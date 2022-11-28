Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDC263A9BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiK1Nhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiK1Nhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:37:38 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A575D9E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:37:37 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id y5-20020a056602120500b006cf628c14ddso5867148iot.15
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z1RW/GWPFPWiLFE8MgsyNjcCwYIIfGWjIAfN9PmOLVY=;
        b=2Q10eclgrnTh70GeWm2xnAJkjNMyCLlUYQTZwDSlBcAQdqa54FvS7yjnbfZsEW2oVV
         funmtFrtHySLNWWvWVvGzgt7rxHMrWrspk3ciaaPYfsfKP4PONd1mHnFQBDZYaLN8FWf
         cBGeaX9deSdOa9JTEEUziURQeUcV0JGboaus1BarztWvdlICRCXXyvcoZGu0c3lC4Fth
         CvA7Br6lW6PPvrqJ0RxzhWQFl0+Ons5cwyvbqu/S8Ze37dMBhn0iWYdr0Sxacny0Brs6
         nztXu0qStllrAACEXCzXEHoV+O0aUQ/VmdZSE6eI5r5CsbQdD2sv1AAPnnJrEPoHaW32
         i+yw==
X-Gm-Message-State: ANoB5pmcYysOck3AsM5KVe5L1w9m5EE1ryhwWRW1k/xN7FpWCdfOMexv
        UdJsn5BCM8HzKCsHYu+lO8Jcjwe7IURwvhCyclqkODMbDuCP
X-Google-Smtp-Source: AA0mqf4WC0fd99+zArTZ8IJBR3aL2FlmGd2mqd71pT3+qR2gdhMPw1B/qHOdZuHxiOO+4Ys7igrofljOrWwuAUjALgyGoX9LOGd8
MIME-Version: 1.0
X-Received: by 2002:a92:de11:0:b0:2fa:46fd:c430 with SMTP id
 x17-20020a92de11000000b002fa46fdc430mr23396936ilm.71.1669642656402; Mon, 28
 Nov 2022 05:37:36 -0800 (PST)
Date:   Mon, 28 Nov 2022 05:37:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fd63905ee87f975@google.com>
Subject: [syzbot] KASAN: use-after-free Read in udf_new_inode
From:   syzbot <syzbot+4740808fef2bdfd0e75f@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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

HEAD commit:    b7b275e60bcd Linux 6.1-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11de933d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=4740808fef2bdfd0e75f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/525233126d34/disk-b7b275e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e8299bf41400/vmlinux-b7b275e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eebf691dbf6f/bzImage-b7b275e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4740808fef2bdfd0e75f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
==================================================================
BUG: KASAN: use-after-free in udf_new_inode+0xdfe/0xf30
Read of size 4 at addr ffff8880547aab90 by task syz-executor.0/4518

CPU: 0 PID: 4518 Comm: syz-executor.0 Not tainted 6.1.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 udf_new_inode+0xdfe/0xf30
 udf_create+0x1f/0x140 fs/udf/namei.c:612
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe1d988c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe1da601168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fe1d99abf80 RCX: 00007fe1d988c0d9
RDX: 000000000000275a RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007fe1d98e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffb3db0f8f R14: 00007fe1da601300 R15: 0000000000022000
 </TASK>

The buggy address belongs to the physical page:
page:ffffea000151ea80 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x547aa
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 3625, tgid 3622 (syz-fuzzer), ts 132903604494, free_ts 165010139517
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 __folio_alloc+0xf/0x30 mm/page_alloc.c:5590
 vma_alloc_folio+0x660/0xb60 mm/mempolicy.c:2246
 alloc_page_vma include/linux/gfp.h:270 [inline]
 wp_page_copy+0x222/0x1610 mm/memory.c:3114
 handle_pte_fault mm/memory.c:4973 [inline]
 __handle_mm_fault mm/memory.c:5097 [inline]
 handle_mm_fault+0x1e72/0x3630 mm/memory.c:5218
 do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page_list+0xb4/0x7b0 mm/page_alloc.c:3529
 release_pages+0x232a/0x25c0 mm/swap.c:1055
 tlb_batch_pages_flush mm/mmu_gather.c:59 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:256 [inline]
 tlb_flush_mmu+0x850/0xa70 mm/mmu_gather.c:263
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:363
 zap_page_range+0x60f/0x6d0 mm/memory.c:1765
 madvise_dontneed_single_vma mm/madvise.c:793 [inline]
 madvise_dontneed_free+0x43f/0xfc0 mm/madvise.c:886
 madvise_vma_behavior mm/madvise.c:1025 [inline]
 madvise_walk_vmas mm/madvise.c:1250 [inline]
 do_madvise+0x788/0x2010 mm/madvise.c:1429
 __do_sys_madvise mm/madvise.c:1442 [inline]
 __se_sys_madvise mm/madvise.c:1440 [inline]
 __x64_sys_madvise+0xa2/0xb0 mm/madvise.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff8880547aaa80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880547aab00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880547aab80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                         ^
 ffff8880547aac00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880547aac80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
