Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5CB6954E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 00:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjBMXkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 18:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBMXkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 18:40:49 -0500
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3541ACC30
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:40:44 -0800 (PST)
Received: by mail-il1-f208.google.com with SMTP id n18-20020a056e02101200b0030f2b79c2ffso10353818ilj.20
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 15:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T96tNQ98xYNkeyLm/ikfyyjI3SBhxjFAaS1vmseZYrw=;
        b=CCZQg6KJH3zlRkFMFhEewZd5Cwj4vlhESG7p3gQz26JFFBe5ZsEGcofYPRR/of05Fj
         sBbqQLhbkQhMGVS8w+HPm1+kEhYx624LtR0go68wHEdOfmRKuKEdvXJkqH1B9N3G4gY+
         GBN3tVXbj9RKif2lfG4bga1iL5QBal0dqaUyI07BNMmrY4z9hcMsBbty1wFGYF6g3EC3
         XKNQxs22ps+MFElu6MWt1cUyX8ye+46f1YjM9fpPrCYnFEOlEqvZ+A0QmkOSyGnM2fcu
         JYJVS6X6bROdqP70IpxJ8KqN8Wt9Vk4KafIxU9iwAgkrLPFgQrDhCjKi5OXYFZPwqVcd
         pyCQ==
X-Gm-Message-State: AO0yUKX2eZhKmK7InPc8Xl+1ej4mmFuyEt1zeOBn8bEYX9QUG4e3Z35P
        IA8sE+Guhc509WOJjUQ8XduUAfHTdL8LULBQjLOdTxIlkomPLl05gw==
X-Google-Smtp-Source: AK7set+o+f4k/1hDdRq3ZCMdX6xGl3x0jWtmixz9HWvT8Xwc1AMdX/IAWmr/diQvDBsmefRlqZ+/jT6QRlNjz6S0ReZtFrwZpdXm
MIME-Version: 1.0
X-Received: by 2002:a5d:8799:0:b0:717:f07e:f74f with SMTP id
 f25-20020a5d8799000000b00717f07ef74fmr54374ion.55.1676331643582; Mon, 13 Feb
 2023 15:40:43 -0800 (PST)
Date:   Mon, 13 Feb 2023 15:40:43 -0800
In-Reply-To: <00000000000073b6d905eb48de3f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000243cc205f49d60c1@google.com>
Subject: Re: [syzbot] [reiserfs?] BUG: unable to handle kernel NULL pointer
 dereference in reiserfs_find_entry
From:   syzbot <syzbot+4654552e088ed458b10d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ceaa837f96ad Linux 6.2-rc8
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=121b8ac7480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42ba4da8e1e6af9f
dashboard link: https://syzkaller.appspot.com/bug?extid=4654552e088ed458b10d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15852a00c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10146167480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/88042f9b5fc8/disk-ceaa837f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9945b57ec9ee/vmlinux-ceaa837f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72ff118ed96b/bzImage-ceaa837f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/804b18b8485e/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4654552e088ed458b10d@syzkaller.appspotmail.com

REISERFS warning:  read_super_block: reiserfs filesystem is deprecated and scheduled to be removed from the kernel in 2025
REISERFS (device loop0): found reiserfs format "3.5" with non-standard journal
REISERFS (device loop0): using ordered data mode
reiserfs: using flush barriers
REISERFS (device loop0): journal params: device loop0, size 512, journal first block 18, max trans len 256, max batch 225, max commit age 30, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using r5 hash to sort names
==================================================================
BUG: KASAN: use-after-free in strlen+0x58/0x70 lib/string.c:418
Read of size 1 at addr ffff8880727180c4 by task syz-executor942/5076

