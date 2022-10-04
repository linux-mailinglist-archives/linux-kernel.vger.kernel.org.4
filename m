Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7D5F4628
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJDPHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiJDPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:06:44 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4303D63FF7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 08:06:34 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l84-20020a6b3e57000000b006a3fe90910cso9205656ioa.16
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 08:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=4VLRnsgvpZOtfXxDmrVaOMox+pkZCpeI+RKB7416ubw=;
        b=InmKOtUYDYJtHxoH3PXGIIkIpOp5EXHRxD6QYyyIKZVbjDEYCtPYo7+Gv8az/Fv6+s
         0py2Y3B9WfdWVbX9xQ/DIBcTypLJmmJK+wigCw+zaxcYlH2sELGAoUXSbzkcuik2sEtf
         YYf2cIjAIvgttLKxtr8ft5OjBgwenVHMhmmPs1pcXahbUYuqEofZOoT7bHNGTYkH4MNn
         YSD94qq1KCNQCL5CaozcKXH59RGDPGvAePpN8Jh3jHgFC+zyvvLMtqkKY1I03sRrmPwH
         5ySl6w3zIj5hP1LJEKXjVrY/va+muVsWYfJgQkJVIZRIuWLlAJJV2j0yiq77tDXpO27S
         2l7A==
X-Gm-Message-State: ACrzQf1lGroYrkarpkk6cnTd4hMyx5NtDPxQEt88r1+LVgVwVOjLASKY
        DQeHwseR40b4jewxjDaUqh6rKcSAZAhO4iD5f6JItRj4k0uh
X-Google-Smtp-Source: AMsMyM5ol8Md0DeCycQuYQbLo4T+/nXrO1HJZfz4DXP23zDAiBh6AkfLN7qwD+vu1U9VE48yFVbH/gMgSsMwHLw5YrC11yKV9J/X
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:2f1:68a6:3bec with SMTP id
 r14-20020a056e0219ce00b002f168a63becmr12120972ill.78.1664895993957; Tue, 04
 Oct 2022 08:06:33 -0700 (PDT)
Date:   Tue, 04 Oct 2022 08:06:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ed3c905ea36cec2@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in reiserfs_set_acl
From:   syzbot <syzbot+27d15e986992eff93cd9@syzkaller.appspotmail.com>
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17ec92cc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aae2d21e7dd80684
dashboard link: https://syzkaller.appspot.com/bug?extid=27d15e986992eff93cd9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11078f50b80b/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/398e5f1e6c84/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27d15e986992eff93cd9@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000068
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000131b9c000
[0000000000000068] pgd=080000013f9b8003, p4d=080000013f9b8003, pud=080000012eae9003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 2588 Comm: syz-executor.3 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : d_really_is_negative include/linux/dcache.h:465 [inline]
pc : reiserfs_xattr_jcreate_nblocks fs/reiserfs/xattr.h:79 [inline]
pc : reiserfs_set_acl+0xd0/0x2c0 fs/reiserfs/xattr_acl.c:36
lr : reiserfs_xattr_jcreate_nblocks fs/reiserfs/xattr.h:78 [inline]
lr : reiserfs_set_acl+0xc0/0x2c0 fs/reiserfs/xattr_acl.c:36
sp : ffff80001688b990
x29: ffff80001688b9e0 x28: ffff0000c8cdfc00 x27: 0000000000000002
x26: 0000000000000000 x25: 0000000000000036 x24: 000000000000002b
x23: 0000000000000000 x22: ffff0000eb2ee000 x21: ffff0000ef1d5380
x20: 0000000000004000 x19: ffff0000ed8f8de0 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000002 x13: 0000000000000020 x12: 0000000000040000
x11: 00000000000042eb x10: 000000000000006c x9 : 00000000000001c0
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000c40 x4 : 0000000000000080 x3 : 0000000000004000
x2 : ffff0000ef1d5380 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 reiserfs_xattr_jcreate_nblocks fs/reiserfs/xattr.h:78 [inline]
 reiserfs_set_acl+0xd0/0x2c0 fs/reiserfs/xattr_acl.c:36
 set_posix_acl fs/posix_acl.c:1015 [inline]
 posix_acl_xattr_set+0x1dc/0x23c fs/posix_acl.c:1034
 __vfs_setxattr+0x250/0x260 fs/xattr.c:182
 __vfs_setxattr_noperm+0xcc/0x320 fs/xattr.c:216
 __vfs_setxattr_locked+0x16c/0x194 fs/xattr.c:277
 vfs_setxattr+0x174/0x280 fs/xattr.c:313
 do_setxattr fs/xattr.c:600 [inline]
 setxattr fs/xattr.c:623 [inline]
 path_setxattr+0x354/0x414 fs/xattr.c:642
 __do_sys_lsetxattr fs/xattr.c:665 [inline]
 __se_sys_lsetxattr fs/xattr.c:661 [inline]
 __arm64_sys_lsetxattr+0x2c/0x40 fs/xattr.c:661
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: f942d388 f10002ff 52803809 52800d8a (f9403508) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f942d388 	ldr	x8, [x28, #1440]
   4:	f10002ff 	cmp	x23, #0x0
   8:	52803809 	mov	w9, #0x1c0                 	// #448
   c:	52800d8a 	mov	w10, #0x6c                  	// #108
* 10:	f9403508 	ldr	x8, [x8, #104] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
