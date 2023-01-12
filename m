Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD00A666FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjALKab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjALK3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:29:31 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CA2637C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:26:51 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id o16-20020a056602225000b006e032e361ccso10956889ioo.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3Yts9DOxWZmPT8UTRvMVE+Tyx3oMKf8LglGOmcPp/A=;
        b=krlo0wlEJh+j4rMZEd3U6T+6y3gg5oz6oZsCLMnPkX6VrwPuKOqlfuQTH+6ZV759DC
         OkKKZeK1DzfuZvLCUY/iVCfaqMcjfwGS+ciK1eHrPc3MsyEpnIleAtJtKB3ojvaJUPAP
         Fn3EmCZjJxJN0/gsLNtUIk1JW89zsj/szZRU9rtlG7fRfwLAVNJV7WG7Jzep4f7nABxU
         1RqBOqnhny9YgYvhW2jQCyt30c5OSYWVEUIcnibnX77XQCiLK61zYVQU3++RSZfO9Nni
         AC4J1+HQg0H46IFNxY3qoALRaTvTeV4ZtpoQ7llnE7o0aZNHvA/Im+Fgs1OoPQ/CH6/S
         K+tA==
X-Gm-Message-State: AFqh2ko003SqNJK2+oA8/Dk4rJNC2AV57uamm3za7viJ4pC+Z5LmtEvc
        iXUi83h9G+oYwCY5DK3I1woeS4hcJtNk8WQSj6lNVyy7pHM1
X-Google-Smtp-Source: AMrXdXtkwQhXvpIM/9kf94zUzAzYs1ZGZ/0CUXvjcIPLIA6XMviTzF2ZohnHx4gIo/I2UUQp1C2SVyhLnDUhq6gzUyF+5/TGKsII
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:505:b0:30d:851a:bc75 with SMTP id
 d5-20020a056e02050500b0030d851abc75mr4096379ils.6.1673519209411; Thu, 12 Jan
 2023 02:26:49 -0800 (PST)
Date:   Thu, 12 Jan 2023 02:26:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000007a6305f20e8e6a@google.com>
Subject: [syzbot] KASAN: use-after-free Read in next_signal
From:   syzbot <syzbot+2ab082603ac60543cf47@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17d2c2a6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=2ab082603ac60543cf47
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ab082603ac60543cf47@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in next_signal+0xa7/0xc0 kernel/signal.c:219
Read of size 8 at addr ffff88807e25d1b8 by task syz-executor.3/23302

CPU: 1 PID: 23302 Comm: syz-executor.3 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 next_signal+0xa7/0xc0 kernel/signal.c:219
 signalfd_poll+0x119/0x200 fs/signalfd.c:59
 vfs_poll include/linux/poll.h:88 [inline]
 io_poll_check_events io_uring/poll.c:279 [inline]
 io_poll_task_func+0x3a6/0x1220 io_uring/poll.c:327
 handle_tw_list+0xa8/0x460 io_uring/io_uring.c:1169
 tctx_task_work+0x12e/0x530 io_uring/io_uring.c:1224
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x24f0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faa6688c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faa67624168 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffe00 RBX: 00007faa669abf80 RCX: 00007faa6688c0c9
RDX: 000000000000006e RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007faa668e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd896a425f R14: 00007faa67624300 R15: 0000000000022000
 </TASK>

Allocated by task 23302:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 do_signalfd4+0x261/0x3c0 fs/signalfd.c:268
 __do_sys_signalfd4 fs/signalfd.c:311 [inline]
 __se_sys_signalfd4 fs/signalfd.c:302 [inline]
 __x64_sys_signalfd4+0x13c/0x1c0 fs/signalfd.c:302
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 23302:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 signalfd_release+0x37/0x50 fs/signalfd.c:47
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x24f0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807e25d1b8
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes inside of
 8-byte region [ffff88807e25d1b8, ffff88807e25d1c0)

The buggy address belongs to the physical page:
page:ffffea0001f89740 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e25d
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888012441280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 22224, tgid 22215 (syz-executor.1), ts 1816170214198, free_ts 1814848860014
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2281
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x330 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0x4d/0xd0 mm/slab_common.c:974
 kmalloc_node include/linux/slab.h:610 [inline]
 __vmalloc_area_node mm/vmalloc.c:3062 [inline]
 __vmalloc_node_range+0xc0b/0x12e0 mm/vmalloc.c:3246
 __vmalloc_node mm/vmalloc.c:3311 [inline]
 vmalloc+0x6b/0x80 mm/vmalloc.c:3344
 bpf_prog_calc_tag+0xcd/0x6c0 kernel/bpf/core.c:290
 resolve_pseudo_ldimm64 kernel/bpf/verifier.c:14371 [inline]
 bpf_check+0x1c89/0xacc0 kernel/bpf/verifier.c:16947
 bpf_prog_load+0x1548/0x2150 kernel/bpf/syscall.c:2609
 __sys_bpf+0x1435/0x5100 kernel/bpf/syscall.c:4969
 __do_sys_bpf kernel/bpf/syscall.c:5073 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5071 [inline]
 __x64_sys_bpf+0x79/0xc0 kernel/bpf/syscall.c:5071
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page_list+0x176/0xcd0 mm/page_alloc.c:3528
 release_pages+0xcb1/0x1330 mm/swap.c:1072
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x202/0x7c0 mm/mmap.c:3100
 __mmput+0x128/0x4c0 kernel/fork.c:1212
 mmput+0x60/0x70 kernel/fork.c:1234
 exit_mm kernel/exit.c:563 [inline]
 do_exit+0x9ac/0x2a90 kernel/exit.c:854
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 get_signal+0x225f/0x24f0 kernel/signal.c:2859
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807e25d080: fc fc fc fc fa fc fc fc fc fa fc fc fc fc fa fc
 ffff88807e25d100: fc fc fc fa fc fc fc fc fa fc fc fc fc fa fc fc
>ffff88807e25d180: fc fc fa fc fc fc fc fa fc fc fc fc fb fc fc fc
                                        ^
 ffff88807e25d200: fc fb fc fc fc fc fb fc fc fc fc fb fc fc fc fc
 ffff88807e25d280: fa fc fc fc fc fa fc fc fc fc fa fc fc fc fc fa
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
