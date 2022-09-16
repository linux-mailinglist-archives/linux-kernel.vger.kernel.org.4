Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A485BA696
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 08:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIPGGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 02:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIPGGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:06:36 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A239985B0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:06:35 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id q12-20020a056e020c2c00b002f13e9070ebso13925211ilg.16
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 23:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=vJH88BefB7UerIa4/HTxXGtsX32y7n4+lY8K0ZVTVsk=;
        b=FGes62n7w2VrNcFINdidD0OY1CjDcFDh8+0oVwUp8/0kglRL02xCNGn04pileUcm2r
         5p74ETmhLmfSeiAMeSZhuDIdig7+uA2Q94cG1VZq5tT1KW+Y+wb9nOuGLKjxntFM1R/l
         trJmQvGF+HTXdxfoT3DWWRFDkYnL2Y6Mr/v1B6Zc3A0HJGe53DPq4B/WJuKNHySwIu8j
         72ZcQe0eDK7pR1G2fnCriF2ikgtsC2o1mKvcflJZkyKaN9SHNO34nq6Ydy+pEIf6Wsjf
         NyWh+RVZej6j7Yfcqj5R/ffAo98wNygw37/C2lhaleLYGnFCfmaQ2sOCiS5EZszBPQsI
         ymrg==
X-Gm-Message-State: ACrzQf2BjNjWlW1bT7PjeBjji2/7Lruvi6gYEKx/yabbi0AS6+ZQkenV
        dI48NQfo7oBWqOoWXvNIqxpUr8xm4vTtx4G8zcdSJwbDmGkI
X-Google-Smtp-Source: AMsMyM6Q5Qe6K0dLuLbsHLEh8ihjX0l79ErzL0PnpBYtSOmQq0yJircLBgwLe8o0HyrKsnZsv4ZXsLQeRZDXihXPslTly7IP/TNO
MIME-Version: 1.0
X-Received: by 2002:a92:d5cd:0:b0:2f4:9660:1ba9 with SMTP id
 d13-20020a92d5cd000000b002f496601ba9mr1613138ilq.91.1663308394878; Thu, 15
 Sep 2022 23:06:34 -0700 (PDT)
Date:   Thu, 15 Sep 2022 23:06:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000075fb105e8c52ada@google.com>
Subject: [syzbot] WARNING in gfs2_ri_update
From:   syzbot <syzbot+f8bc4176e51e87e0928f@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
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

HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10340c9f080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e79d82586727c5df
dashboard link: https://syzkaller.appspot.com/bug?extid=f8bc4176e51e87e0928f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1436897f0dc0/disk-a6b44374.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68c4de151fbb/vmlinux-a6b44374.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8bc4176e51e87e0928f@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
------------[ cut here ]------------
WARNING: CPU: 1 PID: 2396 at mm/page_alloc.c:5491 __alloc_pages+0x150/0x1fc mm/page_alloc.c:5491
Modules linked in:
CPU: 1 PID: 2396 Comm: syz-executor.3 Not tainted 6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __alloc_pages+0x150/0x1fc mm/page_alloc.c:5491
lr : alloc_pages+0x374/0x484
sp : ffff8000148f3790
x29: ffff8000148f37d0 x28: ffff000109e54000 x27: ffff000109e54000
x26: ffff0001046e6000 x25: ffff000107f24f80 x24: ffff80000eeb3bf0
x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000016 x18: ffff000107f24f80
x17: 0000000000000050 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000002 x13: 0000000000000005 x12: 0000000000040000
x11: 000000000003ffff x10: ffff80001d524000 x9 : 0000000000000001
x8 : ffff80000d8f7000 x7 : ffff800008188fe8 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000016 x0 : 0000000000040d40
Call trace:
 __alloc_pages+0x150/0x1fc mm/page_alloc.c:5491
 alloc_pages+0x374/0x484
 kmalloc_order+0x34/0x104 mm/slab_common.c:930
 kmalloc_order_trace+0x2c/0x7c mm/slab_common.c:946
 kmalloc_large include/linux/slab.h:529 [inline]
 __kmalloc+0x2ec/0x394 mm/slub.c:4413
 kmalloc_array include/linux/slab.h:640 [inline]
 kcalloc include/linux/slab.h:671 [inline]
 compute_bitstructs fs/gfs2/rgrp.c:766 [inline]
 read_rindex_entry fs/gfs2/rgrp.c:931 [inline]
 gfs2_ri_update+0x1a4/0x7e4 fs/gfs2/rgrp.c:1001
 gfs2_rindex_update+0x1b0/0x21c fs/gfs2/rgrp.c:1051
 init_inodes+0x11c/0x184 fs/gfs2/ops_fstype.c:910
 gfs2_fill_super+0x630/0x874 fs/gfs2/ops_fstype.c:1240
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 gfs2_get_tree+0x30/0xc0 fs/gfs2/ops_fstype.c:1323
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 46508
hardirqs last  enabled at (46507): [<ffff80000bfd8fbc>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (46507): [<ffff80000bfd8fbc>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (46508): [<ffff80000bfc6674>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (46504): [<ffff800009272c30>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (46502): [<ffff800009272bfc>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
