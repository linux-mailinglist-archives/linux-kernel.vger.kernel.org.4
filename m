Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF2172EFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjFMXAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFMW7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:59:51 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8C91739
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:59:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977c72b116fso9283466b.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1686697188; x=1689289188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0cR2eMJkO0B4oBFKWp7UL22g6wqXxxe1Dgeq5u6pjCs=;
        b=n68k66ygihKoYFhLNUq0LpiphkgkcnLPiZ0rtsyKCwxcNTdKkxYqLf9dfrijSC28mf
         e72fT5CDLFnFvSaToQZxr7jHACVhdaBP3NbpaslUH/KjfiwEmC3KB/ZC4Ekh/PovudC+
         73qXASpCZTmvSHHiwG9B+PWDL2X0a9J+iyOChhaAAXJTditDSq+4HTSwOiJebm85ocXd
         wD8PDcZLvrrYro1Q/ZHuSIHkv2nFYnvA3GJN2Hg+sL0tL44L9JJgkv0KQxBEMv27hbLc
         sTXjhShErfCHe1tv3JvRn8amj7eqfGMjAmVbfY7SxHUiT1FDZ6Uvw5E51FF+nd3iUsry
         0MaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686697188; x=1689289188;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cR2eMJkO0B4oBFKWp7UL22g6wqXxxe1Dgeq5u6pjCs=;
        b=Uvya9eEFctzqHH6wOfqmHAcwO9ddLFdlbAYY4KUgt+t8gQXba388mVI3GmqIszSG9M
         YVld5utfTWPfTB2nE1drRlOaDkGvSSPp32QrixotA70q6UR3OmpSXH5bVtMzV0y4v9DZ
         XsJhmLLDwhm8GvZZmAUQkR4ma1X3g0lZeGRhncLknBXClSRy/4owOWpTsLY18XE4bfxi
         95AD8f0wHUPNPQndlaVvKKZLSYKTAZTx2epjjmxy5dFYdcY5y1QySZ2wCbfd/NaN2wuf
         Q4HMJSp4FtoSn2TVy7P3T78OzEfv854Q+7U/EydIauAVQLGteHKpC6CXfLvYjmbZzRZI
         1ZrA==
X-Gm-Message-State: AC+VfDwzBozUaPr38X/iVVyc48lJHwPv1poik/SHkX2Af35N8R/kwAWT
        UND6UtvH66BP95tC8nTkDDptiA==
X-Google-Smtp-Source: ACHHUZ6Ej2xexWpZo0K9iOy7Be1KLoiDHPU8AlHjbm3WDr9CubXC2bojorP0+Tp+qbu4s9hbFvhH/g==
X-Received: by 2002:a17:907:3203:b0:966:5c04:2c61 with SMTP id xg3-20020a170907320300b009665c042c61mr10721429ejb.8.1686697188344;
        Tue, 13 Jun 2023 15:59:48 -0700 (PDT)
Received: from ?IPV6:2003:f6:af40:b900:d400:cc2b:402:729b? (p200300f6af40b900d400cc2b0402729b.dip0.t-ipconnect.de. [2003:f6:af40:b900:d400:cc2b:402:729b])
        by smtp.gmail.com with ESMTPSA id qt17-20020a170906ecf100b00968242f8c37sm7121697ejb.50.2023.06.13.15.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 15:59:47 -0700 (PDT)
Message-ID: <5a56290d-806e-b9a5-f37c-f21958b5a8c0@grsecurity.net>
Date:   Wed, 14 Jun 2023 00:59:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] timekeeping: Align tick_sched_timer() with the HZ tick.
 -- regression report
Content-Language: en-US, de-DE
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Gusenleitner Klaus <gus@keba.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        stable@vger.kernel.org
References: <20230406095735.0_14edn3@linutronix.de>
 <20230406105529.GB392176@hirez.programming.kicks-ass.net>
 <87mt3lqnde.ffs@tglx> <20230406150254.ZrawA2Y-@linutronix.de>
 <87jzypq6gq.ffs@tglx> <20230418122639.ikgfvu3f@linutronix.de>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230418122639.ikgfvu3f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 18.04.23 14:26, Sebastian Andrzej Siewior wrote:
> [...]. The timer still fires
> every 4ms with HZ=250 but timer is no longer aligned with
> CLOCK_MONOTONIC with 0 as it origin but has an offset in the us/ns part
> of the timestamp. The offset differs with every boot and makes it
> impossible for user land to align with the tick.

I can observe these per-boot offsets too, but...

