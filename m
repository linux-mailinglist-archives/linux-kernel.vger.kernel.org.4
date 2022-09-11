Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE895B4D49
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiIKKUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiIKKU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:20:29 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D8933400
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:20:27 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id v20-20020a6b5b14000000b0069fee36308eso3774469ioh.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 03:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=7n6UZ51GjJRU//RIosHqTw9+K/eUtmU9BCuaFTMuYd4=;
        b=lnm7RZrLrBBp4r4wvo3NRyeupFd7GRKYdM3dHWr9eDsnNZD3uWDJduLjnKxehd0CYu
         jPQZKXYKCBGnSu5PNA5WWp0nndELV8AfzVRLN7OQbg12Wr82yPnI/xvUKZxrLWKN9rSE
         sF40Bq3lLwzls/jezF/2SfvVZPXI6ypKjCzS8C5XZS8MFtb4a+agaQBzVkAsmH8FpTq6
         SSTlcGKCse+/EIDHTKiXWQqzr/89NRxOw+nDD0a7j0bOShmLyF6MqYoVc5FZwe7yaGE3
         zWDvbmdyvrWYF7S0WAnKLs56X+JElmgc5ZbyDxXYiH6iy85Jb4Xcc8H+jtFsvIU4xJX6
         QsJQ==
X-Gm-Message-State: ACgBeo0/WrHn7tLLb1XHCIXwBAIY2yBPImkM/UuQDYMsFr1y9qOVP5sl
        gpVOqJKj4MXKRBq50CotnmpBvpaz5HDR07hNnyn903GHVg27
X-Google-Smtp-Source: AA6agR6KizhXAq97ejL2ALfxQ//lT0YS1y1oNBWVpDydma20heBy2Ni2uGO9ScUJBz1Ytmwd8siLP5FEzwUR1T3Iix1Z0L8q3clH
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:2eb:3770:e3f8 with SMTP id
 j1-20020a056e02218100b002eb3770e3f8mr8414715ila.79.1662891627288; Sun, 11 Sep
 2022 03:20:27 -0700 (PDT)
Date:   Sun, 11 Sep 2022 03:20:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be9dc105e8642051@google.com>
Subject: [syzbot] WARNING in __kernfs_remove
From:   syzbot <syzbot+9526e2e1fc98a6452cd5@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    25050c56fa3c Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1572d025080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db8b30b83a444315
dashboard link: https://syzkaller.appspot.com/bug?extid=9526e2e1fc98a6452cd5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176b3417080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c53007080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9526e2e1fc98a6452cd5@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3237 at fs/kernfs/dir.c:504 kernfs_get fs/kernfs/dir.c:504 [inline]
WARNING: CPU: 0 PID: 3237 at fs/kernfs/dir.c:504 __kernfs_remove+0x6e4/0x7b8 fs/kernfs/dir.c:1377
Modules linked in:
CPU: 0 PID: 3237 Comm: syz-executor100 Not tainted 6.0.0-rc4-syzkaller-17186-g25050c56fa3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kernfs_get fs/kernfs/dir.c:504 [inline]
pc : __kernfs_remove+0x6e4/0x7b8 fs/kernfs/dir.c:1377
lr : kernfs_get fs/kernfs/dir.c:504 [inline]
lr : __kernfs_remove+0x6e4/0x7b8 fs/kernfs/dir.c:1377
sp : ffff8000129138a0
x29: ffff8000129138d0 x28: ffff80000cf35761 x27: 0000000080000001
x26: ffff0000c0011800 x25: ffff80000d37c000 x24: ffff0000cd23c2a0
x23: ffff0000cd23cc10 x22: 0000000000000000 x21: ffff0000cd23c2a0
x20: ffff0000cd23c2a0 x19: ffff800008702970 x18: 0000000000000300
x17: ffff80000c04d6bc x16: ffff80000dbb8658 x15: ffff0000cb12b500
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000cb12b500
x11: ff80800008702360 x10: 0000000000000000 x9 : ffff800008702360
x8 : ffff0000cb12b500 x7 : ffff8000095ef734 x6 : 0000000000000000
x5 : 0000000080180000 x4 : fffffc0003348f20 x3 : 0000000080180000
x2 : ffff0000cd23c2a0 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 kernfs_get fs/kernfs/dir.c:504 [inline]
 __kernfs_remove+0x6e4/0x7b8 fs/kernfs/dir.c:1377
 kernfs_remove_by_name_ns+0x68/0xb8 fs/kernfs/dir.c:1589
 kernfs_remove_by_name include/linux/kernfs.h:615 [inline]
 sysfs_remove_link+0x40/0x50 fs/sysfs/symlink.c:152
 sysfs_slab_add+0x70/0x260 mm/slub.c:5943
 __kmem_cache_create+0x60/0x118 mm/slub.c:4899
 create_cache mm/slab_common.c:229 [inline]
 kmem_cache_create_usercopy+0x19c/0x31c mm/slab_common.c:335
 p9_client_create+0x618/0x758 net/9p/client.c:993
 v9fs_session_init+0xa4/0x9f0 fs/9p/v9fs.c:408
 v9fs_mount+0x6c/0x548 fs/9p/vfs_super.c:126
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
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
 do_el0_svc+0x48/0x154 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 1110
hardirqs last  enabled at (1109): [<ffff80000c0121cc>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (1109): [<ffff80000c0121cc>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (1110): [<ffff80000bfff6cc>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (888): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (681): [<ffff800008104658>] do_softirq_own_stack include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (681): [<ffff800008104658>] invoke_softirq+0x70/0xbc kernel/softirq.c:452
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
