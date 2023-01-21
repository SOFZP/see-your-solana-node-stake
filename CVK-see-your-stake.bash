#!/bin/bash
# Cryptovik "See All Your Stake" Script
# Stand with Ukraine!
# Donate to script author - 3nVhp5ZudpeTSYYWMeJiAHF6nNT6QmctFb5TCdNNMnJD (SOL)

pushd `dirname ${0}` > /dev/null || exit 1


# colors
CYAN='\033[0;36m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'

UNDERLINE='\033[4m'


function check_key () {
	local KEY_TO_CHECK=${1:-}
	
	local STAKE_NAMES=(SELF_STAKE FOUNDATION TDS_FOUNDATION SECRET_STAKE MARINADE MARINADE2 SOCEAN_POOL JPOOL_POOL EVERSOL_STAKE BLAZESTAKE LIDO_POOL DAOPOOL JITO_POOL LAINE_POOL UNKNOWN_POOL ?ALAMEDA2 ?ALAMEDA3 ?ALAMEDA4 ?ALAMEDA5 ?ALAMEDA6 ?ALAMEDA7 ?ALAMEDA8 ?ALAMEDA9 ?ALAMEDA10 ?ALAMEDA11 ?ALAMEDA12 ?ALAMEDA13 ?ALAMEDA14 ?ALAMEDA15)
	local STAKE_WTHDR=($NODE_WITHDRAW_AUTHORITY "4ZJhPQAgUseCsWhKvJLTmmRRUV74fdoTpQLNfKoekbPY" "mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN" "EhYXq3ANp5nAerUpbSgd7VK2RRcxK1zNuSQ755G5Mtxx" "9eG63CdHjsfhHmobHgLtESGC8GabbmRcaSpHAZrtmhco" "4bZ6o3eUUNXhKuqjdCnCoPAoLgWiuLYixKaxoa8PpiKk" "AzZRvyyMHBm8EHEksWxq4ozFL7JxLMydCDMGhqM6BVck" "HbJTxftxnXgpePCshA8FubsRj9MW4kfPscfuUfn44fnt" "C4NeuptywfXuyWB9A7H7g5jHVDE8L6Nj2hS53tA71KPn" "6WecYymEARvjG5ZyqkrVQ6YkhPfujNzWpSPwNKXHCbV2" "W1ZQRwUfSkDKy2oefRBUWph82Vr2zg9txWMA8RQazN5" "BbyX1GwUNsfbcoWwnkZDo8sqGmwNDzs2765RpjyQ1pQb" "6iQKfEyhr3bZMotVkW6beNZz5CPAkiwvgV2CTje9pVSS" "AAbVVaokj2VSZCmSU5Uzmxi6mxrG1n6StW9mnaWwN6cv" "HXdYQ5gixrY2H6Y9gqsD8kPM2JQKSaRiohDQtLbZkRWE" "e6keeZrGmHMiQaFM3TAYvFz8HE3qtTFUSHsyqq5FEw7" "DYG1ooTxkLS5iHDkte2XK4QBrpHziDR6EEZg5VsqNpVo" "EcH12jxhrbhF6qHqRzWpZ8rZU3TjG3sX6F67zP61oDJG" "HKd8LdhjUyhp2z4kYgpJxc4pzKCCKR4yC14EFSLNENtw" "8g3YB8KxpWEAAvcjom5vSqxJAZczZBgB4pEgsssts86K" "2YcwVbKx9L25Jpaj2vfWSXD5UKugZumWjzEe6suBUJi2" "DU5XJS2Cm8ftMmi5eZZJg8nkgx1hnZ3nT5sPU3GzV1fo" "7VMTVroogF6GhVunnUWF9hX8JiXqPHiZoG3VKAe64Ckt" "GunPZHAJc5DH8qARPz8x6UXAsoR3NDadFYs3bxtMZsvg" "7hbKGnBZEFF3Bwd9HFetDkLDHXycjvCATFUnj1nEzV85" "7dPqBYywCgLmjuHmexrEJLTCuoFpEUEf31Mjkjhz15wv" "5LJ93G4SQh9GiewTQJNAu6X9sQ1VVyrpCAgbQsRSgn22" "21uFTR9S5LptdR2tBxVeG1KAsKXB7tESqQVT8KRU7Vnj" "F5U6ac2vLzv3pYsxPVPYhhvxZY7u2WJMQEk81E3keMhX")
	
	for j in ${!STAKE_WTHDR[@]}; do
		if [[ "${KEY_TO_CHECK}" == "${STAKE_WTHDR[$j]}" ]]; then
			RETURN_INFO+=${STAKE_NAMES[$j]}
		fi
	done
	
	if [[ "$RETURN_INFO" == "" ]]; then
		RETURN_INFO="\t"
	fi
	
	echo $RETURN_INFO
}

