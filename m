Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06246CBEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjC1MXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjC1MXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:23:46 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC21BE1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:23:44 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id l7-20020a0566022dc700b0074cc9aba965so7349508iow.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680006224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09f06ejErVvh4RHwn/67piBMXzku9QX7VVb+REYTXX0=;
        b=Y2p/c8d9hOMfCY759Z+hdDCrjqs3nwMJsS3Zy7NzPmracqwzZTzFjZpd1MafnoBD3Y
         y3YXM0o1UsjauSNAJ1TnbGyIcSz6OW9Vn01y6gvWIhvr2twrAU5+Hd+yW+C+0Inyid33
         KJRMXTh4dqz9Inl7jcmBjzHLdBhgAbePE+B+BrTp0dsl9N+YM1nkATGz22B/B2mm4VB7
         qG1DH4NGfUjdWUv4JCoZYKTQSeFDnr1avFUYj6c47rHJyXHHVwOfBoGcrsqwaiJQW8E2
         KKT1IxP6BW9gEhYuPKFqmOqR4b9zetU57K5DH7/nYN/NwCdamRnTgU4E+2bkASdgaRVA
         rKww==
X-Gm-Message-State: AO0yUKWse7OUVokvgm1NuMZQF99/rCL5W7rDc4qTr2O+VD5VAv6gJT4b
        NR3/QR/nEQBp1eW/6MopiR8InSyPXuRqU3PKRYpskoOY/IEU
X-Google-Smtp-Source: AK7set80/t5gLQfrcqvobH0RaEpHGvWzThaLXkhaYf5yTr3aucD+8s2L1jpFOfGxa3yFEbUo4euPTzlT7cTTcL/w43eVgVOPDFtk
MIME-Version: 1.0
X-Received: by 2002:a6b:6307:0:b0:752:fc52:a200 with SMTP id
 p7-20020a6b6307000000b00752fc52a200mr5426823iog.2.1680006223831; Tue, 28 Mar
 2023 05:23:43 -0700 (PDT)
Date:   Tue, 28 Mar 2023 05:23:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000312a0305f7f4ee65@google.com>
Subject: [syzbot] [usb?] INFO: task hung in hub_port_init (3)
From:   syzbot <syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fff5a5e7f528 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1283ef16c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40f6d44826f6cf7
dashboard link: https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7bbf96292b2f/disk-fff5a5e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/65b622a8d0af/vmlinux-fff5a5e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/736865f3bb58/bzImage-fff5a5e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6f11035e572f08bc20f@syzkaller.appspotmail.com

INFO: task kworker/1:10:9980 blocked for more than 143 seconds.
      Not tainted 6.3.0-rc3-syzkaller-00026-gfff5a5e7f528 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:10    state:D stack:22992 pid:9980  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x173b/0x4630 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 usb_kill_urb+0x1c9/0x300 drivers/usb/core/urb.c:728
 usb_start_wait_urb+0x1b0/0x520 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x2b1/0x4c0 drivers/usb/core/message.c:153
 hub_port_init+0xa9f/0x2530 drivers/usb/core/hub.c:4874
 hub_port_connect drivers/usb/core/hub.c:5336 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2bbf/0x5460 drivers/usb/core/hub.c:5793
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/1:13:10611 blocked for more than 143 seconds.
      Not tainted 6.3.0-rc3-syzkaller-00026-gfff5a5e7f528 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:13    state:D stack:25016 pid:10611 ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x173b/0x4630 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 usb_kill_urb+0x1c9/0x300 drivers/usb/core/urb.c:728
 usb_start_wait_urb+0x1b0/0x520 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x2b1/0x4c0 drivers/usb/core/message.c:153
 hub_port_init+0xa9f/0x2530 drivers/usb/core/hub.c:4874
 hub_port_connect drivers/usb/core/hub.c:5336 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2bbf/0x5460 drivers/usb/core/hub.c:5793
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/1:15:10757 blocked for more than 144 seconds.
      Not tainted 6.3.0-rc3-syzkaller-00026-gfff5a5e7f528 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:15    state:D stack:25112 pid:10757 ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0x173b/0x4630 kernel/sched/core.c:6622
 schedule+0xc3/0x180 kernel/sched/core.c:6698
 usb_kill_urb+0x1c9/0x300 drivers/usb/core/urb.c:728
 usb_start_wait_urb+0x1b0/0x520 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x2b1/0x4c0 drivers/usb/core/message.c:153
 hub_port_init+0xa9f/0x2530 drivers/usb/core/hub.c:4874
 hub_port_connect drivers/usb/core/hub.c:5336 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2bbf/0x5460 drivers/usb/core/hub.c:5793
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8cf255f0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:510
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8cf25df0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x29/0xd20 kernel/rcu/tasks.h:510
1 lock held by khungtaskd/28:
 #0: ffffffff8cf25420 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
