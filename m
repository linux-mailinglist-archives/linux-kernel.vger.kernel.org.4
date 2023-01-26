Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2FA67CDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjAZO0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjAZO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:26:17 -0500
Received: from mail-io1-xd45.google.com (mail-io1-xd45.google.com [IPv6:2607:f8b0:4864:20::d45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538E212583
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:25:51 -0800 (PST)
Received: by mail-io1-xd45.google.com with SMTP id b26-20020a056602331a00b00704cb50e151so964542ioz.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 06:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fokMFk2aHN6zddqQgmkFpmX2jguDNP9PGOuf1Cbb47M=;
        b=YvjAUYZ0LxMueIZd+BI40awnwbZ+DjZcd+whTf51PnpSDIyjsOQk+mFUQG0UU5iM+H
         uaF4YoH8afBxZzGFnkSzuv0yncU1PBV/n8QBr74NfLK4oObkg8M+43Jl3CVGz7QtF6Kk
         FKtVZ290Tkkk+Lnwo10kl4L64Lkhj9BaI5e+VyfHB3mQ9g1nmDS/IhcIDrNJ0UrvZsQ8
         JwZEUt+alIb5fOYPAsOiR7FN4QOhgkzJQ/YjKUY6XuVPFrF1OmeGERWyrGZbFi/D9Ce8
         U5IarRsEXzE/4MHWa+J/VyuS66yg43Pkk+1DYzLkT28f/tx0OcUI9AA7HorWj83C0aj1
         iE+g==
X-Gm-Message-State: AFqh2kqHB3J9w5/elNeyqqIxL3rOGp3MwH1sdAD8VW2FIFBBL+656ri0
        2+kStlpbJblpB2TbStg5fcLgTpV5TL3T3Mahbpul9/A2wbeD
X-Google-Smtp-Source: AMrXdXuAP/1Zy0f6YvtK7tUCnhizwYl81TIxyNzmzuoWRm8Y1WgcEv9smpIJCYZZCf6SxEUZnq2XtevM42BDdOwXjgCSH/JblIeR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d8e:b0:30f:5c46:f30d with SMTP id
 i14-20020a056e020d8e00b0030f5c46f30dmr2633257ilj.146.1674743034437; Thu, 26
 Jan 2023 06:23:54 -0800 (PST)
Date:   Thu, 26 Jan 2023 06:23:54 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a86a7c05f32b7f91@google.com>
Subject: [syzbot] [f2fs?] UBSAN: shift-out-of-bounds in f2fs_fill_super (2)
From:   syzbot <syzbot+fea4bcda5eb938ee88ed@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2241ab53cbb5 Linux 6.2-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e678a9480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5d89b670f0458d
dashboard link: https://syzkaller.appspot.com/bug?extid=fea4bcda5eb938ee88ed
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e370de928a15/disk-2241ab53.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a32aa1a12bc4/vmlinux-2241ab53.xz
kernel image: https://storage.googleapis.com/syzbot-assets/914736862f98/bzImage-2241ab53.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fea4bcda5eb938ee88ed@syzkaller.appspotmail.com

F2FS-fs (loop0): Fix alignment : internally, start(4096) end(16896) block(12288)
F2FS-fs (loop0): Magic Mismatch, valid(0xf2f52010) - read(0xe8b)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th superblock
================================================================================
UBSAN: shift-out-of-bounds in fs/f2fs/super.c:4184:41
shift exponent 613 is too large for 64-bit type 'loff_t' (aka 'long long')
CPU: 1 PID: 5467 Comm: syz-executor.0 Not tainted 6.2.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3a0 lib/ubsan.c:321
 f2fs_fill_super+0x5518/0x6ee0 fs/f2fs/super.c:4184
 mount_bdev+0x26c/0x3a0 fs/super.c:1359
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7ad2e8d5fa
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7ad3bccf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000000054f7 RCX: 00007f7ad2e8d5fa
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 00007f7ad3bccfe0
RBP: 00007f7ad3bcd020 R08: 00007f7ad3bcd020 R09: 0000000000000003
R10: 0000000000000003 R11: 0000000000000202 R12: 0000000020000040
R13: 0000000020000080 R14: 00007f7ad3bccfe0 R15: 00000000200056c0
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
