var facebookConnect;

var APP = {};
APP.server = "http://www.aarhusung.dk/";

APP.dataProvider = "appdataprovider.aspx";
APP.jsonScript = "appjson.aspx";


APP.analytics = {
    ready: false,
    plugin: null,
    key: "UA-38998122-3",
    init: function () {
        var _this = this;
        this.plugin = window.plugins.gaPlugin;
        this.plugin.init(
            function () {
                //console.log("GA ready");
                _this.ready = true;
            },
            function (error) {
                //console.log("GA NOT ready: " + error);
            },
            _this.key,
            10
        );
    },
    exit: function () {
        if ((this.plugin != null) && this.ready) {
            this.plugin.exit(
                function () { },
                function () { }
            );
        }
    },
    trackPage: function (url) {
        //console.log("trackPage called, url: " + url);
        if ((typeof url == "string") && (url != "") && (this.plugin != null) && this.ready) {
            this.plugin.trackPage(
                function () {
                    //console.log("trackPage success, url: " + url);
                },
                function () {
                    //console.log("trackPage failure, url: " + url);
                },
                url
            );
        }
        else {
            //console.log("trackPage: not ready, url: " + url);
        }
    }
};

APP.hasConnection = function () {
    return navigator.onLine;
};

APP.delay = 0;
APP.timeout = 30000;

APP.fixLink = function (s) {
    return s.replace("|", "?");
};


APP.alert = function (options) {
    options.title = (typeof options.title == "string" ? options.title : "Ups!");
    options.message = (typeof options.message == "string" ? options.message : "");
    options.buttonName = (typeof options.buttonName == "string" ? options.buttonName : "OK");
    options.callback = (typeof options.callback == "function" ? options.callback : null);

    if (navigator && navigator.notification && navigator.notification.alert) {
        navigator.notification.alert(options.message, options.callback, options.title, options.buttonName);
    }
    else {
        alert(options.message);
        if (options.callback != null) {
            options.callback();
        }
    }
};

APP.loading = function (b) {
    $("body").toggleClass("ajax-loading", b);
};

APP.isEmail = function (s) {
    var rx = /^[a-z0-9\-_\.]*[a-z0-9\-_]@([a-z0-9\-\.])+\.[a-z]{2,4}$/i;
    return s.match(rx);
};

//Perform Facebook Like action
APP.like = function () {
    var _this = this;

    if (typeof facebookConnect != "undefined") {

        facebookConnect.login({ permissions: ["email", "user_about_me"], appId: "429515883799445" }, function (result) {
            //console.log("FacebookConnect.login:" + JSON.stringify(result));

            // Check for cancellation/error
            if (result.cancelled || result.error) {
                //console.log("FacebookConnect.login:failedWithError:" + result.message);
                return;
            }

            var p = $.mobile.activePage;
            var strLink = p.data("url");
            var strPicture = _this.server + "images/logo.png";
            var strName = p.data("title");
            var strCaption = p.data("caption");
            var strDescription = p.data("description");


            var dialogOptions = {
                link: strLink,
                picture: strPicture,
                name: strName,
                caption: strCaption,
                description: strDescription
            };
            facebookConnect.dialog('feed', dialogOptions, function (response) {
                //console.log("FacebookConnect.dialog:" + JSON.stringify(response));
            });

        });
    }

    return false;
};


APP.getPageElement = function (r, xp) {
    return $.mobile.activePage.find("div:jqmData(role='" + r + "')" + (xp != "" ? " " + xp : "")).get(0);
};


