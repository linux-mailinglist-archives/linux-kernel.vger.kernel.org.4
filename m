Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E6A6125A1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 23:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJ2Vsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 17:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJ2Vsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 17:48:40 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDC4558E0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:48:38 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i8-20020a056e0212c800b002f9a4c75658so7376224ilm.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lzBJMc0CRF6kfy2Vo+DpKb0KWuYr/bmkQ8JLU9as1e0=;
        b=mrwkpOmMXT3ilAwDOs2DQLwDldG3W7o5T6QCZdyUiQmMz0Fsn1IKP0TCnGgvc48qgp
         CuYPellSvdVUWkutZxLARR5V6n41SX+XyDBVakT6ljQAU/xHSvN8eRdeES5TYhZ6lptZ
         zlANSr2gmb8KAgxRPnl3//P/jshWIndCZPSbf9LVMKvrdtQR6jFU7n7l9UTbvStcptrj
         bN+Woz1yHCD6mTOXhSuuW2Q6Jzfgl9d+qWGIuH/YFS26bKFZK9T8Wk5UJiUxPKfWBrO3
         weaIW+MBnozLKZaIrt/KJbCgnhJ6TqR+ZWcggtoVSZiDNLWNjZtDJHs0fjyffIv8XWck
         E+EA==
X-Gm-Message-State: ACrzQf1GFIy0yszYlj6iGeMYYVC1SsHwnzRgulHdH2YXHiCrYffdXxhn
        mMgdhXSpReBgjNd+9XUjemDpiDP/5EI8Op408r60jioVXm/x
X-Google-Smtp-Source: AMsMyM6Bxo6Y502AQveT7dakY1dFgAUwtnO90ckFjY87hrZZa5IQY7aO8huZOocj6ZhzAvN0LfJaDJ7M+02j4+RQ4cYNe5o7mzq+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1091:b0:2ff:f2ee:a7a2 with SMTP id
 r17-20020a056e02109100b002fff2eea7a2mr2631597ilj.85.1667080117644; Sat, 29
 Oct 2022 14:48:37 -0700 (PDT)
Date:   Sat, 29 Oct 2022 14:48:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039763c05ec335636@google.com>
Subject: [syzbot] INFO: trying to register non-static key in ext4_do_update_inode
From:   syzbot <syzbot+b2865f6558d604522545@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=132f53ce880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=b2865f6558d604522545
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2865f6558d604522545@syzkaller.appspotmail.com

EXT4-fs (loop1): mounted filesystem without journal. Quota mode: none.
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 13965 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 assign_lock_key+0x134/0x140 kernel/locking/lockdep.c:979
 register_lock_class+0xc4/0x2f8 kernel/locking/lockdep.c:1292
 __lock_acquire+0xa8/0x30a4 kernel/locking/lockdep.c:4932
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 ext4_do_update_inode+0x50/0x8f8 fs/ext4/inode.c:5129
 ext4_mark_iloc_dirty+0x118/0x1f0 fs/ext4/inode.c:5741
 __ext4_mark_inode_dirty+0x138/0x194 fs/ext4/inode.c:5937
 ext4_dirty_inode+0x74/0x98 fs/ext4/inode.c:5966
 __mark_inode_dirty+0x74/0x348 fs/fs-writeback.c:2381
 ext4_mb_new_blocks+0x814/0x9e4
 ext4_new_meta_blocks+0x84/0x140 fs/ext4/balloc.c:700
 ext4_xattr_block_set+0xce0/0x142c fs/ext4/xattr.c:2078
 ext4_xattr_set_handle+0x724/0x994 fs/ext4/xattr.c:2394
 ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2495
 ext4_xattr_trusted_set+0x4c/0x64 fs/ext4/xattr_trusted.c:38
 __vfs_setxattr+0x250/0x260 fs/xattr.c:182
 __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
 __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
 vfs_setxattr+0x174/0x280 fs/xattr.c:313
 do_setxattr fs/xattr.c:600 [inline]
 setxattr fs/xattr.c:623 [inline]
 path_setxattr+0x354/0x414 fs/xattr.c:642
 __do_sys_setxattr fs/xattr.c:658 [inline]
 __se_sys_setxattr fs/xattr.c:654 [inline]
 __arm64_sys_setxattr+0x2c/0x40 fs/xattr.c:654
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
