Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E8463F479
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiLAPre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiLAPrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:47:23 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5257993A5B;
        Thu,  1 Dec 2022 07:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669909640; x=1701445640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CbVACme8iPvjVVtyo9dzw5acjaK3zYZVcz4HHrnwCTw=;
  b=IJnX2hT4sYRSBvVXNKA3Q8iYDPP4vgfPJaw2uRkv4czr2ELDtAf1AC6O
   NITf6zZj7IzRPmF1ef2N+JtotL4aBnioQuROgcqyRAPXmbww0bQUZTthA
   if4vfFTKMaxgV4SesMoW2/wXSA5+hZgOBGzLIAZem+G1OYJc855lwA5Bq
   O/y5DSy74taIMBD2w5WlMOgbyPBlwtNGLXyzkfsYTM56foY+yaCxq1YPi
   pLlZRfffs0+fkjLApwbymiSwYRHGot68qTnoG5QV2vGEG0dC//mdDLCV3
   StQCeeue1R291P2OzZO4R2KfUIUz9ejawkEuVCk8w+VeP7KyWfLRkvGST
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="313347245"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="313347245"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 07:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="622344555"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="622344555"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 01 Dec 2022 07:47:16 -0800
Received: from [10.252.208.219] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1FF67580C75;
        Thu,  1 Dec 2022 07:47:12 -0800 (PST)
Message-ID: <c5e97f0e-0039-7e9f-299f-c0d03a6ac33e@linux.intel.com>
Date:   Thu, 1 Dec 2022 10:47:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] perf test: Add event group test
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>, irogers@google.com
Cc:     acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        carsten.haitzler@arm.com, leo.yan@linaro.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        tmricht@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
References: <20221129111946.409-1-ravi.bangoria@amd.com>
 <20221129111946.409-3-ravi.bangoria@amd.com>
 <0dd566ab-38fd-2204-f59c-e74b2244828b@linux.intel.com>
 <62399b9c-d5ef-4c56-4592-d2cf1af503d6@amd.com>
 <7449d858-2110-1ddf-f7e1-013015cbd791@linux.intel.com>
 <0eb0cc59-d28d-8e42-3233-2587123e291d@amd.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <0eb0cc59-d28d-8e42-3233-2587123e291d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-12-01 10:29 a.m., Ravi Bangoria wrote:
>>>   /* Uncore pmus that support more than 3 counters */
>>>   static struct uncore_pmus {
>>>       char *name;
>>>       unsigned long config;
>>>   } uncore_pmus[] = {
>>>       { "amd_l3",         0x0  },
>>>       { "amd_df",         0x0  },
>>>       { "uncore_imc_xxx", 0xff },   /* Intel */
>>
>> IMC seems a safe choice. AFAIK, we should have at least uncore_imc_0 for
>> all the existing Intel platforms. { "uncore_imc_0", 0x1 }
> 
> Ok. Ian said he don't see uncore_imc_0 on his tigerlake machine. Are you
> sure uncore_imc_0 should be present on all existing Intel platforms?

For TGL and older client platforms, there is only free running IMC
counters. For other uncore PMUs on the old client platforms, I cannot
guarantee that then always have more then 2 counters. I think you can
skip the uncore test for these old platforms if you need at least 3
counters.


> 
>>>       { "intel_xxx_pmu2", 0xff },   /* Intel */
>>
>> Intel doesn't have such uncore PMUs.
> 
> Yeah this was just for example purpose.
> 
>>>       { "abc_pmu1",       0x0  },   /* Arm */
>>>       { "hv_24x7",        0xa  },   /* PowerPC */
>>>       { ...                    },
>>>   };
>>>
>>>   perf_pmus__for_each_pmu(pmu) {
>>>       if (pmu present in uncore_pmus[])
>>>           type[2] = pmu->type;
>>>           config[2] = pmu->config;>   }
>>
>>
>> Not sure the uncore_pmus[] can cover all possible names for all
>> architectures.
> 
> It doesn't need to cover _all_ possible names. It just needs to cover
> minimal set of names which can cover all platforms for that architecture.
>>> Maybe we should fall back to the first uncore PMU and try again if
>> nothing match the uncore_pmus[].
> 
> That's a good point. However, this can endup with the same problem you
> mentioned: it may trigger false alarm on some platform. So better to
> skip the test(and let someone add proper pmu in this list) rather than
> proving false negative result?

OK. Skipping the test for this case sounds good to me.

Thanks,
Kan
> 
> Thanks,
> Ravi
