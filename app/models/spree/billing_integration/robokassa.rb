module Spree
  class BillingIntegration::Robokassa < BillingIntegration

    preference :mrch_login, :string
    preference :password1, :string
    preference :password2, :string

    def provider_class
      OffsitePayments::Integrations::Robokassa
    end

    def service_url
      OffsitePayments::Integrations::Robokassa.production_url
    end

    def service_request(id, amount)
      helper = OffsitePayments::Integrations::Robokassa.helper(id, preferred_mrch_login,
                                                                 secret: preferred_password1, amount: amount)
      is_test = preferred_test_mode ? "&IsTest=1" : ""
      query = helper.form_fields.map{ |k,v| "#{k}=#{v}" }.reduce{ |a,v| "#{a}&#{v}" }
      "#{service_url}?#{query}#{is_test}"
    end

  end
end
