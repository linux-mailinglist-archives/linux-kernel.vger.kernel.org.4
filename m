Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDC56182FC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiKCPgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiKCPgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:36:41 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C22167D8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:36:40 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id q17-20020a5d87d1000000b006d21a9cca67so1268068ios.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 08:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmBanKmH3B77hr7XKdZXp0mnnw6233CG5cr0B84kKMo=;
        b=7ZLO7oexo22uKg3rEeV1q3AK/wPxUxCEW/3sf8cqdwdz0/ZDbwcFhWcxPEvmkxA2WL
         o5jeyTwwXoGBjyORBz59vGQwcjAWGIhx9c1rCwj/vl5URXyRo0xZnvknKvDFS1U971EM
         7v+1f0gDQPN4P9WlNw8Ehi86D4MLQKpYg6kMGeooj+3FihHVM4BVKzMYx0qFThNu5RSd
         1+gGNdk3pYOhPod0cjNtnTrH7dzMU71ITJI87eH2k9NvL7Uj/wf0m4x5vRG2Pl6f2ek+
         tcZuqi3vzxxILPJQhwdAh7gmXbg2C8MpANSagDMpp+8YqdqWyz2eOto9ibS9nkA/KHLZ
         iPgw==
X-Gm-Message-State: ACrzQf15nf8miEhx7il5uoWwm8txt8r41uAVJT2aTS3ShffBlQFrS2bO
        7fbn8PLuzFMD80ozX6qZaODd4nceyEB3uVue5BxFJx5Bkv4h
X-Google-Smtp-Source: AMsMyM5+5MJe7Y/B16++THF4wH5AA2DXzrzhsHVfFR88Qo9qW55ymSH90H9Up1TE5QMfyiKRPlKhubPAYcIckFyIEPlVbIdFuipq
MIME-Version: 1.0
X-Received: by 2002:a92:d603:0:b0:300:941d:f302 with SMTP id
 w3-20020a92d603000000b00300941df302mr17232432ilm.176.1667489799717; Thu, 03
 Nov 2022 08:36:39 -0700 (PDT)
Date:   Thu, 03 Nov 2022 08:36:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ddd5805ec92b9f9@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in __get_metapage
From:   syzbot <syzbot+3367cd73f9cc686a9763@syzkaller.appspotmail.com>
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11143afc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=3367cd73f9cc686a9763
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3367cd73f9cc686a9763@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000156537000
[0000000000000030] pgd=080000015320e003, p4d=080000015320e003, pud=08000001530cd003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 15207 Comm: syz-executor.2 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __get_metapage+0xd4/0x7e0
lr : __get_metapage+0xa0/0x7e0 fs/jfs/jfs_metapage.c:600
sp : ffff80001f743a50
x29: ffff80001f743a50 x28: 000000000000000c x27: 0000000000000000
x26: ffff80000d532000 x25: 0000000000001000 x24: 000000000000000b
x23: 0000000000001000 x22: ffff0001122b1e88 x21: 0000000000000001
x20: 0000000000000000 x19: 000000000000000b x18: 00000000000000a5
x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff0001233a3500
x14: 0000000000000008 x13: 00000000ffffffff x12: 0000000000040000
x11: 000000000000a262 x10: ffff800018655000 x9 : ffff800008d539c4
x8 : 0000000000000000 x7 : ffff8000085e8ba4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000001
x2 : 0000000000001000 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 __get_metapage+0xd4/0x7e0
 diReadSpecial+0xf0/0x218 fs/jfs/jfs_imap.c:443
 jfs_mount+0xf4/0x468 fs/jfs/jfs_mount.c:108
 jfs_fill_super+0x188/0x454 fs/jfs/super.c:556
 mount_bdev+0x1b8/0x210 fs/super.c:1400
 jfs_do_mount+0x44/0x58 fs/jfs/super.c:670
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: eb15033f 540006e2 97d53089 aa1603e8 (f9401915) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	eb15033f 	cmp	x25, x21
   4:	540006e2 	b.cs	0xe0  // b.hs, b.nlast
   8:	97d53089 	bl	0xffffffffff54c22c
   c:	aa1603e8 	mov	x8, x22
* 10:	f9401915 	ldr	x21, [x8, #48] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
