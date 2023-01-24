Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81858679454
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjAXJhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjAXJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:37:51 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C018B4EC8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:37:48 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i7-20020a056e021b0700b003033a763270so10080287ilv.19
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxR4WIv63EkmxgrH8NIhpjdajGAUk0Rc5Ell/1ql4N4=;
        b=HNp76fy63PVriTlKtDfnenNgLrD5X/NJ14UZcS1ljGZ+rnbZeZQhhX5qPeUEGdGRbz
         B8O8m+Ll8w24+CtDEpHdoEFy/6teNpyZ72wDBXpmtIgbrrQPaE9/YTH19EbPbGcHwwIm
         8S8I1jLjK5DfOEhtOzcO7bKB0cNoZtF1Ud7ZE4w8YJOLCYCSjSyn1PggdMJ5zMJyRrD6
         vuzOwFexDRwh8gGc1k/cr4LvmDH2f2qzFjCfSDuZIO8n6NKuhMwvDYnxoq72xRq9fkqh
         ZZdXfR3Tcq8g1hag+msOzWabJ6jPSKgpDeVYkK5P4OBsieyeNrLhQERq0wnXXOQQNaGF
         p3Hw==
X-Gm-Message-State: AFqh2kp37kIkK8xV8vmCc1kPioPud/7nCweR4hfygDqii8DzEZA8IfLs
        cZIf0VD9Tv9NvdlY9oVKS99PBQ2RTDpteNWNv1K+ES2R4t9P
X-Google-Smtp-Source: AMrXdXuqcHqpTCWu6TAIEyu7dIDP5IOB+IGAjyPopP8xvF3iI3HkbOvJ/5+xFS1uj5KukZoczENTgz8Jw08XO2nYwuivXEVEUwnQ
MIME-Version: 1.0
X-Received: by 2002:a92:2911:0:b0:30e:e3f0:43b with SMTP id
 l17-20020a922911000000b0030ee3f0043bmr2595863ilg.123.1674553067854; Tue, 24
 Jan 2023 01:37:47 -0800 (PST)
Date:   Tue, 24 Jan 2023 01:37:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c467c705f2ff449f@google.com>
Subject: [syzbot] linux-next test error: WARNING in vma_merge
From:   syzbot <syzbot+1d9ec4d1a334ae9e1ca6@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a54df7622717 Add linux-next specific files for 20230124
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13220341480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32f13cf65b56e95d
dashboard link: https://syzkaller.appspot.com/bug?extid=1d9ec4d1a334ae9e1ca6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/131be349f841/disk-a54df762.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35330c9d8c6e/vmlinux-a54df762.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90c182db9219/bzImage-a54df762.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d9ec4d1a334ae9e1ca6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5076 at mm/internal.h:908 vma_iter_store mm/internal.h:908 [inline]
WARNING: CPU: 1 PID: 5076 at mm/internal.h:908 vma_merge.cold+0x2e0/0x6b1 mm/mmap.c:1014
Modules linked in:
CPU: 0 PID: 5076 Comm: syz-fuzzer Not tainted 6.2.0-rc5-next-20230124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:vma_iter_store mm/internal.h:908 [inline]
RIP: 0010:vma_merge.cold+0x2e0/0x6b1 mm/mmap.c:1014
Code: 2a 48 c1 ea 03 80 3c 02 00 74 09 48 8b 3c 24 e8 7a 39 0f f8 48 8b 04 24 4c 8b 28 e9 e6 4a fe f7 48 89 74 24 48 e8 84 52 c1 f7 <0f> 0b 48 8b 54 24 28 48 c7 c7 a0 60 58 8a 48 8b 74 24 48 e8 e4 d5
RSP: 0018:ffffc90003c5f980 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffc90003c5fb60 RCX: 0000000000000000
RDX: ffff88807ec23a80 RSI: ffffffff89c09b9c RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000006 R09: 000000c000400000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888077f28d28
R13: ffffc90003c5fb70 R14: ffff888077f28d20 R15: ffffc90003c5fa10
FS:  0000000001f4dab0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c0006f3000 CR3: 000000002af6e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 madvise_update_vma+0x21b/0xa80 mm/madvise.c:153
 madvise_vma_behavior+0x7ea/0x20a0 mm/madvise.c:1091
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1260
 do_madvise.part.0+0x18e/0x340 mm/madvise.c:1439
 do_madvise mm/madvise.c:1452 [inline]
 __do_sys_madvise mm/madvise.c:1452 [inline]
 __se_sys_madvise mm/madvise.c:1450 [inline]
 __x64_sys_madvise+0x117/0x150 mm/madvise.c:1450
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4675b7
Code: 8b 24 24 48 8b 6c 24 10 48 83 c4 18 c3 cc cc cc cc cc cc 48 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 48 c7 c0 1c 00 00 00 0f 05 <89> 44 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24 14
RSP: 002b:00007ffe658ce770 EFLAGS: 00000206 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 0000000000002000 RCX: 00000000004675b7
RDX: 000000000000000f RSI: 0000000000200000 RDI: 000000c000600000
RBP: 00007ffe658ce7b0 R08: 0000000000200000 R09: 0000000000000200
R10: 0000000000000118 R11: 0000000000000206 R12: 00007f77fecbb000
R13: 0000000000000080 R14: 0000000001f4d640 R15: 0000000000001018
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
