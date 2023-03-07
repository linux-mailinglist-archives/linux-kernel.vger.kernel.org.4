Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026836AD8EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCGIPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjCGIPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:15:51 -0500
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC60050984
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:15:49 -0800 (PST)
Received: by mail-io1-f78.google.com with SMTP id z6-20020a056602080600b007407df88db0so6803657iow.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176949;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxmcfZ0a/cApsYpXdgFIc/3B7jtdxdYj+LO2ZQSpEjQ=;
        b=bapuoQzVI4npFOD8ABap0kV5ChtjWFnodrawcNQ7iAI+Z+gq5VR5uQae8bVR8T2yj/
         ifUYgA2XJ07GjUYOEVeRBrzyHa5zAyrhGlFBuahrORoUPAm8FtxgR929ywWQsYakt5ta
         wR7fDgDK7tjfCK/uwte9RKa3d6+rhLDbjf9PCPrGJaKACgREU4ymELfQ2/wkZt5zTLug
         O7ptiyrza+gFEB2AYmHSmuC/y5U5buTyvC/0/YtmRuXVzPgT+CgpIpOwUmTdkTSalAsG
         wtxlru6DCsIP+V1Z3jmPN/R66xrO9p+ISwEhbMh2ZLltE22nqfhTgu8ZHHbtdw6zpfpX
         8WVA==
X-Gm-Message-State: AO0yUKWxlw6RAIotE67cIrgAYMCFI31GKBzt7qixXcOsZnWTGC/NHulB
        igQ25zpq3Zf/f33/LX81UfKIXnDPpqE47ulLeCe7OxtRlcGT
X-Google-Smtp-Source: AK7set/om8T58SQp91UqobwZ1i1b4AXfh0OpgyH0ZSmonaiMxy0kxuFXE+Froe2DhFgp0tnpyidaq3mc/A8fKmb9gQgEMUS1pLOm
MIME-Version: 1.0
X-Received: by 2002:a92:3312:0:b0:321:9d48:2b13 with SMTP id
 a18-20020a923312000000b003219d482b13mr1808575ilf.4.1678176949103; Tue, 07 Mar
 2023 00:15:49 -0800 (PST)
Date:   Tue, 07 Mar 2023 00:15:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebf27305f64b04d8@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in dev_uevent
From:   syzbot <syzbot+5ee79919ffe91d629b96@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f915322fe014 Merge tag 'v6.3-p2' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1190526cc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc0f7cfe5b32efe2
dashboard link: https://syzkaller.appspot.com/bug?extid=5ee79919ffe91d629b96
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b5906c911a8/disk-f915322f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dba92a9c1a17/vmlinux-f915322f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4fca23736a8/bzImage-f915322f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ee79919ffe91d629b96@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:644 [inline]
BUG: KASAN: slab-use-after-free in string+0x218/0x2b0 lib/vsprintf.c:726
Read of size 1 at addr ffff88807d2fc280 by task udevd/4434

CPU: 1 PID: 4434 Comm: udevd Not tainted 6.2.0-syzkaller-13563-gf915322fe014 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:319 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:430
 kasan_report+0x176/0x1b0 mm/kasan/report.c:536
 string_nocheck lib/vsprintf.c:644 [inline]
 string+0x218/0x2b0 lib/vsprintf.c:726
 vsnprintf+0x10fc/0x1d80 lib/vsprintf.c:2796
 add_uevent_var+0x1c4/0x440 lib/kobject_uevent.c:665
 dev_uevent+0x3ec/0x8f0 drivers/base/core.c:2527
 uevent_show+0x19a/0x310 drivers/base/core.c:2598
 dev_attr_show+0x54/0xc0 drivers/base/core.c:2301
 sysfs_kf_seq_show+0x331/0x4b0 fs/sysfs/file.c:59
 seq_read_iter+0x43e/0xd10 fs/seq_file.c:230
 call_read_iter include/linux/fs.h:1845 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7e2/0xbe0 fs/read_write.c:470
 ksys_read+0x1a0/0x2c0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0a165258fe
