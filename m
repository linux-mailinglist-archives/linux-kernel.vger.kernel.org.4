Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CD685C71
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 01:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjBAAuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 19:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjBAAuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 19:50:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89DE5420B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 16:50:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67D8BB81FCD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A118C433D2;
        Wed,  1 Feb 2023 00:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675212637;
        bh=i7A155inveJdph4tpzmVjkuXEr70uWnEgiqPBrxQf+Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ro/NpVrD/l8tPeDChw4K70wDLBGKfnsvlkz4ARnWCZlIHe1p1v8uYML5ne30k9Keb
         uNl8Z0Dd9A5pZKglhulwMQi3S5UHzI+El9bRMQ7MAAUDlGg/o188DN7MTpCaG1l694
         2wqSCaPnAfbPVCjhSFpPWKcd1W7o54Ty09O+Yru6WAtWyp3aShCyI28HgRga35Y/Ga
         9mpb7VydWMWrcYNleLdWaOS8PtoE6WUSLnTr4AP7POFMAFAzANNK8fgKkB1OUgwtRC
         bn0Dg8f3rbeCG+Sqz56XVXaDm9x43Kiz8TOgB7+nX+NlxMwAiqaBy4pEdpBh4+SCk2
         TcAPyxwzseGxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A1FFC5C0623; Tue, 31 Jan 2023 16:50:36 -0800 (PST)
Date:   Tue, 31 Jan 2023 16:50:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@meta.com,
        neeraju@codeaurora.org, ak@linux.intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Waiman Long <longman@redhat.com>,
        x86@kernel.org
Subject: Re: [PATCH v2 clocksource 6/7] clocksource: Verify HPET and PMTMR
 when TSC unverified
Message-ID: <20230201005036.GA3855979@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230125002708.GA1471122@paulmck-ThinkPad-P17-Gen-1>
 <20230125002730.1471349-6-paulmck@kernel.org>
 <9b7337b7-756a-2066-aaf6-ca0e57e5b4de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b7337b7-756a-2066-aaf6-ca0e57e5b4de@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 11:57:41AM +0100, Daniel Lezcano wrote:
> 
> Hi Thomas,
> 
> are you ok with this patch ? Shall I pick it ?

Seeing no response, I sent a pull request.

If it would be helpful for me to make the pilgrimmage to (say) Intel
Jones Farm, I can easily make that trip.

							Thanx, Paul

> Thanks
> 
>   -- Daniel
> 
> 
> On 25/01/2023 01:27, Paul E. McKenney wrote:
> > On systems with two or fewer sockets, when the boot CPU has CONSTANT_TSC,
> > NONSTOP_TSC, and TSC_ADJUST, clocksource watchdog verification of the
> > TSC is disabled.  This works well much of the time, but there is the
> > occasional production-level system that meets all of these criteria, but
> > which still has a TSC that skews significantly from atomic-clock time.
> > This is usually attributed to a firmware or hardware fault.  Yes, the
> > various NTP daemons do express their opinions of userspace-to-atomic-clock
> > time skew, but they put them in various places, depending on the daemon
> > and distro in question.  It would therefore be good for the kernel to
> > have some clue that there is a problem.
> > 
> > The old behavior of marking the TSC unstable is a non-starter because a
> > great many workloads simply cannot tolerate the overheads and latencies
> > of the various non-TSC clocksources.  In addition, NTP-corrected systems
> > sometimes can tolerate significant kernel-space time skew as long as
> > the userspace time sources are within epsilon of atomic-clock time.
> > 
> > Therefore, when watchdog verification of TSC is disabled, enable it for
> > HPET and PMTMR (AKA ACPI PM timer).  This provides the needed in-kernel
> > time-skew diagnostic without degrading the system's performance.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: <x86@kernel.org>
> > Tested-by: Feng Tang <feng.tang@intel.com>
> > ---
> >   arch/x86/include/asm/time.h   | 1 +
> >   arch/x86/kernel/hpet.c        | 2 ++
> >   arch/x86/kernel/tsc.c         | 5 +++++
> >   drivers/clocksource/acpi_pm.c | 6 ++++--
> >   4 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/time.h b/arch/x86/include/asm/time.h
> > index 8ac563abb567b..a53961c64a567 100644
> > --- a/arch/x86/include/asm/time.h
> > +++ b/arch/x86/include/asm/time.h
> > @@ -8,6 +8,7 @@
> >   extern void hpet_time_init(void);
> >   extern void time_init(void);
> >   extern bool pit_timer_init(void);
> > +extern bool tsc_clocksource_watchdog_disabled(void);
> >   extern struct clock_event_device *global_clock_event;
> > diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> > index 71f336425e58a..c8eb1ac5125ab 100644
> > --- a/arch/x86/kernel/hpet.c
> > +++ b/arch/x86/kernel/hpet.c
> > @@ -1091,6 +1091,8 @@ int __init hpet_enable(void)
> >   	if (!hpet_counting())
> >   		goto out_nohpet;
> > +	if (tsc_clocksource_watchdog_disabled())
> > +		clocksource_hpet.flags |= CLOCK_SOURCE_MUST_VERIFY;
> >   	clocksource_register_hz(&clocksource_hpet, (u32)hpet_freq);
> >   	if (id & HPET_ID_LEGSUP) {
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index a78e73da4a74b..af3782fb6200c 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -1186,6 +1186,11 @@ static void __init tsc_disable_clocksource_watchdog(void)
> >   	clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
> >   }
> > +bool tsc_clocksource_watchdog_disabled(void)
> > +{
> > +	return !(clocksource_tsc.flags & CLOCK_SOURCE_MUST_VERIFY);
> > +}
> > +
> >   static void __init check_system_tsc_reliable(void)
> >   {
> >   #if defined(CONFIG_MGEODEGX1) || defined(CONFIG_MGEODE_LX) || defined(CONFIG_X86_GENERIC)
> > diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
> > index 279ddff81ab49..82338773602ca 100644
> > --- a/drivers/clocksource/acpi_pm.c
> > +++ b/drivers/clocksource/acpi_pm.c
> > @@ -23,6 +23,7 @@
> >   #include <linux/pci.h>
> >   #include <linux/delay.h>
> >   #include <asm/io.h>
> > +#include <asm/time.h>
> >   /*
> >    * The I/O port the PMTMR resides at.
> > @@ -210,8 +211,9 @@ static int __init init_acpi_pm_clocksource(void)
> >   		return -ENODEV;
> >   	}
> > -	return clocksource_register_hz(&clocksource_acpi_pm,
> > -						PMTMR_TICKS_PER_SEC);
> > +	if (tsc_clocksource_watchdog_disabled())
> > +		clocksource_acpi_pm.flags |= CLOCK_SOURCE_MUST_VERIFY;
> > +	return clocksource_register_hz(&clocksource_acpi_pm, PMTMR_TICKS_PER_SEC);
> >   }
> >   /* We use fs_initcall because we want the PCI fixups to have run
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
