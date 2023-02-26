Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECFB6A337C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 19:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBZSlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 13:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBZSln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:41:43 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB730C157
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:41:42 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id r13-20020a92c5ad000000b00316ecbf63c9so2658350ilt.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 10:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhtlMZXe7W60A6gs6G8QyEgSl0moyKXQiS/6V/CbvHQ=;
        b=Aq2eBnalouGSIL7ItLneNIwJ1IlSnEs74zSOyzcb+xouK0rLeOw4PcgMmNhY5m4JHt
         IMmcKcDK+fJJ/N/zwZvg/Y/ATPuksgrc7/zO86vHm7hFZ47fyMCsX42S8KXV96DKJjAY
         A+V54kA3Zy2rjTDv5ACVv++b37ZQwVTe8lcdPo0kJFxKJ75FY5PeI3MvDFpsLNI83NVQ
         F55nIo8GaiOBLegBN+BOkFUy/qp628wmlqhGEHlQKnuGAnNm+m7xzmyh0QgpkGKj4vc9
         Ay+Ovjqi+9E7S5aU+sdiM0s3AcxQox1Kmgu4h2qwShWISED6X9ma++6JIOhHgcpKgclY
         lQWg==
X-Gm-Message-State: AO0yUKW/MjfYyXyETVT0h+VT9lNaGKvemdiM+f8L3Zx8zc0RUOSHGCFp
        MMb0QYD3Vul5zB+4XLVkQgxkC3QUGezv/C3iXjT2R0BD9ZDkQbo=
X-Google-Smtp-Source: AK7set9IRZ3sUn87huS0eESE0UM8hzoe+fB0Qhn3fuCWddJCYhj9I9mkLiqxVbtZQQxdTxl1yh1BEChnU3UDTEX6Sdtm7tHRaqZd
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e92:b0:3eb:3166:9d77 with SMTP id
 ch18-20020a0566383e9200b003eb31669d77mr3443234jab.0.1677436902043; Sun, 26
 Feb 2023 10:41:42 -0800 (PST)
Date:   Sun, 26 Feb 2023 10:41:42 -0800
In-Reply-To: <0000000000001c7bf005f549b59d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adf65105f59eb69c@google.com>
Subject: Re: [syzbot] [media?] WARNING in smsusb_term_device
From:   syzbot <syzbot+40ac6e73326e79ee8ecb@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    8232539f864c Add linux-next specific files for 20230225
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10326960c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fe68735401a6111
dashboard link: https://syzkaller.appspot.com/bug?extid=40ac6e73326e79ee8ecb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ba7cb0c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16734964c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4259815e0cee/disk-8232539f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5ea6ea28200d/vmlinux-8232539f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e461f15ffd6b/bzImage-8232539f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+40ac6e73326e79ee8ecb@syzkaller.appspotmail.com

smsusb:smsusb_probe: board id=8, interface number 0
------------[ cut here ]------------
WARNING: CPU: 1 PID: 26 at kernel/workqueue.c:3167 __flush_work+0x946/0xb60 kernel/workqueue.c:3167
Modules linked in:
CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.2.0-next-20230225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:__flush_work+0x946/0xb60 kernel/workqueue.c:3167
Code: 00 48 c7 c6 9b 0e 54 81 48 c7 c7 00 77 79 8c e8 00 0c 12 00 e9 6f fc ff ff e8 e6 96 30 00 0f 0b e9 63 fc ff ff e8 da 96 30 00 <0f> 0b 45 31 ed e9 54 fc ff ff e8 bb 22 82 00 e9 3e fb ff ff e8 c1
RSP: 0018:ffffc90000a1ec00 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807afc00e8 RCX: 0000000000000000
RDX: ffff8880174d1d40 RSI: ffffffff81540ed6 RDI: 0000000000000001
RBP: ffffc90000a1ed98 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88807afc00e8
R13: 0000000000000001 R14: 0000000000000001 R15: ffff88807afc0100
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056455268be78 CR3: 000000002a62c000 CR4: 00000000003506e0
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

