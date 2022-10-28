Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148AA610B46
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJ1H1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJ1H1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:27:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17421B6CBA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:27:41 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g62so4118489pfb.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGyW0Bb4dZNWJ26cqlQ7MbFHewGbpJT4dP9GrPwuNv8=;
        b=Yr65ahPFnZ+lGCbNaPS6S6o7jrsxgiXwrttIuIy9obdu4rfxRLRwqC3FKNaVjajmsS
         vi63Cy8g5nKDbPo0pZIBIwPfUKkIYzxw21XZbLbMTALLF2VFZPaF0TiAF1qpPyBPbVbQ
         wTORT4PeXUJBFSX6gDYIsIu4KSqLp4s6ACgIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGyW0Bb4dZNWJ26cqlQ7MbFHewGbpJT4dP9GrPwuNv8=;
        b=Y1wRU1lUiRC5TPYnJhlOVj0BTo9UCjpLsv2ORSc3/PkFcvQGDxVXrpISnZkIByaxUc
         DiUQfeEXnZCcudYazlOqI0Lt57Bh+a5wWwJigIGh54BSA/Y6wojsj0blV29AU5x2DlXV
         bMqVIQBLYBNkGz4ufXQtPF6GjM2SD3GSvf3TBo+gANlh9hNiSx+rJOWYcrN+5IDgul9x
         RHB+onBldZq9V8asVEj9aOKAGW6qtH8QVLJW02Dn4BWfaHXQKM5nLgsaYuUuhDHJFORN
         uYDemaydHty/sy/Cewq/enZwyL3sLhZlmtMQmCuun4vsO5jon45+B7K6owPhoy+7ljBO
         Nifw==
X-Gm-Message-State: ACrzQf1SoE41QI2VDCYEM/1XCQd6v7dKMxVBTHHVAJSd6IgUV24QlnoZ
        dL8jWIbFx2psfGVq+2TgSdFB3w==
X-Google-Smtp-Source: AMsMyM6zZiD+wD0VrwaTi3fOONqQpKG3KDpL/ag/KEKX4kR3I5dg56OreW5LagTpDi7mdmGRPW1z8A==
X-Received: by 2002:a63:950d:0:b0:46e:d655:b377 with SMTP id p13-20020a63950d000000b0046ed655b377mr29241343pgd.191.1666942060865;
        Fri, 28 Oct 2022 00:27:40 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902654900b001753654d9c5sm2357406pln.95.2022.10.28.00.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 00:27:39 -0700 (PDT)
Message-ID: <d58aeb94-f6d8-5b15-b400-0798e40d51b1@linuxfoundation.org>
Date:   Fri, 28 Oct 2022 01:27:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V4 1/4] selftests: amd-pstate: Modify amd-pstate-ut.sh to
 basic.sh.
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
 <20221024013356.1639489-2-li.meng@amd.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221024013356.1639489-2-li.meng@amd.com>
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
> Modify amd-pstate-ut.sh to basic.sh.
> The purpose of this modification is to facilitate the subsequent
> addition of gitsource, tbench and other tests.
> Then you can specify test case in kselftest/amd-pstate, for example:
> sudo ./run.sh -c basic, this command only test basic kernel funcitions.
> The detail please run the below script.
> ./run.sh --help
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>
> ---
>   tools/testing/selftests/amd-pstate/Makefile   |   3 +-
>   .../selftests/amd-pstate/amd-pstate-ut.sh     |  56 -------
>   tools/testing/selftests/amd-pstate/basic.sh   |  38 +++++
>   tools/testing/selftests/amd-pstate/run.sh     | 142 ++++++++++++++++++
>   4 files changed, 182 insertions(+), 57 deletions(-)
>   delete mode 100755 tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
>   create mode 100755 tools/testing/selftests/amd-pstate/basic.sh

Is there a reason to delete followed by a create?  It is cleaner to rename amd-pstate-ut.sh
it to basic.sh first and then make changes.

