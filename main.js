function convert_to_buttons(table_name, column_indices, new_page_names) {
    // Obtain table rows
    tab = document.getElementById(table_name)
    tab_rows = tab.getElementsByTagName("tr")

    // Iterate through each row in the table
    for (var i=1; i < tab_rows.length; i++) {
    
        // Get the table data within each row
        var tab_data = tab_rows[i].getElementsByTagName("td");
        console.log(tab_data)
    
        // Iterate through columns of interest
        for (var j = 0; j < column_indices.length; j++) {

            // replace the first data item with a button that calls a function to display certain rows in the product table
            var data_name = tab_data[column_indices[j]].innerHTML
            tab_data[column_indices[j]].innerHTML = "<td><form method=\"get\" action=\'" + new_page_names[j] + "\'><input type=\"submit\" name=\"submit\" value=\"" + data_name + "\" class=\"btn btn-link\"></form></td>";

        }
    }
}