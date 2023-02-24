Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FEC6A1D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBXOnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBXOnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:43:42 -0500
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD7F10268
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:43:40 -0800 (PST)
Received: by mail-io1-f79.google.com with SMTP id a21-20020a5d9595000000b0074c9dc19e16so3730954ioo.15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 06:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vhNhDtCJAHygFr5mhS/Wz48xvVC0K933eE1y561LX8=;
        b=Rr8a85gaMwGxVe1vkcFIP+iu8YrgtF9iTWYtFTqXkUqfZoqn/c00Kka4G2OKNGdSZP
         1RJ8liLPv9MUe/CBbROrlz1jYmYJV0Q/6X2EvB2GZ25gcXEZnt70rFimDMHsRM5Zup8R
         GUck68FHg/3+74XbivuOwCU/ZC+qkydeu8cSGNxcT88uOdRFe8PsgKVbbhkg1wYvvx3e
         guDW1TRx93VltpJmZDD43y0jixS1ChnJL4/C3yzJmFLkeMQT5IZ71pFmfyZHskfn3YHz
         YMlZ60y/T34cbxLGVjdeP63bG5Nirw8YiKhSWT71vmg+KidsQul+cfNRHf1MjcHxXYiO
         FGYQ==
X-Gm-Message-State: AO0yUKWK5kHdoEFlFQUC4QvgM0F8JFsezP3BsrlQyA15CUcdFfkSHx8O
        Bv7th1sRUZQJ3Q6UpSeliburKLBrZdCz5QbtQ7HOB/gFDlqJ
X-Google-Smtp-Source: AK7set/hfTFqfGmln4NGCIwq8OaziDx+SmPi49INxJIjpCaRZalddl8K9A7Zc7kyaAVbwlAvG0BDWvnlnm/zIT6BzwEBPOGoyhwn
MIME-Version: 1.0
X-Received: by 2002:a02:b1c7:0:b0:3a7:e46f:ffc with SMTP id
 u7-20020a02b1c7000000b003a7e46f0ffcmr5315145jah.0.1677249819765; Fri, 24 Feb
 2023 06:43:39 -0800 (PST)
Date:   Fri, 24 Feb 2023 06:43:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4f0d505f5732704@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in call_usermodehelper_exec_work
From:   syzbot <syzbot+ed63f5009044b5dc16ba@syzkaller.appspotmail.com>
To:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
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

HEAD commit:    2d3827b3f393 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15b1d290c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606ed7eeab569393
dashboard link: https://syzkaller.appspot.com/bug?extid=ed63f5009044b5dc16ba
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd94d68ff17d/disk-2d3827b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f304fbef0773/vmlinux-2d3827b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74eb318f51b0/Image-2d3827b3.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed63f5009044b5dc16ba@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 5159 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4729 [inline]
WARNING: CPU: 0 PID: 5159 at kernel/locking/lockdep.c:231 __lock_acquire+0x2c0/0x2f48 kernel/locking/lockdep.c:5005
Modules linked in:
CPU: 0 PID: 5159 Comm: kworker/u4:11 Not tainted 6.2.0-rc7-syzkaller-17907-g2d3827b3f393 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Workqueue: events_unbound call_usermodehelper_exec_work
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4729 [inline]
pc : __lock_acquire+0x2c0/0x2f48 kernel/locking/lockdep.c:5005
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4729 [inline]
lr : __lock_acquire+0x2a8/0x2f48 kernel/locking/lockdep.c:5005
sp : ffff80002054bb00
x29: ffff80002054bbe0 x28: ffff0000e74b2440 x27: ffff80000d2c49a4
x26: ffff0000e74b2420 x25: 0000000000000001 x24: 0000000000000000
x23: 0000000000000001 x22: 0000000000000000 x21: ffff0000e74b23d0
x20: 0000000000000002 x19: aaaaaaaaaaa31957 x18: 0000000000000000
x17: 000000000000ba7e x16: 0000000000000001 x15: ffff80000dbd2118
x14: ffff0000e74b1a00 x13: 0000000000000012 x12: ffff0000e74b1a00
x11: ffff80000dd94158 x10: 0000000000000000 x9 : da680f1092402900
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000bf650d4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
Call trace:
 check_wait_context kernel/locking/lockdep.c:4729 [inline]
 __lock_acquire+0x2c0/0x2f48 kernel/locking/lockdep.c:5005
 lock_acquire+0x164/0x334 kernel/locking/lockdep.c:5668
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x68/0x88 kernel/locking/spinlock.c:162
 complete+0x24/0x90 kernel/sched/completion.c:32
 call_usermodehelper_exec_work+0x128/0x17c
 process_one_work+0x3ac/0x9d0 kernel/workqueue.c:2289
 worker_thread+0x340/0x608 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:870
