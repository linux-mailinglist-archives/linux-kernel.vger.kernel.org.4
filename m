Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3CC5F1CC1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJAO2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJAO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:27:45 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4CD481E4
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:27:41 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id e14-20020a6b500e000000b006a13488a320so4459962iob.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ot8S7knVhE/ULqHSauVSXDrHW8LC+2Qa8wO45U/7T5A=;
        b=1tN+xJ+KvXFKKJQ4dQTz30AvG0gzmUycEauXvfFxrXNJlDAmX34IvRNOUAPTQnMhyN
         XITCR5Oe4n3MmC24po8+8tLh7t3O4QtQmD79qyIOEKVBaMPjvZ9QGY0fCj1H+16J0KnK
         IPmzDxcpxuJaDQfh3yLXAiCT55RUhNSxzT+SqKy98wFcE1ht4xK/6iO0D4sZGtMfL5UC
         yeTfidxh4mxaTe+XYxGX9f9Y1xekdfluLYYR6erEq9J5QXG7PsXBG/RSPKadRI9+7OW0
         gFMz7bYrFdrPqJ6ElXXYXnu9dgPonzPLOsIu/aS/+mlFm9szHJUln3u2rjUORBpRHZRE
         /kOA==
X-Gm-Message-State: ACrzQf0JqYAmVFktbtSni5UNe0c+2pnpMGMcgFzjvGXegTQuhfyc1M2h
        kB+gLXMIOHn8GKm7G12UwpFOBGDSOOvRvY1U6AKiuAxlitAW
X-Google-Smtp-Source: AMsMyM44kzfSkPxbszkiAjOC0w2L4uGcFTs6UI4Ny+kb5nksORGHCUXx/pqTTQj6iQZqPiBHCtONoKIRlZwvnZpGSxJLYTIeXjDi
MIME-Version: 1.0
X-Received: by 2002:a02:cb92:0:b0:358:3b30:7d44 with SMTP id
 u18-20020a02cb92000000b003583b307d44mr6572530jap.319.1664634460243; Sat, 01
 Oct 2022 07:27:40 -0700 (PDT)
Date:   Sat, 01 Oct 2022 07:27:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af0c0105e9f9e966@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_fill_super
From:   syzbot <syzbot+bd6d0c83fe8442ad6ef5@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
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

HEAD commit:    ffb4d94b4314 Merge tag 'drm-fixes-2022-10-01' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13212ee0880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=bd6d0c83fe8442ad6ef5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f626c46d9422/disk-ffb4d94b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9140d7085b55/vmlinux-ffb4d94b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd6d0c83fe8442ad6ef5@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 4096
==================================================================
BUG: KASAN: slab-out-of-bounds in load_system_files fs/ntfs/super.c:1833 [inline]
BUG: KASAN: slab-out-of-bounds in ntfs_fill_super+0x7317/0x92d0 fs/ntfs/super.c:2892
Read of size 1 at addr ffff88802baf332a by task syz-executor.1/14735

CPU: 0 PID: 14735 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller-00220-gffb4d94b4314 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 load_system_files fs/ntfs/super.c:1833 [inline]
 ntfs_fill_super+0x7317/0x92d0 fs/ntfs/super.c:2892
 mount_bdev+0x34d/0x410 fs/super.c:1400
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
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
RIP: 0033:0x7f7b1608bada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7b17226f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f7b1608bada
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f7b17226fe0
RBP: 00007f7b17227020 R08: 00007f7b17227020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f7b17226fe0 R15: 0000000020076700
 </TASK>

Allocated by task 10867:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc_lru+0x255/0x720 mm/slub.c:3280
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 nilfs_alloc_inode+0x24/0x150 fs/nilfs2/super.c:154
 alloc_inode+0x61/0x230 fs/inode.c:260
 iget5_locked fs/inode.c:1242 [inline]
 iget5_locked+0x1cb/0x2c0 fs/inode.c:1235
 nilfs_iget_locked+0xa0/0xd0 fs/nilfs2/inode.c:588
 nilfs_ifile_read+0x2c/0x1a0 fs/nilfs2/ifile.c:187
 nilfs_attach_checkpoint+0x258/0x4b0 fs/nilfs2/super.c:541
 nilfs_fill_super fs/nilfs2/super.c:1064 [inline]
 nilfs_mount+0xb12/0xfb0 fs/nilfs2/super.c:1317
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
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

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 call_rcu+0x99/0x790 kernel/rcu/tree.c:2793
 destroy_inode+0x129/0x1b0 fs/inode.c:315
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 nilfs_put_super+0xac/0x1a0 fs/nilfs2/super.c:476
 generic_shutdown_super+0x14c/0x400 fs/super.c:491
 kill_block_super+0x97/0xf0 fs/super.c:1427
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 deactivate_super+0xad/0xd0 fs/super.c:363
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 call_rcu+0x99/0x790 kernel/rcu/tree.c:2793
 destroy_inode+0x129/0x1b0 fs/inode.c:315
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 nilfs_put_super+0xac/0x1a0 fs/nilfs2/super.c:476
 generic_shutdown_super+0x14c/0x400 fs/super.c:491
 kill_block_super+0x97/0xf0 fs/super.c:1427
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 deactivate_super+0xad/0xd0 fs/super.c:363
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802baf2cd8
 which belongs to the cache nilfs2_inode_cache of size 1512
The buggy address is located 106 bytes to the right of
 1512-byte region [ffff88802baf2cd8, ffff88802baf32c0)

The buggy address belongs to the physical page:
page:ffffea0000aebc00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2baf0
head:ffffea0000aebc00 order:3 compound_mapcount:0 compound_pincount:0
memcg:ffff8880493ca901
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888018a8aa00
raw: 0000000000000000 0000000000130013 00000001ffffffff ffff8880493ca901
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0x1d2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 644, tgid 643 (syz-executor.4), ts 2331907861767, free_ts 2317024789889
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5549
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:1829 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x7f1/0xe10 mm/slub.c:3036
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3123
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc_lru+0x528/0x720 mm/slub.c:3280
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 nilfs_alloc_inode+0x24/0x150 fs/nilfs2/super.c:154
 alloc_inode+0x61/0x230 fs/inode.c:260
 iget5_locked fs/inode.c:1242 [inline]
 iget5_locked+0x1cb/0x2c0 fs/inode.c:1235
 nilfs_iget_locked+0xa0/0xd0 fs/nilfs2/inode.c:588
 nilfs_cpfile_read+0x83/0x1f0 fs/nilfs2/cpfile.c:991
 nilfs_load_super_root fs/nilfs2/the_nilfs.c:125 [inline]
 load_nilfs+0x48b/0x1330 fs/nilfs2/the_nilfs.c:269
 nilfs_fill_super fs/nilfs2/super.c:1059 [inline]
 nilfs_mount+0xa9a/0xfb0 fs/nilfs2/super.c:1317
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc+0x267/0x3b0 mm/slub.c:3273
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags+0x9a/0xe0 include/linux/audit.h:320
 user_path_at_empty+0x2b/0x60 fs/namei.c:2875
 user_path_at include/linux/namei.h:57 [inline]
 __do_sys_chdir fs/open.c:514 [inline]
 __se_sys_chdir fs/open.c:508 [inline]
 __x64_sys_chdir+0xb7/0x260 fs/open.c:508
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88802baf3200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802baf3280: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff88802baf3300: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
                                  ^
 ffff88802baf3380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802baf3400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
