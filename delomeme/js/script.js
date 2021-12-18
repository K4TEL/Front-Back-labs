var menu;

function lang() {
    $.getJSON("../json/texts.json", function(texts){
            for (let row of texts) {
        let elem = document.getElementById(row.elementID);
        elem.innerHTML = row.text;
    }
        }).fail(function(){
            console.log("An error has occurred.");
        });
}

function writeWish() {
    let wish = document.querySelector("#wish");
    let donation = document.querySelector("#custom-handle");
    let sum = Number(donation.innerHTML);

    if (!wish.value.trim().length && sum <= 0) {
        alert("You wished nothing, welcome to nirvana");
    }
    // const d = new Date();
    // d.setTime(d.getTime() + (100000));
    // let expires = "expires="+ d.toUTCString();
    // document.cookie = "donation=" + sum + ";" + expires + ";path=/";

    var xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.open("POST", "index.php", false);
    xmlHttpRequest.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
    xmlHttpRequest.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
            console.log(this.responseText);
        }
    };
    xmlHttpRequest.send('text=' + wish.value + '&sum=' + donation.innerHTML);
}

let goWiki = (link) => {
    if (confirm("Open wiki page?")) location.href = link;
}

let praysDecor = () => {
    $('#prays').accordion({
        heightStyle: 'content',
        header: '> .accordion-item > .accordion-header'
    });
}

function color() {
    let img = document.getElementById('look');
    if (img.getAttribute("src") === "../images/delomemat.png") {
        img.src = "../images/bw.png";
        img.dataset.palette = "white";
    } else {
        img.src = "../images/delomemat.png";
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
    lang();
}

function count() {
    $(function(){
        $('.countfect').each(function(){
            var $this=$(this),
            countTo=$this.attr('data-num');
            delayTo=$this.attr('delay');
            if(!delayTo){ delayTo=5000 }
            $({countNum:$this.text()}).animate(
                {countNum:countTo},
                {duration:delayTo,
                    easing:'linear',
                    step:function(){
                        $this.text(
                            Math.floor(this.countNum));
                    }, complete:function(){
                        $this.text(this.countNum);
                            }
                });
        });
    });
}

function load() {
    nav();

    praysDecor();
    count();

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

    let look = document.getElementById('look');
    look.addEventListener("click", color);
}

class Navigator {
    constructor(elem) {
        this._elem = elem;
        elem.onclick = this.onClick.bind(this); 
        }
        main() {
            location.href = "index.php";
        }
        origins() {
            location.href = "origin.php";
        }
        cult() {
            location.href = "cult.php";
        }
        symbol() {
            location.href = "symbol.php";
        }
        contact() {
            location.href = "contact.php";
        }
        onClick(event) {
            let action = event.target.dataset.action;
            if (action) {
                this[action]();
        }
    };
}
