Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD64632491
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKUN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiKUN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:59:33 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3ED2FC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:58:39 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id j7-20020a056e02154700b003025b3c0ea3so8711929ilu.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+DBMQBdNE4cZBaDY0X69thduCCP80awLLejvHLEOe9A=;
        b=NUbwzjMaif73ST8LWjNepprbtKWjLntoUMCf491LIfVaDCJa0uZrI0Tich4b8Ro75g
         /6o4Fd+JpUSIE4/ZJxl6PCZrm/Tc8z/z9To7ZxUK/VThQjRUpPFe7iO2kDosA05aAYb1
         2uBug3JrHJipxMFoGEa9aLrBBpSSPSEH84jrRC3PLEGOlIHF9ij5js13LTvqnDCpDsIO
         9gIs4iAozDSArX3pvlT4Wzcl8pb9Alvs7A2BV+SHeHQtaeOufC2kWFQhIfd8i5MjJ0IS
         oubY0nIaLU78M4bTj4lcegmZXJY78A99krpkoQxQf47F9itlyoV+2K4SrkuHdaguSf4R
         hz7Q==
X-Gm-Message-State: ANoB5pklKZCPHz6yyKl0cn+WEqI+8VpoVDcsMfQ1vwDxT4x9z/pEwDx1
        Jd8s5p79aj90eRBCcNzfvW5Dk4h49vxcSprN4HTjDFoVUq5K
X-Google-Smtp-Source: AA0mqf4FJzd8ynkXYUYNBPZJIbnfu7j5yrY/MEW1xClIy7BICWDFeTXbbLCfF6Q4BYWTCNzi99EjrnfkcEmMzVmbAkootgDldxu7
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3a5:b0:363:e85b:a845 with SMTP id
 z5-20020a05663803a500b00363e85ba845mr8187169jap.138.1669039118765; Mon, 21
 Nov 2022 05:58:38 -0800 (PST)
Date:   Mon, 21 Nov 2022 05:58:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca546e05edfb7356@google.com>
Subject: [syzbot] WARNING in reiserfs_dir_fsync
From:   syzbot <syzbot+3c4ce3260a74215d1deb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

HEAD commit:    9500fc6e9e60 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1540810d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b25c9f218686dd5e
dashboard link: https://syzkaller.appspot.com/bug?extid=3c4ce3260a74215d1deb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1363e60652f7/disk-9500fc6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcc4da811bb6/vmlinux-9500fc6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b554298f1fa/Image-9500fc6e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c4ce3260a74215d1deb@syzkaller.appspotmail.com

EXT2-fs (loop5): error: revision level too high, forcing read-only mode
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 23017 at kernel/locking/mutex.c:582 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
Modules linked in:
CPU: 0 PID: 23017 Comm: syz-executor.5 Not tainted 6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
lr : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
sp : ffff800013ee3ca0
x29: ffff800013ee3d10 x28: ffff80000eefa000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000002
x23: ffff80000879d3d4 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff0000f751c428 x18: 0000000000000157
x17: ffff80000c0ed83c x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 0000000000000c6a x10: ffff80001ad76000 x9 : 72cc9bc43b455200
x8 : 72cc9bc43b455200 x7 : 4e5241575f534b43 x6 : ffff80000c0b2b74
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000028
Call trace:
 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_dir_fsync+0x70/0xb8 fs/reiserfs/dir.c:42
 vfs_fsync_range fs/sync.c:188 [inline]
 vfs_fsync fs/sync.c:202 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:225 [inline]
 __se_sys_fdatasync fs/sync.c:223 [inline]
 __arm64_sys_fdatasync+0x60/0xb8 fs/sync.c:223
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 831
hardirqs last  enabled at (831): [<ffff8000080388c4>] local_daif_restore arch/arm64/include/asm/daifflags.h:75 [inline]
hardirqs last  enabled at (831): [<ffff8000080388c4>] el0_svc_common+0x40/0x220 arch/arm64/kernel/syscall.c:107
hardirqs last disabled at (830): [<ffff80000c0a53a4>] el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
softirqs last  enabled at (826): [<ffff80000801c38c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (824): [<ffff80000801c358>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000054
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010acce000
[0000000000000054] pgd=08000001413b5003, p4d=08000001413b5003, pud=08000001371ff003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 23017 Comm: syz-executor.5 Tainted: G        W          6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : owner_on_cpu include/linux/sched.h:2290 [inline]
pc : mutex_can_spin_on_owner kernel/locking/mutex.c:409 [inline]
pc : mutex_optimistic_spin+0x1c8/0x254 kernel/locking/mutex.c:452
lr : __mutex_lock_common+0x1b4/0xca8 kernel/locking/mutex.c:607
sp : ffff800013ee3c40
x29: ffff800013ee3c50 x28: ffff80000eefa000 x27: ffff80000cbd7d0f
x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000f751c490
x23: ffff80000879d3d4 x22: ffff80000d3ac000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff0000f751c428 x18: 0000000000000157
x17: ffff80000c0ed83c x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 0000000000000c6a x10: ffff80000d3ac000 x9 : 0000000000000003
x8 : 0000000000000020 x7 : 4e5241575f534b43 x6 : ffff80000879d3d4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000f751c428
Call trace:
 mutex_can_spin_on_owner kernel/locking/mutex.c:408 [inline]
 mutex_optimistic_spin+0x1c8/0x254 kernel/locking/mutex.c:452
 __mutex_lock_common+0x1b4/0xca8 kernel/locking/mutex.c:607
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_dir_fsync+0x70/0xb8 fs/reiserfs/dir.c:42
 vfs_fsync_range fs/sync.c:188 [inline]
 vfs_fsync fs/sync.c:202 [inline]
 do_fsync fs/sync.c:212 [inline]
 __do_sys_fdatasync fs/sync.c:225 [inline]
 __se_sys_fdatasync fs/sync.c:223 [inline]
 __arm64_sys_fdatasync+0x60/0xb8 fs/sync.c:223
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 37080148 f9400268 f27df108 54000080 (b9403509) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	37080148 	tbnz	w8, #1, 0x28
   4:	f9400268 	ldr	x8, [x19]
   8:	f27df108 	ands	x8, x8, #0xfffffffffffffff8
   c:	54000080 	b.eq	0x1c  // b.none
* 10:	b9403509 	ldr	w9, [x8, #52] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
