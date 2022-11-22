Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F40633DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiKVNdx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Nov 2022 08:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiKVNdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:33:50 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81DC43AEE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:33:48 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id h20-20020a056e021d9400b00300581edaa5so10543505ila.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 05:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEkdw95poUu9WONI9lulIgAsc8njmDn8sHquxnpPcYg=;
        b=VLPNpjkHMSGPw9/FSyIvmfFpkoCfqmcjJwGN9Z6ncYpTTKUQH0+Cf4HnDBLAaCEykf
         CxSkqdMnUn0IYssuIbkCEokLQG5cIM+uEhohWAt986tqNFz1levvtKSO79dsFvvdjyhr
         ZPSuhtMhgl9C4EtP+r0TJ6GEpFOwP8SGy0D10jKHgYZFnSAKV9UzQtf7RqeE/ELIF8xH
         VQQKOmUJTV6KFTdz1s2rxNz9Q/HcbfNHYJUhTsDKKNo6PLbxzhbbWA78k9et1ETQQgQC
         kZTo78jSorqIe+XmG0F1mpmRbzF2U+xpiRmaKTGeyC6R0V3OiXkyD+gYlF3fUhJXGlaZ
         /UYw==
X-Gm-Message-State: ANoB5pnp1YczbxqLq6/rufXzdcgqm82z0j+WNudGRGcX78TiqQRTWIBE
        dDCluwhR9gVsBskGs2G0MK1jrUcpFBvZBxlRFvHk/JtyJ1hj
X-Google-Smtp-Source: AA0mqf69LEdjvIwiPXoi5aHA59FgIe+zHEZ0sWRLwb9keyNDzX9jaq7Yo0fjGSvu8KntRcR1wWRh3z7v38N/9MWhDPCbAKOSkbZz
MIME-Version: 1.0
X-Received: by 2002:a6b:e814:0:b0:6dc:dd8f:aebf with SMTP id
 f20-20020a6be814000000b006dcdd8faebfmr1983877ioh.191.1669124028115; Tue, 22
 Nov 2022 05:33:48 -0800 (PST)
Date:   Tue, 22 Nov 2022 05:33:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8360d05ee0f387a@google.com>
Subject: [syzbot] KASAN: use-after-free Read in kernfs_get (2)
From:   syzbot <syzbot+ddb9f6e9c752380dbed0@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

HEAD commit:    81ac25651a62 Merge tag 'nfsd-6.1-5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13bed579880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f4e5e9899396248
dashboard link: https://syzkaller.appspot.com/bug?extid=ddb9f6e9c752380dbed0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e898abd2474d/disk-81ac2565.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f1580efc3df/vmlinux-81ac2565.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf9b0ccc5120/bzImage-81ac2565.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ddb9f6e9c752380dbed0@syzkaller.appspotmail.com

usb 6-1: new high-speed USB device number 2 using dummy_hcd
usb 6-1: Using ep0 maxpacket: 8
usb 6-1: config 1 interface 0 altsetting 0 has 2 endpoint descriptors, different from the interface descriptor's value: 0
usb 6-1: New USB device found, idVendor=0525, idProduct=a4a1, bcdDevice= 0.40
usb 6-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 6-1: Product: syz
usb 6-1: Manufacturer: 觰ؚ汾곞ฟᆊ➰쒷럣㵍챛ᐃ㫀앰લ阐쾆럅눉鿋녻쩈䭅쑩湠⧺疉櫜㴍椛岪⚡뇈땡풄ꋉ坵Ἕ刴硽䲝뎓덉৺✶룺魯苋Ѡ枦㢆지쾔튝广첑皟䦖䳛疓뗶ཱ樞얝퉢궃ꏫ讉蕃࣒耜米寖㕀䑞ᬕ椙쉪቗攉免⾻ⶅ笨䍬ㅼ僴렽奭
usb 6-1: SerialNumber: syz
cdc_ether: probe of 6-1:1.0 failed with error -22
usb 6-1: USB disconnect, device number 2
usb 5-1: Direct firmware load for ueagle-atm/eagleII.fw failed with error -2
usb 5-1: Falling back to sysfs fallback for: ueagle-atm/eagleII.fw
==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
BUG: KASAN: use-after-free in kernfs_get.part.0+0x17/0x80 fs/kernfs/dir.c:514
Read of size 4 at addr ffff88807b6533a0 by task kworker/0:5/20931

