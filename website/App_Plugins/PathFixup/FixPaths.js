Umbraco.Sys.registerNamespace("Umbraco.Dashboards");

(function ($) {


    Umbraco.Dashboards.FixPaths = base2.Base.extend({
        //private methods/variables
        _opts: null,
        _status: "",
        _koViewModel: null,
        _timer: null,

        _updateStatus: function (e, pollForUpdate) {
            var self = this;
            self._koViewModel.status(e.status);
            self._koViewModel.message(e.message);

            switch (e.status) {
                case 1:
                    //Fixing
                    if (pollForUpdate) {
                        self._getStatus();
                    }
                    break;
                case 2:
                    //fixed

                    break;
                case 3:
                    break;
            }
        },

        _getStatus: function () {
            var self = this;
            setTimeout(function () {
                //double check that we're not completed already
                if (self._koViewModel.status() == 2)
                    return;

                $.get(self._opts.restServiceLocation + "GetStatus",
                    function (e) {
                        //double check that we're not completed already
                        if (self._koViewModel.status() == 2)
                            return;
                        self._updateStatus(e, true);
                    });
            }, 200);
        },

        // Constructor
        constructor: function (opts) {
            var self = this;

            // Merge options with default
            this._opts = $.extend({
                // Default options go here
            }, opts);

            //The knockout js view model for the selected item
            this._koViewModel = {
                start: function () {
                    self.start();
                },
                message: ko.observable(""),
                status: ko.observable(0),
            };
            //add computed properties
            this._koViewModel.messageStyle = ko.dependentObservable(function () {
                return this.status() == 2 ? "success" : "notice";
            }, this._koViewModel);
        },

        //public methods/variables

        init: function () {
            ko.applyBindings(this._koViewModel, document.getElementById('pathFixDashboard'));
        },

        start: function () {
            
            if (confirm("This operation may be an intensive operation based on how many nodes you have in your Umbraco instance. It will modify some data in the database so ensure you have a backup of your database. Are you sure you want to continue?")) {
                var self = this;
                
                $.post(self._opts.restServiceLocation + "FixPaths",
                    function (e) {
                        self._updateStatus(e, false);// update status but don't poll since it is complete
                    });
                
                //now poll for updates
                self._updateStatus({ status: 1, message: "Fixing" }, true);
            }
        }


    });

    //Set defaults for jQuery ajax calls.
    $.ajaxSetup({
        dataType: 'json',
        cache: false,
        contentType: 'application/json; charset=utf-8'
    });

})(jQuery);