APP.build = {
    title: function (s) {
        if (s && s != "") {
            var objH1 = document.createElement("h1");
            var objSpan = document.createElement("span");
            $(objSpan)
                .text(s)
                .appendTo(objH1);
            return objH1;
        }
        return null;
    },
    topIcons: function (items) {
        if (items) {
            if (items.length > 0) {

                var w = $(window).width();

                var objDivSlider = document.createElement("div");
                $(objDivSlider).attr("id", "slider-code");

                var objDivViewport = document.createElement("div");
                $(objDivViewport)
                    .addClass("viewport")
                    .css("width", w + "px")
                    .appendTo(objDivSlider);

                var objUl = document.createElement("ul");
                $(objUl)
                    .addClass("overview")
                    .appendTo(objDivViewport);

                $.each(items, function (i, n) {
                    var objLi = document.createElement("li");
                    $(objLi)
                        .appendTo(objUl);

                    if (i == 0) {
                        $(objLi).addClass("first-item");
                    }
                    if (i == items.length - 1) {
                        $(objLi).addClass("last-item");
                    }

                    var objSpan = document.createElement("span");
                    $(objSpan)
                       .addClass("slider-item-content")
                       .appendTo(objLi);

                    var objA = document.createElement("a");
                    $(objA)
                        .addClass("item-link")
                        .attr("href", n.url)
                        .appendTo(objSpan);

                    if (n.src != "") {
                        var objSpanImg = document.createElement("span");
                        $(objSpanImg)
                            .addClass("img")
                            .appendTo(objA);

                        var objImg = document.createElement("img");
                        $(objImg)
                            .attr("src", n.src)
                            .appendTo(objSpanImg);
                    }

                    var objSpanText = document.createElement("span");
                    $(objSpanText)
                        .addClass("text")
                        .text(n.title)
                        .appendTo(objA);
                });

                return objDivSlider;
            }
        }
        return null;
    },
    menu: function (items) {
        if (items) {
            if (items.length > 0) {
                var objUl = document.createElement("ul");
                $(objUl).addClass("buttons");

                $.each(items, function (i, n) {
                    var objLi = document.createElement("li");
                    $(objLi)
                        .addClass(n.c)
                        .appendTo(objUl);

                    var href = "#" + n.ntype + "?id=" + n.id;

                    var objA = document.createElement("a");
                    $(objA)
                        .attr("href", href)
                        .css("background-color", "#" + n.theme)
                        .appendTo(objLi);

                    var objSpanTitle = document.createElement("span");
                    $(objSpanTitle)
                        .addClass("title")
                        .text(n.title)
                        .appendTo(objA);

                    var objSpanSub = document.createElement("span");
                    $(objSpanSub)
                        .addClass("sub")
                        .text(n.sub)
                        .appendTo(objA);
                });

                return objUl;
            }
        }
        return null;
    },
    contentText: function (text) {
        if (text && text != "") {
            var objDiv = document.createElement("div");
            $(objDiv)
                .addClass("textContent")
                .html(text);
            return objDiv;
        }
        return null;
    },
    images: function (items) {
        if (items) {
            if (items.length > 0) {
                var objDiv = document.createElement("div");
                $(objDiv).addClass("images");

                var objDivSlider = document.createElement("div");
                $(objDivSlider)
                    .addClass("slider royalSlider rsDefault")
                    .appendTo(objDiv);

                $.each(items, function (i, n) {
                    var objImg = document.createElement("img");
                    $(objImg)
                        .attr("src", n.src)
                        .appendTo(objDivSlider);

                    if (n.href && n.href != "") {
                        $(objImg).attr("data-rsvideo", n.href);
                    }
                });




                return objDiv;
            }
        }
        return null;
    },

    sectionDetailsLogo: function (logo) {
        if (logo && logo != "") {
            var objSpan = document.createElement("span");
            $(objSpan).addClass("logo");

            var objImg = document.createElement("img");
            $(objImg)
                .attr("src", logo)
                .appendTo(objSpan);

            return objSpan;
        }
        return null;
    },

    contactForm: function () {
        var objForm = document.createElement("form");

        var objDivEmail = document.createElement("div");
        $(objDivEmail)
            .addClass("field")
            .appendTo(objForm);

        var objLblEmail = document.createElement("label");
        $(objLblEmail)
            .text("Email:")
            .attr("for", "contact-email")
            .appendTo(objDivEmail);

        var objInpEmail = document.createElement("input");
        $(objInpEmail)
            .attr({
                "type": "text",
                "id": "contact-email",
                "name": "email"
            })
            .appendTo(objDivEmail);


        var objDivMsg = document.createElement("div");
        $(objDivMsg)
            .addClass("field")
            .appendTo(objForm);

        var objTaMsg = document.createElement("textarea");
        $(objTaMsg)
            .attr({
                "name": "message",
                "placeholder": "Skriv din besked her..."
            })
            .appendTo(objDivMsg);

        var objDivSend = document.createElement("div");
        $(objDivSend)
            .addClass("field")
            .appendTo(objForm);

        var objButton = document.createElement("button");
        $(objButton)
            .text("SEND")
            .appendTo(objDivSend);




        $(objForm)
            .submit(function () {
                //Validate content;
                var strEmail = $.trim($(objInpEmail).val());
                var strMsg = $.trim($(objTaMsg).val());

                if (!APP.isEmail(strEmail)) {
                    APP.alert({
                        message: "Du skal angive en gyldig email-adresse"
                    })
                }
                else if (strEmail != "" && strMsg != "") {
                    APP.loading(true);

                    //Do ajax submit
                    window.setTimeout(
                        function () {
                            $.ajax({
                                url: APP.server + APP.jsonScript,
                                data: {
                                    action: "submitcontact",
                                    email: strEmail,
                                    message: strMsg
                                },
                                dataType: "jsonp",
                                timeout: APP.timeout,
                                complete: function () {
                                    APP.loading(false);
                                },
                                success: function (json, status) {
                                    if (json.status && json.status == 1 && json.data && json.data.doneText) {
                                        //Replace contents:
                                        $(objForm).html(json.data.doneText);
                                    }
                                    else {
                                        APP.alert({
                                            message: "Der opstod en fejl ved afsendelse af din besked :-("
                                        });
                                    }
                                },
                                error: function () {
                                    APP.alert({
                                        message: "Der opstod en fejl ved afsendelse af din besked :-("
                                    });

                                }
                            });
                        },
                        APP.delay);
                }
                else {
                    APP.alert({
                        message: "Du skal udfylde både din email-adresse og en besked"
                    });
                }

                return false;
            });

        return objForm;
    },

    contactIcons: function (theme, items) {
        if (items) {
            if (items.length > 0) {
                var objUl = document.createElement("ul");
                $(objUl).addClass("contactButtons");

                switch (items.length) {
                    case 4:
                        $(objUl).addClass("d");
                        break;
                    case 3:
                        $(objUl).addClass("c");
                        break;
                    case 2:
                        $(objUl).addClass("b");
                        break;
                }

                $.each(items, function (i, n) {
                    var objLi = document.createElement("li");
                    $(objLi)
                        .addClass(n.k)
                        //.addClass(c)
                        .appendTo(objUl);

                    var objA = document.createElement("a");
                    var strHref = n.v;
                    switch (n.k) {
                        case "email":
                            strHref = "mailto:" + strHref;
                            break;
                        case "phone":
                            strHref = "tel:" + strHref;
                            break;
                    }
                    $(objA)
                        .attr("href", strHref)
                        .css("background-color", "#" + theme)
                        .appendTo(objLi);

                    var objSpan = document.createElement("span");
                    $(objSpan)
                        .html("&nbsp;")
                        .appendTo(objA);

                });

                return objUl;
            }
        }
        return null;
    },
    aboutVideo: function (src) {
        if (src && src != "") {
            var objDiv = document.createElement("div");
            $(objDiv)
                .addClass("media")
                .data("video", src);

            return objDiv;
        }
        return null;
    },
    aboutPeople: function (items) {
        if (items) {
            if (items.length > 0) {
                var objUl = document.createElement("ul");
                $(objUl).addClass("people");

                $.each(items, function (i, n) {
                    var objLi = document.createElement("li");
                    $(objLi).appendTo(objUl);

                    if (n.img != "") {
                        var objImg = document.createElement("img");
                        $(objImg)
                            .attr("src", n.img)
                            .appendTo(objLi);

                        $(objLi).append(n.text);
                    }
                });

                return objUl;
            }
        }
        return null;
    },

    aboutLogo: function () {
        var objDiv = document.createElement("div");
        $(objDiv).addClass("aboutlogo");

        var objA = document.createElement("a");
        $(objA)
            .attr("href", "http://www.aarhus.dk")
            .appendTo(objDiv);

        var objImg = document.createElement("img");
        $(objImg)
            .attr("src", "images/logo-aarhuskommune.png")
            .appendTo(objA);
        return objDiv;
    },

    footer: function (items) {
        if (items) {
            if (items.length > 0) {
                var objUl = document.createElement("ul");
                $(objUl).addClass("footerLinks");

                $.each(items, function (i, n) {
                    ////FIXME: REMOVE ONCE SERVICE HAS BEEN UPDATED
                    n.href = APP.fixLink(n.href);


                    var objLi = document.createElement("li");
                    $(objLi).appendTo(objUl);

                    //NB: hardcoded to node id of HELP document:
                    if (n.id == 1269) {
                        $(objLi).addClass("help");
                    }

                    var objA = document.createElement("a");
                    $(objA)
                        .attr("href", n.href)
                        .appendTo(objLi);

                    var objSpanTitle = document.createElement("span");
                    $(objSpanTitle)
                        .addClass("title")
                        .text(n.title)
                        .appendTo(objA);

                    var objSpanSub = document.createElement("span");
                    $(objSpanSub)
                        .addClass("sub")
                        .text(n.sub)
                        .appendTo(objA);
                });

                return objUl;

            }
        }
        return null;
    }
};

