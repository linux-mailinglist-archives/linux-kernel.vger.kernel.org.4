Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F0A641F3F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 20:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiLDTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 14:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLDTUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 14:20:42 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F6110064;
        Sun,  4 Dec 2022 11:20:41 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13bd2aea61bso11269327fac.0;
        Sun, 04 Dec 2022 11:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yeg3edC/r39iIOK6guEWh/CYd2mkGIMBeuem4TqRves=;
        b=PBjsnfXRRHhZf7FuPDQII/O9XoCBbkiewPEChkEudn/gfnYugmKwmn8LAKPzydScaQ
         ZpYwGb6hnHHSjEnxqDajnPYpgTOhyQTI538m1yCrIbGirZcJ002DURcR1Gg3NCDCNP0e
         I2VZMvNt1Z7oXFQTZZGgMN8H4mMXCszbW6GEiFoyuAWj4Jg5nM7GeWPi2unOJpunAQED
         OiMsqcimGHZsf1BEZPk8CiqZoVrEcaBLNw1e1jUozv3SrMVmb3n3I3TxTWGNZwXSrMJs
         DX8o34VKQPe/4y/DFrKhSMAN3rDmh+8On3VR/rptnainIrumtDM6sQ5lemSiniPr+NIb
         tbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeg3edC/r39iIOK6guEWh/CYd2mkGIMBeuem4TqRves=;
        b=XyTayFqioo7f0+qV1dx4nDJDhls0cGPIZao6MNGBiFf3taWMkxYKVmCgfMugWh9C/R
         SCFjXSYvlPfB/CgrGzA5Kx45Cip08Nx5MWSl9AAAtJPQcwmy43bTwn4Pjfv3aFc5Eqfn
         6P1K93xLxpyKWPucy7VW7Mf9csUNtPoV+uhGw6U+tNjK4Db+qqCU9XieishG+l/TO4oM
         Ha70mziVnWevShhnwBL5SncmAcEmZqwKjgD4xyStY2ZCtyf8Ebf379t0c7OAbCzxfvbm
         S+U+Nlb3dsH0wRR9DjuP3IQQhiSHd7NoV7O4EJQyJ2+iNf6SpKwn+7INSoowegpZ3GDq
         haGA==
X-Gm-Message-State: ANoB5pnovpyQDxfCbnSoGmxldxsAuy5vhNYg9m4xvQRHrlHEVrdYz4+V
        z++0EpwEQ+FUNzFvKGgK6+Q=
X-Google-Smtp-Source: AA0mqf7SUmshliU5Vd590jvKFPnvm1M+dCWq120e8JWYZFkQ1NPx24+qr/n0vnjvTgoNYHNHbXNVZw==
X-Received: by 2002:a05:6870:4b91:b0:142:fe1c:7a4 with SMTP id lx17-20020a0568704b9100b00142fe1c07a4mr34038313oab.114.1670181640695;
        Sun, 04 Dec 2022 11:20:40 -0800 (PST)
Received: from ?IPV6:2603:8081:2802:9dfb:b9b:12f2:9a60:2073? (2603-8081-2802-9dfb-0b9b-12f2-9a60-2073.res6.spectrum.com. [2603:8081:2802:9dfb:b9b:12f2:9a60:2073])
        by smtp.gmail.com with ESMTPSA id 67-20020a9d02c9000000b0066ac42bc8a4sm6569154otl.33.2022.12.04.11.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 11:20:40 -0800 (PST)
Message-ID: <7a094893-0c2e-a09b-3a10-02fe7aa8680b@gmail.com>
Date:   Sun, 4 Dec 2022 13:20:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] cpufreq: acpi: Defer setting boost MSRs
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Meyer <kyle.meyer@hpe.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221102195957.82871-1-stuart.w.hayes@gmail.com>
 <CAJZ5v0iM28y2YSWOv81VCB9vqh2xwJcz36wnR7PujDehvrkN-Q@mail.gmail.com>
 <Y4zm9T+WYmyWwik4@zn.tnic>
From:   stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <Y4zm9T+WYmyWwik4@zn.tnic>
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



