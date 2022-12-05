Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB92643889
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiLEW55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiLEW5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:57:54 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1FB645C;
        Mon,  5 Dec 2022 14:57:53 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id m7-20020a9d6447000000b0066da0504b5eso8204506otl.13;
        Mon, 05 Dec 2022 14:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUA8Hjavk9jl8IDWhKAbqmOg84KSsTmjB2HB9kbsKCQ=;
        b=l0L7JWjfg3WOe2LrEUdjK49Z3m38sO7xbO4z4qpnrq/JsNi/Hha8FUgfK8I0I9aMKx
         Fa8AQH8PyXldZ5Ym1p/EjKr93XrDqdiqUYR+cNQE4DBmhSHMg0yKbciKtpCRH8YiElrx
         EKl1YqUCU5znyy1cF1WJFfe8tZOXwBoliZ0cmfcnNYJTftcLzdat5ymksNWJhzXhU98a
         JuvVBOr/6noXW4CtOozOV/3pndFWvS1YOL6pwd6y6vlSrCWUPBShftzRbmwJWdbvXzGx
         2W0M9TBe1phFD36OBedhTkcUQxruI1noEiD6HEy/lOe4hHRpcHrGOPniitlVlW4gravV
         ThyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUA8Hjavk9jl8IDWhKAbqmOg84KSsTmjB2HB9kbsKCQ=;
        b=iXpzveKXmPHuwJreASriOeK0ZaB+tm67x3Dd+Lywh40vIA3Cnd9Ywf0J0LQb9wL7jv
         FL3zmveOoxyJ7h8w5gz9/Q/+YvscPAQWNAmrfgqjzZfQ0ZEZt21dwYEteOezXZbzvHRC
         pk5LtClaT2/PjZl+uFxKUr0u3JXQTA3PXvsUG0uDoBr9p99pKrzyucnjj5RS0g0YPkJE
         cS32Oyi6vDJpI0/FBXyLYdZVMstf9zc3aLdAPyjDtHsKI27iemLmILK3voHqSkmDfS5w
         1bdpNXfOayZaMXPnFXY1evZVPGYvyugkL1aieI/0SZUfE0N9feH23LuLVqOQfvqUYh4F
         /uhg==
X-Gm-Message-State: ANoB5pmqC8Ex/N79YsZTOi0BNIOW4sFFzQ3E/S9cn5zHc6K0qzbp1FYY
        qBuOUuH/aHMYlEJBuk4bWmc=
X-Google-Smtp-Source: AA0mqf5rdlD9c/9NnVzzGI1Kkk4X9Y773zD7Syf5PRYz+BBgFWgJCJ4Pw7xV/0Py/PniW6Sjju6Oaw==
X-Received: by 2002:a9d:34f:0:b0:66f:5cc0:7354 with SMTP id 73-20020a9d034f000000b0066f5cc07354mr2459525otv.190.1670281072642;
        Mon, 05 Dec 2022 14:57:52 -0800 (PST)
Received: from ?IPV6:2603:8081:2802:9dfb:b9b:12f2:9a60:2073? (2603-8081-2802-9dfb-0b9b-12f2-9a60-2073.res6.spectrum.com. [2603:8081:2802:9dfb:b9b:12f2:9a60:2073])
        by smtp.gmail.com with ESMTPSA id a7-20020a9d4707000000b0066e7e4b2f76sm5939960otf.17.2022.12.05.14.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 14:57:52 -0800 (PST)
Message-ID: <ab066f39-d766-7a6e-3dc0-4a4847babe28@gmail.com>
Date:   Mon, 5 Dec 2022 16:57:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] cpufreq: acpi: Defer setting boost MSRs
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Meyer <kyle.meyer@hpe.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221102195957.82871-1-stuart.w.hayes@gmail.com>
 <CAJZ5v0iM28y2YSWOv81VCB9vqh2xwJcz36wnR7PujDehvrkN-Q@mail.gmail.com>
 <Y4zm9T+WYmyWwik4@zn.tnic> <7a094893-0c2e-a09b-3a10-02fe7aa8680b@gmail.com>
 <CAJZ5v0gthM-shi9udDmjiknKV29DYOr5o6b4b=taJEwZedM5=w@mail.gmail.com>