APP.init = {
    topIcons: function (obj) {
        var objViewport = $(obj).find(".viewport").get(0);
        var objOverview = $(obj).find(".overview").get(0);

        //Calculate total width:
        var w = 0;
        $.each($(objOverview).find("li"), function (i, n) {
            w += $(n).outerWidth(true);
        });
        //No need to set up kinetic behavior if content is narrower than actual viewport:
        if (w > $(window).width()) {
            $(objOverview).css("width", w + "px");
            $(objViewport).kinetic({
                y: false,
                triggerHardware: true
            });
        }
    },
    slider: function (obj) {
        var objSlider = $(obj).find(".slider").get(0);
        if (objSlider) {
            $(objSlider)
                .css({
                    "width": $(window).width() + "px",
                    "height": $(obj).height() + "px"
                })
                .royalSlider({
                    imageScaleMode: 'fill',
                    imageScalePadding: 0,
                    controlNavigation: 'none',
                    loop: true,
                    navigateByClick: true,
                    numImagesToPreload: 3,
                    arrowsNavAutoHide: true,
                    arrowsNav: false,
                    arrowsNavHideOnTouch: true,
                    keyboardNavEnabled: true,
                    fadeinLoadedSlide: false,
                    video: {
                        autoHideArrows: true,
                        autoHideControlNav: false,
                        autoHideBlocks: true
                    }
                });
        }
    },
    aboutVideo: function (obj) {
        if (obj) {

            var src = $(obj).data("video");
            if (src != "") {
                var rx = /^.+\?v=([^&]+).*$/;
                var tsrc = src.replace(rx, "$1");

                $(obj).tubeplayer({
                    width: "100%",
                    height: 150,
                    initialVideo: tsrc
                });
            }
        }
    }
};

