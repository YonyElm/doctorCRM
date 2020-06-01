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
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>{this.props.name}</th> {/*Prop given by App() function*/}
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
        <TableCRM name="Table for CRM" />
    )
}


// Use the ReactDOM.render to show your component on the browser
ReactDOM.render(App(), rootElement)