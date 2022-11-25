Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFC763870E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKYKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKYKHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:07:43 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9746392
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:07:41 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id o15-20020a6bf80f000000b006de313e5cfeso1857471ioh.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 02:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVDM9OykGg+MjVKeNEf9T09jbHF3MGBctxmyAKcE39g=;
        b=O6TSyae6dxmBJEnku7VvVZhaBq1NUaiCTav1++1q80vLL66r8qnR6xQRLx9aNhV6zj
         2TPVDohc4UbdtIcolXM9XI+UNmznVZRkrYp5VFgXV9By9G5p81/cgZNE9ccqOe2hqwsN
         UYNjY1VH1QYfL4qGQhI1sa+c6nVPZyL8Ji3piLY7saBNjiniwveCELbQgKTr9SOEkWY6
         25zBNMfFUgqay480L/Aih+reY4BToj7DV62PccFzrhixL0C0XtnCxyuHxm7ceLp9Sp9H
         kXhZ2vBs8LmbpB9yMiMxrzylmSXlxHsHnsYt6je4tRbLezas+/92qjy07bE3hlnXzJjT
         cLSg==
X-Gm-Message-State: ANoB5pn8hlQL7Htas9Z0EhVBZhFv0opqR55h3wvs82TEGEDQFyD0ZHRT
        1ATOeY7CkXM3SLzo65SJ0poDyW7mLUjB6VWRtxo561olVzZd
X-Google-Smtp-Source: AA0mqf48VtJk11ryjJpTQeLb8C1asT+VwVTQE71So97leD/poIZhUh4fW+R6guzVDx16bgcdDi6IsfxzcHMjXPQK70m/uZ2zgqmP
MIME-Version: 1.0
X-Received: by 2002:a02:1909:0:b0:374:837e:cc17 with SMTP id
 b9-20020a021909000000b00374837ecc17mr16377633jab.102.1669370860865; Fri, 25
 Nov 2022 02:07:40 -0800 (PST)
Date:   Fri, 25 Nov 2022 02:07:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000290d7c05ee48b10a@google.com>
Subject: [syzbot] possible deadlock in __ntfs_clear_inode
From:   syzbot <syzbot+5ebb8d0e9b8c47867596@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
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

HEAD commit:    4312098baf37 Merge tag 'spi-fix-v6.1-rc6' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16498e3d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=5ebb8d0e9b8c47867596
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7073d20a37/disk-4312098b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36a0367a5593/vmlinux-4312098b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/265bedb3086b/bzImage-4312098b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ebb8d0e9b8c47867596@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc6-syzkaller-00012-g4312098baf37 #0 Not tainted
------------------------------------------------------
kswapd0/110 is trying to acquire lock:
ffff888087920100 (&rl->lock){++++}-{3:3}, at: __ntfs_clear_inode+0x32/0x1f0 fs/ntfs/inode.c:2189

