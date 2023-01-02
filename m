Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D8965AF26
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjABKBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjABKAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:00:55 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05C410A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:00:53 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l14-20020a056e02066e00b0030bff7a1841so13401354ilt.23
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTn4K63RD1N7yaRtZbQN/Yyk0vdAWsKVbj+0GYE16Yg=;
        b=rqPQqlq0hvMN6N2sJU38SvYtFNnqJZFEL5w2J8b3TWLHiC8HYRUx4GulgnQsESGxrm
         otvUTHiGyHXh30MXalUy4hi5kvp904HzIJdgKptPvYaqSPzoHHLYBKlsaO1odU7QUcR1
         gnHEquSN4dghtsidhPqoXq/v2V4dGk/Xr7MFYI3vfQ4BFQknYY8L37EfZNVbt3dPZOo3
         fDhP700i/zzNCd2Ev0utbjDdOyWmhvnZ/KS7YEeFSS3KGIaWNSySf1drjElf9niEhC4R
         RtucPMh43uJlZFRZg4sXcJ1PaxXDJ6sFoJQeo1zaBJzvmK2s7peMiXdas59sZ6fLL+sI
         8WbA==
X-Gm-Message-State: AFqh2kqYKHoOOzJBs0PM7rj1DXSRVhEVTDFuGzL9u4JZMdj/p2mVFoJW
        7DdTA4XmHkzcn0VJJDZ/3cfdeXVctrXr5ur0Uh0LMtKP+H28
X-Google-Smtp-Source: AMrXdXsaBRmcxwEVRbW+gvbCLhwcch0ZIggfJak2esGuQrce59pmhA4vt7r5/Yod39KmXhlJ6QlaMfXpYL6ssM6VVat/LUHedQ3z
MIME-Version: 1.0
X-Received: by 2002:a92:c608:0:b0:30b:fc34:f96a with SMTP id
 p8-20020a92c608000000b0030bfc34f96amr2426737ilm.277.1672653653360; Mon, 02
 Jan 2023 02:00:53 -0800 (PST)
Date:   Mon, 02 Jan 2023 02:00:53 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d74cac05f1450646@google.com>
Subject: [syzbot] [jfs?] KASAN: use-after-free Read in release_metapage
From:   syzbot <syzbot+f1521383cec5f7baaa94@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        jfs-discussion@lists.sourceforge.net, jlayton@kernel.org,
        kch@nvidia.com, linux-kernel@vger.kernel.org, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2f26e424552e Merge tag 'loongarch-6.2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17152890480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4653f4fa0089644
dashboard link: https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1521383cec5f7baaa94@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in drop_metapage fs/jfs/jfs_metapage.c:223 [inline]
BUG: KASAN: use-after-free in release_metapage+0xe08/0xf00 fs/jfs/jfs_metapage.c:757
Read of size 8 at addr ffff888000d80310 by task syz-executor.1/5579

CPU: 3 PID: 5579 Comm: syz-executor.1 Not tainted 6.1.0-syzkaller-13409-g2f26e424552e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x461 mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 drop_metapage fs/jfs/jfs_metapage.c:223 [inline]
 release_metapage+0xe08/0xf00 fs/jfs/jfs_metapage.c:757
 write_metapage fs/jfs/jfs_metapage.h:75 [inline]
 flush_metapage fs/jfs/jfs_metapage.h:81 [inline]
 ea_write+0x5d6/0xc90 fs/jfs/xattr.c:280
 ea_put fs/jfs/xattr.c:610 [inline]
 __jfs_setxattr+0xead/0xfc0 fs/jfs/xattr.c:783
 __jfs_xattr_set+0xc9/0x150 fs/jfs/xattr.c:917
 __vfs_setxattr+0x173/0x1e0 fs/xattr.c:202
 __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:236
 __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:297
 vfs_setxattr+0x143/0x340 fs/xattr.c:323
 do_setxattr+0x151/0x190 fs/xattr.c:608
 setxattr+0x146/0x160 fs/xattr.c:631
 path_setxattr+0x197/0x1c0 fs/xattr.c:650
 __do_sys_setxattr fs/xattr.c:666 [inline]
 __se_sys_setxattr fs/xattr.c:662 [inline]
 __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:662
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb50cc8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb50d94f168 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007fb50cdabf80 RCX: 00007fb50cc8c0d9
RDX: 0000000020000200 RSI: 00000000200000c0 RDI: 0000000020000080
RBP: 00007fb50cce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000c001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcf4c5f19f R14: 00007fb50d94f300 R15: 0000000000022000
 </TASK>