> Align the tick timer with CLOCK_MONOTONIC ensuring that it is always a
> multiple of 1000/CONFIG_HZ ms.

this change doesn't seem to achieve that goal, unfortunately. Quite the 
opposite. It makes the (boot) clock run faster and, because of the per-
boot different offset, differently fast for each boot. Up to the point 
where it's running too fast to make any progress at all.

This patch causes VM boot hangs for us. It took a while to identify as 
the boot hangs were only ~1 out of 30 but it's clearly it. Reverting 
the commit got me 100 boots in a row without any issue.

Instrumenting the kernel a little gave me a clue what the bug is. When 
switching from the boot timer tick device (which is 'hpet' in my setup) 
to 'lapic-deadline', the mode of the timer isn't changed and kept at 
TICKDEV_MODE_PERIODIC. As that device doesn't support this mode, 
tick_setup_periodic() will switch over to CLOCK_EVT_STATE_ONESHOT mode 
and program the next expire event based on tick_next_period.

clockevents_program_event() will calculate the delta of that timestamp 
and ktime_get() and pass that value on to dev->set_next_event() (which 
is lapic_next_deadline()) which will write it to the IA32_TSC_DEADLINE 
MSR.

That delta value -- which is still the per-boot different offset to 
ktime_get() your patch introduces -- now gets stuck and is taken as the 
new *jiffies tick time*. That's because tick_handle_periodic() -> 
tick_periodic() will advance tick_next_period by TICK_NSEC, make 
do_timer() increment jiffies_64 by one and then program the next event 
to be in TICK_NSEC ns based on the device's old expiry time, i.e. keep 
the offset intact. This is followed by re-arming the event by a call to 
clockevents_program_event() which does the already-know delta 
calculation and writes, again, the too little value to 
IA32_TSC_DEADLINE.

This effectively makes the jiffies based clock go too fast as the timer 
IRQ comes too early (less than TICK_NSEC ns). Sometimes it's barely 
noticeable, but sometimes it's so fast that the kernel is overloaded 
with only handling the local timer IRQ without making any further 
progress, especially in (nested) VM setups.

Without commit e9523a0d8189 ("tick/common: Align tick period with the 
HZ tick."), which was backported to many stable and LTS kernels (v6.3.2 
(571c3b46c9b3), v6.2.15 (f0cb827199ec), v6.1.28 (290e26ec0d01), 
v5.15.111 (a55050c7989c), v5.10.180 (c4013689269d) and v5.4.243 
(a3e7a3d472c2)) this clock drift is gone and my VMs boot again.

Before that commit, the delta between tick_next_period and ktime_get() 
was initially zero, so tick_handle_period() had to loop, as 
clockevents_program_event() will return with -ETIME. The next attempt 
would be done with a delta of TICK_NSEC which will make 
clockevents_program_event() succeed and ensure that future events don't 
need the additional loop iteration, as the delta got stuck at TICK_NSEC 
-- exactly where it should be.

We observed the bug first on the v6.3, v6.1 and v5.15 stable branch 
updates from May 11th and then, a week later, on v5.4 too. All first 
occurrences were coinciding with the bad commit going into the 
corresponding stable and LTS kernel releases.

The issue manifests itself as a fast running clock only during boot, 
when the clock source is still jiffies based. That'll eventually lead 
to a boot hang as the timer IRQs are firing too fast.

To reproduce this you can either boot loop a VM and try to get "lucky" 
to hit a big enough 'rem' value or just apply this little diff instead:

---8<---
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 65b8658da829..b01cf18a5d42 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -225,6 +225,7 @@ static void tick_setup_device(struct tick_device *td,
 
 			next_p = ktime_get();
 			div_u64_rem(next_p, TICK_NSEC, &rem);
+			rem = TICK_NSEC - 123;
 			if (rem) {
 				next_p -= rem;
 				next_p += TICK_NSEC;
--->8---

This should make the kernel get stuck with only handling timer ticks 
but not making any further progress.

Change the subtrahend to 1234 to get a system that boots but has an 
unrealistically fast clock during kernel initialization.

As reverting that commit fixes the issue for us but it seemingly fixes 
another bug for Klaus (or at least attempted to), the now uncovered bug 
should be fixed instead.

The fundamental issue is that the jiffies based clock source cannot be 
trusted and shouldn't be used to calculate offsets to timestamps in the 
future when tick_next_period mod ktime_get() != 0.

Can we defer the offset adjustment of tick_next_period to a later point 
in time when a stable clock source gets used, like 'tsc'?

Thanks,
Mathias
