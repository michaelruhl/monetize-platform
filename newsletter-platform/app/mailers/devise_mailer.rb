class DeviseMailer < Devise::Mailer
    def confirmation_instructions(record, token, opts={})
        @name = record.name
        super
    end