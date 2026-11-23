# Redmine Mention Email Autocomplete

[![GPLv2 License](https://img.shields.io/badge/license-GPLv2-blue.svg)](LICENSE)

Redmine Mention Email Autocomplete allows users to find Redmine users by email address while typing `@` mentions.

## Features

- Adds email addresses to the existing search keys used by Redmine's mention candidate autocomplete.
- Adds the email address to eligible mention candidates.
- Respects Redmine users' **Hide my email address** setting.

## Compatibility

- Redmine 6.1 (Other versions are not tested)
- The plugin patches `WatchersController#format_users_json`, which is used to build mention autocomplete results.

## Installation

1. Download or clone this repository into the Redmine plugins directory:

   ```sh
   cd /path/to/redmine/plugins
   git clone https://github.com/sk-ys/redmine_mention_email_autocomplete.git redmine_mention_email_autocomplete
   ```

2. Restart Redmine:

   ```sh
   cd /path/to/redmine
   bundle exec rails server
   ```

No database migration is required.

## Configuration

Open **Administration > Plugins**, locate **Redmine Mention Email Autocomplete**, and select **Configure**.

| Setting                           | Default  | Description                                                                                                           |
| --------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------- |
| Show email in mention suggestions | Disabled | When enabled, appends the email address to the user's displayed name, for example: `John Smith <jsmith@example.com>`. |

The setting applies globally to all users.

### Email privacy

A candidate is included only from an email match when the viewer is allowed to see that user's email:

- The current user is an administrator.
- The candidate is the current user.
- The candidate has not enabled **Hide my email address**.

Email visibility does not expose hidden addresses to users who are not allowed to see them.

## Usage

In an editor that supports Redmine mentions:

1. Type `@`.
2. Enter all or part of a visible email address.
3. Select a user from the suggestions.


## License

This project is licensed under the [GNU General Public License v2.0](LICENSE).
