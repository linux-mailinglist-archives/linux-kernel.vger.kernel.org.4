Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C95F4DA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJECTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJECTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:19:39 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB5D65
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:19:34 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e8-20020a056e020b2800b002f8fd643f78so12370901ilu.18
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 19:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4M6Y+YCjZDe8yEyrYUJqpmia5EuQQHEYQ/5i4CFpBUM=;
        b=4f4nVsZ8sPFAZ0wpqzWRP3HCM6BKp92m/p7ex3F9j2c/uzoPRjjUoNdtm7fE4tkCW3
         wM7Hh0+Pc4345rcnlKMF1zdcl3Nd342NZZvTj1jgbkakjbdAeEAuXftpvrtL6Xbgd5Jm
         Zn38lrhB2430GrBuMc701YT/cRnHSLiZXUl3h3pwNZFOGHfZu3ToC0ahpBAKnmI0/7ro
         cOwCsw/vv6i6puV7BDdqtIRvClIev+Tj0jL06zIhnAZX3Kn8tSm0WHpd6LxHquWKv0bA
         xgRbhaALqvevuqARsk2lHHwFaTaEZFs+2BWoRjpxEniMuGcO0bF0vqmg9Neg/uSA19Xx
         MoeA==
X-Gm-Message-State: ACrzQf2vGta9L1C0R7sRIxYZ+znsuECPhDhTXPe7CLnzYAL+8TRmm+jv
        BVNsXCv8crLhDiPNtItqVQcLmla1z2hRpkjBQI7JIXULmQi9
X-Google-Smtp-Source: AMsMyM69ETx+HzgmJuxZIB+H/uphYf+wy9qqFTPN/0hRp0sS0RPtpg7TkpcXpe+o1Um37BSGhP8qLKkAASp7LTDX8b/NB6XoOACW
MIME-Version: 1.0
X-Received: by 2002:a6b:d80b:0:b0:6a0:d510:9d81 with SMTP id
 y11-20020a6bd80b000000b006a0d5109d81mr12474713iob.16.1664936374212; Tue, 04
 Oct 2022 19:19:34 -0700 (PDT)
Date:   Tue, 04 Oct 2022 19:19:34 -0700
In-Reply-To: <000000000000385cbf05ea3f1862@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028a44005ea40352b@google.com>
Subject: Re: [syzbot] general protection fault in kernfs_get_inode
From:   syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    0326074ff465 Merge tag 'net-next-6.1' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=149c92cc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1de7ca9efcc028c
dashboard link: https://syzkaller.appspot.com/bug?extid=534ee3d24c37c411f37f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10af2492880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104874f0880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43729d6ce2fc/disk-0326074f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f76d6f68eb3/vmlinux-0326074f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
CPU: 1 PID: 3617 Comm: syz-executor384 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:kernfs_ino include/linux/kernfs.h:358 [inline]
RIP: 0010:kernfs_get_inode+0x2e/0x520 fs/kernfs/inode.c:254
Code: 41 56 41 55 41 54 49 89 fc 53 48 89 f3 e8 1a 04 7e ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 3a 04 00 00 48 8b b3 90 00 00 00 4c 89 e7 e8 79
RSP: 0018:ffffc90003c8fa30 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000012 RSI: ffffffff81fd1156 RDI: 0000000000000090
RBP: ffffc90003c8fa50 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000024 R12: ffff8880224ba000
R13: ffff888075922000 R14: ffff88801ebf0000 R15: ffff8880211ae000
FS:  0000555556907300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000200 CR3: 000000001c179000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cgroup_may_write+0x86/0x120 kernel/cgroup/cgroup.c:4937
 cgroup_css_set_fork kernel/cgroup/cgroup.c:6237 [inline]
 cgroup_can_fork+0x961/0xec0 kernel/cgroup/cgroup.c:6331
 copy_process+0x43ed/0x7090 kernel/fork.c:2358
 kernel_clone+0xe7/0xab0 kernel/fork.c:2671
 __do_sys_clone3+0x1cd/0x2e0 kernel/fork.c:2963
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f621d8c3e99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcaa952ec8 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f621d8c3e99
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 00007ffcaa952f40
RBP: 0000000000000000 R08: 00007ffcaa952d60 R09: 00007ffcaa952ef0
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffcaa952eec
R13: 00007ffcaa952f00 R14: 00007ffcaa952f40 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kernfs_ino include/linux/kernfs.h:358 [inline]
RIP: 0010:kernfs_get_inode+0x2e/0x520 fs/kernfs/inode.c:254
Code: 41 56 41 55 41 54 49 89 fc 53 48 89 f3 e8 1a 04 7e ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 3a 04 00 00 48 8b b3 90 00 00 00 4c 89 e7 e8 79
RSP: 0018:ffffc90003c8fa30 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000012 RSI: ffffffff81fd1156 RDI: 0000000000000090
RBP: ffffc90003c8fa50 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000024 R12: ffff8880224ba000
R13: ffff888075922000 R14: ffff88801ebf0000 R15: ffff8880211ae000
FS:  0000555556907300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcaa9cb8f0 CR3: 000000001c179000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	41 56                	push   %r14
   2:	41 55                	push   %r13
   4:	41 54                	push   %r12
   6:	49 89 fc             	mov    %rdi,%r12
   9:	53                   	push   %rbx
   a:	48 89 f3             	mov    %rsi,%rbx
   d:	e8 1a 04 7e ff       	callq  0xff7e042c
  12:	48 8d bb 90 00 00 00 	lea    0x90(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 3a 04 00 00    	jne    0x46e
  34:	48 8b b3 90 00 00 00 	mov    0x90(%rbx),%rsi
  3b:	4c 89 e7             	mov    %r12,%rdi
  3e:	e8                   	.byte 0xe8
  3f:	79                   	.byte 0x79

