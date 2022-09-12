Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D9E5B6439
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiILXfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiILXfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:35:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE21DA4B;
        Mon, 12 Sep 2022 16:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663025740; x=1694561740;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FK30peOhtQglky62cX8i3AARRm6VMYrz0qC/DM4mrEU=;
  b=Rn0W8KBrKxxIo8Kth2Ng4eayqpVGbHqyd/aCLdWXOcOM9ipLPtik/WnB
   dUVTCEW/k8RasLiVD7qVlUzgTSDvLizd/8ykSq1ESU/ZcogwGx71UUsqU
   bmLI7GXFvMs0/2jk4QjuOyOjlRYyL4GZqI0R5a8GKljUrWYKbFWf8RLru
   RsKmEaumY1nscm0XgbUtznPgV1arVoUDggLBbqqtlXo1j9/Pw6lDUusNY
   Q+Hr9PcVPa69QU3gaAxevJ7JwxClPQfhwma5Xh+5PDO6mncf4pd5R5RRi
   tSOqOxzcv9wbHZVzGtgj51eJdMLt9dZL35ZdcPPBpVN+be06NN8Haw8d/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="278387217"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="278387217"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:35:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="684626460"
Received: from gkammela-mobl.amr.corp.intel.com (HELO [10.212.33.193]) ([10.212.33.193])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 16:35:39 -0700
Message-ID: <8680a336-f4a2-7cb2-74e3-552220fc2888@linux.intel.com>
Date:   Mon, 12 Sep 2022 16:35:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1] platform/x86/intel: pmc/core: Add Raptor Lake support
 to pmc core driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, irenic.rajneesh@gmail.com,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
References: <20220830182001.3693030-1-gayatri.kammela@linux.intel.com>
 <b8a5038b-3d3a-4a2c-8fca-32b47f11e85c@redhat.com>
 <e14b3264-7e60-9cfe-34f8-f79815878d50@redhat.com>
 <8d1dec22-72e2-8297-9dbd-6b2904349fda@linux.intel.com>
 <c3401c66-251e-b009-e62f-3909ec8f52f2@redhat.com>
From:   "Kammela, Gayatri" <gayatri.kammela@linux.intel.com>
In-Reply-To: <c3401c66-251e-b009-e62f-3909ec8f52f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/2022 1:55 AM, Hans de Goede wrote:

> Hi,
>
> On 9/1/22 19:32, Kammela, Gayatri wrote:
>> On 9/1/2022 8:47 AM, Hans de Goede wrote:
>>
>>> Hi,
>>>
>>> On 9/1/22 17:43, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 8/30/22 20:20, Gayatri Kammela wrote:
>>>>> Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
>>>>> driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.
>>>>>
>>>>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>>>>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>> Cc: David Box <david.e.box@intel.com>
>>>>> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
>>>> Thank you for your patch, I've applied this patch to my review-hans
>>>> branch:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>> In file included from drivers/platform/x86/intel/pmc/core.c:29:
>>> ./arch/x86/include/asm/cpu_device_id.h:161:46: error: ‘INTEL_FAM6_RAPTORLAKE_S’ undeclared here (not in a function); did you mean ‘INTEL_FAM6_RAPTORLAKE_P’?
>>>     161 |         X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
>>>         |                                              ^~~~~~~~~~~
>>> ./arch/x86/include/asm/cpu_device_id.h:46:27: note: in definition of macro ‘X86_MATCH_VENDOR_FAM_MODEL_STEPPINGS_FEATURE’
>>>      46 |         .model          = _model,                                       \
>>>         |                           ^~~~~~
>>> ./arch/x86/include/asm/cpu_device_id.h:129:9: note: in expansion of macro ‘X86_MATCH_VENDOR_FAM_MODEL_FEATURE’
>>>     129 |         X86_MATCH_VENDOR_FAM_MODEL_FEATURE(vendor, family, model,       \
>>>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ./arch/x86/include/asm/cpu_device_id.h:161:9: note: in expansion of macro ‘X86_MATCH_VENDOR_FAM_MODEL’
>>>     161 |         X86_MATCH_VENDOR_FAM_MODEL(INTEL, 6, INTEL_FAM6_##model, data)
>>>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/platform/x86/intel/pmc/core.c:1918:9: note: in expansion of macro ‘X86_MATCH_INTEL_FAM6_MODEL’
>>>    1918 |         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &adl_reg_map),
>>>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>> make[5]: *** [scripts/Makefile.build:249: drivers/platform/x86/intel/pmc/core.o] Error 1
>>>
>>> And dropped again, please upstream this through the tree which also has the new
>>> INTEL_FAM6_RAPTORLAKE* macros.
>>>
>>> Here is my Acked-by for merging this through another tree:
>>>
>>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Regards,
>>>
>>> Hans
>> Hi Hans!
>>
>> Thank you for your Acked-by! The cpuid patch has been merged in to v6.0-rc3. I am not sure why its complaining about INTEL_FAM6_RAPTORLAKE_S being undeclared.
>>
>> patch - ea902bcc1943f7539200ec464de3f54335588774 : "x86/cpu: Add new Raptor Lake CPU model number".
>>
>> I made sure its built without errors before sending it out.
> Ah I see, but my tree (like most trees) is based on 6.0-rc1,
> please submit this patch to the same tree as through which
> ea902bcc1943f7539200ec464de3f54335588774 went upstream,
> with my Acked-by added.
>
> Thanks,
>
> Hans

Hi Hans!

I did send v2 based on review-hans branch with dependency patch 
included. Sorry for the delay and thank you!

>
>
>
>>>
>>>
>>>>> ---
>>>>>    drivers/platform/x86/intel/pmc/core.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>>>>> index a1fe1e0dcf4a..17ec5825d13d 100644
>>>>> --- a/drivers/platform/x86/intel/pmc/core.c
>>>>> +++ b/drivers/platform/x86/intel/pmc/core.c
>>>>> @@ -1914,6 +1914,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>>>>>        X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,        &tgl_reg_map),
>>>>>        X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,        &adl_reg_map),
>>>>>        X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
>>>>> +    X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,        &adl_reg_map),
>>>>> +    X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,    &adl_reg_map),
>>>>>        {}
>>>>>    };
>>>>>   
>>>>> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
