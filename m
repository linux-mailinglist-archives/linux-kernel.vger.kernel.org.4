Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3389E608B33
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiJVKAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJVKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:00:16 -0400
Received: from mail-il1-x148.google.com (mail-il1-x148.google.com [IPv6:2607:f8b0:4864:20::148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D3B273557
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:16:21 -0700 (PDT)
Received: by mail-il1-x148.google.com with SMTP id k4-20020a056e02156400b002fcfa0da521so5338614ilu.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4q0OymmoKB0BnPYehzovfvQN785CGdLZJJWabpm7Rw=;
        b=AwMhHluvvS5PfjEQ/SbsoII7F8E6xVM8W6cteYylmcnA0Wdm/1s66Q/gp41kCLNz7F
         NKp8y53i78TfFzJQBkWwq1GYhmcI0oWAYBKd1RW/cxmch5Tx/b17JaDuVM1tYHvy36xU
         OjPGaDamYDoho8YZmi+Xu8rlisKQVDea/Im5u6S7uzacR4rDEOs97z9Wb7feYPaVYf7x
         NITRFG2UUtpP5e26FeOD7ZN09u4LTT39T6vCtYML/dWnGt0RoW2IpcWhqY/OypxYCzwt
         Jn+In7FqEAgVZTe63z/X6IbtneOCA91Z5ekMOUnNSdzs3xWXB0n3CXGfPRsmMLomXUlT
         DRAQ==
X-Gm-Message-State: ACrzQf0oBqzN0deL4N0jcj6uWLa/KmbKFkLNN1SQA5/oESQIUMG6adN9
        FSHeZimzt1mj77i3TWc4qRBXvixOAP4Meb33n2OSG+x2Fzr1
X-Google-Smtp-Source: AMsMyM5kNo3rmk3fy+c/QG2ASHPY34bR3eizpJzi2hmk48HHTHerZLi9eRbWFlvRwlng0Lmv/NSTCbUNHNZ1yFEy8x3Z9IPTasG9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15c4:b0:2e1:986c:91a1 with SMTP id
 q4-20020a056e0215c400b002e1986c91a1mr17334243ilu.22.1666429960516; Sat, 22
 Oct 2022 02:12:40 -0700 (PDT)
Date:   Sat, 22 Oct 2022 02:12:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6fae905eb9bf51f@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in mas_leaf_max_gap
From:   syzbot <syzbot+d915173f90391a04af27@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    e35184f32151 Merge tag 'drm-fixes-2022-10-21' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1686adc2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=d915173f90391a04af27
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2700a6b41e93/disk-e35184f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5060712e0c0e/vmlinux-e35184f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d915173f90391a04af27@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in mas_leaf_max_gap+0x5b1/0x6a0 lib/maple_tree.c:1508
Read of size 8 at addr ffff888020c7d700 by task syz-executor.3/11089

CPU: 0 PID: 11089 Comm: syz-executor.3 Not tainted 6.1.0-rc1-syzkaller-00134-ge35184f32151 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 mas_leaf_max_gap+0x5b1/0x6a0 lib/maple_tree.c:1508
 mas_max_gap lib/maple_tree.c:1569 [inline]
 mab_set_b_end lib/maple_tree.c:2648 [inline]
 mas_spanning_rebalance.isra.0+0x429d/0x58a0 lib/maple_tree.c:3038
 mas_wr_spanning_store.isra.0+0x5c8/0xfc0 lib/maple_tree.c:4046
 mas_wr_store_entry.isra.0+0xb13/0xf90 lib/maple_tree.c:4388
 mas_store_prealloc+0xaf/0x150 lib/maple_tree.c:5702
 do_mas_align_munmap+0x761/0xee0 mm/mmap.c:2427
 do_mas_munmap+0x26a/0x2b0 mm/mmap.c:2501
 do_munmap+0xc3/0x100 mm/mmap.c:2515
 mremap_to mm/mremap.c:826 [inline]
 __do_sys_mremap+0x12ce/0x16b0 mm/mremap.c:972
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe25cc8b5f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe25de94168 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
RAX: ffffffffffffffda RBX: 00007fe25cdabf80 RCX: 00007fe25cc8b5f9
RDX: 0000000000004000 RSI: 00007fffdf5ca000 RDI: 0000000020a35000
RBP: 00007fe25cce67b0 R08: 0000000020a14000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe25d2dfb1f R14: 00007fe25de94300 R15: 0000000000022000
 </TASK>

Allocated by task 11089:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7e/0x80 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 kmem_cache_alloc_bulk+0x3e9/0x830 mm/slub.c:3854
 mt_alloc_bulk lib/maple_tree.c:157 [inline]
 mas_alloc_nodes+0x309/0x810 lib/maple_tree.c:1256
 mas_node_count_gfp lib/maple_tree.c:1316 [inline]
 mas_preallocate+0x1b7/0x360 lib/maple_tree.c:5719
 do_mas_align_munmap+0x11c/0xee0 mm/mmap.c:2313
 do_mas_munmap+0x26a/0x2b0 mm/mmap.c:2501
 do_munmap+0xc3/0x100 mm/mmap.c:2515
 mremap_to mm/mremap.c:826 [inline]
 __do_sys_mremap+0x12ce/0x16b0 mm/mremap.c:972
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888020c7d600
 which belongs to the cache maple_node of size 256
The buggy address is located 0 bytes to the right of
 256-byte region [ffff888020c7d600, ffff888020c7d700)

The buggy address belongs to the physical page:
page:ffffea0000831f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20c7c
head:ffffea0000831f00 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff88801184fdc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 9894, tgid 9891 (syz-executor.4), ts 753205402755, free_ts 704601241764
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4287
 __alloc_pages+0x1c7/0x5a0 mm/page_alloc.c:5554
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 kmem_cache_alloc_bulk+0x28b/0x830 mm/slub.c:3830
 mt_alloc_bulk lib/maple_tree.c:157 [inline]
 mas_alloc_nodes+0x309/0x810 lib/maple_tree.c:1256
 mas_node_count_gfp lib/maple_tree.c:1316 [inline]
 mas_preallocate+0x1b7/0x360 lib/maple_tree.c:5719
 vma_link+0xa6/0x290 mm/mmap.c:476
 copy_vma+0x4e1/0x8d0 mm/mmap.c:3230
 move_vma+0x449/0xf60 mm/mremap.c:626
 __do_sys_mremap+0x487/0x16b0 mm/mremap.c:1075
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3482
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2586
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x62/0x80 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 __kmem_cache_alloc_node+0x2da/0x3e0 mm/slub.c:3437
 kmalloc_trace+0x22/0x60 mm/slab_common.c:1046
 kmalloc include/linux/slab.h:576 [inline]
 kzalloc include/linux/slab.h:712 [inline]
 kvm_create_vm_debugfs arch/x86/kvm/../../../virt/kvm/kvm_main.c:1078 [inline]
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:1223 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:4917 [inline]
 kvm_dev_ioctl+0x1734/0x1d00 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4959
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888020c7d600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888020c7d680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888020c7d700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888020c7d780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888020c7d800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
