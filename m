Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21DE6169A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiKBQss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiKBQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:48:22 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01A163A4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:45:40 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id a15-20020a056e0208af00b00300806a52b6so15886783ilt.22
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LcOb2ZJWLl1897Yh0WqPwUDkZj+56LNf0c8jQbloFkM=;
        b=4bIQmldsRKoQeuvLBEQRKQ33FfdiIoHIfIeFYnkk+ZIY4meer06BSgdZxqYuXA9oER
         Y3o+viWar/y2uW8qJqJmCt456uhnCkbMCY6QZIWdR5AVTvh29B0O/DCt8JQ4nl0g1vls
         RV33f7VWk/241IBAd25kKDH/krwZbsH6fi/FoByIhJW28XW+OY/XedY65O4PQCJpdCXU
         eNNv8vqwODcts7d/uO0zbcXfnmLPCvb+C4BpgYLI4FA4q3871UwKTjpU77bADIAffY0+
         yAqTPwzJfR7JlkmKbrs3ZFf5x+dy6QHphkyDLeD6tbV9wOKejgQkUXmUWJmvMLllI1Iy
         ZJ6Q==
X-Gm-Message-State: ACrzQf3Cf5OvF/4s/KDuA9oK4nh1ak99sXAScUe+ix7alT/irJeLosBj
        RJU0dgNuRRHvV6PXbBLmdz+2A+KisDKIlhfHZe/DFbVnOgJl
X-Google-Smtp-Source: AMsMyM5cwRZvSGeiwOh3DYs8byZEbFJNtIJcaBnl4INf0n0WL4T3DSfzyFZ3GxRomR2NotrQFUQ8i8sRkH4AcWjVneuG8TFTiKJc
MIME-Version: 1.0
X-Received: by 2002:a05:6638:258b:b0:375:1760:601a with SMTP id
 s11-20020a056638258b00b003751760601amr16745179jat.306.1667407540297; Wed, 02
 Nov 2022 09:45:40 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:45:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022a65705ec7f923c@google.com>
Subject: [syzbot] kernel BUG in do_journal_begin_r
From:   syzbot <syzbot+2da5e132dd0268a9c0e4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bvanassche@acm.org, jack@suse.cz,
        jlayton@kernel.org, linux-kernel@vger.kernel.org, neilb@suse.de,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11168446880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=2da5e132dd0268a9c0e4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2da5e132dd0268a9c0e4@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/reiserfs/journal.c:3039!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 17357 Comm: syz-executor.5 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:do_journal_begin_r+0x105b/0x1070 fs/reiserfs/journal.c:3039
Code: ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 22 ff ff ff 48 89 df e8 b6 ec b2 ff e9 15 ff ff ff e8 1c f4 5e ff 0f 0b e8 15 f4 5e ff <0f> 0b e8 3e d6 0a 08 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 55
RSP: 0018:ffffc9000cf375c0 EFLAGS: 00010287
RAX: ffffffff8228dbcb RBX: 0000000011008083 RCX: 0000000000040000
RDX: ffffc9000be91000 RSI: 00000000000012c4 RDI: 00000000000012c5
RBP: ffffc9000cf37768 R08: ffffffff8228cca2 R09: fffffbfff1c1b5f6
R10: fffffbfff1c1b5f6 R11: 1ffffffff1c1b5f5 R12: ffff8880411d4678
R13: ffffc9000cedf214 R14: dffffc0000000000 R15: 0000000000000100
FS:  00007f76be5ff700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c02de75000 CR3: 0000000027e78000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 journal_begin+0x14b/0x350 fs/reiserfs/journal.c:3255
 reiserfs_create+0x2c3/0x660 fs/reiserfs/namei.c:661
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3710
 do_filp_open+0x264/0x4f0 fs/namei.c:3740
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f76bf28b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f76be5ff168 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f76bf3ac120 RCX: 00007f76bf28b5a9
RDX: 0000000000000000 RSI: 0000000000042142 RDI: 00000000200000c0
RBP: 00007f76bf2e67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc4062385f R14: 00007f76be5ff300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_journal_begin_r+0x105b/0x1070 fs/reiserfs/journal.c:3039
Code: ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 22 ff ff ff 48 89 df e8 b6 ec b2 ff e9 15 ff ff ff e8 1c f4 5e ff 0f 0b e8 15 f4 5e ff <0f> 0b e8 3e d6 0a 08 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 55
RSP: 0018:ffffc9000cf375c0 EFLAGS: 00010287
RAX: ffffffff8228dbcb RBX: 0000000011008083 RCX: 0000000000040000
RDX: ffffc9000be91000 RSI: 00000000000012c4 RDI: 00000000000012c5
RBP: ffffc9000cf37768 R08: ffffffff8228cca2 R09: fffffbfff1c1b5f6
R10: fffffbfff1c1b5f6 R11: 1ffffffff1c1b5f5 R12: ffff8880411d4678
R13: ffffc9000cedf214 R14: dffffc0000000000 R15: 0000000000000100
FS:  00007f76be5ff700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f76bf3a8000 CR3: 0000000027e78000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
