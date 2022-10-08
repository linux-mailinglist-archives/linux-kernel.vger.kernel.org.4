Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126F55F8708
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 21:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJHTNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJHTNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 15:13:40 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4037FAC
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 12:13:39 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id f25-20020a5d8799000000b006a44e33ddb6so5196348ion.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 12:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JS8DSab2gZD9jS45gAgCKLRbrjCsfGKwLNCHiQZzUZM=;
        b=iQjE4s3SUsVCWKUPzPSU8o0l4Tc2C+8az0Wa+cgT0CzxZYUACaDhReHPxdX92+zC+Y
         R4GWuUdn9bZhX+gxAVmn67ca0ebM8YzxorkW6lvFMjroniRFRkfr/PRfdqql+d/cdJk8
         3OoetH6zn+Gt18uXeVnoud9D57fMU1CSeiSZAt7GwkM+ov6RKoc/Iv6pAioP1iZAlIk6
         8AvWqHxl0s81LyM/HiJ5jVX5D1LqexHMHFa9mGYFsjbU+UqcLPOFuqBacW/F31qoJf/e
         T+10tRQRLdK8eRkjR0a5j0ho8Cdf6FmjJvSTd2qAx6JQfh4dVLJ9Yykg82kbiiYIRASe
         k4CQ==
X-Gm-Message-State: ACrzQf2ekvuvEayzhqF4fQ3m3ZksL68B6dNDcYjGYMksUOMMPhUXUsXg
        7rviHIEWefl2h+70p+hmjAXk+9PKt0QcwnYajKK2003lrimv
X-Google-Smtp-Source: AMsMyM7dHhQc5CoDU2N8J8nhhnCpCNvYWVzvrz1xuAekphRbMpviwVCcBcB4cMislV+F5kVrnNPaN1DLzAA68Bg7TAA7KHBeI0Cb
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d0b:b0:35a:9936:a922 with SMTP id
 q11-20020a0566380d0b00b0035a9936a922mr5502545jaj.169.1665256418901; Sat, 08
 Oct 2022 12:13:38 -0700 (PDT)
Date:   Sat, 08 Oct 2022 12:13:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f067905ea8ab9b2@google.com>
Subject: [syzbot] possible deadlock in dquot_commit (2)
From:   syzbot <syzbot+70ff52e51b7e7714db8a@syzkaller.appspotmail.com>
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

HEAD commit:    4c86114194e6 Merge tag 'iomap-6.1-merge-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17fde8b2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9905c889cc4ad738
dashboard link: https://syzkaller.appspot.com/bug?extid=70ff52e51b7e7714db8a
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf7f1dcd539b/disk-4c861141.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c214481af743/vmlinux-4c861141.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+70ff52e51b7e7714db8a@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 4096
EXT4-fs (loop3): mounted filesystem without journal. Quota mode: writeback.
======================================================
WARNING: possible circular locking dependency detected
6.0.0-syzkaller-06475-g4c86114194e6 #0 Not tainted
------------------------------------------------------
syz-executor.3/12343 is trying to acquire lock:
ffff88802bd4bca8 (&dquot->dq_lock){+.+.}-{3:3}, at: dquot_commit+0x58/0x4e0 fs/quota/dquot.c:479

