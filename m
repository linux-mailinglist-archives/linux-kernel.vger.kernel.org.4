Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DED63F230
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiLAOCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiLAOCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:02:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D3EA47DB;
        Thu,  1 Dec 2022 06:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669903344; x=1701439344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CMBVReNfGbbIECAgFrlXD7Aio9U87nWLRNX1Xd13ihA=;
  b=VazKx7XpWQHltFwb/wmxacTOSoKZOFO6P/DQNBFRgioSTgQgIeX9c0bV
   a5VqsHn8eZECqVIaPtN4mt2CrIaAkdjatOBQ53MkNKA8bR9qaeO4aFuq+
   zVghnMxlAnktKnrKGSoOQnYZskIm+3ZThVhuC9WqBBQfXqElEjix/ZuDN
   jxb0KxuiU2j4TNpNNehN6BsSyyl+QByZNf6LhWwKN7tCCH7hAjLLyIxDo
   34oSc6T7SbFyqLCXRz9XLIaZ8IYGtascIuwMlAtzfvJCJiah50EGRdXcv
   sr5E4fAXJduZSvIEzUpueA9VhsCU0rHM2MJuYJAauxD16dV2/SVWbUHCw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="316842478"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="316842478"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 06:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="644648929"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="644648929"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 01 Dec 2022 06:02:12 -0800
Received: from [10.252.208.219] (kliang2-mobl1.ccr.corp.intel.com [10.252.208.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8AF70580A8B;
        Thu,  1 Dec 2022 06:02:09 -0800 (PST)
Message-ID: <7449d858-2110-1ddf-f7e1-013015cbd791@linux.intel.com>
Date:   Thu, 1 Dec 2022 09:02:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] perf test: Add event group test
Content-Language: en-US
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, irogers@google.com, jolsa@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, mark.rutland@arm.com,
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
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <62399b9c-d5ef-4c56-4592-d2cf1af503d6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-12-01 4:13 a.m., Ravi Bangoria wrote:
> Hi Kan,
> 
> Thanks for the review.
> 
>>> +static int setup_uncore_event(void)
>>> +{
>>> +	struct perf_pmu *pmu;
>>> +
>>> +	if (list_empty(&pmus))
>>> +		perf_pmu__scan(NULL);
>>> +
>>> +	perf_pmus__for_each_pmu(pmu) {
>>> +		if (pmu->is_uncore) {
>>
>> Always using the first uncore PMU may trigger false alarm on some Intel
>> platforms. For example, Intel has free running uncore PMUs (e.g.,
>> uncore_imc_free_running_0), which only supports special event encoding
>> 0xff. The config 0 must fails.
>> You may want to add the below check to ignore the free running uncore PMUs.
>>                         if (strstr(pmu->name, "free_running"))
>>                                 continue;
>>
>>
>> Also, some uncore PMUs only support two counters. But the test assumes
>> that the number of counters > 2. You may want to limit the size of the
>> group for 2 for a pure uncore group.
> 
> That seems hacky. Instead of ignoring, would it be possible to provide
> a list of testable pmus? Example with random values:
> 
>   /* Uncore pmus that support more than 3 counters */
>   static struct uncore_pmus {
>       char *name;
>       unsigned long config;
>   } uncore_pmus[] = {
>       { "amd_l3",         0x0  },
>       { "amd_df",         0x0  },
>       { "uncore_imc_xxx", 0xff },   /* Intel */

IMC seems a safe choice. AFAIK, we should have at least uncore_imc_0 for
all the existing Intel platforms. { "uncore_imc_0", 0x1 }

>       { "intel_xxx_pmu2", 0xff },   /* Intel */

Intel doesn't have such uncore PMUs.

>       { "abc_pmu1",       0x0  },   /* Arm */
>       { "hv_24x7",        0xa  },   /* PowerPC */
>       { ...                    },
>   };
> 
>   perf_pmus__for_each_pmu(pmu) {
>       if (pmu present in uncore_pmus[])
>           type[2] = pmu->type;
>           config[2] = pmu->config;>   }


Not sure the uncore_pmus[] can cover all possible names for all
architectures.

Maybe we should fall back to the first uncore PMU and try again if
nothing match the uncore_pmus[].

Thanks,
Kan
> 
> Ofcourse, this should work for all architectures. Arm, PowerPC, s390 folks?
> 
> Thanks,
> Ravi
