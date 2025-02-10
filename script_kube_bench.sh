#!/bin/bash

# Step 1: Run docker-bench-security.sh and print the output to a text file
cd /root/kube-bench/kube-bench
./kube-bench > /root/script/kube-bench-output.txt

# Step 2: Print main points of the output and add user input to select a specific point
echo $'\n'"Select a point to view warnings:"$'\n'
echo "1 - Control Plane Security Configuration"
echo "2 - Etcd Node Configuration"
echo "3 - Control Plane Configuration"
echo "4 - Worker Node Security Configuration"
echo "5 - Kubernetes Policies"$'\n'
read -p "Enter the number of the section you want to view: " section

if [ "$section" -eq 1 ]; then
	cat /root/script/kube-bench-output.txt | awk '/== Summary master ==/,/2 Etcd Node Configuration/' > /root/script/summary.txt
	cat /root/script/kube-bench-output.txt | awk '/== Remediations master ==/,/== Summary master ==/' > /root/script/remediation.txt
	cat /root/script/kube-bench-output.txt | grep -E 'FAIL.* 1\.|WARN.* 1\.' | awk -F ' ' '{print $2}' > /root/script/remediation_number.txt
	echo "== Summary master ==" >> /root/script/remediation_number.txt
	echo $'\n'"Summary for Control Plane Security Configuration:"
	cat /root/script/summary.txt | grep FAIL
	cat /root/script/summary.txt | grep WARN
	read -p $'\n'"Select the issue category (FAIL/WARN) :- " category
	
	if [ "$category" == "FAIL" ]; then
		echo $'\n'"Failure points of Control Plane Security Configuration :- "$'\n'
		grep 'FAIL.* 1\.' /root/script/kube-bench-output.txt
		grep 'FAIL.* 1\.' /root/script/kube-bench-output.txt > /root/script/number.txt
		num1=$(cat /root/script/number.txt | wc -l)
		
		echo $'\n'"Remediation Steps for Control Plane Security Configuration Failures :-"$'\n'
		for (( n=1; n<=$num1; n++ )); do
			num2=$(cat /root/script/number.txt | awk 'NR == '$n'' | awk -F ' ' '{print $2}')
			num3=$(cat /root/script/remediation_number.txt | awk -v num=$num2 '$0 == num {getline; print $0}')
			cat /root/script/remediation.txt | awk "/(^)$num2([^0-9]|$)/,/(^)$num3([^0-9]|$)/" | head -n -1
			echo # Blank line for readability
		done

	elif [ "$category" == "WARN" ]; then
		echo $'\n'"Warning points of Control Plane Security Configuration :- "$'\n'
                grep 'WARN.* 1\.' /root/script/kube-bench-output.txt
                grep 'WARN.* 1\.' /root/script/kube-bench-output.txt > /root/script/number.txt
                num1=$(cat /root/script/number.txt | wc -l)

                echo $'\n'"Remediation Steps for Control Plane Security Configuration Warnings :-"$'\n'
                for (( n=1; n<=$num1; n++ )); do
                        num2=$(cat /root/script/number.txt | awk 'NR == '$n'' | awk -F ' ' '{print $2}')
                        num3=$(cat /root/script/remediation_number.txt | awk -v num=$num2 '$0 == num {getline; print $0}')
			cat /root/script/remediation.txt | awk "/(^)$num2([^0-9]|$)/,/(^)$num3([^0-9]|$)/" | head -n -1
                        echo # Blank line for readability
                done
	fi


elif [ "$section" -eq 2 ]; then
        cat /root/script/kube-bench-output.txt | awk '/== Summary etcd ==/,/3 Control Plane Configuration/' > /root/script/summary.txt
        cat /root/script/kube-bench-output.txt | awk '/== Remediations etcd ==/,/== Summary etcd ==/' > /root/script/remediation.txt
        cat /root/script/kube-bench-output.txt | grep -E 'FAIL.* 2\.|WARN.* 2\.' | awk -F ' ' '{print $2}' > /root/script/remediation_number.txt
        echo "== Summary etcd ==" >> /root/script/remediation_number.txt
        echo $'\n'"Summary for Etcd Node Configuration:"
        cat /root/script/summary.txt | grep FAIL
        cat /root/script/summary.txt | grep WARN
        read -p $'\n'"Select the issue category (FAIL/WARN) :- " category

        if [ "$category" == "FAIL" ]; then
                echo $'\n'"Failure points of Etcd Node Configuration :- "$'\n'
                grep 'FAIL.* 2\.' /root/script/kube-bench-output.txt
                grep 'FAIL.* 2\.' /root/script/kube-bench-output.txt > /root/script/number.txt
                num1=$(cat /root/script/number.txt | wc -l)

                echo $'\n'"Remediation Steps for Etcd Node Configuration Failures :-"$'\n'
                for (( n=1; n<=$num1; n++ )); do
                        num2=$(cat /root/script/number.txt | awk 'NR == '$n'' | awk -F ' ' '{print $2}')
                        num3=$(cat /root/script/remediation_number.txt | awk -v num=$num2 '$0 == num {getline; print $0}')
                        cat /root/script/remediation.txt | awk "/(^)$num2([^0-9]|$)/,/(^)$num3([^0-9]|$)/" | head -n -1
                        echo # Blank line for readability
                done

        elif [ "$category" == "WARN" ]; then
                echo $'\n'"Warning points of Etcd Node Configuration :- "$'\n'
                grep 'WARN.* 2\.' /root/script/kube-bench-output.txt
                grep 'WARN.* 2\.' /root/script/kube-bench-output.txt > /root/script/number.txt
                num1=$(cat /root/script/number.txt | wc -l)

                echo $'\n'"Remediation Steps for Etcd Node Configuration Warnings :-"$'\n'
                for (( n=1; n<=$num1; n++ )); do
                        num2=$(cat /root/script/number.txt | awk 'NR == '$n'' | awk -F ' ' '{print $2}')
                        num3=$(cat /root/script/remediation_number.txt | awk -v num=$num2 '$0 == num {getline; print $0}')
                        cat /root/script/remediation.txt | awk "/(^)$num2([^0-9]|$)/,/(^)$num3([^0-9]|$)/" | head -n -1
                        echo # Blank line for readability
                done
        fi


