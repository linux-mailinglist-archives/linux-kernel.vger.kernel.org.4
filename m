Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402795F1C68
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJANlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJANln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:41:43 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D1B89837
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:41:33 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id f25-20020a5d8799000000b006a44e33ddb6so4416468ion.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5Q2cWNKH4sd/qj6n/jFbXU9YjN2seqHt+yDGrJVAiLM=;
        b=v8hy3SpxgYXX/PWpIYmZdXhVGdkIKyQh6VCISwNYf0DxXshDPxSuGHNwZZJrYYY9WR
         dHX7ETfR7NHPzeIRl6cKm1P74ekSdGGJUVmF+S/mk7351tEjL97ey8A9ckbfOOfkItjg
         +e033kTsb4blRUwZpeA4sO96MSudNxzMERsElwoj+Lti825E0eqf8Mfzs3vjHbpP9Zbi
         Awz5O6UB/xW6gyug9g6lF1R8FhKbkfFMsvNAE1t4ZmSLIgsRdYg0QCE6vVj52lo0L3pu
         Dn1tvF1LKGkC5DS4bj5+IE6kRiK+HvdJYc802KwzxpN9hDc9HYkNp+4IrvashqPT2BCZ
         QHqQ==
X-Gm-Message-State: ACrzQf0Wfbb1mqQEb/4luACwAw3k2KgWkA7E16uEqmrAWDpGV6W/3HsL
        QrOm26XYkMjGRD5aYV7DsZsJ4rE4AUYInAaotfDD2klifwyW
X-Google-Smtp-Source: AMsMyM7DWcnzh+noBoBqu0kX185mLIlP3lUzLE65RpAAI4bbuJPZxtn6X+Ot3ATxdxi41vySdGX8avnmo3sCNo2kYlJQ2g9LXvp6
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0e:b0:2f9:7742:173c with SMTP id
 i14-20020a056e021d0e00b002f97742173cmr2033804ila.49.1664631692690; Sat, 01
 Oct 2022 06:41:32 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:41:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b98bb905e9f944ef@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in hex_dump_to_buffer
From:   syzbot <syzbot+489783e0c22fbb27d8e9@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1773ecb8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=489783e0c22fbb27d8e9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95c7bf83c07e/disk-aaa11ce2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b161cd56a7a3/vmlinux-aaa11ce2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+489783e0c22fbb27d8e9@syzkaller.appspotmail.com