>   create mode 100755 tools/testing/selftests/amd-pstate/run.sh
> 
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 199867f44b32..6f4c7b01e3bb 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -4,6 +4,7 @@
>   # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>   all:
>   
> -TEST_PROGS := amd-pstate-ut.sh
> +TEST_PROGS := run.sh
> +TEST_FILES := basic.sh
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh b/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> deleted file mode 100755
> index f8e82d91ffcf..000000000000
> --- a/tools/testing/selftests/amd-pstate/amd-pstate-ut.sh
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -
> -# amd-pstate-ut is a test module for testing the amd-pstate driver.
> -# It can only run on x86 architectures and current cpufreq driver
> -# must be amd-pstate.
> -# (1) It can help all users to verify their processor support
> -# (SBIOS/Firmware or Hardware).
> -# (2) Kernel can have a basic function test to avoid the kernel
> -# regression during the update.
> -# (3) We can introduce more functional or performance tests to align
> -# the result together, it will benefit power and performance scale optimization.
> -
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> -
> -# amd-pstate-ut only run on x86/x86_64 AMD systems.
> -ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> -VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
> -
> -if ! echo "$ARCH" | grep -q x86; then
> -	echo "$0 # Skipped: Test can only run on x86 architectures."
> -	exit $ksft_skip
> -fi
> -
> -if ! echo "$VENDOR" | grep -iq amd; then
> -	echo "$0 # Skipped: Test can only run on AMD CPU."
> -	echo "$0 # Current cpu vendor is $VENDOR."
> -	exit $ksft_skip
> -fi
> -
> -scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
> -if [ "$scaling_driver" != "amd-pstate" ]; then
> -	echo "$0 # Skipped: Test can only run on amd-pstate driver."
> -	echo "$0 # Please set X86_AMD_PSTATE enabled."
> -	echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
> -	exit $ksft_skip
> -fi
> -
> -msg="Skip all tests:"
> -if [ ! -w /dev ]; then
> -    echo $msg please run this as root >&2
> -    exit $ksft_skip
> -fi
> -
> -if ! /sbin/modprobe -q -n amd-pstate-ut; then
> -	echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
> -	exit $ksft_skip
> -fi
> -if /sbin/modprobe -q amd-pstate-ut; then
> -	/sbin/modprobe -q -r amd-pstate-ut
> -	echo "amd-pstate-ut: ok"
> -else
> -	echo "amd-pstate-ut: [FAIL]"
> -	exit 1
> -fi
> diff --git a/tools/testing/selftests/amd-pstate/basic.sh b/tools/testing/selftests/amd-pstate/basic.sh
> new file mode 100755
> index 000000000000..e4c43193e4a3
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/basic.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# amd-pstate-ut is a test module for testing the amd-pstate driver.
> +# It can only run on x86 architectures and current cpufreq driver
> +# must be amd-pstate.
> +# (1) It can help all users to verify their processor support
> +# (SBIOS/Firmware or Hardware).
> +# (2) Kernel can have a basic function test to avoid the kernel
> +# regression during the update.
> +# (3) We can introduce more functional or performance tests to align
> +# the result together, it will benefit power and performance scale optimization.
> +
> +# protect against multiple inclusion
> +if [ $FILE_BASIC ]; then
> +	return 0
> +else
> +	FILE_BASIC=DONE
> +fi
> +
> +amd_pstate_basic()
> +{
> +	printf "\n---------------------------------------------\n"
> +	printf "*** Running AMD P-state ut                ***"
> +	printf "\n---------------------------------------------\n"
> +
> +	if ! /sbin/modprobe -q -n amd-pstate-ut; then
> +		echo "amd-pstate-ut: module amd-pstate-ut is not found [SKIP]"
> +		exit $ksft_skip
> +	fi
> +	if /sbin/modprobe -q amd-pstate-ut; then
> +		/sbin/modprobe -q -r amd-pstate-ut
> +		echo "amd-pstate-basic: ok"
> +	else
> +		echo "amd-pstate-basic: [FAIL]"
> +		exit 1
> +	fi
> +}
> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
> new file mode 100755
> index 000000000000..715e9d01484f
> --- /dev/null
> +++ b/tools/testing/selftests/amd-pstate/run.sh
> @@ -0,0 +1,142 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# protect against multiple inclusion
> +if [ $FILE_MAIN ]; then
> +	return 0
> +else
> +	FILE_MAIN=DONE
> +fi
> +
> +source basic.sh
> +
> +# amd-pstate-ut only run on x86/x86_64 AMD systems.
> +ARCH=$(uname -m 2>/dev/null | sed -e 's/i.86/x86/' -e 's/x86_64/x86/')
> +VENDOR=$(cat /proc/cpuinfo | grep -m 1 'vendor_id' | awk '{print $NF}')
> +
> +FUNC=all
> +OUTFILE=selftest
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +# All amd-pstate tests
> +amd_pstate_all()
> +{
> +	printf "\n=============================================\n"
> +	printf "***** Running AMD P-state Sanity Tests  *****\n"
> +	printf "=============================================\n\n"
> +
> +	# unit test for amd-pstate kernel driver
> +	amd_pstate_basic
> +}
> +
> +helpme()

