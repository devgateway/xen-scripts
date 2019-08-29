#!/usr/bin/awk -f
BEGIN {
  FS="(^ *)|( [(][ [:upper:]]+[)]: )";
  OFS="\t";
  split(fields, field_names, ",");
}

{
  for (key in field_names) {
    if ($2 == field_names[key]) {
      current_object[field_names[key]] = $3;
    }
  }
}

END {
  for (key in field_names) {
    if (key > 1) {
      output_line = output_line OFS;
    }
    output_line = output_line current_object[field_names[key]];
  }
  print output_line
}
