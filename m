Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B85B82B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiINIOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiINIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:14:37 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF58462EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:14:32 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id p8-20020a5d9848000000b0068e97cc84b1so8707031ios.23
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=rTdEYGQWknM4bCrr879j6oI5QwDTYjwntwXKpOJK9EE=;
        b=OvNeX5FACZJAZkZVZdYnzJXsyt2RLP3plXMEo4vgCJE6VWtdXvL1YztvXQebookpUG
         Wxe5WfwYgr66ryBik1Us2k6YqiKhyL/Py0Ja1m/tyudZfcM9egU6jf9lctqMqtkOl5gp
         9LVquAX25A7YCqBUZs1pZU/0IQWa0XzeDbeLjGH59bZD2bNkP4d21HXLDEr6KeOYbkRT
         QIBKZtmk2UMOeL4C+JlzJg4/LsvwSo3s9tPrtG3Vdu3u7XDYzSPs59+T/nMqLXgGxo/X
         SHZn5FAA+c6lFYDfFFSWH4zIVasmI6R02RCA/W7P3/if05zxJXaFFfoy8FbXrdo9jfW7
         BhtQ==
X-Gm-Message-State: ACgBeo1wA9jwrwu4LP6/AMsHmxtfXspHpLeBfQcqwfmqhHkHMrXnWN4H
        Bl06WUC2e6Gd6EmBr4LRz1ajcP0juwmMqp5MivV4Mf3GLsOj
X-Google-Smtp-Source: AA6agR6vazj+c4p+xYys19sbCkPRbW2VP922ajnnL9whyKDepvguYuRi9jpBCnkxAJH52eXiynkH0oFOpiDyhrKNOCPyENd0bGX4
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:2f1:2959:8ec8 with SMTP id
 q14-20020a056e0220ee00b002f129598ec8mr14150974ilv.236.1663143271865; Wed, 14
 Sep 2022 01:14:31 -0700 (PDT)
Date:   Wed, 14 Sep 2022 01:14:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee264405e89eb7e8@google.com>
Subject: [syzbot] KASAN: use-after-free Read in hiddev_disconnect (4)
From:   syzbot <syzbot+08bc30b3c98573f139b8@syzkaller.appspotmail.com>
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

HEAD commit:    7eb2bf871454 usb: misc: usb3503: call clk_disable_unprepar..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1536bcaf080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3701a9706c1806e
dashboard link: https://syzkaller.appspot.com/bug?extid=08bc30b3c98573f139b8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+08bc30b3c98573f139b8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
BUG: KASAN: use-after-free in do_raw_spin_lock+0x261/0x2a0 kernel/locking/spinlock_debug.c:114
Read of size 4 at addr ffff888115d24c1c by task kworker/1:2/70

CPU: 1 PID: 70 Comm: kworker/1:2 Not tainted 6.0.0-rc4-syzkaller-00066-g7eb2bf871454 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Workqueue: events __usb_queue_reset_device
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 debug_spin_lock_before kernel/locking/spinlock_debug.c:85 [inline]
 do_raw_spin_lock+0x261/0x2a0 kernel/locking/spinlock_debug.c:114
 __mutex_unlock_slowpath+0x18e/0x5e0 kernel/locking/mutex.c:932
 hiddev_disconnect+0x154/0x1c0 drivers/hid/usbhid/hiddev.c:940
 hid_disconnect+0xb4/0x1a0 drivers/hid/hid-core.c:2252
 hid_hw_stop+0x12/0x70 drivers/hid/hid-core.c:2297
 cmhid_remove+0x38/0x50 drivers/hid/hid-cmedia.c:182
 hid_device_remove+0xbf/0x200 drivers/hid/hid-core.c:2627
 device_remove+0xc8/0x170 drivers/base/dd.c:548
 __device_release_driver drivers/base/dd.c:1249 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1275
 bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3704
 hid_remove_device drivers/hid/hid-core.c:2796 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2815
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1451
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:550 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:542
 __device_release_driver drivers/base/dd.c:1249 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1275
 usb_driver_release_interface drivers/usb/core/driver.c:627 [inline]
 usb_forced_unbind_intf+0x136/0x210 drivers/usb/core/driver.c:1118
 unbind_marked_interfaces.isra.0+0x170/0x1e0 drivers/usb/core/driver.c:1141
 usb_unbind_and_rebind_marked_interfaces+0x34/0x70 drivers/usb/core/driver.c:1202
 usb_reset_device+0x846/0xac0 drivers/usb/core/hub.c:6142
 __usb_queue_reset_device+0x68/0x90 drivers/usb/core/message.c:1904
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x854/0x1080 kernel/workqueue.c:2438
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 4334:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 __kasan_kmalloc+0x81/0xa0 mm/kasan/common.c:525
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 hiddev_connect+0x246/0x5c0 drivers/hid/usbhid/hiddev.c:893
 hid_connect+0x26d/0x17c0 drivers/hid/hid-core.c:2169
 hid_hw_start drivers/hid/hid-core.c:2277 [inline]
 hid_hw_start+0xa2/0x130 drivers/hid/hid-core.c:2268
 cmhid_probe+0x104/0x160 drivers/hid/hid-cmedia.c:165
 hid_device_probe+0x2bd/0x3f0 drivers/hid/hid-core.c:2598
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d0/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 hid_add_device+0x344/0x9d0 drivers/hid/hid-core.c:2748
 usbhid_probe+0xb49/0x1040 drivers/hid/usbhid/hid-core.c:1424
 usb_probe_interface+0x30b/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d0/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd4/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d0/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 usb_new_device.cold+0x685/0x10ad drivers/usb/core/hub.c:2573
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x26c7/0x4610 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 14583:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x14a/0x1b0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook mm/slub.c:1780 [inline]
 slab_free mm/slub.c:3534 [inline]
 kfree+0xca/0x5c0 mm/slub.c:4562
 hiddev_release+0x402/0x520 drivers/hid/usbhid/hiddev.c:232
 __fput+0x277/0x9d0 fs/file_table.c:320
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xad5/0x2930 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 get_signal+0x238c/0x2610 kernel/signal.c:2857
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x156/0x200 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888115d24c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 28 bytes inside of
 512-byte region [ffff888115d24c00, ffff888115d24e00)

The buggy address belongs to the physical page:
page:ffffea0004574900 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x115d24
head:ffffea0004574900 order:2 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head|node=0|zone=2)
raw: 0200000000010200 dead000000000100 dead000000000122 ffff888100041c80
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 11894, tgid 11894 (udevd), ts 853331188558, free_ts 844278582420
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x11cc/0x2a20 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x7b4/0xda0 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 kmem_cache_alloc_trace+0x2fb/0x3b0 mm/slub.c:3282
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 kernfs_fop_open+0x2fa/0xfd0 fs/kernfs/file.c:680
 do_dentry_open+0x49c/0x1240 fs/open.c:878
 do_open fs/namei.c:3557 [inline]
 path_openat+0x1c92/0x28f0 fs/namei.c:3691
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5d2/0xb80 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x420 mm/page_alloc.c:3476
 usbhid_disconnect+0xa7/0xe0 drivers/hid/usbhid/hid-core.c:1452
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:550 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:542
 __device_release_driver drivers/base/dd.c:1249 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1275
 bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3704
 usb_disable_device+0x356/0x7a0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x259/0x6ed drivers/usb/core/hub.c:2235
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x1f86/0x4610 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff888115d24b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888115d24b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888115d24c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff888115d24c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888115d24d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
