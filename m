Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B5273373D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbjFPRN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346039AbjFPRNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:13:53 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DB4E76
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:13:52 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-34087ba5febso7340855ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 10:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686935632; x=1689527632;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IE+IFgH6pBWU74MLE12W2IiGw5dTrwTIG9FskakYaH8=;
        b=Zdp4YZ7SIJHcW3P0Z/jP27aVtaqvFL2PJK6h8YIxtaWwiuLx7k+uoCkb+KMjyr028W
         4dskV122CIcneDRB3vYzqaRFC/JrjRVmGT7NHe4A7YFHmFRqFfidcbuUrL2w6/x5R7kV
         Yw/TI4YJxM6FqwYZ4bgvekTm8I9dbT5bsGfKBeVitqfPZeDdTXd5sruEctQXmnvoixUp
         Ss5lAiyhcZSrXpitl3LgWSaZq/D7DHwNZLZr4VnEXZUhLmAMWrrf4Lnimvlzg125AQmh
         SWFIpFDTX05q7kDk1jYZtLQNeHlTioUt0HJjWhsMHWYjzdR/FhH9EfPvg3o/o8e5tPgC
         3lGQ==
X-Gm-Message-State: AC+VfDx/tJK1YdimGih5zZS67MkwbCaE4Aw+p7Y8XXvP7tWQovHbkxh4
        PHQhSCobEI1f3DgsH3/Kw2hyCEtzkeHjuFU94beQF52P2iohfTn8XA==
X-Google-Smtp-Source: ACHHUZ4UhvkP4/LPnHJkjajtZ1DyrJAzMgklZjd7Mve6Qb3UssRUhPjwh+TohoE83+mT/KsicAAY4E4CPZ/D4RxtPzuZlb9Cd6aJ
MIME-Version: 1.0
X-Received: by 2002:a92:c60a:0:b0:33e:5ea2:bd07 with SMTP id
 p10-20020a92c60a000000b0033e5ea2bd07mr1112842ilm.6.1686935631932; Fri, 16 Jun
 2023 10:13:51 -0700 (PDT)
Date:   Fri, 16 Jun 2023 10:13:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000019b2b105fe424f00@google.com>
Subject: [syzbot] [media?] [usb?] WARNING in imon_probe
From:   syzbot <syzbot+1c41b2e045dc086f58be@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, sean@mess.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    fd37b884003c io_uring/io-wq: don't clear PF_IO_WORKER on e..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f67407280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5bcee04c3b2a8237
dashboard link: https://syzkaller.appspot.com/bug?extid=1c41b2e045dc086f58be
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1339b027280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7108f22d99d8/disk-fd37b884.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83e4f595c21b/vmlinux-fd37b884.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16c5c6a2de66/bzImage-fd37b884.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c41b2e045dc086f58be@syzkaller.appspotmail.com

usb 1-1: 2:1 : UAC_AS_GENERAL descriptor not found
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 4606 at kernel/locking/mutex.c:582 __mutex_lock_common kernel/locking/mutex.c:582 [inline]
WARNING: CPU: 1 PID: 4606 at kernel/locking/mutex.c:582 __mutex_lock+0x9f8/0x1350 kernel/locking/mutex.c:747
Modules linked in:
CPU: 1 PID: 4606 Comm: kworker/1:3 Not tainted 6.4.0-rc6-syzkaller-00006-gfd37b884003c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:582 [inline]
RIP: 0010:__mutex_lock+0x9f8/0x1350 kernel/locking/mutex.c:747
Code: 08 84 d2 0f 85 7e 08 00 00 8b 05 5f a8 67 04 85 c0 0f 85 1b f7 ff ff 48 c7 c6 80 59 4c 8a 48 c7 c7 40 57 4c 8a e8 08 ee 38 f7 <0f> 0b e9 01 f7 ff ff 48 8b 7c 24 30 be 08 00 00 00 e8 e2 02 c4 f7
RSP: 0018:ffffc9000346efb0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888025839dc0 RSI: ffffffff814c03b7 RDI: 0000000000000001
RBP: ffff88807bc74ea8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888020037000 R15: ffff88807bc750d1
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc66ff2f38 CR3: 0000000023c93000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 imon_init_intf1 drivers/media/rc/imon.c:2321 [inline]
 imon_probe+0x1e5/0x3630 drivers/media/rc/imon.c:2449
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:958
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_set_configuration+0x1196/0x1bc0 drivers/usb/core/message.c:2211
 usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:800
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:830
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:958
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1030
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2575
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
