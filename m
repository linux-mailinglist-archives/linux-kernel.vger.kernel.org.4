Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7B160576E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiJTGho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJTGhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:37:41 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDEF18C414
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:37:40 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s2-20020a056e02216200b002f9de38e484so19293067ilv.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YK2IuU4LkO8PftlPkuCYZ3pMTMPqC2CnwJ0QSD9l1HM=;
        b=RYZFVAz5kuUpBXoX1gIsRHer/RbKfHPjj163LauHr+ybpDd7CZuDp5uDGXR47DHaD0
         qA9c0JK2NfvSLP3NQRBh+bsxsHlpMRSfCX7IMDtrqyISv/O1BSD35wbxfe3kK5YUCkdE
         S5w0TCLWEvppBS+KAKzKaWgpH3jHTR3mCsClJkaLGWeGfAHGS1q8QD1IaQJ2gRb0blKD
         jy4thwiIzv/dBHX04jnTFhENuybQKkI3cVeQuTDbMuGYt+qyo5jz+90UQRvf/0tJYmIV
         waP+7r+Dwu1DXRJ3SyOQAwIToE76xgFrPYBbB7ebQxLc5yj1Im5fIVAbzMuyPuvI9Ml0
         5Rtg==
X-Gm-Message-State: ACrzQf3L+pFPohDCZxcNs4ItA3u26jjBf/qkWvYQ3O6WYxeXQ3nOX/AK
        NxBmJb+Lk31/RLtCqPD+T2qHOmxPqnyUQjihzASKX4aKp36h
X-Google-Smtp-Source: AMsMyM5KIowt8hCyeE2JJ+ap+TRmZ8T7wtsmhiRXfBL8RuBj98SGZ3TH1u/QNtesbZwLX4BD86velAHGio4agsgSkOTPX6mZJtUH
MIME-Version: 1.0
X-Received: by 2002:a5d:9c11:0:b0:6bc:674b:1a2d with SMTP id
 17-20020a5d9c11000000b006bc674b1a2dmr8685303ioe.164.1666247859834; Wed, 19
 Oct 2022 23:37:39 -0700 (PDT)
Date:   Wed, 19 Oct 2022 23:37:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb197c05eb718fe5@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in dquot_add_space
From:   syzbot <syzbot+7f3f0e8b232d8c69dac1@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=12890b76880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3f0e8b232d8c69dac1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f3f0e8b232d8c69dac1@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address 0000000100000117
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000018f1e0000
[0000000100000117] pgd=08000001607e1003, p4d=08000001607e1003, pud=0000000000000000
Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 22205 Comm: syz-executor.2 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dquot_add_space+0x3c/0x474 fs/quota/dquot.c:1329
lr : dquot_add_space+0x3c/0x474 fs/quota/dquot.c:1327
sp : ffff8000208cb590
x29: ffff8000208cb5a0 x28: ffff000119271800 x27: 0000000000000001
x26: ffff8000208cb610 x25: 00000000ffffffff x24: ffff00010e158840
x23: 0000000000000001 x22: 0000000000010000 x21: 00000000ffffffff
x20: 0000000000000000 x19: ffff80000d47eb10 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c8173500
x14: ffff80000dd0b198 x13: ffff80000db49158 x12: 0000000000040000
x11: 0000000000003c98 x10: ffff800018493000 x9 : ffff8000086badbc
x8 : 0000000000003c99 x7 : ffff8000086ba810 x6 : 0000000000000000
x5 : 0000000000000020 x4 : ffff8000208cb610 x3 : 0000000000000001
x2 : 0000000000000000 x1 : 0000000000010000 x0 : 00000000ffffffff
Call trace:
 dquot_add_space+0x3c/0x474 fs/quota/dquot.c:1327
 __dquot_alloc_space+0x1c8/0x644
 dquot_alloc_space_nodirty include/linux/quotaops.h:300 [inline]
 dquot_alloc_space include/linux/quotaops.h:313 [inline]
 dquot_alloc_block include/linux/quotaops.h:337 [inline]
 ext4_mb_new_blocks+0x5fc/0x9e4 fs/ext4/mballoc.c:5574
 ext4_new_meta_blocks+0x84/0x140 fs/ext4/balloc.c:700
 ext4_xattr_block_set+0xce0/0x142c fs/ext4/xattr.c:2078
 ext4_xattr_set_handle+0x724/0x994 fs/ext4/xattr.c:2394
 ext4_xattr_set+0x100/0x1d0 fs/ext4/xattr.c:2495
 ext4_xattr_security_set+0x4c/0x64 fs/ext4/xattr_security.c:31
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
Code: aa0203f4 aa0103f6 aa0003f5 97ef9397 (f9408ebc) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	aa0203f4 	mov	x20, x2
   4:	aa0103f6 	mov	x22, x1
   8:	aa0003f5 	mov	x21, x0
   c:	97ef9397 	bl	0xffffffffffbe4e68
* 10:	f9408ebc 	ldr	x28, [x21, #280] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
