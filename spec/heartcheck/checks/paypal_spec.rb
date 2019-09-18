# frozen_string_literal: true

RSpec.describe Heartcheck::Checks::Paypal do
  let :service do
    {
      client_id: 'client_super_secret_id',
      secret_id: 'master_blaster_secret',
      mode: 'sandbox'
    }
  end

  subject do
    described_class.new.tap do |config|
      config.add_service(service)
    end
  end

  describe '#validate' do
    context 'when everything is fine' do
      it 'does not add any error' do
        payment = instance_double(PayPal::SDK::REST::DataTypes::Payment)
        allow(PayPal::SDK::REST::DataTypes::Payment)
          .to receive(:new)
          .and_return(payment)
        allow(payment).to receive(:create).and_return(true)

        subject.validate

        expect(subject.instance_variable_get(:@errors)).to be_empty
      end
    end

    context 'when paypal returns an error' do
      it 'adds the paypal error message' do
        payment = instance_double(
          PayPal::SDK::REST::DataTypes::Payment,
          error: 'Paypal error message'
        )
        allow(PayPal::SDK::REST::DataTypes::Payment)
          .to receive(:new)
          .and_return(payment)
        allow(payment).to receive(:create).and_return(false)

        subject.validate

        expect(subject.instance_variable_get(:@errors))
          .to contain_exactly('Paypal error message')
      end
    end

    context 'when an exception is raised' do
      it 'adds the exception error message' do
        payment = instance_double(PayPal::SDK::REST::DataTypes::Payment)
        allow(PayPal::SDK::REST::DataTypes::Payment)
          .to receive(:new)
          .and_return(payment)
        allow(payment).to receive(:create).and_raise('Ops!')

        subject.validate

        expect(subject.instance_variable_get(:@errors))
          .to contain_exactly('Ops!')
      end
    end
  end
end
