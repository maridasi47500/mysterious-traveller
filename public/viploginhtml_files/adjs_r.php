;(function(c) {
    if ((typeof window.adxcore !== 'undefined' && window.adxcore.version === 2) || document.querySelector('script[src*="adxcore.com/a/init"]')!==null) {
        if(window.advstLibGlobal && window.advstLibGlobal.debug) {
            console.log('%c Adxcore: ', "color: white; background-color: #6c5aee;border-radius:5px;padding: 2px;font-weight:bold;", "disable adjs_r");
        }
        return;
    }

    var tgads = document.createElement('script');
    tgads.async = true;
    tgads.src = 'https://ad.adxcore.com/a/init/?site=22625';
    document.getElementsByTagName('head')[0].appendChild(tgads);
    var ins = document.querySelector('ins[data-zone="' + c.originalZone + '"][class*="byadthink"]:not([id])');
    if (ins) {ins.setAttribute('data-zone', c.zoneid);}

    window.advstAdjsR = window.advstAdjsR || [];window.advstAdjsR.push(c);
    var s='script',d=document,i='adxcore-init',a=d.getElementById(i),f=d.getElementsByTagName(s)[0],j=d.createElement(s);
    if (a!==null) {return;}



})({"zoneid":235630,"originalZone":235630,"advstParam":{"zoneid":235630,"originalZone":235630,"zonename":"728x90_atf","width":728,"height":90,"k":null,"k2":null,"uri.authority":"dispatcher.adxcore.com","uri.log.authority":"l.adxcore.com","site":22625,"tagdata":0,"deviceid":null,"dnt":null,"latitude":null,"longitude":null,"bundle":null,"sticky":0,"stickyLimit":null,"stickyTopOffset":0,"inImage":{"selector":null,"width":0},"parallax":0,"bidders":[],"refresh":1,"refreshInterval":15000,"bidFloor":0,"formatId":12,"debug":0,"jsonGam":{},"capping":{"block":0,"cap":{"nb":0,"period":0}},"zoneFormatParams":[],"ad3.browser.name":"ch","ad3.browser.version":90,"ad3.os":"nix","bannerid":null,"mastertag":"","cookieSyncUri":[]},"isAsync":1,"linkAdvstlib":"https:\/\/ad.adxcore.com\/static\/js\/components\/advstlib\/advstlib.min.js","hostname":"ad.adxcore.com","mtags":"[]","mtagsId":"advst-ins-mastertags-22625","networkLink":10,"site":22625,"getBidders":"https:\/\/d.adxcore.com\/a\/hb\/bidder.php?zoneid=235630&addGeo=1&siteid=22625","cmpUrl":"https:\/\/ad.adxcore.com\/cmp\/?mode=footer&display=none","cmpOpt":{"source":"none","mode":"footer"},"zonesAutoappend":[],"zoneLiee":0,"selector":"ins[data-zone=\"235630\"][class*=\"byadthink\"]:not([data-state])","append":[],"displayDevices":0,"subformats":[{"id":1,"width":468,"height":60},{"id":51,"width":1,"height":51},{"id":52,"width":1,"height":52}],"dynAdunitCode":0,"t9497":true,"publisherCategory":7,"mgam":0,"pubstack_id":"","jsonAdSense":{}});