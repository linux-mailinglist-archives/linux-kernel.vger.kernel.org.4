Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF51663F0C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiLAMnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLAMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:43:45 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8267BFAF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:43:43 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id i1-20020a056e021d0100b00303357fe402so1758017ila.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 04:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ti/q+iV51EFf1gizIZNIIwSFkpgiTRgXSWkOjPToyPM=;
        b=lTtL6pnqWU0HAR2qjzYR3k0leOdVjQnTX8gS4kQb5PAhQOUzrABAMTID8gJICMNOd4
         CQrw4STWtY8WutenywHJ2l3pVoN2Qijqei1KkzUIOCNKwIJc8ZRWg+zaDQFzph3k2djz
         5TzsyFyHDmX9f2zilwz9o9Y8cU+1jx5Ll6+aFfEbjZgeHeGUkCCnRqSkE+BUDLyMsift
         0m+Asicd0x1lA+LvzArt6DtiVFokeu3Ft9oVAY4n2x9X3qq5BAMkZYfbxe8lgVQiSCgf
         FW1uJcKF3fNxYGtIqBaRRO3tYCSS4q0DutEFMCpe+9o1SyxtxdzbtnmIkH524WtSjQj5
         95QQ==
X-Gm-Message-State: ANoB5pljObfGLLXSLYz7pnvlwG6k9w2k0YQNdbAo2FHzfPUQluR2gSsg
        H1ybEtEWSOCjOgh9n6qCBUqvCliV779LBA8rGiJEUPmeW4w8
X-Google-Smtp-Source: AA0mqf4KwfM8tJtygWaAtwlIzuW1bkJC3Bj40roejOm5IE8D61ojfcwVtsOkrnb06LFSg9mmmep6+wNQLPYrRyCCl5PvwmEPzTg4
MIME-Version: 1.0
X-Received: by 2002:a05:6638:11d4:b0:389:ce3c:4ca5 with SMTP id
 g20-20020a05663811d400b00389ce3c4ca5mr12657778jas.308.1669898622957; Thu, 01
 Dec 2022 04:43:42 -0800 (PST)
Date:   Thu, 01 Dec 2022 04:43:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b7fee05eec392a8@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in take_dentry_name_snapshot
From:   syzbot <syzbot+90392eaed540afcc8fc3@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    b7b275e60bcd Linux 6.1-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102c68d5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=90392eaed540afcc8fc3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90392eaed540afcc8fc3@syzkaller.appspotmail.com

REISERFS (device loop1): Created .reiserfs_priv - reserved for xattr storage.
overlayfs: upper fs needs to support d_type.
overlayfs: upper fs does not support tmpfile.
BUG: unable to handle page fault for address: fffffffffff8161d
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD c28f067 P4D c28f067 PUD c291067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5330 Comm: syz-executor.1 Not tainted 6.1.0-rc7-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:__lock_acquire+0xd8d/0x56d0 kernel/locking/lockdep.c:4925
Code: c8 00 00 00 89 05 73 07 19 0f e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 4e 31 00 00 <49> 81 3e 60 b5 d2 8f 0f 84 4c f3 ff ff 41 83 fc 01 0f 87 54 f3 ff
RSP: 0018:ffffc9002212f7c8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 1ffff92004425f29 RCX: 0000000000000000
RDX: 1fffffffffff02c3 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1ca3442 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801c779d40 R14: fffffffffff8161d R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c700000(0063) knlGS:00000000f7f15b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: fffffffffff8161d CR3: 000000001b613000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 take_dentry_name_snapshot+0x2b/0x170 fs/dcache.c:315
 ovl_check_rename_whiteout fs/overlayfs/super.c:1297 [inline]
 ovl_make_workdir fs/overlayfs/super.c:1419 [inline]
 ovl_get_workdir fs/overlayfs/super.c:1534 [inline]
 ovl_fill_super+0x1ddd/0x6400 fs/overlayfs/super.c:2090
 mount_nodev+0x64/0x120 fs/super.c:1447
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1531
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __ia32_sys_mount+0x282/0x300 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f1a549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f155cc EFLAGS: 00000296 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000200000c0
RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000020000480
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: fffffffffff8161d
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xd8d/0x56d0 kernel/locking/lockdep.c:4925
Code: c8 00 00 00 89 05 73 07 19 0f e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 4e 31 00 00 <49> 81 3e 60 b5 d2 8f 0f 84 4c f3 ff ff 41 83 fc 01 0f 87 54 f3 ff
RSP: 0018:ffffc9002212f7c8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 1ffff92004425f29 RCX: 0000000000000000
RDX: 1fffffffffff02c3 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1ca3442 R11: 0000000000000000 R12: 0000000000000000
R13: ffff88801c779d40 R14: fffffffffff8161d R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88802c700000(0063) knlGS:00000000f7f15b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: fffffffffff8161d CR3: 000000001b613000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	c8 00 00 00          	enterq $0x0,$0x0
   4:	89 05 73 07 19 0f    	mov    %eax,0xf190773(%rip)        # 0xf19077d
   a:	e9 bd 00 00 00       	jmpq   0xcc
   f:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  16:	fc ff df
  19:	4c 89 f2             	mov    %r14,%rdx
  1c:	48 c1 ea 03          	shr    $0x3,%rdx
  20:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  24:	0f 85 4e 31 00 00    	jne    0x3178
* 2a:	49 81 3e 60 b5 d2 8f 	cmpq   $0xffffffff8fd2b560,(%r14) <-- trapping instruction
  31:	0f 84 4c f3 ff ff    	je     0xfffff383
  37:	41 83 fc 01          	cmp    $0x1,%r12d
  3b:	0f                   	.byte 0xf
  3c:	87 54 f3 ff          	xchg   %edx,-0x1(%rbx,%rsi,8)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
