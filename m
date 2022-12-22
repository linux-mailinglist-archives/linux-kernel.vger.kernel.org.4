Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4D653BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 06:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiLVFx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 00:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:53:51 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43AD6240
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 21:53:49 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso599200ilu.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 21:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrLyCkjejlehmh+M75P8FUybhr7YLUz0tl3VB0GgeW0=;
        b=N+jkUwBdSej7SjnXp+Fd1+t6JXBWAq+TElGJA8S0A/5yymvzsb0Bnq50xsjB8G9L1p
         L4GM5kQI+fd3NazcPNz58qegRqSvYr9Fq6n4jLFA8WMgLLI2Too0UZeL2HqYkuNCOf/n
         YHgXK0ABNkG6DJ043zvS1xj855KRj6lv6bCbm7kdVnGpFk6pyifIb1WGW9uXQgbZNF0b
         JGgu/WDjiU/l3TL7PoEA80VI5UdOVIBk59J2slhLT/mofLuyklPOvpbs9t72peDxMzWi
         4OEaZ+334leYJInXKs1VfZV6nruGQfO6plbkqN09uSSUvdtflgbEzWH559fh5mW2ejho
         sAww==
X-Gm-Message-State: AFqh2krg5bXpQPc1tb0uOpDxsWyXQ6xCZUSJWRO031lE/0WnBKQLRTPp
        vsihp15CCkvsLaRuFGEMQSsRCgcGrhSiEV07hq6RVIGgUcgV
X-Google-Smtp-Source: AMrXdXvMl9MHnufAofhFKeSaHMmsvRuWt0m6YkuwH4oQ4a+aJbaLSGjohl9OIo3TurtkrDKv++VjVmcUCMEFnpOkg1X+bQNGJUle
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4b81:b0:38a:1a3:d5ac with SMTP id
 dj1-20020a0566384b8100b0038a01a3d5acmr377893jab.256.1671688429056; Wed, 21
 Dec 2022 21:53:49 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:53:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd3ea305f0644a0b@google.com>
Subject: [syzbot] INFO: task hung in usb_get_descriptor (2)
From:   syzbot <syzbot+e8db9d9e65feff8fa471@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mailhol.vincent@wanadoo.fr,
        mkl@pengutronix.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7a693ea78e3c Merge tag 'pwm/for-6.2-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12752f9f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85327a149d5f50f
dashboard link: https://syzkaller.appspot.com/bug?extid=e8db9d9e65feff8fa471
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/53884d225619/disk-7a693ea7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad23f4d4db72/vmlinux-7a693ea7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/42a3204693fd/bzImage-7a693ea7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8db9d9e65feff8fa471@syzkaller.appspotmail.com

INFO: task kworker/0:3:5160 blocked for more than 143 seconds.
      Not tainted 6.1.0-syzkaller-14214-g7a693ea78e3c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:25200 pid:5160  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 usb_kill_urb.part.0+0x19a/0x220 drivers/usb/core/urb.c:728
 usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:717
 usb_start_wait_urb+0x24a/0x4b0 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
 usb_get_descriptor+0xe1/0x1d0 drivers/usb/core/message.c:793
 usb_get_device_descriptor+0x85/0xf0 drivers/usb/core/message.c:1072
 hub_port_init+0x7d1/0x3570 drivers/usb/core/hub.c:4967
 hub_port_connect drivers/usb/core/hub.c:5334 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 port_event drivers/usb/core/hub.c:5709 [inline]
 hub_event+0x2b5d/0x4810 drivers/usb/core/hub.c:5791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/0:6:5165 blocked for more than 143 seconds.
      Not tainted 6.1.0-syzkaller-14214-g7a693ea78e3c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:6     state:D stack:22296 pid:5165  ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 usb_kill_urb.part.0+0x19a/0x220 drivers/usb/core/urb.c:728
 usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:717
 usb_start_wait_urb+0x24a/0x4b0 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
 usb_get_descriptor+0xe1/0x1d0 drivers/usb/core/message.c:793
 usb_get_device_descriptor+0x85/0xf0 drivers/usb/core/message.c:1072
 hub_port_init+0x7d1/0x3570 drivers/usb/core/hub.c:4967
 hub_port_connect drivers/usb/core/hub.c:5334 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 port_event drivers/usb/core/hub.c:5709 [inline]
 hub_event+0x2b5d/0x4810 drivers/usb/core/hub.c:5791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/1:19:18591 blocked for more than 144 seconds.
      Not tainted 6.1.0-syzkaller-14214-g7a693ea78e3c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:19    state:D stack:25976 pid:18591 ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 usb_kill_urb.part.0+0x19a/0x220 drivers/usb/core/urb.c:728
 usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:717
 usb_start_wait_urb+0x24a/0x4b0 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
 usb_get_descriptor+0xe1/0x1d0 drivers/usb/core/message.c:793
 usb_get_device_descriptor+0x85/0xf0 drivers/usb/core/message.c:1072
 hub_port_init+0x7d1/0x3570 drivers/usb/core/hub.c:4967
 hub_port_connect drivers/usb/core/hub.c:5334 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 port_event drivers/usb/core/hub.c:5709 [inline]
 hub_event+0x2b5d/0x4810 drivers/usb/core/hub.c:5791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/1:24:18596 blocked for more than 144 seconds.
      Not tainted 6.1.0-syzkaller-14214-g7a693ea78e3c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:24    state:D stack:21888 pid:18596 ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 usb_kill_urb.part.0+0x19a/0x220 drivers/usb/core/urb.c:728
 usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:717
 usb_start_wait_urb+0x24a/0x4b0 drivers/usb/core/message.c:64
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
 usb_get_descriptor+0xe1/0x1d0 drivers/usb/core/message.c:793
 usb_get_device_descriptor+0x85/0xf0 drivers/usb/core/message.c:1072
 hub_port_init+0x7d1/0x3570 drivers/usb/core/hub.c:4967
 hub_port_connect drivers/usb/core/hub.c:5334 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 port_event drivers/usb/core/hub.c:5709 [inline]
 hub_event+0x2b5d/0x4810 drivers/usb/core/hub.c:5791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8c790c70 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8c790970 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8c7917c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x57/0x264 kernel/locking/lockdep.c:6494