elif [ "$section" -eq 3 ]; then
        cat /root/script/kube-bench-output.txt | awk '/== Summary controlplane ==/,/4 Worker Node Security Configuration/' > /root/script/summary.txt
        cat /root/script/kube-bench-output.txt | awk '/== Remediations controlplane ==/,/== Summary controlplane ==/' > /root/script/remediation.txt
        cat /root/script/kube-bench-output.txt | grep -E 'FAIL.* 3\.|WARN.* 3\.' | awk -F ' ' '{print $2}' > /root/script/remediation_number.txt
        echo "== Summary controlplane ==" >> /root/script/remediation_number.txt
        echo $'\n'"Summary for Control Plane Configuration :"
        cat /root/script/summary.txt | grep FAIL
        cat /root/script/summary.txt | grep WARN
        read -p $'\n'"Select the issue category (FAIL/WARN) :- " category

        if [ "$category" == "FAIL" ]; then
                echo $'\n'"Failure points of Control Plane Configuration :- "$'\n'
                grep 'FAIL.* 3\.' /root/script/kube-bench-output.txt
                grep 'FAIL.* 3\.' /root/script/kube-bench-output.txt > /root/script/number.txt
                num1=$(cat /root/script/number.txt | wc -l)

                echo $'\n'"Remediation Steps for Control Plane Configuration Failures :-"$'\n'
                for (( n=1; n<=$num1; n++ )); do
                        num2=$(cat /root/script/number.txt | awk 'NR == '$n'' | awk -F ' ' '{print $2}')
                        num3=$(cat /root/script/remediation_number.txt | awk -v num=$num2 '$0 == num {getline; print $0}')
                        cat /root/script/remediation.txt | awk "/(^)$num2([^0-9]|$)/,/(^)$num3([^0-9]|$)/" | head -n -1
                        echo # Blank line for readability
                done

        elif [ "$category" == "WARN" ]; then
                echo $'\n'"Warning points of Control Plane Configuration :- "$'\n'
                grep 'WARN.* 3\.' /root/script/kube-bench-output.txt
                grep 'WARN.* 3\.' /root/script/kube-bench-output.txt > /root/script/number.txt
                num1=$(cat /root/script/number.txt | wc -l)

                echo $'\n'"Remediation Steps for Control Plane Configuration Warnings :-"$'\n'
                for (( n=1; n<=$num1; n++ )); do
                        num2=$(cat /root/script/number.txt | awk 'NR == '$n'' | awk -F ' ' '{print $2}')
                        num3=$(cat /root/script/remediation_number.txt | awk -v num=$num2 '$0 == num {getline; print $0}')
                        cat /root/script/remediation.txt | awk "/(^)$num2([^0-9]|$)/,/(^)$num3([^0-9]|$)/" | head -n -1
                        echo # Blank line for readability
                done
        fi


