Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F4A5F799E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJGOUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJGOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:20:42 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61EAB979E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:20:39 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id 5-20020a5d9c05000000b006a44709a638so3333594ioe.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 07:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rn00CJS7mE+YZ5wyQ2Dplu+9tG4WBX9Dh0zTaYBAe8Q=;
        b=plylLO4NCIi6YKv7yBXXjLGeEolxMPDB4O1bu3Nynawj9ywS0ZTA/76gMM/cHdp7s0
         vvKUavkGCPezrYQoD7eX/cfz0kEqNg9oUTUjNpVz//Mf2/9Kfaz3K1QNlOdqc1llII93
         GvqOlq7yuu28XcuzvZIwm4eIOcxW/bVt0SAU6KnPptiv0ijnuNgSpXevejKYD4FHtYnA
         CXC+HSnnifi0oinrsMWWxnEZPOCAPfcvcWyeszXoDAKotiZ26466w4kZ29+Wl5KtKOt9
         1Kmi37ER8F7/8b7ubccFQSx4L6ooQvnap2bWnHdDMquBPMya2PwWVNj2qk6Gu0u1Lt1f
         fjgw==
X-Gm-Message-State: ACrzQf2R/w86R1ZZ5L2OpFGC843KU+cnPPy3G/Z1T0QrnnIPfW+0qYdo
        u74/66o1IW1xPZrucf9xovYn73cVvWZ/z8WMa1iY8VqjSPzo
X-Google-Smtp-Source: AMsMyM5MkJE1uAZFD5OaaIaujO18BwlaJ0OC20U1YkpGNwbdolpYzQpHYP3S2aNHfm8XC2eWtk5u4uKQJJYzwYiB+olPluIoDwQf
MIME-Version: 1.0
X-Received: by 2002:a05:6638:58f:b0:363:4772:d13d with SMTP id
 a15-20020a056638058f00b003634772d13dmr2450082jar.25.1665152439119; Fri, 07
 Oct 2022 07:20:39 -0700 (PDT)
Date:   Fri, 07 Oct 2022 07:20:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a178f505ea72837a@google.com>
Subject: [syzbot] KASAN: use-after-free Read in dvb_devnode
From:   syzbot <syzbot+4b677cfa21f5bd6295cd@syzkaller.appspotmail.com>
To:     cai.huoqing@linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    00988f70a076 Merge tag 'usb-serial-6.0-rc8' of https://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=145efc82880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64cd66daa10a81a
dashboard link: https://syzkaller.appspot.com/bug?extid=4b677cfa21f5bd6295cd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b677cfa21f5bd6295cd@syzkaller.appspotmail.com

BUG: KASAN: use-after-free in dvb_devnode+0x122/0x1b0 drivers/media/dvb-core/dvbdev.c:1025
Read of size 4 at addr ffff888113a1d860 by task udevd/1179

CPU: 0 PID: 1179 Comm: udevd Not tainted 6.0.0-rc7-syzkaller-00946-g00988f70a076 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 dvb_devnode+0x122/0x1b0 drivers/media/dvb-core/dvbdev.c:1025
 device_get_devnode+0x154/0x2b0 drivers/base/core.c:3796
 dev_uevent+0x40d/0x770 drivers/base/core.c:2404
 uevent_show+0x1b8/0x380 drivers/base/core.c:2492
 dev_attr_show+0x4b/0x90 drivers/base/core.c:2195
 sysfs_kf_seq_show+0x219/0x3d0 fs/sysfs/file.c:59
 kernfs_seq_show+0x169/0x1e0 fs/kernfs/file.c:217
 seq_read_iter+0x4f5/0x1280 fs/seq_file.c:230
 kernfs_fop_read_iter+0x523/0x710 fs/kernfs/file.c:299
 call_read_iter include/linux/fs.h:2181 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x67d/0x930 fs/read_write.c:470
 ksys_read+0x127/0x250 fs/read_write.c:607
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f28d98228fe
Code: c0 e9 e6 fe ff ff 50 48 8d 3d 0e c7 09 00 e8 c9 cf 01 00 66 0f 1f 84 00 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 0f 05 <48> 3d 00 f0 ff ff 77 5a c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 28
RSP: 002b:00007ffcef6cb338 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000559cdeb69680 RCX: 00007f28d98228fe
RDX: 0000000000001000 RSI: 0000559cdeb746f0 RDI: 000000000000000c
RBP: 00007f28d98ef380 R08: 000000000000000c R09: 00007f28d98f2a60
R10: 0000000000000008 R11: 0000000000000246 R12: 0000559cdeb69680
R13: 0000000000000d68 R14: 00007f28d98ee780 R15: 0000000000000d68
 </TASK>

The buggy address belongs to the physical page:
page:ffffea00044e8740 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x113a1d
flags: 0x200000000000000(node=0|zone=2)
raw: 0200000000000000 0000000000000000 ffffffff00000201 0000000000000000
raw: 0000000000000000 0000000000110000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x140dc0(GFP_USER|__GFP_COMP|__GFP_ZERO), pid 28063, tgid 28063 (kworker/0:5), ts 3378237051573, free_ts 3378714082458
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x11cc/0x2a20 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 kmalloc_order+0x34/0xf0 mm/slab_common.c:933
 kmalloc_order_trace+0x13/0x120 mm/slab_common.c:949
 kmalloc_large include/linux/slab.h:529 [inline]
 kmalloc include/linux/slab.h:593 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 dvb_usb_device_init+0x113/0x640 drivers/media/usb/dvb-usb/dvb-usb-init.c:279
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
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5d2/0xb80 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x420 mm/page_alloc.c:3476
 dvb_usb_device_init+0x50e/0x640 drivers/media/usb/dvb-usb/dvb-usb-init.c:322
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

Memory state around the buggy address:
 ffff888113a1d700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888113a1d780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888113a1d800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                                       ^
 ffff888113a1d880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888113a1d900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
