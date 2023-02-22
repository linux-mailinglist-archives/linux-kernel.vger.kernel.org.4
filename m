Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA669F52E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjBVNQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjBVNQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:16:45 -0500
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279783A087
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:16:44 -0800 (PST)
Received: by mail-il1-f206.google.com with SMTP id z5-20020a92bf05000000b00313f4759a73so3809336ilh.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HaE5mpn53c+jeScAIAC2Di7GoODmZ6YRnOiov3AM+Fg=;
        b=wNRqEUN2eD0B192yH26n5otp73XT5k3TtjoTQvR2t0t2P/VbZ9MmtDwOJAAwfN2mox
         elIz6O2YYGqgO52bmBGBbMd+q9IHLWVdOToukqjLVdGLMv7oHIE3bnM58N/rwkUwkkrF
         tOAwMjkev7ZBu3TdwSQpfj+fjcPwwRWMBzGM+9dUSLMpUrRYYePwFeF7xAWFepBFQze8
         Gmsuawrl54vYvevXY02tPVZNv99EnNdD+alWm/cC2O0Ux8vQoBV9vsBnUDhQwBfhTBOY
         py4ow0cA/EcuHRWq+e+2YGE64wyUuCHKVtEoup1tjjRMaN2j359bDnbZ1XA20ODmroHa
         Om0Q==
X-Gm-Message-State: AO0yUKVc3epI2ZyC9anFPCWqDYiGCVmOK1W1ExqVbN1w9ZHzHNFPp+sx
        DaQRNrzCROEkZYiaBrHoogCTwzVxVgEA+yTFfsb8rcyh9SLZewKygw==
X-Google-Smtp-Source: AK7set/0y362Yns4SCOf6ZzaM6M8Vnp9cakOw/d2id4L1UEcg5NuvUxNHvndU56HK4fKmIGooWXuBHq9pCZSK8BQing9H8Jevjgf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3499:b0:315:9774:deec with SMTP id
 bp25-20020a056e02349900b003159774deecmr2459194ilb.0.1677071803511; Wed, 22
 Feb 2023 05:16:43 -0800 (PST)
Date:   Wed, 22 Feb 2023 05:16:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c7bf005f549b59d@google.com>
Subject: [syzbot] [media?] WARNING in smsusb_term_device
From:   syzbot <syzbot+40ac6e73326e79ee8ecb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c068f40300a0 Add linux-next specific files for 20230217
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16e298ef480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3e2944dd10f2e33
dashboard link: https://syzkaller.appspot.com/bug?extid=40ac6e73326e79ee8ecb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0351f714d440/disk-c068f403.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0272dec605d9/vmlinux-c068f403.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9813c6350fa4/bzImage-c068f403.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+40ac6e73326e79ee8ecb@syzkaller.appspotmail.com

usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-1: Product: syz
usb 3-1: Manufacturer: syz
usb 3-1: SerialNumber: syz
usb 3-1: config 0 descriptor??
smsusb:smsusb_probe: board id=7, interface number 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 897 at kernel/workqueue.c:3167 __flush_work+0x946/0xb60 kernel/workqueue.c:3167
Modules linked in:
CPU: 0 PID: 897 Comm: kworker/0:2 Not tainted 6.2.0-rc8-next-20230217-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:__flush_work+0x946/0xb60 kernel/workqueue.c:3167
Code: 00 48 c7 c6 7b 0d 54 81 48 c7 c7 40 79 79 8c e8 e0 0d 12 00 e9 6f fc ff ff e8 b6 85 30 00 0f 0b e9 63 fc ff ff e8 aa 85 30 00 <0f> 0b 45 31 ed e9 54 fc ff ff e8 eb 14 82 00 e9 3e fb ff ff e8 91
RSP: 0018:ffffc90005336c00 EFLAGS: 00010206
RAX: 0000000000036840 RBX: ffff88803f4480e8 RCX: ffffc90014d11000
RDX: 0000000000040000 RSI: ffffffff81540db6 RDI: 0000000000000001
RBP: ffffc90005336d98 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88803f4480e8
R13: 0000000000000001 R14: 0000000000000001 R15: ffff88803f448100
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9f02070edb CR3: 00000000283f5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3261
 smsusb_stop_streaming drivers/media/usb/siano/smsusb.c:182 [inline]
 smsusb_term_device+0xef/0x300 drivers/media/usb/siano/smsusb.c:344
 smsusb_init_device+0xb6a/0xd10 drivers/media/usb/siano/smsusb.c:419
 smsusb_probe+0x5b3/0x10b0 drivers/media/usb/siano/smsusb.c:567
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:552 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:631
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:768
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:798
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:926
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:998
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11c4/0x1c50 drivers/base/core.c:3589
 usb_set_configuration+0x10ee/0x1af0 drivers/usb/core/message.c:2171
 usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:552 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:631
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:768
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:798
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:926
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:998
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11c4/0x1c50 drivers/base/core.c:3589
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2575
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x9bf/0x1820 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
