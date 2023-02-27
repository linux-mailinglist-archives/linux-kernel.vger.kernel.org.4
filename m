Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1A46A3ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 06:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjB0FpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 00:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0FpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 00:45:13 -0500
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2414EBD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 21:45:12 -0800 (PST)
Received: by mail-io1-f80.google.com with SMTP id n42-20020a056602342a00b0074cde755b99so2066634ioz.16
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 21:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifLhFcZLmDqpOzacwCmsURnFTRFQLUIKYvDa3MsIkug=;
        b=lDW/iWYzQeJ6oUKtMNV96gwHzTyU0joO45OelTJvc/36TRXh7ZRGCkrbYT+9kzEfdr
         5pqPljhPdWtjYuXSoHP8XVWl4NvVUT59w+bU9SSfZde74RmbtYhzfsfaz9J8COhiTzRj
         apVPfDlxSw6N2ty7FS6j2ATVWgm0BCm3ZA/LDlOqnTn1fahYP+QKghdNda/l87xs2Vy2
         XZVqFX1/a9ir+1RyenJ64Yyu6FnKR00KL+Ospx34L+bDGtydt6MlX8mOMEowSo2BXQLN
         PPejJl4QWXNMK0Ae+TZlcTZe2qIWpHla4kTijOEWENMgg+YvBJWypd5Tapl2fLN999YI
         G+6Q==
X-Gm-Message-State: AO0yUKV1Fd6a7vz4UEZs0PBRV10rxTHsjTJUMZznQD4YTP4ha0IlvmGT
        JqrE7Bqi2WiwyN3TPx+kvW6+DeKysVnDsqDx5bzVFyIZd2JKeEXTTA==
X-Google-Smtp-Source: AK7set+FfkKRCGWwYIVQZ812OVZxPJxE2ybHxDWrHoJ3v4TiUnzgTuQq0ig2OIKfxLTPEzMzjdgGWLjeiNASDfQMF0RpDZ4Px00D
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1212:b0:310:fd22:8809 with SMTP id
 a18-20020a056e02121200b00310fd228809mr7452586ilq.1.1677476711630; Sun, 26 Feb
 2023 21:45:11 -0800 (PST)
Date:   Sun, 26 Feb 2023 21:45:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000840dae05f5a7fb53@google.com>
Subject: [syzbot] [kernel?] inconsistent lock state in valid_state
From:   syzbot <syzbot+3d15e7679037c3d35479@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    307e14c03906 Merge tag '6.3-rc-smb3-client-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155343f0c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=636897a0dac3d81e
dashboard link: https://syzkaller.appspot.com/bug?extid=3d15e7679037c3d35479
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/970f2d144bf1/disk-307e14c0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1ba101847b5b/vmlinux-307e14c0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21e98f0fe45e/bzImage-307e14c0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d15e7679037c3d35479@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.2.0-syzkaller-06742-g307e14c03906 #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor.1/27002 [HC0[0]:SC0[0]:HE1:SE1] takes:
ffffffff81fa11b1 (&obj_hash[i].lock){?.-.}-{2:2}, at: 0xee13a8ffb5cd3747
{IN-HARDIRQ-W} state was registered at:
  lock_acquire+0x23e/0x630 kernel/locking/lockdep.c:5669
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
  debug_object_assert_init+0x6e/0x240 lib/debugobjects.c:881
  debug_timer_assert_init kernel/time/timer.c:792 [inline]
  debug_assert_init kernel/time/timer.c:837 [inline]
  add_timer_on+0xbd/0x5a0 kernel/time/timer.c:1262
  handle_irq_event_percpu kernel/irq/handle.c:195 [inline]
  handle_irq_event+0xad/0x1f0 kernel/irq/handle.c:210
  handle_level_irq+0x3af/0x6d0 kernel/irq/chip.c:650
  generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
  handle_irq arch/x86/kernel/irq.c:231 [inline]
  __common_interrupt+0xdb/0x1f0 arch/x86/kernel/irq.c:250
  common_interrupt+0xa3/0xc0 arch/x86/kernel/irq.c:240
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:640
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
  _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
  __setup_irq+0x12fa/0x1d90 kernel/irq/manage.c:1812
  request_threaded_irq+0x2ab/0x380 kernel/irq/manage.c:2201
  request_irq include/linux/interrupt.h:168 [inline]
  setup_default_timer_irq+0x1f/0x30 arch/x86/kernel/time.c:70
  x86_late_time_init+0x55/0xa0 arch/x86/kernel/time.c:94
  start_kernel+0x3f8/0x530 init/main.c:1112
  secondary_startup_64_no_verify+0xcf/0xdb
irq event stamp: 12225
hardirqs last  enabled at (12225): [<ffffffff8161ddd3>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1378 [inline]
hardirqs last  enabled at (12225): [<ffffffff8161ddd3>] finish_lock_switch+0x93/0x110 kernel/sched/core.c:5062
hardirqs last disabled at (12224): [<ffffffff8ab9b69e>] __schedule+0x32e/0x4990 kernel/sched/core.c:6521
softirqs last  enabled at (10910): [<ffffffff8154fe59>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last  enabled at (10910): [<ffffffff8154fe59>] __irq_exit_rcu+0x159/0x240 kernel/softirq.c:650
softirqs last disabled at (10813): [<ffffffff8154fe59>] invoke_softirq kernel/softirq.c:445 [inline]
softirqs last disabled at (10813): [<ffffffff8154fe59>] __irq_exit_rcu+0x159/0x240 kernel/softirq.c:650

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&obj_hash[i].lock);
  <Interrupt>
    lock(&obj_hash[i].lock);

 *** DEADLOCK ***

1 lock held by syz-executor.1/27002:
 #0: ffff8880765fc0e0 (&type->s_umount_key#61/1){+.+.}-{3:3}, at: alloc_super+0x217/0x930 fs/super.c:228

stack backtrace:
CPU: 0 PID: 27002 Comm: syz-executor.1 Not tainted 6.2.0-syzkaller-06742-g307e14c03906 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 valid_state+0x136/0x1c0 kernel/locking/lockdep.c:3976
 mark_lock_irq+0xac/0xbb0 kernel/locking/lockdep.c:4179
 mark_lock+0x21c/0x340 kernel/locking/lockdep.c:4635
 mark_usage kernel/locking/lockdep.c:4544 [inline]
 __lock_acquire+0xc0d/0x1f80 kernel/locking/lockdep.c:5010
 lock_acquire+0x23e/0x630 kernel/locking/lockdep.c:5669
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 inode_sb_list_del fs/inode.c:503 [inline]
 evict+0x161/0x620 fs/inode.c:654
 ntfs_fill_super+0x3ffc/0x47f0 fs/ntfs3/super.c:1239
 get_tree_bdev+0x402/0x620 fs/super.c:1294
 vfs_get_tree+0x8c/0x270 fs/super.c:1501
 do_new_mount+0x28f/0xae0 fs/namespace.c:3031
 do_mount fs/namespace.c:3374 [inline]
 __do_sys_mount fs/namespace.c:3583 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3560
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9a3188d62a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9a325d3f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000001f7f7 RCX: 00007f9a3188d62a
RDX: 000000002001f800 RSI: 000000002001f840 RDI: 00007f9a325d3fe0
RBP: 00007f9a325d4020 R08: 00007f9a325d4020 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000000002001f800
R13: 000000002001f840 R14: 00007f9a325d3fe0 R15: 000000002001f880
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
