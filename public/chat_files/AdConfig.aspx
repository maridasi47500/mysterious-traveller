
(function (w, undefined) {
    var d = w.document;

    w.ImmAds = {
        Opt     : {},
        Default: {
            Params: "",
            AdUrl : "//adv.123multimedia.com/AdDisplay.aspx",

            Page   : "/",
            Domain : "chat.trace.tv",
            Country: "it",
            
            Width : 0,
            Height: 0,
        
            Age : 0,
            Sex : 1,
            Type: 2
        },

        Init: function (opt) {
            ImmAds.Opt = {};
            
            // Function called before each ad is displayed, and overrides default options (if present)
            ImmAds.Opt.Country = (opt.Country !== undefined) ? opt.Country : ImmAds.Default.Country;
            ImmAds.Opt.Domain  = (opt.Domain  !== undefined) ? opt.Domain  : ImmAds.Default.Domain;
            ImmAds.Opt.Page    = (opt.Page    !== undefined) ? opt.Page    : ImmAds.Default.Page;
            ImmAds.Opt.Params  = (opt.Params  !== undefined) ? opt.Params  : ImmAds.Default.Params;

            ImmAds.Opt.Width  = ((opt.Width  !== undefined) && (opt.Width  > 0)) ? opt.Width  : ImmAds.Default.Width;
            ImmAds.Opt.Height = ((opt.Height !== undefined) && (opt.Height > 0)) ? opt.Height : ImmAds.Default.Height;

            ImmAds.Opt.Age  = ((opt.Age  !== undefined) && (opt.Age  > 0)) ? opt.Age : ImmAds.Default.Age;
            ImmAds.Opt.Sex  = ((opt.Sex  !== undefined) && (opt.Sex  > 0 && opt.Sex  < 3)) ? opt.Sex  : ImmAds.Default.Sex;
            ImmAds.Opt.Type = ((opt.Type !== undefined) && (opt.Type > 0 && opt.Type < 3)) ? opt.Type : ImmAds.Default.Type;           
        },

        // START: ADSENSE CONFIGURATION ASYNC SCRIPT
        GoogleAdServer: function (ad) {
            w.google_page_url = "/";

            if (ImmAds.Opt.Height == 10 && ImmAds.Opt.Width == 10) {
                d.write('<scr' + 'ipt src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></scr' + 'ipt>');
                d.write('<ins class="adsbygoogle" style="display:block" data-ad-format="fluid" data-ad-layout-key="-6t+ed+2i-1n-4w" data-ad-client="' + ad.ClientId + '" data-ad-slot="' + ad.AdSlot + '"></ins>')
                d.write('<scr' + 'ipt>(adsbygoogle = window.adsbygoogle || []).push({});</scr' + 'ipt>');
            }
            else {
                d.write('<scr' + 'ipt src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></scr' + 'ipt>');
                d.write('<ins class="adsbygoogle" style="display:inline-block;width:' + ImmAds.Opt.Width + 'px;height:' + ImmAds.Opt.Height + 'px" data-ad-client="' + ad.ClientId + '" data-ad-slot="' + ad.AdSlot + '" data-override-format="true" data-page-url = "' + w.google_page_url + '"></ins>')
                d.write('<scr' + 'ipt>(adsbygoogle = window.adsbygoogle || []).push({});</scr' + 'ipt>');
            }
        },
     
        // START: ADTHINK CONFIGURATION
        AdThink: function (ad) {
            d.write('<ins data-zone="' + ad.ZoneId + '" class="byadthink"></ins>');
            d.write('<scr' + 'ipt async src="//ad.adxcore.com/adjs_r.php?inf=no&what=zone:' + ad.ZoneId + '&async"></scr' + 'ipt>');
        },

        // START: PRELINKER
        Prelinker: function (ad) {
            d.write('<scr' + 'ipt type="text/javascript" src="//c.free-datings.com/tchatche?site_id=1188704&tr4ck=XXXXXXXtpls=10&v=sexy"></scr' + 'ipt>');
        },

        // START: Playtem
        Playtem: function (ad) {
           d.write('<scr' + 'ipt type="text/javascript" id="ptm' + ad.PlayTemId + '">(function(p,l,a,y,t,e,m){m=window.inDapIF?window.parent:window;e=m.playtem=m.playtem||[];e.push(p);t=m.document.createElement("script");t.async=!0; t.src="//sdk.playtem.com/mediation/native.js?t="+((new Date()).getTime()/36e5).toFixed();m.document.getElementsByTagName("head")[0].appendChild(t); })("' + ad.PlayTemId + '");</scr' + 'ipt>');
        },

        // START: SmileWanted
        SmileWanted: function (ad) {
            d.write('<scr' + 'ipt type="text/javascript" src="//tags.smilewanted.com/formats/corner-video/' + ad.SmileWantedId + '"></scr' + 'ipt>');
        },

		// START: NextMillennium
        NextMillennium: function (ad) {
            d.write('<div class="nmm-ad-wrapper"><scr' + 'ipt async src="//powerad.ai/hbdirect/' + ad.NextMillenniumId + '"></scr' + 'ipt></div>');
        },

        // START: Adnimation
        Adnimation: function (ad) {
            d.write('<scr' + 'ipt data-ad-client="ca-pub-7528949385909099" async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></scr' + 'ipt>');
	        d.write('<scr' + 'ipt async="async" src="//securepubads.g.doubleclick.net/tag/js/gpt.js" type="text/javascript"></scr' + 'ipt>');
	        d.write('<scr' + 'ipt>src="//securepubads.g.doubleclick.net/tag/js/gpt.js" type="text/javascript"</scr' + 'ipt>');
	        d.write('<scr' + 'ipt async="async" src="//adncdnend.azureedge.net/adtags/' + ad.AdnimationId.split("/")[0].toLowerCase() + '.adn.js" type="text/javascript"></scr' + 'ipt>');
	        d.write('<div data-onpage=true data-adpath="/339474670,1011187/' + ad.AdnimationId + '"></div>');
        },

        // START: OKO
        Oko: function (ad) {
            d.write('<scr' + 'ipt async src="//securepubads.g.doubleclick.net/tag/js/gpt.js"></scr' + 'ipt>');
            d.write('<scr' + 'ipt async src="//df80k0z3fi8zg.cloudfront.net/files/instibid/57affebb-f346-40b1-aab3-049946d208e3.js"></scr' + 'ipt>');
            d.write('<scr' + 'ipt data-cfasync="false" type="text/javascript">(function (a, c, s, u){"Insticator"in a || (a.Insticator={ad:{loadAd: function (b){Insticator.ad.q.push(b)}, q: []}, helper:{}, embed:{}, version: "4.0", q: [], load: function (t, o){Insticator.q.push({t: t, o: o})}}); var b=c.createElement(s); b.src=u; b.async=!0; var d=c.getElementsByTagName(s)[0]; d.parentNode.insertBefore(b, d)})(window, document, "script", "//d2f0uviei09pxb.cloudfront.net/ads-code/57affebb-f346-40b1-aab3-049946d208e3.js")</scr' + 'ipt>');
            d.write('<div id="div-insticator-' + ad.OkoId + '"><script data-cfasync="false" type="text/javascript">Insticator.ad.loadAd("div-insticator-' + ad.OkoId + '");</script></div>');
        },

        // START: BuySellAds
        BuySellAds: function (ad) {
            d.write('<scr' + 'ipt>(function () {var bsa_optimize = document.createElement("script");bsa_optimize.type = "text/javascript";bsa_optimize.async = true;bsa_optimize.src = "https://cdn4.buysellads.net/pub/tchatche.js?" + (new Date() - new Date() % 600000);(document.getElementsByTagName("head")[0] || document.getElementsByTagName("body")[0]).appendChild(bsa_optimize);})();</scr' + 'ipt>');
            d.write('<div id="' + ad.BuySellAdsId + '" style="min-width: ' + ImmAds.Opt.Width + 'px; min-height: ' + ImmAds.Opt.Height + 'px;"></div>');
        },

        // START: Clickio
        Clickio: function (ad) {
            d.write('<scr' + 'ipt async src="//s.clickiocdn.com/t/225745/360_light.js"></scr' + 'ipt>');
            d.write('<scr' + 'ipt class="__lxGc__">');
            d.write('((__lxGc__=window.__lxGc__||{"s":{},"b":0})["s"]["_225745"]=__lxGc__["s"]["_225745"]||{"b":{}})["b"]["_' + ad.ClickioId + '"]={"i":__lxGc__.b++};');
            d.write('</script>');
        }
    };
})(window);

