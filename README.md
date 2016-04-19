# LinkedIn Company Searcher

## Instructions

1. Install the required gems

   ```
   $ gem install linkedin
   $ gem install dotenv
   ```

2. Create a dotenv file like so:

   `$ touch .env`
3. In the dotenv file add the following environment variables from your LinkedIn API app

   ```
   LINKEDIN_CLIENT_ID=your_linkedin_client_id
   LINKEDIN_CLIENT_SECRET=your_linkedin_client_secret
   ```

4. Make sure you have a CSV with the list of companies names in the same directory as the script

5. Now run the script! `$ ruby linkedin_companies_search.rb`

6. If you are running this script for the first time follow the instructions to save the access token, if you get an error saying that the token expired, then delete the third line of the .env file if there is one.

7. Following the next instructions from the script (enter the name of the CSV file you want to parse and the column number where the companies' names are listed)

8. There should be a csv file in the same folder called `linkedin_scrape.csv`!

9. Enjoy!
