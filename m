Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C325645451
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiLGHA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGHAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:00:49 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0F24EC10
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 23:00:48 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id z5-20020a6b5c05000000b006dfeee800aeso9479454ioh.21
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 23:00:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sFoDzixvIOUecSJ5AIeZIidcr9UNIE79oGoDN9IDh+w=;
        b=m4xgNOul8ZBFPWMj6mtGVrC+2pS1nNadXe0KrSzYmRBCo+FpDTMB3QojqK8SYJek4Y
         +pRxNiDvL4YTInkhQyPUJUXq2wKd1OLXVMr3K1wpJLSABvfPy6t6FZqQXGDdglGMygAU
         VbTFasJSvPjk+r9Xqzk1hWSbn3rwkj76cAd2oV3w12whx+6VYWqN3JJ+v0K7BVisTJRI
         xoiTkDg9W/7C2dWSQ+50KK97PCB+lzDzIsnqVzgxnLKnP8UdbrSGK7by6hDdTAs4qNN4
         HDNblq9z6aTTbKBbTSy2ys59Rh6ITV6bcuUDxki6heY06JPj79LMbrGTiWz2RVbljAl5
         3gYA==
X-Gm-Message-State: ANoB5pkT4lwX835Fm/Lfpco3x23+f1A0fhGgtanvFvXT7d2Ux1/lGGKE
        0TdQrkKf8LbkN+Y8oNHMnQ7j2sOs5Zb7b6Mb5Ljpmgi07ndE
X-Google-Smtp-Source: AA0mqf7mxhK4vGB9fZQVlsP/vUeiIIwUfIOnKwREj+VjbOmFUc2vscxBgVbsgxrUY7JrV6+sbthVKxyjx4DlciMBy+Bk9WumqHvB
MIME-Version: 1.0
X-Received: by 2002:a05:6638:89:b0:363:9e67:d9d9 with SMTP id
 v9-20020a056638008900b003639e67d9d9mr34521143jao.133.1670396448246; Tue, 06
 Dec 2022 23:00:48 -0800 (PST)
Date:   Tue, 06 Dec 2022 23:00:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee924305ef377a61@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in write_inode_now (2)
From:   syzbot <syzbot+5294a9e355351fddb4b2@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1080851d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=5294a9e355351fddb4b2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5294a9e355351fddb4b2@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0 Not tainted
-----------------------------
kernel/sched/core.c:9870 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor.5/19612:
 #0: ffff0001428b30e0 (&type->s_umount_key#94/1){+.+.}-{3:3}, at: alloc_super+0xf8/0x430 fs/super.c:228

stack backtrace:
CPU: 0 PID: 19612 Comm: syz-executor.5 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 lockdep_rcu_suspicious+0x138/0x154 kernel/locking/lockdep.c:6597
 __might_resched+0x6c/0x218 kernel/sched/core.c:9870
 __might_sleep+0x48/0x78 kernel/sched/core.c:9837
 write_inode_now+0xa4/0xdc fs/fs-writeback.c:2743
 iput_final fs/inode.c:1734 [inline]
 iput+0x1e4/0x324 fs/inode.c:1773
 ntfs_fill_super+0x1254/0x14a4 fs/ntfs3/super.c:1190
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1324
 ntfs_fs_get_tree+0x28/0x38 fs/ntfs3/super.c:1358
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
