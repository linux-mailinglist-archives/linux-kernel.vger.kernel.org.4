Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8312773D719
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFZFMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjFZFMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:12:10 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F4A113
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 22:12:09 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-78335dcde31so190787439f.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 22:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687756328; x=1690348328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yscyR8Hig7n9E+ddOY2GFgin+ZvWyOrz2srW+Ng7bOM=;
        b=kjqNsoyM3xYav/Yffjf9UdL0OCLk54lFYzVNnJ4p15Tg0vKjJiP+VsQ5cQA1ty9p/a
         euwuq+FbaXU8KwXuZlBhjgjNAQV+Ltp7D7l82oEMgp29JEad+jVDU5HNaXzQ0MEhrmh4
         T436zIwEdN+nexd+FIZ32Hp5gwtNGsCaKqIK4x6F+XpCa7WX1RS2f1rQMuc3WOntrIvG
         DIRInAIflBb9FZ49M/VINnCm1JfAVula9mqgOGNXUjgO04Hu8pZ62yybC/m2jW5Wst8a
         wxXe00d5Y6LRjPnTm7yNK7cknJcky3SSsN5NzwAFxMw/bbEtTGIkLo6XkqQACpYwkzll
         UUDw==
X-Gm-Message-State: AC+VfDzTWbr1K6OXOx0aHlK8RRef3te4kVAxa/AiPRsIhn94EEkBWZ8S
        UFaIAm/qof1LWkVikNnnLkoByD48RehR+9Y6nBlqJpl4/Phe
X-Google-Smtp-Source: ACHHUZ78MHgT6pCgdnFz514NVW6eUiyEO26tNYdIbq0tLR8yld88usYFirOErpH1r7GyWA4phXSoBM5pQ0QnxboWWxkvLZCuuvCh
MIME-Version: 1.0
X-Received: by 2002:a02:95a2:0:b0:420:f404:40b6 with SMTP id
 b31-20020a0295a2000000b00420f40440b6mr9235716jai.1.1687756328299; Sun, 25 Jun
 2023 22:12:08 -0700 (PDT)
Date:   Sun, 25 Jun 2023 22:12:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a70e605ff0164a1@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable
From:   syzbot <syzbot+0b6dd551c9c1b573dc28@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    dbad9ce9397e Merge tag 'afs-fixes-20230719' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c608eb280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=24ce1b2abaee24cc
dashboard link: https://syzkaller.appspot.com/bug?extid=0b6dd551c9c1b573dc28
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-dbad9ce9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f5483bdad76/vmlinux-dbad9ce9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/87292ebcdd16/bzImage-dbad9ce9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b6dd551c9c1b573dc28@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-use-after-free in mapping_unevictable include/linux/pagemap.h:249 [inline]
BUG: KASAN: slab-use-after-free in folio_evictable+0x85/0x270 mm/internal.h:156
Read of size 8 at addr ffff88802c2c1ef0 by task kswapd0/110

CPU: 0 PID: 110 Comm: kswapd0 Not tainted 6.4.0-rc7-syzkaller-00003-gdbad9ce9397e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_unevictable include/linux/pagemap.h:249 [inline]
 folio_evictable+0x85/0x270 mm/internal.h:156
 sort_folio mm/vmscan.c:4882 [inline]
 scan_folios mm/vmscan.c:4999 [inline]
 isolate_folios+0x668/0x3830 mm/vmscan.c:5115
 evict_folios+0x191/0x1940 mm/vmscan.c:5146
 try_to_shrink_lruvec+0x82c/0xb90 mm/vmscan.c:5334
 shrink_one+0x462/0x710 mm/vmscan.c:5378
 shrink_many mm/vmscan.c:5430 [inline]
 lru_gen_shrink_node mm/vmscan.c:5547 [inline]
 shrink_node+0x1fd5/0x3500 mm/vmscan.c:6488
 kswapd_shrink_node mm/vmscan.c:7288 [inline]
 balance_pgdat+0xa02/0x1ac0 mm/vmscan.c:7478
 kswapd+0x677/0xd60 mm/vmscan.c:7738
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 17651:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slab.c:3256 [inline]
 slab_alloc mm/slab.c:3265 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3442 [inline]
 kmem_cache_alloc+0x14e/0x3f0 mm/slab.c:3451
 gfs2_glock_get+0x203/0x12f0 fs/gfs2/glock.c:1167
 gfs2_inode_lookup+0x258/0x8a0 fs/gfs2/inode.c:135
 gfs2_dir_search+0x213/0x2d0 fs/gfs2/dir.c:1664
 gfs2_lookupi+0x481/0x640 fs/gfs2/inode.c:332
 gfs2_jindex_hold fs/gfs2/ops_fstype.c:609 [inline]
 init_journal fs/gfs2/ops_fstype.c:751 [inline]
 init_inodes+0x768/0x2b60 fs/gfs2/ops_fstype.c:886
 gfs2_fill_super+0x1a7b/0x2b20 fs/gfs2/ops_fstype.c:1250
 get_tree_bdev+0x44a/0x770 fs/super.c:1303
 gfs2_get_tree+0x4e/0x270 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x7b/0x90 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2627
 gfs2_glock_free+0x6f3/0x10f0 fs/gfs2/glock.c:177
 gfs2_glock_put+0x33/0x40 fs/gfs2/glock.c:307
 gfs2_glock_put_eventually fs/gfs2/super.c:1185 [inline]
 gfs2_evict_inode+0x5cd/0x1c60 fs/gfs2/super.c:1467
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x50a/0x740 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 gfs2_jindex_free+0x391/0x560 fs/gfs2/super.c:75
 init_journal fs/gfs2/ops_fstype.c:868 [inline]
 init_inodes+0x1202/0x2b60 fs/gfs2/ops_fstype.c:886
 gfs2_fill_super+0x1a7b/0x2b20 fs/gfs2/ops_fstype.c:1250
 get_tree_bdev+0x44a/0x770 fs/super.c:1303
 gfs2_get_tree+0x4e/0x270 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x7b/0x90 mm/kasan/generic.c:491
 insert_work+0x48/0x360 kernel/workqueue.c:1365
 __queue_work+0x625/0x1120 kernel/workqueue.c:1526
 __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1674
 queue_delayed_work_on+0x109/0x120 kernel/workqueue.c:1710
 queue_delayed_work include/linux/workqueue.h:520 [inline]
 __gfs2_glock_queue_work+0x2a/0xb0 fs/gfs2/glock.c:252
 gfs2_glock_queue_work fs/gfs2/glock.c:266 [inline]
 do_xmote+0x98b/0xd70 fs/gfs2/glock.c:801
 run_queue+0x3cf/0x660 fs/gfs2/glock.c:844
 glock_work_func+0xc2/0x3b0 fs/gfs2/glock.c:1076
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88802c2c1a90
 which belongs to the cache gfs2_glock(aspace) of size 1224
