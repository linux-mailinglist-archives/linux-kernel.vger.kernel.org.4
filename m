Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C36F846F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjEEOBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjEEOBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:01:48 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E962713
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 07:01:46 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-763c3442563so111371239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 07:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683295306; x=1685887306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl7vEIfvjX1GQVBYs0qBxlowKzBp/cj+YSrMqUiEgjw=;
        b=gFjwuR7087BxUKtmR4ZcF1PcmKaPrQDEtWHFhby/r7ThOIlc9uTppcOvDTwg/Th/5A
         dj5Bf0bAz+lFnREJObirBikelILJAMNcDpx7E0BpFaB6lxEf1sP8bmVUgSBupYW5f4Zt
         UIYOhEWijgeD3WEgDiHprZLuV3M8vMVroxmQeRxqTA6Q2vHnKJ7rLaWAVwlcxbJpjd42
         a2qzifXrEr5gWUMShTEkF46RJTEgRLOGp9tp0WM/uWW4qZz0/Jsna7BDC4BhTodTS6bZ
         st6nM1ZTny7FNxPItZItI/ytojDy4GUZEpFfRTHh37t7k3OEvoi4/dYavTEabZkWw7hN
         nw0w==
X-Gm-Message-State: AC+VfDxYgtghoQVi9LwEfkhedStUk/6vo79KJaUR+PHn2whQgaGywQUX
        pn+ZZutilPJVOWediP+sFBRqX4yE1wXp7DEl/7dqWzH0Ul1x
X-Google-Smtp-Source: ACHHUZ6QbiJTBbIPC/3MSCRw8akgK0iYSwEgfzs6EKJr2Epl32CH9qfszWl/Kdc6IF7nfS8hdwKf25QtoDZaK8CMGi4vpJJni220
MIME-Version: 1.0
X-Received: by 2002:a5d:9d0c:0:b0:760:ebc0:c396 with SMTP id
 j12-20020a5d9d0c000000b00760ebc0c396mr576322ioj.3.1683295305892; Fri, 05 May
 2023 07:01:45 -0700 (PDT)
Date:   Fri, 05 May 2023 07:01:45 -0700
In-Reply-To: <000000000000fd3ea305f0644a0b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2922605faf2baeb@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_get_descriptor (2)
From:   syzbot <syzbot+e8db9d9e65feff8fa471@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mailhol.vincent@wanadoo.fr,
        mkl@pengutronix.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3c4aa4434377 Merge tag 'ceph-for-6.4-rc1' of https://githu..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12b780bc280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87f9126139666d37
dashboard link: https://syzkaller.appspot.com/bug?extid=e8db9d9e65feff8fa471
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1132f45c280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14328870280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5c99ec63ebd1/disk-3c4aa443.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e6de84bd47ce/vmlinux-3c4aa443.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f12b28027b9e/bzImage-3c4aa443.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8db9d9e65feff8fa471@syzkaller.appspotmail.com

INFO: task kworker/0:2:758 blocked for more than 143 seconds.
      Not tainted 6.3.0-syzkaller-13091-g3c4aa4434377 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:25768 pid:758   ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6669
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 usb_kill_urb.part.0+0x19a/0x220 drivers/usb/core/urb.c:728
 usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:717
 usb_start_wait_urb+0x24a/0x4b0 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
 usb_get_descriptor+0xe1/0x1d0 drivers/usb/core/message.c:793
 usb_get_device_descriptor+0x85/0xf0 drivers/usb/core/message.c:1072
 hub_port_init+0x859/0x3900 drivers/usb/core/hub.c:4969
 hub_port_connect drivers/usb/core/hub.c:5336 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2b89/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffffffff8c798670 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c798370 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:518
1 lock held by khungtaskd/28:
 #0: ffffffff8c799280 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6545
