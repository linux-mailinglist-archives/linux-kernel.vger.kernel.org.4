Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41310610B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiJ1HnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJ1HnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:43:19 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3431BF221
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:43:17 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b29so4127528pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B4lOgmCxrqFtkDOfo6b8AQjkjlN8/gAOu5VYBEUch9Q=;
        b=K+9j7grmJ8By2MPEyc9BXZpgVwf4X6i1KQPtlSyoG3Oi0HIUSmXnJEM1+3srtIjPyr
         Y2X1cX09lFsMjJ41PFuuWhqM9rCCNhxG65irFqUIsNgcBckxRlHSNtwbe3yGPvxwMMD/
         0fIuwQTi0o2NF1ov+GhRvF1HpuoQBEiwW0xDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4lOgmCxrqFtkDOfo6b8AQjkjlN8/gAOu5VYBEUch9Q=;
        b=zkKh6hESelji7Ra9yXF3j1Hkumfvt42AhMClwknOOPLHHtzMvH0TM3lCMeIpxdjHyE
         1MLwKr1xhVMb+/enP9zc8j4d7MWlAY0mwCG1CYdRTc3dw9iyidGB+nB5ypvWKAoNWz9Z
         G9FGYPlDeEUHmCMx4YddC7J45H6eFmQt1v8CZeJEvNgddf6CEFPO6R9btvg2HkPv5DPD
         ngnf4CR7CJenR57DEL2rVJ5Rp81grngnaN5/8EKF6V3XBF1Xbrcv50Jm5D7rGKmsfb7Z
         6rTxdb+wLd01TuJQaRobKiWq8PQdsH6gZAdvz8zjw4cxlDaumgGh7FWpIwu1EDPI8ULh
         3uyw==
X-Gm-Message-State: ACrzQf2+ehc7jUqH6hl57p6o1BerxqYQp7kjHnS2ywA2FoQVRNQd9Xx9
        Ne2nNtJnpFz40I54r02+76b24A==
X-Google-Smtp-Source: AMsMyM61fMllscuv40cci0faYHVjDAmFnS2SAIYbCCetOhNKwpSlDqviC+QQ+gidq1+Ct08s/P/65g==
X-Received: by 2002:a05:6a00:234d:b0:561:ec04:e77e with SMTP id j13-20020a056a00234d00b00561ec04e77emr53888087pfj.14.1666942996855;
        Fri, 28 Oct 2022 00:43:16 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id lk14-20020a17090b33ce00b00205f013f275sm3681403pjb.22.2022.10.28.00.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 00:43:16 -0700 (PDT)
Message-ID: <8edb940a-964d-5c17-b6ec-de392c432121@linuxfoundation.org>
Date:   Fri, 28 Oct 2022 01:43:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V4 2/4] selftests: amd-pstate: Trigger tbench benchmark
 and test cpus
Content-Language: en-US
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221024013356.1639489-1-li.meng@amd.com>
 <20221024013356.1639489-3-li.meng@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221024013356.1639489-3-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/22 19:33, Meng Li wrote:
> Add tbench.sh trigger the tbench testing and monitor the cpu desire
> performance, frequency, load, power consumption and throughput etc.

Does tbench.sh do the following? If so please state it clearly in the
chanelog.

