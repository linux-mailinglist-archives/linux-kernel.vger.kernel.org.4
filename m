Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD607708E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 06:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjESEC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 00:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESEC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 00:02:57 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C9910CF
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 21:02:52 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7606e3c6c8aso210015339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 21:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684468971; x=1687060971;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE5MAIa/WGW491oaDfzd4VTzNY/Jw7o9ZNEjONxGpCI=;
        b=IqbBYDcOpyvZ3NDBaSC+DQZ7k7fdBXj5aB5W6wdqMyxzOmw0Eo+NIF8t+vDBW4Tudc
         Tlw1J372Qa22T9PBLQ1fWKTRscSkQ8dZVSqiLz4Uv+o3iqIWod3AdbKJW8EaJZofzjtD
         b7RdHKeL8wI8Fo7oG9BHmgxwU76w7eK1mtrsHtPWN1551Xr4SY6N22kACgQjL/JKZSpz
         wUEnk7uMRwVZiwnpl6qV3NBXLEYhES00Bgg59q17sV/EF5O/2IndowTNo8uBH5WU8+hZ
         cWlB90OW3/3oIyvwAlW4zPMnqndxOgh2QJHH5TL1Ke8T4eZT7x4IBkaiLPiiFiZlzbeJ
         EGFg==
X-Gm-Message-State: AC+VfDwwK8rUHq4DQh7IfAwiHPm8bNQI9RQkYwId/pramyWj3u/JrHr/
        N3lY0vLE+kyJ/AUSvKtbVNV6indk2FbSJ5VP1I/eUIpwBNZcDLNQ2g==
X-Google-Smtp-Source: ACHHUZ6hc1hS+OJVOgKV2fmogqQqL/EOi74+/Ve74bqeSocGb3WW3jziLm36g5eS9b6b0a/IVnrNUl49jogQE4QJ9IazU0GqZuhB
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10d8:b0:416:419b:1249 with SMTP id
 q24-20020a05663810d800b00416419b1249mr140794jad.4.1684468971526; Thu, 18 May
 2023 21:02:51 -0700 (PDT)
Date:   Thu, 18 May 2023 21:02:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aee45b05fc03fe2c@google.com>
Subject: [syzbot] [kernel?] possible deadlock in hrtimer_start_range_ns
From:   syzbot <syzbot+358bb3e221c762a1adbb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    31f4104e392a Merge tag 'locking_urgent_for_v6.4_rc2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d42cba280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340592eb0a0a7c5
dashboard link: https://syzkaller.appspot.com/bug?extid=358bb3e221c762a1adbb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-31f4104e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c22e5284645/vmlinux-31f4104e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd0741f51071/bzImage-31f4104e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+358bb3e221c762a1adbb@syzkaller.appspotmail.com

wlan0: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc1-syzkaller-00190-g31f4104e392a #0 Not tainted
------------------------------------------------------
kworker/u16:2/5186 is trying to acquire lock:
ffff88803fffeba0 (&pgdat->kswapd_wait){....}-{2:2}, at: __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137

