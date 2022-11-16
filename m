Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F85D62BAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiKPLIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiKPLHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:07:15 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9B419A4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:53:43 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id x23-20020a6b6a17000000b006d9ca4e35edso8493550iog.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MGClWNxCys8EdF37c76zS1w38Eum+H+Mz6DrCbtYUQ=;
        b=MIAHc6rWQzzL9TfVfrkBzCWn+f2O9yLkzFn7Iga5mFJtTtwupVcFtZyc9Mv97K8deH
         Ub/mlNji9gPf9oGOSMNqY0YvKlG4/LKd7pTaywbCyIFWVlzB/9mSXHSZJEddYnMYaVAy
         Zx6KVTTJmskvvv1NS/Ol+rng1y14LlcKoEduJu/1tJgLwDqLadcwP3KbiQfeKss01795
         QllXG4uTqyhnEtAdCXQoiSfsfRiDBEn86U+bm1KEPyEr+SJEOjxSF/B9UwbRtYmMqCEM
         4BAkBPnxJFZNi3K4aR6G/OmI6QuXabJWYSy6wVJDZ/vx0nhU7a61tDV/tpJVqw9AGaUs
         JpZg==
X-Gm-Message-State: ANoB5plTkyR3F9aKkBugLV5iGmkWjViqbni5OPRLVRoXBTsPB70gk60L
        DN+irEMOWG+bU1acmJH1cLxFIFpiCNMj3p+OGmV8Ynk8IW0n
X-Google-Smtp-Source: AA0mqf59KfSs2d8fewqSQSX2RqYL1x0ytm9KZXgkEvrMgU1aeSxC0C0wYaYu7rreaLgBxUC6/fmQ5+sUEbY8pGxrUK1YHKYGTLAO
MIME-Version: 1.0
X-Received: by 2002:a02:c6ca:0:b0:375:fc59:201b with SMTP id
 r10-20020a02c6ca000000b00375fc59201bmr9567213jan.12.1668596022898; Wed, 16
 Nov 2022 02:53:42 -0800 (PST)
Date:   Wed, 16 Nov 2022 02:53:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037f6b105ed944924@google.com>
Subject: [syzbot] kernel BUG in jbd2_journal_get_create_access (2)
From:   syzbot <syzbot+1db57b8a1f746d42a177@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
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

HEAD commit:    f5020a08b2b3 Merge tag 's390-6.1-4' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13dcf7a9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63dd4cec15ec5ea2
dashboard link: https://syzkaller.appspot.com/bug?extid=1db57b8a1f746d42a177
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d4840e0a006/disk-f5020a08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/da4765f2786a/vmlinux-f5020a08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5cca8e2906ca/bzImage-f5020a08.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1db57b8a1f746d42a177@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/jbd2/transaction.c:1290!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 20729 Comm: kworker/u4:2 Not tainted 6.1.0-rc4-syzkaller-00308-gf5020a08b2b3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:jbd2_journal_get_create_access+0x36c/0x560 fs/jbd2/transaction.c:1290
Code: 85 01 02 00 00 8b 45 4c bf 02 00 00 00 89 c6 89 44 24 08 e8 26 9f 4c ff 8b 44 24 08 83 f8 02 0f 84 06 fe ff ff e8 44 a2 4c ff <0f> 0b e8 3d a2 4c ff 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc900036d6db8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88814b1b6000 RCX: 0000000000000000
RDX: ffff8880569fe100 RSI: ffffffff822f322c RDI: 0000000000000005
RBP: ffff888045901870 R08: 0000000000000005 R09: 0000000000000002
R10: 0000000000000003 R11: 0000000000000000 R12: ffff88804727e6e0
R13: 0000000000000000 R14: ffff88804e841c80 R15: ffff888045901878
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020091000 CR3: 00000000322c0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ext4_journal_get_create_access+0x50/0x1f0 fs/ext4/ext4_jbd2.c:323
 ext4_ext_grow_indepth fs/ext4/extents.c:1339 [inline]
 ext4_ext_create_new_leaf fs/ext4/extents.c:1435 [inline]
 ext4_ext_insert_extent+0x12ab/0x4130 fs/ext4/extents.c:2102
 ext4_ext_map_blocks+0x1541/0x6270 fs/ext4/extents.c:4308
 ext4_map_blocks+0x775/0x18d0 fs/ext4/inode.c:645
 mpage_map_one_extent fs/ext4/inode.c:2413 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2466 [inline]
 ext4_writepages+0x1e55/0x3da0 fs/ext4/inode.c:2834
 do_writepages+0x1ab/0x690 mm/page-writeback.c:2469
 __writeback_single_inode+0x159/0x1440 fs/fs-writeback.c:1587
 writeback_sb_inodes+0x54d/0xf90 fs/fs-writeback.c:1870
 wb_writeback+0x2c5/0xd70 fs/fs-writeback.c:2044
 wb_do_writeback fs/fs-writeback.c:2187 [inline]
 wb_workfn+0x2dc/0x12f0 fs/fs-writeback.c:2227
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:jbd2_journal_get_create_access+0x36c/0x560 fs/jbd2/transaction.c:1290
Code: 85 01 02 00 00 8b 45 4c bf 02 00 00 00 89 c6 89 44 24 08 e8 26 9f 4c ff 8b 44 24 08 83 f8 02 0f 84 06 fe ff ff e8 44 a2 4c ff <0f> 0b e8 3d a2 4c ff 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1
RSP: 0018:ffffc900036d6db8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88814b1b6000 RCX: 0000000000000000
RDX: ffff8880569fe100 RSI: ffffffff822f322c RDI: 0000000000000005
RBP: ffff888045901870 R08: 0000000000000005 R09: 0000000000000002
R10: 0000000000000003 R11: 0000000000000000 R12: ffff88804727e6e0
R13: 0000000000000000 R14: ffff88804e841c80 R15: ffff888045901878
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020091000 CR3: 00000000322c0000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
