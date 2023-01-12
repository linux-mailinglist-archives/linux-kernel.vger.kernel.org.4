Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F289A666F56
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjALKQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbjALKOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:14:43 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818A613D34
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:13:40 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id z19-20020a921a53000000b0030b90211df1so12890175ill.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:13:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4z+4JMdufQd0xjAzXlpUq0cUo/jRkL5ILtP7IbjE2Lc=;
        b=5cg8S68IVw32KzWfINl13x8dMKwAyOrFDD2MJMqEZu9gPqBKydv8nqcoupxwkC/gHg
         a29AWrCxElCAmIaDcT/X0/Oxje4vCSTFu06oyJxl4BnrPtUIGuxmKgz+3NcrPRdVogrO
         1bgXL2L1yNnUx32ZZNGjcwEX6CU6ZGVF3k/q7Xhjo0WPKyEhm4rwJYw2ngOJ1h349/C6
         ZtYrqFlgsmRkTTR6QWU42gCwz3UT61q3CmKelHnbZJ7Duhgyv1Gy6S7nHwHri6ClbaKW
         NpdrDvRNb3t0mHCsqhvZdRIGvPujTni5KBiyyQHOOMoC4jGKYoTUSXLhqaIlRuC59Hmy
         X4pw==
X-Gm-Message-State: AFqh2koTFZWIJyfy2DpHBxg+GPG9juyfslgbeLdEo99wF5g2gjoSqmB8
        zK3FkPnxa1lOCvEYMnFsEuNmxPVSQESpcIoBbgrKh/MWZhu3
X-Google-Smtp-Source: AMrXdXuDI20Vy67NuqBxivbd6GryckYXfGRT7ozAJz4j1EH4bb3/cHvvWRI97XkiFMui40vDVvzC8lozLmWVwUqhT8uWT7lZd3ek
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2a5:b0:38a:2cb1:7796 with SMTP id
 d5-20020a05663802a500b0038a2cb17796mr7804431jaq.267.1673518419868; Thu, 12
 Jan 2023 02:13:39 -0800 (PST)
Date:   Thu, 12 Jan 2023 02:13:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1068105f20e5e8f@google.com>
Subject: [syzbot] KASAN: use-after-free Read in snd_pcm_oss_poll
From:   syzbot <syzbot+ee73befabe68e7907adf@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16d906ea480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=ee73befabe68e7907adf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ee73befabe68e7907adf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in snd_pcm_oss_poll+0x91c/0xab0 sound/core/oss/pcm_oss.c:2849
Read of size 8 at addr ffff8880222ed980 by task syz-executor.0/13421

CPU: 0 PID: 13421 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 snd_pcm_oss_poll+0x91c/0xab0 sound/core/oss/pcm_oss.c:2849
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
RIP: 0033:0x7fbb08c8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbb099a6218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007fbb08dabf88 RCX: 00007fbb08c8c0c9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fbb08dabf8c
RBP: 00007fbb08dabf80 R08: 00007ffdf79a3080 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007fbb08dabf8c
R13: 00007ffdf794d43f R14: 00007fbb099a6300 R15: 0000000000022000
 </TASK>

Allocated by task 13421:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2433 [inline]
 snd_pcm_oss_open.part.0+0x558/0x1330 sound/core/oss/pcm_oss.c:2535
 snd_pcm_oss_open+0x44/0x60 sound/core/oss/pcm_oss.c:2499
 soundcore_open+0x452/0x620 sound/sound_core.c:593
 chrdev_open+0x26a/0x770 fs/char_dev.c:414
 do_dentry_open+0x6cc/0x13f0 fs/open.c:883
 do_open fs/namei.c:3558 [inline]
 path_openat+0x1bc1/0x2b40 fs/namei.c:3715
 do_filp_open+0x1ba/0x410 fs/namei.c:3742
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 13421:
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
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2415 [inline]
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2405 [inline]
 snd_pcm_oss_release+0x182/0x300 sound/core/oss/pcm_oss.c:2592
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

The buggy address belongs to the object at ffff8880222ed980
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes inside of
 16-byte region [ffff8880222ed980, ffff8880222ed990)

The buggy address belongs to the physical page:
page:ffffea000088bb40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x222ed
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff8880124413c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5107, tgid 5107 (syz-executor.1), ts 750843463810, free_ts 748166918947
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_slab_page mm/slub.c:1853 [inline]
 allocate_slab+0xa7/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x330 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0x4d/0xd0 mm/slab_common.c:974
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0xa2/0x1a0 mm/util.c:603
 xt_jumpstack_alloc net/netfilter/x_tables.c:1354 [inline]
 xt_replace_table+0x1a7/0x8c0 net/netfilter/x_tables.c:1393
 __do_replace+0x1d7/0x8e0 net/ipv4/netfilter/ip_tables.c:1067
 do_replace net/ipv4/netfilter/ip_tables.c:1140 [inline]
 do_ipt_set_ctl+0x89d/0xb10 net/ipv4/netfilter/ip_tables.c:1630
 nf_setsockopt+0x87/0xe0 net/netfilter/nf_sockopt.c:101
 ip_setsockopt+0xf2/0x110 net/ipv4/ip_sockglue.c:1445
 tcp_setsockopt+0x9f/0x100 net/ipv4/tcp.c:3802
 __sys_setsockopt+0x2c6/0x5b0 net/socket.c:2246
 __do_sys_setsockopt net/socket.c:2257 [inline]
 __se_sys_setsockopt net/socket.c:2254 [inline]
 __x64_sys_setsockopt+0xbe/0x160 net/socket.c:2254
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2637
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x175/0x320 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 alloc_buffer_head+0x24/0x150 fs/buffer.c:2946
 alloc_page_buffers+0x284/0x790 fs/buffer.c:871
 create_empty_buffers+0x30/0xf30 fs/buffer.c:1585
 ext4_block_write_begin+0x10a7/0x15f0 fs/ext4/inode.c:1080
 ext4_da_write_begin+0x450/0xb70 fs/ext4/inode.c:3082
 generic_perform_write+0x256/0x570 mm/filemap.c:3772
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:285
 ext4_file_write_iter+0x8bf/0x1710 fs/ext4/file.c:700
 __kernel_write_iter+0x262/0x730 fs/read_write.c:517

Memory state around the buggy address:
 ffff8880222ed880: 00 00 fc fc fa fb fc fc fa fb fc fc fa fb fc fc
 ffff8880222ed900: fa fb fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc
>ffff8880222ed980: fa fb fc fc fa fb fc fc 00 00 fc fc 00 00 fc fc
                   ^
 ffff8880222eda00: 00 00 fc fc 00 00 fc fc fa fb fc fc 00 00 fc fc
 ffff8880222eda80: fa fb fc fc 00 00 fc fc fa fb fc fc fa fb fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
