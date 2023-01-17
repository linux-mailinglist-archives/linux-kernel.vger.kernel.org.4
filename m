Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EB466E33B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjAQQQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAQQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:16:45 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E593BDBF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673972204; x=1705508204;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XwlxHdD5rlND5VEwSoVAqP7En/H6Ew9PGTb3n39d0Xs=;
  b=XJzAC11eKR/wiyYbgj1fXwbybnUpxZSD2eivKYeUXsXXA4G0lc6NqLIV
   CuE9JL4rjNUObAbcJsKp/v63KiQ9+9dKXIpDTXSsgaIowKP/OxFgQ2NbB
   0pCanuKWrauA96dO80GGG42meaYd++/uCDG8U7QKABWPUrOYxy2AqlCE7
   PD2o44xZQDK5WXNDiso7LCdp0UuMdUr5zNYPx2SKqLKNlA7PttTSQDY2h
   TUjhh8MmGa6kD6m2a2R0z4K8e/4efkLX5qSBd4Xqvf9CboLfjUZ8d/nDz
   L0usbcjbfBziixL3PU4l90GsUfSI8fEU7d9OfppaU5AmM84cv1kJSjI3p
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410973909"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="410973909"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 08:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="833226900"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="833226900"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 17 Jan 2023 08:16:43 -0800
Received: from [10.212.252.43] (kliang2-mobl1.ccr.corp.intel.com [10.212.252.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1C81E580DA6;
        Tue, 17 Jan 2023 08:16:43 -0800 (PST)
Message-ID: <7760ae92-e713-603a-217a-25035523b1b2@linux.intel.com>
Date:   Tue, 17 Jan 2023 11:16:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] perf/x86/intel: Add Emerald Rapids
Content-Language: en-US
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com
References: <20230106160449.3566477-1-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230106160449.3566477-1-kan.liang@linux.intel.com>
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

Hi Ingo,

It seems that only the last two patches of the series are merged into
the tip.git perf/urgent branch.

Could you please take the first two patches as well? They similarly add
the CPU model number for perf core driver and perf cstate driver.

Please let me know if you have any questions regarding the first two
patches. If you want me to resend the patches, please let me know as well.

Thanks,
Kan

On 2023-01-06 11:04 a.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> From core PMU's perspective, Emerald Rapids is the same as the Sapphire
> Rapids. The only difference is the event list, which will be
> supported in the perf tool later.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 29d2d0411caf..72943243c95c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6487,6 +6487,7 @@ __init int intel_pmu_init(void)
>  		break;
>  
>  	case INTEL_FAM6_SAPPHIRERAPIDS_X:
> +	case INTEL_FAM6_EMERALDRAPIDS_X:
>  		pmem = true;
>  		x86_pmu.late_ack = true;
>  		memcpy(hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(hw_cache_event_ids));
