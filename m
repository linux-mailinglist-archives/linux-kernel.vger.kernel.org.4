Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABD766AB3B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 12:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjANLkj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 14 Jan 2023 06:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjANLkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 06:40:37 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04441769F
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 03:40:36 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id r6-20020a92cd86000000b00304b2d1c2d7so17901525ilb.11
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 03:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/VwMa/iyZSUhlMG7hXd6JNjISAKZynQ0HqBWFXryTw=;
        b=phO3V1DGe/9hg1X3DV3v9bv/uzQ5Y9bL6JVaX2hqSKFMigd6cHwkWKUHR04nTTpytj
         c7MvilNReLdF+F6ZLSfM8nGRHYxkmycDY279oWd2h8P57mtJDnG4X0+yJw6e1bl/P531
         TKRlQJLHqS2iUhGoYV+v/hTZwVFKEZIWzXAGlh1MOxX1qQBR5kGJO8v+fqj+xINSMk1f
         I8gIF+4x2kdRzh7XqyVajWim5wQfU5eIYRK2mvtQHcn9txLbSlLz8xEtiAy0ICfe4vRV
         FA/V9752A0MmzFQWoPooTNenTEtJPPowe4YHX89pYBHBx+PRdgmtCuluUIAvL4699dLn
         1dfQ==
X-Gm-Message-State: AFqh2kooBT8ZQUPO7+daytcr+jorY481F6IL3Fj92xRdRv6oX0Q1DWlK
        yejfkfKy9VY5O/x+wihKSMzPed+WfgPO3TGOiHwH/KgfvQCh
X-Google-Smtp-Source: AMrXdXsqCQGzg4cbs75CE/Yhqh4wx0vdkY5rZboIXcI1Q+ha0T9Rfm52b4EhqxcRbsp18UTez3lg9vOUd52lQaSEdPwdYLyZyYaN
MIME-Version: 1.0
X-Received: by 2002:a02:a795:0:b0:39e:9686:45bf with SMTP id
 e21-20020a02a795000000b0039e968645bfmr1458255jaj.44.1673696434939; Sat, 14
 Jan 2023 03:40:34 -0800 (PST)
Date:   Sat, 14 Jan 2023 03:40:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000776d0d05f237d1ad@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in ovl_copy_xattr
From:   syzbot <syzbot+d63643338a33351b6ade@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

HEAD commit:    97ec4d559d93 Merge tag 'block-6.2-2023-01-13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159bfc7e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ebc110f9741920ed
dashboard link: https://syzkaller.appspot.com/bug?extid=d63643338a33351b6ade
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/46f8c907cf5f/disk-97ec4d55.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df0994e6fa24/vmlinux-97ec4d55.xz
kernel image: https://storage.googleapis.com/syzbot-assets/59f096ab07dd/bzImage-97ec4d55.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d63643338a33351b6ade@syzkaller.appspotmail.com

REISERFS warning (device loop1): super-6502 reiserfs_getopt: unknown mount option "��<<�G4��mR����u����0��w�2���������"
BUG: unable to handle page fault for address: fffffffffff8d2a5
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD d08f067 P4D d08f067 PUD d091067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7774 Comm: syz-executor.1 Not tainted 6.2.0-rc3-syzkaller-00349-g97ec4d559d93 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:ovl_copy_xattr+0xdb/0xab0 fs/overlayfs/copy_up.c:85
Code: 90 fe e9 52 09 00 00 49 8d 5f 68 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 b5 df e5 fe <48> 8b 1b 48 83 c3 02 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc
RSP: 0018:ffffc90003567450 EFLAGS: 00010246
RAX: 1fffffffffff1a54 RBX: fffffffffff8d2a5 RCX: dffffc0000000000
RDX: ffff88802bc6d7c0 RSI: 0000000000000008 RDI: 0000000000000000
RBP: ffff888042f508d0 R08: ffffffff82fba5a9 R09: ffffed10085a80a0
R10: ffffed10085a80a0 R11: 1ffff110085a809f R12: ffff8880440ba000
R13: 0000000000000000 R14: 1ffff920006acec7 R15: fffffffffff8d23d
FS:  00007f47e45f2700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffff8d2a5 CR3: 0000000049bce000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ovl_copy_up_metadata+0x1c1/0xb80 fs/overlayfs/copy_up.c:616
 ovl_copy_up_workdir fs/overlayfs/copy_up.c:733 [inline]
 ovl_do_copy_up fs/overlayfs/copy_up.c:879 [inline]
 ovl_copy_up_one fs/overlayfs/copy_up.c:1045 [inline]
 ovl_copy_up_flags+0x166b/0x1f10 fs/overlayfs/copy_up.c:1091
 ovl_nlink_start+0x20c/0x580 fs/overlayfs/util.c:908
 ovl_do_remove+0x218/0x800 fs/overlayfs/dir.c:903
 vfs_unlink+0x357/0x5f0 fs/namei.c:4252
 do_unlinkat+0x46f/0x930 fs/namei.c:4320
 __do_sys_unlink fs/namei.c:4368 [inline]
 __se_sys_unlink fs/namei.c:4366 [inline]
 __x64_sys_unlink+0x45/0x50 fs/namei.c:4366
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f47e388c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f47e45f2168 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f47e39abf80 RCX: 00007f47e388c0c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f47e38e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd801926cf R14: 00007f47e45f2300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: fffffffffff8d2a5
---[ end trace 0000000000000000 ]---
RIP: 0010:ovl_copy_xattr+0xdb/0xab0 fs/overlayfs/copy_up.c:85
Code: 90 fe e9 52 09 00 00 49 8d 5f 68 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 b5 df e5 fe <48> 8b 1b 48 83 c3 02 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc
RSP: 0018:ffffc90003567450 EFLAGS: 00010246
RAX: 1fffffffffff1a54 RBX: fffffffffff8d2a5 RCX: dffffc0000000000
RDX: ffff88802bc6d7c0 RSI: 0000000000000008 RDI: 0000000000000000
RBP: ffff888042f508d0 R08: ffffffff82fba5a9 R09: ffffed10085a80a0
R10: ffffed10085a80a0 R11: 1ffff110085a809f R12: ffff8880440ba000
R13: 0000000000000000 R14: 1ffff920006acec7 R15: fffffffffff8d23d
FS:  00007f47e45f2700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffff8d2a5 CR3: 0000000049bce000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	e9 52 09 00 00       	jmpq   0x957
   5:	49 8d 5f 68          	lea    0x68(%r15),%rbx
   9:	48 89 d8             	mov    %rbx,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  17:	fc ff df
  1a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
  1e:	74 08                	je     0x28
  20:	48 89 df             	mov    %rbx,%rdi
  23:	e8 b5 df e5 fe       	callq  0xfee5dfdd
* 28:	48 8b 1b             	mov    (%rbx),%rbx <-- trapping instruction
  2b:	48 83 c3 02          	add    $0x2,%rbx
  2f:	48 89 d8             	mov    %rbx,%rax
  32:	48 c1 e8 03          	shr    $0x3,%rax
  36:	48                   	rex.W
  37:	b9 00 00 00 00       	mov    $0x0,%ecx
  3c:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
