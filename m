Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B816EC6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjDXHW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjDXHWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:22:20 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D24330D0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:21:47 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-32b58d571a8so29038865ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320906; x=1684912906;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usj6HYRCnJfaSA1mz66e95a9Z0Dp09ieC3usS0FlO84=;
        b=F2NGeSA3q7ihYNJvg7ltlhFGYKZlU9C/gtbg58B+4NgNFSF9Ar0rrrPNLxcjdPHzhs
         APcmHLtnrpxoALwNpmd0BekFt46+JZ3qUgGWm0Asc27LCjqSGGWMIjrYji/LGO4zZElC
         UNoyCeEsCpf0WIv908TqQQx4vgWmVMxyibtRECtc7jB2bb1kwMhcugvlchswvhi6nhO8
         lOb2ueLjgpYbDSmSX6fITh/kkkzRE7img1pnhOng2WRH85RkWr63AZYhEBYGsRecKZQQ
         bAMXuuVlxlgEx32HoBaiK8Wr6AiqFXppF7pyNG7ZabEYKKdVIGELk6AP8O5OrMtkNXNC
         b+nQ==
X-Gm-Message-State: AAQBX9fnAVez2EUJyKScFYEnfvOGx4cE/YEWya8bweFqw2pDWPBRDeRi
        Dbg/WtnDVzB3PSdvodNmZiuBIVvnAjKcNTzGp0d+YJzM0jkT
X-Google-Smtp-Source: AKy350Y1IWH7s9PmHEkDUYdr5QOfurgSYL+pl9luMQB2hJAOCxAH0M72bryi1TkiP9jLwJjHXF/94aiMA4OoxeePG4CIl1R/9lqe
MIME-Version: 1.0
X-Received: by 2002:a92:d4cb:0:b0:32a:9e86:242f with SMTP id
 o11-20020a92d4cb000000b0032a9e86242fmr4594072ilm.6.1682320905932; Mon, 24 Apr
 2023 00:21:45 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:21:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff17f705fa0fdbd7@google.com>
Subject: [syzbot] [block?] KCSAN: data-race in __mod_timer / blk_add_timer (6)
From:   syzbot <syzbot+da80e6a47db00f8be22c@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    148341f0a2f5 Merge tag 'vfs.misc.fixes.v6.3-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a5970dc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54d63ee086ae78d0
dashboard link: https://syzkaller.appspot.com/bug?extid=da80e6a47db00f8be22c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1c557f92a6e1/disk-148341f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f2c85210e1ce/vmlinux-148341f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b019d0447709/bzImage-148341f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da80e6a47db00f8be22c@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __mod_timer / blk_add_timer

write to 0xffff88810285dd20 of 8 bytes by task 26833 on cpu 0:
 __mod_timer+0x625/0x890 kernel/time/timer.c:1121
 mod_timer+0x1f/0x30 kernel/time/timer.c:1190
 blk_add_timer+0x184/0x190 block/blk-timeout.c:164
 blk_mq_start_request+0x100/0x2b0 block/blk-mq.c:1264
 scsi_queue_rq+0x143b/0x1990 drivers/scsi/scsi_lib.c:1756
 blk_mq_dispatch_rq_list+0x7b1/0x11f0 block/blk-mq.c:2059
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:172 [inline]
 blk_mq_do_dispatch_sched+0x4de/0x820 block/blk-mq-sched.c:186
 __blk_mq_sched_dispatch_requests+0x1c1/0x260
 blk_mq_sched_dispatch_requests+0x93/0x100 block/blk-mq-sched.c:338
 __blk_mq_run_hw_queue+0x8e/0x110 block/blk-mq.c:2177
 __blk_mq_delay_run_hw_queue+0xb3/0x3a0 block/blk-mq.c:2253
 blk_mq_run_hw_queue+0x19f/0x330 block/blk-mq.c:2301
 blk_mq_sched_insert_requests+0x1da/0x2c0 block/blk-mq-sched.c:492
 blk_mq_dispatch_plug_list block/blk-mq.c:2748 [inline]
 blk_mq_flush_plug_list+0x519/0x660 block/blk-mq.c:2790
 __blk_flush_plug+0x223/0x280 block/blk-core.c:1153
 blk_finish_plug+0x47/0x60 block/blk-core.c:1177
 ext4_do_writepages+0x1c08/0x2140 fs/ext4/inode.c:2927
 ext4_writepages+0x127/0x250 fs/ext4/inode.c:2964
 do_writepages+0x1c5/0x340 mm/page-writeback.c:2551
 filemap_fdatawrite_wbc+0xdb/0xf0 mm/filemap.c:390
 __filemap_fdatawrite_range mm/filemap.c:423 [inline]
 file_write_and_wait_range+0xfa/0x190 mm/filemap.c:781
 ext4_sync_file+0x10d/0x720 fs/ext4/fsync.c:151
 vfs_fsync_range+0x10b/0x120 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2452 [inline]
 ext4_buffered_write_iter+0x397/0x3e0 fs/ext4/file.c:296
 ext4_file_write_iter+0xd7/0x10e0
 do_iter_write+0x418/0x700 fs/read_write.c:861
 vfs_iter_write+0x50/0x70 fs/read_write.c:902
 iter_file_splice_write+0x456/0x7d0 fs/splice.c:778
 do_splice_from fs/splice.c:856 [inline]
 direct_splice_actor+0x84/0xa0 fs/splice.c:1022
 splice_direct_to_actor+0x2ee/0x5f0 fs/splice.c:977
 do_splice_direct+0x104/0x180 fs/splice.c:1065
 do_sendfile+0x3b8/0x950 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0xbd/0x150 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88810285dd20 of 8 bytes by task 2708 on cpu 1:
 blk_add_timer+0x118/0x190
 blk_mq_start_request+0x100/0x2b0 block/blk-mq.c:1264
 scsi_queue_rq+0x143b/0x1990 drivers/scsi/scsi_lib.c:1756
 blk_mq_dispatch_rq_list+0x7b1/0x11f0 block/blk-mq.c:2059
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:172 [inline]
 blk_mq_do_dispatch_sched+0x4de/0x820 block/blk-mq-sched.c:186
 __blk_mq_sched_dispatch_requests+0x1c1/0x260
 blk_mq_sched_dispatch_requests+0x93/0x100 block/blk-mq-sched.c:338
 __blk_mq_run_hw_queue+0x8e/0x110 block/blk-mq.c:2177
 __blk_mq_delay_run_hw_queue+0xb3/0x3a0 block/blk-mq.c:2253
 blk_mq_run_hw_queue+0x19f/0x330 block/blk-mq.c:2301
 blk_mq_sched_insert_requests+0x1da/0x2c0 block/blk-mq-sched.c:492
 blk_mq_dispatch_plug_list block/blk-mq.c:2748 [inline]
 blk_mq_flush_plug_list+0x519/0x660 block/blk-mq.c:2790
 __blk_flush_plug+0x223/0x280 block/blk-core.c:1153
 blk_finish_plug+0x47/0x60 block/blk-core.c:1177
 jbd2_journal_commit_transaction+0x1c09/0x33f0 fs/jbd2/commit.c:797
 kjournald2+0x242/0x420 fs/jbd2/journal.c:209
 kthread+0x1ac/0x1e0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

value changed: 0x0000000100014674 -> 0x00000001000148f4

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 2708 Comm: jbd2/sda1-8 Not tainted 6.3.0-rc5-syzkaller-00005-g148341f0a2f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
