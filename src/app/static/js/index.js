// Obtain the root 
const rootElement = document.getElementById('root')

// Create a ES6 class component
class MyTag extends React.Component {
// Use the render function to return JSX component      
    render() {
        return (
            <div>
                <h1>List for {this.props.name}</h1>
                <ul>
                    <li>Niddle</li>
                    <li>Banded</li>
                </ul>
            </div>
        );
    }
}

// Create a function to wrap up your component
function App(){
    return(
        <MyTag name="Doctor"/>
    )
}


// Use the ReactDOM.render to show your component on the browser
ReactDOM.render(App(), rootElement)