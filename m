Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A05F22DC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 13:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJBLSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 07:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJBLSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 07:18:38 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D39827FE3
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 04:18:37 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id l84-20020a6b3e57000000b006a3fe90910cso5312618ioa.16
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 04:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=YrXxoOGDz1iGBnoxTDB/uNAm6RmhQ/BKaHcl2JVIe7g=;
        b=gkzfyuUkn926yM2/hWf8PqqHAseNasYb9V7igUQalLv4FvbsmwJ0eIAwM7GD+Jv/M5
         Jy7IjxrQBX8iDQWJ7uy+OUHVYkE0x0QREOb8QWFL/bZ8jCl9J6YZ9YLVfQQCje+1ozfm
         wHtNq58gX1gSmpi0ADclqSXYmM1s5R3EGEjyaUWeZ9RnxPZFA76EX85dNu9pAHoJLqv1
         EFU39TkD3tuHFZ8cpiBW0JWeSwRs2LHHuFNSOVnXMTw0MLr5KMZ/0azwUZoBPfdzjP6i
         /aaMr0zucVSR/bN+zz4WIAjRAKWxY3az0n0pZhLDVCg2qsbxtZHgGFc+1hNkKo6CLa9c
         QIGA==
X-Gm-Message-State: ACrzQf0KTPYwRaNmBiTypHI1qoVJbC/lht3chjV9R8lmEbPiIiBIFTRE
        IdIonMEnVa1tQExpUgkSW8rqqkV5wKoIC5keaCu1zr8a9Fdl
X-Google-Smtp-Source: AMsMyM5D2Fzb9QVvmrJhVhxIjyKH8VLSLDA5WbBT1hn4qwyxxAFCXPAArkkbGzuMxY02ojAuxPOP/LEEIeyu2juhdUwdJGTxZ/nl
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15ce:b0:6a5:22db:950b with SMTP id
 f14-20020a05660215ce00b006a522db950bmr7049713iow.183.1664709517034; Sun, 02
 Oct 2022 04:18:37 -0700 (PDT)
Date:   Sun, 02 Oct 2022 04:18:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ad0d505ea0b63ee@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbAllocCtl
From:   syzbot <syzbot+f0e5eba3996857670c88@syzkaller.appspotmail.com>
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

HEAD commit:    ffb4d94b4314 Merge tag 'drm-fixes-2022-10-01' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15877ab8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=f0e5eba3996857670c88
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b74f52232e47/disk-ffb4d94b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b09212ee600a/vmlinux-ffb4d94b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0e5eba3996857670c88@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1785:12
shift exponent 711030885 is too large for 64-bit type 'long long'
CPU: 0 PID: 29745 Comm: syz-executor.2 Not tainted 6.0.0-rc7-syzkaller-00220-gffb4d94b4314 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 dbAllocCtl+0x93d/0x970 fs/jfs/jfs_dmap.c:1785
 dbAllocAG+0x28b/0x1100 fs/jfs/jfs_dmap.c:1334
 dbAlloc+0x661/0xc90 fs/jfs/jfs_dmap.c:858
 diNewIAG fs/jfs/jfs_imap.c:2500 [inline]
 diAllocExt fs/jfs/jfs_imap.c:1898 [inline]
 diAllocAG+0xaf6/0x1f80 fs/jfs/jfs_imap.c:1662
 diAlloc+0x3dd/0x1700 fs/jfs/jfs_imap.c:1583
 ialloc+0x8c/0xa80 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x141/0xb00 fs/jfs/namei.c:225
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
 do_mkdirat+0x279/0x550 fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd56248a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd563556168 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007fd5625abf80 RCX: 00007fd56248a5a9
RDX: 0000000000000000 RSI: 0000000020000540 RDI: 0000000000000004
RBP: 00007fd5624e5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd10304c1f R14: 00007fd563556300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
