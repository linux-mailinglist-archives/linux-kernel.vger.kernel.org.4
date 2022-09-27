Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A255EC026
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiI0Kwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiI0Kwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:52:41 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE66910CA72
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:52:40 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id k6-20020a92c246000000b002f80993e780so6546052ilo.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 03:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=CCI4JCWesHxQYpGABAjBNdE2vpv5Ggt3Vpj/S4NlBos=;
        b=WbF2xu+Fcuw9K/3mfPiten6mNNgV5trH5HVo+UFmwQ4XjaC/zsQKkohId2uVY2gFXw
         EHXtJaStYSGedz4uFY25z0+hX9GysGZfoavXX21iq0XHObznj79YucawDkkPdcKm4ZWq
         B3yystQBzsSqxYJ9bzFQhZCc2GGn8W29UUM7zkbZiYVQl2y1d0gXuzN7lDklasPXWhu0
         tcL0GzWAib1TBDOQ4pcEY8WYrSyfUhHrqK9XfILI5d3D2ii6G30/F27WxbaakUvE1UoT
         e1lIl99iUbIpAlf1xHE5e+B5o3IujSzK3dgk8cMVE4Fy6fkBaHOsFMwranUEkYGeIAf8
         iccQ==
X-Gm-Message-State: ACrzQf35r91FIcZLVzGT6KPFCnjpAHTDtWZQUpuAu6yqZnoveFOtCKxA
        +CVH67b7q7b9uuvDPSUYk42Zv6Csedz4w/FsRO2eIC1OUjOr
X-Google-Smtp-Source: AMsMyM5Wf1XEO/s1l//RN1/VMEdrJPip8ZZqB3cRJ/0sLuovG18a+0nOFizWpeKUOHP8Lg8vp/JAzBQa8ZV+Oi8iLhd5mYg8EtzM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:304b:b0:341:d6bc:7bd9 with SMTP id
 u11-20020a056638304b00b00341d6bc7bd9mr14624993jak.294.1664275960197; Tue, 27
 Sep 2022 03:52:40 -0700 (PDT)
Date:   Tue, 27 Sep 2022 03:52:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a789905e9a67167@google.com>
Subject: [syzbot] KASAN: use-after-free Read in register_shrinker_prepared (2)
From:   syzbot <syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    aaa11ce2ffc8 Add linux-next specific files for 20220923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=139c8540880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=ff796f04613b4c84ad89
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/95c7bf83c07e/disk-aaa11ce2.raw.xz
vmlinux: https://storage.googleapis.com/b161cd56a7a3/vmlinux-aaa11ce2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0xa5/0xb0 lib/list_debug.c:30
Read of size 8 at addr ffff88807c60b5c8 by task syz-executor.0/9090

CPU: 1 PID: 9090 Comm: syz-executor.0 Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 __list_add_valid+0xa5/0xb0 lib/list_debug.c:30
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 register_shrinker_prepared+0x37/0x120 mm/vmscan.c:695
 sget_fc+0x5e7/0x7c0 fs/super.c:581
 vfs_get_super fs/super.c:1163 [inline]
 get_tree_nodev+0x24/0x1d0 fs/super.c:1198
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f691348a669
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6914629168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f69135abf80 RCX: 00007f691348a669
RDX: 0000000020000100 RSI: 0000000020000180 RDI: 0000000000000000
RBP: 00007f69134e5560 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffda5cb705f R14: 00007f6914629300 R15: 0000000000022000
 </TASK>

Allocated by task 9062:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa1/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:934 [inline]
 __kmalloc+0x54/0xc0 mm/slab_common.c:947
 kmalloc include/linux/slab.h:564 [inline]
 kzalloc include/linux/slab.h:695 [inline]
 ops_init+0xfb/0x470 net/core/net_namespace.c:125
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:326
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:472
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3193
 __do_sys_unshare kernel/fork.c:3264 [inline]
 __se_sys_unshare kernel/fork.c:3262 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3262
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 9062:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2a/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1669 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1695
 slab_free mm/slub.c:3599 [inline]
 __kmem_cache_free+0xab/0x3b0 mm/slub.c:3612
 ops_init+0xcd/0x470 net/core/net_namespace.c:140
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:326
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:472
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3193
 __do_sys_unshare kernel/fork.c:3264 [inline]
 __se_sys_unshare kernel/fork.c:3262 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3262
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x99/0x820 kernel/rcu/tree.c:2796
 netlink_release+0xeff/0x1db0 net/netlink/af_netlink.c:815
 __sock_release net/socket.c:650 [inline]
 sock_release+0x87/0x1b0 net/socket.c:678
 netlink_kernel_release+0x4b/0x60 net/netlink/af_netlink.c:2107
 genl_pernet_exit+0x34/0x70 net/netlink/genetlink.c:1416
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:163
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:595
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x99/0x820 kernel/rcu/tree.c:2796
 netlink_release+0xeff/0x1db0 net/netlink/af_netlink.c:815
 __sock_release net/socket.c:650 [inline]
 sock_release+0x87/0x1b0 net/socket.c:678
 netlink_kernel_release+0x4b/0x60 net/netlink/af_netlink.c:2107
 rdma_dev_exit_net+0x32e/0x550 drivers/infiniband/core/device.c:1152
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:163
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:595
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88807c60b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1480 bytes inside of
 2048-byte region [ffff88807c60b000, ffff88807c60b800)

The buggy address belongs to the physical page:
page:ffffea0001f18200 refcount:1 mapcount:0 mapping:0000000000000000 index:0xdead000000000100 pfn:0x7c608
head:ffffea0001f18200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888011842000 dead000000080008 0000000000000000
raw: dead000000000100 dead000000000122 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5290, tgid 5287 (syz-executor.3), ts 351717085963, free_ts 351714173315
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x1092/0x2d20 mm/page_alloc.c:4287
 __alloc_pages+0x1c7/0x5a0 mm/page_alloc.c:5546
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1739 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1884
 new_slab mm/slub.c:1937 [inline]
 ___slab_alloc+0xac1/0x1430 mm/slub.c:3119
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3217
 slab_alloc_node mm/slub.c:3302 [inline]
 __kmem_cache_alloc_node+0x18a/0x3d0 mm/slub.c:3375
 __do_kmalloc_node mm/slab_common.c:933 [inline]
 __kmalloc+0x44/0xc0 mm/slab_common.c:947
 kmalloc include/linux/slab.h:564 [inline]
 kzalloc include/linux/slab.h:695 [inline]
 ops_init+0xfb/0x470 net/core/net_namespace.c:125
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:326
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:472
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3193
 __do_sys_unshare kernel/fork.c:3264 [inline]
 __se_sys_unshare kernel/fork.c:3262 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3262
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3482
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2532
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x62/0x80 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:754 [inline]
 slab_alloc_node mm/slub.c:3336 [inline]
 slab_alloc mm/slub.c:3344 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3351 [inline]
 kmem_cache_alloc+0x2b7/0x3d0 mm/slub.c:3360
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags+0x9a/0xe0 include/linux/audit.h:320
 vfs_fstatat+0x73/0xb0 fs/stat.c:266
 __do_sys_newfstatat+0x94/0x120 fs/stat.c:437
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807c60b480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c60b500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807c60b580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88807c60b600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c60b680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
