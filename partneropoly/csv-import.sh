#!/bin/bash

cat <<EOF
- text: Display intro slide
  action: Showing q00.svg
  context: q00.svg
EOF

q=1

while read x
do
  player="$(echo $x | awk '{print $2}')"
  roll="$(echo "$x" | awk -F\\t '{print $2}')"
  space="$(echo "$x" | awk -F\\t '{print $3}')"

  prop="$(echo "$x" | awk -F\\t '{print $4}')"
  question="$(echo "$x" | awk -F\\t '{print $5}')"
  cat <<EOF
- text: Player $player rolls $roll
  action: Rolling dice
  roll: [$roll]
- text: Display space name
  action: Showing q${q}.svg
  context: q${q}.svg
- text: Player $player moves to $prop
  action: Moving game piece
  player: $player
  space: $space
- text: Display question
  action: Showing q${q}a.svg
  context: q${q}a.svg
EOF
  if [[ ! $space =~ ^(2|4|7|10|17|20|22|30|33|36|38|40)$ ]]; then
    cat <<EOF
- text: Player $player gets a blueprint on $prop
  action: Adding blueprint
  blueprint:
    space: $space
    file: blueprint$player.svg
EOF
  fi

  # Make svg files with imported text
  sed "s/SPACE_NAME/$prop/g;s/QUESTION_TEXT/ /g" p${player}qXa.svg > q${q}.svg
  sed "s/SPACE_NAME/$prop/g;s/QUESTION_TEXT/$question/g" p${player}qXa.svg > q${q}a.svg
  # This reflows the wrapped text field
  inkscape --export-overwrite q${q}a.svg

  ((q++))
done << EOF
player 1 	3,2	5	Azure Railroad 	Is ARO a RH product? Can RH sellers quote it? 
player 2	2,4	6	Oracle Avenue	Which Oracle products were recently certified on OCP? 
player 3	4,6	10	Just Visiting 	---
player 4 	5,3	8	VDI Avenue	Name one of the main VDI vendors.
player 1 	2,5	12	Electric Company	Name this popular compute hardware that is straining electrical capacity.
player 2 	3,4	13	Palo Alto Avenue	What is PA's popular container security solution called? 
player 3 	1,5	16	Cisco Avenue	Name the large data insights provider that they acquired? 
player 4 	3,3	14	Accenture Avenue	True or false: Accenture has a reselling subsidiary? 
player 4 	3,1	18	EY Avenue	What is a question for EY?
player 1 	1,5	18	EY Avenue	Have another question for EY?
player 2 	4,3	20	Free Parking 	Open Source Question - What is the value of Open Source for clients? 
player 3 	1,3	20	Free Parking 	Open Source Question - Why is Open Source the best option when looking at corporate risk? 
player 4 	5,3	26	Ahead Avenue 	Ahead has a unique management solution and value prop. What is it called? 
Player 1 	2,5	25	Oracle Railroad 	Last year OCI and Red Hat made a big partnership anouncement. What was it? 
player 2 	3,5	28	Crossvale Avenue	Crossvale has a solution that allows clients to realize 60% cost savings along with improved operational efficiency, automating cluster ops, and scaling apps. What is it called?
player 3 	5,6	31	Hugging Face Avenue	What is Hugging Face? 
player 4 	4,6	36	Chance 	Audience describes IPU and its value to clients.
Player 1 	6,3	34	Dell Avenue	Dell and Red Hat launched an appliance together. What is it called? 
player 2 	4,5	37	WWT Place 	WWT provides many clients with lab and testing environments. What is their AI testing environemnt called? 
player 3 	1,6	38	AI Luxury Tax 	What are some of the common downfalls when implementing AI? 
player 4 	6,5	7	Chance 	Your client determines they arent seing the value of AI fast enough. What blueprint should you help them create? 
Player 1 	4,4	2	Community Chest 	Work with the room to identify a known blueprint with a partner.
player 1 	3,5	10	Just Visiting 	---
player 2 	5,5	7	Chance 	Your client is experiencing an outage. What blueprint can help them?
player 2 	5,3	15	Amazon Railroad	Is Rosa a Red Hat or AWS product? 
Player 3 	2,4	4	Tech Debt Tax 	Name a client challenge that DCM aims to solve? 
player 4 	1,3	11	PureStorge Avenue	What is Pure's K8 storage and data management software called? 
player 1 	4,3	17	Community Chest 	Bank error! Your client lost 5 million due to missed revenue. What blueprint would you recommend?
EOF

cat <<EOF
- text: Display intro slide
  action: Showing q00.svg
  context: q00.svg
EOF

exit 0
