Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD08626C2F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 23:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiKLWdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 17:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbiKLWds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 17:33:48 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F47014D0B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 14:33:47 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id j6so5710354qvn.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 14:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObPzrzs7HkuXWqb/Hm/pvn03m1dpj1pmmiupPueD+24=;
        b=P52pDzOKLqNpueol/zFYV61tVVAEOij8E4TwX/Rnt0lkrzQwo/quM5rEIXj4ssfKTX
         zhM1j72PfhBL1z/Y6rNuejwrDLpgllop6c1ydULxJ34GHBn1AOA+kMOhH89AqMDneQrV
         tm19w50+8zw/SGZ/HlRCQdzTgHDbM4n5E+QHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObPzrzs7HkuXWqb/Hm/pvn03m1dpj1pmmiupPueD+24=;
        b=xMM9BxGlAHN/uzSoLfxf6EZ2w7rJnkh4R4Z14sb5ewGdEgWdBox3CUYDSkysnAsnJ6
         MkBwJotxLAvn0a4eEPyjtktMftQHwhoL6g/QptDk3UDOe8z8pW6IWw19c5ruW6GsUHKr
         2FBG3iKNblmWtS0kH11nuMWNpIp5R9t3mPxdGD2jGu3mNVSrk1AbPoqL+v0fFBPoGk+b
         inbAjj08EPyUzRPXGJNhcoA/+NfGdZ4me84lUKZE1gHVF4THRqqa5rUiK1vFg5jK0TvZ
         A5Vg8LpG6VvZJnRCccyIHzIpdnYLbE8LVTYzQMA9bLyZ6Y8RwRK2xrfJu7IcwHqoeK46
         QFCA==
X-Gm-Message-State: ANoB5pmmiS109GvCVeHswlbpDlkWr1eDQc8qFdpCNtaDjYH684t6LoN7
        T5zIS5xHz3oiib0lmVQoXVwTsg==
X-Google-Smtp-Source: AA0mqf7yNpnQLnSnYqU8ZZoSTinC44rbJi30aZc9yKIV2S+M8TQ14uhJMRQ3DpYYawi7th/xYOiHOw==
X-Received: by 2002:a05:6214:428d:b0:4b3:e8bc:b06d with SMTP id og13-20020a056214428d00b004b3e8bcb06dmr7431669qvb.72.1668292426374;
        Sat, 12 Nov 2022 14:33:46 -0800 (PST)
Received: from [192.168.2.110] (107-142-220-210.lightspeed.wlfrct.sbcglobal.net. [107.142.220.210])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a404500b006fb11eee465sm3913431qko.64.2022.11.12.14.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Nov 2022 14:33:45 -0800 (PST)
Message-ID: <f5793630-f13d-42d3-c045-276311230682@digitalocean.com>
Date:   Sat, 12 Nov 2022 17:33:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     Sandipan Das <sandipan.das@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221027133511.161922-1-lyan@digtalocean.com>
 <Y1/Gvs0xkk/W0Nro@hirez.programming.kicks-ass.net>
 <a9677c3e-1f2b-a18f-97f5-9cc1a216ed9c@amd.com>
Content-Language: en-US
From:   Liang Yan <lyan@digitalocean.com>
Subject: Re: [PATCH] arch/x86/events/amd/core.c: Return -ENODEV when CPU does
 not have PERFCTL_CORE bit
In-Reply-To: <a9677c3e-1f2b-a18f-97f5-9cc1a216ed9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/31/22 10:28, Sandipan Das wrote:
> Hi Liang, Peter,
>
> On 10/31/2022 6:29 PM, Peter Zijlstra wrote:
>> On Thu, Oct 27, 2022 at 09:35:11AM -0400, Liang Yan wrote:
>>> After disabling cpu.perfctr_core in qemu, I noticed that the guest kernel
>>> still loads the pmu driver while the cpuid does not have perfctl_core.
>>>
>>> The test is running on an EPYC Rome machine.
>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# lscpu | grep perfctl
>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~#
>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
>>> [    0.732097] Performance Events: AMD PMU driver.
>>>
>>> By further looking,
>>>
>>> ==> init_hw_perf_events
>>>      ==> amd_pmu_init
>>>          ==> amd_core_pmu_init
>>>              ==>
>>>                  if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>>> 			return 0;
>>>
>>> With returning 0, it will bypass amd_pmu_init and return 0 to
>>> init_hw_perf_events, and continue the initialization.
>>>
>>> I am not a perf expert and not sure if it is expected for AMD PMU,
>>> otherwise, it would be nice to return -ENODEV instead.
>>>
>>> New output after the change:
>>> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
>>> [    0.531609] Performance Events: no PMU driver, software events only.
>>>
>>> Signed-off-by: Liang Yan <lyan@digtalocean.com>
>> Looks about right, Ravi?
>>
>>> ---
>>>   arch/x86/events/amd/core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>>> index 8b70237c33f7..34d3d2944020 100644
>>> --- a/arch/x86/events/amd/core.c
>>> +++ b/arch/x86/events/amd/core.c
>>> @@ -1335,7 +1335,7 @@ static int __init amd_core_pmu_init(void)
>>>   	int i;
>>>   
>>>   	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>>> -		return 0;
>>> +		return -ENODEV;
>>>   
> There are four legacy counters that are always available even when PERFCTR_CORE
> is absent. This is why the code returns 0 here. I found this to be a bit confusing
> as well during PerfMonV2 development so I wrote the following patch but forgot to
> send it out.


Hi Sandipan,

Thanks for the classification.
Do these legacy counters belong to the AMD PMU property from a VM 
perspective? I mean, if I want to disable PMU for an AMD vcpu for some 
reason, is it possible to disable perfctr_core and the four counters, or 
is this not logical since the four counters could not be disabled from 
the bare-metal level?
I asked because I saw 'pmu' could be disabled for Intel and ARM, but it 
seems not for AMD.

Also, could you please list the four legacy counters here?

Thanks,
Liang


> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 262e39a85031..d3eb7b2f4dda 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1345,6 +1345,14 @@ static int __init amd_core_pmu_init(void)
>   	u64 even_ctr_mask = 0ULL;
>   	int i;
>   
> +	/*
> +	 * All processors support four PMCs even when X86_FEATURE_PERFCTR_CORE
> +	 * is unavailable. They are programmable via the PERF_LEGACY_CTLx and
> +	 * PERF_LEGACY_CTRx registers which have the same address as that of
> +	 * MSR_K7_EVNTSELx and MSR_K7_PERFCTRx. For Family 17h+, these are
> +	 * legacy aliases of PERF_CTLx and PERF_CTRx respectively. Hence, not
> +	 * returning -ENODEV here.
> +	 */
>   	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
>   		return 0;
>
>
> If this looks good to you, I will post it.
>
> - Sandipan
>
