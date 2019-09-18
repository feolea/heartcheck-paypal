# frozen_string_literal: true

module Heartcheck
  module Checks
    class Paypal < Base
      include PayPal::SDK::REST

      def validate
        services.each do |service|
          configure_paypal_api(service)

          unless create_payment(service)
            @errors << @payment.error
          end
        rescue StandardError => e
          @errors << e.message
        end
      end

      private

      def create_payment(service)
        order = service[:order] || dumb_order

        @payment = Payment.new(order)
        @payment.create
      end

      def configure_paypal_api(service)
         PayPal::SDK::REST.set_config(
            {
              client_id: service[:client_id],
              client_secret: service[:client_secret],
              mode: service[:mode]
            }
          )
      end

      def dumb_order
        {
          intent: 'sale',
          payer: { payment_method: 'paypal' },
          redirect_urls: {
            return_url: 'http://localhost:3000/payment/execute',
            cancel_url: 'http://localhost:3000/'
          },
          transactions: [
            {
              item_list: {
                items: [
                  {
                    name: 'blevs',
                    sku: 'jettyphon',
                    price: '7',
                    currency: 'BRL',
                    quantity: 1
                  }
                ]
              },
              amount: { total: '7', currency: 'BRL' },
              description: 'Its just a test description.'
            }
          ]
        }
      end
    end
  end
end