> 1) Download and install tbench codes.
> 2) Run tbench benchmark on specific governors, ondemand or schedutil.
> 3) Run tbench benchmark comparative test on acpi-cpufreq kernel driver.
> 4) Get desire performance, frequency, load by perf.
> 5) Get power consumption and throughput by amd_pstate_trace.py.
> 6) Analyse test results and save it in file selftest.tbench.csv.
> 7) Plot png images about performance, energy and performance per watt
> for each test.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>   tools/testing/selftests/amd-pstate/Makefile  |  10 +-
>   tools/testing/selftests/amd-pstate/run.sh    | 243 +++++++++++++-
>   tools/testing/selftests/amd-pstate/tbench.sh | 334 +++++++++++++++++++
>   3 files changed, 577 insertions(+), 10 deletions(-)
>   create mode 100755 tools/testing/selftests/amd-pstate/tbench.sh
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 6f4c7b01e3bb..cac8dedb7226 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -4,7 +4,15 @@
>   # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>   all:
>   
> +uname_M := $(shell uname -m 2>/dev/null || echo not)
> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> +
> +ifeq (x86,$(ARCH))
> +TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +endif
> +
>   TEST_PROGS := run.sh
> -TEST_FILES := basic.sh
> +TEST_FILES := basic.sh tbench.sh
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
> index 715e9d01484f..dea61e4443fc 100755
> --- a/tools/testing/selftests/amd-pstate/run.sh
> +++ b/tools/testing/selftests/amd-pstate/run.sh
> @@ -9,6 +9,7 @@ else
>   fi
>   
>   source basic.sh
> +source tbench.sh
>   
>   # amd-pstate-ut only run on x86/x86_64 AMD systems.
>   ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> @@ -16,9 +17,98 @@ VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
>   
>   FUNC=all
>   OUTFILE=selftest
> +OUTFILE_TBENCH="$OUTFILE.tbench"
> +
> +SYSFS=
> +CPUROOT=
> +CPUFREQROOT=
> +MAKE_CPUS=
> +
> +TIME_LIMIT=100
> +PROCESS_NUM=128
> +LOOP_TIMES=3
> +TRACER_INTERVAL=10
> +CURRENT_TEST=amd-pstate
> +COMPARATIVE_TEST=
>   
>   # Kselftest framework requirement - SKIP code is 4.
>   ksft_skip=4
> +all_scaling_names=("acpi-cpufreq" "amd-pstate")
> +
> +# Get current cpufreq scaling driver name
> +scaling_name()
> +{
> +	if [ "$COMPARATIVE_TEST" = "" ]; then
> +		echo "$CURRENT_TEST"
> +	else
> +		echo "$COMPARATIVE_TEST"
> +	fi
> +}
> +
> +# Counts CPUs with cpufreq directories
> +count_cpus()
> +{
> +	count=0;
> +
> +	for cpu in `ls $CPUROOT | grep "cpu[0-9].*"`; do
> +		if [ -d $CPUROOT/$cpu/cpufreq ]; then
> +			let count=count+1;
> +		fi
> +	done
> +
> +	echo $count;
> +}
> +
> +# $1: policy
> +find_current_governor()
> +{
> +	cat $CPUFREQROOT/$1/scaling_governor
> +}
> +
> +backup_governor()
> +{
> +	policies=$(ls $CPUFREQROOT| grep "policy[0-9].*")
> +	for policy in $policies; do
> +		cur_gov=$(find_current_governor $policy)
> +		echo "$policy $cur_gov" >> $OUTFILE.backup_governor.log
> +	done
> +
> +	printf "Governor $cur_gov backup done.\n"
> +}
> +
> +restore_governor()
> +{
> +	i=0;
> +
> +	policies=$(awk '{print $1}' $OUTFILE.backup_governor.log)
> +	for policy in $policies; do
> +		let i++;
> +		governor=$(sed -n ''$i'p' $OUTFILE.backup_governor.log | awk '{print $2}')
> +
> +		# switch governor
> +		echo $governor > $CPUFREQROOT/$policy/scaling_governor
> +	done
> +
> +	printf "Governor restored to $governor.\n"
> +}
> +
> +# $1: governor
> +switch_governor()
> +{
> +	policies=$(ls $CPUFREQROOT| grep "policy[0-9].*")
> +	for policy in $policies; do
> +		filepath=$CPUFREQROOT/$policy/scaling_available_governors
> +
> +		# Exit if cpu isn't managed by cpufreq core
> +		if [ ! -f $filepath ]; then
> +			return;
> +		fi
> +
> +		echo $1 > $CPUFREQROOT/$policy/scaling_governor
> +	done
> +
> +	printf "Switched governor to $1.\n"
> +}
>   
>   # All amd-pstate tests
>   amd_pstate_all()
> @@ -27,8 +117,19 @@ amd_pstate_all()
>   	printf "***** Running AMD P-state Sanity Tests  *****\n"
>   	printf "=============================================\n\n"
>   
> +	count=$(count_cpus)
> +	if [ $count = 0 ]; then
> +		printf "No cpu is managed by cpufreq core, exiting\n"
> +		exit;
> +	else
> +		printf "AMD P-state manages: $count CPUs\n"
> +	fi
> +
>   	# unit test for amd-pstate kernel driver
>   	amd_pstate_basic
> +
> +	# tbench
> +	amd_pstate_tbench
>   }
>   
>   helpme()
Change this to help() which is standard way to name this routine.

