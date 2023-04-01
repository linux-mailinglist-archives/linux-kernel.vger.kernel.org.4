Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F616D33D9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDAUjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDAUjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:39:44 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861751A466
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 13:39:43 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id b2-20020a6bcb02000000b0075e09ef5a2eso1680839iog.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 13:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680381583; x=1682973583;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LXPJLx+2D/LfrQu3vD9++008KkjarWI9/HFZYVPkTlU=;
        b=z/pn+ymYZAkl9fqZDAZ1gha3rY5lQ6ZxA/AZso5PFlSHXzLIe5je9h8R7PE5ep6dgC
         hjlj8XRdkf8X+fB0bLVO4WUXCbjk4uTm5dPwRJ2LFx+joO3DEQ/IjiaC3/gbWeVzqgKc
         r6QHLiNiQFGhRG9G+qmtzGXZJ8+UqM5SOtIdsPMeTPHv3oXHtczcTdxR78c/SRSTG959
         sShljOecgkwvp9UN78BmAvMbfOwLIlDKOBKNz7eBZuo5+ge+a+8rURFQrFJokc9Zamol
         uZuJOXEh1QNLXgvTzbLgvvmYtVeer9+lC12vrnzvlCVoaR8Iti4DzKZ0MPKTpV6p54Ti
         OstA==
X-Gm-Message-State: AO0yUKUZ/tmSPFsJyWRhgHuE6dCGx1qlr009Mn5kUQ9+rrx4kosVLDLJ
        U7MjcRlNIpZNdCQfhGVLkSYiP/4Il64Mcbc0Ok0feMvf3MN+
X-Google-Smtp-Source: AK7set/+xl8ktPYd+dw32YKR7kXu4S2nI1EohIJS3kywZ1ct+Qus2xdhmQgaOU/EWZUvP0bTPerf+TPeTLoBZu8KHbhh01MM8lBe
MIME-Version: 1.0
X-Received: by 2002:a5d:9e12:0:b0:745:70d7:4962 with SMTP id
 h18-20020a5d9e12000000b0074570d74962mr12322113ioh.0.1680381582885; Sat, 01
 Apr 2023 13:39:42 -0700 (PDT)
Date:   Sat, 01 Apr 2023 13:39:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055cd8405f84c5386@google.com>
Subject: [syzbot] [kernel?] WARNING in class_register
From:   syzbot <syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a6d9e3034536 Add linux-next specific files for 20230330
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1496edcdc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aceb117f7924508e
dashboard link: https://syzkaller.appspot.com/bug?extid=ca3d9f693dfa69f61371
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f57859c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167cc501c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ec1f900ea929/disk-a6d9e303.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fabbf89c0d22/vmlinux-a6d9e303.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ed05d6192fa/bzImage-a6d9e303.xz

The issue was bisected to:

commit dcfbb67e48a2becfce7990386e985b9c45098ee5
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri Mar 24 10:01:31 2023 +0000

    driver core: class: use lock_class_key already present in struct subsys_private

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10190b49c80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12190b49c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14190b49c80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com
Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")

plantronics 0003:047F:7FFF.0035: No inputs registered, leaving
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7 at kernel/locking/lockdep.c:1232 lockdep_register_key+0x2a4/0x410 kernel/locking/lockdep.c:1232
Modules linked in:
CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.3.0-rc4-next-20230330-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:lockdep_register_key+0x2a4/0x410 kernel/locking/lockdep.c:1232
Code: 5c 41 5d 41 5e 41 5f c3 48 89 d8 48 c1 e8 03 80 3c 10 00 0f 85 fb 00 00 00 48 8b 1b 48 85 db 0f 84 fb fe ff ff 48 39 dd 75 de <0f> 0b eb 87 9c 58 f6 c4 02 0f 84 0f fe ff ff e8 78 c3 aa 02 85 c0
RSP: 0018:ffffc900000c6908 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff888028470b60 RCX: 1ffffffff1cf16e6
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffffc900000c6930
RBP: ffff888028470b60 R08: 0000000000000001 R09: 0000000000000003
R10: fffff52000018d26 R11: 0000000000094001 R12: 0000000000000cf8
R13: 1ffff92000018d22 R14: ffffffff9167f900 R15: 0000000000000a03
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001040 CR3: 0000000027dfb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 class_register+0xed/0x530 drivers/base/class.c:172
 class_create+0x99/0x100 drivers/base/class.c:249
 init_usb_class drivers/usb/core/file.c:91 [inline]
 usb_register_dev+0x4e7/0x860 drivers/usb/core/file.c:179
 hiddev_connect+0x3bd/0x610 drivers/hid/usbhid/hiddev.c:903
 hid_connect+0x271/0x18c0 drivers/hid/hid-core.c:2192
 hid_hw_start drivers/hid/hid-core.c:2302 [inline]
 hid_hw_start+0xa6/0x130 drivers/hid/hid-core.c:2293
 plantronics_probe+0x304/0x400 drivers/hid/hid-plantronics.c:191
 hid_device_probe+0x2aa/0x3d0 drivers/hid/hid-core.c:2633
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11c4/0x1c50 drivers/base/core.c:3616
 hid_add_device+0x377/0xa60 drivers/hid/hid-core.c:2785
 usbhid_probe+0xc43/0x1100 drivers/hid/usbhid/hid-core.c:1429
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11c4/0x1c50 drivers/base/core.c:3616
 usb_set_configuration+0x10ee/0x1af0 drivers/usb/core/message.c:2171
 usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11c4/0x1c50 drivers/base/core.c:3616
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2575
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
