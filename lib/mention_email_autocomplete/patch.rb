module MentionEmailAutocomplete
  module Patch
    private

    # Whether the viewer is allowed to see the email (administrators, the user themselves, or users who do not hide email)
    def mail_visible_for_autocomplete?(user)
      return false unless user.is_a?(User)
      User.current.admin? || User.current == user || !user.pref.hide_mail
    end

    def format_users_json(users)
      q = params[:q].to_s.strip.downcase

      # Exclude a user with hide_mail enabled if the only match is an email address
      users = users.select do |u|
        mail_visible_for_autocomplete?(u) ||
          [u.try(:login), u.try(:firstname), u.try(:lastname), u.name].any? { |s| s.to_s.downcase.include?(q) }
      end

      json = super(users)

      # Add the email to the name for users whose email is visible (used for both filtering and display)
      users.zip(json).each do |u, h|
        next unless h && u.try(:mail).present? && mail_visible_for_autocomplete?(u)

        if Setting.plugin_redmine_mention_email_autocomplete['show_mail'] == '1'
          # Display the email address as part of the suggestion
          h['name'] = "#{h['name']} <#{u.mail}>"
        else
          # Do not display the email address as part of the suggestion
          # Note: lastname is not normally displayed in the suggestion, so we append the email here
          h['lastname'] = "#{h['lastname']} #{u.mail}"
        end
      end
      json
    end
  end
end

unless WatchersController.include?(::MentionEmailAutocomplete::Patch)
  WatchersController.prepend MentionEmailAutocomplete::Patch
end