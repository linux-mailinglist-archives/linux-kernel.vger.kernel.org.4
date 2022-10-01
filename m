Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0511C5F1C62
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiJANg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJANgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:36:48 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D257C196
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:36:38 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id y10-20020a5d914a000000b00688fa7b2252so4441362ioq.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=LSlTHf9hpUrOL2lZ2N5F7aIq3I9D+jsrHS8MaUdQy4c=;
        b=raoLO19yQ6y2kJIk8hziczkPNVoB+xery5oDJ+2fQ6GcUMclD/pOeCiQdxU4Qc7Jra
         1HIjYsUh8S1x41kAhRRQu1o4xvvh5uNK4C2DjR/zCpCQ4974q0ibhKA6WiPXeng/NBM9
         eMSGKi93pZ7onPvwYwBet1qL6DfASGwq1CWKWKt0CzRf1RM9iyp5Sr2kWFdRzQe5uCey
         yx9gVK4RP+l7lvJndtMb6AFwR8k4QhF2gkEido9Ge1X/TJGTPPCaOmJCCy2WTJY5Mfqm
         /sDjJiMbu7DOTORSDx+QsMJi4ACxfdUM04jcdzII1ttadtk0CHcPDlJnSIwoNQ0vYwIp
         LSPg==
X-Gm-Message-State: ACrzQf1ex+dsk+mZwI34wCq/z6wxfRwAiw3xYwovRrymLogE23ilXrfB
        29Fjx/2N3vif/tPum6XTIFDcGHdi/uttCofj4WVlyahhyd/Y
X-Google-Smtp-Source: AMsMyM4+YKN6KZ42PVYmLs6ZIo4vgPcXqNHt6/+Z/oLYv04HS2c//Ya/EweYDuFGqV6xME+KdgZUUCkRcx9s4igZZKYdeEW6VNlN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3729:b0:35a:837d:e324 with SMTP id
 k41-20020a056638372900b0035a837de324mr6985273jav.226.1664631398064; Sat, 01
 Oct 2022 06:36:38 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:36:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029f80705e9f933f9@google.com>
