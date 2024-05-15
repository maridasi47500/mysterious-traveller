
(function() {
    var ad  = {};        
    var tmp = [{"Key":"ClientId","Value":"pub-2989800286131558"},{"Key":"AdSlot","Value":"8346540838"}];

    if (typeof(tmp) == 'function') {
        tmp();
        return;
    }
    // Convert name/value array to js object
    for (var i in tmp) {
        ad[tmp[i].Key] = tmp[i].Value;
    }
    // Only Google Adsense has a ClientId
    if (!!ad.ClientId) {
        ImmAds.GoogleAdServer(ad);
    }
    // Only AdThink has a ZoneId
    else if (!!ad.ZoneId) {
        ImmAds.AdThink(ad);
    }
    // Only Prelinker has a Prelinker
    else if (!!ad.Prelinker) {
        ImmAds.Prelinker(ad);
    }
    // Only Playtem has a PlayTemId
    else if (!!ad.PlayTemId) {
	    ImmAds.Playtem(ad);
    }
    // Only SmileWanted has a SmileWantedId
    else if (!!ad.SmileWantedId) {
	    ImmAds.SmileWanted(ad);
    }
	// Only NextMillennium has a NextMillenniumId
	else if (!!ad.NextMillenniumId) {
		ImmAds.NextMillennium(ad);
	}
    // Only Adnimation has a AdnimationId
    else if (!!ad.AdnimationId) {
        ImmAds.Adnimation(ad);
    }
    // Only OKO has a OkoId
    else if (!!ad.OkoId) {
        ImmAds.Oko(ad);
    }
    // Only BuySellAds has a BuySellAdsId
    else if (!!ad.BuySellAdsId) {
        ImmAds.BuySellAds(ad);
    }
    // Only Clickio has a ClickioId
    else if (!!ad.ClickioId) {
        ImmAds.Clickio(ad);
    }
})();