but task is already holding lock:
ffff88802c72b858 (hrtimer_bases.lock){-.-.}-{2:2}, at: switch_hrtimer_base kernel/time/hrtimer.c:253 [inline]
ffff88802c72b858 (hrtimer_bases.lock){-.-.}-{2:2}, at: __hrtimer_start_range_ns kernel/time/hrtimer.c:1252 [inline]
ffff88802c72b858 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_start_range_ns+0x601/0xd80 kernel/time/hrtimer.c:1298

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (hrtimer_bases.lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       lock_hrtimer_base kernel/time/hrtimer.c:173 [inline]
       hrtimer_start_range_ns+0xe9/0xd80 kernel/time/hrtimer.c:1296
       hrtimer_start_expires include/linux/hrtimer.h:432 [inline]
       do_start_rt_bandwidth kernel/sched/rt.c:116 [inline]
       start_rt_bandwidth kernel/sched/rt.c:127 [inline]
       inc_rt_group kernel/sched/rt.c:1241 [inline]
       inc_rt_tasks kernel/sched/rt.c:1285 [inline]
       __enqueue_rt_entity kernel/sched/rt.c:1461 [inline]
       enqueue_rt_entity kernel/sched/rt.c:1510 [inline]
       enqueue_task_rt+0xa86/0xfc0 kernel/sched/rt.c:1545
       enqueue_task+0xad/0x330 kernel/sched/core.c:2082
       __sched_setscheduler.constprop.0+0xb89/0x25d0 kernel/sched/core.c:7774
       _sched_setscheduler kernel/sched/core.c:7820 [inline]
       sched_setscheduler_nocheck kernel/sched/core.c:7867 [inline]
       sched_set_fifo+0xb1/0x110 kernel/sched/core.c:7891
       irq_thread+0xe3/0x540 kernel/irq/manage.c:1302
       kthread+0x344/0x440 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #3 (&rt_b->rt_runtime_lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __enable_runtime kernel/sched/rt.c:876 [inline]
       rq_online_rt+0xb3/0x3b0 kernel/sched/rt.c:2485
       set_rq_online.part.0+0xf9/0x140 kernel/sched/core.c:9541
       set_rq_online kernel/sched/core.c:9533 [inline]
       sched_cpu_activate+0x216/0x440 kernel/sched/core.c:9649
       cpuhp_invoke_callback+0x645/0xeb0 kernel/cpu.c:192
       cpuhp_thread_fun+0x47f/0x700 kernel/cpu.c:815
       smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
       kthread+0x344/0x440 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #2 (&rq->__lock){-.-.}-{2:2}:
       _raw_spin_lock_nested+0x34/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:558
       raw_spin_rq_lock kernel/sched/sched.h:1366 [inline]
       rq_lock kernel/sched/sched.h:1653 [inline]
       task_fork_fair+0x74/0x4f0 kernel/sched/fair.c:12095
       sched_cgroup_fork+0x3d1/0x540 kernel/sched/core.c:4777
       copy_process+0x4b8a/0x7600 kernel/fork.c:2618
       kernel_clone+0xeb/0x890 kernel/fork.c:2918
       user_mode_thread+0xb1/0xf0 kernel/fork.c:2996
       rest_init+0x27/0x2b0 init/main.c:700
       arch_call_rest_init+0x13/0x30 init/main.c:834
       start_kernel+0x3b6/0x490 init/main.c:1088
       x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:556
       x86_64_start_kernel+0xb3/0xc0 arch/x86/kernel/head64.c:537
       secondary_startup_64_no_verify+0xf4/0xfb

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       try_to_wake_up+0xab/0x1c40 kernel/sched/core.c:4191
       autoremove_wake_function+0x16/0x150 kernel/sched/wait.c:419
       __wake_up_common+0x147/0x650 kernel/sched/wait.c:107
       __wake_up_common_lock+0xd4/0x140 kernel/sched/wait.c:138
       wakeup_kswapd+0x3fe/0x5c0 mm/vmscan.c:7797
       rmqueue mm/page_alloc.c:3057 [inline]
       get_page_from_freelist+0x6c5/0x2c00 mm/page_alloc.c:3499
       __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
       __folio_alloc+0x16/0x40 mm/page_alloc.c:4800
       vma_alloc_folio+0x155/0x890 mm/mempolicy.c:2240
       wp_page_copy mm/memory.c:3074 [inline]
       do_wp_page+0x81c/0x33c0 mm/memory.c:3432
       handle_pte_fault mm/memory.c:4964 [inline]
       __handle_mm_fault+0x1635/0x41c0 mm/memory.c:5089
       handle_mm_fault+0x2af/0x9f0 mm/memory.c:5243
       do_user_addr_fault+0x2ca/0x1210 arch/x86/mm/fault.c:1349
       handle_page_fault arch/x86/mm/fault.c:1534 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (&pgdat->kswapd_wait){....}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain kernel/locking/lockdep.c:3842 [inline]
       __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
       lock_acquire kernel/locking/lockdep.c:5691 [inline]
       lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
       wakeup_kswapd+0x3fe/0x5c0 mm/vmscan.c:7797
       wake_all_kswapds+0x182/0x2d0 mm/page_alloc.c:4028
       __alloc_pages_slowpath.constprop.0+0x1724/0x2170 mm/page_alloc.c:4296
       __alloc_pages+0x408/0x4a0 mm/page_alloc.c:4781
       alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
       __stack_depot_save+0x3b4/0x510 lib/stackdepot.c:410
       kasan_save_stack+0x32/0x40 mm/kasan/common.c:46
       kasan_set_track+0x25/0x30 mm/kasan/common.c:52
       __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
       kasan_slab_alloc include/linux/kasan.h:186 [inline]
       slab_post_alloc_hook mm/slab.h:711 [inline]
       slab_alloc_node mm/slab.c:3256 [inline]
       slab_alloc mm/slab.c:3265 [inline]
       __kmem_cache_alloc_lru mm/slab.c:3442 [inline]
       kmem_cache_alloc+0x1bd/0x3f0 mm/slab.c:3451
       kmem_cache_zalloc include/linux/slab.h:670 [inline]
       fill_pool+0x264/0x5c0 lib/debugobjects.c:168
       debug_objects_fill_pool lib/debugobjects.c:597 [inline]
       debug_object_activate+0xfd/0x400 lib/debugobjects.c:693
       debug_hrtimer_activate kernel/time/hrtimer.c:420 [inline]
       debug_activate kernel/time/hrtimer.c:475 [inline]
       enqueue_hrtimer+0x27/0x320 kernel/time/hrtimer.c:1084
       __hrtimer_start_range_ns kernel/time/hrtimer.c:1258 [inline]
       hrtimer_start_range_ns+0x7bb/0xd80 kernel/time/hrtimer.c:1298
       hrtimer_start include/linux/hrtimer.h:418 [inline]
       mac80211_hwsim_link_info_changed+0xbe2/0xd70 drivers/net/wireless/virtual/mac80211_hwsim.c:2478
       ieee80211_bss_info_change_notify+0x3bf/0x8d0 net/mac80211/main.c:254
       __ieee80211_sta_join_ibss+0xb39/0x16a0 net/mac80211/ibss.c:378
       ieee80211_sta_create_ibss+0x1f5/0x400 net/mac80211/ibss.c:1348
       ieee80211_sta_find_ibss net/mac80211/ibss.c:1478 [inline]
       ieee80211_ibss_work+0xb67/0x14a0 net/mac80211/ibss.c:1705
       ieee80211_iface_work+0xbb9/0xd70 net/mac80211/iface.c:1670
       process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
       worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
       kthread+0x344/0x440 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

Chain exists of:
  &pgdat->kswapd_wait --> &rt_b->rt_runtime_lock --> hrtimer_bases.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hrtimer_bases.lock);
                               lock(&rt_b->rt_runtime_lock);
                               lock(hrtimer_bases.lock);
  lock(&pgdat->kswapd_wait);

 *** DEADLOCK ***

