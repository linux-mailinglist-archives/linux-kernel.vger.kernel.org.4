Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A05694659
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjBMMwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjBMMwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:52:43 -0500
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B941BB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:52:41 -0800 (PST)
Received: by mail-io1-f80.google.com with SMTP id e16-20020a6b5010000000b00719041c51ebso8279884iob.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=id9MRG07ni1YoJkgu96KJB42k2NqRqUR36GnUf4Q0is=;
        b=MdbJvqLYQAfviRoq9zDinihHFeozFjQAjh1lB2Xw2mnVG7wcY6hRvij+c6BDysKoh4
         YYtvg5x+LBaGTkjYW6a+xmrNrEWWvHvSD8yo1MEeoFtUWPczR6B7klVjPyV77y+1QQad
         76l8Fjp/4PCZu3TgE4rOTy2JaK4ZQJY0YgxQsYAIoaoai5IqvuqzPHu7QeIMOoXzSuzG
         WZo7Rt3HA51qbdG7lj9NQVq1KdBtS9xcyKQR4YS0TYGvlivgq+PyNQIdZ77m3Bkhn5QE
         qHeIlUdbO81I9cu3viKW7kFS6o2vcIN5fg/EnBUzQIxguk3jRaismpCpS5v5Od2+WaTu
         czWA==
X-Gm-Message-State: AO0yUKXcX4tS+tUJSJ6AQSoWE8VoGrw3jFifrk03UNLnLGqXXSXKjsYT
        ZPchCfUmuWdz3cETZCewerDRCYZgxN8RQYVP0Lzgq5/opg+y
X-Google-Smtp-Source: AK7set9O1fgyF3b3HnNGdXNjTq0R+rsRyqCYIN/pU3NTUOHPuIxsUIiM1tkPpry68f2spN8pZdJ2xTp3nu3vHfjyupoViT1VsIFX
MIME-Version: 1.0
X-Received: by 2002:a5d:8b41:0:b0:719:2441:e5e7 with SMTP id
 c1-20020a5d8b41000000b007192441e5e7mr11782502iot.11.1676292761300; Mon, 13
 Feb 2023 04:52:41 -0800 (PST)
Date:   Mon, 13 Feb 2023 04:52:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093b50f05f4945251@google.com>
Subject: [syzbot] [udf?] WARNING in udf_prealloc_blocks
From:   syzbot <syzbot+a637b18b4c36f9892829@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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

HEAD commit:    0983f6bf2bfc Merge tag 'devicetree-fixes-for-6.2-2' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11440f97480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e18702f016355851
dashboard link: https://syzkaller.appspot.com/bug?extid=a637b18b4c36f9892829
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9666ee82c289/disk-0983f6bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2eec7d3e271c/vmlinux-0983f6bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e59c8acdb6e0/bzImage-0983f6bf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a637b18b4c36f9892829@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 5542 at fs/udf/udfdecl.h:116 udf_add_free_space fs/udf/balloc.c:102 [inline]
WARNING: CPU: 1 PID: 5542 at fs/udf/udfdecl.h:116 udf_table_prealloc_blocks fs/udf/balloc.c:553 [inline]
WARNING: CPU: 1 PID: 5542 at fs/udf/udfdecl.h:116 udf_prealloc_blocks+0x11a3/0x15a0 fs/udf/balloc.c:686
Modules linked in:
CPU: 1 PID: 5542 Comm: syz-executor.3 Not tainted 6.2.0-rc7-syzkaller-00018-g0983f6bf2bfc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:114 [inline]
RIP: 0010:udf_add_free_space fs/udf/balloc.c:102 [inline]
RIP: 0010:udf_table_prealloc_blocks fs/udf/balloc.c:553 [inline]
RIP: 0010:udf_prealloc_blocks+0x11a3/0x15a0 fs/udf/balloc.c:686
Code: ff ff e8 40 d8 8d fe 49 bc 00 00 00 00 00 fc ff df 49 89 df e9 ca f6 ff ff e8 29 d8 8d fe 0f 0b e9 dc f7 ff ff e8 1d d8 8d fe <0f> 0b e9 79 fe ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c 7f ef ff ff
RSP: 0018:ffffc90005386ca0 EFLAGS: 00010283
RAX: ffffffff82fdfa33 RBX: 0000000010179aab RCX: 0000000000040000
RDX: ffffc90012d0b000 RSI: 0000000000031853 RDI: 0000000000031854
RBP: ffffc90005386e30 R08: ffffffff82fdf8a1 R09: fffffbfff1ca1256
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88802e4c28c0
R13: ffff88802c080678 R14: ffff88801e1e001c R15: 0000000000000008
FS:  00007f9df38fe700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31926000 CR3: 0000000017bd1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_prealloc_extents fs/udf/inode.c:1010 [inline]
 inode_getblk fs/udf/inode.c:871 [inline]
 udf_get_block+0x2614/0x5200 fs/udf/inode.c:444
 __block_write_begin_int+0x548/0x1a50 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0x9c/0x1f0 fs/buffer.c:2102
 udf_write_begin+0x31/0x70 fs/udf/inode.c:207
 generic_perform_write+0x300/0x5e0 mm/filemap.c:3772
 __generic_file_write_iter+0x17a/0x400 mm/filemap.c:3900
 udf_file_write_iter+0x2fa/0x5e0 fs/udf/file.c:170
 do_iter_write+0x6ea/0xc50 fs/read_write.c:861
 iter_file_splice_write+0x80a/0xfa0 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0xe7/0x1c0 fs/splice.c:931
 splice_direct_to_actor+0x4c4/0xbd0 fs/splice.c:886
 do_splice_direct+0x283/0x3d0 fs/splice.c:974
 do_sendfile+0x620/0xff0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9dfd08c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9df38fe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f9dfd1ac050 RCX: 00007f9dfd08c0f9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000004
RBP: 00007f9dfd0e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080000263 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffca29e75bf R14: 00007f9df38fe300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
