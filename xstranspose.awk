#!/usr/bin/awk -f
function flush() {
  if (!need_flush) return;

  output_line = "";

  for (i in indexes) {
    separator = (i > 1) ? OFS : "";
    output_line = output_line separator current_object[indexes[i]];
  }

  print output_line;
  need_flush = 0;
}

BEGIN {
  FS=" +[(][ [:upper:]]+[)]( *): ";
  OFS="\t";
  need_flush = 0;
  split(fields, indexes, ",");
}

{
  if (NF == 0) {
    flush();
  } else {
    gsub(" +", "", $1);
    current_object[$1] = (unit && typeof($2) != "string") ? int($2 / unit) : $2;
    need_flush = 1;
  }
}

END {
  flush();
}
