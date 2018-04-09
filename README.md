# Slashiez

Slashiez is a mini-framework, written in PHP, for running simple [Slack slash commands](https://api.slack.com/slash-commands) on [Azure Functions](https://azure.microsoft.com/en-gb/services/functions/). It comes pre-packaged with several ready-to-go functions for retrieving and managing data in some online tools I use regularly.

***This project is currently under construction, and is not yet ready for production.***

## Commands

* `/dropbox` (Coming soon)
* `/evernote` (Coming soon)
* `/lastpass` (Coming soon)
* `/pocket` (Currently under construction)
* `/pokedex` (Coming soon)
* `/ptv` (Coming soon)
* `/slack` (Coming soon)

## Installation

**Full instructions coming soon.**

There's a few steps, including setting up the infrastructure with [Terraform](https://www.terraform.io/) and the [Azure CLI](https://github.com/Azure/azure-cli), and setting up a [Slack app](https://api.slack.com/).

Some short notes follow for now, but remember **these instructions are under construction**.

### Infrastructure setup

You'll need to [download Terraform](https://www.terraform.io/downloads.html) and [install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) before continuing.

1. Clone this repository to your local machine.
1. Adjust any desired values in [`config.tf`](config.tf), such as naming or state management options.
     * If you're new to Terraform, managing state locally is the easiest way to get started, so you'll want to remove the `terraform {}` block and probably the "aws" provider block as well.
1. Ensure you're logged in to the Azure CLI (run `az login`), OR have exported the [neccessary environment variables](https://www.terraform.io/docs/providers/azurerm/index.html#argument-reference) for Terraform use.
1. Run `terraform init` then `terraform apply`, and follow the prompts.
1. There are some features of Function Apps that Terraform doesn't configure, so next run `./setup.sh`.
     * This script doesn't pull anything from the Terraform config yet, so you'll need to update any naming in the script's variables.
     * You'll be prompted to enter a password to use for pushing to Azure's local git for function deployment.
1. Run `export AZURE_GIT_REMOTE=https://USERNAME:PASSWORD@FUNCTIONAPP.scm.azurewebsites.net/FUNCTIONAPP.git`, replacing the relevant values with those you got (or set) in the last step.
1. Run `./deploy.sh`.

If everything went well, you should now have an instance of Slashiez running in Azure!

### Slack app set up

Coming soon...

## History

_Slashies_ with an S is a mini-framework I created at [Chromatix](https://www.chromatix.com.au), for linking together data and powering minor automations between [various](https://toggl.com/) [online](https://www.wrike.com/) [tools](https://www.prosperworks.com/) we use in the office, utilising Slack slash commands. It's written in PHP, and runs on an [Intel NUC](https://www.intel.com.au/content/www/au/en/products/boards-kits/nuc.html) I have sitting on my desk as my WordPress development server.

As well as commands which the team use every day, I wrote additional commands to help me automate common tasks on services such as [Dropbox](https://www.dropbox.com/), [Evernote](https://www.evernote.com/) and [Pocket](https://getpocket.com/). Although the original Slashies hosting arrangement suits fine for use at Chromatix - particularly since some of the commands access data physically stored in the office - to adapt it to my personal needs I needed to separate it, and rewrite the functionality for use in the cloud.

I knew I wanted to go serverless to save on costs and maintenance burden. [Lambda](https://aws.amazon.com/lambda/) is usually my tool of choice here, but I'd already written the commands in PHP; Lambda doesn't (natively) support PHP; and I didn't want to have to bundle PHP itself, or rewrite the code entirely. Fortunately, [Azure Functions](https://azure.microsoft.com/en-gb/services/functions/) supports PHP (albeit in 'preview', but it seems to work ok). So Slashiez with a Z is Slashies... rewritten for running on Azure! ([IBM's Cloud Functions](https://www.ibm.com/cloud/functions) would be an alternative choice).

## License

[MIT](LICENSE).