APP.clearTitle = function () {
    var obj = APP.getPageElement("header", "div.title");
    if (obj) {
        $(obj).empty();
    }
}

APP.clearContent = function () {
    var objContent = APP.getPageElement("content", "");
    if (objContent) {
        $(objContent).empty();
    }
};

APP.initialize = function () {
    var _this = this;

    //Initialize Google Analytics:
    _this.analytics.init();


    //Prepare contents:
    APP.clearTitle();
    APP.clearContent();

    //Load first page:
    APP.loadPageData("", "/", function (json) {
        var objIcons = _this.build.topIcons(json.data.misc.icons);
        APP.clearTitle();
        APP.clearContent();

        var objContent = APP.getPageElement("content", "");
        $(objContent)
            .append(objIcons)
            .append(_this.build.menu(json.data.misc.sections));


        var objFooter = _this.getPageElement("footer", "");
        if (objFooter) {
            $(objFooter)
                .html(_this.build.footer(json.data.misc.footer));
        }

        _this.init.topIcons(objIcons);

        //Make sure footer is positioned properly:
        $.mobile.activePage.trigger("updatelayout");


    });
};



APP.loadPageData = function (id, path, cb) {
    APP.loading(true);

    if (APP.hasConnection()) {
        window.setTimeout(
            function () {
                $.ajax({
                    url: APP.server + APP.dataProvider,
                    data: {
                        id: id,
                        path: path
                    },
                    dataType: "jsonp",
                    timeout: APP.timeout,
                    complete: function () {
                        APP.loading(false);
                    },
                    success: function (json, status) {
                        if (json.status && json.status == 1) {
                            //Track page on analytics:
                            APP.analytics.trackPage(json.data.url);

                            $($.mobile.activePage).data({
                                "url": json.data.url,
                                "title": json.data.title,
                                "caption": json.data.caption,
                                "description": json.data.description
                            });

                            if ($.isFunction(cb)) {
                                cb(json);
                            }
                        }
                        else {
                            APP.alert({
                                message: "Kunne ikke finde den ønskede side :-("
                            });
                        }
                    },
                    error: function () {
                        APP.alert({
                            message: "Der opstod desværre en fejl :-("
                        });
                    }
                })
            }, APP.delay);
    }
    else {
        APP.alert({
            title: "Ingen forbindelse :-(",
            message: $.mobile.offlineLoadError
        });
    }
};


