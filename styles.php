<?php
    /*** set the content type header ***/
    /*** Without this header, it wont work ***/
    header("Content-type: text/css");
?>

html {
    text-align: center;
}

h1, h2 {
    padding: 20px;
}

<!-- Sortable table design -->
th {
  cursor: pointer;
}

.table-sortable .th-sort-asc::after {
  content: "\25b4";
}

.table-sortable .th-sort-desc::after {
  content: "\25be";
}

.table-sortable .th-sort-asc::after,
.table-sortable .th-sort-desc::after {
  margin-left: 5px;
}

.table-sortable .th-sort-asc,
.table-sortable .th-sort-desc {
  background: rgba(0, 0, 0, 0.1);
}
