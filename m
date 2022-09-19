Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5B5BC2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiISGMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiISGMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:12:40 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311CF1AF36
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:12:38 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id b21-20020a5d8915000000b0068aaf634432so14462800ion.20
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 23:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xFZ8/88ZSPPqC0pTtwfOfwuuvy6tQkm4s2uX0q0HHRE=;
        b=Mp1Th3DzRoRtuvFDFiEcfWhTvHk9aCJF9WWLVTSwcF89Hto08F1EvdDIuT+UuyauYO
         0DDwN8xt4WbTZHbvKMZMBIwenr3RFsMNGoNO6+7NebacUutkZZtaby4j4TiqhCbcp4AX
         pLMJnhGQHhFAxSmiV+8gt04EQIkxjlJEKlDbwYUkuUf4GIY5FIeyXzH5PpnLB1GUBtmW
         EzzkAQBRJG2gVtO9jJyt88Aoc8h77erEWR6RM0FX/fCXer9baAO+UlHIyMlYNP/cvu5Y
         8lBxefUvPZpl8venlmDj0P5U4dcjhYRcCblIa7VnIpCWIKEvy7QWYG0F6fNTzinAczhK
         fkkw==
X-Gm-Message-State: ACrzQf0IhT12ffSVdUzgZeTg/n6voGts8gjup3xZve1Xf7vv8c2ojQCy
        ADkgA9sS8dHU26ZGfxBo9JrOJ8/0zb6nwffrmJs+DbJyxnsC
X-Google-Smtp-Source: AMsMyM5Y4ehE0q4NCUUcbnxYxE8pXXWsAo0bxkz+K+VQgN+p9lPvKyo6FxSZAdAc/4QEUGe+7moNxK8uHcnFVUcAx2yvbXiUm6AJ
MIME-Version: 1.0
X-Received: by 2002:a02:5108:0:b0:35a:eca0:92c1 with SMTP id
 s8-20020a025108000000b0035aeca092c1mr102756jaa.81.1663567957574; Sun, 18 Sep
 2022 23:12:37 -0700 (PDT)
Date:   Sun, 18 Sep 2022 23:12:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002bcef705e90199cd@google.com>
Subject: [syzbot] WARNING in __virt_to_phys
From:   syzbot <syzbot+443228fd71f385302265@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=14fc366f080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
dashboard link: https://syzkaller.appspot.com/bug?extid=443228fd71f385302265
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/81b491dd5861/disk-a6b44374.raw.xz
vmlinux: https://storage.googleapis.com/69c979cdc99a/vmlinux-a6b44374.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+443228fd71f385302265@syzkaller.appspotmail.com

virt_to_phys used for non-linear address: 00000000b6fc6bf9 (0x44006b7369643d45)
WARNING: CPU: 0 PID: 24583 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x80/0x98 arch/arm64/mm/physaddr.c:17
Modules linked in:
CPU: 0 PID: 24583 Comm: syz-executor.3 Not tainted 6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __virt_to_phys+0x80/0x98 arch/arm64/mm/physaddr.c:17
lr : __virt_to_phys+0x7c/0x98 arch/arm64/mm/physaddr.c:12
sp : ffff80001f993b00
x29: ffff80001f993b00 x28: 0000000000000000 x27: ffff0000ed649d68
x26: ffff0000fa388000 x25: 00000000ffff8000
 x24: 0000000000000000

x23: ffff000108325800 x22: 00000000ffff8000 x21: 0000000040000000
x20: 44016b7369643d45 x19: 44006b7369643d45 x18: 00000000000001b8
x17: ffff80000c00d6bc
 x16: ffff80000db78658 x15: ffff0000fa388000
