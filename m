Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEC4691881
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjBJG3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjBJG3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:29:44 -0500
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BC161874
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 22:29:42 -0800 (PST)
Received: by mail-io1-f77.google.com with SMTP id b10-20020a5ea70a000000b0071a96a509a7so2909737iod.22
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 22:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ZhHR6JAdhWWGxJjk3O0j2pj+zKTc9dlG5NWCTkMEpI=;
        b=YOAsrHo68oLVX7LqJ+amfhW0OichwegI5yaKr7IbkIwlvPIbdCNUBQ/L4pZbpPjEBq
         qYm9+TufmxAnEdeJz7eQq+qD8yqShfx+fpUimWd32POy+ISAh9tmPmzJFf1NI8/nwZjH
         6uslFf7r4HIFL8q9EcsYfmIp6LE/H8EvQCTRSGvuOFe/mBHddKQRoWkSNnStFrnhPp0A
         6UJcwgFB7Ya4C9PSCeaILyIXg0SDxgO7eVImUz1+e8U/xat+nJipdC8Uu1dWhkutI7JV
         capaZzhgmA+Zy5gsr10totNLN3m0gEeKNZtMEY1CxfTh59x4KR9/yj1ugDdf2MALxjux
         ouew==
X-Gm-Message-State: AO0yUKUYlUIuqFhLDEeCfJAV+p06PkZwWALBjzHHwZWJRuswEAN8f5KM
        x/U8BP7Cm9bf+dbr0AFNawrj57sd8orkPhT/3hitVy3Rg216
X-Google-Smtp-Source: AK7set9O96CdMvCjLMq41uuwH0p9Kx9xObUCK1hftIsFEQwcOMzmZx9SsllFqcjI0D44tok4S5UYtm6HxOt1Pu93btMA/uDuP+QY
MIME-Version: 1.0
X-Received: by 2002:a92:7d0c:0:b0:30f:5220:d4e4 with SMTP id
 y12-20020a927d0c000000b0030f5220d4e4mr8390615ilc.55.1676010582284; Thu, 09
 Feb 2023 22:29:42 -0800 (PST)
Date:   Thu, 09 Feb 2023 22:29:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065a46a05f4529f59@google.com>
Subject: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in __xfs_xattr_put_listent
From:   syzbot <syzbot+898115bc6d7140437215@syzkaller.appspotmail.com>
To:     chandan.babu@oracle.com, dchinner@redhat.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    129af7708234 Add linux-next specific files for 20230206
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15255097480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be0a3ae20dd54621
dashboard link: https://syzkaller.appspot.com/bug?extid=898115bc6d7140437215
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52d26f2badb0/disk-129af770.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/567a88b6ad33/vmlinux-129af770.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14942fd7430d/bzImage-129af770.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+898115bc6d7140437215@syzkaller.appspotmail.com

XFS (loop0): Ending clean mount
==================================================================
BUG: KASAN: slab-out-of-bounds in strscpy+0x23b/0x2a0 lib/string.c:174
Read of size 1 at addr ffff88801d145eb6 by task syz-executor.0/13785

CPU: 1 PID: 13785 Comm: syz-executor.0 Not tainted 6.2.0-rc7-next-20230206-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 strscpy+0x23b/0x2a0 lib/string.c:174
 strscpy include/linux/fortify-string.h:328 [inline]
 __xfs_xattr_put_listent+0x161/0x220 fs/xfs/xfs_xattr.c:215
 xfs_xattr_put_listent+0xed/0x1b0 fs/xfs/xfs_xattr.c:273
 xfs_attr_shortform_list fs/xfs/xfs_attr_list.c:182 [inline]
 xfs_attr_list_ilocked+0x129d/0x1940 fs/xfs/xfs_attr_list.c:516
 xfs_attr_list+0x1fb/0x2c0 fs/xfs/xfs_attr_list.c:536
 xfs_vn_listxattr+0xec/0x180 fs/xfs/xfs_xattr.c:299
 vfs_listxattr+0x109/0x190 fs/xattr.c:473
 listxattr+0x70/0x180 fs/xattr.c:820
 path_listxattr+0xae/0x140 fs/xattr.c:844
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f929808c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9298d70168 EFLAGS: 00000246 ORIG_RAX: 00000000000000c2
RAX: ffffffffffffffda RBX: 00007f92981abf80 RCX: 00007f929808c0c9
RDX: 0000000000000106 RSI: 0000000020000180 RDI: 0000000020000040
RBP: 00007f92980e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff011b791f R14: 00007f9298d70300 R15: 0000000000022000
 </TASK>

