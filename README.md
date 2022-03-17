# CirlceCI Slack Messages

This is a sample repo to demonstrate sending build information to Slack.

There are three additional files:

1. `generate_vars.sh` - this contains a shell script to hit the API and generate environment vars
2. `failing.json` - this contains the template for failed builds
3. `passing.json` - this contains the templte for passing builds

The script will run after all other steps and before the Slack notify step. This will allow it to pick up a failed step.

Currently this will only handle one failed step. If a single job contains more than one failed steps, it may not correctly work.

You will also need to set your Slack credentials in a context or project level environment variable, as well as a project or user api token.
