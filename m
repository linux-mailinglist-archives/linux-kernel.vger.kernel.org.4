Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74F369188C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjBJGdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjBJGdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:33:46 -0500
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E0A39294
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 22:33:44 -0800 (PST)
Received: by mail-il1-f205.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so3442293ild.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 22:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBFlxcJye4TQJ1JIDRqblYINI3T39X6NovVmO5dDZGk=;
        b=ViFQiKff80dw4k8zoWlOu1GP+Q7sumo5lLTEUHP/b0bontD/+kTYRoJZWtiY9EYveY
         I6puXKlmJG+dvEkVm1k4h19O7nvYhkW2kV6WXMoMiNeyiBx5EgqUiRpTxepC/mBHhENI
         x/zBh5e3maknzrkB4JXawufo1o3+rUHkCvour5/BkHM6p7jJWsRFlp3ib12XvaaE2V2U
         p0zuIIPlg4sQF7ekpOlL7KDGBPeKiQrWwMLQ7pzruNjrLz1Yfm1Ok+t53AdCh1yskduJ
         /5VSSDYf49XoW/xNC/WaaIoPb8AuxVcOhvJ9ckcQ3qDjWdoT3Y3eFN25F2sqe8v1676t
         zadA==
X-Gm-Message-State: AO0yUKXtr9pSJXgR1SgA81pgCCRD5mXhVPqgbKjBLkUHDAoY0++Bw1Nz
        2EgFiTPc0dGfRG/DreLt6nRRaVEFB1g3nahWRHV36Zn58y6q
X-Google-Smtp-Source: AK7set+bp/2etF09+VplgqgARyM5y3Kw9aEDLNHUElk/Nh36gzbjmXKfUAwOLluTIsMw07gU208Ap42trANazT0Wgy2Vx7E42PZw
MIME-Version: 1.0
X-Received: by 2002:a05:6638:23b:b0:3b6:af52:c672 with SMTP id
 f27-20020a056638023b00b003b6af52c672mr8438563jaq.73.1676010823499; Thu, 09
 Feb 2023 22:33:43 -0800 (PST)
Date:   Thu, 09 Feb 2023 22:33:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c6479f05f452adbe@google.com>
Subject: [syzbot] [xfs?] KASAN: use-after-free Read in xfs_inode_item_push
From:   syzbot <syzbot+f0da51f81ea0b040c803@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    d2d11f342b17 Merge branch 'fixes' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1529cd73480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6bb1911ff9919df0
dashboard link: https://syzkaller.appspot.com/bug?extid=f0da51f81ea0b040c803
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6be923b8a63a/disk-d2d11f34.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a426c0bf1d8/vmlinux-d2d11f34.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c6af145650b/bzImage-d2d11f34.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0da51f81ea0b040c803@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in xfs_inode_item_push+0x338/0x350 fs/xfs/xfs_inode_item.c:594
Read of size 8 at addr ffff88804bb907e0 by task xfsaild/loop3/17189

CPU: 0 PID: 17189 Comm: xfsaild/loop3 Not tainted 6.2.0-rc7-syzkaller-00002-gd2d11f342b17 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 xfs_inode_item_push+0x338/0x350 fs/xfs/xfs_inode_item.c:594
 xfsaild_push_item fs/xfs/xfs_trans_ail.c:414 [inline]
 xfsaild_push fs/xfs/xfs_trans_ail.c:486 [inline]
 xfsaild+0xd0f/0x27f0 fs/xfs/xfs_trans_ail.c:671
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 17140:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x82/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x1e4/0x430 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 xfs_inode_item_init+0x24/0xc0 fs/xfs/xfs_inode_item.c:687
 xfs_trans_ijoin+0xb3/0x100 fs/xfs/libxfs/xfs_trans_inode.c:36
 xfs_init_new_inode+0x628/0x1910 fs/xfs/xfs_inode.c:902
 xfs_create+0x77a/0x1250 fs/xfs/xfs_inode.c:1023
 xfs_generic_create+0x5ee/0x790 fs/xfs/xfs_iops.c:199
 lookup_open.isra.0+0xee7/0x1270 fs/namei.c:3413
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x975/0x2a50 fs/namei.c:3711
 do_filp_open+0x1ba/0x410 fs/namei.c:3741
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x11d/0x1c0 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5137:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0xee/0x5c0 mm/slub.c:3809
 xfs_inode_free_callback+0x159/0x240 fs/xfs/xfs_icache.c:145
 rcu_do_batch kernel/rcu/tree.c:2246 [inline]
 rcu_core+0x81f/0x1980 kernel/rcu/tree.c:2506
 __do_softirq+0x1fb/0xadc kernel/softirq.c:571

The buggy address belongs to the object at ffff88804bb907b0
 which belongs to the cache xfs_ili of size 264
The buggy address is located 48 bytes inside of
 264-byte region [ffff88804bb907b0, ffff88804bb908b8)

The buggy address belongs to the physical page:
page:ffffea00012ee400 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88804bb90520 pfn:0x4bb90
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88801bf9fdc0 dead000000000122 0000000000000000
raw: ffff88804bb90520 00000000800c0006 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x112c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 12970, tgid 12969 (syz-executor.2), ts 689997984493, free_ts 627929371073
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x119c/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2287
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x379/0x430 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 xfs_inode_item_init+0x24/0xc0 fs/xfs/xfs_inode_item.c:687
 xfs_trans_ijoin+0xb3/0x100 fs/xfs/libxfs/xfs_trans_inode.c:36
 xfs_trans_alloc_ichange+0x156/0x590 fs/xfs/xfs_trans.c:1298
 xfs_setattr_nonsize+0x18b/0xed0 fs/xfs/xfs_iops.c:709
 xfs_vn_setattr+0x358/0x8d0 fs/xfs/xfs_iops.c:1024
 notify_change+0xca7/0x1420 fs/attr.c:482
 chown_common+0x60a/0x6f0 fs/open.c:736
 do_fchownat+0x12a/0x1e0 fs/open.c:767
 __do_sys_lchown fs/open.c:792 [inline]
 __se_sys_lchown fs/open.c:790 [inline]
 __x64_sys_lchown+0x7e/0xc0 fs/open.c:790
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x65c/0xc00 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3464
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x66/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x1ea/0x430 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc+0x4a/0xd0 mm/slab_common.c:981
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 tomoyo_encode2.part.0+0xe9/0x3a0 security/tomoyo/realpath.c:45
 tomoyo_encode2 security/tomoyo/realpath.c:31 [inline]
 tomoyo_encode+0x2c/0x50 security/tomoyo/realpath.c:80
 tomoyo_path_perm+0x391/0x430 security/tomoyo/file.c:831
 tomoyo_path_symlink+0x98/0xe0 security/tomoyo/tomoyo.c:211
 security_path_symlink+0xe3/0x160 security/security.c:1212
 do_symlinkat+0x10a/0x2c0 fs/namei.c:4425
 __do_sys_symlink fs/namei.c:4452 [inline]
 __se_sys_symlink fs/namei.c:4450 [inline]
 __x64_sys_symlink+0x79/0x90 fs/namei.c:4450
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88804bb90680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804bb90700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
>ffff88804bb90780: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff88804bb90800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804bb90880: fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc fa
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