function old_see_stake_function() {

	local ALL_STAKERS_WITHDRAWERS1=${1:-}

	echo -e "${CYAN}"
	echo -e "Active Stake ${NOCOLOR}"

	for i in $ALL_STAKERS_WITHDRAWERS1; do echo 'Withdraw Authority: '$i 'Active Stake: '`solana ${SOLANA_CLUSTER} stakes ${YOUR_VOTE_ACCOUNT} | grep -B7 -E $i | grep 'Active Stake' | sed 's/Active Stake: //g' | sed 's/ SOL//g' | bc | awk '{n+=0+$1+0}; END{print 0+n+0}'`; done

	echo -e "${RED}"
	echo -e "Deactivating Stake ${NOCOLOR}"

	for i in $ALL_STAKERS_WITHDRAWERS1; do echo 'Withdraw Authority: '$i 'Deactivating: '`solana ${SOLANA_CLUSTER} stakes ${YOUR_VOTE_ACCOUNT} | grep -B7 -E "$i" | grep -B1 -i 'deactivates' | grep 'Active Stake' | sed 's/Active Stake: //g' | sed 's/ SOL//g' | bc | awk '{n+=0+$1+0}; END{print 0+n+0}'`; done


	echo -e "${GREEN}"
	echo -e "Activating Stake ${NOCOLOR}"

	for i in $ALL_STAKERS_WITHDRAWERS1; do echo 'Withdraw Authority: '$i 'Activating Stake: '`solana ${SOLANA_CLUSTER} stakes ${YOUR_VOTE_ACCOUNT} | grep -B7 -E $i | grep 'Activating Stake' | sed 's/Activating Stake: //g' | sed 's/ SOL//g' | bc | awk '{n+=0+$1+0}; END{print 0+n+0}'`; done
}


# default info
DEFAULT_CLUSTER='-ul'
DEFAULT_SOLANA_ADRESS=`echo $(solana address)`
THIS_CONFIG_RPC=`solana config get | grep "RPC URL:"`

THIS_SOLANA_ADRESS=${1:-$DEFAULT_SOLANA_ADRESS}
SOLANA_CLUSTER=' '${2:-$DEFAULT_CLUSTER}' '


if [[ "${SOLANA_CLUSTER}" == " -ul " ]]; then
  if [[ $THIS_CONFIG_RPC == *"testnet"* ]]; then
	SOLANA_CLUSTER=" -ut "
  elif [[ $THIS_CONFIG_RPC == *"mainnet"* ]]; then
	SOLANA_CLUSTER=" -um "
  fi
fi

CLUSTER_NAME=`
if [[ "${SOLANA_CLUSTER}" == " -ut " ]]; then
  echo "(TESTNET)"
elif [[ "${SOLANA_CLUSTER}" == " -um " ]]; then
  echo "(Mainnet)"
elif [[ "${SOLANA_CLUSTER}" == " -ul " ]]; then
  echo "(Taken from Local)"
else
  echo ""
fi`

THIS_VALIDATOR_JSON=`solana ${SOLANA_CLUSTER} validators --output json-compact | jq --arg ID ${THIS_SOLANA_ADRESS} '.validators[] | select(.identityPubkey==$ID)'`

YOUR_VOTE_ACCOUNT=`echo -e "${THIS_VALIDATOR_JSON}" | jq -r '.voteAccountPubkey'`

EPOCH_INFO=`solana ${SOLANA_CLUSTER} epoch-info 2> /dev/null`
THIS_EPOCH=`echo -e "${EPOCH_INFO}" | grep 'Epoch: ' | sed 's/Epoch: //g' | awk '{print $1}'`

if [[ ${YOUR_VOTE_ACCOUNT} == "" ]]; then
	echo -e "${RED}${THIS_SOLANA_ADRESS} - can't find node account!"
	echo -e "<VOTE_ACCOUNT_ADDRESS> for it does not exist or --no-voting key is active or RPC error occured!${NOCOLOR}"
	exit 1
fi

NODE_WITHDRAW_AUTHORITY=`solana ${SOLANA_CLUSTER} vote-account ${YOUR_VOTE_ACCOUNT} | grep 'Withdraw' | awk '{print $NF}'`


#echo -e "This Node: $THIS_SOLANA_ADRESS | $YOUR_VOTE_ACCOUNT ${NOCOLOR}"


ALL_MY_STAKES=`solana ${SOLANA_CLUSTER} stakes ${YOUR_VOTE_ACCOUNT}`
while [[ $? != 0 ]]; do
	ALL_MY_STAKES=`solana ${SOLANA_CLUSTER} stakes ${YOUR_VOTE_ACCOUNT}`
