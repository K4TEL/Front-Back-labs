function gallery() {
    Fancybox.bind("[data-fancybox='single']", {
        groupAttr: false
      });

      const imageCarousel = new Carousel(document.querySelector(".carousel"), {
        infinite: false,
        Navigation: false
      });

      const videoCarousel = new Carousel(document.querySelector(".carouselVideo"), {
        infinite: false,
        Navigation: false
      });
}

function inform() {
  $("#clock").clock({
    width: 300,
    height: 450,
    // 't1' 't2' 't3'
    theme: 't2', 
    date: new Date()
    })
}