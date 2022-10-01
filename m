Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312FD5F1CC5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJAO2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJAO2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:28:42 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9FB15FC3
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:28:36 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso4546006iob.20
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=RmyNMWr5W99uufCqHVPLupIj6BiTQ9auDvoBoBSZjwg=;
        b=TFb2XZ+O/OKHrHV3f6m07Ccbso9e7lCTHkwyi7r1eV8hXbRvyU/DWTUuXYvzBLJprH
         +SlUt15Ylok9cNbetCL7mq/0LgAbmBiVe9h5HlMojVmKR0L++H0javERepQeldPpazZO
         oXDz6ss6AdyqWuq6W3wMVaf0IhSagbDKwzmOojBHX+u23F38z8vViWjW9XlSJS2Izxu7
         8Uu2RsZYu4UeQbpfEA2GlwLoRCHENhJ2h6Npbudi4CkKynJ3GTWwtf70rtyfO1VpYJrA
         hh/0v/7AZq4q+lAoHA8Ot8l51OgX6QOHEoMY0IwMWSgzyN1jMZ7m+3NUDyXaMEdlw1eg
         EQYg==
X-Gm-Message-State: ACrzQf1jrU+vqLIA3fDET3QncuBh0+2/e4lGC1F9xgUyWyopXsxzc8Jk
        DvCEep8gKJgsHUxMh2LKSPB7XGxRTKZOXfjMjM3d81KYVkNU
X-Google-Smtp-Source: AMsMyM7zeDAKE2aSAPyZFSdjme2yhfzBOW/DjmfjbxFTzYO3/CtgjOXHyeXhjxxq/ojqNQeEUSld+gk5Qa2OoHlq8XT8voEkxcWI
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c3:b0:2f1:b33c:63e4 with SMTP id
 3-20020a056e0220c300b002f1b33c63e4mr6807547ilq.144.1664634515370; Sat, 01 Oct
 2022 07:28:35 -0700 (PDT)
Date:   Sat, 01 Oct 2022 07:28:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8389205e9f9ec5f@google.com>
Subject: [syzbot] KASAN: use-after-free Read in crc_itu_t
From:   syzbot <syzbot+d8fc21bfa138a5ae916d@syzkaller.appspotmail.com>
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

HEAD commit:    70575e77839f Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a3bd70880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=d8fc21bfa138a5ae916d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d99310e4b1b7/disk-70575e77.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef3a5647354c/vmlinux-70575e77.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8fc21bfa138a5ae916d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in crc_itu_t+0x1dd/0x2b0 lib/crc-itu-t.c:60
Read of size 1 at addr ffff888086d82000 by task syz-executor.3/3631

CPU: 1 PID: 3631 Comm: syz-executor.3 Not tainted 6.0.0-rc7-syzkaller-00180-g70575e77839f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 crc_itu_t+0x1dd/0x2b0 lib/crc-itu-t.c:60
 udf_finalize_lvid fs/udf/super.c:2021 [inline]
 udf_sync_fs+0x1bc/0x360 fs/udf/super.c:2377
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x300 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:169
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f27d8c8ba17
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdc87f33e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f27d8c8ba17
RDX: 00007ffdc87f34bb RSI: 000000000000000a RDI: 00007ffdc87f34b0
RBP: 00007ffdc87f34b0 R08: 00000000ffffffff R09: 00007ffdc87f3280
R10: 0000555555a338b3 R11: 0000000000000246 R12: 00007f27d8ce45f6
R13: 00007ffdc87f4570 R14: 0000555555a33810 R15: 00007ffdc87f45b0
 </TASK>

The buggy address belongs to the physical page:
page:ffffea00021b6080 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x86d82
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea00021b60c8 ffffea00021cd108 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5709, tgid 5709 (udevadm), ts 809679576496, free_ts 809958426983
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 __folio_alloc+0xf/0x30 mm/page_alloc.c:5580
 vma_alloc_folio+0x662/0xb60 mm/mempolicy.c:2231
 alloc_page_vma include/linux/gfp.h:290 [inline]
 do_cow_fault+0xa6/0x5d0 mm/memory.c:4543
 do_fault mm/memory.c:4655 [inline]
 handle_pte_fault mm/memory.c:4917 [inline]
 __handle_mm_fault mm/memory.c:5059 [inline]
 handle_mm_fault+0x1b9d/0x3590 mm/memory.c:5157
 do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1397
 handle_page_fault arch/x86/mm/fault.c:1488 [inline]
 exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1544
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page_list+0xb4/0x7b0 mm/page_alloc.c:3522
 release_pages+0x22c3/0x2540 mm/swap.c:1012
 tlb_batch_pages_flush mm/mmu_gather.c:58 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:255 [inline]
 tlb_flush_mmu+0x850/0xa70 mm/mmu_gather.c:262
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:353
 exit_mmap+0x1cb/0x520 mm/mmap.c:3118
 __mmput+0x111/0x3a0 kernel/fork.c:1187
 exit_mm+0x1ef/0x2c0 kernel/exit.c:510
 do_exit+0x4e1/0x20a0 kernel/exit.c:782
 do_group_exit+0x23b/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888086d81f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888086d81f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888086d82000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888086d82080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888086d82100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