On 12/4/2022 12:29 PM, Borislav Petkov wrote:
> On Thu, Nov 03, 2022 at 07:19:47PM +0100, Rafael J. Wysocki wrote:
>> On Wed, Nov 2, 2022 at 9:01 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>>>
>>> When acpi-cpufreq is loaded, boost is enabled on every CPU (by setting an
>>> MSR) before the driver is registered with cpufreq.  This can be very time
>>> consuming, because it is done with a CPU hotplug startup callback, and
>>> cpuhp_setup_state() schedules the callback (cpufreq_boost_online()) to run
>>> on each CPU one at a time, waiting for each to run before calling the next.
>>>
>>> If cpufreq_register_driver() fails--if, for example, there are no ACPI
>>> P-states present--this is wasted time.
>>>
>>> Since cpufreq already sets up a CPU hotplug startup callback if and when
>>> acpi-cpufreq is registered, set the boost MSRs in acpi_cpufreq_cpu_init(),
>>> which is called by the cpufreq cpuhp callback.  This allows acpi-cpufreq to
>>> exit quickly if it is loaded but not needed.
>>>
>>> On one system with 192 CPUs, this patch speeds up boot by about 30 seconds.
>>>
>>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>>> ---
>>>   drivers/cpufreq/acpi-cpufreq.c | 31 +++----------------------------
>>>   1 file changed, 3 insertions(+), 28 deletions(-)
> 
> ...
> 
>> Applied as 6.2 material, thanks!
> 
> My 32-bit Atom doesn't like this one. Reverting fixes it ofc.
> 
> [   22.780260] unchecked MSR access error: WRMSR to 0x1a0 (tried to write 0x0000004364950488) at rIP: 0xf80b37d4 (boost_set_msr.isra.0+0x9c/0x114 [acpi_cpufreq])
> [   22.781186] Call Trace:
> [   22.781186]  boost_set_msr_each+0x15/0x1c [acpi_cpufreq]
> [   22.781186]  __flush_smp_call_function_queue+0x132/0x1cc
> [   22.781186]  ? sysvec_call_function+0x30/0x30
> [   22.781186]  generic_smp_call_function_single_interrupt+0x12/0x18
> [   22.781186]  __sysvec_call_function_single.constprop.0+0x43/0x1d8
> [   22.781186]  sysvec_call_function_single+0x18/0x30
> [   22.781186]  handle_exception+0x133/0x133
> [   22.781186] EIP: finish_task_switch.isra.0+0x124/0x3a8
> [   22.781186] Code: d8 e8 8c 16 92 00 85 f6 75 e8 a1 04 24 6c c2 85 c0 0f 8f 9b 00 00 00 89 d8 e8 e4 02 92 00 e8 53 9e 0b 00 fb 64 a1 40 f9 69 c2 <8b> 80 5c 0f 00 00 85 c0 0f 85 72 01 00 00 a1 28 24 6c c2 64 8b 15
> [   22.781186] EAX: c32e2700 EBX: f748af40 ECX: 00000000 EDX: c1c3876e
> [   22.781186] ESI: 00000000 EDI: 00000000 EBP: c3241f90 ESP: c3241f78
> [   22.781186] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00000206
> [   22.781186]  ? uevent_seqnum_show+0x1b/0x28
> [   22.781186]  ? pid_list_refill_irq+0x128/0x1c0
> [   22.781186]  ? sysvec_call_function+0x30/0x30
> [   22.781186]  ? pid_list_refill_irq+0x128/0x1c0
> [   22.781186]  ? sysvec_call_function+0x30/0x30
> [   22.781186]  ? finish_task_switch.isra.0+0x124/0x3a8
> [   22.781186]  schedule_tail+0x12/0x78
> [   22.781186]  schedule_tail_wrapper+0x9/0x10
> [   22.781186]  ret_from_fork+0x5/0x28
> [   22.781186] EIP: 0xb7fba549
> [   22.781186] Code: Unable to access opcode bytes at 0xb7fba51f.
> [   22.781186] EAX: 00000000 EBX: 01200011 ECX: 00000000 EDX: 00000000
> [   22.781186] ESI: 00000000 EDI: b7bfe868 EBP: 00000000 ESP: bfcfedc0
> [   22.781186] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
> 

I believe I see the problem... acpi_cpufreq_cpu_init is calling set_boost() directly without checking to see if acpi_cpufreq_driver.set_boost was set, so it is trying to set the MSR on CPUs that don't support it.

Thanks, I can submit a patch to fix this.