Make this just help()

> +{
> +	printf "Usage: $0 [OPTION...]
> +	[-h <help>]
> +	[-o <output-file-for-dump>]
> +	[-c <all: All testing,
> +	     basic: Basic testing.>]
> +	\n"
> +	exit 2
> +}
> +
> +parse_arguments()
> +{
> +	while getopts ho:c: arg
> +	do
> +		case $arg in
> +			h) # --help
> +				helpme
> +				;;
> +
> +			c) # --func_type (Function to perform: basic (default: all))
> +				FUNC=$OPTARG
> +				;;
> +
> +			o) # --output-file (Output file to store dumps)
> +				OUTFILE=$OPTARG
> +				;;
> +
> +			*)
> +				helpme

Same here

> +				;;
> +		esac
> +	done
> +}
> +
> +prerequisite()
> +{
> +	if ! echo "$ARCH" | grep -q x86; then
> +		echo "$0 # Skipped: Test can only run on x86 architectures."
> +		exit $ksft_skip
> +	fi
> +
> +	if ! echo "$VENDOR" | grep -iq amd; then
> +		echo "$0 # Skipped: Test can only run on AMD CPU."
> +		echo "$0 # Current cpu vendor is $VENDOR."
> +		exit $ksft_skip
> +	fi
> +
> +	scaling_driver=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_driver)
> +	if [ "$scaling_driver" != "amd-pstate" ]; then
> +		echo "$0 # Skipped: Test can only run on amd-pstate driver."
> +		echo "$0 # Please set X86_AMD_PSTATE enabled."
> +		echo "$0 # Current cpufreq scaling drvier is $scaling_driver."
> +		exit $ksft_skip
> +	fi
> +
> +	msg="Skip all tests:"
> +	if [ ! -w /dev ]; then
> +		echo $msg please run this as root >&2
> +		exit $ksft_skip
> +	fi
> +}
> +
> +do_test()
> +{
> +	case "$FUNC" in
> +		"all")
> +			amd_pstate_all
> +			;;
> +
> +		"basic")
> +			amd_pstate_basic
> +			;;
> +
> +		*)
> +			echo "Invalid [-f] function type"
> +			helpme
> +			;;
> +	esac
> +}
> +
> +# clear dumps
> +pre_clear_dumps()
> +{
> +	case "$FUNC" in
> +		"all")
> +			rm -rf $OUTFILE*
> +			;;
> +
> +		*)
> +			;;
> +	esac
> +}
> +
> +post_clear_dumps()
> +{
> +	rm -rf $OUTFILE.log
> +}
> +
> +# Parse arguments
> +parse_arguments $@
> +
> +# Make sure all requirements are met
> +prerequisite
> +
> +# Run requested functions
> +pre_clear_dumps
> +do_test | tee -a $OUTFILE.log
> +post_clear_dumps

