
if (typeof(doctorName) == "undefined"){
    var doctorName = "No"
}

let p = document.createElement("p");
let text = document.createTextNode("Doctor name JS: " + doctorName);
p.appendChild(text)

let div1 = document.getElementById("div1");
if (div1 != null)
    div1.appendChild(p);