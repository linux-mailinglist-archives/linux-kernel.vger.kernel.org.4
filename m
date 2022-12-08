Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F902647149
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiLHOFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLHOFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:05:39 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A537655
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:05:38 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso1215948ilj.17
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 06:05:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqyL3Zkum56PasapztT6RN+h5AGYli3g1QCHsg94WBI=;
        b=lfq4alZ1eAywCbMaBKCdWD/D91XLB7arki5jqaTmWeUXKz+df0V3+NMxyrnL9Np7Vg
         uQmvKjbsuATbojE1qfMMcCbRXTMJDcMG9o7qrIpg6+aFH+EOia8j7uLljSYPyys6i433
         x2WhGOnjUleBgcOQ3hhCWwQtojwdkMb5WZBeEbWrbXylZxavG/Q8UmHasL+tily9855K
         rmxaHeaqd9OCoZY2o8m2n/h9DMqVILGVqH8raJReF7s7XL9NKRt8IRDqkPeKyhjbJ4+m
         SEDqZe8gjuxbZtFP1avzOzGEc768zPfNZnbXzcnQvDxfrpslZf4KG2B6vaALaIQHr6Nf
         k9ig==
X-Gm-Message-State: ANoB5pk5a7KPH3dsv7dS3Mr2p+RnKuqoseZJmFRWrcCWfyWrBpNwFX2G
        MZ8yymsOkM9QEhbLE8JGETgxuek2bg4Q6CIWoAYDXaQ/XH0D
X-Google-Smtp-Source: AA0mqf4NC10xoQLHDIb/AvSxp83JfjIpMb5WYdyyNf2pZegnWJtg706otHpOKYjcC+iDpIUNw+b5Nxr9iFcqfo46F/9e3MFY2I0n
MIME-Version: 1.0
X-Received: by 2002:a02:caad:0:b0:38a:682a:58fc with SMTP id
 e13-20020a02caad000000b0038a682a58fcmr3599373jap.250.1670508337345; Thu, 08
 Dec 2022 06:05:37 -0800 (PST)
Date:   Thu, 08 Dec 2022 06:05:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000abae605ef518834@google.com>
Subject: [syzbot] general protection fault in gfs2_get_tree
From:   syzbot <syzbot+2be9d17f9de2e7342994@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    591cd61541b9 Add linux-next specific files for 20221207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=172b534d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2d3e63e054c24f
dashboard link: https://syzkaller.appspot.com/bug?extid=2be9d17f9de2e7342994
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bc862c01ec56/disk-591cd615.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8f9b93f8ed2f/vmlinux-591cd615.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d5cb636d548/bzImage-591cd615.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2be9d17f9de2e7342994@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 32768
general protection fault, probably for non-canonical address 0xdffffc000000001c: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
CPU: 0 PID: 25472 Comm: syz-executor.2 Not tainted 6.1.0-rc8-next-20221207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:gfs2_get_tree+0xb8/0x270 fs/gfs2/ops_fstype.c:1342
Code: 03 80 3c 02 00 0f 85 9f 01 00 00 4c 8b bb b0 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d bf e0 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 62 01 00 00 4d 8b b7 e0 00 00 00 48 b8 00 00 00
RSP: 0018:ffffc900068b7d50 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888036c15800 RCX: ffffc9001a7a1000
RDX: 000000000000001c RSI: ffffffff83925ec7 RDI: 00000000000000e0
RBP: ffff888076c83200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888036c158b0 R14: ffff888036c15800 R15: 0000000000000000
FS:  00007fa57f6a0700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f68252516b0 CR3: 00000000876a2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa57e88d60a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa57f69ff88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000000133e6 RCX: 00007fa57e88d60a
RDX: 0000000020013400 RSI: 0000000020013440 RDI: 00007fa57f69ffe0
RBP: 00007fa57f6a0020 R08: 00007fa57f6a0020 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020013400
R13: 0000000020013440 R14: 00007fa57f69ffe0 R15: 00000000200000c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_get_tree+0xb8/0x270 fs/gfs2/ops_fstype.c:1342
Code: 03 80 3c 02 00 0f 85 9f 01 00 00 4c 8b bb b0 00 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d bf e0 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 62 01 00 00 4d 8b b7 e0 00 00 00 48 b8 00 00 00
RSP: 0018:ffffc900068b7d50 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888036c15800 RCX: ffffc9001a7a1000
RDX: 000000000000001c RSI: ffffffff83925ec7 RDI: 00000000000000e0
RBP: ffff888076c83200 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888036c158b0 R14: ffff888036c15800 R15: 0000000000000000
FS:  00007fa57f6a0700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbc0fb821b8 CR3: 00000000876a2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   6:	85 9f 01 00 00 4c    	test   %ebx,0x4c000001(%rdi)
   c:	8b bb b0 00 00 00    	mov    0xb0(%rbx),%edi
  12:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  19:	fc ff df
  1c:	49 8d bf e0 00 00 00 	lea    0xe0(%r15),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 62 01 00 00    	jne    0x196
  34:	4d 8b b7 e0 00 00 00 	mov    0xe0(%r15),%r14
  3b:	48                   	rex.W
  3c:	b8                   	.byte 0xb8
  3d:	00 00                	add    %al,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
