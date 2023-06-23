Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA88C73AF27
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 05:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjFWDsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 23:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFWDsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 23:48:06 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8422D1BFA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:48:05 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-341c6c4ef93so1264115ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 20:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687492085; x=1690084085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbdNZt3xIRJYG6sPiuNXwIBjdIsRtrJ+dzPbbqQv6lU=;
        b=DcTFJesTJEvBCyAwLaqXYYo5V6/Tszy2F0Xe/tBXsYAjk321Nt01LkKBDC0g6pPLap
         mkTlvtIexUenDbJxiXPCoZ7JEvg2WtG4EeAn+37BoPx7GtRookZVb53KH8P6CkHySpqo
         aw2DmLzgwcDu+Hp63NHQaaFQIFB4NGfugjv8hZyM53JWo7OMgEZwiFzXh0NY4I7ANdyt
         0ELreZqyehGuCtYYGx7wwiKcOdUA0xIrZhzyc+dnzKUWLxXavveIPpzidU+3Yvnww4Sj
         CP0L4MtEMVGXqoWIMad9xmrL6kTE5V+DeAmc/XkAu72jgjOaZQWsqSuMtrLKesJWkrqh
         Bf1A==
X-Gm-Message-State: AC+VfDzOIjRxctgejREAbuc0idfZrudOEtmylIVB2+gGzwZU4DxKLGx2
        M/7U5o9KVbKJymifKUpPa/pZYLRgmHt6mK2hSDUucAfjtPWd
X-Google-Smtp-Source: ACHHUZ4i1lHMO6zq4zbzt6R0xW+AvrVhtkjez2BeUF459GacWyfe4LpICijeM+nUbMOagMBetUpNVRTGlUI656mLL2iqavmGcJ5o
MIME-Version: 1.0
X-Received: by 2002:a92:d9c5:0:b0:341:e653:bdba with SMTP id
 n5-20020a92d9c5000000b00341e653bdbamr7772971ilq.2.1687492084820; Thu, 22 Jun
 2023 20:48:04 -0700 (PDT)
Date:   Thu, 22 Jun 2023 20:48:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046efb605fec3def0@google.com>
Subject: [syzbot] [arm?] WARNING in delayed_work_timer_fn
From:   syzbot <syzbot+e13e654d315d4da1277c@syzkaller.appspotmail.com>
To:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    177239177378 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13d8a337280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8776b67768a3c9af
dashboard link: https://syzkaller.appspot.com/bug?extid=e13e654d315d4da1277c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c47a40dd633/disk-17723917.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ff319b6fb50/vmlinux-17723917.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ce1ea9e3b7e/Image-17723917.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e13e654d315d4da1277c@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 15561 at kernel/workqueue.c:1447 current_wq_worker kernel/workqueue_internal.h:68 [inline]
WARNING: CPU: 0 PID: 15561 at kernel/workqueue.c:1447 is_chained_work kernel/workqueue.c:1384 [inline]
WARNING: CPU: 0 PID: 15561 at kernel/workqueue.c:1447 __queue_work+0xe48/0x1374 kernel/workqueue.c:1446
Modules linked in:
CPU: 0 PID: 15561 Comm: syz-executor.2 Not tainted 6.4.0-rc5-syzkaller-g177239177378 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __queue_work+0xe48/0x1374 kernel/workqueue_internal.h:68
lr : current_wq_worker kernel/workqueue_internal.h:68 [inline]
lr : is_chained_work kernel/workqueue.c:1384 [inline]
lr : __queue_work+0xe48/0x1374 kernel/workqueue.c:1446
sp : ffff800080007b70
x29: ffff800080007bb0 x28: 1fffe000195506f1 x27: 0000000000000008
x26: ffff0000f6cfb800 x25: dfff800000000000 x24: ffff0000caa83788
x23: ffff0000f6cfb9c0 x22: ffff0000caa83780 x21: 0000000000000000
x20: 0000000000000100 x19: ffff000140bd8b30 x18: 1fffe00019bd827e
x17: ffff800126418000 x16: ffff80008a43bfbc x15: 0000000000010001
x14: 1ffff00011bd80ac x13: dfff800000000000 x12: 00000000beb1c7bb
x11: 0000000000000101 x10: 0000000000000100 x9 : 0000000000000000
x8 : ffff0000caa83780 x7 : ffff800080412e8c x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008c805480
x2 : ffff000140bd8b30 x1 : 0000000000000100 x0 : 0000000000000000
Call trace:
 current_wq_worker kernel/workqueue_internal.h:68 [inline]
 is_chained_work kernel/workqueue.c:1384 [inline]
 __queue_work+0xe48/0x1374 kernel/workqueue.c:1446
 delayed_work_timer_fn+0x74/0x90 kernel/workqueue.c:1652
 call_timer_fn+0x19c/0x8cc kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1746 [inline]
 __run_timers+0x5b4/0x734 kernel/time/timer.c:2022
 run_timer_softirq+0x7c/0x114 kernel/time/timer.c:2035
 __do_softirq+0x2d0/0xd54 kernel/softirq.c:571
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:882
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:85
 invoke_softirq kernel/softirq.c:452 [inline]
 __irq_exit_rcu+0x28c/0x534 kernel/softirq.c:650
 irq_exit_rcu+0x14/0x84 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:474 [inline]
 el1_interrupt+0x38/0x68 arch/arm64/kernel/entry-common.c:488
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:493
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:587
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:182 [inline]
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:202 [inline]
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:405 [inline]
 __wake_up_common_lock kernel/sched/wait.c:140 [inline]
 __wake_up_sync_key+0x124/0x1ac kernel/sched/wait.c:208
 __unix_dgram_recvmsg+0x4c4/0xe2c net/unix/af_unix.c:2479
 unix_dgram_recvmsg+0xd0/0xe8 net/unix/af_unix.c:2549
 sock_recvmsg_nosec+0x90/0xec net/socket.c:1019
 ____sys_recvmsg+0x5c0/0x6e8 net/socket.c:2720
 ___sys_recvmsg net/socket.c:2764 [inline]
 do_recvmmsg+0x41c/0xb60 net/socket.c:2858
 __sys_recvmmsg net/socket.c:2937 [inline]
 __do_sys_recvmmsg net/socket.c:2960 [inline]
 __se_sys_recvmmsg net/socket.c:2953 [inline]
 __arm64_sys_recvmmsg+0x180/0x23c net/socket.c:2953
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
irq event stamp: 295995
hardirqs last  enabled at (295994): [<ffff80008a521910>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (295994): [<ffff80008a521910>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (295995): [<ffff80008a5217b8>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (295995): [<ffff80008a5217b8>] _raw_spin_lock_irq+0x28/0x70 kernel/locking/spinlock.c:170
softirqs last  enabled at (293288): [<ffff8000800218ec>] softirq_handle_end kernel/softirq.c:414 [inline]
softirqs last  enabled at (293288): [<ffff8000800218ec>] __do_softirq+0xac0/0xd54 kernel/softirq.c:600
softirqs last disabled at (295981): [<ffff80008002b660>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---


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
