Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96DC661E92
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 07:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjAIGFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 01:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjAIGEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:04:47 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7642E101E3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 22:04:46 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i20-20020a056e021d1400b0030c306598c6so5407314ila.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 22:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwXJkov4Nuwt0Uq5K+NbV1smPVeIf+qHT03vxrtNAIM=;
        b=RcNYJOW5rQl5tM7re41hJx8S8fLtj56eJTWHTcqf2KBVQcw0cLQTCooFaWQB704iTe
         PjfNBIlqY2njjLutt8h526/jxIDldYFNYSHM59BJHTwfDI9H9b/Vr67y38JIXmpjAwoa
         1cXerbe1B1BqDvIFrsGm6///25k9UsumMFKfzD3igLE44eFqeC6m8E8xaqYRmh9n7n6a
         yQUN7NYxVWe5H8z9F0EXnTsHKNn2eQO50IJYdKvk/McD5myNngs85lvu5AidyyLz6TFR
         /fKfEd+88+vN27j19do/cVhxDIeb3d5MQZS0WSMTMa948Ty6nE3kmLCHWw3qBOQ6e8IH
         VhxA==
X-Gm-Message-State: AFqh2krU+eR3cDYBEd9RvfPwQ7JjV+T8B757POyeDIN8nL6IxRKVFNmo
        j3ajldNOZxvEJ2SrBKokomylBwaNdgH6fviskU3RxdYm2IS+
X-Google-Smtp-Source: AMrXdXu9TcQDTM2BeYAFBfIEHi1ASEvbKHpTbcuqTyO/+Aij0dvHZ7hjkK2K1RFij2faGwGSGDaKUneBEwI2gtOPH6TIKKxeogZ2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1a05:b0:375:6c50:ca08 with SMTP id
 cd5-20020a0566381a0500b003756c50ca08mr6784055jab.258.1673244285802; Sun, 08
 Jan 2023 22:04:45 -0800 (PST)
Date:   Sun, 08 Jan 2023 22:04:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000471f2d05f1ce8bad@google.com>
Subject: [syzbot] [jfs?] KASAN: invalid-free in dbUnmount
From:   syzbot <syzbot+6a93efb725385bc4b2e9@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, paskripkin@gmail.com, r33s3n6@gmail.com,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com,
        wuhoipok@gmail.com
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

HEAD commit:    9b43a525db12 Merge tag 'nfs-for-6.2-2' of git://git.linux-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1019e6d6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9099e39825972652
dashboard link: https://syzkaller.appspot.com/bug?extid=6a93efb725385bc4b2e9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52b3f379ea36/disk-9b43a525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc228143f117/vmlinux-9b43a525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e285dc7878c7/bzImage-9b43a525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a93efb725385bc4b2e9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in slab_free mm/slub.c:3787 [inline]
BUG: KASAN: double-free in __kmem_cache_free+0x71/0x110 mm/slub.c:3800
Free of addr ffff888086408000 by task syz-executor.4/12750

CPU: 1 PID: 12750 Comm: syz-executor.4 Not tainted 6.2.0-rc2-syzkaller-00313-g9b43a525db12 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report_invalid_free+0xac/0xd0 mm/kasan/report.c:482
 ____kasan_slab_free+0xfb/0x120
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0x71/0x110 mm/slub.c:3800
 dbUnmount+0xf4/0x110 fs/jfs/jfs_dmap.c:264
 jfs_umount+0x248/0x3b0 fs/jfs/jfs_umount.c:87
 jfs_put_super+0x86/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x130/0x310 fs/super.c:492
 kill_block_super+0x79/0xd0 fs/super.c:1386
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1291
 task_work_run+0x243/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f67a8c8d537
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffde5e59a38 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f67a8c8d537
RDX: 00007ffde5e59b09 RSI: 000000000000000a RDI: 00007ffde5e59b00
RBP: 00007ffde5e59b00 R08: 00000000ffffffff R09: 00007ffde5e598d0
R10: 00005555556328b3 R11: 0000000000000246 R12: 00007f67a8ce6b24
R13: 00007ffde5e5abc0 R14: 0000555555632810 R15: 00007ffde5e5ac00
 </TASK>

Allocated by task 13352:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 dbMount+0x54/0x980 fs/jfs/jfs_dmap.c:164
 jfs_mount+0x1dd/0x830 fs/jfs/jfs_mount.c:121
 jfs_fill_super+0x590/0xc50 fs/jfs/super.c:556
 mount_bdev+0x26c/0x3a0 fs/super.c:1359
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 13352:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0x71/0x110 mm/slub.c:3800
 dbUnmount+0xf4/0x110 fs/jfs/jfs_dmap.c:264
 jfs_mount_rw+0x545/0x740 fs/jfs/jfs_mount.c:247
 jfs_remount+0x3db/0x710 fs/jfs/super.c:454
 reconfigure_super+0x3bc/0x7b0 fs/super.c:935
 vfs_fsconfig_locked fs/fsopen.c:254 [inline]
 __do_sys_fsconfig fs/fsopen.c:439 [inline]
 __se_sys_fsconfig+0xad5/0x1060 fs/fsopen.c:314
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888086408000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 0 bytes inside of
 2048-byte region [ffff888086408000, ffff888086408800)

The buggy address belongs to the physical page:
page:ffffea0002190200 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88808640a000 pfn:0x86408
head:ffffea0002190200 order:3 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012842000 ffffea0000a69210 ffffea0000ccfc10
raw: ffff88808640a000 0000000000080006 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 6210, tgid 6210 (kworker/1:16), ts 580008526253, free_ts 579975217266
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_slab_page+0xbd/0x190 mm/slub.c:1851
 allocate_slab+0x5e/0x3c0 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x25b/0x340 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc_node_track_caller+0x9c/0x190 mm/slab_common.c:988
 kmalloc_reserve net/core/skbuff.c:492 [inline]
 __alloc_skb+0x12c/0x2c0 net/core/skbuff.c:565
 alloc_skb include/linux/skbuff.h:1270 [inline]
 alloc_skb_with_frags+0xb4/0x780 net/core/skbuff.c:6195
 sock_alloc_send_pskb+0x938/0xa70 net/core/sock.c:2741
 sock_alloc_send_skb include/net/sock.h:1888 [inline]
 mld_newpack+0x19f/0xa30 net/ipv6/mcast.c:1748
 add_grhead+0x5e/0x290 net/ipv6/mcast.c:1851
 add_grec+0x14c9/0x17c0 net/ipv6/mcast.c:1989
 mld_send_cr net/ipv6/mcast.c:2115 [inline]
 mld_ifc_work+0x68d/0xc60 net/ipv6/mcast.c:2653
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x751/0x780 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x19/0x4c0 mm/page_alloc.c:3464
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x156/0x170 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x1b3/0x350 mm/slub.c:3476
 vm_area_alloc+0x20/0xe0 kernel/fork.c:458
 mmap_region+0xd38/0x1e20 mm/mmap.c:2601
 do_mmap+0x8d9/0xf30 mm/mmap.c:1411
 vm_mmap_pgoff+0x19e/0x2b0 mm/util.c:520
 ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1457
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888086407f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888086407f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888086408000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888086408080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888086408100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
