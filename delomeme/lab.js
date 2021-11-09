function labTest() {
    alert(document.head.outerHTML);
    let nav = document.querySelector("div.nav");
    nav.outerHTML = '<div class="nav"><a id="mainlink" href="index.html"><b>Main page</b></a>    <br><a href="origin.html">Origins</a>    <br>    <a href="cult.html">Cult</a>    <br>    <a href="symbol.html">Symbolics</a>    <br>    <a id="author" href="javascript:showAuthor(`Kate`,`Lutsai`)">Author</a><br>    <a href="javascript:labTest()">Test</a>    <br>   </div>';
    alert(nav.textContent);
    let wish = document.querySelector("#prays").lastElementChild;
    let test = document.createTextNode("REPLACE TEST");
    wish.after("===AFTER TEST====")
    wish.replaceWith(test);
    wish.append("testing");
}

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
    line.dataset.author = " by " + username;

    praysDecor();
    
    prays.prepend(line);
}

let firstPray = () => 
    username = prompt("Please introduce yourself, how should we call you?", "anon");

let showAuthor = (name, last, pos="Student") =>
    alert(`Made by ${name} ${last} - ${pos}`);

function longerWish(wish, prev) {
    let longer = wish.length > prev.length ? wish : prev;
    alert(longer + " is longer");
}

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

function bgColor(color) {
    document.body.style.backgroundColor = color;
}

function color() {
    let img = document.getElementById('look');
    if (img.getAttribute("src") === "images/delomemat.png") {
        img.src = "images/bw.png";
        img.dataset.palette = "white";
    } else {
        img.src = "images/delomemat.png";
        img.dataset.palette = "#F3B71A";
    }

    let navigs = document.querySelectorAll("div.nav a");
    for (let a of navigs) {
        a.style.color = img.dataset.palette;
    }
    
    bgColor("#104200");
    setTimeout(bgColor, 30000, "black");
    img.removeEventListener("click", coord)
}

var coord;
var menu;

function nav() {
    menu = menu == undefined ? new Navigator(document.querySelector(".nav")) : menu;
}

function load() {
    nav();

    praysDecor();

    window.onsubmit = function() {return false;}

    coord = new Handler();

    let look = document.getElementById('look');

    look.addEventListener("click", coord);
    look.addEventListener("click", color);

    document.querySelector("#prays ul").addEventListener("click", light);

    document.addEventListener("click", function(event) {
        let author = event.target.dataset.author;

        if (!author) 
            return;
        
        if (event.target.parentElement.firstElementChild == event.target) 
            return;
        
        if (event.target.lastElementChild == null)  
            event.target.insertAdjacentHTML("beforeend", `<span>${author}</span>`)
        
    });
}

function light(event) {
    let list = event.target.parentElement;
    list.style.color = list.style.color == "white" ? "#FDF399" : "white";
}

class Handler {
    handleEvent(event) {
        alert(event.type + " на " + event.currentTarget + " Координаты: " + event.clientX + ":" + event.clientY);
    }
}

class Navigator {
    constructor(elem) {
        this._elem = elem;
        elem.onclick = this.onClick.bind(this); 
        }
        main() {
            location.href = "index.html";
        }
        origins() {
            location.href = "origin.html";
        }
        cult() {
            location.href = "cult.html";
        }
        symbol() {
            location.href = "symbol.html";
        }
        onClick(event) {
            let action = event.target.dataset.action;
            if (action) {
                this[action]();
        }
    };
}