done

ALL_STAKERS_WITHDRAWERS=`echo "$ALL_MY_STAKES" | grep -E "Withdraw" | sort | uniq | awk -F 'Withdraw Authority: ' '{print $2}'`

echo -e "${DARKGRAY}All Stakers of $YOUR_VOTE_ACCOUNT | Epoch ${THIS_EPOCH} ${CLUSTER_NAME}${NOCOLOR}"


#old_see_stake_function $ALL_STAKERS_WITHDRAWERS


echo -e "—————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"

echo -e "${UNDERLINE}Withdraw Authority\t\t\t\tCount\t${LIGHTPURPLE}${UNDERLINE}Info\t\t${CYAN}${UNDERLINE}Active Stake\t${RED}${UNDERLINE}Deactivating\t${GREEN}${UNDERLINE}Activating${NOCOLOR}"

for i in $ALL_STAKERS_WITHDRAWERS; do
	echo -e $i "\t"`echo "$ALL_MY_STAKES" | grep -B7 -E $i | grep 'Active Stake' | sed 's/Active Stake: //g' | sed 's/ SOL//g' | wc -l`"\t${LIGHTPURPLE}"`check_key $i`"\t${CYAN}"`echo "$ALL_MY_STAKES" | grep -B7 -E $i | grep 'Active Stake' | sed 's/Active Stake: //g' | sed 's/ SOL//g' | bc | awk '{n+=0+$1+0}; END{print 0+n+0}' | sed -r 's/^(.{7}).+$/\1/'`"\t\t${RED}"`echo "$ALL_MY_STAKES" | grep -B7 -E $i | grep -B1 -i 'deactivates' | grep 'Active Stake' | sed 's/Active Stake: //g' | sed 's/ SOL//g' | bc | awk '{n+=0+$1+0}; END{print 0+n+0}' | sed -r 's/^(.{7}).+$/\1/'`"\t\t${GREEN}"`echo "$ALL_MY_STAKES" | grep -B7 -E $i | grep 'Activating Stake' | sed 's/Activating Stake: //g' | sed 's/ SOL//g' | bc | awk '{n+=0+$1+0}; END{print 0+n+0}' | sed -r 's/^(.{7}).+$/\1/'`"${NOCOLOR}";
done

TOTAL_ACTIVE_STAKE=`echo -e "${ALL_MY_STAKES}" | grep 'Active Stake' | sed 's/Active Stake: //g' | sed 's/ SOL//g' | bc | awk '{n += $1}; END{print n}' | bc`
TOTAL_STAKE_COUNT=`echo -e "${ALL_MY_STAKES}" | grep 'Active Stake' | sed 's/Active Stake: //g' | sed 's/ SOL//g' | bc | wc -l`

ACTIVATING_STAKE=`echo -e "${ALL_MY_STAKES}" | grep 'Activating Stake: ' | sed 's/Activating Stake: //g' | sed 's/ SOL//g' | bc | awk '{n += $1}; END{print n}' | bc | sed -r 's/^(.{7}).+$/\1/'`
ACTIVATING_STAKE_COUNT=`echo -e "${ALL_MY_STAKES}" | grep 'Activating Stake: ' | sed 's/Activating Stake: //g' | sed 's/ SOL//g' | bc | wc -l`

DEACTIVATING_STAKE=`echo -e "${ALL_MY_STAKES}" | grep -B1 -i 'deactivates' | grep 'Active Stake' | sed 's/Active Stake: //g' | sed 's/ SOL//g' | bc | awk '{n += $1}; END{print n}' | bc | sed -r 's/^(.{7}).+$/\1/'`
DEACTIVATING_STAKE_COUNT=`echo -e "${ALL_MY_STAKES}" | grep -B1 -i 'deactivates' | grep 'Active Stake' | sed 's/Active Stake: //g' | sed 's/ SOL//g' | bc | wc -l`

TOTAL_ACTIVE_STAKE_COUNT=`echo "${TOTAL_STAKE_COUNT:-0} ${ACTIVATING_STAKE_COUNT:-0}" | awk '{print $1 - $2}' | bc`

echo -e "—————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————"
echo -e "${UNDERLINE}TOTAL:\t\t\t\t\t\t${TOTAL_ACTIVE_STAKE_COUNT}\t${LIGHTPURPLE}${UNDERLINE}\t\t${CYAN}${UNDERLINE}${TOTAL_ACTIVE_STAKE:-0}\t\t${RED}${UNDERLINE}${DEACTIVATING_STAKE:-0}\t\t${GREEN}${UNDERLINE}${ACTIVATING_STAKE:-0}${NOCOLOR}"


echo -e "${NOCOLOR}"

popd > /dev/null || exit 1