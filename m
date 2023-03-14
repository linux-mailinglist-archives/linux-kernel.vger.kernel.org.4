Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E496B873E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCNAwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCNAwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:52:53 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5635B136C2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:52:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r4so7881803ila.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678755171;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHzjH7VglcppZFTUdFm592XUYZ3bt2CwGqlDMyOUI3s=;
        b=WSZTts/id8ucNGvnP/AHh7ge3JvSfRpInRare3/mS+SKvXXFQ/ykW8jTykGqXl4cvG
         iVbEyAdcJmpvwXbwWimibaY6wLlbf0QxjMkizuhido22EI9ccgaThl9YwDGZct3HBirN
         ieul0p+M+EmM+tPDOeyT+GYG410tSXCWO5QOQFwaG1qx+M5T87zJEmP83KT0rVtgyLwS
         W0ccIpcVn4XKCUZOSkxWi5jmLq3l8CAfJr8Y+LxjhAwPIhKlxcGSBdn2f9iu+NMcSC8A
         zr1OstRNmGK/xqPphP7EghpxOkXTwzcXFfexe7efxjtnotS/fTyddUAT4Eq25WR432ON
         5koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678755171;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHzjH7VglcppZFTUdFm592XUYZ3bt2CwGqlDMyOUI3s=;
        b=FB1QU26H/Zgm1y1Q4ZyZG5GtwZdhs+18ljOPVgZ+SkmCnsDQBgisLCBAhjqMcIPqIc
         iE/rdDW40laiHqKTUC13hwPA/NI7n0SlZ3f74Et2IqmUL/SN9VXll61i7mmBzY42BfR3
         Fc0svaN0d0HU+XlPQSfCHAZANUXZdxKXQfgComA7iwmVVIoAa0gSbM9n5/pHt76VjN1H
         0o8WUezi0JilOzXGR7Vmz7Bkyuuas6CS4LYytJG5vC9igXYh8z9R7EwDm9cXxRICTcYA
         wKDja5DWBryHRR4J2K5dMoKd12qHj8PCXK76DKqh1FLwbEX4dYVVEYqwqZdaFkoXeYwX
         5wgg==
X-Gm-Message-State: AO0yUKWGbZQY61HaNdcHnn+xTEEn6aqZCsLginweHcUWGWZPxDNSg0NP
        6irob4InZtMDfiYyQ5AFDUQ=
X-Google-Smtp-Source: AK7set96w0xlkbdEsvmQ7AFx3bUwX6ouwo0w7Bu3FALMc5QyzxgUTASVNAjAWROZKvMqrz7sCZxtog==
X-Received: by 2002:a05:6e02:966:b0:311:1168:b9b5 with SMTP id q6-20020a056e02096600b003111168b9b5mr1052754ilt.23.1678755171634;
        Mon, 13 Mar 2023 17:52:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j2-20020a926e02000000b003230ef87bf4sm376907ilc.37.2023.03.13.17.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 17:52:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dc031bc7-8ca4-7ca7-c24f-9db65b5547e4@roeck-us.net>
Date:   Mon, 13 Mar 2023 17:52:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
 <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
 <ZA+ttVOPBvNOYHoC@lothringen>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 6.3-rc2
