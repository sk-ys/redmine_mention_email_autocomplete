Redmine::Plugin.register :redmine_mention_email_autocomplete do
  name 'Redmine Mention Email Autocomplete'
  author 'sk-ys'
  description 'This is a plugin for Redmine. It adds email autocomplete functionality for mentions.'
  version '0.1.0'
  url 'https://github.com/sk-ys/redmine_mention_email_autocomplete'
  author_url 'https://github.com/sk-ys'
  settings default: {
    'show_mail' => '0',
  }, partial: 'settings/mention_email_autocomplete'
end

require_relative 'lib/mention_email_autocomplete/patch'