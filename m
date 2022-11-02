Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48DB615CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKBHDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKBHDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:03:21 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C8A1DA78;
        Wed,  2 Nov 2022 00:03:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sc25so42755612ejc.12;
        Wed, 02 Nov 2022 00:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tO9xu7xKN1aWAtFEIy1XkKy9mzRinMfyDnZOUmkUQoU=;
        b=IJFuJDxYdgpgfYlKduo8m9daRgStgESnEYvNkPJfOm/JWe1qcSuS6NsEWsy++7sw7D
         Vx2pe78Xlm+ORJofiTeMHVVi/kUjXPlAAR+fN//Zt98bQuTVWFv49YhZTXDqb5Luxu7N
         9AolQF+zNJsqvq+/LDqP65ClY3sAIF5Jz+TscLRJFk6ERToBi1IXsPiiIni4Ym0Gp/im
         RGPNAITCcJ5z+xqMWBYnCD4yBAbwnxVhZMNWutrXPolp5knhUujG0QC9cOymmfQwiYU8
         J/CKyhrE/1BowOTcqvu8Y2GN12fuk006raa1sHtLkXGElfoLL3A8KHY7BS+Hds5BRI9R
         scfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tO9xu7xKN1aWAtFEIy1XkKy9mzRinMfyDnZOUmkUQoU=;
        b=8RvffhT7n/ruW1kFwRc+5fsHVVsnKny4F+5rT56MGiGt32NLvS60erfJlET5Xksi8N
         Y51kvdD9tZ3lmHyBDLeDXVGlTw8HxqhZ2kbIg9YBNJcHsoEHF8i1Cr/jAb1W6qDkNAgU
         kPHDZkcXhEkEyxJTzLaAb6p88rp+V7H64ANeCW2rL2sDq0O+s2AV8Fah84zSHGKnAKBM
         N3esdLImZcAMdEJsyPNRAWL7ykCQd4hMwc0IpUOOzhmRIO0LWnWh/ZBX2S1cGh6MOhQb
         C74WyQOs7GJkNoFDsSJ/hqE25jB39Ps0rTB+JUFfeBdDTk4N9fgkuZ7Ys9grF3Fk4X8O
         Fp6g==
X-Gm-Message-State: ACrzQf2IT7PwKam8zaggvmWlUaqeJVAG140QOmgkA/M9d1cycxKfYNnQ
        ljBSx+9EFTBGJLJSKMaiD5BCq3WV6iyyuR777I/v1qSkmCXr5g==
X-Google-Smtp-Source: AMsMyM7cg8cC77+esLpaFLS/5gqNg9NcSzUu8c68OW75MtfeABhqsHauOuUrWvZGCOE1+CVf9ipB3IisoMuImLtjprw=
X-Received: by 2002:a17:907:1041:b0:7ad:a3f8:a733 with SMTP id
 oy1-20020a170907104100b007ada3f8a733mr21683243ejb.739.1667372598588; Wed, 02
 Nov 2022 00:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAO4mrfc=oS37CJtvPt+dWm-24mkV-5XRTGNZDr5ZopAE7pY3WQ@mail.gmail.com>
 <YtQfePz3+zeRDfMg@kbusch-mbp>
In-Reply-To: <YtQfePz3+zeRDfMg@kbusch-mbp>
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Wed, 2 Nov 2022 15:02:43 +0800
Message-ID: <CAO4mrfd6wo3nPig_ZL622FjL7qjEnMQZ7SCTVcv5DR9YTWYM5g@mail.gmail.com>
Subject: Re: WARNING in loop_add
To:     Keith Busch <kbusch@kernel.org>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux developers,

The bug persists in the upstream Linux v6.0.0 4fe89d07dcc2 and the
latest commit Linux v5.19.76 4f5365f77018.

