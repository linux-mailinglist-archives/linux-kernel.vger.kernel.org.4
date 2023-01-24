Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B486F679437
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjAXJ3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjAXJ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:29:37 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B661086A9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:29:14 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id w10-20020a056e021c8a00b0030efad632e0so10171784ill.22
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qix3BlIZt4/7lxlsy/Luy1grphswwUevoArRhNmK25Y=;
        b=67PkFc+1BUeMfQHPhcRDdiPjfxyanuT+B4Zte4SylSeS4W3xz0DDHu511dyzGtXkbd
         VuXUM3dZE1Z1UPNMp+zTlHcqbuh6w7ly0Fz7lXwhNAjWJr64xjB2ssJUcR3FPiy+EkQi
         QauWmjxfFRgHXHiMZk8Fne5z7lpiCIHERniZ7uB0p7+iYZXmqF76cIdm6Jj4y6HHsC7W
         VQMZqIxXQ35a43hT4hU3jhjEhP0LEiMkJZUcygGQD/JTc72UsjK4Udm+tkYi8S8blECp
         4UmKYPtPFnLEla+AoFwVZN4xx+da5ySH5E6QGgQnFMP8HPtnK5oAN9QfxGc5Df8niWLi
         WJ9A==
X-Gm-Message-State: AFqh2krvL2byYkSS474NZkE7f+ZcnUV6TLZNaDS58Fp39JkqQP61AuOa
        GjypFf/8bNAV6FrRSFfw3o6JRxxiT8CY9KSpYHK9Odm6nYPr
X-Google-Smtp-Source: AMrXdXshXzUvSKSyY+KYqtrkmzIz3VeTfEU/0A89eVF4G0gfItkAwASrIyrwfiXQSOI3KePp59zwaYI0FJ3soCMQXdOyjqbbXgt3
MIME-Version: 1.0
X-Received: by 2002:a92:bf0b:0:b0:30e:fab6:3561 with SMTP id
 z11-20020a92bf0b000000b0030efab63561mr1987269ilh.48.1674552518677; Tue, 24
 Jan 2023 01:28:38 -0800 (PST)
Date:   Tue, 24 Jan 2023 01:28:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000089cea05f2ff246a@google.com>
Subject: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xfs_btree_del_cursor
From:   syzbot <syzbot+fdd050b6b63ef0e6e29f@syzkaller.appspotmail.com>
To:     dchinner@redhat.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    081edded9b38 Merge tag 'zonefs-6.2-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e2a4fe480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d24faf5fc10540ae
dashboard link: https://syzkaller.appspot.com/bug?extid=fdd050b6b63ef0e6e29f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e03f6355f8c4/disk-081edded.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba84ff280ef5/vmlinux-081edded.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6ba2dbf91192/bzImage-081edded.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fdd050b6b63ef0e6e29f@syzkaller.appspotmail.com

XFS (loop0): Metadata corruption detected at xfs_btree_lookup_get_block+0x565/0x6d0 fs/xfs/libxfs/xfs_btree.c:1846, xfs_refcountbt block 0x28
XFS (loop0): Unmount and run xfs_repair
==================================================================
BUG: KASAN: slab-out-of-bounds in xfs_btree_del_cursor+0x96/0x2a0 fs/xfs/libxfs/xfs_btree.c:439
Read of size 8 at addr ffff88801e8735f0 by task syz-executor.0/27912

CPU: 1 PID: 27912 Comm: syz-executor.0 Not tainted 6.2.0-rc4-syzkaller-00069-g081edded9b38 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 xfs_btree_del_cursor+0x96/0x2a0 fs/xfs/libxfs/xfs_btree.c:439
 xfs_refcount_recover_cow_leftovers+0x2df/0xa60 fs/xfs/libxfs/xfs_refcount.c:1948
 xfs_reflink_recover_cow+0xab/0x1b0 fs/xfs/xfs_reflink.c:928
 xlog_recover_finish+0x824/0x920 fs/xfs/xfs_log_recover.c:3493
 xfs_log_mount_finish+0x1ec/0x3d0 fs/xfs/xfs_log.c:829
 xfs_mountfs+0x146a/0x1ef0 fs/xfs/xfs_mount.c:933
 xfs_fs_fill_super+0xf95/0x11f0 fs/xfs/xfs_super.c:1666
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9795c8d5fa
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9796aacf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000000097a0 RCX: 00007f9795c8d5fa
RDX: 0000000020000040 RSI: 0000000020000180 RDI: 00007f9796aacfe0
RBP: 00007f9796aad020 R08: 00007f9796aad020 R09: 0000000000800003
R10: 0000000000800003 R11: 0000000000000202 R12: 0000000020000040
R13: 0000000020000180 R14: 00007f9796aacfe0 R15: 0000000020000080
 </TASK>

