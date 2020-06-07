module Spree
  class RobokassaController < StoreController

    before_action :set_order
    before_action :validate_request, only: :result
    skip_before_action :verify_authenticity_token, raise: false

    def result
      unless @order.completed?
        payment = @order.payments.build(payment_method: payment_method, amount: params["OutSum"].to_f)
        payment.complete
        payment.save
        @order.next!
      end
      render plain: notification.success_response
    end

    def success
      redirect_to root_path, notice: t('robokassa.payment_succeed')
    end

    def failure
      redirect_to (@order.blank? ? root_url : checkout_state_path("payment")), flash: { error: t('robokassa.payment_failed') }
    end

    private

    def set_order
      @order = Order.find params['InvId']
    end

    def validate_request

      unless params["SignatureValue"].upcase == Digest::MD5.hexdigest([params["OutSum"], params["InvId"], payment_method.preferred_password2 ].join(':')).upcase
      # unless notification.acknowledge
        # payment.failure
        head :bad_request and return false
      end
    end

    def payment
      @payment ||= Spree::Payment.where(order_id: params['InvId']).first
    end

    def payment_method
      @payment_method ||= Spree::PaymentMethod.find_by(type: Spree::BillingIntegration::Robokassa.to_s)
    end

    def notification
      @notification ||= ::OffsitePayments::Integrations::Robokassa.notification(
        request.query_string || request.raw_post,
        secret: payment_method.preferred_password2)
    end

  end
end
