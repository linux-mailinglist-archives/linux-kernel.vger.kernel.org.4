Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA3D5F9EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiJJMyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJJMyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:54:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F1953A4D;
        Mon, 10 Oct 2022 05:53:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ot12so24729829ejb.1;
        Mon, 10 Oct 2022 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4wf5a6RwI0+jg+xHIHcR0fSixVvpo7nyMe5bP8RORDA=;
        b=Cys3I2hoR68wwtPuWOpSaptgp6Z76LWlbs3QNm4zu15F9WXpgmmXoYuH1YKim+igzD
         hEmOexAUjSE/ZBME6OxySgyymWM/AduQaCJoEfE2dKqFurI3evGbhcbuSY4NXAqwq+ME
         X6x1lZQSHa4R/vi8bPVSR+xOIZ0pJLUuhkW3Odp2LtVzFT0qwGpmBTsOBkXH8jf+HshR
         X8ympZcI1nwnbLpSzqyIn1uYt8Wk5NS0syGcE3Nh/SaJ2ebHw62Hx+PoRE98qDs+avGd
         aGHZnc4Mn0KhdKD9Ppm4W8k58g0XzQNtfhR/AwstWP2JKdc7I5HIVM989XnX4KWyJ8F5
         1IEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wf5a6RwI0+jg+xHIHcR0fSixVvpo7nyMe5bP8RORDA=;
        b=D6I6382Hp2gZ3cNCIiVFeufAvqAziOaGZZBcD1dXS9zHjtsoXNoeifW/pV7zNKztFP
         W1MtKVJ9+WiFPwaSFlr+YCVPfWbCgmPrb8oY3gAwRnhUfvdH2Z0+uWnBMySIuUk5xwE0
         oG1AbX5dDf+V5+kLKtijbutKhJA9LOWIyZK4FxZzLHIwEiqOUXgyQCp2H5Cu6+9OLjC7
         7vsvLVm61CZ/19PDY2sDKbARyNfZY2VpKDWeCV/WwtcWQR53sB4oe19ynDBt5/hAa6dT
         nk6TKKcZ3a0l2HfIyfRK6vc1pK2fV50/mXknuwnp+6zUzikPFFY0a0rweQBeJrLjmx1m
         68LQ==
X-Gm-Message-State: ACrzQf28FUnKoyNHUGv9PLvMgZNA36NdD6qCy6O92L8hXurByv8+JA8w
        IoV7SKJDxnAr1Ps4BSPo1GNnaQYsJWMKIZ8hddIgcOO6buE=
X-Google-Smtp-Source: AMsMyM4WCGu5ESyqLr4NNnYTM8Y/cesPGamT9fxgN1mP/0G9ezbkIpOzzvtgViQD671jU/F1ve4zQxrqVF2F9PUUCxs=
X-Received: by 2002:a17:907:2c74:b0:78d:b3ae:8408 with SMTP id
 ib20-20020a1709072c7400b0078db3ae8408mr5005454ejc.172.1665406437543; Mon, 10
 Oct 2022 05:53:57 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 10 Oct 2022 20:53:23 +0800
Message-ID: <CAO4mrfcuh5MrdXcAtAh_i=nGgXzDHUq-0hRrYVq8pwP7UP9FyQ@mail.gmail.com>
Subject: INFO: task hung in floppy_revalidate
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     efremov@linux.com, linux-kernel@vger.kernel.org
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

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1RCnUEZWaVSMoTGbCMwoT5opyJYzOyz1Q/view?usp=sharing
kernel config: https://drive.google.com/file/d/1lNwvovjLNrcuyFGrg05IoSmgO5jaKBBJ/view?usp=sharing

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

