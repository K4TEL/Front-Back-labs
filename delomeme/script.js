var username;

function writeWish() {
    while (username == undefined) {
        firstPray();
    }
    let prays = document.querySelector("#prays ul");
    let wish = document.querySelector("#wish");

    longerWish(wish.value, prays.firstElementChild.innerHTML);

    if (!wish.value.trim().length) {
        alert("You wished nothing, welcome to nirvana");
        return false;
    }
    
    let line = document.createElement("li");
    line.innerHTML = wish.value;

    praysDecor();
    
    prays.prepend(line);
    prays.firstElementChild.setAttribute("data-content", ` - ${username}`);
}

let firstPray = () => 
    username = prompt("Please introduce yourself, how should we call you?", "anon");

let goWiki = (link) => {
    if (confirm("Open wiki page?")) location.href = link;
}

let praysDecor = () => {
    let wishes = document.querySelectorAll("#prays li");
    let font = 1;
    for (let p of wishes) {
        if (font > 0.05) {
            p.setAttribute("style", "font-size: " + font + "em");
            font -= 0.05;
        } else {
            p.remove();
        }
    }
}

function color() {
    let img = document.getElementById('look');
    img.src = (img.getAttribute("src") === "images/delomemat.png") ? 
    "images/bw.png" : "images/delomemat.png";
}