Content-Language: en-US
From:   stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <CAJZ5v0gthM-shi9udDmjiknKV29DYOr5o6b4b=taJEwZedM5=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/2022 6:43 AM, Rafael J. Wysocki wrote:
> On Sun, Dec 4, 2022 at 8:20 PM stuart hayes <stuart.w.hayes@gmail.com> wrote:
>>
>>
>>
>> On 12/4/2022 12:29 PM, Borislav Petkov wrote:
>>> On Thu, Nov 03, 2022 at 07:19:47PM +0100, Rafael J. Wysocki wrote:
>>>> On Wed, Nov 2, 2022 at 9:01 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>>>>>
>>>>> When acpi-cpufreq is loaded, boost is enabled on every CPU (by setting an
>>>>> MSR) before the driver is registered with cpufreq.  This can be very time
>>>>> consuming, because it is done with a CPU hotplug startup callback, and
>>>>> cpuhp_setup_state() schedules the callback (cpufreq_boost_online()) to run
>>>>> on each CPU one at a time, waiting for each to run before calling the next.
>>>>>
>>>>> If cpufreq_register_driver() fails--if, for example, there are no ACPI
>>>>> P-states present--this is wasted time.
>>>>>
>>>>> Since cpufreq already sets up a CPU hotplug startup callback if and when
>>>>> acpi-cpufreq is registered, set the boost MSRs in acpi_cpufreq_cpu_init(),
>>>>> which is called by the cpufreq cpuhp callback.  This allows acpi-cpufreq to
>>>>> exit quickly if it is loaded but not needed.
>>>>>
>>>>> On one system with 192 CPUs, this patch speeds up boot by about 30 seconds.
>>>>>
>>>>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>>>>> ---
>>>>>    drivers/cpufreq/acpi-cpufreq.c | 31 +++----------------------------
>>>>>    1 file changed, 3 insertions(+), 28 deletions(-)
>>>
>>> ...
>>>
>>>> Applied as 6.2 material, thanks!
>>>
>>> My 32-bit Atom doesn't like this one. Reverting fixes it ofc.
>>>
>>> [   22.780260] unchecked MSR access error: WRMSR to 0x1a0 (tried to write 0x0000004364950488) at rIP: 0xf80b37d4 (boost_set_msr.isra.0+0x9c/0x114 [acpi_cpufreq])
>>> [   22.781186] Call Trace:
>>> [   22.781186]  boost_set_msr_each+0x15/0x1c [acpi_cpufreq]
>>> [   22.781186]  __flush_smp_call_function_queue+0x132/0x1cc
>>> [   22.781186]  ? sysvec_call_function+0x30/0x30
>>> [   22.781186]  generic_smp_call_function_single_interrupt+0x12/0x18
>>> [   22.781186]  __sysvec_call_function_single.constprop.0+0x43/0x1d8
>>> [   22.781186]  sysvec_call_function_single+0x18/0x30
>>> [   22.781186]  handle_exception+0x133/0x133
>>> [   22.781186] EIP: finish_task_switch.isra.0+0x124/0x3a8
>>> [   22.781186] Code: d8 e8 8c 16 92 00 85 f6 75 e8 a1 04 24 6c c2 85 c0 0f 8f 9b 00 00 00 89 d8 e8 e4 02 92 00 e8 53 9e 0b 00 fb 64 a1 40 f9 69 c2 <8b> 80 5c 0f 00 00 85 c0 0f 85 72 01 00 00 a1 28 24 6c c2 64 8b 15
>>> [   22.781186] EAX: c32e2700 EBX: f748af40 ECX: 00000000 EDX: c1c3876e
>>> [   22.781186] ESI: 00000000 EDI: 00000000 EBP: c3241f90 ESP: c3241f78
>>> [   22.781186] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000206
>>> [   22.781186]  ? uevent_seqnum_show+0x1b/0x28
>>> [   22.781186]  ? pid_list_refill_irq+0x128/0x1c0
>>> [   22.781186]  ? sysvec_call_function+0x30/0x30
>>> [   22.781186]  ? pid_list_refill_irq+0x128/0x1c0
>>> [   22.781186]  ? sysvec_call_function+0x30/0x30
>>> [   22.781186]  ? finish_task_switch.isra.0+0x124/0x3a8
>>> [   22.781186]  schedule_tail+0x12/0x78
>>> [   22.781186]  schedule_tail_wrapper+0x9/0x10
>>> [   22.781186]  ret_from_fork+0x5/0x28
>>> [   22.781186] EIP: 0xb7fba549
>>> [   22.781186] Code: Unable to access opcode bytes at 0xb7fba51f.
>>> [   22.781186] EAX: 00000000 EBX: 01200011 ECX: 00000000 EDX: 00000000
>>> [   22.781186] ESI: 00000000 EDI: b7bfe868 EBP: 00000000 ESP: bfcfedc0
>>> [   22.781186] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
>>>
>>
>> I believe I see the problem... acpi_cpufreq_cpu_init is calling set_boost() directly without checking to see if acpi_cpufreq_driver.set_boost was set, so it is trying to set the MSR on CPUs that don't support it.
>>
>> Thanks, I can submit a patch to fix this.
> 
> Yes, please.
> 
> Note that I need to get this fix shortly, though, or I will just
> revert the problemating commit before the 6.2 merge window opens.

I sent it a few hours ago as "[PATCH] cpufreq: acpi: Only set boost MSRs on supported CPUs".
Thanks!


