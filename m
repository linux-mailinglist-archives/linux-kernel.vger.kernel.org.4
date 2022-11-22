Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F016663345D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 05:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiKVEPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 23:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiKVEOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 23:14:46 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8C91E3F2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 20:14:44 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id d2-20020a056e020be200b00300ecc7e0d4so9872530ilu.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 20:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WA4iHCWugmnHvIQu7gzPKMZjhI/irAGM9Jo7KTwNH8s=;
        b=oNpC9dpPSDTdUGoPHYUIlalCZWjVBjv5jFvE1se2uyrW5Y7wIos/gItHPOuoNQ+BMO
         lxRNPUoDyDY8yYy3qHjncPot4EU3/Uncn/IsnlhgGj/j48OEMaEE00/xH4p9aSh7+dwq
         S7TuutQrOfIHCsXQ5bNFAmMf7/TZOFaPm1qYNnkIj83BKsZ4lGqwkRigFVGgigGDJLzl
         mJUCKQ09ndDx4Kzv4wCe/ZLnEyk6rmhVaz1WgCuhvUH3+6qRGR5bb+M48C2PvfWBBlzt
         2ZDUYumCXlrkKACBf8ixCbC5ym4DmLOcR5RogqjA556WvnvpOWUwIqbfU25xL6ZzoLCl
         7ktg==
X-Gm-Message-State: ANoB5pl6ORVIsmBVXHRP8ZvZDz7ehTDt2gylNLkzguJZkW6kXR9jhbH/
        HxAIIs1i62vwVSnK3sQdNzrLd8k+k/a/9NlaK5hg8L19mixB
X-Google-Smtp-Source: AA0mqf7anz7quoRzyRXNmKVeeKOf69utHepRmPLb6jpbZs2+3wjFSDbp+MOo8e5/lSH/hEbxvkbJg+jB5Qb7NqDHbNB3lKfBrbIQ
MIME-Version: 1.0
X-Received: by 2002:a02:b707:0:b0:375:4f73:2951 with SMTP id
 g7-20020a02b707000000b003754f732951mr9908254jam.176.1669090483850; Mon, 21
 Nov 2022 20:14:43 -0800 (PST)
Date:   Mon, 21 Nov 2022 20:14:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063536805ee0769d8@google.com>
Subject: [syzbot] kernel BUG in assfail
From:   syzbot <syzbot+1d8c82e66f2e76b6b427@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    eb7081409f94 Linux 6.1-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e5bb0d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
dashboard link: https://syzkaller.appspot.com/bug?extid=1d8c82e66f2e76b6b427
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169e86fd880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1691470d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a019f55c517/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb36e890aa8b/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/feee2c23ec64/bzImage-eb708140.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c5c0a12afa51/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d8c82e66f2e76b6b427@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
XFS (loop0): Mounting V5 Filesystem
XFS (loop0): Log inconsistent (didn't find previous header)
XFS: Assertion failed: 0, file: fs/xfs/xfs_log_recover.c, line: 429
------------[ cut here ]------------
kernel BUG at fs/xfs/xfs_message.c:102!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3638 Comm: syz-executor351 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:assfail+0x97/0xa0 fs/xfs/xfs_message.c:102
Code: 0f 0b 5b 41 5e 41 5f 5d c3 48 c7 c1 f0 b0 77 8d 80 e1 07 38 c1 7c d0 48 c7 c7 f0 b0 77 8d e8 20 0e ab fe eb c2 e8 59 f6 56 fe <0f> 0b 0f 1f 80 00 00 00 00 41 56 53 89 f3 49 89 fe e8 43 f6 56 fe
RSP: 0018:ffffc90003aff598 EFLAGS: 00010293
RAX: ffffffff8333a217 RBX: 0000000000000001 RCX: ffff888022cb9d40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8b32e340 R08: ffffffff8333a1e4 R09: ffffffff843cfcf6
R10: 0000000000000002 R11: ffff888022cb9d40 R12: 000000000000160d
R13: dffffc0000000000 R14: 00000000000001ad R15: ffffffff8b32fa30
FS:  00007f52b55bb700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056094ba32cc8 CR3: 00000000779ca000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xlog_find_verify_log_record+0x3fa/0x6f0 fs/xfs/xfs_log_recover.c:429
 xlog_find_head+0x97e/0xbd0 fs/xfs/xfs_log_recover.c:722
 xlog_find_tail+0x12f/0xe60 fs/xfs/xfs_log_recover.c:1256
 xlog_recover+0x98/0x550 fs/xfs/xfs_log_recover.c:3361
 xfs_log_mount+0x46c/0x810 fs/xfs/xfs_log.c:739
 xfs_mountfs+0xd44/0x2040 fs/xfs/xfs_mount.c:805
 xfs_fs_fill_super+0xf95/0x11f0 fs/xfs/xfs_super.c:1666
 get_tree_bdev+0x400/0x620 fs/super.c:1324
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f52b563204a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 d8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f52b55bb0d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f52b563204a
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007f52b55bb100
RBP: 00007f52b55bb6b8 R08: 00007f52b55bb140 R09: 00000000000096b3
R10: 0000000006208004 R11: 0000000000000206 R12: 0000000000000005
R13: 00007f52b55bb140 R14: 00007f52b55bb100 R15: 0000000006208004
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:assfail+0x97/0xa0 fs/xfs/xfs_message.c:102
Code: 0f 0b 5b 41 5e 41 5f 5d c3 48 c7 c1 f0 b0 77 8d 80 e1 07 38 c1 7c d0 48 c7 c7 f0 b0 77 8d e8 20 0e ab fe eb c2 e8 59 f6 56 fe <0f> 0b 0f 1f 80 00 00 00 00 41 56 53 89 f3 49 89 fe e8 43 f6 56 fe
RSP: 0018:ffffc90003aff598 EFLAGS: 00010293
RAX: ffffffff8333a217 RBX: 0000000000000001 RCX: ffff888022cb9d40
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8b32e340 R08: ffffffff8333a1e4 R09: ffffffff843cfcf6
R10: 0000000000000002 R11: ffff888022cb9d40 R12: 000000000000160d
R13: dffffc0000000000 R14: 00000000000001ad R15: ffffffff8b32fa30
FS:  00007f52b55bb700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f52b5665190 CR3: 00000000779ca000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
