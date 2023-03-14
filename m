Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039E66B9174
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCNLTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjCNLTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:19:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED0A41098
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E45E3B818EC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414F3C433EF;
        Tue, 14 Mar 2023 11:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678792717;
        bh=dq736rjYaj0DSbyGbLkpNReEYE6IF/qTlF2gdIGVrjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GgNybPKaumWFWqHVq2MwEJ17bVyeTpdqJD0viQN15aIss8BowK+qNjqvUHDnncImJ
         FvCuE/0ge42/aJ2GbH6DLXmIO4daVWLgplld9lrGle+aFYUT+EHhjtPf3TBNOHvRJw
         rbItQW+Gmt+HsWxP8bMHFjlIWj3OcIzWeD1bPfNjdxw4myV0EC5z6+dhhTpbqj+Fkv
         m8i6GDp007XBs8sregF5yJWVpnZsYiP4pIv7mllWoHLa+ej2GeFfyxEbxm+kreVqiH
         nKUrIGxU5WUEkUZ08tD5w3wlUymjrGhD8EuVXBe7nPyw9ZzF5hgX0aC9ze32nn+/Hc
         lnrrOxM58W5hA==
Date:   Tue, 14 Mar 2023 12:18:33 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.3-rc2
Message-ID: <ZBBYCSZUJOWBg1s8@localhost.localdomain>
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net>
 <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
 <ZA+ttVOPBvNOYHoC@lothringen>
 <dc031bc7-8ca4-7ca7-c24f-9db65b5547e4@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc031bc7-8ca4-7ca7-c24f-9db65b5547e4@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Mar 13, 2023 at 05:52:49PM -0700, Guenter Roeck a écrit :
> On 3/13/23 16:11, Frederic Weisbecker wrote:
> [   11.360487] WARNING: CPU: 0 PID: 233 at kernel/locking/lockdep.c:5527 check_flags (./arch/arm/include/asm/current.h:36 (discriminator 12) ./include/asm-generic/preempt.h:11 (discriminator 12) kernel/locking/lockdep.c:5528 (discriminator 12))
> [   11.361102] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
> [   11.361173] Modules linked in:
> [   11.361730] CPU: 0 PID: 233 Comm: rcS Tainted: G                 N 6.3.0-rc2-dirty #2
> [   11.361921] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
> [   11.362303] unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
> [   11.362441] show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4))
> [   11.362519] dump_stack_lvl from __warn (./include/linux/jump_label.h:260 ./include/linux/jump_label.h:270 ./include/trace/events/error_report.h:69 kernel/panic.c:681)
> [   11.362598] __warn from warn_slowpath_fmt (./arch/arm/include/asm/current.h:36 ./include/asm-generic/preempt.h:16 ./include/asm-generic/preempt.h:59 ./include/linux/context_tracking.h:154 kernel/panic.c:706)
> [   11.362702] warn_slowpath_fmt from check_flags (./arch/arm/include/asm/current.h:36 (discriminator 12) ./include/asm-generic/preempt.h:11 (discriminator 12) kernel/locking/lockdep.c:5528 (discriminator 12))
> [   11.362780] check_flags from lock_is_held_type (./arch/arm/include/asm/percpu.h:37 kernel/locking/lockdep.c:462 kernel/locking/lockdep.c:5713)
> [   11.362851] lock_is_held_type from rcu_read_lock_sched_held (kernel/rcu/update.c:125)
> [   11.362933] rcu_read_lock_sched_held from trace_rcu_dyntick (./include/trace/events/rcu.h:480 (discriminator 28))
> [   11.363016] trace_rcu_dyntick from ct_nmi_enter (./arch/arm/include/asm/percpu.h:37 (discriminator 4) ./include/linux/context_tracking_state.h:90 (discriminator 4) kernel/context_tracking.c:301 (discriminator 4))
> [   11.363108] ct_nmi_enter from irq_enter (kernel/softirq.c:625)
> [   11.363177] irq_enter from generic_handle_arch_irq (kernel/irq/handle.c:238)
> [   11.363251] generic_handle_arch_irq from call_with_stack (arch/arm/lib/call_with_stack.S:45)
> [   11.363339] call_with_stack from __irq_svc (arch/arm/kernel/entry-armv.S:232)
> [   11.363438] Exception stack(0xd1819f60 to 0xd1819fa8)
> [   11.363629] 9f60: ecac8b10 40000000 b6f88418 c1c2607c 00000000 40000000 c4acc00b 00000001
> [   11.363740] 9f80: 00000b00 c0101278 c4acc0f0 00000000 00000051 d1819fb0 c01011c4 c0103c1c
> [   11.363833] 9fa0: 00000013 ffffffff
> [   11.363896] __irq_svc from vfp_reload_hw (arch/arm/vfp/vfphw.S:149)
> [   11.364015] irq event stamp: 1626
> [   11.364069] hardirqs last enabled at (1625): __und_usr (arch/arm/kernel/entry-armv.S:465)
> [   11.364199] hardirqs last disabled at (1626): __irq_svc (arch/arm/kernel/entry-armv.S:221)
> [   11.364290] softirqs last enabled at (1424): __do_softirq (./arch/arm/include/asm/current.h:36 ./include/asm-generic/preempt.h:11 kernel/softirq.c:415 kernel/softirq.c:600)
> [   11.364396] softirqs last disabled at (1323): __irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650)
> [   11.364494] ---[ end trace 0000000000000000 ]---
> [   11.364637] preempt_count(): 201 softirq_count(): 200
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ok so this is a softirq disabled section that doesn't handle the lockdep
part.

How does the following look like as a culprit?

62b95a7b44d1 (ARM: 9282/1: vfp: Manipulate task VFP state with softirqs disabled)

Thanks!
