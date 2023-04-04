Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46F16D5A46
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjDDIFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjDDIFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:05:52 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC06B19A4
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:05:50 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id b2-20020a6bcb02000000b0075e09ef5a2eso5636958iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 01:05:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680595550; x=1683187550;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T6jDXg14tdNXMaozTiUp25YezqCZpNnf/RIHYsW52LA=;
        b=OjSxlKaPPHRvni4wd9cPvE5rWFo1gQC0Nw9S2JOpyT0GzXTM8kiTLdVjqkmj1e7QQn
         c99RU9znUtCt1EEe7aQd3PKw7mfm37+A15P10uqLqNumyndKx1R6KHsy54bZcISdb9BI
         m92cR528Ea7rmodAT3jOBowGrKhFYVjZ2+yYva26QoIFpU4fgWhoOypm4mdTgCWSvptv
         gAzyVgsO5QGT/tIXpx7uZ1GCKOVzPK/z5im3w7LnRVx7VSZnYkIXZ8sScmurpw1mEfTD
         /aRN1sjZBPXWZdfI7/k/SaFOChOUk1JKltOCD06vAwgfYxdczs9ExxLCZNhwkshBWpLI
         fiIQ==
X-Gm-Message-State: AAQBX9f8ttlA8O0+/ZJ47dPwUiX0ixZ8CxQpKnFiC7VBGWiUSgOncTWZ
        FvXzgajaohQNopvS4qsTNdovrFC46ZGXQYeHjldzFPtR1NkO
X-Google-Smtp-Source: AKy350YKU1K5jV5orkVbm5HYH3kwRULxOLYTYOi35mQGf9z7MCwVevHdRRhenTzQiHR3mnRp08/80tL+3v/hdulb+g2IVhidqHig
MIME-Version: 1.0
X-Received: by 2002:a02:94e7:0:b0:3ae:e73b:ff26 with SMTP id
 x94-20020a0294e7000000b003aee73bff26mr1051157jah.1.1680595550287; Tue, 04 Apr
 2023 01:05:50 -0700 (PDT)
Date:   Tue, 04 Apr 2023 01:05:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c93feb05f87e24ad@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_entry
From:   syzbot <syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    148341f0a2f5 Merge tag 'vfs.misc.fixes.v6.3-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11fcd0c9c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3500b143c204867
dashboard link: https://syzkaller.appspot.com/bug?extid=a7c1ec5b1d71ceaa5186
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5c6c5ea510a3/disk-148341f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ad4974cdfb7/vmlinux-148341f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a705a56e3f96/bzImage-148341f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mas_safe_min lib/maple_tree.c:727 [inline]
BUG: KASAN: slab-use-after-free in mas_next_nentry lib/maple_tree.c:4664 [inline]
BUG: KASAN: slab-use-after-free in mas_next_entry+0x12b3/0x1690 lib/maple_tree.c:4760
Read of size 8 at addr ffff888040743e20 by task syz-executor.3/2734

CPU: 0 PID: 2734 Comm: syz-executor.3 Not tainted 6.3.0-rc5-syzkaller-00005-g148341f0a2f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 mas_safe_min lib/maple_tree.c:727 [inline]
 mas_next_nentry lib/maple_tree.c:4664 [inline]
 mas_next_entry+0x12b3/0x1690 lib/maple_tree.c:4760
 mas_find+0x7d/0x200 lib/maple_tree.c:6025
 vma_find include/linux/mm.h:736 [inline]
 __do_sys_set_mempolicy_home_node+0x1ef/0x480 mm/mempolicy.c:1524
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff7fde8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff7fecbd168 EFLAGS: 00000246 ORIG_RAX: 00000000000001c2
RAX: ffffffffffffffda RBX: 00007ff7fdfabf80 RCX: 00007ff7fde8c169
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffd000
RBP: 00007ff7fdee7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff7fe0cfb1f R14: 00007ff7fecbd300 R15: 0000000000022000
 </TASK>

Allocated by task 5125:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x424/0x860 mm/slub.c:4034
 mt_alloc_bulk lib/maple_tree.c:164 [inline]
 mas_alloc_nodes+0x276/0x8a0 lib/maple_tree.c:1263
 mas_node_count_gfp+0x106/0x140 lib/maple_tree.c:1318
 mas_node_count lib/maple_tree.c:1332 [inline]
 mas_expected_entries+0x117/0x200 lib/maple_tree.c:5828
 vma_iter_bulk_alloc include/linux/mm.h:765 [inline]
 dup_mmap+0x4f3/0x1230 kernel/fork.c:616
 dup_mm kernel/fork.c:1545 [inline]
 copy_mm kernel/fork.c:1594 [inline]
 copy_process+0x7082/0x7590 kernel/fork.c:2264
 kernel_clone+0xeb/0x890 kernel/fork.c:2679
 __do_sys_clone+0xba/0x100 kernel/fork.c:2820
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 2734:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free_bulk.part.0+0x20c/0x680 mm/slub.c:3905
 mt_free_bulk lib/maple_tree.c:169 [inline]
 mas_destroy+0x3e0/0x650 lib/maple_tree.c:5771
 mas_store_prealloc+0xf0/0x150 lib/maple_tree.c:5702
 vma_iter_store mm/internal.h:1013 [inline]
 vma_complete+0xad9/0x1170 mm/mmap.c:572
 __split_vma+0x523/0x810 mm/mmap.c:2214
 split_vma+0xc6/0x110 mm/mmap.c:2242
 mbind_range+0x4d2/0x760 mm/mempolicy.c:829
 __do_sys_set_mempolicy_home_node+0x323/0x480 mm/mempolicy.c:1546
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888040743e00
 which belongs to the cache maple_node of size 256
The buggy address is located 32 bytes inside of
 freed 256-byte region [ffff888040743e00, ffff888040743f00)

The buggy address belongs to the physical page:
page:ffffea000101d080 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x40742
head:ffffea000101d080 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff8880124cd000 ffffea0001072e80 0000000000000003
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 2628, tgid 2628 (syz-executor.4), ts 3594695240825, free_ts 3593255422246
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4326
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5592
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x38e/0x3b0 mm/slub.c:3476
 mt_alloc_one lib/maple_tree.c:159 [inline]
 mas_alloc_nodes+0x402/0x8a0 lib/maple_tree.c:1233
 mas_node_count_gfp lib/maple_tree.c:1318 [inline]
 mas_preallocate+0x1bb/0x360 lib/maple_tree.c:5717
 vma_iter_prealloc mm/internal.h:972 [inline]
 vma_expand+0x23b/0xc60 mm/mmap.c:683
 mmap_region+0x1820/0x2620 mm/mmap.c:2542
 do_mmap+0x831/0xf60 mm/mmap.c:1364
 vm_mmap_pgoff+0x1af/0x280 mm/util.c:542
 ksys_mmap_pgoff+0x7d/0x5a0 mm/mmap.c:1410
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1504
 free_unref_page_prepare mm/page_alloc.c:3388 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3483
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2637
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x17c/0x3b0 mm/slub.c:3476
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags include/linux/audit.h:321 [inline]
 getname fs/namei.c:219 [inline]
 __do_sys_unlink fs/namei.c:4364 [inline]
 __se_sys_unlink fs/namei.c:4362 [inline]
 __x64_sys_unlink+0xb5/0x110 fs/namei.c:4362
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888040743d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888040743d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888040743e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888040743e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888040743f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
