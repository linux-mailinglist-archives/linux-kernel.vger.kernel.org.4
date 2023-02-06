Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C4768B7DD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjBFI6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBFI6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:58:51 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4131B327
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:58:50 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id z25-20020a6be019000000b00716eaf80c1dso6552122iog.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 00:58:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzoLADHANIqcF9FsafAB41ZC95Rig7FwqX55yF4UK6E=;
        b=jQNDPFm0OOSdkvVwv4R7dKn5YifrATci7o2F2SQuiEjLT2Kc1hr87pf6hk4hfORh9c
         lH7YtDbAivgvYnRextS0/w6sQqnP41w1z39C2C6uQxoUYZctiWgMtyywvutEM7mTggzk
         s3bSaqhahh4URtYtxOI63+rRBSIR0aPMv9aXBQV95CokKjP28j9eTVm1q61PR92nxqnD
         TLFQ0lQasLPkqblPlM+JuaCG+onJ4yoLnkJhcK2RYMlvzC4lPxBjDbCXlq1Bc2JlrEer
         VkMhT6HORN7PaXX1uibuTvR5yd3zHpPANml17/i+SI3gaSJeE+tORX/0HOgC7d+cMFIM
         Upyw==
X-Gm-Message-State: AO0yUKXOB8Bdmoxp+GH1ISX4Dw9vhDVcDLIg2MLo2R65LeWXD1HXTjTx
        ZTvaCjV0QesZLWXN7pmgIxv7vVdg9FqYouuXv9BDBjdnoixh
X-Google-Smtp-Source: AK7set8Ri2TWy/MQ9u6nr+4EJE4b+c1SRTqrxCE7CNpNZqHCk4vXBhRspElgpj6AHD6YKbvSLy27FGlQbIi3bKO2GnMtCVvuVlgq
MIME-Version: 1.0
X-Received: by 2002:a02:9443:0:b0:3a9:46f6:b197 with SMTP id
 a61-20020a029443000000b003a946f6b197mr4872940jai.20.1675673929301; Mon, 06
 Feb 2023 00:58:49 -0800 (PST)
Date:   Mon, 06 Feb 2023 00:58:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050c30005f4043d1d@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in vfs_rename
From:   syzbot <syzbot+e91636b670ccb340da5e@syzkaller.appspotmail.com>
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

HEAD commit:    d2d11f342b17 Merge branch 'fixes' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16055fbb480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bb1911ff9919df0
dashboard link: https://syzkaller.appspot.com/bug?extid=e91636b670ccb340da5e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6be923b8a63a/disk-d2d11f34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a426c0bf1d8/vmlinux-d2d11f34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c6af145650b/bzImage-d2d11f34.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e91636b670ccb340da5e@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffffffff815ad
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD c48f067 P4D c48f067 PUD c491067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7143 Comm: syz-executor.3 Not tainted 6.2.0-rc7-syzkaller-00002-gd2d11f342b17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:vfs_rename+0xd5/0x1a90 fs/namei.c:4691
Code: 00 0f 85 41 17 00 00 48 8d 7d 68 4c 8b 6b 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 14 17 00 00 <48> 8b 45 68 4d 8d 75 68 4c 89 f2 48 c1 ea 03 48 89 44 24 08 48 b8
RSP: 0018:ffffc9000aa4faa8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc9000aa4fc28 RCX: ffffc9000b5ea000
RDX: 1fffffffffff02b5 RSI: ffffffff81e1dfba RDI: fffffffffff815ad
RBP: fffffffffff81545 R08: 0000000000000005 R09: 0000000000200000
R10: 0000000000000000 R11: 0000000000000000 R12: fffffffffff81545
R13: ffff888073167028 R14: ffff888073167028 R15: ffff88803af73690
FS:  00007f26c0b92700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffff815ad CR3: 000000007ce37000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ovl_do_rename fs/overlayfs/overlayfs.h:311 [inline]
 ovl_cleanup_and_whiteout+0x2c6/0x700 fs/overlayfs/dir.c:125
 ovl_remove_and_whiteout fs/overlayfs/dir.c:784 [inline]
 ovl_do_remove+0xb45/0xe50 fs/overlayfs/dir.c:911
 vfs_unlink+0x355/0x930 fs/namei.c:4252
 do_unlinkat+0x3b7/0x640 fs/namei.c:4320
 __do_sys_unlink fs/namei.c:4368 [inline]
 __se_sys_unlink fs/namei.c:4366 [inline]
 __x64_sys_unlink+0xca/0x110 fs/namei.c:4366
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f26bfe8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f26c0b92168 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f26bffabf80 RCX: 00007f26bfe8c0c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000100
RBP: 00007f26bfee7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff98d3e57f R14: 00007f26c0b92300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: fffffffffff815ad
---[ end trace 0000000000000000 ]---
RIP: 0010:vfs_rename+0xd5/0x1a90 fs/namei.c:4691
Code: 00 0f 85 41 17 00 00 48 8d 7d 68 4c 8b 6b 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 14 17 00 00 <48> 8b 45 68 4d 8d 75 68 4c 89 f2 48 c1 ea 03 48 89 44 24 08 48 b8
RSP: 0018:ffffc9000aa4faa8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffffc9000aa4fc28 RCX: ffffc9000b5ea000
RDX: 1fffffffffff02b5 RSI: ffffffff81e1dfba RDI: fffffffffff815ad
RBP: fffffffffff81545 R08: 0000000000000005 R09: 0000000000200000
R10: 0000000000000000 R11: 0000000000000000 R12: fffffffffff81545
R13: ffff888073167028 R14: ffff888073167028 R15: ffff88803af73690
FS:  00007f26c0b92700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffff815ad CR3: 000000007ce37000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	00 0f                	add    %cl,(%rdi)
   2:	85 41 17             	test   %eax,0x17(%rcx)
   5:	00 00                	add    %al,(%rax)
   7:	48 8d 7d 68          	lea    0x68(%rbp),%rdi
   b:	4c 8b 6b 28          	mov    0x28(%rbx),%r13
   f:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  16:	fc ff df
  19:	48 89 fa             	mov    %rdi,%rdx
  1c:	48 c1 ea 03          	shr    $0x3,%rdx
  20:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  24:	0f 85 14 17 00 00    	jne    0x173e
* 2a:	48 8b 45 68          	mov    0x68(%rbp),%rax <-- trapping instruction
  2e:	4d 8d 75 68          	lea    0x68(%r13),%r14
  32:	4c 89 f2             	mov    %r14,%rdx
  35:	48 c1 ea 03          	shr    $0x3,%rdx
  39:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  3e:	48                   	rex.W
  3f:	b8                   	.byte 0xb8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
