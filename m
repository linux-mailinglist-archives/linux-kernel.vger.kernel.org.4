Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D86749526
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 07:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjGFFzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 01:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjGFFzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 01:55:08 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED5173F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 22:55:07 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-55b406bbd77so413250a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 22:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688622907; x=1691214907;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIg/iDO/f6kUqu/EvJMZQEj+4CzFHfglGJ6DoW7xGvw=;
        b=YeMWFe5yG9IY5tfFr8OPWKysoEtJMQ5uuCcbkYKbIjlzjfX+nWPs94HwulTYg5J88h
         9J78b2UCXD4een0nINox8TsCkJlSfn/eruYN7Xn1ddd4UisN2xvmmbyEDsi5r7azMHeb
         k3r+78HYk9Es47N17HiFJSAk0TMEVB9YThYVLBFjefvhxcT/KfY0lOE0lWtVlkgi13r9
         /y8awkWHrATppc/+jBJWBpSGaOtD1Re3ZTB/EnYV6AaRl31mjORC1TCqk3WySlLHmSVq
         mpa4s8o/fUfN3GkgV4pcdj1A3X5SLwluWIQd88U3uUPKWah20mbri/1dhvuy0BKb9PQ8
         Zplw==
X-Gm-Message-State: ABy/qLYvnb53TUzY2Y0/WIJ6Kr3gh+B1LeSOYd2Zbn3aZ7tV0M73OnZt
        oDcm8j7pBpe4d7mkdy7dov2F83PCmrrkAAgwY8KpQIML95Gr
X-Google-Smtp-Source: APBJJlHUqNZXZAqqOaxjtlJyqGDWfbmLkQezpJD7kIIUhZA3wIBzwIOIoXkWuylsZGF2hKCMovaqbMG1DE83APufG7A7eidHMylO
MIME-Version: 1.0
X-Received: by 2002:a63:7112:0:b0:53f:f4c5:e81e with SMTP id
 m18-20020a637112000000b0053ff4c5e81emr460702pgc.6.1688622906867; Wed, 05 Jul
 2023 22:55:06 -0700 (PDT)
Date:   Wed, 05 Jul 2023 22:55:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086040605ffcb2856@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_slot
From:   syzbot <syzbot+ca8f1ca3255d1bac5f2f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f631fca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d787595a482d6a43
dashboard link: https://syzkaller.appspot.com/bug?extid=ca8f1ca3255d1bac5f2f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/35902c43a7c2/disk-a901a356.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78b3ce875c7d/vmlinux-a901a356.xz
kernel image: https://storage.googleapis.com/syzbot-assets/150b1474a952/bzImage-a901a356.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca8f1ca3255d1bac5f2f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in ma_data_end lib/maple_tree.c:1459 [inline]
BUG: KASAN: slab-use-after-free in mas_next_slot+0x184/0x960 lib/maple_tree.c:4725
Read of size 8 at addr ffff88804b9c5078 by task syz-executor.4/27410

CPU: 1 PID: 27410 Comm: syz-executor.4 Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 ma_data_end lib/maple_tree.c:1459 [inline]
 mas_next_slot+0x184/0x960 lib/maple_tree.c:4725
 vma_next include/linux/mm.h:865 [inline]
 validate_mm+0x3e5/0x500 mm/mmap.c:301
 do_vmi_align_munmap+0x13b1/0x15c0 mm/mmap.c:2561
 do_vmi_munmap+0x24d/0x2d0 mm/mmap.c:2619
 __vm_munmap+0x230/0x450 mm/mmap.c:2899
 __do_sys_munmap mm/mmap.c:2916 [inline]
 __se_sys_munmap mm/mmap.c:2913 [inline]
 __x64_sys_munmap+0x69/0x80 mm/mmap.c:2913
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1076e8c467
Code: 00 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1077b1af38 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1076e8c467
RDX: 0000000000040000 RSI: 0000000000040000 RDI: 00007f106d5bd000
RBP: 00007f106d5bd000 R08: 0000000000000000 R09: 00000000000004a0
R10: 0000000000040000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1077b1afdc R14: 00007f1077b1afe0 R15: 0000000020000582
 </TASK>

