Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF93D5F1CBE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJAO1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJAO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:27:44 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC48545F5A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:27:40 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id f25-20020a5d8799000000b006a44e33ddb6so4461552ion.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=rbRLvdkjNdhOmIl4SMPV9eDspzA9B9qisws/DlkonqY=;
        b=pKXMvBjHq0bNsE01bYfYqeP6UnZ8J+CqyuHHQfOoKJPsm1T0PrdiQXb7Qu1fcIL5iT
         AWkrNPE+srTM2vxitz9vot/IjFKuGEf2h/pdx/DJtatNsV48PPHnzKo6AU1oiGGVBiBY
         DY7bL1PdY3WBscWbMqsQVXXeXHH5ph4khc6fzqA0vLdV5IQx90/jgWZXsaRzgumdxv0T
         otbU9rLyVPPnDmbQITB6rOZDZfhcHY6CH3CGtvm2gKAzet23C39z3QBmsIw5Fm27zzkx
         y9BmpY6I+eYgVsXA/D/AQ3esgB4eoqQ4yRPTD7INYHpdC+LOP5hVJd02lX/tStjVO2bT
         Ew2g==
X-Gm-Message-State: ACrzQf1dHt814k3sygc5bxJhmFquD/wirsAtHGAJUzY3QrNTaQoxnIka
        0C5Of+RPpX+2hzCqAzpGyFMp9PWaU2PHSb7kQyFfKuOk5dXH
X-Google-Smtp-Source: AMsMyM67Lc5+PA80vneKJBtqjtjYtQgkxrHQDxqC9gaoeVQLsYbBe3OjUVooFJLG5GrMGX17OSNt1IIjB8qCXdYMkH4LK1XyiLU7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164d:b0:2f1:869c:c45b with SMTP id
 v13-20020a056e02164d00b002f1869cc45bmr5787823ilu.212.1664634459784; Sat, 01
 Oct 2022 07:27:39 -0700 (PDT)
Date:   Sat, 01 Oct 2022 07:27:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a80d7c05e9f9e9ad@google.com>
Subject: [syzbot] general protection fault in __nilfs_btree_get_block
From:   syzbot <syzbot+3760ae4a4f4e0278a90f@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    987a926c1d8a Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111494b8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=3760ae4a4f4e0278a90f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f613b00c57b/disk-987a926c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/92e205364bcf/vmlinux-987a926c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3760ae4a4f4e0278a90f@syzkaller.appspotmail.com

loop2: detected capacity change from 0 to 4096
general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 PID: 12815 Comm: syz-executor.2 Not tainted 6.0.0-rc7-syzkaller-00132-g987a926c1d8a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:__nilfs_btree_get_block+0xc6/0x730 fs/nilfs2/btree.c:475
Code: 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 1d af 93 fe 4c 89 7c 24 20 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 fb ae 93 fe 4c 8d bc 24 80 00 00
RSP: 0018:ffffc9000e9c7140 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 0000000000040000
RDX: ffffc90013b88000 RSI: 000000000002c630 RDI: 000000000002c631
RBP: ffffc9000e9c7270 R08: ffffffff8346c1ec R09: 0000000000000000
R10: ffffed1009841a33 R11: 1ffff11009841a30 R12: 1ffff92001d38e34
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000025
FS:  00007f63dda66700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f63dda45718 CR3: 0000000020f0c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_btree_do_lookup+0x558/0xc80 fs/nilfs2/btree.c:569
 nilfs_btree_lookup+0x19d/0x1d0 fs/nilfs2/btree.c:686
 nilfs_bmap_lookup_at_level+0xd8/0x350 fs/nilfs2/bmap.c:69
 nilfs_bmap_lookup fs/nilfs2/bmap.h:170 [inline]
 nilfs_mdt_submit_block+0x23d/0x520 fs/nilfs2/mdt.c:142
 nilfs_mdt_read_block+0xa3/0x460 fs/nilfs2/mdt.c:176
 nilfs_mdt_get_block+0x104/0x820 fs/nilfs2/mdt.c:251
 nilfs_palloc_get_block+0x142/0x240 fs/nilfs2/alloc.c:216
 nilfs_palloc_get_entry_block+0x1e8/0x2e0 fs/nilfs2/alloc.c:318
 nilfs_ifile_get_inode_block+0xf0/0x1a0 fs/nilfs2/ifile.c:143
 __nilfs_read_inode fs/nilfs2/inode.c:477 [inline]
 nilfs_iget+0x253/0x8b0 fs/nilfs2/inode.c:603
 nilfs_get_root_dentry+0x28/0x230 fs/nilfs2/super.c:904
 nilfs_fill_super+0x3dd/0x5d0 fs/nilfs2/super.c:1078
 nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f63dc88bada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f63dda65f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f63dc88bada
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f63dda65fe0
RBP: 00007f63dda66020 R08: 00007f63dda66020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f63dda65fe0 R15: 00000000200162e0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__nilfs_btree_get_block+0xc6/0x730 fs/nilfs2/btree.c:475
Code: 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 1d af 93 fe 4c 89 7c 24 20 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 fb ae 93 fe 4c 8d bc 24 80 00 00
RSP: 0018:ffffc9000e9c7140 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 0000000000040000
RDX: ffffc90013b88000 RSI: 000000000002c630 RDI: 000000000002c631
RBP: ffffc9000e9c7270 R08: ffffffff8346c1ec R09: 0000000000000000
R10: ffffed1009841a33 R11: 1ffff11009841a30 R12: 1ffff92001d38e34
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000025
FS:  00007f63dda66700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c016f24f20 CR3: 0000000020f0c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	d8 48 c1             	fmuls  -0x3f(%rax)
   6:	e8 03 42 80 3c       	callq  0x3c80420e
   b:	30 00                	xor    %al,(%rax)
   d:	74 08                	je     0x17
   f:	48 89 df             	mov    %rbx,%rdi
  12:	e8 1d af 93 fe       	callq  0xfe93af34
  17:	4c 89 7c 24 20       	mov    %r15,0x20(%rsp)
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 30          	add    $0x30,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 fb ae 93 fe       	callq  0xfe93af34
  39:	4c                   	rex.WR
  3a:	8d                   	.byte 0x8d
  3b:	bc 24 80 00 00       	mov    $0x8024,%esp


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
