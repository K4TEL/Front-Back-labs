var xmlDoc;
var currentSlideshowId = 1199;
var interval;
var anchor;

function LoadData() {
    //cross browser object for XMLHttpRequest
    var xmlHttpRequest = (window.XMLHttpRequest) ? new window.XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    xmlHttpRequest.open("GET", "../SlideshowClientData.xml", false);
    xmlHttpRequest.send(null);
    //fetching the responseXML from the request
    xmlDoc = xmlHttpRequest.responseXML;

    // For Cross Browser support.
    ElementProtoType();

    ShowNextImage(null);
}

function ElementProtoType() {
    if (document.implementation.hasFeature("XPath", "3.0")) {
        //Some of the browsers not supporting selectSingleNode
        Element.prototype.selectSingleNode = function(xPath) {
            var evaluator = new XPathEvaluator();
            var result = evaluator.evaluate(xPath, this, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null);
            if (result != null && result.singleNodeValue != null) {
                result.singleNodeValue.nodeTypedValue = result.singleNodeValue.textContent;
                return result.singleNodeValue;
            }
            else {
                return null;
            }
        }
    }
}

function ShowPreviousImage() {
    if (xmlDoc != null) {
        //Getting Previous image from data xml.
        for (var i = 0; i < xmlDoc.documentElement.childNodes.length; i++) {
            var element = xmlDoc.documentElement.childNodes[i];
            if (element.nodeType == 1 && element.selectSingleNode("SlideshowId").nodeTypedValue == currentSlideshowId - 1) {
                document.getElementById('slideshowimg').src = element.selectSingleNode("ImagePath").nodeTypedValue;
                document.getElementById('description').innerHTML = element.selectSingleNode("Description").nodeTypedValue;
                currentSlideshowId = currentSlideshowId - 1;
                break;
            }
        }
    }
}

function StartSlideshow(pointer) {
    currentSlideshowId = 1199;
    anchor = pointer;
    ShowNextImage();
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
    if (xmlDoc != null) {
        var flag = false;
        //Getting Previous image from data xml.
        for (var i = 0; i < xmlDoc.documentElement.childNodes.length; i++) {
            var element = xmlDoc.documentElement.childNodes[i];
            if (element.nodeType == 1 && element.selectSingleNode("SlideshowId") != null &&
                    element.selectSingleNode("SlideshowId").nodeTypedValue == currentSlideshowId + 1) {
                document.getElementById('slideshowimg').src = element.selectSingleNode("ImagePath").nodeTypedValue;
                document.getElementById('description').innerHTML = element.selectSingleNode("Description").nodeTypedValue;
                currentSlideshowId = currentSlideshowId + 1;
                flag = true;
                break;
            }
        }

        if (!flag && interval != null && anchor != null) {
            StopSlideshow(anchor);
        }
    }
}

function DeleteImage() {
    if (xmlDoc != null) {
        var flag = false;
        for (var i = 0; i < xmlDoc.documentElement.childNodes.length; i++) {
            var element = xmlDoc.documentElement.childNodes[i];
            if (flag && element.nodeType == 1 && element.selectSingleNode("SlideshowId") != null) {
                var id = element.firstElementChild;
                id.nodeValue += 1;
            } else {
                if (element.nodeType == 1 && element.selectSingleNode("SlideshowId") != null &&
                        element.selectSingleNode("SlideshowId").nodeTypedValue == currentSlideshowId) {
                    xmlDoc.documentElement.removeChild(element);
                    flag = true;
                }
            }
        }
    }
    ShowNextImage();
}