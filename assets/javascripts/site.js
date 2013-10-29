//Common js

//load sharing js sdks & ga
(function(doc, script) {
  var add, fjs, js;
  js = void 0;
  fjs = doc.getElementsByTagName(script)[0];
  add = function(url, id) {
    if (doc.getElementById(id)) {
      return;
    }
    js = doc.createElement(script);
    js.src = url;
    id && (js.id = id);
    return fjs.parentNode.insertBefore(js, fjs);
  };
  return add(("https:" === location.protocol ? "//ssl" : "//www") + ".google-analytics.com/ga.js", "ga");
  //add("https://apis.google.com/js/plusone.js");
  //add("//connect.facebook.net/en_GB/all.js#xfbml=1", "facebook-jssdk");
  //return add("//platform.twitter.com/widgets.js", "twitter-wjs");
})(document, "script");