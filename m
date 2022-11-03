Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF476182F1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKCPdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:33:43 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACB912618
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:33:42 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id l14-20020a056e021c0e00b00300770134f9so1802156ilh.16
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHnOEh2OfaE+q0opCACAT9L1IQD8bbfDxR+ALgErgz8=;
        b=TXsmjpyOM2nLJQWmkIC8ZnSmKxonsSHlFTNQPkR5/3beODs3D6D6O/JaShxaiZZgtw
         2w4XhImjLSD4/N1XZnc53W6syfADLHyTKcwr7xzZh2mptCL+UyeYmLkD/Wy9OoAByNmv
         l4R/IOdMxcAh4g/3wTpLVQXPZU0vpo1GH3XnKUB/GhZXZ+LzsIVYunBeAft9rWcuD7dF
         JO5e3icYbmzUdCvfLqnagY2lJstB/nn7DHnmypuLSrr/L1JvSnH3vBdMcxxxH1OfbKuQ
         8XT1VjRrRjieLr6YBDTFOV2JnwFgMhE8OxCaMPR34k6vfJ1pz6EspxcA9TjSpnmqbXMk
         mnvw==
X-Gm-Message-State: ACrzQf2B1fzWPWTEWzGe7qxB1FbpWV452gjcWSc3ee5FcxLe3vJVMuV5
        iNcQLEee4D4g1zSVw5irirN7Nzfy7N/qMhXnmNfoL6qCxRnm
X-Google-Smtp-Source: AMsMyM6sGpevv0pmUgUUqiAcdgEZLaRVimGEfXbT4A6JPA6SMo+FwUiSD2Fiwa2K8O+j/trK3n0zAYgn5gJ0XhCf6jC4mV9i0ozX
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4418:b0:375:5a8b:1425 with SMTP id
 bp24-20020a056638441800b003755a8b1425mr13563406jab.225.1667489621363; Thu, 03
 Nov 2022 08:33:41 -0700 (PDT)
Date:   Thu, 03 Nov 2022 08:33:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c543f05ec92aeee@google.com>
Subject: [syzbot] KASAN: use-after-free Read in __mark_inode_dirty
From:   syzbot <syzbot+061052676f05d48a2355@syzkaller.appspotmail.com>
To:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149134de880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=061052676f05d48a2355
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+061052676f05d48a2355@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 64
==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0x48/0x100 lib/list_debug.c:27
Read of size 8 at addr ffff88808307e7e0 by task syz-executor.4/16125

CPU: 1 PID: 16125 Comm: syz-executor.4 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 __list_add_valid+0x48/0x100 lib/list_debug.c:27
 __list_add include/linux/list.h:69 [inline]
 list_add include/linux/list.h:88 [inline]
 list_move include/linux/list.h:218 [inline]
 inode_io_list_move_locked+0x18b/0x3c0 fs/fs-writeback.c:125
 __mark_inode_dirty+0x525/0x600 fs/fs-writeback.c:2481
 fat_set_state+0x264/0x350 fs/fat/inode.c:710
 fat_fill_super+0x3768/0x4b00 fs/fat/inode.c:1882
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
RIP: 0033:0x7f546968cada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f546a3cbf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000140 RCX: 00007f546968cada
RDX: 00000000200000c0 RSI: 0000000020000080 RDI: 00007f546a3cbfe0
RBP: 00007f546a3cc020 R08: 00007f546a3cc020 R09: 00000000200000c0
R10: 0000000002010000 R11: 0000000000000202 R12: 00000000200000c0
R13: 0000000020000080 R14: 00007f546a3cbfe0 R15: 0000000020000240
 </TASK>

Allocated by task 16113:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x180/0x2e0 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3117 [inline]
 fat_alloc_inode+0x25/0xc0 fs/fat/inode.c:750
 alloc_inode fs/inode.c:259 [inline]
 new_inode_pseudo+0x61/0x1d0 fs/inode.c:1018
 new_inode+0x25/0x1d0 fs/inode.c:1046
 fat_build_inode+0x1e8/0x3e0 fs/fat/inode.c:603
 vfat_create+0x1ef/0x2e0 fs/fat/namei_vfat.c:776
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3710
 do_filp_open+0x264/0x4f0 fs/namei.c:3740
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 16108:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free+0x94/0x1d0 mm/slub.c:3683
 rcu_do_batch kernel/rcu/tree.c:2250 [inline]
 rcu_core+0x9c1/0x1690 kernel/rcu/tree.c:2510
 __do_softirq+0x277/0x738 kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:481
 call_rcu+0x163/0x9c0 kernel/rcu/tree.c:2798
 __dentry_kill+0x3b1/0x5b0 fs/dcache.c:607
 dentry_kill+0xbb/0x290
 dput+0x1f3/0x410 fs/dcache.c:913
 __fput+0x5e4/0x880 fs/file_table.c:328
 task_work_run+0x243/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:481
 call_rcu+0x163/0x9c0 kernel/rcu/tree.c:2798
 fat_put_super+0x6a/0xb0 fs/fat/inode.c:739
 generic_shutdown_super+0x130/0x310 fs/super.c:491
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:331
 cleanup_mnt+0x494/0x520 fs/namespace.c:1186
 task_work_run+0x243/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88808307e500
 which belongs to the cache fat_inode_cache of size 1488
The buggy address is located 736 bytes inside of
 1488-byte region [ffff88808307e500, ffff88808307ead0)

The buggy address belongs to the physical page:
page:ffffea00020c1e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x83078
head:ffffea00020c1e00 order:3 compound_mapcount:0 compound_pincount:0
memcg:ffff88803d4a6301
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff88801c0fb000
raw: 0000000000000000 0000000080140014 00000001ffffffff ffff88803d4a6301
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 13967, tgid 13966 (syz-executor.2), ts 779342107397, free_ts 748305958885
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4287
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5554
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc_lru+0x233/0x2e0 mm/slub.c:3429
 alloc_inode_sb include/linux/fs.h:3117 [inline]
 fat_alloc_inode+0x25/0xc0 fs/fat/inode.c:750
 alloc_inode fs/inode.c:259 [inline]
 new_inode_pseudo+0x61/0x1d0 fs/inode.c:1018
 new_inode+0x25/0x1d0 fs/inode.c:1046
 fat_fill_super+0x3278/0x4b00 fs/fat/inode.c:1847
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3482
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x1cc/0x300 mm/slub.c:3422
 getname_flags+0xb8/0x4e0 fs/namei.c:139
 user_path_at_empty+0x2a/0x1a0 fs/namei.c:2875
 do_readlinkat+0x10c/0x3d0 fs/stat.c:468
 __do_sys_readlink fs/stat.c:501 [inline]
 __se_sys_readlink fs/stat.c:498 [inline]
 __x64_sys_readlink+0x7b/0x90 fs/stat.c:498
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88808307e680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808307e700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88808307e780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff88808307e800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88808307e880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
