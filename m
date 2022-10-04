Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8185F3EEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiJDIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiJDIzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:55:47 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1792C664
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:55:44 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id t21-20020a056602181500b006b3a8e8450eso104662ioh.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=InIRiMkyYwB1FDXbSqjAaras5BX3+DGjqflPWBQevuY=;
        b=Ok1cUvXKv4KkQhZQ8k7hhROG1niGo0ki3+cf/sMj+/XIa8L+JGWUpTE6tL7qUqLy0d
         KTHFmU8runUR42slN4n7ABrEbaHfk44hDZms1ji+X4f5Qh9qgkQ39tXolxgnjZRpyZvm
         heKKFH5rkdJXDbrcOToxy7WkO/xnQSjmWbeiPkgQTPvVp0SJgrnd5CDXGXH9T97FKZSD
         Ek00oPWjOoWK8Vvihgi76eBp2N02X7BYSGMNw2p7Xz2sGC4Yv2eoEtZAGxO8kfC/17qP
         9xJhLi8XkzHbHR55W524OSM3QcNjx/1ZiW7QugZqK+RGi5FIJITrEnYjtW61Fi/O98Be
         RS8g==
X-Gm-Message-State: ACrzQf2cBQGwnSyXGyDn5VVEVArzKt+nJkMumGfBJKbxNdCHbIl/oBO0
        gSh+Hu9BTABD6lZ+cHBd7HY/aHn5pi5QFjJG4B+I0cMF87D2
X-Google-Smtp-Source: AMsMyM4HHaLplSG4i+vi3iqrfsp2FzoAZTUhwaL2jrV2g3SEQOof6gHM3cF8Q2vARRwnyzUe5mLtcCU93A0kmwRxmhSWaLDpZKee
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1492:b0:35a:5484:b8db with SMTP id
 j18-20020a056638149200b0035a5484b8dbmr12167468jak.236.1664873743743; Tue, 04
 Oct 2022 01:55:43 -0700 (PDT)
Date:   Tue, 04 Oct 2022 01:55:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000177e5b05ea31a065@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in nilfs_iget_test
From:   syzbot <syzbot+cac676135771fc8f1eb2@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a962b54e162c Merge tag 'i2c-for-6.0-rc8' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a398a2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=cac676135771fc8f1eb2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7cf7771c181a/disk-a962b54e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dcd5516984d8/vmlinux-a962b54e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cac676135771fc8f1eb2@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 2048
==================================================================
BUG: KASAN: slab-out-of-bounds in nilfs_iget_test+0xa1/0x330 fs/nilfs2/inode.c:527
Read of size 8 at addr ffff88802ff0d868 by task syz-executor.4/24017

CPU: 0 PID: 24017 Comm: syz-executor.4 Not tainted 6.0.0-rc7-syzkaller-00250-ga962b54e162c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 nilfs_iget_test+0xa1/0x330 fs/nilfs2/inode.c:527
 find_inode+0x1ac/0x4c0 fs/inode.c:916
 ilookup5_nowait fs/inode.c:1429 [inline]
 ilookup5+0x9d/0x1d0 fs/inode.c:1458
 iget5_locked+0x33/0x270 fs/inode.c:1239
 nilfs_iget_locked+0x140/0x1d0 fs/nilfs2/inode.c:588
 nilfs_dat_read+0xbd/0x300 fs/nilfs2/dat.c:483
 nilfs_load_super_root fs/nilfs2/the_nilfs.c:120 [inline]
 load_nilfs+0x4c8/0xfc0 fs/nilfs2/the_nilfs.c:269
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
RIP: 0033:0x7f0f1c88bada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0f1d9a1f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0f1c88bada
RDX: 00000000200000c0 RSI: 0000000020000100 RDI: 00007f0f1d9a1fe0
RBP: 00007f0f1d9a2020 R08: 00007f0f1d9a2020 R09: 00000000200000c0
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000200000c0
R13: 0000000020000100 R14: 00007f0f1d9a1fe0 R15: 00000000200007c0
 </TASK>

Allocated by task 13367:
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
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1361
 alloc_inode fs/inode.c:260 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1287
 f2fs_iget+0x52/0x4930 fs/f2fs/inode.c:489
 f2fs_fill_super+0x5094/0x6c90 fs/f2fs/super.c:4273
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

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
 call_rcu+0x163/0x970 kernel/rcu/tree.c:2793
 dispose_list fs/inode.c:698 [inline]
 evict_inodes+0x658/0x700 fs/inode.c:748
 generic_shutdown_super+0x94/0x300 fs/super.c:480
 kill_block_super+0x79/0xd0 fs/super.c:1427
 kill_f2fs_super+0x2f9/0x3c0 fs/f2fs/super.c:4544
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
 kill_f2fs_super+0x2f9/0x3c0 fs/f2fs/super.c:4544
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

The buggy address belongs to the object at ffff88802ff0cf98
 which belongs to the cache f2fs_inode_cache of size 2136
The buggy address is located 120 bytes to the right of
 2136-byte region [ffff88802ff0cf98, ffff88802ff0d7f0)

The buggy address belongs to the physical page:
page:ffffea0000bfc200 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802ff0f2f8 pfn:0x2ff08
head:ffffea0000bfc200 order:3 compound_mapcount:0 compound_pincount:0
memcg:ffff888021ca3b01
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001429208 ffff88801bbfb708 ffff88801bfeb000
raw: ffff88802ff0f2f8 00000000000e0002 00000001ffffffff ffff888021ca3b01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 7912, tgid 7908 (syz-executor.4), ts 264814143236, free_ts 206722655579
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
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1361
 alloc_inode fs/inode.c:260 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1287
 f2fs_iget+0x52/0x4930 fs/f2fs/inode.c:489
 f2fs_fill_super+0x5094/0x6c90 fs/f2fs/super.c:4273
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
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 __free_pages_ok+0xbcd/0xcc0 mm/page_alloc.c:1705
 io_ring_ctx_free+0x846/0xaf5 io_uring/io_uring.c:2469
 io_ring_exit_work+0x650/0x6bb io_uring/io_uring.c:2628
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff88802ff0d700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ff0d780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
>ffff88802ff0d800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 00 00
                                                          ^
 ffff88802ff0d880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802ff0d900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
