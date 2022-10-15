Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE75F5FFBC6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 21:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiJOTWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiJOTWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 15:22:44 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3395F4198D
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 12:22:43 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i8-20020a056e0212c800b002f9a4c75658so6205051ilm.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 12:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZABjE9MIeCEWNGCRmpJHEG3TaBWzpt+2u4rcgQ+OFg=;
        b=wkFHZufA422s2eWYDXFlmwZEfzhCYrU3FRXwyUX92gT7yCzXp+ub4+z2TGS0/aqwD6
         bTtpKEamWHrV8Kxn99GOlW7TrESspYO2kbgxsu3VZdQQvVIhPkd2gN+h4HCeqQio9zBR
         j3uZAixjCHSr/6yiPYoo0V/347mX2OH1uSMe5Yr7c/HS4Wv6hCBuSFfF/eYop8hJ3eLM
         VwEa5M4fxqISEaOER8tAjnQN2UJggqMBgXDOiYwpIdWmdUYFoUCMiZ/nwqC5GS2AXT5s
         OpSOpS9/RqebwOsPYcseHVdcSxhf3+pja/mi7dP6sUoURMPNpnadGfv6AUrwq+SnnTy6
         8MoA==
X-Gm-Message-State: ACrzQf18I3rECOh879v5laaBjExyGhWu/T7g3RvcpsXYTlU3XA15Lksg
        rvbit6frV9D7ljxdKVNboNlhOVIWu71pF7rPiioVANLDT10K
X-Google-Smtp-Source: AMsMyM4xlWpeXvVPmaD8DGvwRcSScV6XT3YtHz00KOp8wx+8/jGj/pGbkpSR12sZl6aB7L/xZ6DqWa/pXFjMIMYkVDc2gt1DpsZM
MIME-Version: 1.0
X-Received: by 2002:a92:c54d:0:b0:2fb:5ecf:8f2 with SMTP id
 a13-20020a92c54d000000b002fb5ecf08f2mr1769078ilj.270.1665861762352; Sat, 15
 Oct 2022 12:22:42 -0700 (PDT)
Date:   Sat, 15 Oct 2022 12:22:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000970d2605eb17aaf9@google.com>
Subject: [syzbot] WARNING in reiserfs_ioctl
From:   syzbot <syzbot+9411504628309b2b748e@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=157831e6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=9411504628309b2b748e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9411504628309b2b748e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 7
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 8335 at kernel/locking/mutex.c:582 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
Modules linked in:
CPU: 0 PID: 8335 Comm: syz-executor.0 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
lr : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
sp : ffff80001c7e3c80
x29: ffff80001c7e3cf0 x28: ffff80000ee2b000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000002
x23: ffff80000878a408 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff00010d57e828 x18: 0000000000000159
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 000000000000103b x10: ffff80001693f000 x9 : dbe221ab05c56400
x8 : dbe221ab05c56400 x7 : 4e5241575f534b43 x6 : ffff80000819545c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000028
Call trace:
 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_ioctl+0x34/0x2a0 fs/reiserfs/ioctl.c:81
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 685
hardirqs last  enabled at (685): [<ffff80000bfc89b4>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (685): [<ffff80000bfc89b4>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (684): [<ffff80000bfc87f0>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (684): [<ffff80000bfc87f0>] _raw_spin_lock_irqsave+0xa4/0xb4 kernel/locking/spinlock.c:162
softirqs last  enabled at (672): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (670): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
