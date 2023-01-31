Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36C46825AF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjAaHmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjAaHmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:42:42 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D0D39285
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:42:38 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id u16-20020a5d8710000000b00720434598d6so1406002iom.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVfNvDlkq4HR7zoEKB0jRLzb51uhtItCyuNvAQUoqX8=;
        b=TN5QucBxXzGq0e7Xlrmnx5RtYudyxRWOB6DI+ItEAkVI+4l9vdK/5Q1PVbw99i3C84
         /6icJwrjMh58CZ5il3Vdjxlfv5SFsOUFVK3KO3Z2sg0SJdVKN1tG7x9oe6EzPJ+4ua/d
         rFRlvub9Esl+ZNZ8XfJ2xDYPi0KrN2e5RaFqVDE0dua12WuUhAmRjz4Cxd1A3eBsdrVV
         QuZoh7rWnZ5vZB58B7lPJjapZqyudklB8ojhmwicesaPIKTGG0U97keYKLaNak6qFHG2
         a4oeZuhuO/oY0q47Y9j2kl/ilRH43P28SjM7f1fntW9VBfdeEf88bGPMetWSUdK2oeYg
         Ka+w==
X-Gm-Message-State: AO0yUKWQbW3ltitIhbvkefVFWTST4pyrd6Io9CJ206HxlKT2Yn1y6AXe
        qFRoRlNDqQo/9pQe6k8wBxLA8juvMD5BA6vP/AsiHjgEomPn
X-Google-Smtp-Source: AK7set8CSQgqSumF3SCcecZYPTMn+Nes/Api5On3OTNgPL3x4D5Ex8wkT5SkjrliajHZh6mybkA1dAV7ceL1yR4UZirO/mJfyokA
MIME-Version: 1.0
X-Received: by 2002:a92:c981:0:b0:310:99f5:df36 with SMTP id
 y1-20020a92c981000000b0031099f5df36mr3834696iln.65.1675150957720; Mon, 30 Jan
 2023 23:42:37 -0800 (PST)
Date:   Mon, 30 Jan 2023 23:42:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7bf4e05f38a79eb@google.com>
Subject: [syzbot] [btrfs?] WARNING in csum_one_extent_buffer
From:   syzbot <syzbot+12ccac7f251e18746c4c@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    7c46948a6e9c Merge tag 'fs.fuse.acl.v6.2-rc6' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114b21e1480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8d5c2ee6c2bd4b8
dashboard link: https://syzkaller.appspot.com/bug?extid=12ccac7f251e18746c4c
compiler:       Debian clang version 13.0.1-6~deb11u1, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc51645b6401/disk-7c46948a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be036b5604a3/vmlinux-7c46948a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/274f5abf2c8f/bzImage-7c46948a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12ccac7f251e18746c4c@syzkaller.appspotmail.com

		inode generation 0 size 0 mode 100755
	item 13 key (261 12 256) itemoff 3250 itemsize 15
BTRFS error (device loop2): block=5361664 write time tree block corruption detected
------------[ cut here ]------------
WARNING: CPU: 0 PID: 18620 at fs/btrfs/disk-io.c:377 csum_one_extent_buffer+0x416/0x4e0
Modules linked in:
CPU: 1 PID: 18620 Comm: syz-executor.2 Not tainted 6.2.0-rc5-syzkaller-00047-g7c46948a6e9c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:csum_one_extent_buffer+0x416/0x4e0 fs/btrfs/disk-io.c:376
Code: ef 48 c7 c6 e0 58 39 8b 48 8b 54 24 38 4c 89 f9 49 89 d8 31 c0 e8 3a a8 24 07 41 bd 8b ff ff ff e9 e2 fe ff ff e8 5a 94 00 fe <0f> 0b e9 89 fe ff ff 89 d9 80 e1 07 38 c1 0f 8c 3b fd ff ff 48 89
RSP: 0018:ffffc90016616da0 EFLAGS: 00010287
RAX: ffffffff838b4716 RBX: fffffffffffffffa RCX: 0000000000040000
RDX: ffffc90005a61000 RSI: 0000000000035286 RDI: 0000000000035287
RBP: ffffc90016616e90 R08: ffffffff838b46b3 R09: fffff52002cc2d39
R10: fffff52002cc2d39 R11: 1ffff92002cc2d38 R12: dffffc0000000000
R13: 00000000ffffff8b R14: ffff8880759f005f R15: ffff8880759f0058
FS:  00007fb9113fe700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb909fdd718 CR3: 0000000075763000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btree_csum_one_bio+0x46a/0x6b0 fs/btrfs/disk-io.c:809
 btrfs_submit_metadata_bio+0x1a5/0x590 fs/btrfs/disk-io.c:860
 submit_one_bio+0x2f7/0x490 fs/btrfs/extent_io.c:156
 submit_write_bio fs/btrfs/extent_io.c:184 [inline]
 btree_write_cache_pages+0x18e3/0x1b90 fs/btrfs/extent_io.c:2966
 do_writepages+0x3c3/0x680 mm/page-writeback.c:2581
 filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
 btrfs_write_marked_extents+0x2b0/0x4d0 fs/btrfs/transaction.c:1091
 btrfs_sync_log+0x8e8/0x29d0 fs/btrfs/tree-log.c:2969
 btrfs_sync_file+0xe3f/0x1190 fs/btrfs/file.c:1953
 vfs_fsync_range fs/sync.c:188 [inline]
 vfs_fsync fs/sync.c:202 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:225 [inline]
 __se_sys_fdatasync fs/sync.c:223 [inline]
 __x64_sys_fdatasync+0xb1/0x100 fs/sync.c:223
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb91288c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb9113fe168 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: ffffffffffffffda RBX: 00007fb9129abf80 RCX: 00007fb91288c0c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 00007fb9128e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe9fa30b4f R14: 00007fb9113fe300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
