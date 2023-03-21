Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7706C33B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjCUOIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCUOIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:08:47 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B23043926
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:08:42 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id l7-20020a0566022dc700b0074cc9aba965so7712941iow.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407721;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RdZX7FP0N8TAavVjx3r+pAC5QECi0TeLGUufWkWlMc=;
        b=tnpVcgZEBkTStKg7n8xeUyjheQgkep14G6iKqDtF2xDoLPJ9jZWZFTQhArAo+vZmd+
         iS2+8X70AwGeDe/ALMd8n0g9StxNB+gPSLLdQ5WX1jPCYCMaqtm3flkH5DiA9VgPqNEA
         PklS/2j9d1Tf0z0KcCdVkTZbKt9VExLyDtEpzjiFnUxevVdZY9IncbBMCLo9JMIuNLqx
         bjHLe69rDYtc5cYpLR6/lmLW3HCtVUs614ClINddkb/2LtPbqfhqDYjFl+guE5JIOk4/
         FxBtGsYwfkPsLcKrT63euDDmGjvLWubmsAR26AsfJn3BIIraaIXVtZO9avzNJLt0MJTl
         8AvQ==
X-Gm-Message-State: AO0yUKWqbagSeZGZcpNmy7kPUthOhoKI2Pcu8GV21Ag7W+Ecxi2o15wz
        zDki2iBpQqq3E2tlFrsyxxj+tpXt80oAkPM/XQDquapqU1II
X-Google-Smtp-Source: AK7set8+X/Jj4+N5r67AeIFYNbu2xn1KVh6wpQ1q4pulx8tHDn53Yp4cge6XRT+aejIveslYrYmFMPJcRQmpXuFPtAb7gq/Xicwv
MIME-Version: 1.0
X-Received: by 2002:a92:2e12:0:b0:315:459d:e6dd with SMTP id
 v18-20020a922e12000000b00315459de6ddmr955547ile.3.1679407721540; Tue, 21 Mar
 2023 07:08:41 -0700 (PDT)
Date:   Tue, 21 Mar 2023 07:08:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad151605f769947e@google.com>
Subject: [syzbot] [jfs?] kernel BUG in jfs_flush_journal
From:   syzbot <syzbot+b678a3f04e9bdedb6cba@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    478a351ce0d6 Merge tag 'net-6.3-rc3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1231039ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9688428cfef5e8d5
dashboard link: https://syzkaller.appspot.com/bug?extid=b678a3f04e9bdedb6cba
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6ed6e770a183/disk-478a351c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/534bea112600/vmlinux-478a351c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67569395f0b5/bzImage-478a351c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b678a3f04e9bdedb6cba@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_logmgr.c:1588 assert(list_empty(&log->cqueue))
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_logmgr.c:1588!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5110 Comm: syz-executor.1 Not tainted 6.3.0-rc2-syzkaller-00363-g478a351ce0d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:jfs_flush_journal+0xeb7/0xec0 fs/jfs/jfs_logmgr.c:1588
Code: ff e8 dd 70 99 07 e8 b8 81 83 fe 48 c7 c7 40 20 21 8b 48 c7 c6 40 1b 21 8b ba 34 06 00 00 48 c7 c1 80 20 21 8b e8 79 51 97 07 <0f> 0b 0f 1f 80 00 00 00 00 f3 0f 1e fa 55 41 56 53 49 be 00 00 00
RSP: 0018:ffffc90004abfae0 EFLAGS: 00010246
RAX: 0000000000000040 RBX: ffff88805be811a8 RCX: a0f2929d95c89200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90004abfc20 R08: ffffffff816dfe9c R09: fffff52000957f15
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff92000957f68
R13: dffffc0000000000 R14: ffff88805be81000 R15: ffff88805be81000
FS:  0000555556a18400(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c002c99000 CR3: 0000000061716000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_umount+0x170/0x3a0 fs/jfs/jfs_umount.c:58
 jfs_put_super+0x8a/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x134/0x340 fs/super.c:491
 kill_block_super+0x7e/0xe0 fs/super.c:1398
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe2aba8d567
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffde8e74ca8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fe2aba8d567
RDX: 00007ffde8e74d7b RSI: 000000000000000a RDI: 00007ffde8e74d70
RBP: 00007ffde8e74d70 R08: 00000000ffffffff R09: 00007ffde8e74b40
R10: 0000555556a198b3 R11: 0000000000000246 R12: 00007fe2abae6b74
R13: 00007ffde8e75e30 R14: 0000555556a19810 R15: 00007ffde8e75e70
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jfs_flush_journal+0xeb7/0xec0 fs/jfs/jfs_logmgr.c:1588
Code: ff e8 dd 70 99 07 e8 b8 81 83 fe 48 c7 c7 40 20 21 8b 48 c7 c6 40 1b 21 8b ba 34 06 00 00 48 c7 c1 80 20 21 8b e8 79 51 97 07 <0f> 0b 0f 1f 80 00 00 00 00 f3 0f 1e fa 55 41 56 53 49 be 00 00 00
RSP: 0018:ffffc90004abfae0 EFLAGS: 00010246
RAX: 0000000000000040 RBX: ffff88805be811a8 RCX: a0f2929d95c89200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90004abfc20 R08: ffffffff816dfe9c R09: fffff52000957f15
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff92000957f68
R13: dffffc0000000000 R14: ffff88805be81000 R15: ffff88805be81000
FS:  0000555556a18400(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c002c99000 CR3: 0000000061716000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