Allocated by task 5579:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slab.c:3261 [inline]
 slab_alloc mm/slab.c:3270 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3447 [inline]
 kmem_cache_alloc+0x225/0x460 mm/slab.c:3456
 mempool_alloc+0x158/0x360 mm/mempool.c:398
 alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
 __get_metapage+0x73d/0xf00 fs/jfs/jfs_metapage.c:651
 ea_write+0x6d7/0xc90 fs/jfs/xattr.c:256
 ea_put fs/jfs/xattr.c:610 [inline]
 __jfs_setxattr+0xead/0xfc0 fs/jfs/xattr.c:783
 __jfs_xattr_set+0xc9/0x150 fs/jfs/xattr.c:917
 __vfs_setxattr+0x173/0x1e0 fs/xattr.c:202
 __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:236
 __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:297
 vfs_setxattr+0x143/0x340 fs/xattr.c:323
 do_setxattr+0x151/0x190 fs/xattr.c:608
 setxattr+0x146/0x160 fs/xattr.c:631
 path_setxattr+0x197/0x1c0 fs/xattr.c:650
 __do_sys_setxattr fs/xattr.c:666 [inline]
 __se_sys_setxattr fs/xattr.c:662 [inline]
 __x64_sys_setxattr+0xc4/0x160 fs/xattr.c:662
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5583:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 __cache_free mm/slab.c:3394 [inline]
 __do_kmem_cache_free mm/slab.c:3580 [inline]
 kmem_cache_free mm/slab.c:3605 [inline]
 kmem_cache_free+0x108/0x4c0 mm/slab.c:3598
 mempool_free+0xe7/0x3b0 mm/mempool.c:507
 free_metapage fs/jfs/jfs_metapage.c:191 [inline]
 metapage_release_folio+0x2b5/0x3c0 fs/jfs/jfs_metapage.c:551
 filemap_release_folio+0x13f/0x1b0 mm/filemap.c:3967
 shrink_folio_list+0x1ea9/0x3a60 mm/vmscan.c:2000
 shrink_inactive_list mm/vmscan.c:2526 [inline]
 shrink_list mm/vmscan.c:2767 [inline]
 shrink_lruvec+0xd0e/0x27a0 mm/vmscan.c:5951
 shrink_node_memcgs mm/vmscan.c:6138 [inline]
 shrink_node+0x8f2/0x1f40 mm/vmscan.c:6169
 shrink_zones mm/vmscan.c:6407 [inline]
 do_try_to_free_pages+0x3b4/0x17a0 mm/vmscan.c:6469
 try_to_free_pages+0x2e5/0x960 mm/vmscan.c:6704
 __perform_reclaim mm/page_alloc.c:4750 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:4772 [inline]
 __alloc_pages_slowpath.constprop.0+0x8b6/0x23d0 mm/page_alloc.c:5178
 __alloc_pages+0x4aa/0x5b0 mm/page_alloc.c:5562
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
 folio_alloc+0x20/0x70 mm/mempolicy.c:2295
 filemap_alloc_folio+0x362/0x450 mm/filemap.c:972
 __filemap_get_folio+0x32c/0xd80 mm/filemap.c:1966
 pagecache_get_page+0x2e/0x280 mm/folio-compat.c:98
 find_or_create_page include/linux/pagemap.h:612 [inline]
 grow_dev_page fs/buffer.c:946 [inline]
 grow_buffers fs/buffer.c:1011 [inline]
 __getblk_slow+0x1f4/0x1030 fs/buffer.c:1038
 __getblk_gfp+0x72/0x80 fs/buffer.c:1333
 sb_getblk include/linux/buffer_head.h:356 [inline]
 search_by_key+0x3ac/0x3bf0 fs/reiserfs/stree.c:672
 reiserfs_read_locked_inode+0x158/0x2160 fs/reiserfs/inode.c:1549
 reiserfs_fill_super+0x1273/0x2e90 fs/reiserfs/super.c:2071
 mount_bdev+0x351/0x410 fs/super.c:1359
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888000d802e8
 which belongs to the cache jfs_mp of size 184
The buggy address is located 40 bytes inside of
 184-byte region [ffff888000d802e8, ffff888000d803a0)

The buggy address belongs to the physical page:
page:ffffea0000036000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xd80
flags: 0x7ff00000000200(slab|node=0|zone=0|lastcpupid=0x7ff)
raw: 007ff00000000200 ffff888043795600 ffffea000057a090 ffffea00006b5d90
raw: 0000000000000000 ffff888000d80000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2d2000(__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_THISNODE), pid 5532, tgid 5531 (syz-executor.2), ts 318971103348, free_ts 315871259807
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x119c/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages_slowpath.constprop.0+0x36b/0x23d0 mm/page_alloc.c:5084
 __alloc_pages+0x4aa/0x5b0 mm/page_alloc.c:5562
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x94/0x390 mm/slab.c:2574
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2947
 ____cache_alloc mm/slab.c:3023 [inline]
 ____cache_alloc mm/slab.c:3006 [inline]
 __do_cache_alloc mm/slab.c:3206 [inline]
 slab_alloc_node mm/slab.c:3254 [inline]
 slab_alloc mm/slab.c:3270 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3447 [inline]
 kmem_cache_alloc+0x366/0x460 mm/slab.c:3456
 mempool_alloc+0x158/0x360 mm/mempool.c:398
 alloc_metapage fs/jfs/jfs_metapage.c:176 [inline]
 __get_metapage+0x73d/0xf00 fs/jfs/jfs_metapage.c:651
 diReadSpecial+0x191/0x6d0 fs/jfs/jfs_imap.c:443
 jfs_mount+0xd1/0x7b0 fs/jfs/jfs_mount.c:87
 jfs_fill_super+0x5a8/0xc80 fs/jfs/super.c:556
 mount_bdev+0x351/0x410 fs/super.c:1359
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x65c/0xc00 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3464
 __vunmap+0x85d/0xd30 mm/vmalloc.c:2727
 free_work+0x5c/0x80 mm/vmalloc.c:100
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888000d80200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888000d80280: fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb
>ffff888000d80300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888000d80380: fb fb fb fb fc fc fc fc fc fc fc fc fb fb fb fb
 ffff888000d80400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
