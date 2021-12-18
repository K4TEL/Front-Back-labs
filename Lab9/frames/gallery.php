<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="../../css/frame.css"> 
        <meta name = "author" content = "Луцай">
        <title>Галерея</title>

	<script type="text/javascript" src="../SlideshowClient.js"></script>

	<style type="text/css">
		.slideshowtd
		{
			border: 2px;
			border-color: #fff;
			border-style: solid;
			padding: 5px;
            height: 500px;
		}
		.slideshowcontainer
		{
            width: 100%;
			height: 100%;
		}
        a {
            text-decoration: none;
            font-weight: normal;
            font-style: normal;
            color: #fff;
        }
	</style>
</head>
<body onload="LoadData(); ">
	<form id="form1" runat="server" action="" method="POST" enctype="multipart/form-data">
	<table class="slideshowcontainer">
		<tr>
			<td colspan="3" align="center">
				<img class="slideshowtd" id="slideshowimg" src="../img/lyrics/lyric1.png" alt="Slideshow" />
			</td>
		</tr>
		<tr>
            <td align="right">
				<a title="Delete" onclick="DeleteImage();">
					[ - ]
				</a>
			</td>
			<td align="center">
				<span id="description"></span>
			</td>
            <td align="left">
            <input id='fileid' type='file' name='filename' hidden/>
            <input type='submit' name='submitFile' value='submit' hidden/> 
				<a title="Add New" href="#" onclick="AddNewImage();">
					[ + ]
				</a>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a title="Previous" href="#" onclick="ShowPreviousImage();">
					[ << ]
				</a>
			</td>
			<td align="center" style="width:15%;">
				<a title="Play" href="#" onclick="StartSlideshow(this);">
					[ > ]
				</a>
			</td>
			<td align="left">
				<a title="Next" href="#" onclick="ShowNextImage();">
					[ >> ]
				</a>
			</td>
		</tr>
	</table>
	</form>
	<?php

if(isset($_FILES["filename"]["name"])) {
	$target_dir = "../img/lyrics/";
	$target_file = $target_dir . basename($_FILES["filename"]["name"]);
	$uploadOk = 1;
	$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

	if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
		&& $imageFileType != "gif" ) {
		echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
		$uploadOk = 0;
	}
	if ($_FILES["filename"]["size"] > 500000) {
		echo "Sorry, your file is too large.";
		$uploadOk = 0;
	}
	if (file_exists($target_file)) {
		echo "Sorry, file already exists.";
		$uploadOk = 0;
	}

	if ($uploadOk == 0) {
		echo "Sorry, your file was not uploaded.";
	} else {
		if (move_uploaded_file($_FILES["filename"]["tmp_name"], $target_file)) {
			echo "The file ". htmlspecialchars( basename( $_FILES["filename"]["name"])). " has been uploaded.";
		} else {
			echo "Sorry, there was an error uploading your file.";
		}
	}

	if ($uploadOk == 1) {
		$root = simplexml_load_file('../SlideshowClientData.xml');
		$id = $root->xpath("Slideshow[last()]/SlideshowId")[0];
		$slide = $root->addChild('Slideshow');
		$slide->addChild('SlideshowId', (int)$id+1);
		$slide->addChild('ImagePath', $target_file);
		$slide->addChild('Description', basename( $_FILES["filename"]["name"]));
		
		$root->saveXML("../SlideshowClientData.xml");
		http_response_code(200);
	}
}

if (isset($_GET["delId"])) {
	$id = $_GET["delId"];
	$dom=new DOMDocument();
	$dom->Load("../SlideshowClientData.xml");
	$root=$dom->documentElement;
	$slides = $root->getElementsByTagName('Slideshow');
	foreach ($slides as $slide) {
		if ($slide->getElementsByTagName('SlideshowId')->item(0)->textContent == $id) {
			$file = $slide->getElementsByTagName('ImagePath')->item(0)->textContent;
			unlink($file);
			$slide->parentNode->removeChild($slide);
		}
	}
	$dom->Save("../SlideshowClientData.xml");
}
?>
</body>
</html>