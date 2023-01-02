Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5A365AF28
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjABKBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbjABKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:00:56 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FCB10B6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:00:54 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so17959304ilh.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmjMwtXpxAbnC88x8JLvG4A4xNTrO1itYQdLASs/0jw=;
        b=i1bDOjk9xl7bdsiUNXX1JI2zvZFm4QhM4B12hbgDEbjSHTScjLl02u/gt81t+4BNW6
         1PdPEy1uqFX99fSf7DTd5g3Bx8odNM65AvMGFV3AmFqruCmfw3+47Ml1USighMXsXfD0
         8tHOhpqIBk9VcL5SQihPt5ZVpUHUxey6vsPmZfb5hvqiGIw6AvSsDaMlrQya2OL1FT6O
         hZ0GKRLuNNrvL00nz5t7mVzwbe9HTvtnLnzRe58mGzxLDK8TbrLaoMUasN0QPu/1wiho
         dDB982Ai0TR8CJO2Kl83vzJcs64JzkoBZtjY6KFMtcnvOEkdmJnXbAHwIOWWgoBRe4ZH
         flZw==
X-Gm-Message-State: AFqh2koi2ek60taekOsDGEMbVdDktXH5aEiPwLpJImmTraDfVrCc3Jzj
        9rjdqinnoOIKjcJKYlHRbQa+rZloelR9pmaVn56CUOmMgXG0
X-Google-Smtp-Source: AMrXdXuoa3oMoNhdchTv5L7Tdl0dRBYNBdc8Ojlip/aSpwLDI94+jF14KRCd0fkFT9WhUTBJIXE0Mo5DyJtn/9b2oWh1Kr1hdiah
MIME-Version: 1.0
X-Received: by 2002:a92:dd89:0:b0:30c:39a:b4b1 with SMTP id
 g9-20020a92dd89000000b0030c039ab4b1mr1666036iln.75.1672653653559; Mon, 02 Jan
 2023 02:00:53 -0800 (PST)
Date:   Mon, 02 Jan 2023 02:00:53 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da505a05f1450636@google.com>
Subject: [syzbot] KASAN: use-after-free Read in hiddev_release (2)
From:   syzbot <syzbot+9554fc2c9f37f1b9fe77@syzkaller.appspotmail.com>
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

HEAD commit:    f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=124e11c8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0b80bd549c34918
dashboard link: https://syzkaller.appspot.com/bug?extid=9554fc2c9f37f1b9fe77
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/39b24e3d0967/disk-f9ff5644.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91e3c62e1185/vmlinux-f9ff5644.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7737d489c34c/bzImage-f9ff5644.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9554fc2c9f37f1b9fe77@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4925
Read of size 8 at addr ffff888115c8dc30 by task syz-executor.0/26716

CPU: 0 PID: 26716 Comm: syz-executor.0 Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:517
 __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4925
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1df/0x630 kernel/locking/lockdep.c:5633
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 __mutex_unlock_slowpath+0x18e/0x5e0 kernel/locking/mutex.c:932
 hiddev_release+0x3af/0x520 drivers/hid/usbhid/hiddev.c:238
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x1f7/0x200 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb6eca82f8b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007fb6ebe23120 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 00007fb6ecbf1050 RCX: 00007fb6eca82f8b
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fb6ecb2cae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffedbcffaef R14: 00007fb6ebe23300 R15: 0000000000022000
 </TASK>