APP.router = null;

APP.controllerHelpers = {
    pagebeforeshow: function (page, params, cb) {
        //        $.mobile.loading('show');
        var dId = $(page).data("id") || 0;
        params = params || {};
        //        if ($(page).data("id") != params.id) {
        if (dId != params.id) {
            if ($.isFunction(cb)) {
                cb();
            }
        }
    },
    pageshow: function (page, params) {
        $(page).data("id", params.id);
    }
};


APP.builder = {
    "title": function (objHeader, json) {
        var objDiv = $(objHeader).find("div.title:first").get(0);
        if (objDiv) {
            $(objDiv).html(APP.build.title(json.data.title));
        }
    },

    "section": function (objContent, json) {
        var objImages = APP.build.images(json.data.misc.images);

        $(objContent)
            .append(objImages)
            .append(APP.build.contentText(json.data.misc.text))
            .append(APP.build.menu(json.data.misc.sections));

        if (objImages != null) {
            APP.init.slider(objImages);
        }
    },

    "sectiondetails": function (objContent, json) {
        var objImages = APP.build.images(json.data.misc.images);

        $(objContent).append(objImages);

        $(objContent)
            .append(APP.build.contactIcons(json.data.theme, json.data.misc.contact))
            .append(APP.build.contentText(json.data.misc.text))
            .append(APP.build.menu(json.data.misc.sections));

        if (objImages != null) {
            APP.init.slider(objImages);
            $(objImages).append(APP.build.sectionDetailsLogo(json.data.misc.logo));
        }
    },

    "contact": function (objContent, json) {
        $(objContent)
            .append(APP.build.contentText(json.data.misc.text))
            .append(APP.build.contactForm())
            .trigger("create");
    },

    "about": function (objContent, json) {
        var objVideo = APP.build.aboutVideo(json.data.misc.video);

        $(objContent)
            .append(objVideo)
            .append(APP.build.contentText(json.data.misc.text))
            .append(APP.build.aboutPeople(json.data.misc.people))
            .append(APP.build.aboutLogo());


        APP.init.aboutVideo(objVideo);
    }
};


APP.controller = {
    "generic": function (eventType, matchObj, ui, page, evt) {
        var ntype = matchObj[1];
        var params = APP.router.getParams(matchObj[2]) || {};
        params.id = params.id || 0;
        params.path = params.path || "";


        switch (eventType) {
            case "pagebeforeshow":

                APP.controllerHelpers.pagebeforeshow(page, params, function () {

                    APP.clearTitle();
                    APP.clearContent();

                    APP.loadPageData(params.id, "", function (json) {
                        var objHeader = APP.getPageElement("header", "");
                        var objContent = APP.getPageElement("content", "");

                        APP.clearTitle();
                        APP.clearContent();

                        APP.builder.title(objHeader, json);

                        switch (ntype) {
                            case "section":
                                APP.builder.section(objContent, json);
                                break;
                            case "sectiondetails":
                                APP.builder.sectiondetails(objContent, json);
                                break;
                            case "about":
                                APP.builder.about(objContent, json);
                                break;
                            case "contact":
                                APP.builder.contact(objContent, json);
                                break;
                        }

                        $.mobile.activePage.trigger("updatelayout");
                    });
                });
                break;

            case "pageshow":
                APP.controllerHelpers.pageshow(page, params);
                break;
        }
    }
};


$.mobile.defaultPageTransition = "none";
$.mobile.transitionFallbacks.slideout = "none";
$.mobile.languageCode = "da";
$.mobile.offlineLoadError = "Denne app kræver en aktiv internetforbindelse.";



APP.router = new $.mobile.Router([
    { "^#([^\\?]+)([?].*)?$": { events: "bs,s", handler: "generic" } }
], APP.controller);


//Toggle class upon tap (since :active pseudoclass doesn't work properly).
$("a").live("tap", function (e) {
    var _this = this;
    $(_this).addClass("active");
    window.setTimeout(function () {
        $(_this).removeClass("active");
    }, 250);
})

document.addEventListener("deviceready", function () {
    facebookConnect = window.plugins.facebookConnect;
    APP.initialize();
});

