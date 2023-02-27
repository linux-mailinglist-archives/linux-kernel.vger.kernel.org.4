Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C26A46E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjB0QVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB0QVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:21:07 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B933D21941;
        Mon, 27 Feb 2023 08:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677514863; x=1709050863;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mT9USpHEmmCCmakydMx/Q4eEVoitEVqCXyaxLeIp9JY=;
  b=Tr8aKPhPqrJlxQq998nNu7M/OIOCrYFjLHap9TMAUdBjEQTAc65eCvaC
   nZ5jJWxVbVAvdG9YQMK3FtwgIFxL76HqbRJa+4ftUaY4fHhKVbTGqSSPT
   sk1GkMIZkQYCLQ7Y3h8gToWPPpGjZ2OlpR6BjoacSLkPoLbCarAKILSoQ
   FiFYf8uJhZLWXW2ABz2ga7ZcZayZfdgvfMu/gqK3ap9ZTphpHBE0/il3u
   LjW6WGpsWwAoSXgbUjvMCkKJP6uJOpsfYmLk/QW72M57ltPXUbAtzYnpz
   LmjBJg23VYvFkiuWaORIxoU/4Fzlsp86/2/zSq5KTs6LtrCoVVdeFYTNY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="420159362"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="420159362"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 08:21:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="1002837345"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="1002837345"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 27 Feb 2023 08:21:02 -0800
Received: from [10.212.193.244] (kliang2-mobl1.ccr.corp.intel.com [10.212.193.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5C281580C28;
        Mon, 27 Feb 2023 08:21:00 -0800 (PST)
Message-ID: <97e10366-b9d2-5fae-74a5-8f7e314eafa4@linux.intel.com>
Date:   Mon, 27 Feb 2023 11:20:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] perf/x86/core: Remove repeating test expression
To:     Deepak R Varma <drv@mailo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y/yYTY7c7L0+d+Gb@ubun2204.myguest.virtualbox.org>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Y/yYTY7c7L0+d+Gb@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-02-27 6:47 a.m., Deepak R Varma wrote:
> Current implementation already checks validity of the cpu_type for the
> hybrid pmu two lines above. Hence there is no need to again include
> it in the immediate if test evaluation.

The pmu_attr is different from the pmu. The pmu_attr is the
EVENT_ATTR_STR_HYBRID() which is defined in the kernel. The pmu is
calculated from the sysfs PMU entry. The first two line is to check
whether the attr is defined in the kernel. The second check is to find
the correct attr for the sysfs PMU entry. I don't think we should remove
the second check.

Thanks,
Kan
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
>  arch/x86/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 87a7f0cd77fd..89db2352deb9 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1893,7 +1893,7 @@ ssize_t events_hybrid_sysfs_show(struct device *dev,
>  	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
>  		if (!(x86_pmu.hybrid_pmu[i].cpu_type & pmu_attr->pmu_type))
>  			continue;
> -		if (x86_pmu.hybrid_pmu[i].cpu_type & pmu->cpu_type) {
> +		if (pmu->cpu_type) {
>  			next_str = strchr(str, ';');
>  			if (next_str)
>  				return snprintf(page, next_str - str + 1, "%s", str);