Code: c0 e9 e6 fe ff ff 50 48 8d 3d 0e c7 09 00 e8 c9 cf 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007ffec00b7aa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000561c4316e5c0 RCX: 00007f0a165258fe
RDX: 0000000000001000 RSI: 0000561c43189ba0 RDI: 000000000000000c
RBP: 00007f0a165f2380 R08: 000000000000000c R09: 00007f0a165f5a60
R10: 0000000001000000 R11: 0000000000000246 R12: 0000561c4316e5c0
R13: 0000000000000d68 R14: 00007f0a165f1780 R15: 0000000000000d68
 </TASK>

Allocated by task 22572:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:580 [inline]
 raw_ioctl_init drivers/usb/gadget/legacy/raw_gadget.c:460 [inline]
 raw_ioctl+0x1aad/0x3cd0 drivers/usb/gadget/legacy/raw_gadget.c:1250
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 22572:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0x264/0x3c0 mm/slub.c:3800
 dev_free drivers/usb/gadget/legacy/raw_gadget.c:210 [inline]
 kref_put+0xb5/0x7c0 include/linux/kref.h:65
 raw_release+0x138/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:424
 __fput+0x3b7/0x890 fs/file_table.c:321
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x68f/0x2290 kernel/exit.c:869
 do_group_exit+0x206/0x2c0 kernel/exit.c:1019
 get_signal+0x1701/0x17e0 kernel/signal.c:2859
 arch_do_signal_or_restart+0x91/0x670 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x2e0 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:491
 kvfree_call_rcu+0x109/0x8d0 kernel/rcu/tree.c:3316
 cleanup_net+0x9bb/0xb80 net/core/net_namespace.c:631
 process_one_work+0x915/0x13a0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88807d2fc280
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 freed 32-byte region [ffff88807d2fc280, ffff88807d2fc2a0)

The buggy address belongs to the physical page:
page:ffffea0001f4bf00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7d2fc
ksm flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888012441500 ffffea00009c4080 dead000000000003
raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5113, tgid 5113 (syz-executor.1), ts 244087761826, free_ts 244006526484
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x37e0/0x3970 mm/page_alloc.c:4325
 __alloc_pages+0x291/0x7f0 mm/page_alloc.c:5591
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3491
 kmalloc_trace+0x2a/0x60 mm/slab_common.c:1061
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 vlan_vid_info_alloc net/8021q/vlan_core.c:196 [inline]
 __vlan_vid_add net/8021q/vlan_core.c:302 [inline]
 vlan_vid_add+0x31c/0x750 net/8021q/vlan_core.c:336
 bond_vlan_rx_add_vid+0x14f/0x2e0 drivers/net/bonding/bond_main.c:375
 vlan_add_rx_filter_info net/8021q/vlan_core.c:211 [inline]
 __vlan_vid_add net/8021q/vlan_core.c:306 [inline]
 vlan_vid_add+0x647/0x750 net/8021q/vlan_core.c:336
 vlan_device_event+0x1cb3/0x1df0 net/8021q/vlan.c:385
 notifier_call_chain kernel/notifier.c:87 [inline]
 raw_notifier_call_chain+0xd4/0x170 kernel/notifier.c:455
 __dev_notify_flags+0x359/0x650
 dev_change_flags+0xf0/0x1a0 net/core/dev.c:8604
 do_setlink+0xe93/0x2ae0 net/core/rtnetlink.c:2833
 __rtnl_newlink net/core/rtnetlink.c:3623 [inline]
 rtnl_newlink+0x172d/0x2010 net/core/rtnetlink.c:3670
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare mm/page_alloc.c:1503 [inline]
 free_unref_page_prepare+0xf0e/0xf70 mm/page_alloc.c:3387
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:3482
 tlb_batch_list_free mm/mmu_gather.c:113 [inline]
 tlb_finish_mmu+0x11f/0x1f0 mm/mmu_gather.c:394
 exit_mmap+0x2c9/0x990 mm/mmap.c:3047
 __mmput+0x115/0x3c0 kernel/fork.c:1209
 exit_mm+0x227/0x310 kernel/exit.c:563
 do_exit+0x612/0x2290 kernel/exit.c:856
 do_group_exit+0x206/0x2c0 kernel/exit.c:1019
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1028
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807d2fc180: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff88807d2fc200: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
>ffff88807d2fc280: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
                   ^
 ffff88807d2fc300: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff88807d2fc380: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
