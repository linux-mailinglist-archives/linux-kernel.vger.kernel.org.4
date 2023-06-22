Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870F7739741
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjFVGMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFVGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:12:43 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D8A1739
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:12:40 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3426ee45975so36349505ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687414359; x=1690006359;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2dMr/xz0yMoDdaJj0swaIzPCe7B560XF27mhCngssI=;
        b=T6/X5ZrmldPPYP+jkiHEbDPCML0JyZXsZw2R48uHAML2YLP7pwHgv/MgC5spsJvPpr
         YAXCz86K/Ui84F5/g6QjTmGb3dA+kVSE5sLkdQrU3YcMyw4btzAb/vLOIBmNhUk9vaD0
         T4XvxJebdP7CWPWpXuqhrDHuXvlwoKJlPJiU96q4q1/tiRTtfK8WHuYiG/ysaV1RWy0c
         3db3DQ3AiRbcXoRDJZdTx4riRYohx2fP7Ui7/TcQW907KE8CH5NxqbiDA+F76QSPyvbt
         xuBuKVfxbsQqPm5Sihy+a/prPnOaA/c2wIiiWJncTjxjM867R6JxyvB/01Fs+X7+sMtn
         WEwQ==
X-Gm-Message-State: AC+VfDzo0bMuz4Ji9Gai+pGdS3H1WdhB3mWP8+M60DteG9lb8Fu1y86W
        ZsTHG7odY9Cg46RuDsXniTenRCr1IMW98+UfTh/XEqexwjjz
X-Google-Smtp-Source: ACHHUZ6mxVJcRyg5ba4LgBFNnGjNfHl7PI+M3tF24K9TT9Voy2e28omad908qXpgJ/3Bz4CQlRTeSKXc1/efCANF2+QsAQ0qgV13
MIME-Version: 1.0
X-Received: by 2002:a92:c0c8:0:b0:33e:6d38:8f7b with SMTP id
 t8-20020a92c0c8000000b0033e6d388f7bmr6864150ilf.1.1687414359449; Wed, 21 Jun
 2023 23:12:39 -0700 (PDT)
Date:   Wed, 21 Jun 2023 23:12:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007be8cc05feb1c590@google.com>
Subject: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in remove_wait_queue
From:   syzbot <syzbot+e0b9084463edf54b83c4@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    99ec1ed7c2ed Merge tag '6.4-rc6-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f9cdf3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=e0b9084463edf54b83c4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8ce811aa7d80/disk-99ec1ed7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2b30638505a/vmlinux-99ec1ed7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93293b228847/bzImage-99ec1ed7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e0b9084463edf54b83c4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x41b9/0x5f30 kernel/locking/lockdep.c:4956
Read of size 8 at addr ffff888020c4fd28 by task syz-executor.0/25827

CPU: 1 PID: 25827 Comm: syz-executor.0 Not tainted 6.4.0-rc7-syzkaller-00019-g99ec1ed7c2ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 __lock_acquire+0x41b9/0x5f30 kernel/locking/lockdep.c:4956
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5670
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 remove_wait_queue+0x21/0x180 kernel/sched/wait.c:54
 hidraw_read+0x5e8/0xa80 drivers/hid/hidraw.c:74
 vfs_read+0x1e1/0x8a0 fs/read_write.c:468
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f245ac8c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f245ba30168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f245adac050 RCX: 00007f245ac8c389
RDX: 00000000200001da RSI: 0000000020000100 RDI: 0000000000000005
RBP: 00007f245acd7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f245aecfb1f R14: 00007f245ba30300 R15: 0000000000022000
 </TASK>

Allocated by task 4746:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 hidraw_connect+0x4f/0x450 drivers/hid/hidraw.c:545
 hid_connect+0x10b8/0x18c0 drivers/hid/hid-core.c:2195
 hid_hw_start drivers/hid/hid-core.c:2302 [inline]
 hid_hw_start+0xa6/0x130 drivers/hid/hid-core.c:2293
 hid_device_probe+0x383/0x3d0 drivers/hid/hid-core.c:2637
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:958
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 hid_add_device+0x377/0xa60 drivers/hid/hid-core.c:2785
 usbhid_probe+0xc49/0x1100 drivers/hid/usbhid/hid-core.c:1429
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:958
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_set_configuration+0x1196/0x1bc0 drivers/usb/core/message.c:2211
 usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:958
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2575
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Freed by task 4746:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3786 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3799
 drop_ref+0x28f/0x390 drivers/hid/hidraw.c:335
 hidraw_disconnect+0x4c/0x70 drivers/hid/hidraw.c:601
 hid_disconnect+0x134/0x1b0 drivers/hid/hid-core.c:2277
 hid_hw_stop drivers/hid/hid-core.c:2322 [inline]
 hid_device_remove+0x174/0x210 drivers/hid/hid-core.c:2664
 device_remove+0xc8/0x170 drivers/base/dd.c:567
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x443/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x399/0xa30 drivers/base/core.c:3814
 hid_remove_device drivers/hid/hid-core.c:2835 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2855
 usbhid_disconnect+0xa3/0xe0 drivers/hid/usbhid/hid-core.c:1456
 usb_unbind_interface+0x1dc/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x443/0x610 drivers/base/dd.c:1295
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x399/0xa30 drivers/base/core.c:3814
 usb_disable_device+0x360/0x7b0 drivers/usb/core/message.c:1420
 usb_disconnect+0x2db/0x8a0 drivers/usb/core/hub.c:2238
 hub_port_connect drivers/usb/core/hub.c:5246 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x1fbf/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888020c4fd00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 40 bytes inside of
 freed 192-byte region [ffff888020c4fd00, ffff888020c4fdc0)

The buggy address belongs to the physical page:
page:ffffea00008313c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888020c4f700 pfn:0x20c4f
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888012441a00 ffffea0001e0f100 dead000000000002
raw: ffff888020c4f700 000000008010000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5055, tgid 5055 (syz-executor.4), ts 451103824327, free_ts 451062516182
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_slab_page mm/slub.c:1853 [inline]
 allocate_slab+0xa7/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc_node+0x51/0x1a0 mm/slab_common.c:973
 kmalloc_array_node include/linux/slab.h:657 [inline]
 kcalloc_node include/linux/slab.h:662 [inline]
 memcg_alloc_slab_cgroups+0x8f/0x150 mm/memcontrol.c:2928
 account_slab mm/slab.h:597 [inline]
 allocate_slab+0x2d6/0x390 mm/slub.c:2016
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 slab_alloc mm/slub.c:3459 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3466 [inline]
 kmem_cache_alloc+0x38e/0x3b0 mm/slub.c:3475
 vma_lock_alloc kernel/fork.c:463 [inline]
 vm_area_dup+0x55/0x300 kernel/fork.c:516
 dup_mmap+0x713/0x19d0 kernel/fork.c:713
 dup_mm kernel/fork.c:1692 [inline]
 copy_mm kernel/fork.c:1741 [inline]
 copy_process+0x6663/0x75c0 kernel/fork.c:2507
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2564
 free_unref_page_list+0xe3/0xa70 mm/page_alloc.c:2705
 release_pages+0xcd8/0x1380 mm/swap.c:1042
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x2b2/0x930 mm/mmap.c:3120
 __mmput+0x128/0x4c0 kernel/fork.c:1351
 mmput+0x60/0x70 kernel/fork.c:1373
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9b0/0x29b0 kernel/exit.c:861
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x2318/0x25b0 kernel/signal.c:2876
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888020c4fc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888020c4fc80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888020c4fd00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff888020c4fd80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888020c4fe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


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

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
