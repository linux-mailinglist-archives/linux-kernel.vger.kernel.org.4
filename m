Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E8772D49A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbjFLWmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 18:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjFLWmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:42:13 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5A121
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:42:11 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77a55f64dbaso548733739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686609731; x=1689201731;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03CwWPtNpjZn2+VqtMiwIjTRdCtuV2Q+AKbauGSX8sw=;
        b=YLe5gfqFtCZX+HuusTk/D+s/xuxHccFmlRDPX3gUH3NIW/gqJaVm2wSg+ST/+tmckW
         wsc4jc8X2NnTR+gF/HnhP1w283/ijfCgSNQUuv98GgeLnMnm3jPCBGXYiGtw2nOuObnU
         YQFRPIIwXhcQhTOXgk1WgDq0pSNG0ezO/GH5ixLhZUGmYreoInqBf7uNBjLjL+cQ34Z5
         4kh9a1UPI2SJUNtezbAeu1B4RkzCm8Vc/qCTegHnG84sprB6CjYCXj95PkvU3ugHYAZz
         lqGYJwQOah6SSzMtCb82SJloOcWETojEO6E+dh8sayQTl0kUHOjQ5XIaR/DsNnOfXYvF
         Zu2Q==
X-Gm-Message-State: AC+VfDzkcvgVUczV+E3KhS46htBzRnRk/yAi1Jm1dgdTi5qHvLhefy3u
        Kk99L9Lsz0fin6WXX8igqrN3xo8Ey968BFNQRIs9B374I2Nr
X-Google-Smtp-Source: ACHHUZ5IVgqV9tzRTu/ac2FX1lgOBGtdKKBMQZLoe6TCAvoC+ZYLnnGFf8ogyUd/hdm0WBaJxYCdtEV55tLfwp42LLZf6UKzhLvr
MIME-Version: 1.0
X-Received: by 2002:a05:6638:10c8:b0:420:d4da:3947 with SMTP id
 q8-20020a05663810c800b00420d4da3947mr4838858jad.4.1686609730882; Mon, 12 Jun
 2023 15:42:10 -0700 (PDT)
Date:   Mon, 12 Jun 2023 15:42:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e274a205fdf66d0a@google.com>
Subject: [syzbot] [net?] WARNING in print_tainted (2)
From:   syzbot <syzbot+732b84af10976114e761@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    022ce8862dff Merge tag 'i2c-for-6.4-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cd352d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=869b244dcd5d983c
dashboard link: https://syzkaller.appspot.com/bug?extid=732b84af10976114e761
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-022ce886.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81969b6d173b/vmlinux-022ce886.xz
kernel image: https://storage.googleapis.com/syzbot-assets/95a50e8c0f0b/zImage-022ce886.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+732b84af10976114e761@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 12513 at mm/mmap.c:965 vma_merge+0x170/0x818 mm/mmap.c:965
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 12513 Comm: syz-executor.1 Not tainted 6.4.0-rc5-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: 
[<817da338>] (dump_backtrace) from [<817da42c>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:826229c4 r5:60000093 r4:81f9d90c
[<817da414>] (show_stack) from [<817f6f14>] (__dump_stack lib/dump_stack.c:88 [inline])
[<817da414>] (show_stack) from [<817f6f14>] (dump_stack_lvl+0x48/0x54 lib/dump_stack.c:106)
[<817f6ecc>] (dump_stack_lvl) from [<817f6f38>] (dump_stack+0x18/0x1c lib/dump_stack.c:113)
 r5:00000000 r4:82850d14
[<817f6f20>] (dump_stack) from [<817daf24>] (panic+0x120/0x370 kernel/panic.c:340)
[<817dae04>] (panic) from [<80241fd0>] (print_tainted+0x0/0xa0 kernel/panic.c:236)
 r3:8260c488 r2:00000001 r1:81f86a00 r0:81f8e410
 r7:80465728
[<80241f4c>] (check_panic_on_warn) from [<802421c4>] (__warn+0x7c/0x180 kernel/panic.c:673)
[<80242148>] (__warn) from [<802423a0>] (warn_slowpath_fmt+0xd8/0x1d8 kernel/panic.c:697)
 r8:00000009 r7:000003c5 r6:81fb2798 r5:8260c960 r4:824adf7c
[<802422cc>] (warn_slowpath_fmt) from [<80465728>] (vma_merge+0x170/0x818 mm/mmap.c:965)
 r10:00000000 r9:00000000 r8:847a4f00 r7:200e2000 r6:85c93630 r5:00000000
 r4:85c939f8
[<804655b8>] (vma_merge) from [<80531bf8>] (userfaultfd_register fs/userfaultfd.c:1485 [inline])
[<804655b8>] (vma_merge) from [<80531bf8>] (userfaultfd_ioctl+0x1268/0x1534 fs/userfaultfd.c:2050)
 r10:20ce2000 r9:85c93630 r8:200e2000 r7:85c939f8 r6:00100277 r5:85f98000
 r4:ec8a1eb8
[<80530990>] (userfaultfd_ioctl) from [<804e54dc>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<80530990>] (userfaultfd_ioctl) from [<804e54dc>] (do_vfs_ioctl fs/ioctl.c:830 [inline])
[<80530990>] (userfaultfd_ioctl) from [<804e54dc>] (__do_sys_ioctl fs/ioctl.c:868 [inline])
[<80530990>] (userfaultfd_ioctl) from [<804e54dc>] (sys_ioctl+0x110/0xa74 fs/ioctl.c:856)
 r10:8530e870 r9:00000003 r8:85ca1f00 r7:20000100 r6:85ca1f01 r5:00000000
 r4:c020aa00
[<804e53cc>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xec8a1fa8 to 0xec8a1ff0)
1fa0:                   00000000 00000000 00000003 c020aa00 20000100 00000000
1fc0: 00000000 00000000 0014c2b8 00000036 7ea0c3c2 76b056d0 7ea0c534 76b0520c
1fe0: 76b05020 76b05010 00017004 0004dfb0
 r10:00000036 r9:84963ac0 r8:80200288 r7:00000036 r6:0014c2b8 r5:00000000
 r4:00000000
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
