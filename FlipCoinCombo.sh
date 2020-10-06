#!/bin/bash

echo "This program displays winning percentage of Head or Tail Combination in a Singlet, Doublet and Triplet"

#input number of flips respectively
read -p "how many times you want to flip for singlet :" flips_for_singlet
read -p "how many times you want to flip for doublet :" flips_for_doublet
read -p "how many times you want to flip for triplet :" flips_for_triplet

#dictionary declaretion
declare -A SingletDictionary
declare -A DoubletDictionary
declare -A TripletDictionary

#Variables for singlet
heads=0
tails=0
#Variables for doublet
HH=0
TH=0
HT=0
TT=0
#Variables for triplet
HHH=0
HHT=0
HTT=0
THH=0
TTH=0
THT=0
HTH=0


#for singlet
for i in `seq $flips_for_singlet`
do
	FLIP=$(($((RANDOM%10))%2))

	if [[ $FLIP -eq 1 ]]
	then
		((heads++));
		SingletDictionary["key$i"]=`echo "H"`
		head_percent=`echo $heads |awk 'BEGIN{printf("%02.2f", '$heads'*100)}'`
	else
		((tails++));
		SingletDictionary["key$i"]=`echo "T"`
		tail_percent=`echo $heads |awk 'BEGIN{printf("%02.2f", '$tails'*100)}'`
	fi
done

#Finding winner in singlet
if [[ $heads -gt $tails ]]
then
	echo "Winner in singlet is : Heads"
else
        echo "Winner in singlet is : Tails"
fi

#loop for doublet combination of coins
for i in `seq $flips_for_doublet`
do
	doubletFlip=$(($((RANDOM%4))+1))
	case $doubletFlip in 
		1)((HH++))
		DoubletDictionary["key$i"]=`echo "HH"`;;
		
		2)((HT++))
		DoubletDictionary["key$i"]=`echo "HT"`;;
		
		3)((TH++))
		DoubletDictionary["key$i"]=`echo "TH"`;;
		
		4)((TT++))
		DoubletDictionary["key$i"]=`echo "TT"`;;
		
		*)DoubletDictionary["key$i"]=`echo "NA"`;;
	esac
done

#Finding the winner in doublet
if [[ $HH -gt $HT ]] &&  [[ $HH -gt $TH ]] && [[ $HH -gt $TT ]]
then
	echo "Winning in doublet combination is  : HH"
elif [[ $HT -gt $HH ]] &&  [[ $HT -gt $TH ]] && [[ $HT -gt $TT ]]
then
        echo "Winning in doublet combination is  : HT"
elif [[ $TH -gt $HH ]] &&  [[ $TH -gt $HT ]] && [[ $TH -gt $TT ]]
then
        echo "Winner in doublet is : TH"
else
        echo "Winner in doublet is : TT"
fi
#loop for triplet
for i in `seq $flips_for_triplet`
do
        tripletFlip=$(($((RANDOM%8))+1))
        case $tripletFlip in
                1)((HHH++))
		TripletDictionary["key$i"]=`echo "HHH"`;;
                
		2)((HHT++))
		TripletDictionary["key$i"]=`echo "HHT"`;;
                
		3)((HTH++))
		TripletDictionary["key$i"]=`echo "HTH"`;;
                
		4)((THH++))
		TripletDictionary["key$i"]=`echo "THH"`;;
		
		5)((TTH++))
		TripletDictionary["key$i"]=`echo "TTH"`;;
                
		6)((THT++))
		TripletDictionary["key$i"]=`echo "THT"`;; 
		
		7)((HTT++))
		TripletDictionary["key$i"]=`echo "HTT"`;;
		
		8)((TTT++))
		TripletDictionary["key$i"]=`echo "TTT"`;;
		
		*)TripletDictionary["key$i"]=`echo "NA"`;;
        esac
done

#Finding the winner in triplet
if [[ $HHH -gt $HHT ]] && [[ $HHH -gt $HTH ]] && [[ $HHH -gt $THH ]]&& [[ $HHH -gt $THT ]]&& [[ $HHH -gt $HTT ]] && [[ $HHH -gt $TTT ]]
then
	echo "Winner in triplet combination is : HHH"
elif [[ $HHT -gt $HHH ]] && [[ $HHT -gt $HTH ]] && [[ $HHT -gt $THH ]]&& [[ $HHT -gt $THT ]]&& [[ $HHT -gt $HTT ]] && [[ $HHT -gt $TTT ]]
then
	echo "Winner in triplet combination is : HHT"
elif [[ $THH -gt $HHT ]] && [[ $THH -gt $HTH ]] && [[ $THH -gt $HHH ]]&& [[ $THH -gt $THT ]]&& [[ $THH -gt $HTT ]] && [[ $THH -gt $TTT ]]
then
	echo "Winner in triplet combination is : THH"
elif [[ $THT -gt $HHT ]] && [[ $THT -gt $HTH ]] && [[ $THT -gt $THH ]]&& [[ $THT -gt $HHH ]]&& [[ $THT -gt $HTT ]] && [[ $THT -gt $TTT ]]
then
        echo "Winner in triplet combination is : THT"
elif [[ $HTT -gt $HHT ]] && [[ $HTT -gt $HTH ]] && [[ $HTT -gt $THH ]]&& [[ $HTT -gt $THT ]]&& [[ $HTT -gt $HHH ]] && [[ $HTT -gt $TTT ]]
then
        echo "Winner in triplet is: HTT"
else
	echo "Winner in triplet is : TTT"
fi


#display singlet dictionary and its percentage 
echo -e "Dictionary to show Singlet Combination : \n ${SingletDictionary[@]}"
echo "Percentage of head win: $head_percent%";
echo "Percentage of Tail win: $tail_percent%";
singlet_count=${#SingletDictionary[@]}
singlet_percentage=`echo ${#SingletDictionary[@]} | awk 'BEGIN{printf("%0.2f", '$head_percent' + '$tail_percent')}'`
