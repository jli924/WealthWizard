# WealthWizard set up and members

**Members**
1. Jamie Li 
2. Sarah LaCroix
3. Kriti Gupta
4. Shreesh Dassarkar
5. Daniel Fernandez

## How to setup and start the containers
**Important** - you need Docker Desktop installed

To set up & run the WealthWizard app:
1. Clone this repository. 
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

## Appsmith & UI
1. Go to our UI repository: https://github.com/jli924/WealthWizardUI
2. Scroll down to the README.md file and click "View application"
3. Navigate between different pages and manage your finances!
3a. When navigating between different pages, be sure to use the home button (don't click through the tabs at the top! It can cause issues with loading data)






