var username;
var menu;
var fund = {
    sum: 1337,
    donats: new Map([
        [new Date(2021,9,21,4,20,0), {
            user: "test",
            wish: "Щоб мама жила вічно!",
            sum: 1337
        }],
        [new Date(2021,9,21,4,21,0), {
            user: "test",
            wish: "Слава Україні!",
            sum: 0
        }]
    ])
}

function writeWish() {
    while (username == undefined) {
        firstPray();
    }

    let prays = document.querySelector("#prays");
    let wish = document.querySelector("#wish");
    let donation = document.querySelector("#custom-handle");

    let sum = Number(donation.innerHTML);

    if (!wish.value.trim().length && sum <= 0) {
        alert("You wished nothing, welcome to nirvana");
        return false;
    }

    let now = new Date();

    fund.sum += sum;
    fund.donats.set(now, {user: username, wish: wish.value, sum: sum});   
    
    prays.prepend(postWish(now, fund.donats.get(now)));
    document.querySelector("#donated").innerHTML = "Donated: " + fund.sum + "$";
    $( "#prays" ).accordion( "refresh" );
    $( "#prays" ).accordion({active: 0});
}

let firstPray = () => 
    username = prompt("Please introduce yourself, how should we call you?", "anon");

let goWiki = (link) => {
    if (confirm("Open wiki page?")) location.href = link;
}

let praysDecor = () => {
    document.querySelector("#donated").innerHTML = "Donated: " + fund.sum + "$";

    let prays = document.querySelector("#prays");
    for (const [date, donat] of fund.donats.entries()) {
        prays.prepend(postWish(date, donat));
    }

    $('#prays').accordion({
        heightStyle: 'content',
        header: '> .accordion-item > .accordion-header'
    });
}

function postWish(date, donat) {
        let wish = document.createElement("li");
        wish.className = "accordion-item";

        let head = document.createElement("div");
        head.className = "accordion-header";
        let wishText = document.createElement("p");
        wishText.innerHTML = donat.wish;
        if (donat.sum > 0)
            wishText.insertAdjacentHTML("beforeend", `<span>${donat.sum}$</span>`);
        head.appendChild(wishText);
        wish.appendChild(head);

        let body = document.createElement("div");
        let dateTime = document.createElement("p");
        dateTime.innerHTML = date.toLocaleDateString() + " " + 
            date.toLocaleTimeString().slice(0, -3);
        let author = document.createElement("p");
        author.innerHTML = "by " + donat.user;
        body.appendChild(dateTime);
        body.appendChild(author);
        wish.appendChild(body);

        return wish;
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
    let socials = document.querySelectorAll("div#social a");
    for (let a of socials) {
        a.style.color = img.dataset.palette;
        a.style.borderColor = img.dataset.palette;
    }
}

function nav() {
    menu = menu == undefined ? new Navigator(document.querySelector(".nav")) : menu;
}

function load() {
    nav();

    praysDecor();

    $(function(){
	    var handle = $("#custom-handle");
	    $("#slider").slider({
            range: "min",
            min: 0,
		    max: 100,
		    value: 42,
		    create: function() {
			    handle.text($(this).slider("value"));
		    },
		    slide: function(event, ui) {
			    handle.text( ui.value );
		    }
	    });
    });



    window.onsubmit = function() {return false;}

    let look = document.getElementById('look');
    look.addEventListener("click", color);
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
        gallery() {
            location.href = "gallery.html";
        }
        onClick(event) {
            let action = event.target.dataset.action;
            if (action) {
                this[action]();
        }
    };
}
