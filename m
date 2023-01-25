Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D58267AA28
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 07:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjAYGA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 01:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbjAYGAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 01:00:54 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A43302B0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:00:52 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id n8-20020a6bf608000000b007048850aa92so10099715ioh.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBGPZb6W6r5Wl7tWTN+SABGezf4q6l6ydN5u7wmCR/U=;
        b=J8ujtnt4V2tcIpLyQXvEaSrkBciomLTFrFrOsb5pPiGAzAiU/GbPxndmIIAuB3hJZm
         LWS95PhqFbpPy28XQTj/9ziF1VPQ+1NsB7u3zWzxgUt/OessxErToIBsVuS2YfJ8J2Xy
         cmRmg0ISoQwamPFodeE5pE3cnWg0OrxLMFwQj4VEpd3Td82Gv5xi4Y0ocZqUDc60B8HW
         sekt13PPHqVi2dWJtOLxUKxhQqJcA26vMqT1KmfwYR2rRCdubVST09Q5YzWvcqvvQVTS
         VHbduU2OpiEdECYO2/v2nxvPDCReA2bz/Z2u9vP1yz2J54ljW3A7+mVEIqAjqwvm0iRC
         BGIg==
X-Gm-Message-State: AO0yUKUIcd/VryrTECRKCmtBoWqt3X9GepWASb+iF8BWjxGpnY4Y1JMg
        ripEmscQLoqPYahAJIwbChCjH4QPZGuki2ljDMZ6ZbY62cda
X-Google-Smtp-Source: AK7set8AKCbYFU2q6LfBWqSeL6/Jw0zYVJpgtMr8kw8kyITYGNSySHqGGbnSIzK6sPhWRNGmER4+AQknECHlbdvkDNvtWeP8It4+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a08:b0:310:9776:db80 with SMTP id
 s8-20020a056e021a0800b003109776db80mr583251ild.40.1674626449658; Tue, 24 Jan
 2023 22:00:49 -0800 (PST)
Date:   Tue, 24 Jan 2023 22:00:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9dc0705f3105a26@google.com>
Subject: [syzbot] kernel BUG in free_huge_page
From:   syzbot <syzbot+83cc82a0254bc0c17b52@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    691781f561e9 Add linux-next specific files for 20230123
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1393d0ac480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=804cddf7ddbc6c64
dashboard link: https://syzkaller.appspot.com/bug?extid=83cc82a0254bc0c17b52
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95b9320565c9/disk-691781f5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5f3482fee79/vmlinux-691781f5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/63516279b1a1/bzImage-691781f5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83cc82a0254bc0c17b52@syzkaller.appspotmail.com

 follow_hugetlb_page+0x6ab/0x1e40 mm/hugetlb.c:6524
 __get_user_pages+0x29b/0xfc0 mm/gup.c:1125
 __get_user_pages_locked mm/gup.c:1373 [inline]
 __gup_longterm_locked+0x1bd/0x25d0 mm/gup.c:2058
 get_user_pages_unlocked+0xe8/0x1b0 mm/gup.c:2250
 internal_get_user_pages_fast+0x1633/0x3190 mm/gup.c:2935
 get_user_pages_fast+0x6a/0xa0 mm/gup.c:3027
 __iov_iter_get_pages_alloc+0x39f/0x2250 lib/iov_iter.c:1461
 iov_iter_get_pages+0xb0/0x100 lib/iov_iter.c:1504
 __bio_iov_iter_get_pages block/bio.c:1276 [inline]
 bio_iov_iter_get_pages+0x2a0/0x11e0 block/bio.c:1347
page_owner free stack trace missing
------------[ cut here ]------------
kernel BUG at mm/hugetlb.c:1865!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8927 Comm: syz-executor.5 Not tainted 6.2.0-rc5-next-20230123-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:free_huge_page+0xa5b/0xe80 mm/hugetlb.c:1865
Code: 0f 0b e8 08 98 b7 ff 4c 89 e7 e8 00 3e f7 ff 89 c3 e9 a0 f9 ff ff e8 f4 97 b7 ff 48 c7 c6 a0 6f 59 8a 4c 89 e7 e8 55 8b ef ff <0f> 0b e8 de 97 b7 ff 48 8d 7b 17 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc9000557f908 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc900062ea000
RDX: 0000000000040000 RSI: ffffffff81ca564b RDI: 0000000000000000
RBP: ffffffff91c45bf8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 1ffffffff21798de R12: ffffea0002580000
R13: ffffea0002580090 R14: 0000000000000000 R15: ffffea0002580034
FS:  00007f42bf3be700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2349dabf84 CR3: 0000000021513000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __folio_put_large mm/swap.c:119 [inline]
 __folio_put+0x109/0x140 mm/swap.c:127
 folio_put include/linux/mm.h:1203 [inline]
 put_page+0x21b/0x280 include/linux/mm.h:1272
 hugetlb_fault+0x153e/0x23f0 mm/hugetlb.c:6130
 follow_hugetlb_page+0x6ab/0x1e40 mm/hugetlb.c:6524
 __get_user_pages+0x29b/0xfc0 mm/gup.c:1125
 populate_vma_page_range+0x241/0x320 mm/gup.c:1526
 __mm_populate+0x105/0x3b0 mm/gup.c:1640
 do_mlock+0x370/0x6d0 mm/mlock.c:608
 __do_sys_mlock mm/mlock.c:616 [inline]
 __se_sys_mlock mm/mlock.c:614 [inline]
 __x64_sys_mlock+0x59/0x80 mm/mlock.c:614
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f42be68c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f42bf3be168 EFLAGS: 00000246 ORIG_RAX: 0000000000000095
RAX: ffffffffffffffda RBX: 00007f42be7ac050 RCX: 00007f42be68c0c9
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020308000
RBP: 00007f42be6e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe0e3b671f R14: 00007f42bf3be300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:free_huge_page+0xa5b/0xe80 mm/hugetlb.c:1865
Code: 0f 0b e8 08 98 b7 ff 4c 89 e7 e8 00 3e f7 ff 89 c3 e9 a0 f9 ff ff e8 f4 97 b7 ff 48 c7 c6 a0 6f 59 8a 4c 89 e7 e8 55 8b ef ff <0f> 0b e8 de 97 b7 ff 48 8d 7b 17 48 b8 00 00 00 00 00 fc ff df 4c
RSP: 0018:ffffc9000557f908 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc900062ea000
RDX: 0000000000040000 RSI: ffffffff81ca564b RDI: 0000000000000000
RBP: ffffffff91c45bf8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 1ffffffff21798de R12: ffffea0002580000
R13: ffffea0002580090 R14: 0000000000000000 R15: ffffea0002580034
FS:  00007f42bf3be700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2349dabf84 CR3: 0000000021513000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