In-Reply-To: <ZA+ttVOPBvNOYHoC@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 16:11, Frederic Weisbecker wrote:
> On Mon, Mar 13, 2023 at 11:21:44AM -0700, Linus Torvalds wrote:
[ ... ]
> It would be interesting to see what the IRQ is interrupting. For example does it
> happen while softirqs are serviced or just disabled? Or are we even outside any
> of that? Any chance we can have a deeper stack trace? If not at least a print of
> preempt_count() would be helpful.
> 
> Both would be awesome.
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 50d4863974e7..a7d1a65e5425 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5523,6 +5523,7 @@ static noinstr void check_flags(unsigned long flags)
>   	 */
>   	if (!hardirq_count()) {
>   		if (softirq_count()) {
> +			printk("preempt_count(): %x", preempt_count());
>   			/* like the above, but with softirqs */
>   			DEBUG_LOCKS_WARN_ON(current->softirqs_enabled);
>   		} else {
> 

That crashed nicely; it didn't like the unconditional printk().
With

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 50d4863974e7..ea4f76e2d815 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5524,7 +5524,9 @@ static noinstr void check_flags(unsigned long flags)
         if (!hardirq_count()) {
                 if (softirq_count()) {
                         /* like the above, but with softirqs */
-                       DEBUG_LOCKS_WARN_ON(current->softirqs_enabled);
+                       if (DEBUG_LOCKS_WARN_ON(current->softirqs_enabled))
+                               printk("preempt_count(): %x softirq_count(): %lx",
+                                      preempt_count(), softirq_count());
                 } else {
                         /* lick the above, does it taste good? */
                         DEBUG_LOCKS_WARN_ON(!current->softirqs_enabled);

I got the following (decoded):

[   11.360487] WARNING: CPU: 0 PID: 233 at kernel/locking/lockdep.c:5527 check_flags (./arch/arm/include/asm/current.h:36 (discriminator 12) ./include/asm-generic/preempt.h:11 (discriminator 12) kernel/locking/lockdep.c:5528 (discriminator 12))
[   11.361102] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
[   11.361173] Modules linked in:
[   11.361730] CPU: 0 PID: 233 Comm: rcS Tainted: G                 N 6.3.0-rc2-dirty #2
[   11.361921] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   11.362303] unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
[   11.362441] show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
[   11.362519] dump_stack_lvl from __warn (./include/linux/jump_label.h:260 ./include/linux/jump_label.h:270 ./include/trace/events/error_report.h:69 kernel/panic.c:681)
[   11.362598] __warn from warn_slowpath_fmt (./arch/arm/include/asm/current.h:36 ./include/asm-generic/preempt.h:16 ./include/asm-generic/preempt.h:59 ./include/linux/context_tracking.h:154 kernel/panic.c:706)
[   11.362702] warn_slowpath_fmt from check_flags (./arch/arm/include/asm/current.h:36 (discriminator 12) ./include/asm-generic/preempt.h:11 (discriminator 12) kernel/locking/lockdep.c:5528 (discriminator 12))
[   11.362780] check_flags from lock_is_held_type (./arch/arm/include/asm/percpu.h:37 kernel/locking/lockdep.c:462 kernel/locking/lockdep.c:5713)
[   11.362851] lock_is_held_type from rcu_read_lock_sched_held (kernel/rcu/update.c:125)
[   11.362933] rcu_read_lock_sched_held from trace_rcu_dyntick (./include/trace/events/rcu.h:480 (discriminator 28))
[   11.363016] trace_rcu_dyntick from ct_nmi_enter (./arch/arm/include/asm/percpu.h:37 (discriminator 4) ./include/linux/context_tracking_state.h:90 (discriminator 4) kernel/context_tracking.c:301 (discriminator 4))
[   11.363108] ct_nmi_enter from irq_enter (kernel/softirq.c:625)
[   11.363177] irq_enter from generic_handle_arch_irq (kernel/irq/handle.c:238)
[   11.363251] generic_handle_arch_irq from call_with_stack (arch/arm/lib/call_with_stack.S:45)
[   11.363339] call_with_stack from __irq_svc (arch/arm/kernel/entry-armv.S:232)
[   11.363438] Exception stack(0xd1819f60 to 0xd1819fa8)
[   11.363629] 9f60: ecac8b10 40000000 b6f88418 c1c2607c 00000000 40000000 c4acc00b 00000001
[   11.363740] 9f80: 00000b00 c0101278 c4acc0f0 00000000 00000051 d1819fb0 c01011c4 c0103c1c
[   11.363833] 9fa0: 00000013 ffffffff
[   11.363896] __irq_svc from vfp_reload_hw (arch/arm/vfp/vfphw.S:149)
[   11.364015] irq event stamp: 1626
[   11.364069] hardirqs last enabled at (1625): __und_usr (arch/arm/kernel/entry-armv.S:465)
[   11.364199] hardirqs last disabled at (1626): __irq_svc (arch/arm/kernel/entry-armv.S:221)
[   11.364290] softirqs last enabled at (1424): __do_softirq (./arch/arm/include/asm/current.h:36 ./include/asm-generic/preempt.h:11 kernel/softirq.c:415 kernel/softirq.c:600)
[   11.364396] softirqs last disabled at (1323): __irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650)
[   11.364494] ---[ end trace 0000000000000000 ]---
[   11.364637] preempt_count(): 201 softirq_count(): 200
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[   11.364659] irq event stamp: 1626
[   11.364757] hardirqs last enabled at (1625): __und_usr (arch/arm/kernel/entry-armv.S:465)
[   11.364843] hardirqs last disabled at (1626): __irq_svc (arch/arm/kernel/entry-armv.S:221)
[   11.364926] softirqs last enabled at (1424): __do_softirq (./arch/arm/include/asm/current.h:36 ./include/asm-generic/preempt.h:11 kernel/softirq.c:415 kernel/softirq.c:600)
[   11.365014] softirqs last disabled at (1323): __irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650)

Does that tell you anything ?

Thanks,
Guenter

