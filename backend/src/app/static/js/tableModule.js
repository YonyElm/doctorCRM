// Obtain the root 
const rootElement = document.getElementById('root')

// Create a ES6 class component
class TableCRM extends React.Component {
// Use the render function to return JSX component      
    render() {
        
        var records = [];
        for (var i = 0; i < content.length; i++) {
            records.push(   <tr>
                                <td>{i}</td>
                                <td>{content[i].patient.name}</td>
                                <td>{content[i].patient.surname}</td>
                                <td>{content[i].patient.id_num}</td>
                                <td>{content[i].test.name}</td>
                                <td>{content[i].due_date}</td>
                                <td>{content[i].alert_code}</td>
                            </tr>);
        }

        return (
            <table id={this.props.name} class="table table-striped"> {/*Prop given by App() function*/}
                <thead>
                    <tr>
                        <th>#</th> 
                        <th>Name</th>
                        <th>Surname</th>
                        <th>ID Number</th>
                        <th>Test Name</th>
                        <th>Due Date</th>
                        <th>Alert</th>
                    </tr>
                </thead>
                <tbody>
                    {records}
                </tbody>
            </table>
        );
    }
}

// Create a function to wrap up your component
function App(){
    return(
        <TableCRM name="recommendations_t" />
    )
}


// Use the ReactDOM.render to show your component on the browser
ReactDOM.render(App(), rootElement)

// Table modifications
$(document).ready(function() {
    $('#recommendations_t').DataTable({
            // Layout: https://datatables.net/reference/option/dom
            dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>" +
            "<'row'<'col-sm-12'tr>>" +
            "<'row'<'col-md-4'i><'col-md-4'B><'col-md-4'p>>",
            // https://datatables.net/extensions/buttons/
            buttons: [
                'excel',
                'print'
            ]
        });
    });