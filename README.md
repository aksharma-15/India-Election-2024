# India-Election-2024
The project is based on the 2024 lok sabha elections held in India.

## Table of contents 
- [Project overview](#project-overview)
- [Data sources](#data-sources)
- [Purpose of each file](#purpose-of-each-file)
- [Tools](#tools)
- [Problem statements SQL](#problem-statements-sql)
- [Report and visualization](#report-and-visualization)
- [Conclusion](#conclusion)

## Project overview
This project contains the complete trend and analysis of the 2024 lok sabha elections held in India.I have gathered five .csv files that were released right after the election results and used them to determine all the insights and conclusions portrayed in this project. I have used 3 tools in making this project, namely, MS-Excel, MS SQL server management studio 19 and MS Power BI. I have made problem statements for both SQL and Power BI reports. The project will prove to be useful to political analysts, journalists and maybe even political leaders from all over India. 

## Data sources
1. constituencywise_details.csv
2. constituencywise_results.csv
3. partywise_results.csv
4. statewise_results
5. states
   - All files have been downloaded from Kaggle

## Purpose of each file
1. constituencywise_details: Holds information according to the constituency. Has a column named as "Constituency ID", this column is used as joining column with other tables in SQL database. It's a foreign key.
 2. constituencywise_results: Consists of facts about all the consitituencies and winning candidates along with their votes. The column "party ID" is the foreign key here.
 3. partywise_results: Information of the parties and the number of constituencies they have won. Only parties who have won at least 1 or more seats are mentioned and used in this project.
 4. statewise_results: Information of all the states with their constituencies along with winning and runner-up candidate.
 5. states: All the states of India along with state ID.

## Tools
- MS SQL server - Data analysis and manipulation
- Power BI - Visualization and report making

## Problem statements SQL
 1. Total seats (Total number of seats throughout all constituencies)
 2. What are the total number of seats available for elections in each state?
 3. Total seats won by N.D.A alliance.
 4. Seats won by individual parties in N.D.A.
 5. Total seats won by I.N.D.I.A alliance (India National Developmental Inclusive Alliance).
 6. Seats won by individual parties in I.N.D.I.A alliance.
 7. Add new column field in table partywise_results to get the party alliance as NDA, INDIA and OTHER.
 8. Which party alliance (NDA, INDIA or other) won the most seats across all states?
 9. Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency.
 10. What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
 11. Which parties won the most seats in a state, and how many seats did each party win?
 12. What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024?
 13. Which candidate received the highest number of EVM votes in each constituency (Top 10)?
 14. Which candidate won and which candidate was the runner-up in each constituency of state for the 2024 elections?
 15. For the UT of Delhi, what are the total number of seats, total number of candidates, total number of parties, total votes(including EVM and postal), and the breakdown of EVM and postal votes?
     
     - P.S: As I have used MS SQL Management Studio 19 for working with sql database, there was no need for me to end my queries with (;)
     - All the above statements have been answered. The queries related to each statement are as follows:
     1. Total seats (Total number of seats throughout all constituencies)
          ```sql
          SELECT 
	        DISTINCT COUNT (Parliament_Constituency) AS Total_Seats
	        FROM constituencywise_results

          ```
     2. What are the total number of seats available for elections in each state?
        ```sql
        SELECT 
        s.State AS State_Name,
        COUNT(cr.Constituency_ID) AS Total_Seats_Available
        FROM 
        constituencywise_results cr
        JOIN 
        statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
        JOIN 
        states s ON sr.State_ID = s.State_ID
        GROUP BY 
        s.State
        ORDER BY 
        s.State;

        ```
     3. Total seats won by N.D.A alliance.
        ```sql
        SELECT 
        SUM(CASE 
             WHEN party IN ('Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
                            ) THEN [Won]
							ELSE 0
							END) AS NDA_Total_Seats_Won
							FROM 
							partywise_results
        ```
     4. Seats won by individual parties in N.D.A.
        ```sql
        SELECT party AS Party_Name,
        won AS Seats_Won
        FROM
        partywise_results
        WHERE 
        party IN (
	           'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
				)
				ORDER BY Seats_Won DESC
        ```
     5. Total seats won by I.N.D.I.A alliance (India National Developmental Inclusive Alliance).
           ```sql
           SELECT 
           SUM(CASE 
             WHEN party IN ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'

                            ) THEN [Won]
							ELSE 0
							END) AS INDIA_Total_Seats_Won
							FROM 
							partywise_results
           ```
      6. Seats won by individual parties in I.N.D.I.A alliance.
         ```sql
         SELECT 
         party,
	       won FROM partywise_results
             WHERE party IN ('Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'

                            ) 

							SELECT * FROM partywise_results
         ```
      7. Add new column field in table partywise_results to get the party alliance as NDA, INDIA and OTHER.
            ```sql
            ALTER TABLE partywise_results
            ADD party_alliance VARCHAR(50)

            SELECT * FROM partywise_results --To check whether the query has worked or not



            --Adding new column field in table partywise_results to get the party alliance as NDA, INDIA and OTHER.

             ALTER TABLE partywise_results
            ADD party_alliance VARCHAR(50)
            ```
     8. Which party alliance (NDA, INDIA or other) won the most seats across all states?
        ```sql
        SELECT party_alliance, SUM(won) FROM 
        partywise_results GROUP BY party_alliance  
        --N.D.A won the most seats across all states
     9. Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency.
        ```sql
        SELECT
        cr.Winning_Candidate,
        pr.party,
        pr.party_alliance,
        cr.total_votes,
        cr.margin,
        state,
        cr.Constituency_Name
        FROM
        constituencywise_results cr INNER JOIN partywise_results pr ON cr.Party_ID = pr.party_ID
        INNER JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
        WHERE cr.Constituency_Name = 'NEWDELHI'
        ```
     10. What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?
         ```sql
         SELECT
         cd.EVM_Votes,
         cd.Postal_Votes,
         cd.Total_Votes,
         cd.Candidate,
         cr.Constituency_Name
         FROM constituencywise_results cr JOIN constituencywise_details cd 
         ON cr.Constituency_ID = cd.Constituency_ID
         WHERE cr.Constituency_Name = 'NEWDELHI'
         ```
      11. Which parties won the most seats in a state, and how many seats did each party win?
          ```sql
          SELECT
          p.Party,
          COUNT(cr.Constituency_ID) AS Seats_Won
          FROM
          constituencywise_results cr
          JOIN
          partywise_results p ON cr.Party_ID = p.Party_ID
          JOIN
          statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
          JOIN
          states s ON sr.State_ID = s.State_ID
          WHERE
          s.state = 'Delhi'
          GROUP BY p.Party
          ORDER BY Seats_Won DESC
          ```
      12. What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024?
          ```sql
          SELECT
          s.State,
          SUM(CASE WHEN pr.party_alliance = 'N.D.A' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
          SUM(CASE WHEN pr.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
          SUM(CASE WHEN pr.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
          FROM
          constituencywise_results cr
          JOIN
          partywise_results pr ON cr.Party_ID = pr.Party_ID
          JOIN  
          statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
          JOIN
          states s ON sr.State_ID = s.State_ID
          GROUP BY s.state
          ```
      13. Which candidate received the highest number of EVM votes in each constituency (Top 10)?
          ```sql
          SELECT TOP 10
          cr. Constituency_Name,
          cd.Constituency_ID,
          cd.Candidate,
          cd.EVM_Votes
          FROM
          constituencywise_details cd
          INNER JOIN
          constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
          WHERE 
          cd.EVM_Votes = (
	                 SELECT MAX(cd1.EVM_Votes)
					 FROM constituencywise_details cd1
					 WHERE cd1.Constituency_ID = cd.Constituency_ID
					 )
          ORDER BY
          cd.EVM_Votes DESC
          ```
      14. Which candidate won and which candidate was the runner-up in each constituency of state for the 2024 elections?
          ```sql
          WITH RankedCandidates AS (
          SELECT 
          cd.Constituency_ID,
          cd.Candidate,
          cd.Party,
          cd.EVM_Votes,
          cd.Postal_Votes,
          cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
          ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
          FROM 
          constituencywise_details cd
          JOIN 
          constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
          JOIN 
          statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
          JOIN 
          states s ON sr.State_ID = s.State_ID
          WHERE 
          s.State = 'MAHARASHTRA'      --Maharashtra taken as the choice of state.
          )

          SELECT 
          cr.Constituency_Name,
          MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
          MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
          FROM 
          RankedCandidates rc
          JOIN 
          constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
          GROUP BY 
          cr.Constituency_Name
          ORDER BY 
          cr.Constituency_Name
          ```
     15. For the UT of Delhi, what are the total number of seats, total number of candidates, total number of parties, total votes(including EVM and postal), and the breakdown of EVM and postal votes?
         ```sql
         SELECT 
         COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
         COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
         COUNT(DISTINCT p.Party) AS Total_Parties,
         SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
         SUM(cd.EVM_Votes) AS Total_EVM_Votes,
         SUM(cd.Postal_Votes) AS Total_Postal_Votes
         FROM 
         constituencywise_results cr
         JOIN 
         constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
         JOIN 
         statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
         JOIN 
         states s ON sr.State_ID = s.State_ID
         JOIN 
         partywise_results p ON cr.Party_ID = p.Party_ID
         WHERE 
         s.State = 'Delhi'
        ```
        
          

        
## Report and visualization 
I have used Power BI desktop to further analyse the data and to visualize it to create easy to understand and interactive dashboards. I also used DAX and Power Query to add new measures and columns to the data in order to connect the tables so that I could make sufficiently interactive dashboards. The problem statements document file for Power BI is provided along with final product I have created.

## Conclusion 
It took me around 3 days to complete the project. The project is made to showcase my current skill level in SQL and data visualization using Power BI. I hope you find it useful.