Allocated by task 13821:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_krealloc+0x142/0x180 mm/kasan/common.c:442
 kasan_krealloc include/linux/kasan.h:216 [inline]
 __do_krealloc mm/slab_common.c:1360 [inline]
 krealloc+0xa8/0x100 mm/slab_common.c:1397
 xfs_idata_realloc+0xcc/0x280 fs/xfs/libxfs/xfs_inode_fork.c:503
 xfs_attr_shortform_add+0x23b/0x930 fs/xfs/libxfs/xfs_attr_leaf.c:775
 xfs_attr_shortform_addname+0x3bf/0x610 fs/xfs/libxfs/xfs_attr.c:1158
 xfs_attr_try_sf_addname+0x6b/0x240 fs/xfs/libxfs/xfs_attr.c:358
 xfs_attr_sf_addname fs/xfs/libxfs/xfs_attr.c:383 [inline]
 xfs_attr_set_iter+0x17dd/0x3930 fs/xfs/libxfs/xfs_attr.c:719
 xfs_xattri_finish_update+0x3c/0x140 fs/xfs/xfs_attr_item.c:332
 xfs_attr_finish_item+0x6d/0x280 fs/xfs/xfs_attr_item.c:463
 xfs_defer_finish_one fs/xfs/libxfs/xfs_defer.c:479 [inline]
 xfs_defer_finish_noroll+0xac5/0x2430 fs/xfs/libxfs/xfs_defer.c:563
 __xfs_trans_commit+0x82b/0x1100 fs/xfs/xfs_trans.c:970
 xfs_attr_set+0x13ac/0x2650 fs/xfs/libxfs/xfs_attr.c:1083
 xfs_attr_change fs/xfs/xfs_xattr.c:106 [inline]
 xfs_xattr_set+0xf2/0x1c0 fs/xfs/xfs_xattr.c:151
 __vfs_setxattr+0x173/0x1e0 fs/xattr.c:203
 __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:237
 __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:298
 vfs_setxattr+0x143/0x340 fs/xattr.c:324
 do_setxattr+0x147/0x190 fs/xattr.c:609
 setxattr+0x146/0x160 fs/xattr.c:632
 path_setxattr+0x197/0x1c0 fs/xattr.c:651
 __do_sys_setxattr fs/xattr.c:667 [inline]
 __se_sys_setxattr fs/xattr.c:663 [inline]
 __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:663
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801d145e00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes to the right of
 allocated 182-byte region [ffff88801d145e00, ffff88801d145eb6)

The buggy address belongs to the physical page:
page:ffffea0000745140 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1d145
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888012441a00 ffffea0000891a00 dead000000000004
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 13038, tgid 13035 (syz-executor.2), ts 248534795000, free_ts 248133886182
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4339
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5605
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_slab_page mm/slub.c:1853 [inline]
 allocate_slab+0xa7/0x380 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x330 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0x4d/0xd0 mm/slab_common.c:974
 kmalloc_array_node include/linux/slab.h:697 [inline]
 kcalloc_node include/linux/slab.h:702 [inline]
 memcg_alloc_slab_cgroups+0x8f/0x150 mm/memcontrol.c:2893
 memcg_slab_post_alloc_hook+0xa9/0x390 mm/slab.h:546
 slab_post_alloc_hook mm/slab.h:777 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x1a7/0x320 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 alloc_buffer_head+0x24/0x150 fs/buffer.c:2947
 alloc_page_buffers+0x284/0x790 fs/buffer.c:872
 create_empty_buffers+0x30/0xf30 fs/buffer.c:1586
 ext4_block_write_begin+0x10aa/0x1780 fs/ext4/inode.c:1079
 ext4_da_write_begin+0x450/0xb70 fs/ext4/inode.c:3081
 generic_perform_write+0x256/0x570 mm/filemap.c:3770
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3401 [inline]
 free_unref_page_list+0x176/0xcd0 mm/page_alloc.c:3542
 release_pages+0xcb1/0x1330 mm/swap.c:1072
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x205/0x7d0 mm/mmap.c:3047
 __mmput+0x128/0x4c0 kernel/fork.c:1209
 mmput+0x60/0x70 kernel/fork.c:1231
 exit_mm kernel/exit.c:563 [inline]
 do_exit+0x9d7/0x2b60 kernel/exit.c:856
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1019
 get_signal+0x2321/0x25b0 kernel/signal.c:2859
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801d145d80: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801d145e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88801d145e80: 00 00 00 00 00 00 06 fc fc fc fc fc fc fc fc fc
                                     ^
 ffff88801d145f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801d145f80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
