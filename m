Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395526072B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiJUIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJUIph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:45:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97601D2CEE;
        Fri, 21 Oct 2022 01:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666341931; x=1697877931;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bCmnXMxEdIpqLDpzSjuss3n0Raqam0wXCvy5gepTCeE=;
  b=VLg+PsFwgygfl4Vdmi4Ce66iuu+07bSrFK88bjpovUn/R3kluWZ10u76
   4nqLgwlNuc3xTIOqlHR7J0YaUgGShyQQmcUfaRhLb4vefKpObaXRKARgC
   /fmzPOXVB4bREB31x5KZOLob8BWG7nL+uam2PNE8t47i1hIze+J9gGWoo
   04q35emxDo55yngENjZ+K7KARLColFgiIORYti/+De1hWbWY/CMD4mlVz
   RBUAJfeCU9f0ls3s0GXrWkzX2CG0l7BdJlLFNEUxoVMyT4/xtXIvWqdqj
   zXY6xNeHe3j2yay2dW6BBOrHMFXjMvg3WJX2Iyn58bnpLMPCGWGaiCXEq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="286670037"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="286670037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:45:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="630376775"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="630376775"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.45.134])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 01:45:28 -0700
Message-ID: <132e3bcd-c64a-5c55-bb52-efe013e55157@intel.com>
Date:   Fri, 21 Oct 2022 11:45:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH 2/8] perf test: Fix shellcheck issues in the record test
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
References: <20221020172643.3458767-1-namhyung@kernel.org>
 <20221020172643.3458767-3-namhyung@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221020172643.3458767-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/22 20:26, Namhyung Kim wrote:
> Basically there are 3 issues:
> 
>  1. quote shell expansion
>  2. do not use egrep
>  3. use upper case letters for signal names
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/shell/record.sh | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 747c33a1ec45..464071462809 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -8,16 +8,16 @@ err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  
>  cleanup() {
> -  rm -f ${perfdata}
> -  rm -f ${perfdata}.old
> -  trap - exit term int
> +  rm -f "${perfdata}"
> +  rm -f "${perfdata}".old
> +  trap - EXIT TERM INT
>  }
>  
>  trap_cleanup() {
>    cleanup
>    exit 1
>  }
> -trap trap_cleanup exit term int
> +trap trap_cleanup EXIT TERM INT
>  
>  test_per_thread() {
>    echo "Basic --per-thread mode test"
> @@ -30,13 +30,13 @@ test_per_thread() {
>      fi
>      return
>    fi
> -  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
> +  if ! perf record --per-thread -o "${perfdata}" true 2> /dev/null
>    then
>      echo "Per-thread record [Failed record]"
>      err=1
>      return
>    fi
> -  if ! perf report -i ${perfdata} -q | egrep -q true
> +  if ! perf report -i "${perfdata}" -q | grep -q true
>    then
>      echo "Per-thread record [Failed missing output]"
>      err=1
> @@ -47,7 +47,7 @@ test_per_thread() {
>  
>  test_register_capture() {
>    echo "Register capture test"
> -  if ! perf list | egrep -q 'br_inst_retired.near_call'
> +  if ! perf list | grep -q 'br_inst_retired.near_call'
>    then
>      echo "Register capture test [Skipped missing event]"
>      if [ $err -ne 1 ]
> @@ -56,7 +56,7 @@ test_register_capture() {
>      fi
>      return
>    fi
> -  if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
> +  if ! perf record --intr-regs=\? 2>&1 | grep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
>    then
>      echo "Register capture test [Skipped missing registers]"
>      return
> @@ -64,7 +64,7 @@ test_register_capture() {
>    if ! perf record -o - --intr-regs=di,r8,dx,cx -e br_inst_retired.near_call:p \
>      -c 1000 --per-thread true 2> /dev/null \
>      | perf script -F ip,sym,iregs -i - 2> /dev/null \
> -    | egrep -q "DI:"
> +    | grep -q "DI:"
>    then
>      echo "Register capture test [Failed missing output]"
>      err=1

