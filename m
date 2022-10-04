Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202775F4138
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJDK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJDK6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:58:54 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FE756033
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:58:41 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id a15-20020a6b660f000000b006a0d0794ad1so8638432ioc.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 03:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ZYSREnsnGXkBLTAeb5rbau2gCUJEzDgvUUvtIq/tHNE=;
        b=GcTAoeG62eCpZtgJ0rQFaUyYn/gJZyEVJw+es+GhQoFI6ODe8eTK+bI/zi6OvJ3O/n
         2pzYShIqxv+laoYybvGgM2qbygSlsimyD/42ON9IsP8XXIXwXO7B2Ki4y1eFHvQkd+K4
         Gv41Bnv02FHuIlNKxCa9MhWioHRo5Th7Hkpg1bYZ9uf0e22hYfG7nYkITFLpOrGMQbvZ
         6+th/sij31LrirwuDEsHnrugyNJuCtbNCDpKoqRFr3V6h9slE7W2TkuYtBxaJNyA8xDc
         /OqkwJ9hUe7d2hpj9l10k4UwkvIdsfTBrvcKDtUcOfwWVwRKVHvKJA7DNNW51mUJIbg5
         58+A==
X-Gm-Message-State: ACrzQf08l7l4JkdmqOmwk2aPiGTEHP59PmAp8NDEpSYMyLOYhygfqguW
        IAH1eHyx56qNNAfnyBtU5dPGhxo/BI1iw72EYHniz1gT8Yds
X-Google-Smtp-Source: AMsMyM4elG8XrhJGpIcoa5/PNRQRMw0ZHWuguuSWIf1x3a+SfvymX7YfQ7iB//6BGnpz7HyIL8wDv/pkfZPWMb8xf3pX8D32oKuG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cd:b0:2f9:b5d4:94b8 with SMTP id
 13-20020a056e0220cd00b002f9b5d494b8mr5208529ilq.144.1664881120612; Tue, 04
 Oct 2022 03:58:40 -0700 (PDT)
Date:   Tue, 04 Oct 2022 03:58:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9972105ea33575d@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in load_system_files
From:   syzbot <syzbot+9353cae6f83b3c2213ac@syzkaller.appspotmail.com>
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

HEAD commit:    4fe89d07dcc2 Linux 6.0
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ee62f0880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48b99eaecc2b324f
dashboard link: https://syzkaller.appspot.com/bug?extid=9353cae6f83b3c2213ac
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce1d9b74a5e0/disk-4fe89d07.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06e7c02fa7ba/vmlinux-4fe89d07.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9353cae6f83b3c2213ac@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in load_system_files+0x366e/0x4870 fs/ntfs/super.c:1833
Read of size 1 at addr ffff888028d8a659 by task syz-executor.1/19273

CPU: 1 PID: 19273 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 load_system_files+0x366e/0x4870 fs/ntfs/super.c:1833
 ntfs_fill_super+0x19a9/0x2bf0 fs/ntfs/super.c:2892
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f063968bada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f063a79ef88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f063968bada
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f063a79efe0
RBP: 00007f063a79f020 R08: 00007f063a79f020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f063a79efe0 R15: 0000000020076700
 </TASK>

Allocated by task 19259:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0xa3/0xd0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc_lru+0x175/0x2d0 mm/slub.c:3280
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 nilfs_alloc_inode+0x27/0xe0 fs/nilfs2/super.c:154
 alloc_inode fs/inode.c:260 [inline]
 iget5_locked+0x9c/0x270 fs/inode.c:1242
 nilfs_iget_locked+0x140/0x1d0 fs/nilfs2/inode.c:588
 nilfs_cpfile_read+0xb2/0x1a0 fs/nilfs2/cpfile.c:991
 nilfs_load_super_root fs/nilfs2/the_nilfs.c:125 [inline]
 load_nilfs+0x57e/0xfc0 fs/nilfs2/the_nilfs.c:269
 nilfs_fill_super+0x27e/0x5d0 fs/nilfs2/super.c:1059
 nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
 call_rcu+0x163/0x970 kernel/rcu/tree.c:2793
 nilfs_put_super+0xf1/0x150 fs/nilfs2/super.c:477
 generic_shutdown_super+0x128/0x300 fs/super.c:491
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:169
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
 call_rcu+0x163/0x970 kernel/rcu/tree.c:2793
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x658/0x700 fs/inode.c:748
 generic_shutdown_super+0x94/0x300 fs/super.c:480
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:169
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888028d8a008
 which belongs to the cache nilfs2_inode_cache of size 1512
The buggy address is located 105 bytes to the right of
 1512-byte region [ffff888028d8a008, ffff888028d8a5f0)

The buggy address belongs to the physical page:
page:ffffea0000a36200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28d88
head:ffffea0000a36200 order:3 compound_mapcount:0 compound_pincount:0
memcg:ffff88801c7ae801
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff88801bee0a00
raw: 0000000000000000 0000000000130013 00000001ffffffff ffff88801c7ae801
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5720, tgid 5719 (syz-executor.1), ts 185949110402, free_ts 183859340753
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_slab_page+0x70/0xf0 mm/slub.c:1829
 allocate_slab+0x5e/0x520 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
 __slab_alloc mm/slub.c:3123 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc_lru+0x225/0x2d0 mm/slub.c:3280
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 nilfs_alloc_inode+0x27/0xe0 fs/nilfs2/super.c:154
 alloc_inode fs/inode.c:260 [inline]
 iget5_locked+0x9c/0x270 fs/inode.c:1242
 nilfs_attach_btree_node_cache+0x2c9/0x440 fs/nilfs2/inode.c:666
 nilfs_read_inode_common+0x460/0x680 fs/nilfs2/inode.c:458
 nilfs_dat_read+0x265/0x300 fs/nilfs2/dat.c:504
 nilfs_load_super_root fs/nilfs2/the_nilfs.c:120 [inline]
 load_nilfs+0x4c8/0xfc0 fs/nilfs2/the_nilfs.c:269
 nilfs_fill_super+0x27e/0x5d0 fs/nilfs2/super.c:1059
 nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3476
 free_slab mm/slub.c:2073 [inline]
 discard_slab mm/slub.c:2079 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2553
 put_cpu_partial+0x106/0x170 mm/slub.c:2629
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x2f/0xd0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 kmem_cache_alloc_node+0x1cc/0x350 mm/slub.c:3298
 __alloc_skb+0xcf/0x2b0 net/core/skbuff.c:422
 alloc_skb_fclone include/linux/skbuff.h:1307 [inline]
 tcp_stream_alloc_skb+0x3c/0x300 net/ipv4/tcp.c:861
 tcp_sendmsg_locked+0xd70/0x40c0 net/ipv4/tcp.c:1325
 tcp_sendmsg+0x2c/0x40 net/ipv4/tcp.c:1483
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 sock_write_iter+0x3d4/0x540 net/socket.c:1108
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80

Memory state around the buggy address:
 ffff888028d8a500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888028d8a580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
>ffff888028d8a600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 00 00
                                                    ^
 ffff888028d8a680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888028d8a700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
