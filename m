Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8B68DF6C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjBGRwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjBGRwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:52:21 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE60D3E60A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:52:02 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id h2-20020a92c262000000b00313b8b647ceso6360877ild.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:52:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoBKLzmGmyNsMYA92o0k2YWp0ZOapj4eKWNeizk91B0=;
        b=hYjAZWsh/vqxnXVrnNsJrmDBa1cyLPGnKGsFB68KmBsZ30Pr5KvMQHiV+wz8ugTm3C
         EztPv+7pAI9TM3RWjpzXn7hiw+2PB5ccOZ3u5GZeYIXcBSzY1SRL5FQFk3uH0KGj6dfF
         q/8uEhN03qxOCNYg6byuXRDVHsb/SfHYFDkbkWNfyjy6XwKAiix4L5+FuRiFiX8AOKPI
         ZBbDYRlTz8NV+Y/EHCD1XHgniwvzT9nx6T3lhiYSSsFFhI1Ghm1Ks+8fHvljY9Z+Dxr2
         N0tY6yMwnTZm2yGj2s0VcsknBdlsv16QAGWhEYq6DQ3bqCHlHbiwr+zLKnPTVKZc/iO0
         6XSw==
X-Gm-Message-State: AO0yUKWlAqoQcqzUKrP/ytUrYEM6Gu0vyq5hCX9TD3vAHcxR+sHG9Mfk
        vvyxf9dgXSX4R2P+AgIHPyAhyjG/dRW2aVLaVOiQ9Wmneovn
X-Google-Smtp-Source: AK7set9xk+hnU7ynssyou7cbXPDW//Uz1Pr9s/g36RJrVIbcksQNqi0eDaxETyM4WPGIfIoWIgkWzQ+ECoQxPAqAng05YlzGIFWa
MIME-Version: 1.0
X-Received: by 2002:a92:a051:0:b0:313:8923:a4ab with SMTP id
 b17-20020a92a051000000b003138923a4abmr3138397ilm.1.1675792312867; Tue, 07 Feb
 2023 09:51:52 -0800 (PST)
Date:   Tue, 07 Feb 2023 09:51:52 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086a1b705f41fcd64@google.com>
Subject: [syzbot] [bfs?] general protection fault in bfs_get_block
From:   syzbot <syzbot+9851c0a26f6143fb0173@syzkaller.appspotmail.com>
To:     aivazian.tigran@gmail.com, linux-kernel@vger.kernel.org,
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

HEAD commit:    c0b67534c95c Merge tag 'cgroup-for-6.2-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174bfa45480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89fb74cb65e24f0e
dashboard link: https://syzkaller.appspot.com/bug?extid=9851c0a26f6143fb0173
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/380fe06903bb/disk-c0b67534.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/afeae913ffab/vmlinux-c0b67534.xz
kernel image: https://storage.googleapis.com/syzbot-assets/985e809f5705/bzImage-c0b67534.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9851c0a26f6143fb0173@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 23349 Comm: syz-executor.3 Not tainted 6.2.0-rc6-syzkaller-00011-gc0b67534c95c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:bfs_move_block fs/bfs/file.c:42 [inline]
RIP: 0010:bfs_move_blocks fs/bfs/file.c:56 [inline]
RIP: 0010:bfs_get_block+0x35a/0xdd0 fs/bfs/file.c:125
Code: 48 89 f8 48 c1 e8 03 80 3c 08 00 0f 85 64 08 00 00 49 8d 7e 28 48 8b 55 20 48 b9 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <80> 3c 08 00 0f 85 2d 08 00 00 48 8d 7d 28 4d 8b 4e 28 48 b9 00 00
RSP: 0018:ffffc9000508ef68 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 000000000000000e RCX: dffffc0000000000
RDX: 0000000000000200 RSI: ffffffff81ed528f RDI: 0000000000000028
RBP: ffff88808656c570 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffffa R11: 0000000000000000 R12: ffff88803b408000
R13: ffffed100768102c R14: 0000000000000000 R15: 0000000000000012
FS:  00007f83e5621700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556e96708 CR3: 0000000028963000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __block_write_begin_int+0x3bd/0x14b0 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0xb9/0x4d0 fs/buffer.c:2102
 bfs_write_begin+0x31/0xd0 fs/bfs/file.c:177
 generic_perform_write+0x256/0x570 mm/filemap.c:3772
 __generic_file_write_iter+0x2ae/0x500 mm/filemap.c:3900
 generic_file_write_iter+0xe3/0x350 mm/filemap.c:3932
 __kernel_write_iter+0x262/0x730 fs/read_write.c:517
 __kernel_write+0xcb/0x110 fs/read_write.c:537
 __dump_emit fs/coredump.c:811 [inline]
 dump_emit+0x21d/0x340 fs/coredump.c:881
 writenote+0x20f/0x2b0 fs/binfmt_elf.c:1482
 write_note_info fs/binfmt_elf.c:1967 [inline]
 elf_core_dump+0x2476/0x3590 fs/binfmt_elf.c:2124
 do_coredump+0x2764/0x3c50 fs/coredump.c:762
 get_signal+0x1c03/0x2450 kernel/signal.c:2845
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 irqentry_exit_to_user_mode+0x9/0x40 kernel/entry/common.c:309
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564
RIP: 0033:0x7f83e488c0d1
Code: c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 48 3d 01 f0 ff ff 73 01 <c3> 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
RSP: 002b:0000000020000050 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f83e49abf80 RCX: 00007f83e488c0c9
RDX: 0000000020000080 RSI: 0000000020000050 RDI: 0000000080000080
RBP: 00007f83e48e7ae9 R08: 0000000020000300 R09: 0000000020000300
R10: 0000000020000100 R11: 0000000000000202 R12: 0000000000000000
R13: 00007ffe44bc4c1f R14: 00007f83e5621300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bfs_move_block fs/bfs/file.c:42 [inline]
RIP: 0010:bfs_move_blocks fs/bfs/file.c:56 [inline]
RIP: 0010:bfs_get_block+0x35a/0xdd0 fs/bfs/file.c:125
Code: 48 89 f8 48 c1 e8 03 80 3c 08 00 0f 85 64 08 00 00 49 8d 7e 28 48 8b 55 20 48 b9 00 00 00 00 00 fc ff df 48 89 f8 48 c1 e8 03 <80> 3c 08 00 0f 85 2d 08 00 00 48 8d 7d 28 4d 8b 4e 28 48 b9 00 00
RSP: 0018:ffffc9000508ef68 EFLAGS: 00010206

RAX: 0000000000000005 RBX: 000000000000000e RCX: dffffc0000000000
RDX: 0000000000000200 RSI: ffffffff81ed528f RDI: 0000000000000028
RBP: ffff88808656c570 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffffa R11: 0000000000000000 R12: ffff88803b408000
R13: ffffed100768102c R14: 0000000000000000 R15: 0000000000000012
FS:  00007f83e5621700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc566985058 CR3: 0000000028963000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 f8             	mov    %rdi,%rax
   3:	48 c1 e8 03          	shr    $0x3,%rax
   7:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
   b:	0f 85 64 08 00 00    	jne    0x875
  11:	49 8d 7e 28          	lea    0x28(%r14),%rdi
  15:	48 8b 55 20          	mov    0x20(%rbp),%rdx
  19:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  20:	fc ff df
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	0f 85 2d 08 00 00    	jne    0x861
  34:	48 8d 7d 28          	lea    0x28(%rbp),%rdi
  38:	4d 8b 4e 28          	mov    0x28(%r14),%r9
  3c:	48                   	rex.W
  3d:	b9                   	.byte 0xb9


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