but task is already holding lock:
ffff88804c4cc8c0 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x971/0x1cc0 fs/ext4/inode.c:638

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ei->i_data_sem/2){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       down_read+0x39/0x50 kernel/locking/rwsem.c:1499
       ext4_map_blocks+0x398/0x1cc0 fs/ext4/inode.c:568
       ext4_getblk+0x1b9/0x770 fs/ext4/inode.c:858
       ext4_bread+0x2a/0x170 fs/ext4/inode.c:914
       ext4_quota_write+0x225/0x570 fs/ext4/super.c:7087
       write_blk fs/quota/quota_tree.c:64 [inline]
       get_free_dqblk+0x357/0x6a0 fs/quota/quota_tree.c:93
       do_insert_tree+0x26c/0x1a40 fs/quota/quota_tree.c:300
       do_insert_tree+0x693/0x1a40 fs/quota/quota_tree.c:331
       do_insert_tree+0x693/0x1a40 fs/quota/quota_tree.c:331
       do_insert_tree+0x693/0x1a40 fs/quota/quota_tree.c:331
       dq_insert_tree fs/quota/quota_tree.c:357 [inline]
       qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:376
       v2_write_dquot+0x11b/0x190 fs/quota/quota_v2.c:358
       dquot_acquire+0x348/0x670 fs/quota/dquot.c:444
       ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6743
       dqget+0x999/0xdc0 fs/quota/dquot.c:914
       __dquot_initialize+0x291/0xcf0 fs/quota/dquot.c:1492
       ext4_process_orphan+0x57/0x2d0 fs/ext4/orphan.c:329
       ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5520 [inline]
       ext4_fill_super+0x82e8/0x8810 fs/ext4/super.c:5648
       get_tree_bdev+0x400/0x620 fs/super.c:1323
       vfs_get_tree+0x88/0x270 fs/super.c:1530
       do_new_mount+0x289/0xad0 fs/namespace.c:3040
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&s->s_dquot.dqio_sem){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       down_read+0x39/0x50 kernel/locking/rwsem.c:1499
       v2_read_dquot+0x4a/0x100 fs/quota/quota_v2.c:332
       dquot_acquire+0x186/0x670 fs/quota/dquot.c:435
       ext4_acquire_dquot+0x2e0/0x400 fs/ext4/super.c:6743
       dqget+0x999/0xdc0 fs/quota/dquot.c:914
       __dquot_initialize+0x291/0xcf0 fs/quota/dquot.c:1492
       ext4_process_orphan+0x57/0x2d0 fs/ext4/orphan.c:329
       ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5520 [inline]
       ext4_fill_super+0x82e8/0x8810 fs/ext4/super.c:5648
       get_tree_bdev+0x400/0x620 fs/super.c:1323
       vfs_get_tree+0x88/0x270 fs/super.c:1530
       do_new_mount+0x289/0xad0 fs/namespace.c:3040
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&dquot->dq_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain+0x18c1/0x6bd0 kernel/locking/lockdep.c:3829
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5053
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       dquot_commit+0x58/0x4e0 fs/quota/dquot.c:479
       ext4_write_dquot+0x1e4/0x2b0 fs/ext4/super.c:6727
       mark_dquot_dirty fs/quota/dquot.c:346 [inline]
       mark_all_dquot_dirty fs/quota/dquot.c:384 [inline]
       __dquot_alloc_space+0xa09/0x1030 fs/quota/dquot.c:1722
       dquot_alloc_space_nodirty include/linux/quotaops.h:300 [inline]
       dquot_alloc_space include/linux/quotaops.h:313 [inline]
       dquot_alloc_block include/linux/quotaops.h:337 [inline]
       ext4_mb_new_blocks+0x106f/0x3e80 fs/ext4/mballoc.c:5573
       ext4_ext_map_blocks+0x1868/0x6880 fs/ext4/extents.c:4287
       ext4_map_blocks+0xa49/0x1cc0 fs/ext4/inode.c:645
       _ext4_get_block+0x233/0x660 fs/ext4/inode.c:802
       ext4_block_write_begin+0x6a8/0x2290 fs/ext4/inode.c:1092
       ext4_write_begin+0x5cc/0xd50
       ext4_da_write_begin+0x326/0x760 fs/ext4/inode.c:2979
       generic_perform_write+0x2a8/0x5b0 mm/filemap.c:3738
       ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
       ext4_file_write_iter+0x1d0/0x18d0
       call_write_iter include/linux/fs.h:2188 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x7dc/0xc50 fs/read_write.c:584
       ksys_write+0x177/0x2a0 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &dquot->dq_lock --> &s->s_dquot.dqio_sem --> &ei->i_data_sem/2

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/2);
                               lock(&s->s_dquot.dqio_sem);
                               lock(&ei->i_data_sem/2);
  lock(&dquot->dq_lock);

 *** DEADLOCK ***

5 locks held by syz-executor.3/12343:
 #0: ffff888020f78368 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x242/0x2e0 fs/file.c:1036
 #1: ffff88803337a460 (sb_writers#4){.+.+}-{0:0}, at: vfs_write+0x287/0xc50 fs/read_write.c:580
 #2: ffff88804c4cca38 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #2: ffff88804c4cca38 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0xae/0x3a0 fs/ext4/file.c:279
 #3: ffff88804c4cc8c0 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x971/0x1cc0 fs/ext4/inode.c:638
 #4: ffffffff8cc63528 (dquot_srcu){....}-{0:0}, at: rcu_lock_acquire+0x5/0x30 include/linux/rcupdate.h:303

stack backtrace:
CPU: 1 PID: 12343 Comm: syz-executor.3 Not tainted 6.0.0-syzkaller-06475-g4c86114194e6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain+0x18c1/0x6bd0 kernel/locking/lockdep.c:3829
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5053
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 dquot_commit+0x58/0x4e0 fs/quota/dquot.c:479
 ext4_write_dquot+0x1e4/0x2b0 fs/ext4/super.c:6727
 mark_dquot_dirty fs/quota/dquot.c:346 [inline]
 mark_all_dquot_dirty fs/quota/dquot.c:384 [inline]
 __dquot_alloc_space+0xa09/0x1030 fs/quota/dquot.c:1722
 dquot_alloc_space_nodirty include/linux/quotaops.h:300 [inline]
 dquot_alloc_space include/linux/quotaops.h:313 [inline]
 dquot_alloc_block include/linux/quotaops.h:337 [inline]
 ext4_mb_new_blocks+0x106f/0x3e80 fs/ext4/mballoc.c:5573
 ext4_ext_map_blocks+0x1868/0x6880 fs/ext4/extents.c:4287
 ext4_map_blocks+0xa49/0x1cc0 fs/ext4/inode.c:645
 _ext4_get_block+0x233/0x660 fs/ext4/inode.c:802
 ext4_block_write_begin+0x6a8/0x2290 fs/ext4/inode.c:1092
 ext4_write_begin+0x5cc/0xd50
 ext4_da_write_begin+0x326/0x760 fs/ext4/inode.c:2979
 generic_perform_write+0x2a8/0x5b0 mm/filemap.c:3738
 ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
 ext4_file_write_iter+0x1d0/0x18d0
 call_write_iter include/linux/fs.h:2188 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f54cd28a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f54ce4d3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f54cd3abf80 RCX: 00007f54cd28a5a9
RDX: 000000000208e24b RSI: 0000000020000380 RDI: 0000000000000006
RBP: 00007f54cd2e5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe81cd1cbf R14: 00007f54ce4d3300 R15: 0000000000022000
 </TASK>
fuse: Bad value for 'group_id'
syz-executor.3 (12343) used greatest stack depth: 15352 bytes left


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