3 locks held by kworker/u4:3/46:
 #0: ffff8880b983be98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:547
 #1: ffffc90000b77d20 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work+0x7c8/0x10e0 kernel/workqueue.c:2365
 #2: ffff8880b9929598 (&base->lock){-.-.}-{2:2}, at: lock_timer_base+0x120/0x260 kernel/time/timer.c:999
2 locks held by getty/4746:
 #0: ffff88814a687098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015b02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ab/0x1db0 drivers/tty/n_tty.c:2177
5 locks held by kworker/1:10/9980:
 #0: ffff888017d04538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x77e/0x10e0 kernel/workqueue.c:2363
 #1: ffffc9000b06fd20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x7c8/0x10e0 kernel/workqueue.c:2365
 #2: ffff888021e2d190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
 #2: ffff888021e2d190 (&dev->mutex){....}-{3:3}, at: hub_event+0x20e/0x5460 drivers/usb/core/hub.c:5739
 #3: ffff888021e484f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3147 [inline]
 #3: ffff888021e484f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5303 [inline]
 #3: ffff888021e484f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 #3: ffff888021e484f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5711 [inline]
 #3: ffff888021e484f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x252f/0x5460 drivers/usb/core/hub.c:5793
 #4: ffff888021db0068 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5304 [inline]
 #4: ffff888021db0068 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 #4: ffff888021db0068 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5711 [inline]
 #4: ffff888021db0068 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x2564/0x5460 drivers/usb/core/hub.c:5793
3 locks held by kworker/0:14/10515:
 #0: ffff888012470d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x77e/0x10e0 kernel/workqueue.c:2363
 #1: ffffc900162b7d20 ((work_completion)(&pwq->unbound_release_work)){+.+.}-{0:0}, at: process_one_work+0x7c8/0x10e0 kernel/workqueue.c:2365
 #2: ffffffff8cf2a8f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:325 [inline]
 #2: ffffffff8cf2a8f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x46c/0x890 kernel/rcu/tree_exp.h:989
5 locks held by kworker/1:13/10611:
 #0: ffff888017d04538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x77e/0x10e0 kernel/workqueue.c:2363
 #1: ffffc900033cfd20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x7c8/0x10e0 kernel/workqueue.c:2365
 #2: ffff8880219ef190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
 #2: ffff8880219ef190 (&dev->mutex){....}-{3:3}, at: hub_event+0x20e/0x5460 drivers/usb/core/hub.c:5739
 #3: ffff8881474bb4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3147 [inline]
 #3: ffff8881474bb4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5303 [inline]
 #3: ffff8881474bb4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 #3: ffff8881474bb4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5711 [inline]
 #3: ffff8881474bb4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x252f/0x5460 drivers/usb/core/hub.c:5793
 #4: ffff8880217e4968 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5304 [inline]
 #4: ffff8880217e4968 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 #4: ffff8880217e4968 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5711 [inline]
 #4: ffff8880217e4968 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x2564/0x5460 drivers/usb/core/hub.c:5793
