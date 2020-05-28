// Obtain the root 
const rootElement = document.getElementById('root')

// Create a ES6 class component
class TableCRM extends React.Component {
// Use the render function to return JSX component      
    render() {
        
        var records = [];
        for (var i = 0; i < content.tracking_chart.length; i++) {
            records.push(   <tr><td>{content.tracking_chart[i].patient.name}</td>
                            <td>{content.tracking_chart[i].patient.surname}</td>
                            <td>{content.tracking_chart[i].patient.name}</td>
                            <td>{content.tracking_chart[i].test.name}</td>
                            <td>{content.tracking_chart[i].due_date}</td>
                            <td>{content.tracking_chart[i].alert_code}</td></tr>);
        }

        return (
            <table>
                <tr>
                    <h3>{this.props.name}</h3>
                </tr>
                <tr>
                    <td>Name</td>
                    <td>Surname</td>
                    <td>ID Number</td>
                    <td>Test Name</td>
                    <td>Due Date</td>
                    <td>Alert</td>
                </tr>
                    {records}
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