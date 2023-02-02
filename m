Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93EC688467
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjBBQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjBBQ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:27:43 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676CF66024
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:27:40 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id g5-20020a92d7c5000000b00310afb74005so1533826ilq.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/Fye7YGxkexdHFRmtjVTI5F+CBnNcSNRcKyzFayDxA=;
        b=ynHLJhney0cy1IW5qEIlGLFJzaTkPF60/WaYvxJs0HKMyrQASH0SVU/5SgyjNdFN2w
         Bljw6x4q6yeMZYooQ9snXYB2fwJqG3dUVespVwelDRQCBXDS0tvWjLRF97RVDLoKBw1r
         nSpVvXEVT4tIfuj/k2h4unvjtxXq75QJvLFekF4/nt8EqAYvSVFToTQ8i6ykLbmyyP6W
         +8feC1DbcUynhGm6bZ5IM4llRaCt3XlhZ3rm1zMGQymGbbMk/QFmt4NDeZVXOA3YY3/k
         WM0mQWOXLvnE3tBW4m3b5R2zs1z8fuf0CO9pePjFQmFj7kqLJq4YOy3rqY9FWB6zOg3u
         b7GQ==
X-Gm-Message-State: AO0yUKWXLyNsBe7NNgGyLZQjQpqELoGN3h7V7N4eNNt2cnM7dhRe87Lu
        6GFEgpfWngsIBm0lc3gRLxlB5BHEkb+Sw8r7stAudg/J8vu1
X-Google-Smtp-Source: AK7set8QNCB7SLtxmJeYcyLmhCuin+LlMv7XQhE0Ti30t3fRboF29laG2odduXjGixWKgyND6iFR9gmbSrEesA6WNioHvN8UxPO1
MIME-Version: 1.0
X-Received: by 2002:a6b:dc13:0:b0:71a:b7de:6e1c with SMTP id
 s19-20020a6bdc13000000b0071ab7de6e1cmr1472234ioc.87.1675355259498; Thu, 02
 Feb 2023 08:27:39 -0800 (PST)
Date:   Thu, 02 Feb 2023 08:27:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d745f05f3ba0be7@google.com>
Subject: [syzbot] [reiserfs?] panic: item_ops-NUM direntry_check_left: free
 space NUM, entry_count NUM
From:   syzbot <syzbot+3f480503caba4b4b47c5@syzkaller.appspotmail.com>
To:     jack@suse.cz, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yijiangshan@kylinos.cn
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

HEAD commit:    c96618275234 Fix up more non-executable files marked execu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10db6a69480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d5c2ee6c2bd4b8
dashboard link: https://syzkaller.appspot.com/bug?extid=3f480503caba4b4b47c5
compiler:       Debian clang version 13.0.1-6~deb11u1, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a829cd39e940/disk-c9661827.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/abbc86f52a98/vmlinux-c9661827.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab0970dd4f84/bzImage-c9661827.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f480503caba4b4b47c5@syzkaller.appspotmail.com

REISERFS (device loop3): checking transaction log (loop3)
REISERFS (device loop3): Using r5 hash to sort names
REISERFS (device loop3): Created .reiserfs_priv - reserved for xattr storage.
REISERFS warning: vs-16090 direntry_bytes_number: bytes number is asked for direntry
REISERFS panic: item_ops-1 direntry_check_left: free space 16, entry_count 4
------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:390!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8130 Comm: syz-executor.3 Not tainted 6.2.0-rc5-syzkaller-00205-gc96618275234 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__reiserfs_panic+0xea/0x140 fs/reiserfs/prints.c:390
Code: 48 c7 c2 00 51 03 8b 48 0f 44 d0 48 0f 44 d8 48 c7 c7 20 52 03 8b 48 89 de 4c 89 f1 49 c7 c0 40 76 16 92 31 c0 e8 96 3a 83 08 <0f> 0b e8 9f bb 5f ff 49 81 c7 a8 06 00 00 48 85 db 48 c7 c0 e0 50
RSP: 0018:ffffc9000a3ee980 EFLAGS: 00010246
RAX: 000000000000004c RBX: ffffffff8b03be20 RCX: ad4adfe0867ba200
RDX: ffffc9000bd4b000 RSI: 0000000000008492 RDI: 0000000000008493
RBP: ffffc9000a3eea68 R08: ffffffff816f2b8d R09: fffff5200147dce9
R10: fffff5200147dce9 R11: 1ffff9200147dce8 R12: ffffffff8b03be40
R13: ffffc9000a3ee9a0 R14: ffffffff8cc75f06 R15: 0000000000000000
FS:  00007fc01024f700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32823000 CR3: 000000007dd96000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 direntry_check_left+0x315/0x320 fs/reiserfs/item_ops.c:542
 check_left+0x4e2/0x730 fs/reiserfs/fix_node.c:265
 ip_check_balance fs/reiserfs/fix_node.c:1420 [inline]
 check_balance fs/reiserfs/fix_node.c:2083 [inline]
 fix_nodes+0x1d3d/0x8560 fs/reiserfs/fix_node.c:2635
 reiserfs_paste_into_item+0x662/0x880 fs/reiserfs/stree.c:2130
 reiserfs_get_block+0x223f/0x5180 fs/reiserfs/inode.c:1069
 __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
 reiserfs_write_begin+0x247/0x510 fs/reiserfs/inode.c:2775
 generic_cont_expand_simple+0x151/0x250 fs/buffer.c:2347
 reiserfs_setattr+0x642/0x1200 fs/reiserfs/inode.c:3305
 notify_change+0xe50/0x1100 fs/attr.c:482
 do_truncate+0x200/0x2f0 fs/open.c:65
 do_sys_ftruncate+0x2b0/0x350 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc00f48c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc01024f168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007fc00f5abf80 RCX: 00007fc00f48c0c9
RDX: 0000000000000000 RSI: 0000000002007ffb RDI: 0000000000000006
RBP: 00007fc00f4e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd3617badf R14: 00007fc01024f300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__reiserfs_panic+0xea/0x140 fs/reiserfs/prints.c:390
Code: 48 c7 c2 00 51 03 8b 48 0f 44 d0 48 0f 44 d8 48 c7 c7 20 52 03 8b 48 89 de 4c 89 f1 49 c7 c0 40 76 16 92 31 c0 e8 96 3a 83 08 <0f> 0b e8 9f bb 5f ff 49 81 c7 a8 06 00 00 48 85 db 48 c7 c0 e0 50
RSP: 0018:ffffc9000a3ee980 EFLAGS: 00010246
RAX: 000000000000004c RBX: ffffffff8b03be20 RCX: ad4adfe0867ba200
RDX: ffffc9000bd4b000 RSI: 0000000000008492 RDI: 0000000000008493
RBP: ffffc9000a3eea68 R08: ffffffff816f2b8d R09: fffff5200147dce9
R10: fffff5200147dce9 R11: 1ffff9200147dce8 R12: ffffffff8b03be40
R13: ffffc9000a3ee9a0 R14: ffffffff8cc75f06 R15: 0000000000000000
FS:  00007fc01024f700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8fb71de000 CR3: 000000007dd96000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
