function writeWish() {
    let prays = document.querySelector("#prays");

    let line = document.createElement("p");
    line.innerHTML = document.querySelector("#wish").value;

    prays.insertBefore(line, prays.firstChild);
}