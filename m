Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9DE62703A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 16:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiKMPlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 10:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 10:40:58 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E5DF9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:40:57 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id r197-20020a6b8fce000000b006c3fc33424dso5042987iod.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtE8tqhwFvcSyTr6lQl79neZ9UIv6AbT1kREmGkhh4Y=;
        b=Gs2ze5p+EwV9Gx/+nkD9YLIYuXnriu6Xd3Zkgl4Qc1BcGeu4kuTgMuW9o7hKBPL/NO
         BbMld2cddm7CxpVU2y3uQvxtWHmc458RW5zGuVA77yJ4ICo3Hp4NSmTNFIzrxVLmwjFF
         7jni2590d1acL0gkKoY106WP2XRkwUaEtqLqoBgG8hG++maC7xj7hEiGWQpDkIHegO3R
         lbMveBZ9BtcDP8xS1gvQvIdhAf8GIOdiYMYXC5RIwNWluK8JTZn/8FZpR4pR/8Aacx2J
         dZ8uPGIE7OxkpPEe22929Kp1GFCPCg8gXgr+li9bJY/OGxEUOvKtgsQSFm/b0e8ZaiNu
         6JDQ==
X-Gm-Message-State: ANoB5pmT+R+RoSKcys9MxNDcO20xcnRKXqyVE1dYcom72jGhsvrdsHli
        ZRv3MhkleBczR6a24Uk9zZCy6+mdkIhjF8SuF5W048qZYbkv
X-Google-Smtp-Source: AA0mqf7NetubDdSKokpK9tMnvUWeU0AZg7XHp/4pYGk7A5MvqNsc6bxGG7DWWJ3R5m6nphZbXznq2VdXphFvkhgqB8Npsuxx+TuA
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2725:b0:363:c65d:dd06 with SMTP id
 m37-20020a056638272500b00363c65ddd06mr4388705jav.22.1668354056446; Sun, 13
 Nov 2022 07:40:56 -0800 (PST)
Date:   Sun, 13 Nov 2022 07:40:56 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4e4fe05ed5bf2b0@google.com>
Subject: [syzbot] KASAN: use-after-free Read in kernfs_activate (2)
From:   syzbot <syzbot+782984d6f1701b526edb@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

HEAD commit:    59f2f4b8a757 fs/userfaultfd: Fix maple tree iterator in us..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e836fa880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=480ba0fb2fd243ac
dashboard link: https://syzkaller.appspot.com/bug?extid=782984d6f1701b526edb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/619de907b82c/disk-59f2f4b8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bcd0dc7d69ef/vmlinux-59f2f4b8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a8dbe0bc7228/bzImage-59f2f4b8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+782984d6f1701b526edb@syzkaller.appspotmail.com

usb 4-1: Direct firmware load for ueagle-atm/eagleII.fw failed with error -2
usb 4-1: Falling back to sysfs fallback for: ueagle-atm/eagleII.fw
==================================================================
BUG: KASAN: use-after-free in kernfs_root fs/kernfs/kernfs-internal.h:66 [inline]
BUG: KASAN: use-after-free in kernfs_next_descendant_post fs/kernfs/dir.c:1289 [inline]
BUG: KASAN: use-after-free in kernfs_activate+0xd0/0x3a0 fs/kernfs/dir.c:1344
Read of size 8 at addr ffff888079194b10 by task kworker/1:12/5383