5 locks held by kworker/0:2/758:
 #0: ffff888147e7c138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888147e7c138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888147e7c138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1324 [inline]
 #0: ffff888147e7c138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:643 [inline]
 #0: ffff888147e7c138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:670 [inline]
 #0: ffff888147e7c138 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x883/0x15e0 kernel/workqueue.c:2376
 #1: ffffc9000404fdb0 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x15e0 kernel/workqueue.c:2380
 #2: ffff888142b9b190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:837 [inline]
 #2: ffff888142b9b190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4e40 drivers/usb/core/hub.c:5739
 #3: ffff888142b9e4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3147 [inline]
 #3: ffff888142b9e4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5303 [inline]
 #3: ffff888142b9e4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 #3: ffff888142b9e4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5711 [inline]
 #3: ffff888142b9e4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x278e/0x4e40 drivers/usb/core/hub.c:5793
 #4: ffff8881427f4d68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5304 [inline]
 #4: ffff8881427f4d68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 #4: ffff8881427f4d68 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5711 [inline]
 #4: ffff8881427f4d68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27c3/0x4e40 drivers/usb/core/hub.c:5793
2 locks held by getty/4760:
 #0: ffff88814ae7f098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015802f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2176
1 lock held by strace-static-x/5000:
 #0: ffffffff8c40a098 (tasklist_lock){.+.+}-{2:2}, at: raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:558
2 locks held by dhcpcd/28900:
 #0: ffff88807a84e130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1697 [inline]
 #0: ffff88807a84e130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2f/0xe30 net/packet/af_packet.c:3204
 #1: ffffffff8c7a46f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:293 [inline]
 #1: ffffffff8c7a46f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x64a/0x770 kernel/rcu/tree_exp.h:992

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.3.0-syzkaller-13091-g3c4aa4434377 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2a4/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe16/0x1090 kernel/hung_task.c:379
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 12 Comm: kworker/u4:1 Not tainted 6.3.0-syzkaller-13091-g3c4aa4434377 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:hlock_class kernel/locking/lockdep.c:228 [inline]
RIP: 0010:__lock_acquire+0x1727/0x5df0 kernel/locking/lockdep.c:5070
Code: f8 66 81 e3 ff 1f 0f b7 db be 08 00 00 00 48 89 d8 48 c1 e8 06 48 8d 3c c5 00 8d 52 91 e8 51 8b 71 00 48 0f a3 1d f9 e4 ec 0f <0f> 83 51 06 00 00 48 8d 1c 5b 48 c1 e3 06 48 81 c3 20 91 52 91 48
RSP: 0018:ffffc90000117598 EFLAGS: 00000047
RAX: 0000000000000001 RBX: 00000000000000bb RCX: ffffffff8165a7ff
RDX: fffffbfff22a51a3 RSI: 0000000000000008 RDI: ffffffff91528d10
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff91528d17
R10: fffffbfff22a51a2 R11: 0000000000000000 R12: ffff888016646458
R13: ffff888016645940 R14: 0000000000000000 R15: c19cd5fde613a6fd
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe22eb1e0cf CR3: 000000000c571000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5691 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5656
 _raw_spin_lock_nested+0x34/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:558
 raw_spin_rq_lock kernel/sched/sched.h:1366 [inline]
 _raw_spin_rq_lock_irqsave kernel/sched/sched.h:1385 [inline]
 rq_lock_irqsave kernel/sched/sched.h:1637 [inline]
 update_blocked_averages+0x80/0x1dd0 kernel/sched/fair.c:9021
 newidle_balance+0x485/0x11d0 kernel/sched/fair.c:11800
 pick_next_task_fair+0x9a/0x1290 kernel/sched/fair.c:8107
 __pick_next_task kernel/sched/core.c:5972 [inline]
 pick_next_task kernel/sched/core.c:6047 [inline]
 __schedule+0x462/0x5880 kernel/sched/core.c:6633
 schedule+0xde/0x1a0 kernel/sched/core.c:6745
 toggle_allocation_gate mm/kfence/core.c:833 [inline]
 toggle_allocation_gate+0x1ad/0x230 mm/kfence/core.c:823
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
