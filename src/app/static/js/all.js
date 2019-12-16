
 /*!
    * WOWJS v1.1.3 (Animation on scrolling)
    * View style.css for the import of animate.css
 */
var wow = new WOW(
  {
    boxClass:     'wow',      // animated element css class (default is wow)
    animateClass: 'animated', // animation css class (default is animated)
    offset:       0,          // distance to the element when triggering the animation (default is 0)
    mobile:       false,       // trigger animations on mobile devices (default is true)
    live:         true,       // act on asynchronously loaded content (default is true)
    callback:     function(box) {
      // the callback is fired every time an animation is started
      // the argument that is passed in is the DOM node being animated
    },
    scrollContainer: null // optional scroll container selector, otherwise use window
  }
);
wow.init();

/*!
    * Smooth Scroll v15.0.0
 */

var scroll = new SmoothScroll('a[href*="#"]', {
    selector: '[data-scroll]', // Selector for links (must be a valid CSS selector)
    selectorHeader: '[data-scroll-header]', // Selector for fixed headers (must be a valid CSS selector)
    speed: 700, // Integer. How fast to complete the scroll in milliseconds
    easing: 'Linear', // Easing pattern to use
    offset: 90, // Integer. How far to offset the scrolling anchor location in pixels
    updateURL: true, // Boolean. If true, update the URL hash on scroll
    callback: function ( anchor, toggle ) {} // Function to run after scrolling
});


/*!
    * PrettyPhoto v3.1.6
 */

jQuery('a[data-gal]').each(function() {
    jQuery(this).attr('rel', jQuery(this).data('gal'));
});
jQuery("a[data-rel^='prettyPhoto']").prettyPhoto({
    animationSpeed: 'slow',
    theme: 'light_square',
    slideshow: true,
    overlay_gallery: true,
    social_tools: false,
    deeplinking: false
});