> @@ -37,21 +138,27 @@ helpme()
>   	[-h <help>]
>   	[-o <output-file-for-dump>]
>   	[-c <all: All testing,
> -	     basic: Basic testing.>]
> +	     basic: Basic testing,
> +	     tbench: Tbench testing.>]
> +	[-t <tbench time limit>]
> +	[-p <tbench process number>]
> +	[-l <loop times for tbench>]
> +	[-i <amd tracer interval>]
> +	[-m <comparative test: acpi-cpufreq>]
>   	\n"
>   	exit 2
>   }
>   
>   parse_arguments()
>   {
> -	while getopts ho:c: arg
> +	while getopts ho:c:t:p:l:i:m: arg
>   	do
>   		case $arg in
>   			h) # --help
>   				helpme

Same here.

>   				;;
>   
> -			c) # --func_type (Function to perform: basic (default: all))
> +			c) # --func_type (Function to perform: basic, tbench (default: all))
>   				FUNC=$OPTARG
>   				;;
>   
> @@ -59,6 +166,26 @@ parse_arguments()
>   				OUTFILE=$OPTARG
>   				;;
>   
> +			t) # --tbench-time-limit
> +				TIME_LIMIT=$OPTARG
> +				;;
> +
> +			p) # --tbench-process-number
> +				PROCESS_NUM=$OPTARG
> +				;;
> +
> +			l) # --tbench-loop-times
> +				LOOP_TIMES=$OPTARG
> +				;;
> +
> +			i) # --amd-tracer-interval
> +				TRACER_INTERVAL=$OPTARG
> +				;;
> +
> +			m) # --comparative-test
> +				COMPARATIVE_TEST=$OPTARG
> +				;;
> +
>   			*)
>   				helpme

Same here

