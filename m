Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA9366AD9A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 21:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjANUT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 15:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjANUT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 15:19:57 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ABEA5CE
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:19:55 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id j3-20020a056e02154300b00304bc968ef1so18206611ilu.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 12:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkxQA6pn7YG+Kgfha3ynPMbE5+PCwDEveeXQC+SSO0U=;
        b=zCvnP+fd0zlUX4qlA0mp0hpfvcRtDgXKIA1zhI6VW4H0ZH/mMx4HoGZjcqmmWjaRNK
         UUibPhWKIdIqEqpIzasBLiEZvrKMY0DXrow2ye+xTg2tgwiQT78XFiyw1/26RtUmSJLQ
         EpGddTq+y2Uzr1t1OBp2jw2gA0DWzzM+qRh5ICjI0UjD2kEW5h9pwxhOAGowdTKz1HF4
         TLGCiq5EBwhr1sMYvVif1sOOFAkMyia210LsmyWGDk7K9STe4emR20qLS48G6aIXzFRb
         iW3EUB+f1RRObnDl7JMo7AJAG5iQwuFZ8Wt4nIR6uXPxG5JnrVRXukhdP2gytC3JZ8nh
         1MjA==
X-Gm-Message-State: AFqh2kpv49OVRIpeIgPws1NFBjAWcqtlMjWhABZ2C3vjfJUuSquImhrF
        AIBDAWQEE4aJZJUN1zSoVSlaWF9MGYGWZGyn+QncovmbXLSS
X-Google-Smtp-Source: AMrXdXtUtlR8AEIfy9thbmveMdmwX4NbjNpeJDR+Z4pWPnCZ3FVwBwCdbcfip4t5gYLDwOg74MgJB1xP2oTgi2DCBLMTFknj8R/P
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d87:b0:30e:cfd6:4c98 with SMTP id
 i7-20020a056e020d8700b0030ecfd64c98mr1341352ilj.31.1673727594358; Sat, 14 Jan
 2023 12:19:54 -0800 (PST)
Date:   Sat, 14 Jan 2023 12:19:54 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6701405f23f1243@google.com>
Subject: [syzbot] INFO: task hung in hub_event (3)
From:   syzbot <syzbot+a7edecbf389d11a369d4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.grzeschik@pengutronix.de,
        mathias.nyman@linux.intel.com, raychi@google.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    97ec4d559d93 Merge tag 'block-6.2-2023-01-13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c11516480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=a7edecbf389d11a369d4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9e9ef163c5e9/disk-97ec4d55.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3dc9c1e25304/vmlinux-97ec4d55.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7d859b6029ba/bzImage-97ec4d55.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7edecbf389d11a369d4@syzkaller.appspotmail.com

INFO: task kworker/0:5:17966 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc3-syzkaller-00349-g97ec4d559d93 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:5     state:D stack:24608 pid:17966 ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5293 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6606
 schedule+0xde/0x1b0 kernel/sched/core.c:6682
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6741
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 port_event drivers/usb/core/hub.c:5709 [inline]
 hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/1:2:12207 blocked for more than 144 seconds.
      Not tainted 6.2.0-rc3-syzkaller-00349-g97ec4d559d93 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:27256 pid:12207 ppid:2      flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5293 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6606
 schedule+0xde/0x1b0 kernel/sched/core.c:6682
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6741
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 port_event drivers/usb/core/hub.c:5709 [inline]
 hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8c790fb0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8c790cb0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8c791b00 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x57/0x264 kernel/locking/lockdep.c:6494
1 lock held by kworker/0:1H/52:
 #0: ffff8880b983b598 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:545 [inline]
 #0: ffff8880b983b598 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x90/0x120 kernel/sched/core.c:530
2 locks held by getty/4748:
 #0: ffff88802bd3b098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015a02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2177