Allocated by task 16834:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x7a/0x90 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 hiddev_connect+0x246/0x5c0 drivers/hid/usbhid/hiddev.c:893
 hid_connect+0x26d/0x17c0 drivers/hid/hid-core.c:2174
 hid_hw_start drivers/hid/hid-core.c:2282 [inline]
 hid_hw_start+0xa2/0x130 drivers/hid/hid-core.c:2273
 plantronics_probe+0x300/0x3d0 drivers/hid/hid-plantronics.c:191
 hid_device_probe+0x296/0x3c0 drivers/hid/hid-core.c:2603
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d0/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3479
 hid_add_device+0x373/0xa10 drivers/hid/hid-core.c:2755
 usbhid_probe+0xbaa/0x1020 drivers/hid/usbhid/hid-core.c:1424
 usb_probe_interface+0x30b/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d0/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3479
 usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2171
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
 device_add+0xbd5/0x1e90 drivers/base/core.c:3479
 usb_new_device.cold+0x685/0x10ad drivers/usb/core/hub.c:2573
 hub_port_connect drivers/usb/core/hub.c:5405 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 port_event drivers/usb/core/hub.c:5709 [inline]
 hub_event+0x2d58/0x4810 drivers/usb/core/hub.c:5791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x854/0x1080 kernel/workqueue.c:2438
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Freed by task 16833:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2a/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x144/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0x95/0x400 mm/slub.c:3800
 hiddev_disconnect+0x172/0x1c0 drivers/hid/usbhid/hiddev.c:943
 hid_disconnect+0xb4/0x1a0 drivers/hid/hid-core.c:2257
 hid_hw_stop drivers/hid/hid-core.c:2302 [inline]
 hid_device_remove+0x15d/0x200 drivers/hid/hid-core.c:2634
 device_remove+0xc8/0x170 drivers/base/dd.c:548
 __device_release_driver drivers/base/dd.c:1253 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1279
 bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3666
 hid_remove_device drivers/hid/hid-core.c:2803 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2822
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1451
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:550 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:542
 __device_release_driver drivers/base/dd.c:1253 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1279
 bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3666
 usb_disable_device+0x356/0x7a0 drivers/usb/core/message.c:1420
 usb_disconnect.cold+0x259/0x6ed drivers/usb/core/hub.c:2235
 hub_port_connect drivers/usb/core/hub.c:5244 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5549 [inline]
 port_event drivers/usb/core/hub.c:5709 [inline]
 hub_event+0x1fb1/0x4810 drivers/usb/core/hub.c:5791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888115c8dc00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 48 bytes inside of
 512-byte region [ffff888115c8dc00, ffff888115c8de00)

The buggy address belongs to the physical page:
page:ffffea0004572300 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x115c8c
head:ffffea0004572300 order:2 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head|node=0|zone=2)
raw: 0200000000010200 ffff888100041c80 ffffea000448bd00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 19882, tgid 19882 (udevd), ts 1810039154353, free_ts 1800647190180
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x1263/0x2c00 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x5a0 mm/page_alloc.c:5549
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x300/0x3d0 mm/slub.c:3491
 kmalloc_trace+0x22/0x60 mm/slab_common.c:1062
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 kernfs_fop_open+0x31a/0xe70 fs/kernfs/file.c:670
 do_dentry_open+0x6c7/0x12a0 fs/open.c:882
 do_open fs/namei.c:3557 [inline]
 path_openat+0x1bbc/0x2a50 fs/namei.c:3714
 do_filp_open+0x1b6/0x400 fs/namei.c:3741
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x64a/0xbf0 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x19/0x3c0 mm/page_alloc.c:3464
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x18e/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x44/0x60 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 kmem_cache_alloc_node+0x1fa/0x410 mm/slub.c:3497
 __alloc_skb+0x212/0x310 net/core/skbuff.c:552
 alloc_skb include/linux/skbuff.h:1270 [inline]
 netlink_alloc_large_skb net/netlink/af_netlink.c:1202 [inline]
 netlink_sendmsg+0x9a2/0xe10 net/netlink/af_netlink.c:1907
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 ____sys_sendmsg+0x712/0x8c0 net/socket.c:2476
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2530
 __sys_sendmsg+0xf3/0x1c0 net/socket.c:2559
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888115c8db00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888115c8db80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888115c8dc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888115c8dc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888115c8dd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