CPU: 0 PID: 5076 Comm: syz-executor942 Not tainted 6.2.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x163/0x4f0 mm/kasan/report.c:417
 kasan_report+0x13a/0x170 mm/kasan/report.c:517
 strlen+0x58/0x70 lib/string.c:418
 set_de_name_and_namelen fs/reiserfs/namei.c:82 [inline]
 linear_search_in_dir_item fs/reiserfs/namei.c:262 [inline]
 reiserfs_find_entry+0x982/0x19b0 fs/reiserfs/namei.c:331
 reiserfs_lookup+0x1ea/0x4b0 fs/reiserfs/namei.c:368
 __lookup_slow+0x282/0x3e0 fs/namei.c:1685
 lookup_one_len+0x18b/0x2d0 fs/namei.c:2711
 reiserfs_lookup_privroot+0x89/0x1e0 fs/reiserfs/xattr.c:973
 reiserfs_fill_super+0x195b/0x2620 fs/reiserfs/super.c:2192
 mount_bdev+0x271/0x3a0 fs/super.c:1359
 legacy_get_tree+0xef/0x190 fs/fs_context.c:610
 vfs_get_tree+0x8c/0x270 fs/super.c:1489
 do_new_mount+0x28f/0xae0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0deea57d0a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe5e115c98 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000055555718e2c0 RCX: 00007f0deea57d0a
RDX: 00000000200000c0 RSI: 0000000020000040 RDI: 00007ffe5e115ce0
RBP: 0000000000000000 R08: 00007ffe5e115d20 R09: 000000000000111a
R10: 0000000000008001 R11: 0000000000000286 R12: 0000000000000004
R13: 00007ffe5e115d20 R14: 0000000000000003 R15: 00007ffe5e115ce0
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0001c9c600 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1 pfn:0x72718
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 ffffea0001c9bec8 ffff8880b9841e20 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 5074, tgid 5074 (syz-executor942), ts 68154639328, free_ts 68338552355
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x3449/0x35c0 mm/page_alloc.c:4283
 __alloc_pages+0x291/0x7e0 mm/page_alloc.c:5549
 __folio_alloc+0x13/0x30 mm/page_alloc.c:5581
 vma_alloc_folio+0x48a/0x9a0 mm/mempolicy.c:2248
 shmem_alloc_folio mm/shmem.c:1569 [inline]
 shmem_alloc_and_acct_folio+0x596/0xd40 mm/shmem.c:1593
 shmem_get_folio_gfp+0x1408/0x34a0 mm/shmem.c:1920
 shmem_get_folio mm/shmem.c:2051 [inline]
 shmem_write_begin+0x172/0x4f0 mm/shmem.c:2543
 generic_perform_write+0x300/0x5e0 mm/filemap.c:3772
 __generic_file_write_iter+0x17a/0x400 mm/filemap.c:3900
 generic_file_write_iter+0xaf/0x310 mm/filemap.c:3932
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7b2/0xbb0 fs/read_write.c:584
 ksys_write+0x1a0/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare mm/page_alloc.c:1496 [inline]
 free_unref_page_prepare+0xf3a/0x1040 mm/page_alloc.c:3369
 free_unref_page_list+0x6b1/0x950 mm/page_alloc.c:3510
 release_pages+0x219e/0x2470 mm/swap.c:1076
 __pagevec_release+0x84/0x100 mm/swap.c:1096
 pagevec_release include/linux/pagevec.h:71 [inline]
 folio_batch_release include/linux/pagevec.h:135 [inline]
 shmem_undo_range+0x6b6/0x1dd0 mm/shmem.c:947
 shmem_truncate_range mm/shmem.c:1042 [inline]
 shmem_evict_inode+0x258/0x9f0 mm/shmem.c:1151
 evict+0x2a4/0x620 fs/inode.c:664
 __dentry_kill+0x436/0x650 fs/dcache.c:607
 dentry_kill+0xbb/0x290
 dput+0x1d8/0x3f0 fs/dcache.c:913
 __fput+0x5e4/0x890 fs/file_table.c:328
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 ptrace_notify+0x2a2/0x350 kernel/signal.c:2354
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x171/0x2e0 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888072717f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888072718000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888072718080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                           ^
 ffff888072718100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888072718180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

