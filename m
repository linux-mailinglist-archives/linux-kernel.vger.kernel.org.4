Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430C3749106
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 00:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjGEWiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 18:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjGEWiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:38:11 -0400
Received: from mail-pf1-f205.google.com (mail-pf1-f205.google.com [209.85.210.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593AE1981
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 15:38:10 -0700 (PDT)
Received: by mail-pf1-f205.google.com with SMTP id d2e1a72fcca58-67106f598b1so186572b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 15:38:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688596690; x=1691188690;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iV7HXzyDj8KY1IlnlcwbeahF8x3U8A/H8CTkW5EZaH4=;
        b=DZIIVz/kdE3k0wtyS0SzJwvodKyMwj2T1DxaQomX4bxXAKqqwyBZ0rZ+fqSf45lz6l
         Tw5VwwAAyUM3DMdjB+YOncCw8EzXVhvzwrGT5E7NsKQ7EWaSFefj8dlS+0OxnyKenvu1
         mFiZZdHszCLhWi4GulBypevIRdTrdQQdYjxpRnCRzNCWhssZbi3qcwu5O6MHCRVA1+af
         WoAdYiTHeyqOIGQwBu/e6f5eGDkRdgRCiC5diESR3c6HN/fFGcJGLIgGulA6mE7e+1Yz
         akMMM/lpPl4ctrcgZ9a2W+pLRiCGoOxKVvjpKfy1YXnCWmHpbH0S7WSfBzJqLSBK12I0
         qLnA==
X-Gm-Message-State: ABy/qLbcRzU5mMRuXmTdIqPZRU+idHUf0WhjD9r8pqReTMyfE6+leq60
        kB+avmqq92UTDoN9W/1gtlqHuPp9avt8M4MD8gI0rP7tOUSm
X-Google-Smtp-Source: APBJJlHr2MmqrWr1/DZ4AmOQ7hUzV46oftixys977CeNKEuWLvlphQo25Y++gxEDmfULx3Y72N1WqpFwjrzuBGm0jntRz/jeWJvV
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:2d09:b0:673:e4b4:fa35 with SMTP id
 fa9-20020a056a002d0900b00673e4b4fa35mr319240pfb.2.1688596689729; Wed, 05 Jul
 2023 15:38:09 -0700 (PDT)
Date:   Wed, 05 Jul 2023 15:38:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc3ea105ffc50d00@google.com>
Subject: [syzbot] [mm?] WARNING in validate_mm
From:   syzbot <syzbot+a85a0b4b0f39dca529a5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14aeea08a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d787595a482d6a43
dashboard link: https://syzkaller.appspot.com/bug?extid=a85a0b4b0f39dca529a5
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9f5f0447f626/disk-a901a356.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/500177760bfb/vmlinux-a901a356.xz
kernel image: https://storage.googleapis.com/syzbot-assets/82352cc74fb3/bzImage-a901a356.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a85a0b4b0f39dca529a5@syzkaller.appspotmail.com

owner ffff88807cee5940 exe_file ffff888028ce6f00
notifier_subscriptions 0000000000000000
numa_next_scan 4295297648 numa_scan_offset 0 numa_scan_seq 0
tlb_flush_pending 1
def_flags: 0x0()
------------[ cut here ]------------
WARNING: CPU: 0 PID: 18358 at mm/mmap.c:314 validate_mm+0x42a/0x500 mm/mmap.c:314
Modules linked in:
CPU: 0 PID: 18358 Comm: syz-executor.2 Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:validate_mm+0x42a/0x500 mm/mmap.c:314
Code: 28 e8 5a 98 fa ff c6 05 96 e3 b0 0c 01 0f 0b e9 09 fe ff ff e8 77 e1 b9 ff 48 8b 7c 24 28 e8 3d 98 fa ff c6 05 7a e3 b0 0c 01 <0f> 0b e9 46 ff ff ff e8 5a e1 b9 ff 44 8b 74 24 1c eb 08 e8 4e e1
RSP: 0018:ffffc90006a279a0 EFLAGS: 00010282
RAX: 0000000000000330 RBX: 0000000000000000 RCX: 3ddfd82186994a00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90006a27ad0 R08: ffffffff816f481c R09: 1ffff92000d44e5c
R10: dffffc0000000000 R11: fffff52000d44e5d R12: dffffc0000000000
R13: ffffc90006a27a20 R14: ffff888024681500 R15: 00007f2d1ec14000
FS:  00007f2d1ec97700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f690424b000 CR3: 000000001ebc5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_vmi_align_munmap+0x13b1/0x15c0 mm/mmap.c:2561
 do_vmi_munmap+0x24d/0x2d0 mm/mmap.c:2619
 __vm_munmap+0x230/0x450 mm/mmap.c:2899
 __do_sys_munmap mm/mmap.c:2916 [inline]
 __se_sys_munmap mm/mmap.c:2913 [inline]
 __x64_sys_munmap+0x69/0x80 mm/mmap.c:2913
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2d1de8c467
Code: 00 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2d1ec96f38 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f2d1de8c467
RDX: 0000000000010000 RSI: 0000000000010000 RDI: 00007f2d145ff000
RBP: 00007f2d145ff000 R08: 0000000000000000 R09: 000000000000028b
R10: 0000000000010000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2d1ec96fdc R14: 00007f2d1ec96fe0 R15: 0000000020000382
 </TASK>


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