INFO: task syz-executor:8550 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc5+ #14
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23192 pid: 8550 ppid:  6613 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xc1a/0x11e0 kernel/sched/core.c:6287
 schedule+0x14b/0x210 kernel/sched/core.c:6366
 schedule_timeout+0x98/0x310 kernel/time/timer.c:1857
 do_wait_for_common+0x2da/0x480 kernel/sched/completion.c:85
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x48/0x60 kernel/sched/completion.c:138
 __floppy_read_block_0 drivers/block/floppy.c:4144 [inline]
 floppy_revalidate+0xd2e/0x1280 drivers/block/floppy.c:4188
 floppy_open+0x70b/0x1220 drivers/block/floppy.c:4038
 blkdev_get_whole+0x9a/0x430 block/bdev.c:668
 blkdev_get_by_dev+0x296/0xcb0 block/bdev.c:823
 blkdev_open+0x133/0x2d0 block/fops.c:448
 do_dentry_open+0x839/0x1080 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x28b0/0x3870 fs/namei.c:3561
 do_filp_open+0x258/0x4d0 fs/namei.c:3588
 do_sys_openat2+0x133/0x520 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x249/0x290 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f37347325b4
RSP: 002b:00007f3731cf3780 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f37347325b4
RDX: 0000000000006400 RSI: 00007f3731cf3820 RDI: 00000000ffffff9c
RBP: 00007f3731cf3820 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000006400
R13: 00007ffffcce873f R14: 00007ffffcce88e0 R15: 00007f3731cf3dc0
INFO: task syz-executor:8551 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc5+ #14
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:26576 pid: 8551 ppid:  6613 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xc1a/0x11e0 kernel/sched/core.c:6287
 schedule+0x14b/0x210 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common+0xcff/0x2630 kernel/locking/mutex.c:669
 __mutex_lock kernel/locking/mutex.c:729 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:743
 blkdev_get_by_dev+0x107/0xcb0 block/bdev.c:816
 blkdev_open+0x133/0x2d0 block/fops.c:448
 do_dentry_open+0x839/0x1080 fs/open.c:822
 do_open fs/namei.c:3428 [inline]
 path_openat+0x28b0/0x3870 fs/namei.c:3561
 do_filp_open+0x258/0x4d0 fs/namei.c:3588
 do_sys_openat2+0x133/0x520 fs/open.c:1200
 do_sys_open fs/open.c:1216 [inline]
 __do_sys_openat fs/open.c:1232 [inline]
 __se_sys_openat fs/open.c:1227 [inline]
 __x64_sys_openat+0x249/0x290 fs/open.c:1227
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f37347325b4
RSP: 002b:00007f3731cd2780 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007f37347325b4
RDX: 0000000000006400 RSI: 00007f3731cd2820 RDI: 00000000ffffff9c
RBP: 00007f3731cd2820 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000006400
R13: 00007ffffcce873f R14: 00007ffffcce88e0 R15: 00007f3731cd2dc0

Showing all locks held in the system:
1 lock held by khungtaskd/21:
 #0: ffffffff8cf1c040 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
1 lock held by in:imklog/6512:
 #0: ffff88801de005f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x26c/0x310 fs/file.c:990
3 locks held by syz-executor/8550:
 #0: ffff888019e12918 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x107/0xcb0 block/bdev.c:816
 #1: ffffffff8d69b1a8 (floppy_mutex){+.+.}-{3:3}, at:
floppy_open+0x7f/0x1220 drivers/block/floppy.c:3974
 #2: ffffffff8d69b268 (open_lock){+.+.}-{3:3}, at:
floppy_open+0x8d/0x1220 drivers/block/floppy.c:3975
1 lock held by syz-executor/8551:
 #0: ffff888019e12918 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x107/0xcb0 block/bdev.c:816
1 lock held by syz-executor/8812:
 #0: ffff888019e12918 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x107/0xcb0 block/bdev.c:816
1 lock held by syz-executor/8813:
 #0: ffff888019e12918 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x107/0xcb0 block/bdev.c:816
2 locks held by kworker/u2:8/9312:
1 lock held by syz-executor/9536:
 #0: ffff888019e12918 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x107/0xcb0 block/bdev.c:816
1 lock held by syz-executor/9537:
 #0: ffff888019e12918 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x107/0xcb0 block/bdev.c:816

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 21 Comm: khungtaskd Not tainted 5.15.0-rc5+ #14
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1d8/0x2c4 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x452/0x480 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1a3/0x330 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xdbe/0xe30 kernel/hung_task.c:295
 kthread+0x419/0x510 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

Best,
Wei