x14: 0000000000000000 x13: 00000000ffffffff x12: 0000000000040000
x11: 0000000000005389 x10: ffff800017fb2000 x9 : 48cd7cd042b5b300
x8 : ffff80000cf0e000 x7 : ffff800008162e5c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000007 x1 : 0000000100000000 x0 : 000000000000004f
Call trace:
 __virt_to_phys+0x80/0x98 arch/arm64/mm/physaddr.c:17
 virt_to_folio include/linux/mm.h:856 [inline]
 kfree+0x70/0x348 mm/slub.c:4556
 nilfs_mdt_destroy+0x24/0x3c fs/nilfs2/mdt.c:497
 nilfs_free_inode+0x2c/0x54 fs/nilfs2/super.c:168
 i_callback fs/inode.c:249 [inline]
 alloc_inode+0xdc/0x104 fs/inode.c:274
 new_inode_pseudo fs/inode.c:1019 [inline]
 new_inode+0x2c/0xc0 fs/inode.c:1047
 nilfs_new_inode+0x48/0x378 fs/nilfs2/inode.c:334
 nilfs_create+0x74/0x17c fs/nilfs2/namei.c:85
 vfs_create+0x1c8/0x270 fs/namei.c:3115
 do_mknodat+0x274/0x3e8 fs/namei.c:3942
 __do_sys_mknodat fs/namei.c:3970 [inline]
 __se_sys_mknodat fs/namei.c:3967 [inline]
 __arm64_sys_mknodat+0x4c/0x64 fs/namei.c:3967
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
irq event stamp: 2368
hardirqs last  enabled at (2367): [<ffff800008162eec>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (2367): [<ffff800008162eec>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
hardirqs last disabled at (2368): [<ffff80000bfc5c8c>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
softirqs last  enabled at (2364): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (2287): [<ffff800008017c48>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
Unable to handle kernel paging request at virtual address 000fffadd38710c8
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
[000fffadd38710c8] address between user and kernel address ranges
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 24583 Comm: syz-executor.3 Tainted: G        W          6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : _compound_head include/linux/page-flags.h:253 [inline]
pc : virt_to_folio include/linux/mm.h:858 [inline]
pc : kfree+0x80/0x348 mm/slub.c:4556
lr : virt_to_folio include/linux/mm.h:856 [inline]
lr : kfree+0x70/0x348 mm/slub.c:4556
sp : ffff80001f993b20
x29: ffff80001f993b30 x28: 0000000000000000 x27: ffff0000ed649d68
x26: ffff0000fa388000 x25: 00000000ffff8000 x24: 0000000000000000
x23: ffff000108325800
 x22: 00000000ffff8000
 x21: 010fffadd38710c0
x20: ffff800008f58ab8
 x19: 44006b7369643d45 x18: 00000000000001b8
x17: ffff80000c00d6bc
 x16: ffff80000db78658 x15: ffff0000fa388000
x14: 0000000000000000
 x13: 00000000ffffffff x12: 0000000000040000
x11: 0000000000005389
 x10: ffff800017fb2000 x9 : fffffc0000000000
x8 : 0004400eb74e1c43 x7 : ffff800008162e5c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000007 x1 : 0000000100000000 x0 : 4400eb7521c43d45
Call trace:
 virt_to_folio include/linux/mm.h:856 [inline]
 kfree+0x80/0x348 mm/slub.c:4556
 nilfs_mdt_destroy+0x24/0x3c fs/nilfs2/mdt.c:497
 nilfs_free_inode+0x2c/0x54 fs/nilfs2/super.c:168
 i_callback fs/inode.c:249 [inline]
 alloc_inode+0xdc/0x104 fs/inode.c:274
 new_inode_pseudo fs/inode.c:1019 [inline]
 new_inode+0x2c/0xc0 fs/inode.c:1047
 nilfs_new_inode+0x48/0x378 fs/nilfs2/inode.c:334
 nilfs_create+0x74/0x17c fs/nilfs2/namei.c:85
 vfs_create+0x1c8/0x270 fs/namei.c:3115
 do_mknodat+0x274/0x3e8 fs/namei.c:3942
 __do_sys_mknodat fs/namei.c:3970 [inline]
 __se_sys_mknodat fs/namei.c:3967 [inline]
 __arm64_sys_mknodat+0x4c/0x64 fs/namei.c:3967
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
 el0t_64_sync+0x18c/0x190
Code: d34cfc08 cb953108 b25657e9 8b081935 (f94006a8) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d34cfc08 	lsr	x8, x0, #12
   4:	cb953108 	sub	x8, x8, x21, asr #12
   8:	b25657e9 	mov	x9, #0xfffffc0000000000    	// #-4398046511104
   c:	8b081935 	add	x21, x9, x8, lsl #6
* 10:	f94006a8 	ldr	x8, [x21, #8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