2 locks held by getty/4749:
 #0: ffff888028017098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2177
5 locks held by kworker/0:3/5160:
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc90004b07da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff888147199190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:831 [inline]
 #2: ffff888147199190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4810 drivers/usb/core/hub.c:5737
 #3: ffff88814719c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3145 [inline]
 #3: ffff88814719c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5301 [inline]
 #3: ffff88814719c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #3: ffff88814719c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #3: ffff88814719c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x277c/0x4810 drivers/usb/core/hub.c:5791
 #4: ffff888147155068 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 #4: ffff888147155068 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #4: ffff888147155068 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #4: ffff888147155068 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
5 locks held by kworker/0:6/5165:
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc90004b77da8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff8880222c5190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:831 [inline]
 #2: ffff8880222c5190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4810 drivers/usb/core/hub.c:5737
 #3: ffff8881470204f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3145 [inline]
 #3: ffff8881470204f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5301 [inline]
 #3: ffff8881470204f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #3: ffff8881470204f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #3: ffff8881470204f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x277c/0x4810 drivers/usb/core/hub.c:5791
 #4: ffff888146f61a68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 #4: ffff888146f61a68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #4: ffff888146f61a68 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #4: ffff888146f61a68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
5 locks held by kworker/1:19/18591:
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc9000317fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff8881471dd190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:831 [inline]
 #2: ffff8881471dd190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4810 drivers/usb/core/hub.c:5737
 #3: ffff8881471e84f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3145 [inline]
 #3: ffff8881471e84f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5301 [inline]
 #3: ffff8881471e84f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #3: ffff8881471e84f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #3: ffff8881471e84f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x277c/0x4810 drivers/usb/core/hub.c:5791
 #4: ffff88823bc58068 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 #4: ffff88823bc58068 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #4: ffff88823bc58068 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #4: ffff88823bc58068 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
5 locks held by kworker/1:24/18596:
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888017fa0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc900031cfda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff888147059190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:831 [inline]
 #2: ffff888147059190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4810 drivers/usb/core/hub.c:5737
 #3: ffff88814705c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3145 [inline]
 #3: ffff88814705c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5301 [inline]
 #3: ffff88814705c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #3: ffff88814705c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #3: ffff88814705c4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x277c/0x4810 drivers/usb/core/hub.c:5791
 #4: ffff888021f59d68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 #4: ffff888021f59d68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #4: ffff888021f59d68 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #4: ffff888021f59d68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
2 locks held by kworker/u4:1/32420:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.1.0-syzkaller-14214-g7a693ea78e3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x24/0x18a lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x333/0x3c0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xc75/0xfc0 kernel/hung_task.c:377
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5323 Comm: kworker/u4:8 Not tainted 6.1.0-syzkaller-14214-g7a693ea78e3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:match_held_lock+0x14/0xc0 kernel/locking/lockdep.c:5117
Code: 31 c0 48 83 c4 08 5d c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 53 48 89 fb 48 83 ec 08 48 39 77 10 74 6a 66 f7 47 22 f0 ff <74> 5a 48 8b 46 08 48 89 f7 48 85 c0 74 42 8b 15 08 a7 ba 07 85 d2
RSP: 0018:ffffc9000552f910 EFLAGS: 00000046
RAX: 0000000000000014 RBX: ffff888028db2818 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8c791700 RDI: ffff888028db2818
RBP: ffffffff8c791700 R08: 0000000000000000 R09: ffffffff8e72db97
R10: fffffbfff1ce5b72 R11: 0000000000000000 R12: ffff888028db1d40
R13: ffff888028db2778 R14: 00000000ffffffff R15: ffff888028db2818
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe1ea984998 CR3: 0000000012463000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 __lock_is_held kernel/locking/lockdep.c:5409 [inline]
 lock_is_held_type+0xab/0x140 kernel/locking/lockdep.c:5711
 lock_is_held include/linux/lockdep.h:283 [inline]
 rcu_read_lock_sched_held+0x3e/0x70 kernel/rcu/update.c:125
 trace_tlb_flush include/trace/events/tlb.h:38 [inline]
 trace_tlb_flush+0x191/0x240 include/trace/events/tlb.h:38
 switch_mm_irqs_off+0x668/0xbe0 arch/x86/mm/tlb.c:630
 use_temporary_mm arch/x86/kernel/alternative.c:1496 [inline]
 __text_poke+0x2f7/0x8e0 arch/x86/kernel/alternative.c:1607
 text_poke arch/x86/kernel/alternative.c:1671 [inline]
 text_poke_bp_batch+0x37d/0x6b0 arch/x86/kernel/alternative.c:1976
 text_poke_flush arch/x86/kernel/alternative.c:2131 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2128 [inline]
 text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:2138
 arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:829
 static_key_disable_cpuslocked+0x156/0x1b0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:804 [inline]
 toggle_allocation_gate+0x143/0x230 mm/kfence/core.c:791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
