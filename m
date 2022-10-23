Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767AF60919D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 09:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJWH0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 03:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJWH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 03:26:33 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211635F98B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:26:32 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x6-20020a056e021bc600b002fc96f780e7so6807699ilv.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5d7+siGxW6EZq/Nh8Y0g59tpTA0sw2fz1ur+quuZuI=;
        b=3mwb5Wb7Xw9BbEZ4I/rA1PKj0z8Y5JgXu7VWrWgVhouG8VQwDsKi/bIaQaH8rgwlCu
         cbzl7z2pgeY3+AMTwz0gP5c+BhHaeoXNlgfaizxPz73ZXF7V/iPkDJB8qCELnrxlpB+e
         QcNv5TTCQF+V0oi55TjklgaH6bkAwnJ6WDHsL22sMhCJHVgELJ/4cb463x+K76UTYOyL
         +KldOiDHbpxYq+FI9tkHbFst0QSgngSGNq49CoThZe+BSvrNIng6eRAoRliChTy1XRlf
         7R8BNuGvWVZUu7VkDrpz8P1FI7myBwX6qdmL1ttbektcUjgGvr6TP6PUvJVH7N3z55vu
         vq3g==
X-Gm-Message-State: ACrzQf2e1g+H+wH3HIQMHWpDPKKgCaAfmmoUCDe2vZr0/U7r6lJEzM9q
        TD0E9tGVQKx704iSilx9dld1nJaI63P1ijKPulmTMRQ5IHAI
X-Google-Smtp-Source: AMsMyM7BV42Pj0Jifp9osXhoPIfTHnd3/rVwq8w82KUO3HubtRiilY4HBCxH71aC47FNGCJ5Juo0iPl9dDw9wJlAp6vPVjG+CONA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2a:b0:2fc:2163:5072 with SMTP id
 g10-20020a056e021a2a00b002fc21635072mr17477466ile.121.1666509991498; Sun, 23
 Oct 2022 00:26:31 -0700 (PDT)
Date:   Sun, 23 Oct 2022 00:26:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000eda7a05ebae986e@google.com>
Subject: [syzbot] KASAN: use-after-free Read in hugetlb_fault
From:   syzbot <syzbot+1b27d7a2722eabc2c5d5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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

HEAD commit:    bb1a1146467a Merge tag 'cgroup-for-6.1-rc1-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f38cc2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=972ee691c428ae39
dashboard link: https://syzkaller.appspot.com/bug?extid=1b27d7a2722eabc2c5d5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b27d7a2722eabc2c5d5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
BUG: KASAN: use-after-free in is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
BUG: KASAN: use-after-free in __down_read_common kernel/locking/rwsem.c:1262 [inline]
BUG: KASAN: use-after-free in __down_read_common kernel/locking/rwsem.c:1255 [inline]
BUG: KASAN: use-after-free in __down_read kernel/locking/rwsem.c:1269 [inline]
BUG: KASAN: use-after-free in down_read+0x1d3/0x450 kernel/locking/rwsem.c:1511
Read of size 8 at addr ffff88801eabdc08 by task syz-executor.2/4171

CPU: 0 PID: 4171 Comm: syz-executor.2 Not tainted 6.1.0-rc1-syzkaller-00010-gbb1a1146467a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x461 mm/kasan/report.c:395
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
 is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
 __down_read_common kernel/locking/rwsem.c:1262 [inline]
 __down_read_common kernel/locking/rwsem.c:1255 [inline]
 __down_read kernel/locking/rwsem.c:1269 [inline]
 down_read+0x1d3/0x450 kernel/locking/rwsem.c:1511
 hugetlb_vma_lock_read mm/hugetlb.c:6797 [inline]
 hugetlb_fault+0x40a/0x2060 mm/hugetlb.c:5840
 follow_hugetlb_page+0x3f3/0x1850 mm/hugetlb.c:6282
 __get_user_pages+0x2cb/0xf10 mm/gup.c:1202
 populate_vma_page_range+0x23d/0x320 mm/gup.c:1587
 __mm_populate+0x101/0x3a0 mm/gup.c:1701
 mm_populate include/linux/mm.h:2744 [inline]
 vm_mmap_pgoff+0x1fd/0x270 mm/util.c:525
 ksys_mmap_pgoff+0x1c3/0x5a0 mm/mmap.c:1457
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f07e488b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f07e59e7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f07e49abf80 RCX: 00007f07e488b5a9
RDX: 0000000000000003 RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007f07e48e6580 R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000068831 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc053fba9f R14: 00007f07e59e7300 R15: 0000000000022000
 </TASK>

