var slides;
var currentSlideshowId;
var interval;
var anchor;

function LoadData() {
    //cross browser object for XMLHttpRequest
    LoadSlides();

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

    Start();
}

function Start() {
    if (slides != null) {
        currentSlideshowId = slides.children[0].children[0].innerHTML;
        document.getElementById('slideshowimg').src = slides.children[0].children[1].innerHTML;
        document.getElementById('description').innerHTML = slides.children[0].children[2].innerHTML;
    }
}

function LoadSlides() {
    var xmlHttpRequest = new XMLHttpRequest();
    xmlHttpRequest.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
            var xml = this.responseXML;
            slides = xml.documentElement;
        }
    };
    xmlHttpRequest.open("GET", "../SlideshowClientData.xml", false);
    xmlHttpRequest.send();
}


function ShowPreviousImage() {
    if (slides != null) {
        //Getting Previous image from data xml.
        for (var i = 0; i < slides.children.length; i++) {
            var element = slides.children[i];
            if (element.children[0] != null && element.children[0].innerHTML == currentSlideshowId) {
                target = element.previousElementSibling;
                if (target != null) {
                    document.getElementById('slideshowimg').src = target.children[1].innerHTML;
                    document.getElementById('description').innerHTML = target.children[2].innerHTML;
                    currentSlideshowId = target.children[0].innerHTML;
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
    pointer.innerHTML = "[ || ]";
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
                    document.getElementById('slideshowimg').src = target.children[1].innerHTML;
                    document.getElementById('description').innerHTML = target.children[2].innerHTML;
                    currentSlideshowId = target.children[0].innerHTML;
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