CPU: 1 PID: 5383 Comm: kworker/1:12 Not tainted 6.1.0-rc4-syzkaller-00011-g59f2f4b8a757 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x220 mm/kasan/report.c:395
 kasan_report+0x139/0x170 mm/kasan/report.c:495
 kernfs_root fs/kernfs/kernfs-internal.h:66 [inline]
 kernfs_next_descendant_post fs/kernfs/dir.c:1289 [inline]
 kernfs_activate+0xd0/0x3a0 fs/kernfs/dir.c:1344
 kernfs_add_one+0x465/0x560 fs/kernfs/dir.c:776
 kernfs_create_dir_ns+0x1bf/0x220 fs/kernfs/dir.c:1021
 sysfs_create_dir_ns+0x181/0x390 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x6dd/0xd10 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x14c/0x210 lib/kobject.c:410
 device_add+0x47d/0xf90 drivers/base/core.c:3452
 fw_load_sysfs_fallback+0xd4/0x5e0 drivers/base/firmware_loader/fallback.c:82
 fw_load_from_user_helper+0x12d/0x1f0 drivers/base/firmware_loader/fallback.c:158
 _request_firmware+0x446/0x6a0 drivers/base/firmware_loader/main.c:856
 request_firmware_work_func+0x125/0x270 drivers/base/firmware_loader/main.c:1105
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 5383:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
 __kasan_slab_alloc+0x65/0x70 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x1cc/0x300 mm/slub.c:3422
 kmem_cache_zalloc include/linux/slab.h:702 [inline]
 __kernfs_new_node+0xdb/0x730 fs/kernfs/dir.c:603
 kernfs_new_node fs/kernfs/dir.c:665 [inline]
 kernfs_create_dir_ns+0x90/0x220 fs/kernfs/dir.c:1011
 sysfs_create_dir_ns+0x181/0x390 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x6dd/0xd10 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x14c/0x210 lib/kobject.c:410
 device_add+0x47d/0xf90 drivers/base/core.c:3452
 fw_load_sysfs_fallback+0xd4/0x5e0 drivers/base/firmware_loader/fallback.c:82
 fw_load_from_user_helper+0x12d/0x1f0 drivers/base/firmware_loader/fallback.c:158
 _request_firmware+0x446/0x6a0 drivers/base/firmware_loader/main.c:856
 request_firmware_work_func+0x125/0x270 drivers/base/firmware_loader/main.c:1105
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 3754:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free+0x94/0x1d0 mm/slub.c:3683
 kernfs_put+0x340/0x490 fs/kernfs/dir.c:557
 __kernfs_remove+0x980/0xa90 fs/kernfs/dir.c:1443
 kernfs_remove+0x76/0x90 fs/kernfs/dir.c:1463
 __kobject_del+0xdc/0x300 lib/kobject.c:588
 kobject_del+0x41/0x60 lib/kobject.c:611
 device_del+0xa10/0xbe0 drivers/base/core.c:3715
 usb_disconnect+0x56e/0x890 drivers/usb/core/hub.c:2261
 hub_port_connect+0x296/0x2910 drivers/usb/core/hub.c:5197
 hub_port_connect_change+0x619/0xbe0 drivers/usb/core/hub.c:5497
 port_event+0xec6/0x13b0 drivers/usb/core/hub.c:5653
 hub_event+0x5c1/0xd80 drivers/usb/core/hub.c:5735
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0xe16/0x1330 kernel/workqueue.c:2438
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff888079194ae0
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 48 bytes inside of
 168-byte region [ffff888079194ae0, ffff888079194b88)

The buggy address belongs to the physical page:
page:ffffea0001e46500 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79194
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00009ddc80 dead000000000004 ffff8880121d5dc0
raw: 0000000000000000 0000000080110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 3659, tgid 3659 (syz-executor.4), ts 217350520729, free_ts 217156331022
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4288
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5555
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x7f4/0xeb0 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x24c/0x300 mm/slub.c:3422
 kmem_cache_zalloc include/linux/slab.h:702 [inline]
 __kernfs_new_node+0xdb/0x730 fs/kernfs/dir.c:603
 kernfs_new_node fs/kernfs/dir.c:665 [inline]
 kernfs_create_dir_ns+0x90/0x220 fs/kernfs/dir.c:1011
 sysfs_create_dir_ns+0x181/0x390 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x6dd/0xd10 lib/kobject.c:223
 kset_register lib/kobject.c:846 [inline]
 kset_create_and_add+0x201/0x280 lib/kobject.c:983
 register_queue_kobjects net/core/net-sysfs.c:1766 [inline]
 netdev_register_kobject+0x1a2/0x310 net/core/net-sysfs.c:2019
 register_netdevice+0x136c/0x1a20 net/core/dev.c:10057
 veth_newlink+0x638/0xd10 drivers/net/veth.c:1764
 rtnl_newlink_create net/core/rtnetlink.c:3364 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3581 [inline]
 rtnl_newlink+0x14ed/0x2060 net/core/rtnetlink.c:3594
 rtnetlink_rcv_msg+0x7b8/0xe90 net/core/rtnetlink.c:6091
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x630 mm/page_alloc.c:3483
 free_slab mm/slub.c:2031 [inline]
 discard_slab mm/slub.c:2037 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2586
 put_cpu_partial+0x116/0x180 mm/slub.c:2662
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 __kmem_cache_alloc_node+0x1d7/0x310 mm/slub.c:3437
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1046
 kmalloc include/linux/slab.h:576 [inline]
 kzalloc include/linux/slab.h:712 [inline]
 kobject_uevent_env+0x33a/0x8e0 lib/kobject_uevent.c:524
 __kobject_del+0xcd/0x300 lib/kobject.c:585
 kobject_cleanup+0x25d/0x470 lib/kobject.c:664
 netdev_queue_update_kobjects+0x417/0x4c0 net/core/net-sysfs.c:1733
 netif_set_real_num_tx_queues+0x16d/0x880 net/core/dev.c:2893
 veth_init_queues+0x81/0x170 drivers/net/veth.c:1687
 veth_newlink+0xa59/0xd10 drivers/net/veth.c:1813

Memory state around the buggy address:
 ffff888079194a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079194a80: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
>ffff888079194b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888079194b80: fb fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00
 ffff888079194c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