Allocated by task 4171:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0x9f/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:576 [inline]
 hugetlb_vma_lock_alloc.part.0+0x3f/0x130 mm/hugetlb.c:6907
 hugetlb_vma_lock_alloc mm/hugetlb.c:6663 [inline]
 hugetlb_reserve_pages+0xa3f/0xe80 mm/hugetlb.c:6532
 hugetlbfs_file_mmap+0x40c/0x5c0 fs/hugetlbfs/inode.c:167
 call_mmap include/linux/fs.h:2196 [inline]
 mmap_region+0x6bf/0x1bf0 mm/mmap.c:2624
 do_mmap+0x825/0xf50 mm/mmap.c:1411
 vm_mmap_pgoff+0x1ab/0x270 mm/util.c:520
 ksys_mmap_pgoff+0x1c3/0x5a0 mm/mmap.c:1457
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 4172:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x13b/0x1a0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 __cache_free mm/slab.c:3389 [inline]
 __do_kmem_cache_free mm/slab.c:3585 [inline]
 __kmem_cache_free+0xc9/0x3a0 mm/slab.c:3592
 hugetlb_vma_lock_release mm/hugetlb.c:6852 [inline]
 kref_put include/linux/kref.h:65 [inline]
 __hugetlb_vma_unlock_write_put mm/hugetlb.c:6867 [inline]
 __hugetlb_vma_unlock_write_free mm/hugetlb.c:6875 [inline]
 __unmap_hugepage_range_final+0x2ad/0x340 mm/hugetlb.c:5196
 unmap_single_vma+0x23d/0x2a0 mm/memory.c:1690
 zap_page_range+0x38a/0x520 mm/memory.c:1762
 madvise_dontneed_single_vma mm/madvise.c:793 [inline]
 madvise_dontneed_free mm/madvise.c:876 [inline]
 madvise_vma_behavior+0xee8/0x1cc0 mm/madvise.c:1015
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
 do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
 do_madvise mm/madvise.c:1432 [inline]
 __do_sys_madvise mm/madvise.c:1432 [inline]
 __se_sys_madvise mm/madvise.c:1430 [inline]
 __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x7b/0x90 mm/kasan/generic.c:481
 insert_work+0x48/0x350 kernel/workqueue.c:1358
 __queue_work+0x693/0x13b0 kernel/workqueue.c:1517
 queue_work_on+0xee/0x110 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:659 [inline]
 netdevice_event+0x42e/0x8b0 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1945
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 dev_set_mac_address+0x2d3/0x3d0 net/core/dev.c:8799
 dev_set_mac_address_user+0x2d/0x50 net/core/dev.c:8813
 do_setlink+0x18c4/0x3bb0 net/core/rtnetlink.c:2736
 __rtnl_newlink+0xd6a/0x17e0 net/core/rtnetlink.c:3547
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3594
 rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6091
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2540
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 __sys_sendto+0x236/0x340 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x7b/0x90 mm/kasan/generic.c:481
 insert_work+0x48/0x350 kernel/workqueue.c:1358
 __queue_work+0x693/0x13b0 kernel/workqueue.c:1517
 queue_work_on+0xee/0x110 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 netdevice_queue_work drivers/infiniband/core/roce_gid_mgmt.c:659 [inline]
 netdevice_event+0x42e/0x8b0 drivers/infiniband/core/roce_gid_mgmt.c:802
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1945
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 register_netdevice+0x10bb/0x1670 net/core/dev.c:10086
 veth_newlink+0x4cf/0x990 drivers/net/veth.c:1795
 rtnl_newlink_create net/core/rtnetlink.c:3364 [inline]
 __rtnl_newlink+0x1087/0x17e0 net/core/rtnetlink.c:3581
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3594
 rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6091
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2540
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x543/0x7f0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x917/0xe10 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 __sys_sendto+0x236/0x340 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xdd/0x1b0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801eabdc00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 8 bytes inside of
 192-byte region [ffff88801eabdc00, ffff88801eabdcc0)

The buggy address belongs to the physical page:
page:ffffea00007aaf40 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801eabd300 pfn:0x1eabd
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea000049dd88 ffffea00005410c8 ffff888011840000
raw: ffff88801eabd300 ffff88801eabd000 000000010000000f 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 1, tgid 1 (swapper/0), ts 20597218826, free_ts 18377230336
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4287
 __alloc_pages+0x1c7/0x5a0 mm/page_alloc.c:5554
 __alloc_pages_node include/linux/gfp.h:223 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x75/0x360 mm/slab.c:2570
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2943
 ____cache_alloc mm/slab.c:3019 [inline]
 ____cache_alloc mm/slab.c:3002 [inline]
 __do_cache_alloc mm/slab.c:3202 [inline]
 slab_alloc_node mm/slab.c:3250 [inline]
 __kmem_cache_alloc_node+0x442/0x500 mm/slab.c:3549
 kmalloc_trace+0x22/0x60 mm/slab_common.c:1046
 kmalloc include/linux/slab.h:576 [inline]
 kzalloc include/linux/slab.h:712 [inline]
 mon_bus_init+0x45/0x320 drivers/usb/mon/mon_main.c:287
 mon_bus_add drivers/usb/mon/mon_main.c:199 [inline]
 mon_notify+0x32c/0x490 drivers/usb/mon/mon_main.c:230
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 blocking_notifier_call_chain kernel/notifier.c:382 [inline]
 blocking_notifier_call_chain+0x67/0x90 kernel/notifier.c:370
 usb_register_bus drivers/usb/core/hcd.c:935 [inline]
 usb_add_hcd.cold+0x3bb/0x13a1 drivers/usb/core/hcd.c:2877
 vhci_hcd_probe+0x1c4/0x390 drivers/usb/usbip/vhci_hcd.c:1376
 platform_probe+0xfc/0x1f0 drivers/base/platform.c:1400
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3482
 __folio_put_small mm/swap.c:105 [inline]
 __folio_put+0xc1/0x130 mm/swap.c:128
 folio_put include/linux/mm.h:1159 [inline]
 put_page include/linux/mm.h:1211 [inline]
 free_page_and_swap_cache+0x253/0x2c0 mm/swap_state.c:299
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:115 [inline]
 tlb_remove_table_rcu+0x85/0xe0 mm/mmu_gather.c:170
 rcu_do_batch kernel/rcu/tree.c:2248 [inline]
 rcu_core+0x81f/0x1980 kernel/rcu/tree.c:2508
 __do_softirq+0x1f7/0xad8 kernel/softirq.c:571

Memory state around the buggy address:
 ffff88801eabdb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801eabdb80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801eabdc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88801eabdc80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88801eabdd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