[   68.027515][    C0] ======================================================
[   68.027977][    C0] WARNING: possible circular locking dependency detected
[   68.028436][    C0] 6.0.0 #35 Not tainted
[   68.028704][    C0] ------------------------------------------------------
[   68.029145][    C0] a.out/6625 is trying to acquire lock:
[   68.029530][    C0] ffff88801be0c0d0 (&q->queue_lock){..-.}-{2:2},
at: throtl_pending_timer_fn+0xf6/0x1020
[   68.030213][    C0]
[   68.030213][    C0] but task is already holding lock:
[   68.030688][    C0] ffffc90000007be0
((&sq->pending_timer)){+.-.}-{0:0}, at: call_timer_fn+0xbb/0x210
[   68.031300][    C0]
[   68.031300][    C0] which lock already depends on the new lock.
[   68.031300][    C0]
[   68.031976][    C0]
[   68.031976][    C0] the existing dependency chain (in reverse order) is:
[   68.032548][    C0]
[   68.032548][    C0] -> #2 ((&sq->pending_timer)){+.-.}-{0:0}:
[   68.033086][    C0]        lock_acquire+0x17f/0x430
[   68.033418][    C0]        del_timer_sync+0x104/0x380
[   68.033764][    C0]        throtl_pd_free+0x15/0x40
[   68.034100][    C0]        blkcg_deactivate_policy+0x31c/0x530
[   68.034496][    C0]        blk_throtl_exit+0x86/0x120
[   68.034838][    C0]        blkcg_init_queue+0x25a/0x2d0
[   68.035184][    C0]        __alloc_disk_node+0x2ce/0x590
[   68.035537][    C0]        __blk_mq_alloc_disk+0x11b/0x1e0
[   68.035907][    C0]        loop_add+0x340/0x9b0
[   68.036225][    C0]        loop_control_ioctl+0x108/0x770
[   68.036587][    C0]        __se_sys_ioctl+0xfb/0x170
[   68.036927][    C0]        do_syscall_64+0x3d/0x90
[   68.037252][    C0]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   68.037668][    C0]
[   68.037668][    C0] -> #1 (&blkcg->lock){....}-{2:2}:
[   68.038152][    C0]        lock_acquire+0x17f/0x430
[   68.038497][    C0]        _raw_spin_lock+0x2a/0x40
[   68.038827][    C0]        blkg_create+0x949/0x10a0
[   68.039165][    C0]        blkcg_init_queue+0xb4/0x2d0
[   68.039517][    C0]        __alloc_disk_node+0x2ce/0x590
[   68.039868][    C0]        __blk_mq_alloc_disk+0x11b/0x1e0
[   68.040232][    C0]        floppy_alloc_disk+0x54/0x350
[   68.040585][    C0]        do_floppy_init+0x1b1/0x1d27
[   68.040927][    C0]        async_run_entry_fn+0xa6/0x400
[   68.041281][    C0]        process_one_work+0x83c/0x11a0
[   68.041646][    C0]        worker_thread+0xa6c/0x1290
[   68.041980][    C0]        kthread+0x266/0x300
[   68.042274][    C0]        ret_from_fork+0x1f/0x30
[   68.042592][    C0]
[   68.042592][    C0] -> #0 (&q->queue_lock){..-.}-{2:2}:
[   68.043074][    C0]        check_prevs_add+0x4f5/0x5d30
[   68.043433][    C0]        __lock_acquire+0x4432/0x6080
[   68.043783][    C0]        lock_acquire+0x17f/0x430
[   68.044113][    C0]        _raw_spin_lock_irq+0xae/0xf0
[   68.044465][    C0]        throtl_pending_timer_fn+0xf6/0x1020
[   68.044867][    C0]        call_timer_fn+0xf5/0x210
[   68.045189][    C0]        __run_timers+0x762/0x970
[   68.045534][    C0]        run_timer_softirq+0x63/0xf0
[   68.045890][    C0]        __do_softirq+0x372/0x783
[   68.046223][    C0]        __irq_exit_rcu+0xcf/0x150
[   68.046557][    C0]        irq_exit_rcu+0x5/0x20
[   68.046868][    C0]        sysvec_apic_timer_interrupt+0x91/0xb0
[   68.047281][    C0]        asm_sysvec_apic_timer_interrupt+0x16/0x20
[   68.047704][    C0]        should_fail+0x169/0x4f0
[   68.048022][    C0]        should_failslab+0x5/0x20
[   68.048346][    C0]        kmem_cache_alloc_lru+0x75/0x2f0
[   68.048718][    C0]        new_inode_pseudo+0x81/0x1d0
[   68.049055][    C0]        new_inode+0x25/0x1d0
[   68.049355][    C0]        __debugfs_create_file+0x146/0x550
[   68.049723][    C0]        blk_mq_debugfs_register_hctx+0x21c/0x660
[   68.050166][    C0]        blk_mq_debugfs_register+0x2e0/0x470
[   68.050553][    C0]        blk_register_queue+0x24f/0x3c0
[   68.050912][    C0]        device_add_disk+0x55a/0xc00
[   68.051257][    C0]        loop_add+0x71a/0x9b0
[   68.051566][    C0]        loop_control_ioctl+0x108/0x770
[   68.051933][    C0]        __se_sys_ioctl+0xfb/0x170
[   68.052266][    C0]        do_syscall_64+0x3d/0x90
[   68.052591][    C0]        entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   68.053013][    C0]
[   68.053013][    C0] other info that might help us debug this:
[   68.053013][    C0]
[   68.053689][    C0] Chain exists of:
[   68.053689][    C0]   &q->queue_lock --> &blkcg->lock -->
(&sq->pending_timer)
[   68.053689][    C0]
[   68.054539][    C0]  Possible unsafe locking scenario:
[   68.054539][    C0]
[   68.055013][    C0]        CPU0                    CPU1
[   68.055360][    C0]        ----                    ----
[   68.055703][    C0]   lock((&sq->pending_timer));
[   68.056022][    C0]                                lock(&blkcg->lock);
[   68.056426][    C0]
lock((&sq->pending_timer));
[   68.056883][    C0]   lock(&q->queue_lock);
[   68.057161][    C0]
[   68.057161][    C0]  *** DEADLOCK ***
[   68.057161][    C0]
[   68.057640][    C0] 5 locks held by a.out/6625:
[   68.057927][    C0]  #0: ffff88801c54b340
(&q->sysfs_dir_lock){+.+.}-{3:3}, at: blk_register_queue+0x52/0x3c0
[   68.058533][    C0]  #1: ffff88801c54b2b0
(&q->sysfs_lock){+.+.}-{3:3}, at: blk_register_queue+0x16e/0x3c0
[   68.059132][    C0]  #2: ffff88801c54b558
(&q->debugfs_mutex){+.+.}-{3:3}, at: blk_register_queue+0x181/0x3c0
[   68.059741][    C0]  #3: ffff888026091aa0
(&sb->s_type->i_mutex_key#3){+.+.}-{3:3}, at:
start_creating+0x12d/0x330
[   68.060369][    C0]  #4: ffffc90000007be0
((&sq->pending_timer)){+.-.}-{0:0}, at: call_timer_fn+0xbb/0x210
[   68.060955][    C0]
[   68.060955][    C0] stack backtrace:
[   68.061309][    C0] CPU: 0 PID: 6625 Comm: a.out Not tainted 6.0.0 #35
[   68.061705][    C0] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   68.062295][    C0] Call Trace:
[   68.062504][    C0]  <IRQ>
[   68.062678][    C0]  dump_stack_lvl+0x1b1/0x28e
[   68.062962][    C0]  ? io_alloc_page_table+0xfe/0xfe
[   68.063267][    C0]  ? panic+0x81b/0x81b
[   68.063514][    C0]  ? lockdep_unlock+0x144/0x2e0
[   68.063806][    C0]  print_circular_bug+0xa95/0xd40
[   68.064107][    C0]  ? hlock_conflict+0x1f0/0x1f0
[   68.064402][    C0]  ? __bfs+0x369/0x700
[   68.064648][    C0]  ? check_path+0x40/0x40
[   68.064909][    C0]  ? save_trace+0x5a/0xad0
[   68.065181][    C0]  check_noncircular+0x2cc/0x390
[   68.065480][    C0]  ? add_chain_block+0x850/0x850
[   68.065782][    C0]  ? stack_trace_save+0x1e0/0x1e0
[   68.066084][    C0]  ? stack_trace_save+0x1e0/0x1e0
[   68.066384][    C0]  ? rcu_read_lock_sched_held+0x87/0x110
[   68.066728][    C0]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[   68.067083][    C0]  ? mark_lock+0x199/0x1eb0
[   68.067356][    C0]  check_prevs_add+0x4f5/0x5d30
[   68.067651][    C0]  ? read_lock_is_recursive+0x10/0x10
[   68.067972][    C0]  ? __rcu_read_lock+0xb0/0xb0
[   68.068260][    C0]  ? reacquire_held_locks+0x650/0x650
[   68.068591][    C0]  ? memset+0x1f/0x40
[   68.068828][    C0]  ? stack_trace_save+0x1e0/0x1e0
[   68.069127][    C0]  ? stack_trace_save+0x1e0/0x1e0
[   68.069425][    C0]  ? is_bpf_text_address+0x253/0x270
[   68.069736][    C0]  ? stack_trace_save+0x1e0/0x1e0
[   68.070036][    C0]  ? kernel_text_address+0x9e/0xd0
[   68.070338][    C0]  ? __kernel_text_address+0x9/0x40
[   68.070643][    C0]  ? unwind_get_return_address+0x48/0x80
[   68.070977][    C0]  ? arch_stack_walk+0x98/0xe0
[   68.071265][    C0]  ? stack_trace_save+0x104/0x1e0
[   68.071567][    C0]  ? stack_trace_snprint+0xf0/0xf0
[   68.071870][    C0]  ? kernel_text_address+0x9e/0xd0
[   68.072172][    C0]  ? lockdep_unlock+0x144/0x2e0
[   68.072459][    C0]  ? lockdep_lock+0x2c0/0x2c0
[   68.072736][    C0]  ? mark_lock+0x199/0x1eb0
[   68.073006][    C0]  ? __bfs+0x700/0x700
[   68.073247][    C0]  ? lockdep_unlock+0x144/0x2e0
[   68.073535][    C0]  ? lockdep_lock+0x2c0/0x2c0
[   68.073815][    C0]  ? mark_lock+0x199/0x1eb0
[   68.074084][    C0]  ? mark_lock+0x199/0x1eb0
[   68.074354][    C0]  ? lockdep_lock+0x102/0x2c0
[   68.074634][    C0]  ? lockdep_count_forward_deps+0x240/0x240
[   68.074984][    C0]  ? mark_lock+0x199/0x1eb0
[   68.075255][    C0]  __lock_acquire+0x4432/0x6080
[   68.075545][    C0]  ? register_lock_class+0xd7/0x11d0
[   68.075862][    C0]  ? trace_lock_acquire+0x1d0/0x1d0
[   68.076173][    C0]  ? __lock_acquire+0x145c/0x6080
[   68.076471][    C0]  ? __lock_acquire+0x145c/0x6080
[   68.076773][    C0]  ? trace_lock_acquire+0x1d0/0x1d0
[   68.077083][    C0]  ? rcu_read_lock_sched_held+0x87/0x110
[   68.077414][    C0]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[   68.077773][    C0]  lock_acquire+0x17f/0x430
[   68.078042][    C0]  ? throtl_pending_timer_fn+0xf6/0x1020
[   68.078390][    C0]  ? read_lock_is_recursive+0x10/0x10
[   68.078706][    C0]  ? rcu_read_lock_sched_held+0x87/0x110
[   68.079035][    C0]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[   68.079388][    C0]  ? _raw_spin_lock_irq+0x89/0xf0
[   68.079685][    C0]  _raw_spin_lock_irq+0xae/0xf0
[   68.079972][    C0]  ? throtl_pending_timer_fn+0xf6/0x1020
[   68.080302][    C0]  ? _raw_spin_lock_irqsave+0x100/0x100
[   68.080628][    C0]  throtl_pending_timer_fn+0xf6/0x1020
[   68.080945][    C0]  ? blkg_put+0x1e0/0x1e0
[   68.081206][    C0]  ? blkg_put+0x1e0/0x1e0
[   68.081459][    C0]  call_timer_fn+0xf5/0x210
[   68.081727][    C0]  ? blkg_put+0x1e0/0x1e0
[   68.081985][    C0]  ? __run_timers+0x970/0x970
[   68.082264][    C0]  ? _raw_spin_unlock_irq+0x1f/0x40
[   68.082569][    C0]  ? blkg_put+0x1e0/0x1e0
[   68.082824][    C0]  ? lockdep_hardirqs_on+0x8d/0x130
[   68.083131][    C0]  ? blkg_put+0x1e0/0x1e0
[   68.083384][    C0]  __run_timers+0x762/0x970
[   68.083681][    C0]  ? trace_timer_cancel+0x220/0x220
[   68.083989][    C0]  ? rcu_read_lock_sched_held+0x87/0x110
[   68.084319][    C0]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[   68.084671][    C0]  run_timer_softirq+0x63/0xf0
[   68.084952][    C0]  __do_softirq+0x372/0x783
[   68.085219][    C0]  ? __irq_exit_rcu+0xcf/0x150
[   68.085502][    C0]  ? __entry_text_end+0x1feacb/0x1feacb
[   68.085836][    C0]  __irq_exit_rcu+0xcf/0x150
[   68.086116][    C0]  ? irq_exit_rcu+0x20/0x20
[   68.086400][    C0]  ? __sysvec_apic_timer_interrupt+0x11e/0x280
[   68.086763][    C0]  irq_exit_rcu+0x5/0x20
[   68.087013][    C0]  sysvec_apic_timer_interrupt+0x91/0xb0
[   68.087341][    C0]  </IRQ>
[   68.087515][    C0]  <TASK>
[   68.087689][    C0]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   68.088045][    C0] RIP: 0010:should_fail+0x169/0x4f0
[   68.088369][    C0] Code: ed 0f 84 ea fe ff ff ff cd 42 8a 04 2b 84
c0 0f 85 b3 02 00 00 41 89 2c 24 85 ed 0f 84 98 00 00 00 31 db 89 d8
48 83 c4 18 5b <41> 5c 41 5d 41 5e 41 5f 5d c3 49 8d 5f 08 48 89 d8 48
c1 e8 03 42
[   68.089483][    C0] RSP: 0018:ffffc9000a05f948 EFLAGS: 00000292
[   68.089841][    C0] RAX: 0000000000000000 RBX: 0000000000000cc0
RCX: 000000000a05f803
[   68.090299][    C0] RDX: ffff8880239a4880 RSI: 0000000000000490
RDI: ffffffff8d00b620
[   68.090753][    C0] RBP: 1ffffffff1a016c4 R08: dffffc0000000000
R09: fffffbfff1c8dac6
[   68.091210][    C0] R10: fffffbfff1c8dac6 R11: 0000000000000000
R12: ffff8880239a5d9c
[   68.091661][    C0] R13: dffffc0000000000 R14: 0000000000000490
R15: ffffffff8d00b620
[   68.092122][    C0]  ? new_inode_pseudo+0x81/0x1d0
[   68.092409][    C0]  should_failslab+0x5/0x20
[   68.092674][    C0]  kmem_cache_alloc_lru+0x75/0x2f0
[   68.092976][    C0]  new_inode_pseudo+0x81/0x1d0
[   68.093254][    C0]  new_inode+0x25/0x1d0
[   68.093497][    C0]  ? start_creating+0x21f/0x330
[   68.093788][    C0]  __debugfs_create_file+0x146/0x550
[   68.094096][    C0]  blk_mq_debugfs_register_hctx+0x21c/0x660
[   68.094441][    C0]  ? blk_mq_debugfs_register_sched+0x290/0x290
[   68.094800][    C0]  ? xa_clear_mark+0x300/0x300
[   68.095083][    C0]  ? __debugfs_create_file+0x45f/0x550
[   68.095402][    C0]  blk_mq_debugfs_register+0x2e0/0x470
[   68.095718][    C0]  ? blk_mq_debugfs_rq_show+0x30/0x30
[   68.096031][    C0]  ? debugfs_create_dir+0x3dc/0x4e0
[   68.096334][    C0]  blk_register_queue+0x24f/0x3c0
[   68.096629][    C0]  device_add_disk+0x55a/0xc00
[   68.096912][    C0]  loop_add+0x71a/0x9b0
[   68.097156][    C0]  loop_control_ioctl+0x108/0x770
[   68.097451][    C0]  ? print_irqtrace_events+0x220/0x220
[   68.097771][    C0]  ? vtime_user_exit+0x2b2/0x3e0
[   68.098059][    C0]  ? loop_set_hw_queue_depth+0x60/0x60
[   68.098375][    C0]  ? __ct_user_exit+0xd9/0x160
[   68.098657][    C0]  ? bpf_lsm_file_ioctl+0x5/0x10
[   68.098948][    C0]  ? security_file_ioctl+0x9d/0xb0
[   68.099264][    C0]  ? loop_set_hw_queue_depth+0x60/0x60
[   68.099580][    C0]  __se_sys_ioctl+0xfb/0x170
[   68.099845][    C0]  do_syscall_64+0x3d/0x90
[   68.100106][    C0]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   68.100447][    C0] RIP: 0033:0x7f276e4e4469
[   68.100711][    C0] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8
64 89 01 48
[   68.101805][    C0] RSP: 002b:00007ffdc2646898 EFLAGS: 00000206
ORIG_RAX: 0000000000000010
[   68.102285][    C0] RAX: ffffffffffffffda RBX: 0000000000000000
RCX: 00007f276e4e4469
[   68.102736][    C0] RDX: 0000000000000000 RSI: 0000000000004c80
RDI: 0000000000000004
[   68.103185][    C0] RBP: 00007ffdc26468b0 R08: 0000000000000002
R09: 00007ffdc26468b0
[   68.103634][    C0] R10: 0000000000000001 R11: 0000000000000206
R12: 0000557db3000ce0
[   68.104085][    C0] R13: 00007ffdc26469d0 R14: 0000000000000000
R15: 0000000000000000
[   68.104538][    C0]  </TASK>

Best,
Wei

On Sun, 17 Jul 2022 at 22:41, Keith Busch <kbusch@kernel.org> wrote:
>
> On Sun, Jul 17, 2022 at 10:06:16PM +0800, Wei Chen wrote:
> > Recently when using our tool to fuzz kernel, the following crash was triggered:
> >
> > HEAD commit: 64570fbc14f8 Linux 5.15-rc5
>
> That's an unusual commit to be testing today. Why are you using such an old
> release candidate?
