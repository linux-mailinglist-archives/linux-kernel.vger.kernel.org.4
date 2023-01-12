Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D28C666F47
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbjALKOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbjALKNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:13:54 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5C8654C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:12:40 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id p2-20020a5d9842000000b007047916de1cso923907ios.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hJHl7iV8f1sYSqGJtEFNLAOHn3tn9sXTJHzL+rZ44k=;
        b=2nmCR7ZZPVDFDBxVwGLNoSQd1ZuOsG5+Lluga0hu2sa0IPe5BPFIZ5VvNHNX+CNuCw
         QDPU3H1JtIexB6+8pLAKY30Sul4bItwNmx52q1VuVsmb5J64lBSzteBkzB8kd9VQaKWE
         S7NKDuQWzw4m0yueo1W74vqsjKo9AXkxmWEZcoxNJJGykw1fu9XusYLtVyMUS43e156n
         MAk+D/jL8ySmznitt+6Bnpb3IIk2jOVd7m6qOuNujhW20l/+IGbXmSug5ING69Jcddrx
         A3OFpB5qUUQaKGKnNOr9w878CAR9O6RsZlhTE2vIUsYnRFi8CsDfDHJp6aRYQURAHq1a
         sl3Q==
X-Gm-Message-State: AFqh2kr070w6PCbj2itYuVysnA2gHJEDbdIeo3vb4guFaHSmg6yKDEQ+
        ETxbfPcNoIXn99ZU7pMQDTTLV9F2COmb6QRK129y/ohGu2RO
X-Google-Smtp-Source: AMrXdXurBxuYu0nhD0PaEOwHTy7qvi0IMq+b8qmXhXbFK7SZ28SbXP+kfBgzivzv0yQ+mAeHgD/g4rExqh9Bz48nPCQy0ihcNA4/
MIME-Version: 1.0
X-Received: by 2002:a05:6638:50b:b0:373:d769:bc14 with SMTP id
 i11-20020a056638050b00b00373d769bc14mr8061266jar.264.1673518359945; Thu, 12
 Jan 2023 02:12:39 -0800 (PST)
Date:   Thu, 12 Jan 2023 02:12:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ea9dd05f20e5b48@google.com>
Subject: [syzbot] KASAN: use-after-free Read in snd_rawmidi_poll
From:   syzbot <syzbot+e3ec01fd2d18c9264c3b@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1748baa1480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e3ec01fd2d18c9264c3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3ec01fd2d18c9264c3b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in snd_rawmidi_poll+0x559/0x680 sound/core/rawmidi.c:1655
Read of size 8 at addr ffff8881479ea708 by task syz-executor.0/7629

CPU: 1 PID: 7629 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 snd_rawmidi_poll+0x559/0x680 sound/core/rawmidi.c:1655
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
RIP: 0033:0x7f66cbc8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f66cc936168 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: fffffffffffffe00 RBX: 00007f66cbdabf80 RCX: 00007f66cbc8c0c9
RDX: 0000000000000001 RSI: 0000000020000800 RDI: 0000000000000006
RBP: 00007f66cbce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe231decef R14: 00007f66cc936300 R15: 0000000000022000
 </TASK>

Allocated by task 7629:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 snd_rawmidi_open+0x39a/0xb70 sound/core/rawmidi.c:482
 snd_open+0x223/0x460 sound/core/sound.c:169
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

Freed by task 7629:
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
 snd_rawmidi_release+0x6a/0xf0 sound/core/rawmidi.c:619
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

The buggy address belongs to the object at ffff8881479ea700
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 8 bytes inside of
 32-byte region [ffff8881479ea700, ffff8881479ea720)

The buggy address belongs to the physical page:
page:ffffea00051e7a80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1479ea
flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000200 ffff888012441500 ffffea0001debd00 dead000000000004
raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 9844741481, free_ts 0
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2114
 alloc_pages+0x233/0x270 mm/mempolicy.c:2276
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x330 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x4a/0xd0 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 usb_get_configuration+0x381/0x3b60 drivers/usb/core/config.c:919
 usb_enumerate_device drivers/usb/core/hub.c:2405 [inline]
 usb_new_device+0x56a/0x7b0 drivers/usb/core/hub.c:2543
 register_root_hub+0x421/0x573 drivers/usb/core/hcd.c:1017
 usb_add_hcd.cold+0x100c/0x13a1 drivers/usb/core/hcd.c:2991
 vhci_hcd_probe+0x14f/0x3a0 drivers/usb/usbip/vhci_hcd.c:1362
 platform_probe+0x100/0x1f0 drivers/base/platform.c:1400
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8881479ea600: 00 00 00 00 fc fc fc fc 00 00 00 07 fc fc fc fc
 ffff8881479ea680: fa fb fb fb fc fc fc fc 00 00 00 07 fc fc fc fc
>ffff8881479ea700: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
                      ^
 ffff8881479ea780: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff8881479ea800: 00 00 00 01 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
