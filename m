Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC16724ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbjFFSIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjFFSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:08:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715671732
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686074907; x=1717610907;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=UzDOupbFSr0zaWStQB5C/RzkjHszGyqSmQ68bXb4SCI=;
  b=Wd8KAqMXHUYsU4R9Avw27cJTHbQoo8SFGuXH5eIHFHtxYJArqgRbDZ3f
   ugc5wH0kW9Up7bvxYOdAqvDG00DUfGdK4r79lq2FpuE/ihIEpfcoxKike
   V6iTAVwS50XJ6VStCB/wgAcenXS+XCWQivPQGOHewnoHeN0MpdNoBDOke
   j9MJzjQ0gMT9YABXUClATHrwvPvFaYAghCX6mvwSYJylW7YvjPBt4msFz
   cCimpUg6LzUYDHf0+K91TRGym5Gow4F8pBlOns4PbsSx87bVxjB1MrYXd
   X82PlcwPpDU97sHCuCAXmpk7vGBZ+btd4XS3IO9+BT4IIqXUTlm5ekcfV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="337121643"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="337121643"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 11:08:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="712306939"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="712306939"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2023 11:08:22 -0700
Received: from [10.212.191.33] (kliang2-mobl1.ccr.corp.intel.com [10.212.191.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CD8CB580C9B;
        Tue,  6 Jun 2023 11:08:20 -0700 (PDT)
Message-ID: <4c2c7c64-a956-ab2b-eaac-b800333ee177@linux.intel.com>
Date:   Tue, 6 Jun 2023 14:08:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC PATCH] x86/cpu: Update Intel model naming rule
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, tony.luck@intel.com,
        peterz@infradead.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20230606170257.3213720-1-kan.liang@linux.intel.com>
 <84292c84-6f12-2df5-dc4c-3a7abc6659ea@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <84292c84-6f12-2df5-dc4c-3a7abc6659ea@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-06 1:28 p.m., Dave Hansen wrote:
> On 6/6/23 10:02, kan.liang@linux.intel.com wrote:
>>   * MICROARCH	Is the code name for the micro-architecture for this core.
>>   *		N.B. Not the platform name.
>> + * PROCESSOR	Is the code name for the processor
> 
> I think we should refine the definition of "MICROARCH" here.  We want it
> to refer to the combination of cores, not just "this core".
> 
> ALDERLAKE is a fine name to refer to a processor that has a mix of
> "Golden Cove / Gracemont" cores.  Let's just have it say:
> 
>    * MICROARCH	Is the code name for the collection of micro-
> 		architectures for this processor.  N.B. Not the
> 		platform name.
> 

OK. It should address the issue for hybrid.

But for the non-hybrid, it may not work by only redefining the
"MICROARCH". They usually have different code name for microarchitecture
and processor. For example, the Sapphire Rapids should be the code name
of the processor, while the Golden Cove is the code name of the
microarchitecture.

The other option is to still only use the microarch name. Then we have
to change all the big core names at least since Ice Lake and the latest
Atom names. All the names below will be changed. We also need to change
all the places where using them. It could be a big change.

#define INTEL_FAM6_ICELAKE_X		0x6A	/* Sunny Cove */
#define INTEL_FAM6_ICELAKE_D		0x6C	/* Sunny Cove */
#define INTEL_FAM6_ICELAKE		0x7D	/* Sunny Cove */
#define INTEL_FAM6_ICELAKE_L		0x7E	/* Sunny Cove */
#define INTEL_FAM6_ICELAKE_NNPI		0x9D	/* Sunny Cove */

#define INTEL_FAM6_ROCKETLAKE		0xA7	/* Cypress Cove */

#define INTEL_FAM6_TIGERLAKE_L		0x8C	/* Willow Cove */
#define INTEL_FAM6_TIGERLAKE		0x8D	/* Willow Cove */

#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Golden Cove */

#define INTEL_FAM6_EMERALDRAPIDS_X	0xCF

#define INTEL_FAM6_GRANITERAPIDS_X	0xAD
#define INTEL_FAM6_GRANITERAPIDS_D	0xAE

#define INTEL_FAM6_SIERRAFOREST_X	0xAF

#define INTEL_FAM6_GRANDRIDGE		0xB6

Thanks,
Kan

