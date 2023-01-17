Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFB066DB51
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbjAQKkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjAQKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:39:39 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490A222A06
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:38:40 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id g1-20020a92cda1000000b0030c45d93884so22670237ild.16
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJYBrcqUwdRqgvgHo+3fqcuaRSbYa+PJ6bUTeyvavX0=;
        b=6AUXdTKER86pu9qc1vt6fD6e9Y2KPoFKsZEQ3J10Ny4UQIxH0fPJ/jrs/WaZWRgnss
         6LmpwcAuenO2ZweHzEjdqLF9gbj0a6f+i6+Ue02a/QO83gqFMJ1tGpxNGuWKZMBYHMDS
         A84N7/fe8P3TVipHNrUrFJD4zLBpEb55DIZwWOwIAOkYaXY30Syk8xsozvuFFd3vVK7i
         qCzDw881kmjrv0ErD84IdPutHAdBTy03Pums0BqUn2NUetHFuxk5wYRs99vJd+RtRYbj
         pN6KuKhC1e88Bk5vyI11Og9HKpBO/x0XqwUEUE+agkhAgfW3XiwWkZbuXHqfVZ+w5zVG
         x5TQ==
X-Gm-Message-State: AFqh2kqntjXW9cxZb6zG2Ziwv6Lf2NLv7SCVzdPmanA8V5wvj2Py1OSa
        x+q2uoi6rFiNATKmSIPofUloGUYJRdVWNJAlkgwMb73l8gLR
X-Google-Smtp-Source: AMrXdXtuDg/cf/b17BDJQqrV0DKh0G9mu7eoPQM5tkFdidkp3/cP27/pflxHXRPKAQEImzm4sjUx0YI2mv7roi97eeT2ZsBXII7/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e09:b0:3a5:e79b:c8eb with SMTP id
 co9-20020a0566383e0900b003a5e79bc8ebmr201335jab.198.1673951919671; Tue, 17
 Jan 2023 02:38:39 -0800 (PST)
Date:   Tue, 17 Jan 2023 02:38:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b105805f2734d55@google.com>
Subject: [syzbot] [gfs2?] KMSAN: uninit-value in inode_go_dump
From:   syzbot <syzbot+79333ce1ae874ab7ffbb@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com, glider@google.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
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

HEAD commit:    e919e2b1bc1c Revert "kmsan: disallow CONFIG_KMSAN with CON..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11530191480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b63e082c4fda2e77
dashboard link: https://syzkaller.appspot.com/bug?extid=79333ce1ae874ab7ffbb
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5676c9771994/disk-e919e2b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f53a1472ca4/vmlinux-e919e2b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eb021c0a44de/bzImage-e919e2b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79333ce1ae874ab7ffbb@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: G:  s:SH n:2/13 f:qobnN t:SH d:EX/0 a:0 v:0 r:3 m:20 p:1
gfs2: fsid=syz:syz.0:  H: s:SH f:eEcH e:0 p:0 [(none)] init_inodes+0x125/0x510 fs/gfs2/ops_fstype.c:889
=====================================================
BUG: KMSAN: uninit-value in inode_go_dump+0x499/0x4d0 fs/gfs2/glops.c:544
 inode_go_dump+0x499/0x4d0 fs/gfs2/glops.c:544
 gfs2_dump_glock+0x21d1/0x2300 fs/gfs2/glock.c:2379
 gfs2_consist_inode_i+0x19b/0x220 fs/gfs2/util.c:465
 gfs2_dinode_in fs/gfs2/glops.c:460 [inline]
 gfs2_inode_refresh+0x10d9/0x14e0 fs/gfs2/glops.c:480
 inode_go_instantiate+0x6a/0xc0 fs/gfs2/glops.c:499
 gfs2_instantiate+0x253/0x490 fs/gfs2/glock.c:456
 gfs2_glock_holder_ready fs/gfs2/glock.c:1299 [inline]
 gfs2_glock_wait+0x28a/0x3d0 fs/gfs2/glock.c:1319
 gfs2_glock_nq+0x8ce/0xbe0 fs/gfs2/glock.c:1567
 gfs2_glock_nq_init fs/gfs2/glock.h:262 [inline]
 init_journal+0x11f2/0x38e0 fs/gfs2/ops_fstype.c:794
 init_inodes+0x125/0x510 fs/gfs2/ops_fstype.c:889
 gfs2_fill_super+0x3b2d/0x43a0 fs/gfs2/ops_fstype.c:1247
 get_tree_bdev+0x8a3/0xd30 fs/super.c:1282
 gfs2_get_tree+0x58/0x340 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0xa1/0x500 fs/super.c:1489
 do_new_mount+0x694/0x1580 fs/namespace.c:3145
 path_mount+0x71a/0x1eb0 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x734/0x840 fs/namespace.c:3674
 __ia32_sys_mount+0xdf/0x140 fs/namespace.c:3674
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x9f1/0xe80 mm/page_alloc.c:5572
 alloc_pages+0xaae/0xd80 mm/mempolicy.c:2286
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x235/0x1200 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0x10c3/0x2d60 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x713/0xb60 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:3119 [inline]
 gfs2_alloc_inode+0x62/0x210 fs/gfs2/super.c:1440
 alloc_inode+0x83/0x440 fs/inode.c:259
 iget5_locked+0xa5/0x200 fs/inode.c:1241
 gfs2_inode_lookup+0xc7/0x14b0 fs/gfs2/inode.c:124
 gfs2_lookup_root fs/gfs2/ops_fstype.c:462 [inline]
 init_sb+0xf27/0x19d0 fs/gfs2/ops_fstype.c:529
 gfs2_fill_super+0x315b/0x43a0 fs/gfs2/ops_fstype.c:1214
 get_tree_bdev+0x8a3/0xd30 fs/super.c:1282
 gfs2_get_tree+0x58/0x340 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0xa1/0x500 fs/super.c:1489
 do_new_mount+0x694/0x1580 fs/namespace.c:3145
 path_mount+0x71a/0x1eb0 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x734/0x840 fs/namespace.c:3674
 __ia32_sys_mount+0xdf/0x140 fs/namespace.c:3674
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 0 PID: 5906 Comm: syz-executor.3 Not tainted 6.2.0-rc3-syzkaller-79343-ge919e2b1bc1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
