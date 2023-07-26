var UsertimeModule = (function($) {
    'use strict';

    var TAG = 'usertime';
    var FORMAT = 'format';
    var LOCALE = 'es';
    var MUTATION = window.MutationObserver !== undefined;

    function convert() {
        var element = $(this);
        var time = element.text();
        if (!time) {
            return;
        }
        time = /^[0-9]+$/.test(time) ? parseInt(time) : time;
        time = new Date(time * 1000);
        if (time.toString() == 'Invalid Date') {
            return;
        }
        time = moment(time);
        var format = element.attr(FORMAT);
        if (format === undefined) {
            format = 'YYYY-MM-DD HH:mm:ss';
        }
        var converted = time.format(format);
        element.parent().css('text-transform', 'capitalize');
        element.replaceWith(converted.replace(/\./g, ''));
    }

    if (MUTATION) {
        moment.locale(LOCALE);
        var observer = new MutationObserver(function(records) {
            records.forEach(function(record) {
                if (!record.addedNodes.length) {
                    return;
                }
                Array.from(record.addedNodes).forEach(function(node) {
                    $(TAG, node).each(convert);
                });
            });
        });
        observer.observe(document, {
            childList : true,
            subtree : true
        });
    }

    function convertUnixTimes() {
        $(TAG).each(convert);
    }

    $(document).ready(function(){
        UsertimeModule.convertUnixTimes();
    });

    return { convertUnixTimes: convertUnixTimes };

})(jQuery);
