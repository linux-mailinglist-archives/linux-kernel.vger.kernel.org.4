Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD456A93D8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 10:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCCJYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 04:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjCCJYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 04:24:20 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151105C105
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 01:23:57 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id z6-20020a056602080600b007407df88db0so1006888iow.23
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 01:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKaUM4DL4aUCt53wSY6+xVX2c75cHIXVKHSTMsgM6us=;
        b=DNr8MtD/SosWvNrsPVwVLDrYYZO4YsiN+U0Jb284t2gS0YWcdrSit/ZzaGHCOuKJ7g
         SagTcAvZrEkS/NOSNaEXUyisLtzXSKk2Pz2U5GZCKfO9qKKZudckpAzakIbX+71Z0Kv+
         We+ZvW3oTg590JIdwNzbYi3V1QRkLOsnktvwVwMZPvQ9qBM5kD82qzwkdplsXRr+9Nhk
         BuxIa7ZXnseCfEK2d2OD9gngBv27PeWkK7pX2O5g6DSIJ6RAoZLcerNTrVbRSNMfBdW8
         az0UsquZaD83Z8nU7PAZAR6AbCViecHWA7D4JP2PC5y8ETyNKktfGfi4nKOOHQyHHMbt
         Skew==
X-Gm-Message-State: AO0yUKXASsjV/mx3Jbp4qCLesWFYU7AGfpkS0cC2cnqrf3KBSfPOZTBn
        KsR6VKZquLKwei7XfxbsXfL6iAXJoWuN79e6KLkry8o0b3t2
X-Google-Smtp-Source: AK7set8ebZa0cBmUtVB0Uoaurhg8Ab9d8vC2YCWQc8CTIWYtHVI5HCvIjsAdQEmhoWDn0zsWqkr1a4ZUFyksplDc17jDeQJLPyal
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1110:b0:315:9a9a:2d3 with SMTP id
 u16-20020a056e02111000b003159a9a02d3mr681660ilk.5.1677835424500; Fri, 03 Mar
 2023 01:23:44 -0800 (PST)
Date:   Fri, 03 Mar 2023 01:23:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078153305f5fb8030@google.com>
Subject: [syzbot] [nilfs?] WARNING in nilfs_btree_propagate
From:   syzbot <syzbot+527641d191abe35993c1@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
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

HEAD commit:    f3a2439f20d9 Merge tag 'rproc-v6.3' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17228a74c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd442ddf29eaca0c
dashboard link: https://syzkaller.appspot.com/bug?extid=527641d191abe35993c1
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9dbed9360199/disk-f3a2439f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d9708601442a/vmlinux-f3a2439f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/177fdbdbd4ea/bzImage-f3a2439f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+527641d191abe35993c1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6839 at fs/nilfs2/btree.c:2071 nilfs_btree_propagate+0xc72/0xde0
Modules linked in:
CPU: 1 PID: 6839 Comm: syz-executor.4 Not tainted 6.2.0-syzkaller-12485-gf3a2439f20d9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
RIP: 0010:nilfs_btree_propagate+0xc72/0xde0 fs/nilfs2/btree.c:2071
Code: 00 48 8b 44 24 08 49 8d 74 05 58 e8 c8 64 ff ff 48 8b 6c 24 10 43 80 3c 27 00 0f 85 1a fe ff ff e9 1d fe ff ff e8 3e 6c 39 fe <0f> 0b e9 f2 f3 ff ff e8 32 6c 39 fe 48 8b 1c 24 48 81 c3 d0 00 00
RSP: 0018:ffffc90006196ea0 EFLAGS: 00010283
RAX: ffffffff83537a82 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc90005929000 RSI: 000000000001e5d4 RDI: 000000000001e5d5
RBP: ffffffff8b4581a8 R08: ffffffff83536e6c R09: ffffed100e936523
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: 1ffff1100e93652b R14: 1ffff1100e936522 R15: ffff8880749b2910
FS:  00007f851cc6a700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31f2b000 CR3: 0000000028470000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_bmap_propagate+0x71/0x120 fs/nilfs2/bmap.c:337
 nilfs_collect_file_data+0x4d/0xc0 fs/nilfs2/segment.c:568
 nilfs_segctor_apply_buffers+0x180/0x330 fs/nilfs2/segment.c:1020
 nilfs_segctor_scan_file_dsync fs/nilfs2/segment.c:1109 [inline]
 nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1263 [inline]
 nilfs_segctor_collect fs/nilfs2/segment.c:1505 [inline]
 nilfs_segctor_do_construct+0x175e/0x6f70 fs/nilfs2/segment.c:2047
 nilfs_construct_dsync_segment+0x5c4/0x6c0 fs/nilfs2/segment.c:2312
 nilfs_sync_file+0xbc/0x260 fs/nilfs2/file.c:32
 generic_write_sync include/linux/fs.h:2452 [inline]
 generic_file_write_iter+0x2a1/0x310 mm/filemap.c:4090
 do_iter_write+0x6ea/0xc50 fs/read_write.c:861
 iter_file_splice_write+0x843/0xfe0 fs/splice.c:778
 do_splice_from fs/splice.c:856 [inline]
 direct_splice_actor+0xe7/0x1c0 fs/splice.c:1023
 splice_direct_to_actor+0x4c4/0xbd0 fs/splice.c:978
 do_splice_direct+0x283/0x3d0 fs/splice.c:1066
 do_sendfile+0x620/0xff0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f851be8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f851cc6a168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f851bfac050 RCX: 00007f851be8c0f9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f851bee7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000f03b2400 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdf954162f R14: 00007f851cc6a300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
