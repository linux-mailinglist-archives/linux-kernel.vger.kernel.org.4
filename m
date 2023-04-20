Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB036E9554
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjDTNEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjDTNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:04:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C4665A9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681995838; x=1713531838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qrNMqJjUG01YI9RCER0spb2SKWe0YuljGeeRhTnOhtk=;
  b=aB5ZgaxIimjp5cFtltoagrZHJldd/NHjNCfQVfipuSsl7RkTFEbK4Zte
   M1OPsBDOHATNyyx9DVWLSeqDtaGaUaYHfmdXeMnSRaBJG3hSSEDcSaj64
   fzQsLssAC8t9ASqVbI2gRcfN21L02Bwe9VqT5mlO7CL+IhmNTtRPYoVHc
   xm2EKFNHp9NSRFaOHxszTWNojy1yfZh8DkLKH7PLfL5WSfXGm8Xjturyp
   MH6zRu1rAn7IeKgyUs0n1IzW4dVEG2J1pjgyI14joxAdNXjQ9lvzvHcoT
   Iz/dvTvEuhqEHzCAbw+flA2I9U3/2273lHLIMNbeqW4F3DAPwImDPAU6F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="329901963"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="329901963"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 06:03:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="938058688"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="938058688"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2023 06:03:57 -0700
Received: from [10.255.228.114] (kliang2-mobl1.ccr.corp.intel.com [10.255.228.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8BBF1580CB8;
        Thu, 20 Apr 2023 06:03:56 -0700 (PDT)
Message-ID: <0e1a27ca-8288-cbff-b903-0bb4f605bf84@linux.intel.com>
Date:   Thu, 20 Apr 2023 09:03:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] perf/x86/intel/uncore: add events for Intel SPR IMC PMU
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kan.liang@intel.com, ak@linux.intel.com,
        namhyung@kernel.org, irogers@google.com
References: <20230419214241.2310385-1-eranian@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230419214241.2310385-1-eranian@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-19 5:42 p.m., Stephane Eranian wrote:
> Add missing clockticks and cas_count_* events for Intel SapphireRapids IMC
> PMU. These events are useful to measure memory bandwidth.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/uncore_snbep.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 7d1199554fe3..fa9b209a11fa 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6068,6 +6068,17 @@ static struct intel_uncore_ops spr_uncore_mmio_ops = {
>  	.read_counter		= uncore_mmio_read_counter,
>  };
>  
> +static struct uncore_event_desc spr_uncore_imc_events[] = {
> +	INTEL_UNCORE_EVENT_DESC(clockticks,      "event=0x01,umask=0x00"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_read,  "event=0x05,umask=0xcf"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_read.scale, "6.103515625e-5"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_read.unit, "MiB"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_write, "event=0x05,umask=0xf0"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_write.scale, "6.103515625e-5"),
> +	INTEL_UNCORE_EVENT_DESC(cas_count_write.unit, "MiB"),
> +	{ /* end: all zeroes */ },
> +};
> +
>  static struct intel_uncore_type spr_uncore_imc = {
>  	SPR_UNCORE_COMMON_FORMAT(),
>  	.name			= "imc",
> @@ -6075,6 +6086,7 @@ static struct intel_uncore_type spr_uncore_imc = {
>  	.fixed_ctr		= SNR_IMC_MMIO_PMON_FIXED_CTR,
>  	.fixed_ctl		= SNR_IMC_MMIO_PMON_FIXED_CTL,
>  	.ops			= &spr_uncore_mmio_ops,
> +	.event_descs		= spr_uncore_imc_events,
>  };
>  
>  static void spr_uncore_pci_enable_event(struct intel_uncore_box *box,
