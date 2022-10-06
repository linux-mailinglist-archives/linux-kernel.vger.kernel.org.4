Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57F65F68B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJFOAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiJFOAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:00:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C3229802
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:00:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a13so3004552edj.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3VUvRlbpuvf0sSI/tMS6r4LiVAE0zxyqHrBnHrDjVs=;
        b=gqWZo0POJFIpXr6KC2pBuLd9vp3XUt7rv5cfK/YRtT8dWF7zknLkup9KyDu6I3ZO5C
         NSxgqn/8zdG+o+eQp9iu2PS03+ULrVn5n2wYa/nzEHdc1d4fGTYghzmRDt/H069GSYac
         7HUihpidwUaizW8onUuV2B+TdjUPeDd2Xr6f+UZ485VyIttUjGUehJbEV4n3FjzzEAf+
         223OZ02LAPr/+yJ7/0bjwfCEz+jhJ2O6whEx0pks8Xu2pDD1Q0v/QejRVE4J7bN2RtAU
         PxklD38eAETKbfvvkgXI/Zk7lNDWiwv1FGOp18brdxxRQf8ntv6ZDWopr/u1OUzmqgMR
         ctKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3VUvRlbpuvf0sSI/tMS6r4LiVAE0zxyqHrBnHrDjVs=;
        b=nnvrZa10T6EmBCBnZ1/Kfjykzpw2qljsFCqbzV37Nf+gvmx4NoXAq7rx0SzL2DsZPk
         AHzk6rkV3gpE2mzbfmMhB5/OVhki/G4cdrx9heikpXq/K/6O2wzZRS1HOeKeWP91Qtt5
         er8WmyTI5ORK6HXtS8d5G8Lln9gO+qkDqTzuaRoIZTy2va0OT7sHUYZ8Y/j+XJwsGrCH
         3SMz4UKItXcdrbLA7No598MMJUXsE2Nbu1JFQ5epEukyhDZB+6ZTNYy4MggEmcBOEg1n
         J2qflILwVEFlQEizNRp88xIAxjgaIOOwXSMARrzlArMg2Z30AtjEipkvWb9ZawtEalF0
         heGQ==
X-Gm-Message-State: ACrzQf3Yjh9qMttWdclJbmeKHmtPCvMBLS7HIEm9+MVP4l4cAto2OJxx
        6Qbj0zw2lvHTGtQlDhHu8k1mkA==
X-Google-Smtp-Source: AMsMyM6U8geCMz0HfEPcxRTfzYl8glFCMpBQGQRDMLam2KLlSCcpSglOCh36sG+3x+wK4VMIOQoBhQ==
X-Received: by 2002:a05:6402:156:b0:440:b458:93df with SMTP id s22-20020a056402015600b00440b45893dfmr4982111edu.337.1665064803139;
        Thu, 06 Oct 2022 07:00:03 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:504b:a880:4e60:e32d])
        by smtp.gmail.com with ESMTPSA id er6-20020a056402448600b004580b26e32esm5812366edb.81.2022.10.06.07.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:00:02 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:59:55 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs
Message-ID: <Yz7fWw8duIOezSW1@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
 <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7ZLaT4jW3Y9EYS@hirez.programming.kicks-ass.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 03:33PM +0200, Peter Zijlstra wrote:
> 
> OK, so the below seems to pass the concurrent sigtrap_threads test for
> me and doesn't have that horrible irq_work_sync hackery.
> 
> Does it work for you too?

I'm getting this (courtesy of syzkaller):

 |  BUG: using smp_processor_id() in preemptible [00000000] code: syz-executor.8/22848
 |  caller is perf_swevent_get_recursion_context+0x13/0x80
 |  CPU: 0 PID: 22860 Comm: syz-executor.6 Not tainted 6.0.0-rc3-00017-g1472d7e42f41 #64
 |  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
 |  Call Trace:
 |   <TASK>
 |   dump_stack_lvl+0x6a/0x86
 |   check_preemption_disabled+0xdf/0xf0
 |   perf_swevent_get_recursion_context+0x13/0x80
 |   perf_pending_task+0xf/0x80
 |   task_work_run+0x73/0xc0
 |   do_exit+0x459/0xf20
 |   do_group_exit+0x3f/0xe0
 |   get_signal+0xe04/0xe60
 |   arch_do_signal_or_restart+0x3f/0x780
 |   exit_to_user_mode_prepare+0x135/0x1a0
 |   irqentry_exit_to_user_mode+0x6/0x30
 |   asm_sysvec_irq_work+0x16/0x20

