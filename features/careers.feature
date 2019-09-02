Feature: Careers area

Scenario: See the Careers area
Given the user opens the website Freeletics
When the user clicks on the footer link "Careers"
Then the user sees the text "25 open positions" on the page

Scenario: See the Vacancies ist
Given the user accessed the Careers area
When the user clicks on "25 open positions"
Then the user sees the text "Unsolicited Application" on the page

Scenario: See the QA Engineer vacancy page
Given the user accessed the Vacancies list
When the user clicks on "QA Engineer (m/f/d)"
Then the user sees the job title "QA ENGINEER (M/F/D)"
And the user sees the job location "Munich"
And the user sees "9" items in the Your Responsibilities section
And the user sees "7" items in the Your Profile section

#@CloseTest
Scenario: Click on Apply Now on the QA Engineer vacancy page
Given the user accessed the Vacancies list
When the user clicks on "QA Engineer (m/f/d)"
And the user clicks on "Apply now"
And the user switches tabs
Then the user sees the text "Submit your application" on the page