>   				;;
> @@ -66,6 +193,32 @@ parse_arguments()
>   	done
>   }
>   
> +command_perf()
> +{
> +	if ! command -v perf > /dev/null; then
> +		echo $msg please install perf. >&2
> +		exit $ksft_skip
> +	fi
> +}
> +
> +command_tbench()
> +{
> +	if ! command -v tbench > /dev/null; then
> +		if apt policy dbench > /dev/null 2>&1; then
> +			printf "Install dbench, please wait a moment ...\n"
> +			sudo apt install dbench > /dev/null 2>&1
> +		elif yum list available | grep dbench > /dev/null 2>&1; then
> +			printf "Install dbench, please wait a moment ...\n"
> +			sudo yum install dbench > /dev/null 2>&1

This install requires user interaction. Do you expect this to work in kernel ci
type environment?

> +		fi
> +	fi
> +
> +	if ! command -v tbench > /dev/null; then
> +		echo $msg please install tbench. >&2
> +		exit $ksft_skip
> +	fi
> +}
> +
>   prerequisite()
>   {
>   	if ! echo "$ARCH" | grep -q x86; then
> @@ -80,11 +233,29 @@ prerequisite()
>   	fi
>   
>   	scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
> -	if [ "$scaling_driver" != "amd-pstate" ]; then
> -		echo "$0 # Skipped: Test can only run on amd-pstate driver."
> -		echo "$0 # Please set X86_AMD_PSTATE enabled."
> -		echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
> -		exit $ksft_skip
> +	if [ "$COMPARATIVE_TEST" = "" ]; then
> +		if [ "$scaling_driver" != "$CURRENT_TEST" ]; then
> +			echo "$0 # Skipped: Test can only run on $CURRENT_TEST driver or run comparative test."
> +			echo "$0 # Please set X86_AMD_PSTATE enabled or run comparative test."
> +			echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
> +			exit $ksft_skip
> +		fi
> +	else
> +		case "$FUNC" in
> +			"tbench")
> +				if [ "$scaling_driver" != "$COMPARATIVE_TEST" ]; then
> +					echo "$0 # Skipped: Comparison test can only run on $COMPARATIVE_TEST driver."
> +					echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
> +					exit $ksft_skip
> +				fi
> +				;;
> +
> +			*)
> +				echo "$0 # Skipped: Comparison test are only for tbench."
> +				echo "$0 # Current comparative test is for $FUNC."
> +				exit $ksft_skip
> +				;;
> +		esac
>   	fi
>   
>   	msg="Skip all tests:"
> @@ -92,10 +263,51 @@ prerequisite()
>   		echo $msg please run this as root >&2
>   		exit $ksft_skip
>   	fi
> +
> +	case "$FUNC" in
> +		"all")
> +			command_perf
> +			command_tbench
> +			;;
> +
> +		"tbench")
> +			command_perf
> +			command_tbench
> +			;;
> +	esac
> +
> +	SYSFS=`mount -t sysfs | head -1 | awk '{ print $3 }'`
> +
> +	if [ ! -d "$SYSFS" ]; then
> +		echo $msg sysfs is not mounted >&2
> +		exit 2
> +	fi
> +
> +	CPUROOT=$SYSFS/devices/system/cpu
> +	CPUFREQROOT="$CPUROOT/cpufreq"
> +
> +	if ! ls $CPUROOT/cpu* > /dev/null 2>&1; then
> +		echo $msg cpus not available in sysfs >&2
> +		exit 2
> +	fi
> +
> +	if ! ls $CPUROOT/cpufreq > /dev/null 2>&1; then
> +		echo $msg cpufreq directory not available in sysfs >&2
> +		exit 2
> +	fi
>   }
>   
>   do_test()
>   {
> +	# Check if CPUs are managed by cpufreq or not
> +	count=$(count_cpus)
> +	MAKE_CPUS=$((count*2))
> +
> +	if [ $count = 0 ]; then
> +		echo "No cpu is managed by cpufreq core, exiting"
> +		exit 2;
> +	fi
> +
>   	case "$FUNC" in
>   		"all")
>   			amd_pstate_all
> @@ -105,6 +317,10 @@ do_test()
>   			amd_pstate_basic
>   			;;
>   
> +		"tbench")
> +			amd_pstate_tbench
> +			;;
> +
>   		*)
>   			echo "Invalid [-f] function type"
>   			helpme

Here