5 locks held by kworker/1:15/10757:
 #0: ffff888017d04538 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x77e/0x10e0 kernel/workqueue.c:2363
 #1: ffffc900039afd20 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x7c8/0x10e0 kernel/workqueue.c:2365
 #2: ffff888021f09190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:832 [inline]
 #2: ffff888021f09190 (&dev->mutex){....}-{3:3}, at: hub_event+0x20e/0x5460 drivers/usb/core/hub.c:5739
 #3: ffff888021f0c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3147 [inline]
 #3: ffff888021f0c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5303 [inline]
 #3: ffff888021f0c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 #3: ffff888021f0c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5711 [inline]
 #3: ffff888021f0c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x252f/0x5460 drivers/usb/core/hub.c:5793
 #4: ffff888021ebc268 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5304 [inline]
 #4: ffff888021ebc268 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 #4: ffff888021ebc268 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5711 [inline]
 #4: ffff888021ebc268 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x2564/0x5460 drivers/usb/core/hub.c:5793
2 locks held by kworker/1:16/10759:
 #0: ffff888012472538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x77e/0x10e0 kernel/workqueue.c:2363
 #1: ffffc900039efd20 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7c8/0x10e0 kernel/workqueue.c:2365
1 lock held by syz-executor.3/17813:
 #0: ffffffff8e08a168 (rtnl_mutex){+.+.}-{3:3}, at: ppp_release+0x8a/0x1f0 drivers/net/ppp/ppp_generic.c:405
1 lock held by syz-executor.4/17815:
 #0: ffffffff8cf2a7c0 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x540 kernel/rcu/tree.c:3945
1 lock held by syz-executor.1/17825:
 #0: ffffffff8cf2a7c0 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x540 kernel/rcu/tree.c:3945
1 lock held by syz-executor.0/17832:
 #0: ffffffff8cf2a7c0 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x540 kernel/rcu/tree.c:3945
2 locks held by syz-executor.5/17841:
 #0: ffffffff8e08a168 (rtnl_mutex){+.+.}-{3:3}, at: ppp_release+0x8a/0x1f0 drivers/net/ppp/ppp_generic.c:405
 #1: ffffffff8cf2a8f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:293 [inline]
 #1: ffffffff8cf2a8f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3a3/0x890 kernel/rcu/tree_exp.h:989

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.3.0-rc3-syzkaller-00026-gfff5a5e7f528 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x187/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xec2/0xf00 kernel/hung_task.c:379
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 7818 Comm: kworker/u4:15 Not tainted 6.3.0-rc3-syzkaller-00026-gfff5a5e7f528 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: bat_events batadv_nc_worker
RIP: 0010:__lock_acquire+0x121/0x1f80 kernel/locking/lockdep.c:4959
Code: e8 03 48 89 44 24 28 0f b6 04 10 84 c0 0f 85 6d 15 00 00 48 89 6c 24 18 8b 75 00 48 c7 c0 e0 70 ad 91 48 c1 e8 03 0f b6 04 10 <84> c0 48 89 74 24 40 0f 85 70 15 00 00 83 3d eb 50 43 10 00 75 09
RSP: 0018:ffffc90015d5f9a0 EFLAGS: 00000802
RAX: 0000000000000004 RBX: ffffffff8ffd6980 RCX: 0000000000000002
RDX: dffffc0000000000 RSI: 0000000000000002 RDI: ffffffff8cf25420
RBP: ffff888026842770 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000002
R13: ffff888026841d40 R14: ffffffff8cf25420 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556f79888 CR3: 000000003ff54000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000000a DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1e1/0x520 kernel/locking/lockdep.c:5669
 rcu_lock_acquire+0x2e/0x40 include/linux/rcupdate.h:327
 rcu_read_lock include/linux/rcupdate.h:773 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0xc5/0x5c0 net/batman-adv/network-coding.c:719
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
