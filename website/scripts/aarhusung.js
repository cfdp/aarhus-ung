var AARHUSUNG = {};

AARHUSUNG.isEmail = function (s) {
    var rx = /^[a-z0-9\-_\.]*[a-z0-9\-_]@([a-z0-9\-\.])+\.[a-z]{2,4}$/i;
    return s.match(rx);
};

AARHUSUNG.initSlider = function () {
    //slider setup
    if ($('.slider').length > 0) {
        $('.slider').cycle({
            fx: 'fade',
            timeout: 0,
            speed: 400,
            prev: '#prev',
            next: '#next',
            before: function () {
                $('.current .slide_inner').fadeOut();
                $(this).parent().find('.current').removeClass();
            },
            after: function () {
                $(this).addClass('current');
                $('.current .slide_inner').fadeIn();
            }
        });
    }
    //slider setup
    if ($('.small_slider').length > 0) {
        $('.small_slider').cycle({
            fx: 'fade',
            timeout: 0,
            speed: 400,
            prev: '#small_prev',
            next: '#small_next',
            before: function () {
                $('.current .slide_inner').fadeOut();
                $(this).parent().find('.current').removeClass();
            },
            after: function () {
                $(this).addClass('current');
                $('.current .slide_inner').fadeIn();
            }
        });
    }
};

AARHUSUNG.initFooter = function () {
    $.superbox.settings = {
        loadTxt: "Indlæser..."
    };
    $.superbox();

    var obj = $("#footer").get(0);
    if (obj) {
        var arrA = $(obj).find("a");
        $.each(arrA, function (i, n) {
            var s = $(n).attr("rel");
            if (s) {
                if (s.substr(0, 8) == "superbox") {
                    var h = $(n).attr("href");
                    h += "?v=dialog";
                    $(n).attr("href", h);
                }
            }
        });
    }
};

AARHUSUNG.initLinks = function () {
    $("a[href^=http]").click(function () {
        window.open($(this).attr("href"));
        return false;
    });
};

AARHUSUNG.initContact = function () {
    var _this = this;
    var objForm = $("#contact-form").get(0);
    if (objForm) {
        $(objForm).submit(function () {
            var objEmail = $(this).find("input[name='email']").get(0);
            var objMsg = $(this).find("textarea[name='message']").get(0);
            if (objEmail && objMsg) {
                var m = $(objEmail).val();
                var s = $(objMsg).val();
                if (m != "" && s != "") {
                    return _this.isEmail(m);
                }
            }
            return false;
        });
    }
};

AARHUSUNG.initPhoneLinks = function () {
    $.each($("li.phone"), function (i, n) {
        var objA = $(n).children("a").get(0);
        if (objA) {
            $(objA)
                .data("href", $(objA).attr("href"))
                .removeAttr("href");

            $(n).hover(
                function () {
                    $(n).addClass("opened");
                },
                function () {
                    $(n).removeClass("opened");
                }
            );
        }
    });
};

AARHUSUNG.initMenu = function () {
    $.each($("ul.menu a"), function (i, n) {
        var c = $(n).data("c");
        if (c != "") {
            if ($(n).parent().hasClass("current")) {
                $(n).css("color", "#" + c);
            }
            var dc = $(n).css("color");

            $(n).hover(
                function () {
                    $(this).css("color", "#" + c);
                },
                function () {
                    $(this).css("color", dc);
                }
            );
        }
    });
};

AARHUSUNG.initSubmenu = function () {
    var obj = $(".sidebar ul:first").get(0);
    if (obj) {
        var c = $(obj).data("c");
        if (c != "") {
            $.each($(obj).find("a"), function (i, n) {
                if ($(n).parent().hasClass("current")) {
                    $(n).css("color", "#" + c);
                }

                var dc = $(n).css("color");

                $(n).hover(
                    function () {
                        $(this).css("color", "#" + c);
                    },
                    function () {
                        $(this).css("color", dc);
                    }
                );
            });
        }
    }
};


$(function () {
    AARHUSUNG.initSlider();
    AARHUSUNG.initPhoneLinks();
    AARHUSUNG.initMenu();
    AARHUSUNG.initSubmenu();
});