/**
 * Adds buttons to a HTML table that link to other tables
 * 
 * @param {String} table_name The name of the table to which we will add buttons
 * @param {Array} column_indices An array containing the indices of columns we are adding buttons to
 * @param {Array} new_page_names An array containing the names of pages that buttons in each column will link to
 */

function convert_to_buttons(table_name, column_indices, new_page_names) {
    // Obtain table rows
    const tab = document.getElementById(table_name);
    const tab_body = tab.getElementsByTagName("tbody");
    const tab_rows = tab_body[0].getElementsByTagName("tr");

    // Iterate through each row in the table
    for (var i = 0; i < tab_rows.length; i++) {
    
        // Get the table data within each row
        var tab_data = tab_rows[i].getElementsByTagName("td");
    
        // Iterate through columns of interest
        for (var j = 0; j < column_indices.length; j++) {

            // replace the first data item with a button that calls a function to display certain rows in the product table
            var data_name = tab_data[column_indices[j]].innerHTML;
            tab_data[column_indices[j]].innerHTML = "<td><form method=\"get\" action=\'" + new_page_names[j] + "\'><input type=\"submit\" name=\"submit\" value=\"" + data_name + "\" class=\"btn btn-link\"></form></td>";

        }
    }
}


/**
 * Sorts a HTML table. Reference: https://codepen.io/dcode-software/pen/zYGOrzK
 * 
 * @param {HTMLTableElement} table The table to sort
 * @param {number} column The index of the column to sort
 * @param {boolean} asc Determines if the sorting will be in ascending
 */
 function sortTableByColumn(table, column, asc = true) {
    const dirModifier = asc ? 1 : -1;
    const tBody = table.tBodies[0];
    const rows = Array.from(tBody.querySelectorAll("tr"));

    // Sort each row
    // Sorting by Interview ID
    if (column == 0) {
            sortedRows = rows.sort((a, b) => {
            const aColText = parseInt(a.querySelector(`td:nth-child(${ column + 1 })`).textContent.trim());
            const bColText = parseInt(b.querySelector(`td:nth-child(${ column + 1 })`).textContent.trim());
    
            return aColText > bColText ? (1 * dirModifier) : (-1 * dirModifier);
        })
    }

    // Sorting by Candidate, Department or Position ID
    else if ([1, 2, 3].includes(column)) {
            sortedRows = rows.sort((a, b) => {
            const aColText = parseInt(a.querySelector(`td:nth-child(${ column + 1 })`).querySelector("form").querySelector("input").value);
            const bColText = parseInt(b.querySelector(`td:nth-child(${ column + 1 })`).querySelector("form").querySelector("input").value);
    
            return aColText > bColText ? (1 * dirModifier) : (-1 * dirModifier);
        })
    }
    
    // Sorting by date or result
    else {
            sortedRows = rows.sort((a, b) => {
            const aColText = a.querySelector(`td:nth-child(${ column + 1 })`).textContent.trim();
            const bColText = b.querySelector(`td:nth-child(${ column + 1 })`).textContent.trim();
    
            return aColText > bColText ? (1 * dirModifier) : (-1 * dirModifier);
        })
    }
    
    // Remove all existing TRs from the table
    while (tBody.firstChild) {
        tBody.removeChild(tBody.firstChild);
    }

    // Re-add the newly sorted rows
    tBody.append(...sortedRows);

    // Remember how the column is currently sorted
    table.querySelectorAll("th").forEach(th => th.classList.remove("th-sort-asc", "th-sort-desc"));
    table.querySelector(`th:nth-child(${ column + 1})`).classList.toggle("th-sort-asc", asc);
    table.querySelector(`th:nth-child(${ column + 1})`).classList.toggle("th-sort-desc", !asc);
}

document.querySelectorAll(".table-sortable th").forEach(headerCell => {
    headerCell.addEventListener("click", () => {
        const tableElement = headerCell.closest(".table");
        const headerIndex = Array.prototype.indexOf.call(headerCell.parentElement.children, headerCell);
        const currentIsAscending = headerCell.classList.contains("th-sort-asc");

        sortTableByColumn(tableElement, headerIndex, !currentIsAscending);
    });
});