but task is already holding lock:
ffffffff8d1ff180 (fs_reclaim){+.+.}-{0:0}, at: arch_static_branch arch/x86/include/asm/jump_label.h:27 [inline]
ffffffff8d1ff180 (fs_reclaim){+.+.}-{0:0}, at: freezing include/linux/freezer.h:36 [inline]
ffffffff8d1ff180 (fs_reclaim){+.+.}-{0:0}, at: try_to_freeze include/linux/freezer.h:54 [inline]
ffffffff8d1ff180 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x109c/0x1c50 mm/vmscan.c:7098

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __fs_reclaim_acquire mm/page_alloc.c:4679 [inline]
       fs_reclaim_acquire+0x82/0x120 mm/page_alloc.c:4693
       might_alloc include/linux/sched/mm.h:271 [inline]
       prepare_alloc_pages+0x145/0x5a0 mm/page_alloc.c:5325
       __alloc_pages+0x161/0x560 mm/page_alloc.c:5544
       folio_alloc+0x1a/0x50 mm/mempolicy.c:2295
       filemap_alloc_folio+0x7e/0x1c0 mm/filemap.c:971
       do_read_cache_folio+0x28a/0x790 mm/filemap.c:3498
       do_read_cache_page mm/filemap.c:3576 [inline]
       read_cache_page+0x56/0x270 mm/filemap.c:3585
       read_mapping_page include/linux/pagemap.h:756 [inline]
       ntfs_map_page fs/ntfs/aops.h:75 [inline]
       map_mft_record_page fs/ntfs/mft.c:73 [inline]
       map_mft_record+0x1dc/0x610 fs/ntfs/mft.c:156
       ntfs_read_locked_inode+0x194/0x47c0 fs/ntfs/inode.c:550
       ntfs_iget+0x10f/0x190 fs/ntfs/inode.c:177
       ntfs_lookup+0x268/0xdb0 fs/ntfs/namei.c:117
       __lookup_slow+0x266/0x3a0 fs/namei.c:1685
       lookup_slow+0x53/0x70 fs/namei.c:1702
       walk_component+0x2e1/0x410 fs/namei.c:1993
       lookup_last fs/namei.c:2450 [inline]
       path_lookupat+0x17d/0x450 fs/namei.c:2474
       filename_lookup+0x274/0x650 fs/namei.c:2503
       user_path_at_empty+0x40/0x1a0 fs/namei.c:2876
       user_path_at include/linux/namei.h:57 [inline]
       do_sys_truncate+0x94/0x180 fs/open.c:132
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&ni->mrec_lock){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       map_mft_record+0x46/0x610 fs/ntfs/mft.c:154
       ntfs_truncate+0x24e/0x2720 fs/ntfs/inode.c:2383
       ntfs_truncate_vfs fs/ntfs/inode.c:2862 [inline]
       ntfs_setattr+0x2b9/0x3a0 fs/ntfs/inode.c:2914
       notify_change+0xe38/0x10f0 fs/attr.c:420
       do_truncate+0x1fb/0x2e0 fs/open.c:65
       vfs_truncate+0x2af/0x380 fs/open.c:111
       do_sys_truncate+0xcb/0x180 fs/open.c:134
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&rl->lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
       __ntfs_clear_inode+0x32/0x1f0 fs/ntfs/inode.c:2189
       ntfs_evict_big_inode+0x2b6/0x470 fs/ntfs/inode.c:2278
       evict+0x2a4/0x620 fs/inode.c:664
       dispose_list fs/inode.c:697 [inline]
       prune_icache_sb+0x268/0x320 fs/inode.c:896
       super_cache_scan+0x362/0x470 fs/super.c:106
       do_shrink_slab+0x4e1/0xa00 mm/vmscan.c:842
       shrink_slab_memcg+0x2ec/0x630 mm/vmscan.c:911
       shrink_slab+0xbe/0x340 mm/vmscan.c:990
       shrink_node_memcgs+0x3c3/0x770 mm/vmscan.c:6076
       shrink_node+0x299/0x1050 mm/vmscan.c:6105
       kswapd_shrink_node mm/vmscan.c:6894 [inline]
       balance_pgdat+0xec2/0x1c50 mm/vmscan.c:7084
       kswapd+0x2d5/0x590 mm/vmscan.c:7344
       kthread+0x266/0x300 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

other info that might help us debug this:

Chain exists of:
  &rl->lock --> &ni->mrec_lock --> fs_reclaim

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&ni->mrec_lock);
                               lock(fs_reclaim);
  lock(&rl->lock);

 *** DEADLOCK ***

3 locks held by kswapd0/110:
 #0: ffffffff8d1ff180 (fs_reclaim){+.+.}-{0:0}, at: arch_static_branch arch/x86/include/asm/jump_label.h:27 [inline]
 #0: ffffffff8d1ff180 (fs_reclaim){+.+.}-{0:0}, at: freezing include/linux/freezer.h:36 [inline]
 #0: ffffffff8d1ff180 (fs_reclaim){+.+.}-{0:0}, at: try_to_freeze include/linux/freezer.h:54 [inline]
 #0: ffffffff8d1ff180 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x109c/0x1c50 mm/vmscan.c:7098
 #1: ffffffff8d1d6030 (shrinker_rwsem){++++}-{3:3}, at: shrink_slab_memcg+0xd9/0x630 mm/vmscan.c:884
 #2: ffff8880289160e0 (&type->s_umount_key#71){++++}-{3:3}, at: trylock_super fs/super.c:415 [inline]
 #2: ffff8880289160e0 (&type->s_umount_key#71){++++}-{3:3}, at: super_cache_scan+0x6a/0x470 fs/super.c:79

stack backtrace:
CPU: 0 PID: 110 Comm: kswapd0 Not tainted 6.1.0-rc6-syzkaller-00012-g4312098baf37 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
 __ntfs_clear_inode+0x32/0x1f0 fs/ntfs/inode.c:2189
 ntfs_evict_big_inode+0x2b6/0x470 fs/ntfs/inode.c:2278
 evict+0x2a4/0x620 fs/inode.c:664
 dispose_list fs/inode.c:697 [inline]
 prune_icache_sb+0x268/0x320 fs/inode.c:896
 super_cache_scan+0x362/0x470 fs/super.c:106
 do_shrink_slab+0x4e1/0xa00 mm/vmscan.c:842
 shrink_slab_memcg+0x2ec/0x630 mm/vmscan.c:911
 shrink_slab+0xbe/0x340 mm/vmscan.c:990
 shrink_node_memcgs+0x3c3/0x770 mm/vmscan.c:6076
 shrink_node+0x299/0x1050 mm/vmscan.c:6105
 kswapd_shrink_node mm/vmscan.c:6894 [inline]
 balance_pgdat+0xec2/0x1c50 mm/vmscan.c:7084
 kswapd+0x2d5/0x590 mm/vmscan.c:7344
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