4 locks held by kworker/u16:2/5186:
 #0: ffff88802953f138
 ((wq_completion)phy5){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 ((wq_completion)phy5){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 ((wq_completion)phy5){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1324 [inline]
 ((wq_completion)phy5){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:643 [inline]
 ((wq_completion)phy5){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:670 [inline]
 ((wq_completion)phy5){+.+.}-{0:0}, at: process_one_work+0x883/0x15e0 kernel/workqueue.c:2376
 #1: ffffc90002fa7db0 ((work_completion)(&sdata->work)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x15e0 kernel/workqueue.c:2380
 #2: ffff88805bd90d40 (&wdev->mtx){+.+.}-{3:3}, at: sdata_lock net/mac80211/ieee80211_i.h:1129 [inline]
 #2: ffff88805bd90d40 (&wdev->mtx){+.+.}-{3:3}, at: ieee80211_ibss_work+0x94/0x14a0 net/mac80211/ibss.c:1680
 #3: ffff88802c72b858 (hrtimer_bases.lock){-.-.}-{2:2}, at: switch_hrtimer_base kernel/time/hrtimer.c:253 [inline]
 #3: ffff88802c72b858 (hrtimer_bases.lock){-.-.}-{2:2}, at: __hrtimer_start_range_ns kernel/time/hrtimer.c:1252 [inline]
 #3: ffff88802c72b858 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_start_range_ns+0x601/0xd80 kernel/time/hrtimer.c:1298

stack backtrace:
CPU: 1 PID: 5186 Comm: kworker/u16:2 Not tainted 6.4.0-rc1-syzkaller-00190-g31f4104e392a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: phy5 ieee80211_iface_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain kernel/locking/lockdep.c:3842 [inline]
 __lock_acquire+0x2f21/0x5df0 kernel/locking/lockdep.c:5074
 lock_acquire kernel/locking/lockdep.c:5691 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0xb8/0x140 kernel/sched/wait.c:137
 wakeup_kswapd+0x3fe/0x5c0 mm/vmscan.c:7797
 wake_all_kswapds+0x182/0x2d0 mm/page_alloc.c:4028
 __alloc_pages_slowpath.constprop.0+0x1724/0x2170 mm/page_alloc.c:4296
 __alloc_pages+0x408/0x4a0 mm/page_alloc.c:4781
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 __stack_depot_save+0x3b4/0x510 lib/stackdepot.c:410
 kasan_save_stack+0x32/0x40 mm/kasan/common.c:46
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slab.c:3256 [inline]
 slab_alloc mm/slab.c:3265 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3442 [inline]
 kmem_cache_alloc+0x1bd/0x3f0 mm/slab.c:3451
 kmem_cache_zalloc include/linux/slab.h:670 [inline]
 fill_pool+0x264/0x5c0 lib/debugobjects.c:168
 debug_objects_fill_pool lib/debugobjects.c:597 [inline]
 debug_object_activate+0xfd/0x400 lib/debugobjects.c:693
 debug_hrtimer_activate kernel/time/hrtimer.c:420 [inline]
 debug_activate kernel/time/hrtimer.c:475 [inline]
 enqueue_hrtimer+0x27/0x320 kernel/time/hrtimer.c:1084
 __hrtimer_start_range_ns kernel/time/hrtimer.c:1258 [inline]
 hrtimer_start_range_ns+0x7bb/0xd80 kernel/time/hrtimer.c:1298
 hrtimer_start include/linux/hrtimer.h:418 [inline]
 mac80211_hwsim_link_info_changed+0xbe2/0xd70 drivers/net/wireless/virtual/mac80211_hwsim.c:2478
 ieee80211_bss_info_change_notify+0x3bf/0x8d0 net/mac80211/main.c:254
 __ieee80211_sta_join_ibss+0xb39/0x16a0 net/mac80211/ibss.c:378
 ieee80211_sta_create_ibss+0x1f5/0x400 net/mac80211/ibss.c:1348
 ieee80211_sta_find_ibss net/mac80211/ibss.c:1478 [inline]
 ieee80211_ibss_work+0xb67/0x14a0 net/mac80211/ibss.c:1705
 ieee80211_iface_work+0xbb9/0xd70 net/mac80211/iface.c:1670
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
netdevsim netdevsim3 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim3 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim3 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim3 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
hsr_slave_0: left promiscuous mode
hsr_slave_1: left promiscuous mode
batman_adv: batadv0: Interface deactivated: batadv_slave_0
batman_adv: batadv0: Removing interface: batadv_slave_0
batman_adv: batadv0: Interface deactivated: batadv_slave_1
batman_adv: batadv0: Removing interface: batadv_slave_1
bridge_slave_1: left allmulticast mode
bridge_slave_1: left promiscuous mode
bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
veth1_macvtap: left promiscuous mode
veth0_macvtap: left promiscuous mode
veth1_vlan: left promiscuous mode
veth0_vlan: left promiscuous mode
team0 (unregistering): Port device team_slave_1 removed
team0 (unregistering): Port device team_slave_0 removed
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): Released all slaves


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
