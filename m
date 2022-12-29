Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0933659184
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbiL2U0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiL2U0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:26:44 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABBB14005
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:26:42 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l3-20020a056e021aa300b00304be32e9e5so12374048ilv.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BrdfuQKC3IEHrqVlF9HvlqBuZgfNcN5SbSHn+PTkhas=;
        b=JKAsqfO+JgTfacgMyVWDWBX7abHeAnL4YAOL2zUj2u7MKk7PCq5pbHSP8vTyYeoSYy
         yhY9o9okLqP+3pKAafAUy/dNskX9d6FNaGtmIdqmub0U42ddw0v4FbhX6HMwQi0Sg6dR
         kiT4ZNju5p1sHWXeid/OmTuLIh0CFPclKxeXciplvsUhwWAFvgFN0WIFclBK3Zu6PiN4
         urD9xyvcRND9ZXKMDlh8R99EgAS04GETsZd5X9Nm9kIMTsrankTGclXfXLKwKzg7DEmK
         9eWRwZYPkQE2De45bwrBY9rhM51+tMWY1Q0wQe0PPkHw6v7dWVQBBa1JlrcyZbvqU152
         /S/Q==
X-Gm-Message-State: AFqh2kqmccvH0dOnMsxGqRZJ8iTJVWXcwEfjXD5r/cJrhrjL6q8u4gzo
        YKF3lCbXO4vyUw1NiEpSI9TJJCIwmZ2s8HtCmRz+tX+bGpyw
X-Google-Smtp-Source: AMrXdXuQO6X+Z50fbOWHu6NIUUPGmDFkhuNX4WO0ifd2egH3JgKISMaidNA8CUU216NjH5oyargepXbQ/YXCDaVhxP8xngUJrPpe
MIME-Version: 1.0
X-Received: by 2002:a02:c6d3:0:b0:38a:3dbb:1f90 with SMTP id
 r19-20020a02c6d3000000b0038a3dbb1f90mr2778727jan.94.1672345601914; Thu, 29
 Dec 2022 12:26:41 -0800 (PST)
Date:   Thu, 29 Dec 2022 12:26:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b3c4305f0fd4dbe@google.com>
Subject: [syzbot] [xfs?] WARNING in call_rcu (2)
From:   syzbot <syzbot+49cacf14fd027a089740@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=135634a8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=49cacf14fd027a089740
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145749a8480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bb4118480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ffd09d8cecad/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+49cacf14fd027a089740@syzkaller.appspotmail.com