CPU: 0 PID: 20931 Comm: kworker/0:5 Not tainted 6.1.0-rc5-syzkaller-00103-g81ac25651a62 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:495
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:27 [inline]
 kernfs_get.part.0+0x17/0x80 fs/kernfs/dir.c:514
 kernfs_get+0x1f/0x30 fs/kernfs/dir.c:513
 sysfs_get include/linux/sysfs.h:651 [inline]
 create_dir lib/kobject.c:79 [inline]
 kobject_add_internal+0x35a/0x8f0 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x154/0x1c0 lib/kobject.c:410
 device_add+0x36c/0x1e90 drivers/base/core.c:3452
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:82 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:158 [inline]
 firmware_fallback_sysfs+0x2d9/0xba0 drivers/base/firmware_loader/fallback.c:234
 _request_firmware+0xbca/0x1190 drivers/base/firmware_loader/main.c:856
 request_firmware_work_func+0xe1/0x240 drivers/base/firmware_loader/main.c:1105
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 20931:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x82/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x2b4/0x3d0 mm/slub.c:3422
 kmem_cache_zalloc include/linux/slab.h:679 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:603
 kernfs_new_node fs/kernfs/dir.c:665 [inline]
 kernfs_create_dir_ns+0xa0/0x230 fs/kernfs/dir.c:1011
 sysfs_create_dir_ns+0x12b/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2c9/0x8f0 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x154/0x1c0 lib/kobject.c:410
 device_add+0x36c/0x1e90 drivers/base/core.c:3452
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:82 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:158 [inline]
 firmware_fallback_sysfs+0x2d9/0xba0 drivers/base/firmware_loader/fallback.c:234
 _request_firmware+0xbca/0x1190 drivers/base/firmware_loader/main.c:856
 request_firmware_work_func+0xe1/0x240 drivers/base/firmware_loader/main.c:1105
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 3699:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free+0xee/0x5c0 mm/slub.c:3683
 kernfs_put.part.0+0x2c4/0x540 fs/kernfs/dir.c:557
 kernfs_put+0x46/0x50 fs/kernfs/dir.c:531
 __kernfs_remove+0x463/0x600 fs/kernfs/dir.c:1443
 kernfs_remove+0x7b/0xa0 fs/kernfs/dir.c:1463
 sysfs_remove_dir+0xc5/0x100 fs/sysfs/dir.c:101
 __kobject_del+0xe2/0x1f0 lib/kobject.c:588
 kobject_del lib/kobject.c:611 [inline]
 kobject_del+0x40/0x60 lib/kobject.c:603
 device_del+0x820/0xc80 drivers/base/core.c:3715
 usb_disconnect.cold+0x49b/0x6ed drivers/usb/core/hub.c:2261
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x1f8a/0x45d0 drivers/usb/core/hub.c:5735
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x858/0x1090 kernel/workqueue.c:2438
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88807b6533a0
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 0 bytes inside of
 168-byte region [ffff88807b6533a0, ffff88807b653448)

The buggy address belongs to the physical page:
page:ffffea0001ed94c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b653
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0001755c80 dead000000000002 ffff8880121e1c80
raw: 0000000000000000 0000000080110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 153, tgid 153 (kworker/1:2), ts 551906333142, free_ts 551868223171
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4288
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5555
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3279
 slab_alloc_node mm/slub.c:3364 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x31a/0x3d0 mm/slub.c:3422
 kmem_cache_zalloc include/linux/slab.h:679 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:603
 kernfs_new_node+0x97/0x120 fs/kernfs/dir.c:665
 __kernfs_create_file+0x55/0x350 fs/kernfs/file.c:1043
 sysfs_add_file_mode_ns+0x213/0x3f0 fs/sysfs/file.c:294
 sysfs_merge_group+0x19a/0x310 fs/sysfs/group.c:342
 dpm_sysfs_add+0x245/0x290 drivers/base/power/sysfs.c:707
 device_add+0xa86/0x1e90 drivers/base/core.c:3474
 usb_create_ep_devs+0x160/0x2a0 drivers/usb/core/endpoint.c:169
 usb_new_device.cold+0xc9b/0x10ad drivers/usb/core/hub.c:2601
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x4d0 mm/page_alloc.c:3483
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x184/0x210 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x66/0x90 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 __kmem_cache_alloc_node+0x2e2/0x3e0 mm/slub.c:3437
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1045
 kmalloc include/linux/slab.h:553 [inline]
 usb_control_msg+0xbd/0x4a0 drivers/usb/core/message.c:143
 get_port_status drivers/usb/core/hub.c:581 [inline]
 hub_ext_port_status+0x112/0x450 drivers/usb/core/hub.c:598
 usb_hub_port_status drivers/usb/core/hub.c:620 [inline]
 port_event drivers/usb/core/hub.c:5550 [inline]
 hub_event+0xc8e/0x45d0 drivers/usb/core/hub.c:5735
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x858/0x1090 kernel/workqueue.c:2438
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff88807b653280: fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00 00
 ffff88807b653300: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
>ffff88807b653380: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88807b653400: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
 ffff88807b653480: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
