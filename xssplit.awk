#!/usr/bin/awk -f
function flush() {
  if (!need_flush) return;

  output_line = "";

  indexes[1] = 1;
  asorti(fields, indexes);

  for (n in indexes) {
    separator = (n > 1) ? OFS : "";
    output_line = output_line separator fields[indexes[n]];
  }

  print output_line;
  need_flush = 0;
}

BEGIN {
  FS=" +[(][ [:upper:]]+[)]( *): ";
  OFS="\t";
  need_flush = 0;
  gibibyte = 1024 ^ 3;
}

{
  if (NF == 0) {
    flush();
  } else {
    gsub(" +", "", $1);
    fields[$1] = $2
    need_flush = 1;
  }
}

END {
  flush();
}