XFS (loop0): Please unmount the filesystem and rectify the problem(s).
------------[ cut here ]------------
ODEBUG: activate active (active state 1) object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 50 at lib/debugobjects.c:505 debug_print_object lib/debugobjects.c:502 [inline]
WARNING: CPU: 0 PID: 50 at lib/debugobjects.c:505 debug_object_activate+0x2c0/0x300 lib/debugobjects.c:674
Modules linked in:
CPU: 0 PID: 50 Comm: kworker/0:1H Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: xfs-log/loop0 xlog_ioend_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:502 [inline]
pc : debug_object_activate+0x2c0/0x300 lib/debugobjects.c:674
lr : debug_print_object lib/debugobjects.c:502 [inline]
lr : debug_object_activate+0x2c0/0x300 lib/debugobjects.c:674
sp : ffff80000f723880
x29: ffff80000f723880 x28: 0000000000000001 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000c6ad9a50
x23: ffff80000c0cec40 x22: ffff0000c79fcc30 x21: ffff80000f143000
x20: ffff80000c0cec40 x19: ffff0000cab5a638 x18: 00000000000000c0
x17: 6820646165685f75 x16: ffff80000dbe6158 x15: ffff0000c106cec0
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c106cec0
x11: ff808000081c4d64 x10: 0000000000000000 x9 : 41d50f7522bc1100
x8 : 41d50f7522bc1100 x7 : ffff80000c091ebc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000048
Call trace:
 debug_print_object lib/debugobjects.c:502 [inline]
 debug_object_activate+0x2c0/0x300 lib/debugobjects.c:674
 debug_rcu_head_queue kernel/rcu/rcu.h:189 [inline]
 call_rcu+0x40/0x494 kernel/rcu/tree.c:2783
 xfs_buf_rele+0x654/0x780
 xfs_buf_relse fs/xfs/xfs_buf.h:286 [inline]
 xfs_buf_ioend+0x214/0x228 fs/xfs/xfs_buf.c:1339
 xfs_buf_ioend_fail+0x58/0x68 fs/xfs/xfs_buf.c:1397
 xfs_buf_item_unpin+0x18c/0x280 fs/xfs/xfs_buf_item.c:549
 xfs_trans_committed_bulk+0x190/0x460 fs/xfs/xfs_trans.c:806
 xlog_cil_committed+0xcc/0x340 fs/xfs/xfs_log_cil.c:795
 xlog_cil_process_committed+0x6c/0xa8 fs/xfs/xfs_log_cil.c:823
 xlog_state_shutdown_callbacks+0xac/0x140 fs/xfs/xfs_log.c:538
 xlog_force_shutdown+0x1ac/0x230 fs/xfs/xfs_log.c:3821
 xlog_ioend_work+0x68/0xa0 fs/xfs/xfs_log.c:1402
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
irq event stamp: 558
hardirqs last  enabled at (557): [<ffff8000081c3048>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:261
hardirqs last disabled at (558): [<ffff80000c084084>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (528): [<ffff800008e528b8>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (526): [<ffff800008e52884>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 50 at lib/debugobjects.c:505 debug_print_object lib/debugobjects.c:502 [inline]
WARNING: CPU: 0 PID: 50 at lib/debugobjects.c:505 debug_object_active_state+0x1b0/0x1dc lib/debugobjects.c:950
Modules linked in:
CPU: 0 PID: 50 Comm: kworker/0:1H Tainted: G        W          6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: xfs-log/loop0 xlog_ioend_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:502 [inline]
pc : debug_object_active_state+0x1b0/0x1dc lib/debugobjects.c:950
lr : debug_print_object lib/debugobjects.c:502 [inline]
lr : debug_object_active_state+0x1b0/0x1dc lib/debugobjects.c:950
sp : ffff80000f723880
x29: ffff80000f723880 x28: 0000000000000001 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000c79fcc30
x23: 0000000000000000 x22: 0000000000000001 x21: ffff80000f10e018
x20: ffff80000c0cec40 x19: ffff80000f143000 x18: 00000000000000c0
x17: 65685f756372203a x16: ffff80000dbe6158 x15: ffff0000c106cec0
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c106cec0
x11: ff808000081c4d64 x10: 0000000000000000 x9 : 41d50f7522bc1100
x8 : 41d50f7522bc1100 x7 : ffff80000c091ebc x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 000000000000004c
Call trace:
 debug_print_object lib/debugobjects.c:502 [inline]
 debug_object_active_state+0x1b0/0x1dc lib/debugobjects.c:950
 debug_rcu_head_queue kernel/rcu/rcu.h:190 [inline]
 call_rcu+0x58/0x494 kernel/rcu/tree.c:2783
 xfs_buf_rele+0x654/0x780
 xfs_buf_relse fs/xfs/xfs_buf.h:286 [inline]
 xfs_buf_ioend+0x214/0x228 fs/xfs/xfs_buf.c:1339
 xfs_buf_ioend_fail+0x58/0x68 fs/xfs/xfs_buf.c:1397
 xfs_buf_item_unpin+0x18c/0x280 fs/xfs/xfs_buf_item.c:549
 xfs_trans_committed_bulk+0x190/0x460 fs/xfs/xfs_trans.c:806
 xlog_cil_committed+0xcc/0x340 fs/xfs/xfs_log_cil.c:795
 xlog_cil_process_committed+0x6c/0xa8 fs/xfs/xfs_log_cil.c:823
 xlog_state_shutdown_callbacks+0xac/0x140 fs/xfs/xfs_log.c:538
 xlog_force_shutdown+0x1ac/0x230 fs/xfs/xfs_log.c:3821
 xlog_ioend_work+0x68/0xa0 fs/xfs/xfs_log.c:1402
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
irq event stamp: 686
hardirqs last  enabled at (685): [<ffff8000081c3048>] __up_console_sem+0xb0/0xfc kernel/printk/printk.c:261
hardirqs last disabled at (686): [<ffff80000c084084>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (658): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (561): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
rcu: call_rcu(): Double-freed CB 00000000d44ae33c->0x0()!!!   slab xfs_buf start ffff0000cab5a3c0 pointer offset 632


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
