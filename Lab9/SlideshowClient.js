var slides;
var currentSlideshowId;
var interval;
var anchor;

function LoadData() {
    LoadSlides();
    Start();

    document.getElementById('fileid').addEventListener('change', submitForm);
    function submitForm() {
        const form = document.getElementById('form1');
        const XHR = new XMLHttpRequest();
        const FD = new FormData( form );
        XHR.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
                LoadSlides();
            }
        };
        XHR.open( "POST", "gallery.php", false);
        XHR.send( FD );
    }
}

function Start() {
    if (slides != null) {
        CurrentSlide(slides.children[0]);
    }
}

function CurrentSlide(element) {
    currentSlideshowId = element.children[0].innerHTML;
    document.getElementById('slideshowimg').src = element.children[1].innerHTML;
    document.getElementById('description').innerHTML = element.children[2].innerHTML;
}

function LoadSlides() {
    var xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
            var xml = this.responseXML;
            console.log(xml);
            slides = xml.documentElement;
        }
    };
    xmlHttpRequest.open("GET", "../SlideshowClientData.xml", false);
    xmlHttpRequest.setRequestHeader("Cache-Control", "no-cache, no-store, max-age=0");
    xmlHttpRequest.send();
}


function ShowPreviousImage() {
    if (slides != null) {
        for (var i = 0; i < slides.children.length; i++) {
            var element = slides.children[i];
            if (element.children[0] != null && element.children[0].innerHTML == currentSlideshowId) {
                target = element.previousElementSibling;
                if (target != null) {
                    CurrentSlide(target);
                    break;
                }
            }
        }
    }
}

function StartSlideshow(pointer) {
    Start();
    anchor = pointer;
    interval = setInterval("ShowNextImage()", 1000);
    pointer.title = "Stop";
    pointer.onclick = new Function("StopSlideshow(this)");
    pointer.innerHTML = "[ II ]";
}

function StopSlideshow(pointer) {
    if (interval != null) {
        clearInterval(interval);
        interval = null;
        pointer.title = "Start";
        pointer.onclick = new Function("StartSlideshow(this)"); ;
        pointer.innerHTML = "[ > ]";
    }
}

function ShowNextImage() {
    if (slides != null) {
        var flag = false;
        //Getting Previous image from data xml.
        for (var i = 0; i < slides.children.length; i++) {
            var element = slides.children[i];
            if (element.children[0] != null && element.children[0].innerHTML == currentSlideshowId) {
                target = element.nextElementSibling;
                if (target != null) {
                    CurrentSlide(target);
                    flag = true;
                    break;
                }
            }
        }

        if (!flag && interval != null && anchor != null) {
            StopSlideshow(anchor);
        }
    }
}

function DeleteImage() {
    var req = new XMLHttpRequest();
    req.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
            LoadSlides();
        }
    };
    req.open("GET", "gallery.php?delId=" + currentSlideshowId, false);
    req.send();
    
    Start();
}

function AddNewImage() {
    document.getElementById('fileid').click();
    LoadSlides();
}