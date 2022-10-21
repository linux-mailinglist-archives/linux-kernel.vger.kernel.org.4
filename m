Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5C7606F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJUEqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiJUEqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:46:42 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583CC187DEC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:46:41 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id m9-20020a056e021c2900b002fadb905ddcso2190148ilh.18
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfwbBXept+kyIXLF7KoNlo/3TgZGKQRQdwMy65vltyo=;
        b=OHHXxkaW/bQ2RjlIDDWTZb93XYRooFnk0Zcs+khWu2tTI0tI2MwNcak0YBbnr5fLHY
         EMei0Wy1v0FQtYcGBQDvDo/bvD3sTmiSmGr19IVetx6ceRqX6uMRpHRzcw9Rm4YlRrEE
         +QVX6ZGkqzStGkvTy/fGo0jdXjVcd6HM07cgeZN9YBhk9hx6IQza5H6yqtb71aFbx3rd
         gg5Qv1h4X1zPyL0ZmcwoLrD083nozD/gIa1KCNAYe7Qq+FR2n+Kmj3LXkinRRktVcOit
         y5RfADILaSO/I5aLrw2+/bTav3mucVcKc6Gy5JKGA6iWe/8nkqjZLfFOCgK5M9NKs/5b
         qEjw==
X-Gm-Message-State: ACrzQf1TNFxoiTooS74rCGuXCtOmqn4QYo2xx8E6S9QydSrUSdGx8L/8
        y9L76FK6ZkWHHv520dKEv9VVk1LqeW5KpB5x2eIKU8iaJci5
X-Google-Smtp-Source: AMsMyM6ilerTnLXtSrHP5jWo2RIS0UltdpycfXZqD0MVYFiZZ6720Dq0SZSMF379Rc27TWbqtFZj43dfQhqY+HzPToHcb2Tg+p7u
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1305:b0:363:ecbc:25d4 with SMTP id
 r5-20020a056638130500b00363ecbc25d4mr13911048jad.59.1666327600718; Thu, 20
 Oct 2022 21:46:40 -0700 (PDT)
Date:   Thu, 20 Oct 2022 21:46:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8687105eb842054@google.com>
Subject: [syzbot] WARNING in reiserfs_setattr
From:   syzbot <syzbot+55b93dba2f5f385ebe4d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14e5373a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=55b93dba2f5f385ebe4d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55b93dba2f5f385ebe4d@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 12653 at kernel/locking/mutex.c:582 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
Modules linked in:
CPU: 1 PID: 12653 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
lr : __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
sp : ffff800013983aa0
x29: ffff800013983b10 x28: ffff80000ee2b000 x27: 00000000ffffff00
x26: 0000000000000000 x25: 0000000000000046 x24: 0000000000000002
x23: ffff80000878a408 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff000100e2d028 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 00000000000044aa x10: ffff80001f44d000 x9 : 7d4b49b29f0bd400
x8 : 7d4b49b29f0bd400 x7 : 4e5241575f534b43 x6 : ffff80000819545c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000028
Call trace:
 __mutex_lock_common+0x4c4/0xca8 kernel/locking/mutex.c:582
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_setattr+0x298/0x7f4 fs/reiserfs/inode.c:3284
 notify_change+0x758/0x7f0 fs/attr.c:420
 chown_common+0x29c/0x388 fs/open.c:736
 do_fchownat+0xec/0x1a0 fs/open.c:767
 __do_sys_fchownat fs/open.c:782 [inline]
 __se_sys_fchownat fs/open.c:779 [inline]
 __arm64_sys_fchownat+0x30/0x44 fs/open.c:779
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 1633
hardirqs last  enabled at (1633): [<ffff800008223334>] seqcount_lockdep_reader_access include/linux/seqlock.h:104 [inline]
hardirqs last  enabled at (1633): [<ffff800008223334>] ktime_get_coarse_real_ts64+0xfc/0x1bc kernel/time/timekeeping.c:2261
hardirqs last disabled at (1632): [<ffff8000082232c4>] seqcount_lockdep_reader_access include/linux/seqlock.h:101 [inline]
hardirqs last disabled at (1632): [<ffff8000082232c4>] ktime_get_coarse_real_ts64+0x8c/0x1bc kernel/time/timekeeping.c:2261
softirqs last  enabled at (1598): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (1596): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 000000000000003c
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000013197f000
[000000000000003c] pgd=0800000140f65003, p4d=0800000140f65003, pud=0800000140ddf003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 12653 Comm: syz-executor.1 Tainted: G        W          6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : owner_on_cpu include/linux/sched.h:2269 [inline]
pc : mutex_can_spin_on_owner kernel/locking/mutex.c:409 [inline]
pc : mutex_optimistic_spin+0x1c8/0x254 kernel/locking/mutex.c:452
lr : __mutex_lock_common+0x1b4/0xca8 kernel/locking/mutex.c:607
sp : ffff800013983a40
x29: ffff800013983a50 x28: ffff80000ee2b000 x27: ffff80000cb4f733
x26: 0000000000000000 x25: 0000000000000046 x24: ffff000100e2d090
x23: ffff80000878a408 x22: ffff80000d30c000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff000100e2d028 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 00000000000044aa x10: ffff80000d30c000 x9 : 0000000000000003
x8 : 0000000000000008 x7 : 4e5241575f534b43 x6 : ffff80000878a408
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000100e2d028
Call trace:
 mutex_can_spin_on_owner kernel/locking/mutex.c:408 [inline]
 mutex_optimistic_spin+0x1c8/0x254 kernel/locking/mutex.c:452
 __mutex_lock_common+0x1b4/0xca8 kernel/locking/mutex.c:607
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_setattr+0x298/0x7f4 fs/reiserfs/inode.c:3284
 notify_change+0x758/0x7f0 fs/attr.c:420
 chown_common+0x29c/0x388 fs/open.c:736
 do_fchownat+0xec/0x1a0 fs/open.c:767
 __do_sys_fchownat fs/open.c:782 [inline]
 __se_sys_fchownat fs/open.c:779 [inline]
 __arm64_sys_fchownat+0x30/0x44 fs/open.c:779
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
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
