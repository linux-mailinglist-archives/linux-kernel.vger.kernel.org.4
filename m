Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7716537E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiLUUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiLUUyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:54:47 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01601218AF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:54:46 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h9-20020a92c269000000b00303494c4f3eso1167ild.15
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSld9w5b0c5431C0gCV8qTOX+c8jsvfzKbAp62hQ8Fg=;
        b=Jbev21cf5hPlgeHv9nIsXrRKjB/UU0kpZKypkDyHvvTFEkPBRxinA33hurCQM19PXj
         DNgMdCDVwqBCp32ZPEEyZKPGmGUIMz2KzJV1TXL8PXKMTDGZQpvChlq09N2qUX6RuUtI
         zcoOTpo7uPSlVgPrElIya+w1+zBnA2qTWDuVPWJmRq6e902v6ATip+KKgGVWYcmJq9NH
         YuN1zN0zo/nuHhgR6Kyz9pqOale17ZLd3x3uKJV9sFcz7URD8ZoN/JJcFj4tiKxhoLC9
         75HmaJFWmzSk7grJ2YkJvu+eKx0q03xWUQFQcXxRak+KWWzIo24Olq6JrBJoiU0FqeKm
         8ERQ==
X-Gm-Message-State: AFqh2kq5JkcHF4nt0PYxThpaIMEm+Qjmx4PocLsCLTUULhb8AAPaoWSA
        v1HT+uEzwIavMHgRVapemXn5RqspVOcMWrSl+qEvDU6UnPKi
X-Google-Smtp-Source: AMrXdXuL+24luRUyHNexCg4o+QwHOBlu6ukTdpFscESJScttijITt95GXMl+4BD/sska23LG+fo/yuJO9BggiQAHirIFJYJP4F+G
MIME-Version: 1.0
X-Received: by 2002:a02:cc65:0:b0:398:d917:5c51 with SMTP id
 j5-20020a02cc65000000b00398d9175c51mr200801jaq.42.1671656085361; Wed, 21 Dec
 2022 12:54:45 -0800 (PST)
Date:   Wed, 21 Dec 2022 12:54:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000279ebd05f05cc339@google.com>
Subject: [syzbot] INFO: trying to register non-static key in __timer_delete_sync
From:   syzbot <syzbot+1e164be619b690a43d79@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    ca39c4daa6f7 Add linux-next specific files for 20221216
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1182429d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f0bce83c86de334
dashboard link: https://syzkaller.appspot.com/bug?extid=1e164be619b690a43d79
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3cbf8a8f223d/disk-ca39c4da.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f104cf6ddf80/vmlinux-ca39c4da.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ba8b49536b5/bzImage-ca39c4da.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e164be619b690a43d79@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 20857 Comm: syz-executor.5 Not tainted 6.1.0-next-20221216-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:981 [inline]
 register_lock_class+0xf1b/0x1120 kernel/locking/lockdep.c:1294
 __lock_acquire+0x109/0x56d0 kernel/locking/lockdep.c:4934
 lock_acquire.part.0+0x11a/0x350 kernel/locking/lockdep.c:5668
 __timer_delete_sync+0x5d/0x1c0 kernel/time/timer.c:1555
 del_timer_sync include/linux/timer.h:200 [inline]
 cleanup_srcu_struct kernel/rcu/srcutree.c:611 [inline]
 cleanup_srcu_struct+0x112/0x3e0 kernel/rcu/srcutree.c:599
 kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1325 [inline]
 kvm_put_kvm+0x884/0xb80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1352
 kvm_vm_release+0x43/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1375
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1a7ae3df8b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007fff9d5d14e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f1a7ae3df8b
RDX: 0000000000000000 RSI: 0000001b32320ef8 RDI: 0000000000000004
RBP: 00007f1a7afad980 R08: 0000000000000000 R09: 000000008acd30fc
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000011376f
R13: 00007fff9d5d15e0 R14: 00007f1a7afac050 R15: 0000000000000032
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 1 PID: 20857 at kernel/workqueue.c:3066 __flush_work+0x90a/0xaf0 kernel/workqueue.c:3066
Modules linked in:
CPU: 1 PID: 20857 Comm: syz-executor.5 Not tainted 6.1.0-next-20221216-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__flush_work+0x90a/0xaf0 kernel/workqueue.c:3066
Code: 00 48 c7 c6 2f 7b 52 81 48 c7 c7 c0 28 79 8c e8 1c 7c 11 00 e9 ab fc ff ff e8 12 d7 2e 00 0f 0b e9 9f fc ff ff e8 06 d7 2e 00 <0f> 0b 45 31 ed e9 90 fc ff ff e8 77 e6 7c 00 e9 7a fb ff ff e8 ed
RSP: 0018:ffffc900038afb60 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffe8ffffcd0620 RCX: 0000000000000000
RDX: ffff888020d38000 RSI: ffffffff81527b6a RDI: 0000000000000001
RBP: ffffc900038afcf8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 3e4b5341542f3c20 R12: ffffc9000393b478
R13: 0000000000000001 R14: fffffbfff1ce6138 R15: ffffe8ffffcd0638
FS:  0000555555edb400(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200e9000 CR3: 00000000297ac000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cleanup_srcu_struct kernel/rcu/srcutree.c:612 [inline]
 cleanup_srcu_struct+0x11e/0x3e0 kernel/rcu/srcutree.c:599
 kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1325 [inline]
 kvm_put_kvm+0x884/0xb80 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1352
 kvm_vm_release+0x43/0x50 arch/x86/kvm/../../../virt/kvm/kvm_main.c:1375
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1a7ae3df8b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007fff9d5d14e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00007f1a7ae3df8b
RDX: 0000000000000000 RSI: 0000001b32320ef8 RDI: 0000000000000004
RBP: 00007f1a7afad980 R08: 0000000000000000 R09: 000000008acd30fc
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000011376f
R13: 00007fff9d5d15e0 R14: 00007f1a7afac050 R15: 0000000000000032
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
