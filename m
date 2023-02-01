Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DE867943B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjAXJaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjAXJaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:30:03 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25262A5E6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:29:49 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g1-20020a92cda1000000b0030c45d93884so10072042ild.16
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0KTMw6cCzKRbJUfPdKu2lT4/KdDwDsrx0tJfevXquI=;
        b=meB0rF01u06MHlwrQmf42wLCAQ3FIuLihFnwuiVQL2qy4QI18D7kVAGZXaUtSbobgw
         dMYwWi42FNiyph5XTfv5m/FFBQllwAPDjnWAeaSQZ84L4XevqgMNtaIDRi/nacCnHXmk
         RPrO21Z/pM4wvTcRoSbzA3V+kYoyJvy0fjlboP8DioN2f/Vo4vcLjiv065DZQ6IPyFfp
         g5NnrMp/f7NI4ehxF/CSeuTPr8cYmhG/pYLr2Bf4AcyBahC/co0FiQn7vThQHeu88+iS
         GGL18YE9w9XTzacdUCatYFOWFGVAxwlhrjPVhVSIIK56R7sKWN++LpHSnLx2y8Lf33TQ
         FPtw==
X-Gm-Message-State: AFqh2kohMVYYj795BQDLrpPGJsCU9cbKbfYOmtgVmplpNXFteEIegk4C
        pkzqPjUcRu1OnaJJqXaj7bTWP+TOMjTpuRWsfq419nULwoGp
X-Google-Smtp-Source: AMrXdXsVIDqIWm24zO7zD6kL8zM/SyVRwwe6mF/xVWokRS6TIH1sfhrC4UAPM++3pnHDCBkQiuSrfNU7p6qdQvpa34UEvspTCcsw
MIME-Version: 1.0
X-Received: by 2002:a02:b793:0:b0:39e:9294:159f with SMTP id
 f19-20020a02b793000000b0039e9294159fmr2673123jam.7.1674552576727; Tue, 24 Jan
 2023 01:29:36 -0800 (PST)
Date:   Tue, 24 Jan 2023 01:29:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e648a05f2ff2727@google.com>
Subject: [syzbot] KASAN: use-after-free Read in hiddev_disconnect (5)
From:   syzbot <syzbot+063c07e14d0399971c93@syzkaller.appspotmail.com>
To:     benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    081edded9b38 Merge tag 'zonefs-6.2-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1305a9b1480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=899d86a7610a0ea0
dashboard link: https://syzkaller.appspot.com/bug?extid=063c07e14d0399971c93
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b3f03c5cb208/disk-081edded.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ea56a8e575ac/vmlinux-081edded.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a717b26e391/bzImage-081edded.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+063c07e14d0399971c93@syzkaller.appspotmail.com

usb 6-1: USB disconnect, device number 35
==================================================================
BUG: KASAN: use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
BUG: KASAN: use-after-free in do_raw_spin_lock+0x265/0x2b0 kernel/locking/spinlock_debug.c:114
Read of size 4 at addr ffff88804225cc1c by task kworker/0:20/21099