// Fractured for readability 
function ShowAdvertising (opt) {
    // Initialize Options
    ImmAds.Init(opt);
  
    // Write Ad
    var url = ImmAds.Default.AdUrl
                .concat("?Domain="     , ImmAds.Opt.Domain)                
                .concat("&amp;Page="   , ImmAds.Opt.Page)
                .concat("&amp;Country=", ImmAds.Opt.Country)
                
                .concat("&amp;Width=" , ImmAds.Opt.Width)
                .concat("&amp;Height=", ImmAds.Opt.Height)
                                                
                .concat("&amp;Age=" , ImmAds.Opt.Age)
                .concat("&amp;Sex=" , ImmAds.Opt.Sex)
                .concat("&amp;Type=", ImmAds.Opt.Type);

    document.write('<scr' + 'ipt src="' + url + '"></scr' + 'ipt>');
};

function ShowAdvertisingInfo (opt) {
    // Initialize Options
    ImmAds.Init(opt);
    var adDisplayInfoUrl ='//adv.123multimedia.com/AdDisplayInfo.aspx';
    // Write Ad Info
    var url = adDisplayInfoUrl
                .concat("?Domain="     , ImmAds.Opt.Domain)                
                .concat("&amp;Page="   , ImmAds.Opt.Page)
                .concat("&amp;Country=", ImmAds.Opt.Country)
                
                .concat("&amp;Width=" , ImmAds.Opt.Width)
                .concat("&amp;Height=", ImmAds.Opt.Height)
                                                
                .concat("&amp;Age=" , ImmAds.Opt.Age)
                .concat("&amp;Sex=" , ImmAds.Opt.Sex)
                .concat("&amp;Type=", ImmAds.Opt.Type);

    document.write('<scr' + 'ipt src="' + url + '"></scr' + 'ipt>');
};
