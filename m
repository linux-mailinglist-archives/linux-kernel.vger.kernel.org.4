Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526B36F081D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244060AbjD0PUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbjD0PUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:20:53 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B664224
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:20:52 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-763537830d9so645262039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682608851; x=1685200851;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ooUwgEV9UupcorTy+WLxLIX3nFusiETN6t9eu1Vflk=;
        b=WPGxFQVIlZryB75mgKGoCEWBosk5DgpTYs+wXCK1k2udTECKMGSlrZsahofdhh3xrV
         t7pp1m3rlSwMhtGeRXlAufhW9vvUM6kPuVSZgp+s4eSBcgJ4AEGgpT2Ecc9wx7/hFtV9
         nrrdHXGlB5sGIXjeRJQZRGdiAmq0CryOipdptaCQjWPcwUWlXF5UWHpZzQ/fIHWXMa00
         HjN+8DzlOTil0RfRkUXihkthSKV/Kj82nwPGLpZmdu4bPZ9o4mNpS/AI67xmE8Ri7HoZ
         KoxU4rOsd1LGRytM2hu1Bd5v87G13471CQ5ZLml6KriE2Npwbm7nFCL+d5R1pUsK9E/8
         8xGg==
X-Gm-Message-State: AC+VfDxY1zIDEEHkmBunTh+bNAvH6SXy6oRKIKcHI4uOD41SKmjHrZYL
        YrmEkSgbkQMWnsffPjnV6QHacLtSbfm7bv2uZl5MjrYcV+pI
X-Google-Smtp-Source: ACHHUZ4OusLOTLQh/CMn6BfqiMedwdfCcJOMfbeIpQCq92jcqmD+8imXbrGag7V+JjlKONtt4i2o2n1RbVZ/raXQnryDzK7zJjsl
MIME-Version: 1.0
X-Received: by 2002:a05:6602:114:b0:745:5e5c:f091 with SMTP id
 s20-20020a056602011400b007455e5cf091mr1345241iot.0.1682608851698; Thu, 27 Apr
 2023 08:20:51 -0700 (PDT)
Date:   Thu, 27 Apr 2023 08:20:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6cd7405fa52e6ad@google.com>
Subject: [syzbot] [mm?] kernel BUG in folio_unlock
From:   syzbot <syzbot+1b2ce6d050776f4403cf@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    d3e1ee0e67e7 Add linux-next specific files for 20230421
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=110654a4280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53c789efbcc06cf6
dashboard link: https://syzkaller.appspot.com/bug?extid=1b2ce6d050776f4403cf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c558a9e1fe6a/disk-d3e1ee0e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ec100a34c4c/vmlinux-d3e1ee0e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1afcd9936dc1/bzImage-d3e1ee0e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b2ce6d050776f4403cf@syzkaller.appspotmail.com

 faultin_page mm/gup.c:925 [inline]
 __get_user_pages+0x614/0x10e0 mm/gup.c:1147
 populate_vma_page_range+0x2df/0x420 mm/gup.c:1543
 __mm_populate+0x105/0x3b0 mm/gup.c:1652
 mm_populate include/linux/mm.h:3191 [inline]
 vm_mmap_pgoff+0x2c6/0x3b0 mm/util.c:548
 ksys_mmap_pgoff+0x7d/0x5a0 mm/mmap.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
------------[ cut here ]------------
kernel BUG at mm/filemap.c:1529!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7377 Comm: syz-executor.1 Not tainted 6.3.0-rc7-next-20230421-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:folio_unlock+0xb2/0xd0 mm/filemap.c:1529
Code: e8 63 4b d4 ff 48 89 ef 31 f6 e8 f9 fc ff ff 5b 5d e9 52 4b d4 ff e8 4d 4b d4 ff 48 c7 c6 c0 a7 56 8a 48 89 ef e8 ee e0 0f 00 <0f> 0b 48 89 df e8 74 2a 27 00 e9 7c ff ff ff 66 66 2e 0f 1f 84 00
RSP: 0018:ffffc9001531f7a8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88803c570000 RSI: ffffffff81af9a12 RDI: 0000000000000000
RBP: ffffea0002128000 R08: 0000000000000001 R09: ffffffff8e796e17
R10: fffffbfff1cf2dc2 R11: 0000000000000000 R12: ffffc9001531f8d8
R13: ffffc9001531f8d0 R14: ffffc9001531f8d8 R15: 000000000000001e
FS:  00007fe54afbc700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007eff0bb831b8 CR3: 0000000023ba2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 collapse_file+0x1f6d/0x5db0 mm/khugepaged.c:2316
 hpage_collapse_scan_file+0xbef/0x1550 mm/khugepaged.c:2415
 madvise_collapse+0x53b/0xca0 mm/khugepaged.c:2877
 madvise_vma_behavior+0x649/0x20a0 mm/madvise.c:1074
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1248
 do_madvise.part.0+0x287/0x5e0 mm/madvise.c:1428
 do_madvise mm/madvise.c:1441 [inline]
 __do_sys_madvise mm/madvise.c:1441 [inline]
 __se_sys_madvise mm/madvise.c:1439 [inline]
 __x64_sys_madvise+0x117/0x150 mm/madvise.c:1439
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe54c48c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe54afbc168 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fe54c5ac120 RCX: 00007fe54c48c169
RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
RBP: 00007fe54c4e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff8070a1ff R14: 00007fe54afbc300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_unlock+0xb2/0xd0 mm/filemap.c:1529
Code: e8 63 4b d4 ff 48 89 ef 31 f6 e8 f9 fc ff ff 5b 5d e9 52 4b d4 ff e8 4d 4b d4 ff 48 c7 c6 c0 a7 56 8a 48 89 ef e8 ee e0 0f 00 <0f> 0b 48 89 df e8 74 2a 27 00 e9 7c ff ff ff 66 66 2e 0f 1f 84 00
RSP: 0018:ffffc9001531f7a8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88803c570000 RSI: ffffffff81af9a12 RDI: 0000000000000000
RBP: ffffea0002128000 R08: 0000000000000001 R09: ffffffff8e796e17
R10: fffffbfff1cf2dc2 R11: 0000000000000000 R12: ffffc9001531f8d8
R13: ffffc9001531f8d0 R14: ffffc9001531f8d8 R15: 000000000000001e
FS:  00007fe54afbc700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd2aa586058 CR3: 0000000023ba2000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

If you want to unassign a label, reply with:
#syz unset some-label

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