irq event stamp: 115998
hardirqs last  enabled at (115997): [<ffff80000bf56d78>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:84 [inline]
hardirqs last  enabled at (115997): [<ffff80000bf56d78>] exit_to_kernel_mode+0xe8/0x118 arch/arm64/kernel/entry-common.c:94
hardirqs last disabled at (115998): [<ffff80000bf6a910>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (115998): [<ffff80000bf6a910>] _raw_spin_lock_irqsave+0x2c/0x88 kernel/locking/spinlock.c:162
softirqs last  enabled at (115906): [<ffff80000bbed718>] spin_unlock_bh include/linux/spinlock.h:395 [inline]
softirqs last  enabled at (115906): [<ffff80000bbed718>] ieee80211_ibss_work+0x170/0x9d8 net/mac80211/ibss.c:1701
softirqs last disabled at (115904): [<ffff80000bbed610>] spin_lock_bh include/linux/spinlock.h:355 [inline]
softirqs last disabled at (115904): [<ffff80000bbed610>] ieee80211_ibss_work+0x68/0x9d8 net/mac80211/ibss.c:1690
---[ end trace 0000000000000000 ]---
Unable to handle kernel NULL pointer dereference at virtual address 00000000000000b8
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001274f6000
[00000000000000b8] pgd=0800000127562003, p4d=0800000127562003, pud=0800000109882003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 5159 Comm: kworker/u4:11 Tainted: G        W          6.2.0-rc7-syzkaller-17907-g2d3827b3f393 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Workqueue: events_unbound call_usermodehelper_exec_work
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : check_wait_context kernel/locking/lockdep.c:4729 [inline]
pc : __lock_acquire+0x2e0/0x2f48 kernel/locking/lockdep.c:5005
lr : hlock_class kernel/locking/lockdep.c:231 [inline]
lr : check_wait_context kernel/locking/lockdep.c:4729 [inline]
lr : __lock_acquire+0x2a8/0x2f48 kernel/locking/lockdep.c:5005
sp : ffff80002054bb00
x29: ffff80002054bbe0 x28: ffff0000e74b2440 x27: ffff80000d2c49a4
x26: ffff0000e74b2420 x25: 0000000000000001 x24: 0000000000000000
x23: 0000000000000001 x22: 0000000000000000 x21: ffff0000e74b23d0
x20: 0000000000000002 x19: aaaaaaaaaaa31957 x18: 0000000000000000
x17: 000000000000ba7e x16: 0000000000000001 x15: ffff80000dbd2118
x14: ffff0000e74b1a00 x13: 0000000000000012 x12: ffff0000e74b1a00
x11: ffff80000dd94158 x10: 0000000000000000 x9 : 00000000000c1957
x8 : 0000000000000000 x7 : 4e5241575f534b43 x6 : ffff80000bf650d4
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000016
Call trace:
 hlock_class kernel/locking/lockdep.c:222 [inline]
 check_wait_context kernel/locking/lockdep.c:4730 [inline]
 __lock_acquire+0x2e0/0x2f48 kernel/locking/lockdep.c:5005
 lock_acquire+0x164/0x334 kernel/locking/lockdep.c:5668
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x68/0x88 kernel/locking/spinlock.c:162
 complete+0x24/0x90 kernel/sched/completion.c:32
 call_usermodehelper_exec_work+0x128/0x17c
 process_one_work+0x3ac/0x9d0 kernel/workqueue.c:2289
 worker_thread+0x340/0x608 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:870
Code: 910461ef 9002dfeb 9105616b b9400389 (3942e118) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	910461ef 	add	x15, x15, #0x118
   4:	9002dfeb 	adrp	x11, 0x5bfc000
   8:	9105616b 	add	x11, x11, #0x158
   c:	b9400389 	ldr	w9, [x28]
* 10:	3942e118 	ldrb	w24, [x8, #184] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