> @@ -117,7 +333,15 @@ pre_clear_dumps()
>   {
>   	case "$FUNC" in
>   		"all")
> -			rm -rf $OUTFILE*
> +			rm -rf $OUTFILE.log
> +			rm -rf $OUTFILE.backup_governor.log
> +			rm -rf *.png
> +			;;
> +
> +		"tbench")
> +			rm -rf $OUTFILE.log
> +			rm -rf $OUTFILE.backup_governor.log
> +			rm -rf tbench_*.png
>   			;;
>   
>   		*)
> @@ -128,6 +352,7 @@ pre_clear_dumps()
>   post_clear_dumps()
>   {
>   	rm -rf $OUTFILE.log
> +	rm -rf $OUTFILE.backup_governor.log
>   }
>   
>   # Parse arguments
> diff --git a/tools/testing/selftests/amd-pstate/tbench.sh b/tools/testing/selftests/amd-pstate/tbench.sh
> new file mode 100755
> index 000000000000..fd6e28139035
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/tbench.sh
> @@ -0,0 +1,334 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Testing and monitor the cpu frequency and performance when
> +# this script trigger tbench test.
> +
> +# protect against multiple inclusion
> +if [ $FILE_TBENCH ]; then
> +	return 0
> +else
> +	FILE_TBENCH=DONE
> +fi
> +
> +tbench_governors=("ondemand" "schedutil")
> +
> +# $1: governor, $2: round, $3: des-perf, $4: freq, $5: load, $6: performance, $7: energy, $8: performance per watt
> +store_csv_tbench()
> +{
> +	echo "$1, $2, $3, $4, $5, $6, $7, $8" | tee -a $OUTFILE_TBENCH.csv > /dev/null 2>&1
> +}
> +
> +# clear some special lines
> +clear_csv_tbench()
> +{
> +	if [ -f $OUTFILE_TBENCH.csv ]; then
> +		sed -i '/Comprison(%)/d' $OUTFILE_TBENCH.csv
> +		sed -i "/$(scaling_name)/d" $OUTFILE_TBENCH.csv
> +	fi
> +}
> +
> +# find string $1 in file csv and get the number of lines
> +get_lines_csv_tbench()
> +{
> +	if [ -f $OUTFILE_TBENCH.csv ]; then
> +		return `grep -c "$1" $OUTFILE_TBENCH.csv`
> +	else
> +		return 0
> +	fi
> +}
> +
> +pre_clear_tbench()
> +{
> +	post_clear_tbench
> +	rm -rf tbench_*.png
> +	clear_csv_tbench
> +}
> +
> +post_clear_tbench()
> +{
> +	rm -rf results/tracer-tbench*
> +	rm -rf $OUTFILE_TBENCH*.log
> +	rm -rf $OUTFILE_TBENCH*.result
> +
> +}
> +
> +# $1: governor, $2: loop
> +run_tbench()
> +{
> +	echo "Launching amd pstate tracer for $1 #$2 tracer_interval: $TRACER_INTERVAL"
> +	./amd_pstate_trace.py -n tracer-tbench-$1-$2 -i $TRACER_INTERVAL > /dev/null 2>&1 &
> +
> +	printf "Test tbench for $1 #$2 time_limit: $TIME_LIMIT procs_num: $PROCESS_NUM\n"
> +	tbench_srv > /dev/null 2>&1 &
> +	perf stat -a --per-socket -I 1000 -e power/energy-pkg/ tbench -t $TIME_LIMIT $PROCESS_NUM > $OUTFILE_TBENCH-perf-$1-$2.log 2>&1
> +
> +	pid=`pidof tbench_srv`
> +	kill $pid
> +
> +	for job in `jobs -p`
> +	do
> +		echo "Waiting for job id $job"
> +		wait $job
> +	done
> +}
> +
> +# $1: governor, $2: loop
> +parse_tbench()
> +{
> +	awk '{print $5}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-des-perf-$1-$2.log
> +	avg_des_perf=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-des-perf-$1-$2.log)
> +	printf "Tbench-$1-#$2 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	awk '{print $7}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-freq-$1-$2.log
> +	avg_freq=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-freq-$1-$2.log)
> +	printf "Tbench-$1-#$2 avg freq: $avg_freq\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	awk '{print $11}' results/tracer-tbench-$1-$2/cpu.csv | sed -e '1d' | sed s/,// > $OUTFILE_TBENCH-load-$1-$2.log
> +	avg_load=$(awk 'BEGIN {i=0; sum=0};{i++; sum += $1};END {print sum/i}' $OUTFILE_TBENCH-load-$1-$2.log)
> +	printf "Tbench-$1-#$2 avg load: $avg_load\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep Throughput $OUTFILE_TBENCH-perf-$1-$2.log | awk '{print $2}' > $OUTFILE_TBENCH-throughput-$1-$2.log
> +	tp_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-throughput-$1-$2.log)
> +	printf "Tbench-$1-#$2 throughput(MB/s): $tp_sum\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep Joules $OUTFILE_TBENCH-perf-$1-$2.log | awk '{print $4}' > $OUTFILE_TBENCH-energy-$1-$2.log
> +	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1-$2.log)
> +	printf "Tbench-$1-#$2 power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	# Permance is throughput per second, denoted T/t, where T is throught rendered in t seconds.
> +	# It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
> +	# and t is time measured in seconds(s). This means that performance per watt becomes
> +	#       T/t   T/t    T
> +	#       --- = --- = ---
> +	#        P    E/t    E
> +	# with unit given by MB per joule.
> +	ppw=`echo "scale=4;($TIME_LIMIT-1)*$tp_sum/$en_sum" | bc | awk '{printf "%.4f", $0}'`
> +	printf "Tbench-$1-#$2 performance per watt(MB/J): $ppw\n" | tee -a $OUTFILE_TBENCH.result
> +	printf "\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	driver_name=`echo $(scaling_name)`
> +	store_csv_tbench "$driver_name-$1" $2 $avg_des_perf $avg_freq $avg_load $tp_sum $en_sum $ppw
> +}
> +
> +# $1: governor
> +loop_tbench()
> +{
> +	printf "\nTbench total test times is $LOOP_TIMES for $1\n\n"
> +	for i in `seq 1 $LOOP_TIMES`
> +	do
> +		run_tbench $1 $i
> +		parse_tbench $1 $i
> +	done
> +}
> +
> +# $1: governor
> +gather_tbench()
> +{
> +	printf "Tbench test result for $1 (loops:$LOOP_TIMES)" | tee -a $OUTFILE_TBENCH.result
> +	printf "\n--------------------------------------------------\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg des perf:" | awk '{print $NF}' > $OUTFILE_TBENCH-des-perf-$1.log
> +	avg_des_perf=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-des-perf-$1.log)
> +	printf "Tbench-$1 avg des perf: $avg_des_perf\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg freq:" | awk '{print $NF}' > $OUTFILE_TBENCH-freq-$1.log
> +	avg_freq=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-freq-$1.log)
> +	printf "Tbench-$1 avg freq: $avg_freq\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "avg load:" | awk '{print $NF}' > $OUTFILE_TBENCH-load-$1.log
> +	avg_load=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-load-$1.log)
> +	printf "Tbench-$1 avg load: $avg_load\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "throughput(MB/s):" | awk '{print $NF}' > $OUTFILE_TBENCH-throughput-$1.log
> +	tp_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-throughput-$1.log)
> +	printf "Tbench-$1 total throughput(MB/s): $tp_sum\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	avg_tp=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-throughput-$1.log)
> +	printf "Tbench-$1 avg throughput(MB/s): $avg_tp\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	grep "Tbench-$1-#" $OUTFILE_TBENCH.result | grep "power consumption(J):" | awk '{print $NF}' > $OUTFILE_TBENCH-energy-$1.log
> +	en_sum=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum}' $OUTFILE_TBENCH-energy-$1.log)
> +	printf "Tbench-$1 total power consumption(J): $en_sum\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	avg_en=$(awk 'BEGIN {sum=0};{sum += $1};END {print sum/'$LOOP_TIMES'}' $OUTFILE_TBENCH-energy-$1.log)
> +	printf "Tbench-$1 avg power consumption(J): $avg_en\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	# Permance is throughput per second, denoted T/t, where T is throught rendered in t seconds.
> +	# It is well known that P=E/t, where P is power measured in watts(W), E is energy measured in joules(J),
> +	# and t is time measured in seconds(s). This means that performance per watt becomes
> +	#       T/t   T/t    T
> +	#       --- = --- = ---
> +	#        P    E/t    E
> +	# with unit given by MB per joule.
> +	ppw=`echo "scale=4;($TIME_LIMIT-1)*$avg_tp/$avg_en" | bc | awk '{printf "%.4f", $0}'`
> +	printf "Tbench-$1 performance per watt(MB/J): $ppw\n" | tee -a $OUTFILE_TBENCH.result
> +	printf "\n" | tee -a $OUTFILE_TBENCH.result
> +
> +	driver_name=`echo $(scaling_name)`
> +	store_csv_tbench "$driver_name-$1" "Average" $avg_des_perf $avg_freq $avg_load $avg_tp $avg_en $ppw
> +}
> +
> +# $1: base scaling_driver $2: base governor $3: comparative scaling_driver $4: comparative governor
> +__calc_comp_tbench()
> +{
> +	base=`grep "$1-$2" $OUTFILE_TBENCH.csv | grep "Average"`
> +	comp=`grep "$3-$4" $OUTFILE_TBENCH.csv | grep "Average"`
> +
> +	if [ -n "$base" -a -n "$comp" ]; then
> +		printf "\n==================================================\n" | tee -a $OUTFILE_TBENCH.result
> +		printf "Tbench comparison $1-$2 VS $3-$4" | tee -a $OUTFILE_TBENCH.result
> +		printf "\n==================================================\n" | tee -a $OUTFILE_TBENCH.result
> +
> +		# get the base values
> +		des_perf_base=`echo "$base" | awk '{print $3}' | sed s/,//`
> +		freq_base=`echo "$base" | awk '{print $4}' | sed s/,//`
> +		load_base=`echo "$base" | awk '{print $5}' | sed s/,//`
> +		perf_base=`echo "$base" | awk '{print $6}' | sed s/,//`
> +		energy_base=`echo "$base" | awk '{print $7}' | sed s/,//`
> +		ppw_base=`echo "$base" | awk '{print $8}' | sed s/,//`
> +
> +		# get the comparative values
> +		des_perf_comp=`echo "$comp" | awk '{print $3}' | sed s/,//`
> +		freq_comp=`echo "$comp" | awk '{print $4}' | sed s/,//`
> +		load_comp=`echo "$comp" | awk '{print $5}' | sed s/,//`
> +		perf_comp=`echo "$comp" | awk '{print $6}' | sed s/,//`
> +		energy_comp=`echo "$comp" | awk '{print $7}' | sed s/,//`
> +		ppw_comp=`echo "$comp" | awk '{print $8}' | sed s/,//`
> +
> +		# compare the base and comp values
> +		des_perf_drop=`echo "scale=4;($des_perf_comp-$des_perf_base)*100/$des_perf_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Tbench-$1 des perf base: $des_perf_base comprison: $des_perf_comp percent: $des_perf_drop\n" | tee -a $OUTFILE_TBENCH.result
> +
> +		freq_drop=`echo "scale=4;($freq_comp-$freq_base)*100/$freq_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Tbench-$1 freq base: $freq_base comprison: $freq_comp percent: $freq_drop\n" | tee -a $OUTFILE_TBENCH.result
> +
> +		load_drop=`echo "scale=4;($load_comp-$load_base)*100/$load_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Tbench-$1 load base: $load_base comprison: $load_comp percent: $load_drop\n" | tee -a $OUTFILE_TBENCH.result
> +
> +		perf_drop=`echo "scale=4;($perf_comp-$perf_base)*100/$perf_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Tbench-$1 perf base: $perf_base comprison: $perf_comp percent: $perf_drop\n" | tee -a $OUTFILE_TBENCH.result
> +
> +		energy_drop=`echo "scale=4;($energy_comp-$energy_base)*100/$energy_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Tbench-$1 energy base: $energy_base comprison: $energy_comp percent: $energy_drop\n" | tee -a $OUTFILE_TBENCH.result
> +
> +		ppw_drop=`echo "scale=4;($ppw_comp-$ppw_base)*100/$ppw_base" | bc | awk '{printf "%.4f", $0}'`
> +		printf "Tbench-$1 performance per watt base: $ppw_base comprison: $ppw_comp percent: $ppw_drop\n" | tee -a $OUTFILE_TBENCH.result
> +		printf "\n" | tee -a $OUTFILE_TBENCH.result
> +
> +		store_csv_tbench "$1-$2 VS $3-$4" "Comprison(%)" "$des_perf_drop" "$freq_drop" "$load_drop" "$perf_drop" "$energy_drop" "$ppw_drop"
> +	fi
> +}
> +
> +# calculate the comparison(%)
> +calc_comp_tbench()
> +{
> +	# acpi-cpufreq-ondemand VS acpi-cpufreq-schedutil
> +	__calc_comp_tbench ${all_scaling_names[0]} ${tbench_governors[0]} ${all_scaling_names[0]} ${tbench_governors[1]}
> +
> +	# amd-pstate-ondemand VS amd-pstate-schedutil
> +	__calc_comp_tbench ${all_scaling_names[1]} ${tbench_governors[0]} ${all_scaling_names[1]} ${tbench_governors[1]}
> +
> +	# acpi-cpufreq-ondemand VS amd-pstate-ondemand
> +	__calc_comp_tbench ${all_scaling_names[0]} ${tbench_governors[0]} ${all_scaling_names[1]} ${tbench_governors[0]}
> +
> +	# acpi-cpufreq-schedutil VS amd-pstate-schedutil
> +	__calc_comp_tbench ${all_scaling_names[0]} ${tbench_governors[1]} ${all_scaling_names[1]} ${tbench_governors[1]}
> +}
> +
> +# $1: file_name, $2: title, $3: ylable, $4: column
> +plot_png_tbench()
> +{
> +	# all_scaling_names[1] all_scaling_names[0] flag
> +	#    amd-pstate           acpi-cpufreq
> +	#         N                   N             0
> +	#         N                   Y             1
> +	#         Y                   N             2
> +	#         Y                   Y             3
> +	ret=`grep -c "${all_scaling_names[1]}" $OUTFILE_TBENCH.csv`
> +	if [ $ret -eq 0 ]; then
> +		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_TBENCH.csv`
> +		if [ $ret -eq 0 ]; then
> +			flag=0
> +		else
> +			flag=1
> +		fi
> +	else
> +		ret=`grep -c "${all_scaling_names[0]}" $OUTFILE_TBENCH.csv`
> +		if [ $ret -eq 0 ]; then
> +			flag=2
> +		else
> +			flag=3
> +		fi
> +	fi
> +
> +	gnuplot << EOF
> +		set term png
> +		set output "$1"
> +
> +		set title "$2"
> +		set xlabel "Test Cycles (round)"
> +		set ylabel "$3"
> +
> +		set grid
> +		set style data histogram
> +		set style fill solid 0.5 border
> +		set boxwidth 0.8
> +
> +		if ($flag == 1) {
> +			plot \
> +			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[0]}", \
> +			"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[1]}"
> +		} else {
> +			if ($flag == 2) {
> +				plot \
> +				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[0]}", \
> +				"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[1]}"
> +			} else {
> +				if ($flag == 3 ) {
> +					plot \
> +					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[0]}", \
> +					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[0]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[0]}-${tbench_governors[1]}", \
> +					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[0]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[0]}", \
> +					"<(sed -n -e 's/,//g' -e '/${all_scaling_names[1]}-${tbench_governors[1]}/p' $OUTFILE_TBENCH.csv)" using $4:xtic(2) title "${all_scaling_names[1]}-${tbench_governors[1]}"
> +				}
> +			}
> +		}
> +		quit
> +EOF
> +}
> +
> +amd_pstate_tbench()
> +{
> +	printf "\n---------------------------------------------\n"
> +	printf "*** Running tbench                        ***"
> +	printf "\n---------------------------------------------\n"
> +
> +	pre_clear_tbench
> +
> +	#install_tbench
> +
> +	get_lines_csv_tbench "Governor"
> +	if [ $? -eq 0 ]; then
> +		# add titles and unit for csv file
> +		store_csv_tbench "Governor" "Round" "Des-perf" "Freq" "Load" "Performance" "Energy" "Performance Per Watt"
> +		store_csv_tbench "Unit" "" "" "GHz" "" "MB/s" "J" "MB/J"
> +	fi
> +
> +	backup_governor
> +	for governor in ${tbench_governors[*]} ; do
> +		printf "\nSpecified governor is $governor\n\n"
> +		switch_governor $governor
> +		loop_tbench $governor
> +		gather_tbench $governor
> +	done
> +	restore_governor
> +
> +	plot_png_tbench "tbench_perfromance.png" "Tbench Benchmark Performance" "Performance" 6
> +	plot_png_tbench "tbench_energy.png" "Tbench Benchmark Energy" "Energy (J)" 7
> +	plot_png_tbench "tbench_ppw.png" "Tbench Benchmark Performance Per Watt" "Performance Per Watt (MB/J)" 8
> +
> +	calc_comp_tbench
> +
> +	post_clear_tbench
> +}

thanks,
-- Shuah