1 lock held by syz-executor.1/5113:
5 locks held by kworker/0:5/17966:
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc9000210fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff88814725d190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:831 [inline]
 #2: ffff88814725d190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4810 drivers/usb/core/hub.c:5737
 #3: ffff8881472a04f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3145 [inline]
 #3: ffff8881472a04f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5301 [inline]
 #3: ffff8881472a04f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #3: ffff8881472a04f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #3: ffff8881472a04f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x277c/0x4810 drivers/usb/core/hub.c:5791
 #4: ffff88814697d468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 #4: ffff88814697d468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #4: ffff88814697d468 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #4: ffff88814697d468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
5 locks held by kworker/0:9/19328:
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc9000471fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff888021fff190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:831 [inline]
 #2: ffff888021fff190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4810 drivers/usb/core/hub.c:5737
 #3: ffff8881473b24f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3145 [inline]
 #3: ffff8881473b24f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5301 [inline]
 #3: ffff8881473b24f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #3: ffff8881473b24f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #3: ffff8881473b24f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x277c/0x4810 drivers/usb/core/hub.c:5791
 #4: ffff88801c847a68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 #4: ffff88801c847a68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #4: ffff88801c847a68 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #4: ffff88801c847a68 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
5 locks held by kworker/0:0/25428:
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc900047efda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff888147237190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:831 [inline]
 #2: ffff888147237190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4810 drivers/usb/core/hub.c:5737
 #3: ffff88814724a4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3145 [inline]
 #3: ffff88814724a4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5301 [inline]
 #3: ffff88814724a4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #3: ffff88814724a4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #3: ffff88814724a4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x277c/0x4810 drivers/usb/core/hub.c:5791
 #4: ffff888147205368 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 #4: ffff888147205368 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #4: ffff888147205368 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #4: ffff888147205368 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
5 locks held by kworker/1:23/26875:
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc9000ba3fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff8881472ab190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:831 [inline]
 #2: ffff8881472ab190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4810 drivers/usb/core/hub.c:5737
 #3: ffff8881472ae4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3145 [inline]
 #3: ffff8881472ae4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5301 [inline]
 #3: ffff8881472ae4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #3: ffff8881472ae4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #3: ffff8881472ae4f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x277c/0x4810 drivers/usb/core/hub.c:5791
 #4: ffff88814697d468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 #4: ffff88814697d468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #4: ffff88814697d468 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #4: ffff88814697d468 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
2 locks held by kworker/u4:1/8522:
5 locks held by kworker/1:2/12207:
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888017ef0938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc9000319fda8 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff888147221190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:831 [inline]
 #2: ffff888147221190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1c0/0x4810 drivers/usb/core/hub.c:5737
 #3: ffff8881472244f8 (&port_dev->status_lock){+.+.}-{3:3}, at: usb_lock_port drivers/usb/core/hub.c:3145 [inline]
 #3: ffff8881472244f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5301 [inline]
 #3: ffff8881472244f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #3: ffff8881472244f8 (&port_dev->status_lock){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #3: ffff8881472244f8 (&port_dev->status_lock){+.+.}-{3:3}, at: hub_event+0x277c/0x4810 drivers/usb/core/hub.c:5791
 #4: ffff888147205368 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect drivers/usb/core/hub.c:5302 [inline]
 #4: ffff888147205368 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 #4: ffff888147205368 (hcd->address0_mutex){+.+.}-{3:3}, at: port_event drivers/usb/core/hub.c:5709 [inline]
 #4: ffff888147205368 (hcd->address0_mutex){+.+.}-{3:3}, at: hub_event+0x27b1/0x4810 drivers/usb/core/hub.c:5791
1 lock held by syz-executor.2/16250:
 #0: ffff8880b983b598 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:545 [inline]
 #0: ffff8880b983b598 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x90/0x120 kernel/sched/core.c:530
2 locks held by sed/16260:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.2.0-rc3-syzkaller-00349-g97ec4d559d93 #0
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
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:112 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_idle_do_entry+0x1fd/0x2a0 drivers/acpi/processor_idle.c:570


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
