Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B26F608B48
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 12:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiJVKJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 06:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJVKJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 06:09:11 -0400
Received: from mail-io1-xd45.google.com (mail-io1-xd45.google.com [IPv6:2607:f8b0:4864:20::d45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A2D2D7D1B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:26:09 -0700 (PDT)
Received: by mail-io1-xd45.google.com with SMTP id y4-20020a5e9204000000b006bbffbc3d27so4118257iop.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7QL3H9pJ8Y07fQ/A+T2Db6159+/4DiLAVRYi1i7PQj4=;
        b=ZQhX2yateq3zifl+xpI2Y5RC2LI9HyADsfj462DZPgGpLE78ub9RYvDefiHqCMwR/B
         RseJzFKk8Tl3C6VoxwKEUr4aoM0qU9yh1zKRHWa+irNnZr5wBUW+tNA7yDwPEqJ06Q6o
         vv4sZQVKJHRlSu1mKeNwn0vtfGefQlK7qVAJWLF/gXjireXUVUO7hbQl37bfMykMdDWI
         fEKeMMmPLi49G8KkR9Fih4OnP2R/UejUozJVYM4jrFCyb/1CbRq8LNIiFjaM4XuX6Lud
         ZKwN1L4BLfPS1KlsjZ/aVDFWdgxx2hW8XZCn4iDxk5KzfCjIbdu//ay+4YprlLYHQWNc
         PVog==
X-Gm-Message-State: ACrzQf20j0qlxAgXkW4ilvxw1e69ryGdFBCePWKj8V72QCqn1+FJ9ITD
        MybNh4FP7zwjvJnXLFFV4MqvJtYA2vCV2YReu6m1/ZrWSMfU
X-Google-Smtp-Source: AMsMyM617NhSCb13wwy2MaDcyLgYWBBwV023qLcOytskgTsGnb98ghMJrdQ3mh4o2rw3GaLwcW1fpd1xu4EkU83vMCkxI+ElhmU1
MIME-Version: 1.0
X-Received: by 2002:a02:cc4c:0:b0:363:af6c:eb08 with SMTP id
 i12-20020a02cc4c000000b00363af6ceb08mr17062856jaq.39.1666429960979; Sat, 22
 Oct 2022 02:12:40 -0700 (PDT)
Date:   Sat, 22 Oct 2022 02:12:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de0b0605eb9bf57f@google.com>
Subject: [syzbot] KASAN: use-after-free Read in mtree_range_walk
From:   syzbot <syzbot+2b3d442b8ebfc7e50073@syzkaller.appspotmail.com>
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

HEAD commit:    4da34b7d175d Merge tag 'thermal-6.1-rc2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162d61b4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea03ca45176080bc
dashboard link: https://syzkaller.appspot.com/bug?extid=2b3d442b8ebfc7e50073
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/20d944930440/disk-4da34b7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a40490d108a0/vmlinux-4da34b7d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b3d442b8ebfc7e50073@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in mtree_range_walk+0x7b2/0x920 lib/maple_tree.c:2928
Read of size 8 at addr ffff88801fbb4a10 by task syz-executor.4/31718

CPU: 1 PID: 31718 Comm: syz-executor.4 Not tainted 6.1.0-rc1-syzkaller-00249-g4da34b7d175d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 mtree_range_walk+0x7b2/0x920 lib/maple_tree.c:2928
 mas_state_walk lib/maple_tree.c:3843 [inline]
 mt_find+0x463/0xee0 lib/maple_tree.c:6434
 find_vma+0x108/0x1a0 mm/mmap.c:1835
 do_user_addr_fault+0x2c1/0x1210 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x94/0x170 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:fault_in_readable+0x175/0x290 mm/gup.c:1895
Code: 6f c9 ff 49 39 dd 0f 84 06 01 00 00 45 31 f6 eb 11 e8 6f 6f c9 ff 48 81 c3 00 10 00 00 4c 39 eb 74 1d e8 5e 6f c9 ff 45 89 f7 <8a> 03 31 ff 44 89 fe 88 44 24 28 e8 1b 6c c9 ff 45 85 ff 74 d2 e8
RSP: 0018:ffffc900056c7b18 EFLAGS: 00050246
RAX: 0000000000040000 RBX: 0000000020c53000 RCX: ffffc9000e3dc000
RDX: 0000000000040000 RSI: ffffffff81b31b92 RDI: 0000000000000005
RBP: 0000000020c52040 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001000
R13: 0000000020c54000 R14: 0000000000000000 R15: 0000000000000000
 fault_in_iov_iter_readable+0x24e/0x2c0 lib/iov_iter.c:356
 generic_perform_write+0x1aa/0x570 mm/filemap.c:3743
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3881
 generic_file_write_iter+0xdf/0x350 mm/filemap.c:3913
 call_write_iter include/linux/fs.h:2191 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:584
 ksys_write+0x127/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efff128b5f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efff24c4168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007efff13abf80 RCX: 00007efff128b5f9
RDX: 00000000fffffeba RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007efff12e67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efff18dfb1f R14: 00007efff24c4300 R15: 0000000000022000
 </TASK>

Allocated by task 31739:
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
 __vma_adjust+0x18e/0x1ae0 mm/mmap.c:716
 vma_adjust include/linux/mm.h:2663 [inline]
 __split_vma+0x4b0/0x5c0 mm/mmap.c:2237
 do_mas_align_munmap+0x54c/0xee0 mm/mmap.c:2362
 do_mas_munmap+0x26a/0x2b0 mm/mmap.c:2502
 do_munmap+0xc3/0x100 mm/mmap.c:2516
 mremap_to mm/mremap.c:826 [inline]
 __do_sys_mremap+0x12ce/0x16b0 mm/mremap.c:972
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 31715:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2a/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free_bulk.part.0+0x205/0x780 mm/slub.c:3779
 mt_free_bulk lib/maple_tree.c:163 [inline]
 mas_destroy+0x394/0x5c0 lib/maple_tree.c:5769
 mas_store_prealloc+0xec/0x150 lib/maple_tree.c:5704
 expand_downwards+0x962/0xdb0 mm/mmap.c:2066
 do_user_addr_fault+0x901/0x1210 arch/x86/mm/fault.c:1400
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x94/0x170 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570

The buggy address belongs to the object at ffff88801fbb4a00
 which belongs to the cache maple_node of size 256
The buggy address is located 16 bytes inside of
 256-byte region [ffff88801fbb4a00, ffff88801fbb4b00)

The buggy address belongs to the physical page:
page:ffffea00007eed00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fbb4
head:ffffea00007eed00 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff88801184fdc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 31078, tgid 31078 (syz-executor.1), ts 1125816469332, free_ts 1109146474618
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4287
 __alloc_pages+0x1c7/0x5a0 mm/page_alloc.c:5554
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 kmem_cache_alloc_bulk+0x28b/0x830 mm/slub.c:3830
 mt_alloc_bulk lib/maple_tree.c:157 [inline]
 mas_alloc_nodes+0x309/0x810 lib/maple_tree.c:1256
 mas_node_count_gfp lib/maple_tree.c:1316 [inline]
 mas_preallocate+0x1b7/0x360 lib/maple_tree.c:5719
 vma_expand+0x1cc/0xb60 mm/mmap.c:542
 mmap_region+0x131b/0x1c00 mm/mmap.c:2592
 do_mmap+0x825/0xf50 mm/mmap.c:1412
 vm_mmap_pgoff+0x1ab/0x270 mm/util.c:520
 ksys_mmap_pgoff+0x41b/0x5a0 mm/mmap.c:1458
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3482
 kasan_depopulate_vmalloc_pte+0x5c/0x70 mm/kasan/shadow.c:372
 apply_to_pte_range mm/memory.c:2640 [inline]
 apply_to_pmd_range mm/memory.c:2684 [inline]
 apply_to_pud_range mm/memory.c:2720 [inline]
 apply_to_p4d_range mm/memory.c:2756 [inline]
 __apply_to_page_range+0x68c/0x1030 mm/memory.c:2790
 kasan_release_vmalloc+0xa7/0xc0 mm/kasan/shadow.c:486
 __purge_vmap_area_lazy+0x885/0x1c50 mm/vmalloc.c:1770
 drain_vmap_area_work+0x52/0xe0 mm/vmalloc.c:1799
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff88801fbb4900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801fbb4980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801fbb4a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88801fbb4a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801fbb4b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	6f                   	outsl  %ds:(%rsi),(%dx)
   1:	c9                   	leaveq
   2:	ff 49 39             	decl   0x39(%rcx)
   5:	dd 0f                	fisttpll (%rdi)
   7:	84 06                	test   %al,(%rsi)
   9:	01 00                	add    %eax,(%rax)
   b:	00 45 31             	add    %al,0x31(%rbp)
   e:	f6 eb                	imul   %bl
  10:	11 e8                	adc    %ebp,%eax
  12:	6f                   	outsl  %ds:(%rsi),(%dx)
  13:	6f                   	outsl  %ds:(%rsi),(%dx)
  14:	c9                   	leaveq
  15:	ff 48 81             	decl   -0x7f(%rax)
  18:	c3                   	retq
  19:	00 10                	add    %dl,(%rax)
  1b:	00 00                	add    %al,(%rax)
  1d:	4c 39 eb             	cmp    %r13,%rbx
  20:	74 1d                	je     0x3f
  22:	e8 5e 6f c9 ff       	callq  0xffc96f85
  27:	45 89 f7             	mov    %r14d,%r15d
* 2a:	8a 03                	mov    (%rbx),%al <-- trapping instruction
  2c:	31 ff                	xor    %edi,%edi
  2e:	44 89 fe             	mov    %r15d,%esi
  31:	88 44 24 28          	mov    %al,0x28(%rsp)
  35:	e8 1b 6c c9 ff       	callq  0xffc96c55
  3a:	45 85 ff             	test   %r15d,%r15d
  3d:	74 d2                	je     0x11
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
