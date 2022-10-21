Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1986076D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJUMV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJUMVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:21:46 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C1475CF8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:21:45 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i4-20020a056e02152400b002fa876e95b3so3408025ilu.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pnLQEi49b7eMYSApkCD1PoDhPgZzcH1PN7FDHx9LS0=;
        b=KxJGOC1siHJ2yaFGDEaQuLKHvbondiZ5NLmlpHLKzdxOCjUiY7q/A6AJgH1GNfN+mO
         tOOhpbMAoqGQGiO3um7qGHN3XH/6MpNElqmbRmhwmZ8DMFnAf387hfHS/DVGZxsq14Ot
         TH0GGehCxNlb3lPYwYx9zpckpLZ1jO3eooHIBOS5KvjCyEUWV0kH2MTjV5OWjq/oJptn
         Q2lSfeioGnWdTVl7gc1fFO8C/9ywnqJBgGbAxCeaJnQIAzGvtv4A920WS6Ds0C/dIJnq
         T1C3ZrOVBMKSoRe8Y2+macS6bmOBBUBL2uapFagqYnVPGxd47v5XEHVsGNJuvSDn4n/1
         6ArQ==
X-Gm-Message-State: ACrzQf0FtkquBbFfkxMDuF7xBkS4kabYrN0+SkJ972Y8U1rbpNssPM8m
        FnzRUS1Pze7dGETPNtxdLLRqAObN9BkDsuogLdphAxs+4yti
X-Google-Smtp-Source: AMsMyM4emuHDYp5cKxwfqAjqh6rV1xnetav+FIqN2TQwI+JPR73d97kjNktx/C+tQRlsBcZRwNaDfmcb+N9hOPmdbRYgSXGWXNqR
MIME-Version: 1.0
X-Received: by 2002:a5d:9411:0:b0:6a7:f7ec:6dd8 with SMTP id
 v17-20020a5d9411000000b006a7f7ec6dd8mr13104822ion.44.1666354904452; Fri, 21
 Oct 2022 05:21:44 -0700 (PDT)
Date:   Fri, 21 Oct 2022 05:21:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026532c05eb8a7ce2@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in dquot_add_inodes
From:   syzbot <syzbot+60faec7a78ed9879d6b9@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15ea75d2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=60faec7a78ed9879d6b9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+60faec7a78ed9879d6b9@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem without journal. Quota mode: writeback.
Unable to handle kernel paging request at virtual address 00000001000000e7
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000133af2000
[00000001000000e7] pgd=0800000135e12003, p4d=0800000135e12003, pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 8925 Comm: syz-executor.0 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 804000c5 (Nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __lock_acquire+0x60/0x30a4 kernel/locking/lockdep.c:4923
lr : lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
sp : ffff800015adb3d0
x29: ffff800015adb4b0 x28: 0000000000000000 x27: 0000000000000000
x26: 00000001000000e7 x25: ffff8000086bb660 x24: 0000000000000000
x23: 0000000000000000 x22: 00000001000000e7 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000000 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000e3f44f80
x14: ffff80000dd0b198 x13: ffff80000db49158 x12: 0000000000040000
x11: 0000000000001abd x10: ffff800012e18000 x9 : 0000000000000001
x8 : 0000000000000001 x7 : ffff8000086bb660 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000001000000e7
Call trace:
 __lock_acquire+0x60/0x30a4 kernel/locking/lockdep.c:4923
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x54/0x6c kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 dquot_add_inodes+0x38/0x36c fs/quota/dquot.c:1285
 dquot_alloc_inode+0xdc/0x434 fs/quota/dquot.c:1751
 ext4_xattr_inode_alloc_quota fs/ext4/xattr.c:888 [inline]
 ext4_xattr_set_entry+0x294/0xe28 fs/ext4/xattr.c:1661
 ext4_xattr_block_set+0x3d4/0x142c fs/ext4/xattr.c:1971
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
Code: 2a0303f4 2a0203f7 aa0003fa 34000148 (f9400348) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	2a0303f4 	mov	w20, w3
   4:	2a0203f7 	mov	w23, w2
   8:	aa0003fa 	mov	x26, x0
   c:	34000148 	cbz	w8, 0x34
* 10:	f9400348 	ldr	x8, [x26] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