elif [ "$section" -eq 4 ]; then
        cat /root/script/kube-bench-output.txt | awk '/== Summary node ==/,/5 Kubernetes Policies/' > /root/script/summary.txt
        cat /root/script/kube-bench-output.txt | awk '/== Remediations node ==/,/== Summary node ==/' > /root/script/remediation.txt
        cat /root/script/kube-bench-output.txt | grep -E 'FAIL.* 4\.|WARN.* 4\.' | awk -F ' ' '{print $2}' > /root/script/remediation_number.txt
        echo "== Summary node ==" >> /root/script/remediation_number.txt
        echo $'\n'"Summary for Worker Node Security Configuration :"
        cat /root/script/summary.txt | grep FAIL
        cat /root/script/summary.txt | grep WARN
        read -p $'\n'"Select the issue category (FAIL/WARN) :- " category

        if [ "$category" == "FAIL" ]; then
                echo $'\n'"Failure points of Worker Node Security Configuration :- "$'\n'
                grep 'FAIL.* 4\.' /root/script/kube-bench-output.txt
                grep 'FAIL.* 4\.' /root/script/kube-bench-output.txt > /root/script/number.txt
                num1=$(cat /root/script/number.txt | wc -l)

                echo $'\n'"Remediation Steps for Worker Node Security Configuration Failures :-"$'\n'
                for (( n=1; n<=$num1; n++ )); do
                        num2=$(cat /root/script/number.txt | awk 'NR == '$n'' | awk -F ' ' '{print $2}')
                        num3=$(cat /root/script/remediation_number.txt | awk -v num=$num2 '$0 == num {getline; print $0}')
                        cat /root/script/remediation.txt | awk "/(^)$num2([^0-9]|$)/,/(^)$num3([^0-9]|$)/" | head -n -1
                        echo # Blank line for readability
                done

        elif [ "$category" == "WARN" ]; then
                echo $'\n'"Warning points of Worker Node Security Configuration :- "$'\n'
                grep 'WARN.* 4\.' /root/script/kube-bench-output.txt
                grep 'WARN.* 4\.' /root/script/kube-bench-output.txt > /root/script/number.txt
                num1=$(cat /root/script/number.txt | wc -l)

                echo $'\n'"Remediation Steps for Worker Node Security Configuration Warnings :-"$'\n'
                for (( n=1; n<=$num1; n++ )); do
                        num2=$(cat /root/script/number.txt | awk 'NR == '$n'' | awk -F ' ' '{print $2}')
                        num3=$(cat /root/script/remediation_number.txt | awk -v num=$num2 '$0 == num {getline; print $0}')
                        cat /root/script/remediation.txt | awk "/(^)$num2([^0-9]|$)/,/(^)$num3([^0-9]|$)/" | head -n -1
                        echo # Blank line for readability
                done
        fi

elif [ "$section" -eq 5 ]; then
        cat /root/script/kube-bench-output.txt | awk '/== Summary policies ==/,/== Summary total ==/' > /root/script/summary.txt
        cat /root/script/kube-bench-output.txt | awk '/== Remediations policies ==/,/== Summary policies ==/' > /root/script/remediation.txt
        cat /root/script/kube-bench-output.txt | grep -E 'FAIL.* 5\.|WARN.* 5\.' | awk -F ' ' '{print $2}' > /root/script/remediation_number.txt
        echo "== Summary policies ==" >> /root/script/remediation_number.txt
        echo $'\n'"Summary for Kubernetes Policies :"
        cat /root/script/summary.txt | grep FAIL
        cat /root/script/summary.txt | grep WARN
        read -p $'\n'"Select the issue category (FAIL/WARN) :- " category

        if [ "$category" == "FAIL" ]; then
                echo $'\n'"Failure points of Kubernetes Policies :- "$'\n'
                grep 'FAIL.* 5\.' /root/script/kube-bench-output.txt
                grep 'FAIL.* 5\.' /root/script/kube-bench-output.txt > /root/script/number.txt
                num1=$(cat /root/script/number.txt | wc -l)

                echo $'\n'"Remediation Steps for Kubernetes Policy Failures :-"$'\n'
                for (( n=1; n<=$num1; n++ )); do
                        num2=$(cat /root/script/number.txt | awk 'NR == '$n'' | awk -F ' ' '{print $2}')
                        num3=$(cat /root/script/remediation_number.txt | awk -v num=$num2 '$0 == num {getline; print $0}')
                        cat /root/script/remediation.txt | awk "/(^)$num2([^0-9]|$)/,/(^)$num3([^0-9]|$)/" | head -n -1
                        echo # Blank line for readability
                done

        elif [ "$category" == "WARN" ]; then
                echo $'\n'"Warning points of Kubernetes Policies :- "$'\n'
                grep 'WARN.* 5\.' /root/script/kube-bench-output.txt
                grep 'WARN.* 5\.' /root/script/kube-bench-output.txt > /root/script/number.txt
                num1=$(cat /root/script/number.txt | wc -l)

                echo $'\n'"Remediation Steps for Kubernetes Policy Warnings :-"$'\n'
                for (( n=1; n<=$num1; n++ )); do
                        num2=$(cat /root/script/number.txt | awk 'NR == '$n'' | awk -F ' ' '{print $2}')
                        num3=$(cat /root/script/remediation_number.txt | awk -v num=$num2 '$0 == num {getline; print $0}')
                        cat /root/script/remediation.txt | awk "/(^)$num2([^0-9]|$)/,/(^)$num3([^0-9]|$)/" | head -n -1
                        echo # Blank line for readability
                done
        fi

fi