The buggy address is located 1120 bytes inside of
 freed 1224-byte region [ffff88802c2c1a90, ffff88802c2c1f58)

The buggy address belongs to the physical page:
page:ffffea0000b0b040 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802c2c1ffd pfn:0x2c2c1
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x0()
raw: 00fff00000000200 ffff88801c906900 ffff88801c931960 ffff88801c931960
raw: ffff88802c2c1ffd ffff88802c2c1000 0000000100000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x342040(__GFP_IO|__GFP_NOWARN|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 17078, tgid 17076 (syz-executor.1), ts 1862668640369, free_ts 1862613844099
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1360 [inline]
 cache_grow_begin+0x9b/0x3b0 mm/slab.c:2569
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
 ____cache_alloc mm/slab.c:3018 [inline]
 ____cache_alloc mm/slab.c:3001 [inline]
 __do_cache_alloc mm/slab.c:3201 [inline]
 slab_alloc_node mm/slab.c:3249 [inline]
 slab_alloc mm/slab.c:3265 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3442 [inline]
 kmem_cache_alloc+0x397/0x3f0 mm/slab.c:3451
 gfs2_glock_get+0x203/0x12f0 fs/gfs2/glock.c:1167
 gfs2_inode_lookup+0x258/0x8a0 fs/gfs2/inode.c:135
 gfs2_dir_search+0x213/0x2d0 fs/gfs2/dir.c:1664
 gfs2_lookupi+0x481/0x640 fs/gfs2/inode.c:332
 gfs2_jindex_hold fs/gfs2/ops_fstype.c:609 [inline]
 init_journal fs/gfs2/ops_fstype.c:751 [inline]
 init_inodes+0x768/0x2b60 fs/gfs2/ops_fstype.c:886
 gfs2_fill_super+0x1a7b/0x2b20 fs/gfs2/ops_fstype.c:1250
 get_tree_bdev+0x44a/0x770 fs/super.c:1303
 gfs2_get_tree+0x4e/0x270 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x8d/0x350 fs/super.c:1510
 do_new_mount fs/namespace.c:3039 [inline]
 path_mount+0x134b/0x1e40 fs/namespace.c:3369
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2564
 free_unref_page+0x33/0x370 mm/page_alloc.c:2659
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0xc5/0x140 mm/swap.c:129
 folio_put include/linux/mm.h:1430 [inline]
 put_page include/linux/mm.h:1499 [inline]
 free_page_and_swap_cache+0x257/0x2c0 mm/swap_state.c:305
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:153 [inline]
 tlb_remove_table_rcu+0x89/0xe0 mm/mmu_gather.c:208
 rcu_do_batch kernel/rcu/tree.c:2115 [inline]
 rcu_core+0x806/0x1ad0 kernel/rcu/tree.c:2377
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571

Memory state around the buggy address:
 ffff88802c2c1d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802c2c1e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802c2c1e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                             ^
 ffff88802c2c1f00: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
 ffff88802c2c1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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
