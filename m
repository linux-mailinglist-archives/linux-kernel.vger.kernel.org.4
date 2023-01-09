Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39AA661EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 07:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjAIGyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 01:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjAIGyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:54:45 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868E812749
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 22:54:43 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id o22-20020a6b5a16000000b006e2d564944aso4330876iob.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 22:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mH0bcm8pszTvvuBdC7MXp0/ulxUGuilAMn8VM6FuAZs=;
        b=rOmIcM/40+rSS374mSMkiA/icxvKRUC3ZxWXaY6gCYQYEa+gEu/5VrGvnDlncjbw3z
         g9K996kAsZCUeFh0UrTq/DP8t9weYJ523cim8wMLCB8v6dG4YXu9c/JYd+1oj4Rb3Rux
         9rs0hBAigq7nWO8BPQpnZn47v0+fg+/PMVS92ap57KK4EUuZvLk84e5+SL+NxZ9iCsv6
         cH74m/rGv8Wo9Xu2dhdVQNy4Pgv46C1YuxDpMQpgodisEPviuRlkH4EpjpEqX9o7AC+T
         CscQQ61k3IEU0Slt4bubzPZj4CjuofPnjEH8BxxIeSmvlDtyxqAfhrqaj8fXbo7lTm31
         Z5Wg==
X-Gm-Message-State: AFqh2kqYv28BnUs3pZYG6wNta3p4bhFHI/I8xh5JJoi0XPeMhYkjICDB
        Lr+HEPKRQFDBNpUI23fxq/UosoU5Kx8Cy8IcIG5Ei+7kOJd3
X-Google-Smtp-Source: AMrXdXuy6Jwv0/4czwNRc2HLVk6GTxMfq/NPTyUVTK47nDECMAJsWWjnj9MU3CLBpX6pgX/C0D3LPu7Ct0JI/IFZsLcuemqFRkm3
MIME-Version: 1.0
X-Received: by 2002:a02:a086:0:b0:375:bee:4c7c with SMTP id
 g6-20020a02a086000000b003750bee4c7cmr6250746jah.161.1673247282884; Sun, 08
 Jan 2023 22:54:42 -0800 (PST)
Date:   Sun, 08 Jan 2023 22:54:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eaf55c05f1cf3df6@google.com>
Subject: [syzbot] [minix?] KASAN: slab-out-of-bounds Read in get_block (2)
From:   syzbot <syzbot+68d6b98b3f9bb279c74c@syzkaller.appspotmail.com>
To:     aeb@cwi.nl, akpm@linux-foundation.org, danarag@gmail.com,
        deepa.kernel@gmail.com, ebiggers@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
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
console output: https://syzkaller.appspot.com/x/log.txt?x=105c3f3a480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9099e39825972652
dashboard link: https://syzkaller.appspot.com/bug?extid=68d6b98b3f9bb279c74c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52b3f379ea36/disk-9b43a525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc228143f117/vmlinux-9b43a525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e285dc7878c7/bzImage-9b43a525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+68d6b98b3f9bb279c74c@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 128
==================================================================
BUG: KASAN: slab-out-of-bounds in add_chain fs/minix/itree_common.c:14 [inline]
BUG: KASAN: slab-out-of-bounds in get_branch fs/minix/itree_common.c:42 [inline]
BUG: KASAN: slab-out-of-bounds in get_block+0x10df/0x1810 fs/minix/itree_common.c:166
Read of size 2 at addr ffff888073755030 by task syz-executor.1/3956

CPU: 0 PID: 3956 Comm: syz-executor.1 Not tainted 6.2.0-rc2-syzkaller-00313-g9b43a525db12 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 add_chain fs/minix/itree_common.c:14 [inline]
 get_branch fs/minix/itree_common.c:42 [inline]
 get_block+0x10df/0x1810 fs/minix/itree_common.c:166
 __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
 minix_set_link+0x129/0x600 fs/minix/dir.c:423
 minix_rename+0x4d2/0x570 fs/minix/namei.c:243
 vfs_rename+0xd53/0x1130 fs/namei.c:4779
 do_renameat2+0xaad/0x12d0 fs/namei.c:4930
 __do_sys_rename fs/namei.c:4976 [inline]
 __se_sys_rename fs/namei.c:4974 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:4974
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f669048c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6691279168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f66905abf80 RCX: 00007f669048c0c9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 00000000200000c0
RBP: 00007f66904e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffced88ecaf R14: 00007f6691279300 R15: 0000000000022000
 </TASK>

Allocated by task 1202:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x183/0x320 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:3119 [inline]
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1380
 alloc_inode fs/inode.c:259 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1286
 f2fs_iget+0x51/0x4bc0 fs/f2fs/inode.c:508
 f2fs_fill_super+0x5683/0x6ee0 fs/f2fs/super.c:4369
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

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:488
 __call_rcu_common kernel/rcu/tree.c:2755 [inline]
 call_rcu+0x163/0xa70 kernel/rcu/tree.c:2868
 dispose_list fs/inode.c:697 [inline]
 evict_inodes+0x658/0x700 fs/inode.c:747
 generic_shutdown_super+0x94/0x310 fs/super.c:480
 kill_block_super+0x79/0xd0 fs/super.c:1386
 kill_f2fs_super+0x2f9/0x3c0 fs/f2fs/super.c:4640
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

Second to last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:488
 __call_rcu_common kernel/rcu/tree.c:2755 [inline]
 call_rcu+0x163/0xa70 kernel/rcu/tree.c:2868
 dispose_list fs/inode.c:697 [inline]
 evict_inodes+0x658/0x700 fs/inode.c:747
 generic_shutdown_super+0x94/0x310 fs/super.c:480
 kill_block_super+0x79/0xd0 fs/super.c:1386
 kill_f2fs_super+0x2f9/0x3c0 fs/f2fs/super.c:4640
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

The buggy address belongs to the object at ffff888073754780
 which belongs to the cache f2fs_inode_cache of size 2160
The buggy address is located 64 bytes to the right of
 2160-byte region [ffff888073754780, ffff888073754ff0)

The buggy address belongs to the physical page:
page:ffffea0001cdd400 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888073750000 pfn:0x73750
head:ffffea0001cdd400 order:3 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
memcg:ffff888027b4dd01
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888146135c80 dead000000000122 0000000000000000
raw: ffff888073750000 00000000800e0007 00000001ffffffff ffff888027b4dd01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5381, tgid 5378 (syz-executor.3), ts 242558619235, free_ts 242528398389
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
 kmem_cache_alloc_lru+0x238/0x320 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:3119 [inline]
 f2fs_alloc_inode+0x14d/0x520 fs/f2fs/super.c:1380
 alloc_inode fs/inode.c:259 [inline]
 iget_locked+0x191/0x830 fs/inode.c:1286
 f2fs_iget+0x51/0x4bc0 fs/f2fs/inode.c:508
 f2fs_fill_super+0x3d5e/0x6ee0 fs/f2fs/super.c:4259
 mount_bdev+0x26c/0x3a0 fs/super.c:1359
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
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
 getname_flags+0xb8/0x4e0 fs/namei.c:139
 do_sys_openat2+0xba/0x4e0 fs/open.c:1304
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888073754f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888073754f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
>ffff888073755000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc 00 00
                                     ^
 ffff888073755080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888073755100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
