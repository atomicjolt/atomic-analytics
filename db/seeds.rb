admin = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << admin.email

# Setup default accounts
accounts = [{
  code: ENV["APP_SUBDOMAIN"],
  name: Rails.application.secrets.application_name,
  domain: Rails.application.secrets.application_url,
  lti_key: ENV["APP_SUBDOMAIN"],
  canvas_uri: Rails.application.secrets.canvas_url
}]

# Setup accounts
accounts.each do |account|
  if a = Account.find_by(code: account[:code])
    a.update_attributes!(account)
  else
    Account.create!(account)
  end
end

admin.account = Account.find_by(code: ENV["APP_SUBDOMAIN"])
admin.save!