That one I could fix up with:

 | diff --git a/kernel/events/core.c b/kernel/events/core.c
 | index 9319af6013f1..2f1d51b50be7 100644
 | --- a/kernel/events/core.c
 | +++ b/kernel/events/core.c
 | @@ -6563,6 +6563,7 @@ static void perf_pending_task(struct callback_head *head)
 |  	 * If we 'fail' here, that's OK, it means recursion is already disabled
 |  	 * and we won't recurse 'further'.
 |  	 */
 | +	preempt_disable_notrace();
 |  	rctx = perf_swevent_get_recursion_context();
 |  
 |  	if (event->pending_work) {
 | @@ -6573,6 +6574,7 @@ static void perf_pending_task(struct callback_head *head)
 |  
 |  	if (rctx >= 0)
 |  		perf_swevent_put_recursion_context(rctx);
 | +	preempt_enable_notrace();
 |  }
 |  
 |  #ifdef CONFIG_GUEST_PERF_EVENTS

But following that, I get:

 | ======================================================
 | WARNING: possible circular locking dependency detected
 | 6.0.0-rc3-00017-g1472d7e42f41-dirty #65 Not tainted
 | ------------------------------------------------------
 | syz-executor.11/13018 is trying to acquire lock:
 | ffffffffbb754a18 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0xa/0x30 kernel/locking/semaphore.c:139
 | 
 | but task is already holding lock:
 | ffff8ea992e00e20 (&ctx->lock){-.-.}-{2:2}, at: perf_event_context_sched_out kernel/events/core.c:3499 [inline]
 | ffff8ea992e00e20 (&ctx->lock){-.-.}-{2:2}, at: __perf_event_task_sched_out+0x29e/0xb50 kernel/events/core.c:3608
 | 
 | which lock already depends on the new lock.
 | 
 |  << snip ... lockdep unhappy we're trying to WARN >>
 | 
 | WARNING: CPU: 3 PID: 13018 at kernel/events/core.c:2288 event_sched_out+0x3f2/0x410 kernel/events/core.c:2288
 | Modules linked in:
 | CPU: 3 PID: 13018 Comm: syz-executor.11 Not tainted 6.0.0-rc3-00017-g1472d7e42f41-dirty #65
 | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
 | RIP: 0010:event_sched_out+0x3f2/0x410 kernel/events/core.c:2288
 | Code: ff ff e8 21 b2 f9 ff 65 8b 05 76 67 7f 46 85 c0 0f 84 0f ff ff ff e8 0d b2 f9 ff 90 0f 0b 90 e9 01 ff ff ff e8 ff b1 f9 ff 90 <0f> 0b 90 e9 3b fe ff ff e8 f1 b1 f9 ff 90 0f 0b 90 e9 01 ff ff ff
 | RSP: 0018:ffffa69c8931f9a8 EFLAGS: 00010012
 | RAX: 0000000040000000 RBX: ffff8ea99526f1c8 RCX: ffffffffb9824d01
 | RDX: ffff8ea9934a0040 RSI: 0000000000000000 RDI: ffff8ea99526f1c8
 | RBP: ffff8ea992e00e00 R08: 0000000000000000 R09: 0000000000000000
 | R10: 00000000820822cd R11: 00000000d820822c R12: ffff8eacafcf2e50
 | R13: ffff8eacafcf2e58 R14: ffffffffbb62e9a0 R15: ffff8ea992e00ef8
 | FS:  00007fdcddbb6640(0000) GS:ffff8eacafcc0000(0000) knlGS:0000000000000000
 | CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 | CR2: 00007fdcddbb5fa8 CR3: 0000000112846004 CR4: 0000000000770ee0
 | DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 | DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
 | PKRU: 55555554
 | Call Trace:
 |  <TASK>
 |  group_sched_out.part.0+0x5c/0xe0 kernel/events/core.c:2320
 |  group_sched_out kernel/events/core.c:2315 [inline]
 |  ctx_sched_out+0x35d/0x3c0 kernel/events/core.c:3288
 |  task_ctx_sched_out+0x3d/0x60 kernel/events/core.c:2657
 |  perf_event_context_sched_out kernel/events/core.c:3505 [inline]
 |  __perf_event_task_sched_out+0x31b/0xb50 kernel/events/core.c:3608
 |  perf_event_task_sched_out include/linux/perf_event.h:1266 [inline]
 |  prepare_task_switch kernel/sched/core.c:4992 [inline]
 |  context_switch kernel/sched/core.c:5134 [inline]
 |  __schedule+0x4f8/0xb20 kernel/sched/core.c:6494
 |  preempt_schedule_irq+0x39/0x70 kernel/sched/core.c:6806
 |  irqentry_exit+0x32/0x90 kernel/entry/common.c:428
 |  asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
 | RIP: 0010:try_to_freeze include/linux/freezer.h:66 [inline]
 | RIP: 0010:freezer_count include/linux/freezer.h:128 [inline]
 | RIP: 0010:coredump_wait fs/coredump.c:407 [inline]
 | RIP: 0010:do_coredump+0x1193/0x1b60 fs/coredump.c:563
 | Code: d3 25 df ff 83 e3 08 0f 84 f0 03 00 00 e8 c5 25 df ff 48 f7 85 88 fe ff ff 00 01 00 00 0f 85 7e fc ff ff 31 db e9 83 fc ff ff <e8> a8 25 df ff e8 63 43 d3 ff e9 d2 f1 ff ff e8 99 25 df ff 48 85
 | RSP: 0018:ffffa69c8931fc30 EFLAGS: 00000246
 | RAX: 7fffffffffffffff RBX: ffff8ea9934a0040 RCX: 0000000000000000
 | RDX: 0000000000000001 RSI: ffffffffbb4ab491 RDI: 00000000ffffffff
 | RBP: ffffa69c8931fdc0 R08: 0000000000000001 R09: 0000000000000001
 | R10: 00000000ffffffff R11: 00000000ffffffff R12: ffff8ea9934a0040
 | R13: ffffffffbb792620 R14: 0000000000000108 R15: 0000000000000001
 |  get_signal+0xe56/0xe60 kernel/signal.c:2843
 |  arch_do_signal_or_restart+0x3f/0x780 arch/x86/kernel/signal.c:869
 |  exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 |  exit_to_user_mode_prepare+0x135/0x1a0 kernel/entry/common.c:201
 |  __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 |  syscall_exit_to_user_mode+0x1a/0x50 kernel/entry/common.c:294
 |  do_syscall_64+0x48/0x90 arch/x86/entry/common.c:86
 |  entry_SYSCALL_64_after_hwframe+0x64/0xce
 | RIP: 0033:0x7fdcddc48549
 | Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
 | RSP: 002b:00007fdcddbb60f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
 | RAX: 0000000000000001 RBX: 00007fdcddd62f88 RCX: 00007fdcddc48549
 | RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fdcddd62f8c
 | RBP: 00007fdcddd62f80 R08: 000000000000001e R09: 0000000000000000
 | R10: 0000000000000003 R11: 0000000000000246 R12: 00007fdcddd62f8c
 | R13: 00007ffc4136118f R14: 0000000000000000 R15: 00007fdcddbb6640
 |  </TASK>
 | irq event stamp: 128
 | hardirqs last  enabled at (127): [<ffffffffba9f7237>] irqentry_exit+0x37/0x90 kernel/entry/common.c:431
 | hardirqs last disabled at (128): [<ffffffffba9faa5b>] __schedule+0x6cb/0xb20 kernel/sched/core.c:6393
 | softirqs last  enabled at (106): [<ffffffffbae0034f>] softirq_handle_end kernel/softirq.c:414 [inline]
 | softirqs last  enabled at (106): [<ffffffffbae0034f>] __do_softirq+0x34f/0x4d5 kernel/softirq.c:600
 | softirqs last disabled at (99): [<ffffffffb9693821>] invoke_softirq kernel/softirq.c:445 [inline]
 | softirqs last disabled at (99): [<ffffffffb9693821>] __irq_exit_rcu+0xb1/0x120 kernel/softirq.c:650
 | ---[ end trace 0000000000000000 ]---
 | BUG: kernel NULL pointer dereference, address: 0000000000000000
 | #PF: supervisor instruction fetch in kernel mode
 | #PF: error_code(0x0010) - not-present page
 | PGD 8000000112e91067 P4D 8000000112e91067 PUD 114481067 PMD 0 
 | Oops: 0010 [#1] PREEMPT SMP PTI
 | CPU: 1 PID: 13018 Comm: syz-executor.11 Tainted: G        W          6.0.0-rc3-00017-g1472d7e42f41-dirty #65
 | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
 | RIP: 0010:0x0
 | Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
 | RSP: 0018:ffffa69c8931fd18 EFLAGS: 00010293
 | RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffb96be917
 | RDX: ffff8ea9934a0040 RSI: 0000000000000000 RDI: ffff8ea99526f620
 | RBP: ffff8ea9934a0040 R08: 0000000000000000 R09: 0000000000000000
 | R10: 0000000000000001 R11: ffffffffb9cb7eaf R12: ffff8ea9934a08f0
 | R13: ffff8ea992fc9cf8 R14: ffff8ea98c65dec0 R15: ffff8ea9934a0828
 | FS:  0000000000000000(0000) GS:ffff8eacafc40000(0000) knlGS:0000000000000000
 | CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 | CR2: ffffffffffffffd6 CR3: 000000011343a003 CR4: 0000000000770ee0
 | DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 | DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
 | PKRU: 55555554
 | Call Trace:
 |  <TASK>
 |  task_work_run+0x73/0xc0 kernel/task_work.c:177
 |  exit_task_work include/linux/task_work.h:38 [inline]
 |  do_exit+0x459/0xf20 kernel/exit.c:795
 |  do_group_exit+0x3f/0xe0 kernel/exit.c:925
 |  get_signal+0xe04/0xe60 kernel/signal.c:2857
 |  arch_do_signal_or_restart+0x3f/0x780 arch/x86/kernel/signal.c:869
 |  exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 |  exit_to_user_mode_prepare+0x135/0x1a0 kernel/entry/common.c:201
 |  __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 |  syscall_exit_to_user_mode+0x1a/0x50 kernel/entry/common.c:294
 |  do_syscall_64+0x48/0x90 arch/x86/entry/common.c:86
 |  entry_SYSCALL_64_after_hwframe+0x64/0xce
 | RIP: 0033:0x7fdcddc48549
 | Code: Unable to access opcode bytes at RIP 0x7fdcddc4851f.
 | RSP: 002b:00007fdcddbb60f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
 | RAX: 0000000000000001 RBX: 00007fdcddd62f88 RCX: 00007fdcddc48549
 | RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fdcddd62f8c
 | RBP: 00007fdcddd62f80 R08: 000000000000001e R09: 0000000000000000
 | R10: 0000000000000003 R11: 0000000000000246 R12: 00007fdcddd62f8c
 | R13: 00007ffc4136118f R14: 0000000000000000 R15: 00007fdcddbb6640
 |  </TASK>
 | Modules linked in:
 | CR2: 0000000000000000
 | ---[ end trace 0000000000000000 ]---
 | RIP: 0010:0x0
 | Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
 | RSP: 0018:ffffa69c8931fd18 EFLAGS: 00010293
 | RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffb96be917
 | RDX: ffff8ea9934a0040 RSI: 0000000000000000 RDI: ffff8ea99526f620
 | RBP: ffff8ea9934a0040 R08: 0000000000000000 R09: 0000000000000000
 | R10: 0000000000000001 R11: ffffffffb9cb7eaf R12: ffff8ea9934a08f0
 | R13: ffff8ea992fc9cf8 R14: ffff8ea98c65dec0 R15: ffff8ea9934a0828
 | FS:  0000000000000000(0000) GS:ffff8eacafc40000(0000) knlGS:0000000000000000
 | CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 | CR2: ffffffffffffffd6 CR3: 000000011343a003 CR4: 0000000000770ee0
 | DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 | DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
 | PKRU: 55555554
 | ----------------
 | Code disassembly (best guess):
 |    0:	d3 25 df ff 83 e3    	shll   %cl,-0x1c7c0021(%rip)        # 0xe383ffe5
 |    6:	08 0f                	or     %cl,(%rdi)
 |    8:	84 f0                	test   %dh,%al
 |    a:	03 00                	add    (%rax),%eax
 |    c:	00 e8                	add    %ch,%al
 |    e:	c5 25 df ff          	vpandn %ymm7,%ymm11,%ymm15
 |   12:	48 f7 85 88 fe ff ff 	testq  $0x100,-0x178(%rbp)
 |   19:	00 01 00 00
 |   1d:	0f 85 7e fc ff ff    	jne    0xfffffca1
 |   23:	31 db                	xor    %ebx,%ebx
 |   25:	e9 83 fc ff ff       	jmp    0xfffffcad
 | * 2a:	e8 a8 25 df ff       	call   0xffdf25d7 <-- trapping instruction
 |   2f:	e8 63 43 d3 ff       	call   0xffd34397
 |   34:	e9 d2 f1 ff ff       	jmp    0xfffff20b
 |   39:	e8 99 25 df ff       	call   0xffdf25d7
 |   3e:	48                   	rex.W
 |   3f:	85                   	.byte 0x85


So something isn't quite right yet. Unfortunately I don't have a good
reproducer. :-/

Thanks,
-- Marco
