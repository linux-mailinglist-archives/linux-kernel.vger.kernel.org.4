Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A526D67C944
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbjAZK5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236210AbjAZK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:57:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE81AF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:57:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id q5so1395167wrv.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDiApTji0XjsfqEXdYJL1n2uax2N78XbNZ4XDI7fuwk=;
        b=DHrGtcDXc8AHvFDqMm8xWT6waR4SvL5ELPg1uemmulk0FQYWGvuPW5kPi8Ehg29uil
         gElr1B6jmoUNm9/0W6GDF+jIQPth/pWZjGU4RTSbquhwlOod/Jv9LCsw6ZzOir+14AM0
         xzqpH1eXW/nGxEbIHJgJvP3FzWQhpNUXgkOUvBXLDMqUIrGM7kvHLR2a4mRrrZ8kVuSg
         Gn3Fzg22A3N49VxGUTz2is77F9jRWY/ecMq1lBnXYpYAr7AK9A45Y5NxmFL2h3wNWxPz
         fdwf4tzzgmJJvjvmPWWu4BHeUJFx8i66SVFx2R0H568nhAF8z/rtPh3pefrspVupTXEK
         s0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tDiApTji0XjsfqEXdYJL1n2uax2N78XbNZ4XDI7fuwk=;
        b=r7Z7xLE6dppyuVmpCia1zQzqBov8CCjdlIZtYDR2Od0VZ61l5j9rUZhzgGpONLQ7WS
         RGpYWZ1S0DxB2d5HaSQL+jngOluj47whcLnaIN9bZz1GW52yfn6wxO5dF3Cx/u1hh4cn
         kQ073QRuy5gWKN+L4FCpbqBNjcCiAFIjUvxkGOdCMrRxpm/ZkgAwKu4j4MwGwhlLL1Uq
         u1/cG0fSh5SDIZ6aF/fzMLWYwdMaEkDq1RvoQAkMnOWPN9qdCdz2vDT/bi3eVH3zxrQB
         z7BjZvvyVV7P73uy5oMk7XfQPK2XGvZ9WpFesQg7nCkpRph1MxxSwpFZCCNAWwUNmnuM
         WWbw==
X-Gm-Message-State: AO0yUKUAmG8sFq64ks9m5dxWa7+MCIPzk6SLigVWrI0r7Ea0chQFMI/o
        VzRKPnadZrTgd6pR6++6JxNxfQ==
X-Google-Smtp-Source: AK7set+SB4hAIgN5uQhmDNcIK4/4f01zFjizJyCkhyujoOLg1M/EW9o1v8/j2PE1Fg4EyEAsoyLPhg==
X-Received: by 2002:a05:6000:184f:b0:2bf:c21f:329e with SMTP id c15-20020a056000184f00b002bfc21f329emr2779356wri.3.1674730663197;
        Thu, 26 Jan 2023 02:57:43 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id c7-20020adfe707000000b002bfb0c5527esm962954wrm.109.2023.01.26.02.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:57:42 -0800 (PST)
Message-ID: <9b7337b7-756a-2066-aaf6-ca0e57e5b4de@linaro.org>
Date:   Thu, 26 Jan 2023 11:57:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 clocksource 6/7] clocksource: Verify HPET and PMTMR
 when TSC unverified
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Waiman Long <longman@redhat.com>,
        x86@kernel.org
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230125002730.1471349-6-paulmck@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230125002730.1471349-6-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

are you ok with this patch ? Shall I pick it ?

Thanks

   -- Daniel


On 25/01/2023 01:27, Paul E. McKenney wrote:
> On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
> NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
> TSC is disabled.  This works well much of the time, but there is the
> occasional production-level system that meets all of these criteria, but
> which still has a TSC that skews significantly from atomic-clock time.
> This is usually attributed to a firmware or hardware fault.  Yes, the
> various NTP daemons do express their opinions of userspace-to-atomic-clock
> time skew, but they put them in various places, depending on the daemon
> and distro in question.  It would therefore be good for the kernel to
> have some clue that there is a problem.
> 
> The old behavior of marking the TSC unstable is a non-starter because a
> great many workloads simply cannot tolerate the overheads and latencies
> of the various non-TSC clocksources.  In addition, NTP-corrected systems
> sometimes can tolerate significant kernel-space time skew as long as
> the userspace time sources are within epsilon of atomic-clock time.
> 
> Therefore, when watchdog verification of TSC is disabled, enable it for
> HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> time-skew diagnostic without degrading the system's performance.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: <x86@kernel.org>
> Tested-by: Feng Tang <feng.tang@intel.com>
> ---
>   arch/x86/include/asm/time.h   | 1 +
>   arch/x86/kernel/hpet.c        | 2 ++
>   arch/x86/kernel/tsc.c         | 5 +++++
>   drivers/clocksource/acpi_pm.c | 6 ++++--
>   4 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
> index 8ac563abb567b..a53961c64a567 100644
> --- a/arch/x86/include/asm/time.h
> +++ b/arch/x86/include/asm/time.h
> @@ -8,6 +8,7 @@
>   extern void hpet_time_init(void);
>   extern void time_init(void);
>   extern bool pit_timer_init(void);
> +extern bool tsc_clocksource_watchdog_disabled(void);
>   
>   extern struct clock_event_device *global_clock_event;
>   
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index 71f336425e58a..c8eb1ac5125ab 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -1091,6 +1091,8 @@ int __init hpet_enable(void)
>   	if (!hpet_counting())
>   		goto out_nohpet;
>   
> +	if (tsc_clocksource_watchdog_disabled())
> +		clocksource_hpet.flags |= CLOCK_SOURCE_MUST_VERIFY;
>   	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
>   
>   	if (id & HPET_ID_LEGSUP) {
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index a78e73da4a74b..af3782fb6200c 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1186,6 +1186,11 @@ static void __init tsc_disable_clocksource_watchdog(void)
>   	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
>   }
>   
> +bool tsc_clocksource_watchdog_disabled(void)
> +{
> +	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY);
> +}
> +
>   static void __init check_system_tsc_reliable(void)
>   {
>   #if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
> diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
> index 279ddff81ab49..82338773602ca 100644
> --- a/drivers/clocksource/acpi_pm.c
> +++ b/drivers/clocksource/acpi_pm.c
> @@ -23,6 +23,7 @@
>   #include <linux/pci.h>
>   #include <linux/delay.h>
>   #include <asm/io.h>
> +#include <asm/time.h>
>   
>   /*
>    * The I/O port the PMTMR resides at.
> @@ -210,8 +211,9 @@ static int __init init_acpi_pm_clocksource(void)
>   		return -ENODEV;
>   	}
>   
> -	return clocksource_register_hz(&clocksource_acpi_pm,
> -						PMTMR_TICKS_PER_SEC);
> +	if (tsc_clocksource_watchdog_disabled())
> +		clocksource_acpi_pm.flags |= CLOCK_SOURCE_MUST_VERIFY;
> +	return clocksource_register_hz(&clocksource_acpi_pm, PMTMR_TICKS_PER_SEC);
>   }
>   
>   /* We use fs_initcall because we want the PCI fixups to have run

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