Allocated by task 27410:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:750
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x123/0x300 mm/slub.c:3494
 mt_alloc_one lib/maple_tree.c:159 [inline]
 mas_alloc_nodes+0x276/0x800 lib/maple_tree.c:1282
 mas_node_count_gfp lib/maple_tree.c:1362 [inline]
 mas_node_count lib/maple_tree.c:1376 [inline]
 mas_wr_node_store lib/maple_tree.c:4100 [inline]
 mas_wr_modify+0x1346/0x2290 lib/maple_tree.c:4346
 mas_store_gfp+0x30d/0x410 lib/maple_tree.c:5506
 vma_iter_clear_gfp mm/mmap.c:162 [inline]
 do_vmi_align_munmap+0xfad/0x15c0 mm/mmap.c:2538
 do_vmi_munmap+0x24d/0x2d0 mm/mmap.c:2619
 __vm_munmap+0x230/0x450 mm/mmap.c:2899
 __do_sys_munmap mm/mmap.c:2916 [inline]
 __se_sys_munmap mm/mmap.c:2913 [inline]
 __x64_sys_munmap+0x69/0x80 mm/mmap.c:2913
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 21:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook mm/slub.c:1818 [inline]
 slab_free mm/slub.c:3801 [inline]
 kmem_cache_free+0x292/0x500 mm/slub.c:3823
 rcu_do_batch kernel/rcu/tree.c:2135 [inline]
 rcu_core+0xaaa/0x1740 kernel/rcu/tree.c:2399
 __do_softirq+0x2ab/0x908 kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:491
 __call_rcu_common kernel/rcu/tree.c:2649 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2763
 mas_wr_node_store lib/maple_tree.c:4151 [inline]
 mas_wr_modify+0x1aec/0x2290 lib/maple_tree.c:4346
 mas_store_prealloc+0x313/0x650 lib/maple_tree.c:5529
 mmap_region+0x1680/0x2310 mm/mmap.c:2811
 do_mmap+0x8cf/0xf80 mm/mmap.c:1362
 vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88804b9c5000
 which belongs to the cache maple_node of size 256
The buggy address is located 120 bytes inside of
 freed 256-byte region [ffff88804b9c5000, ffff88804b9c5100)

The buggy address belongs to the physical page:
page:ffffea00012e7100 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4b9c4
head:ffffea00012e7100 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff88801324d000 ffffea0000849c00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 26971, tgid 26971 (syz-executor.1), ts 924325306641, free_ts 824783195274
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x31e8/0x3370 mm/page_alloc.c:3221
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4477
 alloc_slab_page+0x6a/0x160 mm/slub.c:1862
 allocate_slab mm/slub.c:2009 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2062
 ___slab_alloc+0xade/0x1100 mm/slub.c:3215
 __kmem_cache_alloc_bulk mm/slub.c:3966 [inline]
 kmem_cache_alloc_bulk+0x196/0x4b0 mm/slub.c:4041
 mt_alloc_bulk lib/maple_tree.c:164 [inline]
 mas_alloc_nodes+0x3df/0x800 lib/maple_tree.c:1304
 mas_node_count_gfp lib/maple_tree.c:1362 [inline]
 mas_preallocate+0x131/0x350 lib/maple_tree.c:5546
 vma_iter_prealloc mm/internal.h:1032 [inline]
 vma_expand+0x41b/0x6d0 mm/mmap.c:665
 mmap_region+0xaed/0x2310 mm/mmap.c:2711
 do_mmap+0x8cf/0xf80 mm/mmap.c:1362
 vm_mmap_pgoff+0x1db/0x410 mm/util.c:543
 ksys_mmap_pgoff+0x4ff/0x6d0 mm/mmap.c:1408
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2348
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2443
 __slab_free+0x2f6/0x390 mm/slub.c:3707
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:750
 slab_alloc_node mm/slub.c:3470 [inline]
 __kmem_cache_alloc_node+0x141/0x270 mm/slub.c:3509
 kmalloc_node_trace+0x27/0xe0 mm/slab_common.c:1089
 kmalloc_node include/linux/slab.h:595 [inline]
 kzalloc_node include/linux/slab.h:711 [inline]
 __get_vm_area_node+0x125/0x370 mm/vmalloc.c:2588
 __vmalloc_node_range+0x3df/0x1490 mm/vmalloc.c:3276
 __vmalloc_node mm/vmalloc.c:3381 [inline]
 vzalloc+0x79/0x90 mm/vmalloc.c:3454
 alloc_counters+0xd7/0x760 net/ipv4/netfilter/ip_tables.c:799
 copy_entries_to_user net/ipv6/netfilter/ip6_tables.c:837 [inline]
 get_entries net/ipv6/netfilter/ip6_tables.c:1039 [inline]
 do_ip6t_get_ctl+0xec4/0x18d0 net/ipv6/netfilter/ip6_tables.c:1669
 nf_getsockopt+0x292/0x2c0 net/netfilter/nf_sockopt.c:116
 ipv6_getsockopt+0x25d/0x380 net/ipv6/ipv6_sockglue.c:1500

Memory state around the buggy address:
 ffff88804b9c4f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804b9c4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88804b9c5000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff88804b9c5080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804b9c5100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