Allocated by task 27912:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x1b3/0x350 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 xfs_btree_alloc_cursor fs/xfs/libxfs/xfs_btree.h:592 [inline]
 xfs_refcountbt_init_common fs/xfs/libxfs/xfs_refcount_btree.c:336 [inline]
 xfs_refcountbt_init_cursor+0x84/0x330 fs/xfs/libxfs/xfs_refcount_btree.c:363
 xfs_refcount_recover_cow_leftovers+0x213/0xa60 fs/xfs/libxfs/xfs_refcount.c:1939
 xfs_reflink_recover_cow+0xab/0x1b0 fs/xfs/xfs_reflink.c:928
 xlog_recover_finish+0x824/0x920 fs/xfs/xfs_log_recover.c:3493
 xfs_log_mount_finish+0x1ec/0x3d0 fs/xfs/xfs_log.c:829
 xfs_mountfs+0x146a/0x1ef0 fs/xfs/xfs_mount.c:933
 xfs_fs_fill_super+0xf95/0x11f0 fs/xfs/xfs_super.c:1666
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801e873528
 which belongs to the cache xfs_refcbt_cur of size 200
The buggy address is located 0 bytes to the right of
 200-byte region [ffff88801e873528, ffff88801e8735f0)

The buggy address belongs to the physical page:
page:ffffea00007a1cc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801e873000 pfn:0x1e873
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88814639e8c0 0000000000000000 0000000000000001
raw: ffff88801e873000 00000000800f0006 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 5813, tgid 5812 (syz-executor.1), ts 240974207332, free_ts 240939470118
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
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x268/0x350 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 xfs_btree_alloc_cursor fs/xfs/libxfs/xfs_btree.h:592 [inline]
 xfs_refcountbt_init_common fs/xfs/libxfs/xfs_refcount_btree.c:336 [inline]
 xfs_refcountbt_init_cursor+0x84/0x330 fs/xfs/libxfs/xfs_refcount_btree.c:363
 xfs_refcount_recover_cow_leftovers+0x213/0xa60 fs/xfs/libxfs/xfs_refcount.c:1939
 xfs_reflink_recover_cow+0xab/0x1b0 fs/xfs/xfs_reflink.c:928
 xlog_recover_finish+0x824/0x920 fs/xfs/xfs_log_recover.c:3493
 xfs_log_mount_finish+0x1ec/0x3d0 fs/xfs/xfs_log.c:829
 xfs_mountfs+0x146a/0x1ef0 fs/xfs/xfs_mount.c:933
 xfs_fs_fill_super+0xf95/0x11f0 fs/xfs/xfs_super.c:1666
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x751/0x780 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page_list+0xb2/0x830 mm/page_alloc.c:3510
 release_pages+0x233e/0x25e0 mm/swap.c:1076
 tlb_batch_pages_flush mm/mmu_gather.c:97 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu+0x860/0xa80 mm/mmu_gather.c:299
 tlb_finish_mmu+0xcd/0x200 mm/mmu_gather.c:391
 exit_mmap+0x275/0x630 mm/mmap.c:3100
 __mmput+0x114/0x3b0 kernel/fork.c:1207
 exec_mmap+0x4af/0x530 fs/exec.c:1033
 begin_new_exec+0x772/0xfb0 fs/exec.c:1292
 load_elf_binary+0x8f0/0x2830 fs/binfmt_elf.c:996
 search_binary_handler fs/exec.c:1735 [inline]
 exec_binprm fs/exec.c:1777 [inline]
 bprm_execve+0x8dc/0x1590 fs/exec.c:1851
 do_execveat_common+0x598/0x750 fs/exec.c:1956
 do_execve fs/exec.c:2030 [inline]
 __do_sys_execve fs/exec.c:2106 [inline]
 __se_sys_execve fs/exec.c:2101 [inline]
 __x64_sys_execve+0x8e/0xa0 fs/exec.c:2101
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801e873480: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff88801e873500: fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00
>ffff88801e873580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
                                                             ^
 ffff88801e873600: fc fc fc fc fc fc fb fb fb fb fb fb fb fb fb fb
 ffff88801e873680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
