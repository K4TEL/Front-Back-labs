var username;

function writeWish() {
    while (username == undefined) {
        firstPray();
    }
    let prays = document.querySelector("#prays ul");
    let wish = document.querySelector("#wish");

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
}

function load() {
    let menu = new Navigator(document.querySelector(".nav"));
    if (location.href != "index.html") return;

    praysDecor();

    window.onsubmit = function() {return false;}

    let look = document.getElementById('look');

    look.addEventListener("click", color);

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