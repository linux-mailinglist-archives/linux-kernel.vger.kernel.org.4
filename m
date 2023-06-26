Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D5373E2E6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjFZPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjFZPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:11:10 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0155B1BDD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:10:45 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-341d8129ee1so27755085ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687792245; x=1690384245;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrQoPoBurrRNvwZj3zE/ypJVitI+T1fZ0yW7L4BgzJA=;
        b=B5lRNGu5zIE6Rx8THdKyvOCCzDhr4EufQ+sTsLpvtMoCaxCiRN2hBkNz7S5MB6UH60
         Rpty6qAJ3byl6YZExRxFe6h85bL3fMiS+zXqkOsi8TNkRzF/lfqGUiI73M9DVWvz5UMY
         33aD4XJC7Tccj9ecXkw2J1yAA/ZO9IKKAdwSogZxBFmfX3PdHwEhdssfKCWMy2xrpcfv
         tJlhxT1ZsvQ/+6c2ZwCYHxvU8Kazg6+8IWqH6WwbRNXVrrt6ldljdXU5o4Vih6TGM9rZ
         zebWHtsmHObH18Lvsc+8Pbyr+OyvdbnPuIWLuGdgs0xkRmDeI+Qcm6h7Fn7hSgoulLOc
         JvpQ==
X-Gm-Message-State: AC+VfDwme38pYGW8/S8V1TuP84iKCAOKREMd5pZ4EZvBBNxTwXR3TsTy
        Ea/iCRJzzWmlN3vIfGTO41lQVN9eALiwQd4DdmKvbIqTE0sO
X-Google-Smtp-Source: ACHHUZ7np46iHMIUZRkSlh1oIsTam+lRLQ9LEYON2C/fs1tYSKd4wQ3rgnUX+Alq73PhxnU+o/owRj6vMULeyg4SF1Dv1yU/Ydt2
MIME-Version: 1.0
X-Received: by 2002:a92:d40c:0:b0:345:6c50:24cc with SMTP id
 q12-20020a92d40c000000b003456c5024ccmr2885869ilm.1.1687792245239; Mon, 26 Jun
 2023 08:10:45 -0700 (PDT)
Date:   Mon, 26 Jun 2023 08:10:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b764f05ff09c1e2@google.com>
Subject: [syzbot] [mm?] possible deadlock in f2fs_file_write_iter
From:   syzbot <syzbot+b67b270114065129f12b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c87d46a9e8eb Add linux-next specific files for 20230622
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=129edf4b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d8ac8dd33677e8e0
dashboard link: https://syzkaller.appspot.com/bug?extid=b67b270114065129f12b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bdf5ea2db527/disk-c87d46a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3201e576e2ad/vmlinux-c87d46a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d011d9fa4e63/bzImage-c87d46a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b67b270114065129f12b@syzkaller.appspotmail.com

F2FS-fs (loop5): Mounted with checkpoint version = 48b305e5
======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc7-next-20230622-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.5/16876 is trying to acquire lock:
ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: percpu_ref_put include/linux/percpu-refcount.h:351 [inline]
ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: put_dev_pagemap include/linux/memremap.h:251 [inline]
ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: gup_pte_range mm/gup.c:2583 [inline]
ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: gup_pmd_range mm/gup.c:2950 [inline]
ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: gup_pud_range mm/gup.c:2978 [inline]
ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: gup_p4d_range mm/gup.c:3003 [inline]
ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: gup_pgd_range mm/gup.c:3031 [inline]
ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: lockless_pages_from_mm mm/gup.c:3084 [inline]
ffff88802a033120 (&mm->mmap_lock){++++}-{3:3}, at: internal_get_user_pages_fast+0x135f/0x3370 mm/gup.c:3133

