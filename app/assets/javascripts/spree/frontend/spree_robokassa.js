Spree.ready(function ($) {
    Spree.onPayment = function () {
        if ($('#checkout_form_payment').length) {
            $('[data-hook="buttons"]').hide()
            $('input[type="radio"][name="order[payments_attributes][][payment_method_id]"]').click(function () {
                if ($('#payment_method_' + this.value).find('.robokassa').children().length == 0) {
                    $('[data-hook="buttons"]').show()
                } else {
                    $('[data-hook="buttons"]').hide()
                }
            })
        }
    }
    Spree.onPayment()
})