CPU: 0 PID: 21099 Comm: kworker/0:20 Not tainted 6.2.0-rc4-syzkaller-00069-g081edded9b38 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
 do_raw_spin_lock+0x265/0x2b0 kernel/locking/spinlock_debug.c:114
 __mutex_unlock_slowpath+0x18e/0x5e0 kernel/locking/mutex.c:932
 hiddev_disconnect+0x158/0x1c0 drivers/hid/usbhid/hiddev.c:940
 hid_disconnect+0xb8/0x1b0 drivers/hid/hid-core.c:2257
 hid_hw_stop drivers/hid/hid-core.c:2302 [inline]
 hid_device_remove+0x161/0x200 drivers/hid/hid-core.c:2634
 device_remove+0xc8/0x170 drivers/base/dd.c:548
 __device_release_driver drivers/base/dd.c:1253 [inline]
 device_release_driver_internal+0x4a5/0x700 drivers/base/dd.c:1279
 bus_remove_device+0x2e7/0x5a0 drivers/base/bus.c:529
 device_del+0x4f7/0xc80 drivers/base/core.c:3666
 hid_remove_device drivers/hid/hid-core.c:2803 [inline]
 hid_destroy_device+0xe5/0x150 drivers/hid/hid-core.c:2822
 usbhid_disconnect+0xa3/0xe0 drivers/hid/usbhid/hid-core.c:1451
 usb_unbind_interface+0x1dc/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:550 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:542
 __device_release_driver drivers/base/dd.c:1253 [inline]
 device_release_driver_internal+0x4a5/0x700 drivers/base/dd.c:1279
 bus_remove_device+0x2e7/0x5a0 drivers/base/bus.c:529
 device_del+0x4f7/0xc80 drivers/base/core.c:3666
 usb_disable_device+0x35a/0x7b0 drivers/usb/core/message.c:1420
 usb_disconnect.cold+0x259/0x6ed drivers/usb/core/hub.c:2235
 hub_port_connect drivers/usb/core/hub.c:5244 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 port_event drivers/usb/core/hub.c:5709 [inline]
 hub_event+0x1fb5/0x4810 drivers/usb/core/hub.c:5791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 20984:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa5/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 hiddev_connect+0x24a/0x5c0 drivers/hid/usbhid/hiddev.c:893
 hid_connect+0x271/0x17c0 drivers/hid/hid-core.c:2174
 hid_hw_start drivers/hid/hid-core.c:2282 [inline]
 hid_hw_start+0xa6/0x130 drivers/hid/hid-core.c:2273
 plantronics_probe+0x304/0x3e0 drivers/hid/hid-plantronics.c:191
 hid_device_probe+0x29a/0x3c0 drivers/hid/hid-core.c:2603
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e8/0x2a0 drivers/base/bus.c:487
 device_add+0xbd9/0x1e90 drivers/base/core.c:3479
 hid_add_device+0x377/0xa20 drivers/hid/hid-core.c:2755
 usbhid_probe+0xbae/0x1030 drivers/hid/usbhid/hid-core.c:1424
 usb_probe_interface+0x30f/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e8/0x2a0 drivers/base/bus.c:487
 device_add+0xbd9/0x1e90 drivers/base/core.c:3479
 usb_set_configuration+0x101d/0x1900 drivers/usb/core/message.c:2171
 usb_generic_driver_probe+0xbe/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x163/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e8/0x2a0 drivers/base/bus.c:487
 device_add+0xbd9/0x1e90 drivers/base/core.c:3479
 usb_new_device.cold+0x685/0x10ad drivers/usb/core/hub.c:2573
 hub_port_connect drivers/usb/core/hub.c:5405 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 port_event drivers/usb/core/hub.c:5709 [inline]
 hub_event+0x2d5c/0x4810 drivers/usb/core/hub.c:5791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Freed by task 21404:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x3b0 mm/slub.c:3800
 hiddev_release+0x406/0x520 drivers/hid/usbhid/hiddev.c:232
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:488
 insert_work+0x48/0x350 kernel/workqueue.c:1358
 __queue_work+0x693/0x13b0 kernel/workqueue.c:1517
 call_timer_fn+0x1da/0x7c0 kernel/time/timer.c:1700
 expire_timers+0xbb/0x5c0 kernel/time/timer.c:1746
 __run_timers kernel/time/timer.c:2022 [inline]
 __run_timers kernel/time/timer.c:1995 [inline]
 run_timer_softirq+0x326/0x910 kernel/time/timer.c:2035
 __do_softirq+0x1fb/0xadc kernel/softirq.c:571

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:488
 insert_work+0x48/0x350 kernel/workqueue.c:1358
 __queue_work+0x693/0x13b0 kernel/workqueue.c:1517
 call_timer_fn+0x1da/0x7c0 kernel/time/timer.c:1700
 expire_timers+0xbb/0x5c0 kernel/time/timer.c:1746
 __run_timers kernel/time/timer.c:2022 [inline]
 __run_timers kernel/time/timer.c:1995 [inline]
 run_timer_softirq+0x326/0x910 kernel/time/timer.c:2035
 __do_softirq+0x1fb/0xadc kernel/softirq.c:571

The buggy address belongs to the object at ffff88804225cc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 28 bytes inside of
 512-byte region [ffff88804225cc00, ffff88804225ce00)

The buggy address belongs to the physical page:
page:ffffea0001089700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4225c
head:ffffea0001089700 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012441c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5115, tgid 5115 (syz-executor.3), ts 148294241180, free_ts 13478414814
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x119c/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x1a4/0x430 mm/slub.c:3491
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1062
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 __devlink_health_reporter_create+0x91/0x2f0 net/core/devlink.c:7763
 devlink_health_reporter_create+0xa8/0x1e0 net/core/devlink.c:7835
 nsim_dev_health_init+0x99/0x3b0 drivers/net/netdevsim/health.c:243
 nsim_drv_probe+0xc78/0x1320 drivers/net/netdevsim/dev.c:1587
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:936
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x65c/0xc00 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3464
 free_contig_range+0xb5/0x180 mm/page_alloc.c:9485
 destroy_args+0xa8/0x64c mm/debug_vm_pgtable.c:998
 debug_vm_pgtable+0x28de/0x296f mm/debug_vm_pgtable.c:1318
 do_one_initcall+0x141/0x790 init/main.c:1306
 do_initcall_level init/main.c:1379 [inline]
 do_initcalls init/main.c:1395 [inline]
 do_basic_setup init/main.c:1414 [inline]
 kernel_init_freeable+0x6f9/0x782 init/main.c:1634
 kernel_init+0x1e/0x1d0 init/main.c:1522
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff88804225cb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88804225cb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88804225cc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88804225cc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804225cd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