Subject: [syzbot] WARNING in dbAllocBits
From:   syzbot <syzbot+e6a47211665dce6af915@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    c194837ebb57 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12e45ca8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=e6a47211665dce6af915
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14632d40880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134260ec880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6a47211665dce6af915@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
WARNING: CPU: 1 PID: 3069 at kernel/locking/mutex.c:918 __mutex_unlock_slowpath+0xd8/0x1cc kernel/locking/mutex.c:918
Modules linked in:
CPU: 1 PID: 3069 Comm: syz-executor273 Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_unlock_slowpath+0xd8/0x1cc kernel/locking/mutex.c:918
lr : __mutex_unlock_slowpath+0xd8/0x1cc kernel/locking/mutex.c:918
sp : ffff80000ff93670
x29: ffff80000ff93690 x28: ffff0000cd21e000 x27: 0000000000000001
x26: ffff80000d30c000 x25: ffff0000c68db500 x24: ffff80000ee2b000
x23: ffff80000cb54135 x22: ffff80000cb5415a x21: ffff80000cb4f56b
x20: ffff0000c68db4ff x19: ffff0000cb316450 x18: fffffffffffffff5
x17: ffff80000dd0b198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: ffff80000d5ef920
x11: ff808000081c1630 x10: 0000000000000000 x9 : b51a2818168f2500
x8 : b51a2818168f2500 x7 : 4e5241575f534b43 x6 : ffff800008195d30
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000039
Call trace:
 __mutex_unlock_slowpath+0xd8/0x1cc kernel/locking/mutex.c:918
 mutex_unlock+0x24/0x30 kernel/locking/mutex.c:543
 dbAllocBits+0x364/0x3b0 fs/jfs/jfs_dmap.c:2225
 dbAllocDmap+0x44/0xd0 fs/jfs/jfs_dmap.c:1999
 dbAllocNext+0x280/0x290 fs/jfs/jfs_dmap.c:1152
 dbAlloc+0x200/0x694 fs/jfs/jfs_dmap.c:786
 extBalloc+0xd0/0x368 fs/jfs/jfs_extent.c:321
 extAlloc+0x16c/0x384 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x1b4/0x3ec fs/jfs/inode.c:248
 __block_write_begin_int+0x240/0x95c fs/buffer.c:2006
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x74/0x14c fs/buffer.c:2117
 jfs_write_begin+0x44/0x88 fs/jfs/inode.c:304
 generic_perform_write+0xf0/0x2cc mm/filemap.c:3738
 __generic_file_write_iter+0xd8/0x21c mm/filemap.c:3866
 generic_file_write_iter+0x6c/0x168 mm/filemap.c:3898
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x2dc/0x46c fs/read_write.c:578
 ksys_write+0xb4/0x160 fs/read_write.c:631
 __do_sys_write fs/read_write.c:643 [inline]
 __se_sys_write fs/read_write.c:640 [inline]
 __arm64_sys_write+0x24/0x34 fs/read_write.c:640
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
irq event stamp: 23765
hardirqs last  enabled at (23765): [<ffff80000bfcbcdc>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (23765): [<ffff80000bfcbcdc>] _raw_spin_unlock_irq+0x3c/0x70 kernel/locking/spinlock.c:202
hardirqs last disabled at (23764): [<ffff80000bfcbadc>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:117 [inline]
hardirqs last disabled at (23764): [<ffff80000bfcbadc>] _raw_spin_lock_irq+0x34/0x9c kernel/locking/spinlock.c:170
softirqs last  enabled at (21988): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (21653): [<ffff800008017c14>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address ffff80000d272a70
Mem abort info:
  ESR = 0x0000000096000047
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000047
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c566a000
[ffff80000d272a70] pgd=100000023ffff003, p4d=100000023ffff003, pud=100000023fffe003, pmd=100000023fffa003, pte=0000000000000000
Internal error: Oops: 0000000096000047 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3069 Comm: syz-executor273 Tainted: G        W          6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x198/0x380 kernel/locking/qspinlock.c:474
lr : queued_spin_lock_slowpath+0x114/0x380 kernel/locking/qspinlock.c:405
sp : ffff80000ff935e0
x29: ffff80000ff935e0 x28: ffff0000cd21e000 x27: 0000000000000001
x26: ffff80000d30c000 x25: ffff0000c68db500 x24: ffff0001fefd0a40
x23: 0000000000000000 x22: ffff80000d30cf28 x21: ffff80000d272a40
x20: 0000000000000000 x19: ffff0000cb316458 x18: fffffffffffffff5
x17: ffff80000dd0b198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 000000000000ffff x12: 0000000000000000
x11: ffff80000d272a70 x10: 0000000000040000 x9 : ffff0001fefd0a48
x8 : ffff0001fefd0a40 x7 : 0000000000000000 x6 : ffff80000bfc55b8
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffff80000ce2689f x0 : 0000000000000001
Call trace:
 decode_tail kernel/locking/qspinlock.c:131 [inline]
 queued_spin_lock_slowpath+0x198/0x380 kernel/locking/qspinlock.c:471
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x10c/0x110 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x5c/0x6c kernel/locking/spinlock.c:154
 __mutex_unlock_slowpath+0x138/0x1cc kernel/locking/mutex.c:932
 mutex_unlock+0x24/0x30 kernel/locking/mutex.c:543
 dbAllocBits+0x364/0x3b0 fs/jfs/jfs_dmap.c:2225
 dbAllocDmap+0x44/0xd0 fs/jfs/jfs_dmap.c:1999
 dbAllocNext+0x280/0x290 fs/jfs/jfs_dmap.c:1152
 dbAlloc+0x200/0x694 fs/jfs/jfs_dmap.c:786
 extBalloc+0xd0/0x368 fs/jfs/jfs_extent.c:321
 extAlloc+0x16c/0x384 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x1b4/0x3ec fs/jfs/inode.c:248
 __block_write_begin_int+0x240/0x95c fs/buffer.c:2006
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x74/0x14c fs/buffer.c:2117
 jfs_write_begin+0x44/0x88 fs/jfs/inode.c:304
 generic_perform_write+0xf0/0x2cc mm/filemap.c:3738
 __generic_file_write_iter+0xd8/0x21c mm/filemap.c:3866
 generic_file_write_iter+0x6c/0x168 mm/filemap.c:3898
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x2dc/0x46c fs/read_write.c:578
 ksys_write+0xb4/0x160 fs/read_write.c:631
 __do_sys_write fs/read_write.c:643 [inline]
 __se_sys_write fs/read_write.c:640 [inline]
 __arm64_sys_write+0x24/0x34 fs/read_write.c:640
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
Code: 8b2c4ecc f85f818c 1200056b 8b2b52ab (f82b6988) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8b2c4ecc 	add	x12, x22, w12, uxtw #3
   4:	f85f818c 	ldur	x12, [x12, #-8]
   8:	1200056b 	and	w11, w11, #0x3
   c:	8b2b52ab 	add	x11, x21, w11, uxtw #4
* 10:	f82b6988 	str	x8, [x12, x11] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
