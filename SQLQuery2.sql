--What are the total number of seats available for elections in each state?

SELECT
s.state AS State_name,
COUNT(cr.parliament_constituency) AS Total_Seats
FROM
constituencywise_results cr
INNER JOIN statewise_results sr ON cr.Parliament_constituency = sr.Parliament_Constituency
INNER JOIN states s ON sr.state_ID = s.state_ID
GROUP BY s.state





--Total seats won by N.D.A alliance.

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





--Seats won by individual parties in N.D.A.

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





--Total seats won by I.N.D.I.A alliance (India National Developmental Inclusive Alliance).

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


							




--Seats won by individual parties in I.N.D.I.A alliance.

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
							


--Add new column field in table partywise_results to get the party alliance as NDA, INDIA and OTHER.

ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50)

SELECT * FROM partywise_results --To check whether the query has worked or not



--Add new column field in table partywise_results to get the party alliance as NDA, INDIA and OTHER.

ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50)





--Adding values to the new column in partywise_results

UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
                 'Indian National Congress - INC',
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


UPDATE partywise_results
SET party_alliance = 'N.D.A'
WHERE party IN (
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



UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL
                
			






--Which party alliance (NDA, INDIA or other) won the most seats across all states?

SELECT party_alliance, SUM(won) FROM 
partywise_results GROUP BY party_alliance  
        --N.D.A won the most seats across all states








--Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency. (NEWDELHI selected)

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





--What is the distribution of EVM votes versus postal votes for candidates in a specific constituency? (NEWDELHI selected)

SELECT
cd.EVM_Votes,
cd.Postal_Votes,
cd.Total_Votes,
cd.Candidate,
cr.Constituency_Name
FROM constituencywise_results cr JOIN constituencywise_details cd 
ON cr.Constituency_ID = cd.Constituency_ID
WHERE cr.Constituency_Name = 'NEWDELHI'








--Which parties won the most seats in a state, and how many seats did each party win?

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









--What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

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







--Which candidate received the highest number of EVM votes in each constituency (Top 10)?

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









--Which candidate won and which candidate was the runner-up in each constituency of state for the 2024 elections?


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











--For the union territory of Delhi, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?

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




	 












							



