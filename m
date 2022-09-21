Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D235BF627
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiIUGOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiIUGOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:14:42 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34490205C5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:14:40 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id h10-20020a92c26a000000b002f57c5ac7dbso2973815ild.15
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=pwxsXVmmiEyXGWa8asxYh7qnCp8kgPys1NHj5YwvFoU=;
        b=H+g3nPkgCG4L4yIkzsnrnnT7zQ52hQo3JXDwhzHmUv3B81N18j6qUG4Z3Mb4XKGdQ8
         tpTx0rqROitNmuyVM0i+UhkDLHb4Gn7u1romjVwyPJwiel+zoARx47q4R50aWohFEcnG
         RTOcPNp8UjAoG0OINzFTmHJ6p2TZaSH+MauvzOc9LTAt7JVcE8wTJGOR/LpynGVEMDab
         0kXfobmsV6S6DXF6BvZW3oD7XJT0EbzBzwfD0mGKbz6jPFKkvEvtg4JyIprNLAEJWlNH
         vHzzK0zR4ijbmsOBuuejBe7oT7/0QrP9k+QBQITplfH5MNAYtCmEgDuiMeuiGRO3X/Jq
         yIAA==
X-Gm-Message-State: ACrzQf1IOuKo0PiDf32T/HrsKHjDDxjsr/IjHXLkCi4aJenHp2qgKksK
        kSRGcQ75Izr2UpZPhdGIsrMGY2SKosMnRPZDcu5Pog+2dlp2
X-Google-Smtp-Source: AMsMyM77T7icMwj2HMdnsBBQZIIySgklD0FV0IO9kYZwD29quHz54+n5DGR/fOqhwgZQudq6sEGQP0H3I855NkG5k/KsyLGVr7Dn
MIME-Version: 1.0
X-Received: by 2002:a05:6638:490f:b0:35a:8060:2f69 with SMTP id
 cx15-20020a056638490f00b0035a80602f69mr12888419jab.79.1663740879493; Tue, 20
 Sep 2022 23:14:39 -0700 (PDT)
Date:   Tue, 20 Sep 2022 23:14:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ee18405e929dc7f@google.com>
Subject: [syzbot] BUG: looking up invalid subclass: ADDR
From:   syzbot <syzbot+39d19414bd6553c23c40@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
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

HEAD commit:    6879c2d3b960 Merge tag 'pinctrl-v6.0-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154d7fbf080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e66520f224211a2
dashboard link: https://syzkaller.appspot.com/bug?extid=39d19414bd6553c23c40
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39d19414bd6553c23c40@syzkaller.appspotmail.com

BUG: looking up invalid subclass: 4294967295
turning off the locking correctness validator.
CPU: 0 PID: 23921 Comm: syz-executor.4 Not tainted 6.0.0-rc5-syzkaller-00089-g6879c2d3b960 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 look_up_lock_class+0xdf/0x120 kernel/locking/lockdep.c:900
 register_lock_class+0xfe/0x9b0 kernel/locking/lockdep.c:1287
 __lock_acquire+0xe4/0x1f60 kernel/locking/lockdep.c:4932
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 iput_final fs/inode.c:1737 [inline]
 iput+0x3ee/0x760 fs/inode.c:1774
 ntfs_fill_super+0x3c6c/0x4420 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc89668a93a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc8977aef88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fc89668a93a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fc8977aefe0
RBP: 00007fc8977af020 R08: 00007fc8977af020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fc8977aefe0 R15: 0000000020003580
 </TASK>
================================================================================
UBSAN: array-index-out-of-bounds in kernel/locking/lockdep.c:1298:27
index 4294967295 is out of range for type 'struct lockdep_subclass_key [8]'
CPU: 0 PID: 23921 Comm: syz-executor.4 Not tainted 6.0.0-rc5-syzkaller-00089-g6879c2d3b960 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0x107/0x150 lib/ubsan.c:283
 register_lock_class+0x9a6/0x9b0 kernel/locking/lockdep.c:1298
 __lock_acquire+0xe4/0x1f60 kernel/locking/lockdep.c:4932
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 iput_final fs/inode.c:1737 [inline]
 iput+0x3ee/0x760 fs/inode.c:1774
 ntfs_fill_super+0x3c6c/0x4420 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc89668a93a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc8977aef88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fc89668a93a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fc8977aefe0
RBP: 00007fc8977af020 R08: 00007fc8977af020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fc8977aefe0 R15: 0000000020003580
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
