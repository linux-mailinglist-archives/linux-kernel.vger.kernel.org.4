Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943895EF022
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiI2IQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiI2IPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:15:44 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C013070B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:15:43 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z4-20020a921a44000000b002f8da436b83so572654ill.19
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5O+AfyUYvrezWb+Q0brjuKnlN+Y9GS/PYnjJecqM0js=;
        b=w5QOfobwnL/fo5bgkhA2o3TqictAXGIisWIcxBOSjlwm//wz7f4RLJVGBEG0myqYSu
         HvtPfjjnAAOaCfbp8xiFv9aZfc9u1WBPRvXTGly/TqTEY1NRlqj6kG7V13INJugShIyF
         Qx6UDMH51MWyEhVbjsfxVWt9nh1h07zqNs1ppJrNYjRN5hRd5iSJbHlWA1RVeANZzyPO
         5l3/Jdwm6ADx0/W0B0yx74L5R0qqmZ8QpwFphKn5gl8z5q7LnRario+ZqIet+QNvmcj0
         LC2cXMsABw4MAt0j9S7yzn66JdeiE9ai3TyMkJKbUkJocyYdh8ERa5tktId001fT695q
         davQ==
X-Gm-Message-State: ACrzQf06aDDA7SHq0OG1Srjj7fC/cFqDkKT8I/rL3dD182UMazWJp1sr
        Eo+yLSYl4gGPH+3r1HwnLSVpwGcleSdnwuXsjtVyn3C9uitb
X-Google-Smtp-Source: AMsMyM5EWmfOCJODgArmGpjZbLDWCsGDKUQIrYtjiEJvyAmBYxmPE/11/ksn8B13qS079gvQ3FAXR0u238VUfsCmHTNUd5EsCDrQ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1583:b0:2d7:a75d:888f with SMTP id
 m3-20020a056e02158300b002d7a75d888fmr977702ilu.13.1664439342476; Thu, 29 Sep
 2022 01:15:42 -0700 (PDT)
Date:   Thu, 29 Sep 2022 01:15:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2333105e9cc7b1c@google.com>
Subject: [syzbot] WARNING in wnd_init
From:   syzbot <syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

HEAD commit:    49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12615824880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=fa4648a5446460b7b963
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cad4e0880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1303781f080000

Downloadable assets:
disk image: https://storage.googleapis.com/418654aab051/disk-49c13ed0.raw.xz
vmlinux: https://storage.googleapis.com/49c501fc7ae3/vmlinux-49c13ed0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa4648a5446460b7b963@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3607 at mm/page_alloc.c:5525 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
Modules linked in:
CPU: 1 PID: 3607 Comm: syz-executor265 Not tainted 6.0.0-rc7-syzkaller-00068-g49c13ed0316d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
Code: 5c 24 04 0f 85 f3 00 00 00 44 89 e1 81 e1 7f ff ff ff a9 00 00 04 00 41 0f 44 cc 41 89 cc e9 e3 00 00 00 c6 05 73 17 29 0c 01 <0f> 0b 83 fb 0a 0f 86 c8 fd ff ff 31 db 48 c7 44 24 20 0e 36 e0 45
RSP: 0018:ffffc900039bf8a0 EFLAGS: 00010246
RAX: ffffc900039bf900 RBX: 0000000000000026 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc900039bf928
RBP: ffffc900039bf9b0 R08: dffffc0000000000 R09: ffffc900039bf900
R10: fffff52000737f25 R11: 1ffff92000737f20 R12: 0000000000040d40
R13: 1ffff92000737f1c R14: dffffc0000000000 R15: 1ffff92000737f18
FS:  0000555556f45300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000007f9fc000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmalloc_order+0x41/0x140 mm/slab_common.c:933
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:949
 kmalloc_large include/linux/slab.h:529 [inline]
 __kmalloc+0x26e/0x370 mm/slub.c:4418
 kmalloc_array include/linux/slab.h:640 [inline]
 kcalloc include/linux/slab.h:671 [inline]
 wnd_init+0x1db/0x310 fs/ntfs3/bitmap.c:664
 ntfs_fill_super+0x28ce/0x42a0 fs/ntfs3/super.c:1058
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efe2672d73a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb31dc6b8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007efe2672d73a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fffb31dc6d0
RBP: 00007fffb31dc6d0 R08: 00007fffb31dc710 R09: 00007fffb31dc710
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000004
R13: 00007fffb31dc710 R14: 000000000000010e R15: 0000000020001b50
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