ffff8880a5a1c930: 28 c9 a1 a5 80 88 ff ff 00 00 00 00 00 00 00 00  (...............
ffff8880a5a1c940: 40 c9 a1 a5 80 88 ff ff 40 c9 a1 a5 80 88 ff ff  @.......@.......
ffff8880a5a1c950: 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
ffff8880a5a1c960: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
ffff8880a5a1c970: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
==================================================================
BUG: KASAN: slab-out-of-bounds in hex_dump_to_buffer+0xdc1/0xdf0 lib/hexdump.c:193
Read of size 1 at addr ffff8880a5a1c980 by task syz-executor.0/21885

CPU: 1 PID: 21885 Comm: syz-executor.0 Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 hex_dump_to_buffer+0xdc1/0xdf0 lib/hexdump.c:193
 print_hex_dump+0x12f/0x1d0 lib/hexdump.c:276
 ea_get.cold+0xaa/0x197 fs/jfs/xattr.c:561
 __jfs_setxattr+0xdb/0xfc0 fs/jfs/xattr.c:671
 __jfs_xattr_set+0xc9/0x150 fs/jfs/xattr.c:917
 __vfs_setxattr+0x115/0x180 fs/xattr.c:182
 __vfs_setxattr_noperm+0x125/0x5f0 fs/xattr.c:216
 __vfs_setxattr_locked+0x1cf/0x260 fs/xattr.c:277
 vfs_setxattr+0x13f/0x330 fs/xattr.c:309
 setxattr+0x146/0x160 fs/xattr.c:617
 path_setxattr+0x197/0x1c0 fs/xattr.c:636
 __do_sys_lsetxattr fs/xattr.c:659 [inline]
 __se_sys_lsetxattr fs/xattr.c:655 [inline]
 __x64_sys_lsetxattr+0xbd/0x150 fs/xattr.c:655
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f56a6e8a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f56a800f168 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 00007f56a6fabf80 RCX: 00007f56a6e8a5a9
RDX: 0000000020005280 RSI: 0000000020000180 RDI: 0000000020000140
RBP: 00007f56a6ee5580 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000016 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe8902fcff R14: 00007f56a800f300 R15: 0000000000022000
 </TASK>

Allocated by task 21885:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7e/0x80 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:754 [inline]
 slab_alloc_node mm/slub.c:3336 [inline]
 slab_alloc mm/slub.c:3344 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3351 [inline]
 kmem_cache_alloc_lru+0x255/0x730 mm/slub.c:3367
 alloc_inode_sb include/linux/fs.h:3106 [inline]
 jfs_alloc_inode+0x23/0x60 fs/jfs/super.c:105
 alloc_inode+0x61/0x230 fs/inode.c:259
 iget_locked+0x1b7/0x6f0 fs/inode.c:1286
 jfs_iget+0x1a/0x4d0 fs/jfs/inode.c:29
 jfs_lookup+0x246/0x2f0 fs/jfs/namei.c:1462
 __lookup_slow+0x24c/0x460 fs/namei.c:1685
 lookup_slow fs/namei.c:1702 [inline]
 walk_component+0x33f/0x5a0 fs/namei.c:1993
 lookup_last fs/namei.c:2450 [inline]
 path_lookupat+0x1ba/0x840 fs/namei.c:2474
 filename_lookup+0x1ce/0x590 fs/namei.c:2503
 user_path_at_empty+0x42/0x60 fs/namei.c:2876
 user_path_at include/linux/namei.h:57 [inline]
 do_mount fs/namespace.c:3380 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x1ea/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x99/0x820 kernel/rcu/tree.c:2796
 destroy_inode+0x129/0x1b0 fs/inode.c:314
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x59b/0x880 fs/inode.c:1773
 iput+0x58/0x70 fs/inode.c:1763
 diFreeSpecial+0x73/0x100 fs/jfs/jfs_imap.c:548
 jfs_umount+0x130/0x3f0 fs/jfs/jfs_umount.c:65
 jfs_put_super+0x81/0x190 fs/jfs/super.c:194
 generic_shutdown_super+0x154/0x410 fs/super.c:491
 kill_block_super+0x97/0xf0 fs/super.c:1427
 deactivate_locked_super+0x94/0x160 fs/super.c:331
 deactivate_super+0xad/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x99/0x820 kernel/rcu/tree.c:2796
 destroy_inode+0x129/0x1b0 fs/inode.c:314
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x59b/0x880 fs/inode.c:1773
 iput+0x58/0x70 fs/inode.c:1763
 jfs_put_super+0x152/0x190 fs/jfs/super.c:201
 generic_shutdown_super+0x154/0x410 fs/super.c:491
 kill_block_super+0x97/0xf0 fs/super.c:1427
 deactivate_locked_super+0x94/0x160 fs/super.c:331
 deactivate_super+0xad/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880a5a1c0c0
 which belongs to the cache jfs_ip of size 2240
The buggy address is located 0 bytes to the right of
 2240-byte region [ffff8880a5a1c0c0, ffff8880a5a1c980)

The buggy address belongs to the physical page:
page:ffffea0002968600 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffea0002771e00 pfn:0xa5a18
head:ffffea0002968600 order:3 compound_mapcount:0 compound_pincount:0
memcg:ffff888027fc6101
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff88801ba46b40 dead0000800d000d 0000000000000000
raw: ffffea0002771e00 dead000000000003 00000001ffffffff ffff888027fc6101
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 15578, tgid 15577 (syz-executor.1), ts 741966923770, free_ts 738328900782
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
 slab_alloc mm/slub.c:3344 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3351 [inline]
 kmem_cache_alloc_lru+0x4aa/0x730 mm/slub.c:3367
 alloc_inode_sb include/linux/fs.h:3106 [inline]
 jfs_alloc_inode+0x23/0x60 fs/jfs/super.c:105
 alloc_inode+0x61/0x230 fs/inode.c:259
 new_inode_pseudo fs/inode.c:1018 [inline]
 new_inode+0x27/0x270 fs/inode.c:1046
 diReadSpecial+0x4f/0x6d0 fs/jfs/jfs_imap.c:422
 jfs_mount+0x1da/0x7b0 fs/jfs/jfs_mount.c:108
 jfs_fill_super+0x5a4/0xc70 fs/jfs/super.c:556
 mount_bdev+0x34d/0x410 fs/super.c:1400
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
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
 getname_flags include/linux/audit.h:320 [inline]
 getname+0x8e/0xd0 fs/namei.c:218
 do_sys_openat2+0xf5/0x4c0 fs/open.c:1304
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff8880a5a1c880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880a5a1c900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880a5a1c980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff8880a5a1ca00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880a5a1ca80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
