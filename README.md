# PopChef to Slack

`eatpopchef-to-slack` is a little project, written in Ruby.

It sends every day at 11:30am the available dishes on slack.
You receive a message for every dishes, the price, the available quantity and the picture of the dish.

Your team vote for the dish they want to order with the built-in Slack reaction system.

Then, when you decide the order are over, we send you how many dishes should be ordered and for who.

## How to install and configure it

- Clone the repository
- Install ruby
- `bundle install` at the root of the repo
- `cp config/config.yml.example config/config.yml`
- `crontab -e`
- `30 11 * * * ruby /PATH/TO/THE/REPO/eatpopchef-to-slack/bin/eatpopchef_to_slack`