but task is already holding lock:
ffff88808b20ea30 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2107 [inline]
ffff88808b20ea30 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_dio_write_iter fs/f2fs/file.c:4643 [inline]
ffff88808b20ea30 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_file_write_iter+0x1161/0x2500 fs/f2fs/file.c:4766

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       f2fs_down_write fs/f2fs/f2fs.h:2132 [inline]
       f2fs_setattr+0x50a/0x2090 fs/f2fs/file.c:1009
       notify_change+0xb2c/0x1180 fs/attr.c:483
       do_truncate+0x143/0x200 fs/open.c:66
       do_sys_ftruncate+0x549/0x780 fs/open.c:194
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       inode_lock include/linux/fs.h:771 [inline]
       f2fs_file_mmap+0x154/0x290 fs/f2fs/file.c:527
       call_mmap include/linux/fs.h:1876 [inline]
       mmap_region+0x6cf/0x2570 mm/mmap.c:2669
       do_mmap+0x837/0xea0 mm/mmap.c:1373
       vm_mmap_pgoff+0x1a4/0x3b0 mm/util.c:543
       ksys_mmap_pgoff+0x42b/0x5b0 mm/mmap.c:1419
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&mm->mmap_lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3142 [inline]
       check_prevs_add kernel/locking/lockdep.c:3261 [inline]
       validate_chain kernel/locking/lockdep.c:3876 [inline]
       __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
       lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5761
       internal_get_user_pages_fast+0x13c0/0x3370 mm/gup.c:3122
       pin_user_pages_fast+0xa8/0xf0 mm/gup.c:3246
       iov_iter_extract_user_pages lib/iov_iter.c:1768 [inline]
       iov_iter_extract_pages+0x293/0x18f0 lib/iov_iter.c:1831
       __bio_iov_iter_get_pages block/bio.c:1276 [inline]
       bio_iov_iter_get_pages block/bio.c:1349 [inline]
       bio_iov_iter_get_pages+0x33b/0xd50 block/bio.c:1336
       iomap_dio_bio_iter+0x82a/0x1430 fs/iomap/direct-io.c:317
       iomap_dio_iter fs/iomap/direct-io.c:430 [inline]
       __iomap_dio_rw+0x1010/0x1d80 fs/iomap/direct-io.c:575
       f2fs_dio_write_iter fs/f2fs/file.c:4657 [inline]
       f2fs_file_write_iter+0x121b/0x2500 fs/f2fs/file.c:4766
       call_write_iter include/linux/fs.h:1871 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x981/0xda0 fs/read_write.c:584
       ksys_write+0x122/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &sb->s_type->i_mutex_key#21 --> &fi->i_gc_rwsem[WRITE]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&fi->i_gc_rwsem[WRITE]);
                               lock(&sb->s_type->i_mutex_key#21);
                               lock(&fi->i_gc_rwsem[WRITE]);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

4 locks held by syz-executor.5/16876:
 #0: ffff888023d4f9c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xd7/0xf0 fs/file.c:1047
 #1: ffff8880846ac410 (sb_writers#14){.+.+}-{0:0}, at: ksys_write+0x122/0x250 fs/read_write.c:637
 #2: ffff88808b20e450 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:771 [inline]
 #2: ffff88808b20e450 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: f2fs_file_write_iter+0x297/0x2500 fs/f2fs/file.c:4744
 #3: ffff88808b20ea30 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2107 [inline]
 #3: ffff88808b20ea30 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_dio_write_iter fs/f2fs/file.c:4643 [inline]
 #3: ffff88808b20ea30 (&fi->i_gc_rwsem[WRITE]){++++}-{3:3}, at: f2fs_file_write_iter+0x1161/0x2500 fs/f2fs/file.c:4766

stack backtrace:
CPU: 0 PID: 16876 Comm: syz-executor.5 Not tainted 6.4.0-rc7-next-20230622-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x2df/0x3b0 kernel/locking/lockdep.c:2195
 check_prev_add kernel/locking/lockdep.c:3142 [inline]
 check_prevs_add kernel/locking/lockdep.c:3261 [inline]
 validate_chain kernel/locking/lockdep.c:3876 [inline]
 __lock_acquire+0x2e9d/0x5e20 kernel/locking/lockdep.c:5144
 lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5761
 internal_get_user_pages_fast+0x13c0/0x3370 mm/gup.c:3122
 pin_user_pages_fast+0xa8/0xf0 mm/gup.c:3246
 iov_iter_extract_user_pages lib/iov_iter.c:1768 [inline]
 iov_iter_extract_pages+0x293/0x18f0 lib/iov_iter.c:1831
 __bio_iov_iter_get_pages block/bio.c:1276 [inline]
 bio_iov_iter_get_pages block/bio.c:1349 [inline]
 bio_iov_iter_get_pages+0x33b/0xd50 block/bio.c:1336
 iomap_dio_bio_iter+0x82a/0x1430 fs/iomap/direct-io.c:317
 iomap_dio_iter fs/iomap/direct-io.c:430 [inline]
 __iomap_dio_rw+0x1010/0x1d80 fs/iomap/direct-io.c:575
 f2fs_dio_write_iter fs/f2fs/file.c:4657 [inline]
 f2fs_file_write_iter+0x121b/0x2500 fs/f2fs/file.c:4766
 call_write_iter include/linux/fs.h:1871 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x981/0xda0 fs/read_write.c:584
 ksys_write+0x122/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8e4728c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8e4800f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8e473abf80 RCX: 00007f8e4728c389
RDX: 000000000002a000 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f8e472d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff9aab699f R14: 00007f8e4800f300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
