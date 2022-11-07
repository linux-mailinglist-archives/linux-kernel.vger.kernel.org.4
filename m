Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5598E61EF59
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiKGJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKGJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:43:43 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434DB55AC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:43:42 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id 15-20020a056e0220cf00b0030099e75602so8391062ilq.21
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:43:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LeTjeIApLS5/nObgZE1J+Sv2xng4QNqwVUT1nwGcsBU=;
        b=LQkosjo3JL4TTXpdR4NO3bp3sr90T/rosYIa84ib6l8uRCwHakBO8HfR7VR2NSS0Iw
         HOfOYa+YoPxS1J4gLgnLValHyP/cmovvnuJCvfPgGlzqfWfRGowdsY5GqCf56sfUi/mP
         W8t9Bod+UFRFHI+1eLJJniZ1U+dcRnplClxlZGdfHoSbkrAhQ97Avj8ez2TKM1jtqOww
         8kEmmdFpfw5HntO5hMtOZUfky2Nw19opD/TqvuWF8AjIAzvdwPvZa0vqOXaKqexwGG8h
         nOP/5R+mPoHRXrGcoiS6fdCnQ5ulCSFt2WS79p3oAT7BE9P6WfPZhDoufUhvpIgWPSkB
         GDyg==
X-Gm-Message-State: ANoB5pl4co/8vvJl9AiAmqeS3BSjwq4tvplx8E/uMLpfFNMi9RNgaP1n
        xfYROE220oSsio9ZNjQuIhcNIrma8WgxH8Qd4pMQYEGcuJeO
X-Google-Smtp-Source: AA0mqf4xJC86btC9Mxa5as5flMcCHNpvCr+f9RIZqTpEPs6+yF6EQdHBnhR/Ajl6w9NNmfYv0ftkhQ8NAPFaAJJtISg7vx0knkyh
MIME-Version: 1.0
X-Received: by 2002:a05:6602:104:b0:6da:eb2f:d6d9 with SMTP id
 s4-20020a056602010400b006daeb2fd6d9mr3052159iot.47.1667814221600; Mon, 07 Nov
 2022 01:43:41 -0800 (PST)
Date:   Mon, 07 Nov 2022 01:43:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003adfa805ecde42f8@google.com>
Subject: [syzbot] KMSAN: uninit-value in iforce_init_device (2)
From:   syzbot <syzbot+4dd880c1184280378821@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, glider@google.com,
        greg.iforce@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    968c2729e576 x86: kmsan: fix comment in kmsan_shadow.c
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14efb852880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=131312b26465c190
dashboard link: https://syzkaller.appspot.com/bug?extid=4dd880c1184280378821
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/56b19fc61d98/disk-968c2729.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b048b309a6e5/vmlinux-968c2729.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4dd880c1184280378821@syzkaller.appspotmail.com

iforce 1-1:0.0: usb_submit_urb failed: -71
iforce 1-1:0.0: usb_submit_urb failed: -71
iforce 1-1:0.0: usb_submit_urb failed: -71
=====================================================
BUG: KMSAN: uninit-value in iforce_init_device+0x1bd5/0x2010 drivers/input/joystick/iforce/iforce-main.c:297
 iforce_init_device+0x1bd5/0x2010 drivers/input/joystick/iforce/iforce-main.c:297
 iforce_usb_probe+0xc86/0x11c0 drivers/input/joystick/iforce/iforce-usb.c:238
 usb_probe_interface+0xc4b/0x11f0 drivers/usb/core/driver.c:396
 really_probe+0x506/0x1000 drivers/base/dd.c:639
 __driver_probe_device+0x2fa/0x3d0 drivers/base/dd.c:778
 driver_probe_device+0x72/0x7a0 drivers/base/dd.c:808
 __device_attach_driver+0x548/0x8e0 drivers/base/dd.c:936
 bus_for_each_drv+0x1fc/0x360 drivers/base/bus.c:427
 __device_attach+0x42a/0x720 drivers/base/dd.c:1008
 device_initial_probe+0x2e/0x40 drivers/base/dd.c:1057
 bus_probe_device+0x13c/0x3b0 drivers/base/bus.c:487
 device_add+0x1d4b/0x26c0 drivers/base/core.c:3517
 usb_set_configuration+0x30f8/0x37e0 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0x105/0x290 drivers/usb/core/generic.c:238
 usb_probe_device+0x288/0x490 drivers/usb/core/driver.c:293
 really_probe+0x506/0x1000 drivers/base/dd.c:639
 __driver_probe_device+0x2fa/0x3d0 drivers/base/dd.c:778
 driver_probe_device+0x72/0x7a0 drivers/base/dd.c:808
 __device_attach_driver+0x548/0x8e0 drivers/base/dd.c:936
 bus_for_each_drv+0x1fc/0x360 drivers/base/bus.c:427
 __device_attach+0x42a/0x720 drivers/base/dd.c:1008
 device_initial_probe+0x2e/0x40 drivers/base/dd.c:1057
 bus_probe_device+0x13c/0x3b0 drivers/base/bus.c:487
 device_add+0x1d4b/0x26c0 drivers/base/core.c:3517
 usb_new_device+0x17ac/0x2370 drivers/usb/core/hub.c:2573
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x5589/0x8080 drivers/usb/core/hub.c:5735
 process_one_work+0xb27/0x13e0 kernel/workqueue.c:2289
 worker_thread+0x1076/0x1d60 kernel/workqueue.c:2436
 kthread+0x31b/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30

Local variable buf created at:
 iforce_init_device+0x5a/0x2010 drivers/input/joystick/iforce/iforce-main.c:217
 iforce_usb_probe+0xc86/0x11c0 drivers/input/joystick/iforce/iforce-usb.c:238

CPU: 0 PID: 15409 Comm: kworker/0:2 Not tainted 6.0.0-rc5-syzkaller-48543-g968c2729e576 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Workqueue: usb_hub_wq hub_event
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
