Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787006DD384
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjDKGzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjDKGzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:55:10 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19BF3C03
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:54:46 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id u6-20020a926006000000b003232594207dso5511369ilb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681196086; x=1683788086;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SbarmdOkuRZxojL+y9qIUN8oc/jImKA5TOPqPYvQPpM=;
        b=rLKPOcNGOBjx5XCH6qInIfYwuPLKp1NMCZys9yOSU9orpnKAF28BiGzP0Ho4/EHM3t
         u4ojotehp156uamUFxLmf0AHCmtr4gPUC/XTWecFB/8Q16CXtdPebvL7PVUVYluygSFW
         VaP0gHTkvjKFy3D+6n8ZdrghVeZ+wO65k/2CX7skh6OuM1da+9p7kfVnHwUatvIxX085
         qlFxUEmyG1qsh7HDBVrt1vRXfuP+rSJc4ib1Ndomp4dBKWerjbt/uoyV+WEAboNuyDtv
         gbXBC/asVBzJ7+jsca4V8FFcpu3ipYqAkYz+YgZ44SOktSNHy7D/tlrhemp9ttV9L8Dm
         tWAA==
X-Gm-Message-State: AAQBX9dbDzqhudIquDKaN+1JGp8YhzgcNiZDieT+B615tFIxrqDorh3F
        LuCp7KMVIVtrinVMC4NI2cn7RqIWDnkQflCGPyjX96k0UT6p
X-Google-Smtp-Source: AKy350ZCB0+68JSSgj2CAG6n1Sv6rwaBkRifc/3KeBXSkoYsoGhRQGgSM72JEOSCdSwPYctauLyVNi6U/wBAYX/MSDHICN0H4lBo
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d94:b0:758:f2d3:7fa1 with SMTP id
 k20-20020a0566022d9400b00758f2d37fa1mr10765886iow.0.1681196086185; Mon, 10
 Apr 2023 23:54:46 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:54:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083d76d05f909f716@google.com>
Subject: [syzbot] [kernel?] general protection fault in xpad_probe
From:   syzbot <syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com>
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

HEAD commit:    6a53bda3aaf3 Add linux-next specific files for 20230404
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16cde443c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2da90e7abb20c1a
dashboard link: https://syzkaller.appspot.com/bug?extid=a3f758b8d8cb7e49afec
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1b162a671d14/disk-6a53bda3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a0dbf376db5/vmlinux-6a53bda3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d48fe3fd998/bzImage-6a53bda3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3f758b8d8cb7e49afec@syzkaller.appspotmail.com

usb 6-1: config 0 interface 65 has no altsetting 0
usb 6-1: New USB device found, idVendor=12ab, idProduct=90a1, bcdDevice=1e.eb
usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 6-1: config 0 descriptor??
general protection fault, probably for non-canonical address 0xdffffc0000000068: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000340-0x0000000000000347]
CPU: 0 PID: 20530 Comm: kworker/0:1 Not tainted 6.3.0-rc5-next-20230404-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:dev_name include/linux/device.h:706 [inline]
RIP: 0010:__dev_printk+0x3b/0x270 drivers/base/core.c:4869
Code: f5 53 e8 88 8e 6f fc 48 85 ed 0f 84 cb 01 00 00 e8 7a 8e 6f fc 48 8d 7d 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d7 01 00 00 48 8b 5d 50 48 85 db 0f 84 b5 00 00
RSP: 0018:ffffc90004c66f70 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: fffff5200098cdf5 RCX: ffffc90014c8c000
RDX: 0000000000000068 RSI: ffffffff8513c496 RDI: 0000000000000340
RBP: 00000000000002f0 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffff92 R11: 0000000000000000 R12: ffffffff8ace0700
R13: ffffc90004c66fc8 R14: ffff88804962d264 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2cd2c000 CR3: 00000000458ec000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 _dev_warn+0xdc/0x120 drivers/base/core.c:4913
 xpad_probe+0x197e/0x2020 drivers/input/joystick/xpad.c:2035
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a50 drivers/base/core.c:3627
 usb_set_configuration+0x1196/0x1bc0 drivers/usb/core/message.c:2211
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
 device_add+0x112d/0x1a50 drivers/base/core.c:3627
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
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_name include/linux/device.h:706 [inline]
RIP: 0010:__dev_printk+0x3b/0x270 drivers/base/core.c:4869
Code: f5 53 e8 88 8e 6f fc 48 85 ed 0f 84 cb 01 00 00 e8 7a 8e 6f fc 48 8d 7d 50 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d7 01 00 00 48 8b 5d 50 48 85 db 0f 84 b5 00 00
RSP: 0018:ffffc90004c66f70 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: fffff5200098cdf5 RCX: ffffc90014c8c000
RDX: 0000000000000068 RSI: ffffffff8513c496 RDI: 0000000000000340
RBP: 00000000000002f0 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffff92 R11: 0000000000000000 R12: ffffffff8ace0700
R13: ffffc90004c66fc8 R14: ffff88804962d264 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c012c4b000 CR3: 000000002c080000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	f5                   	cmc
   1:	53                   	push   %rbx
   2:	e8 88 8e 6f fc       	callq  0xfc6f8e8f
   7:	48 85 ed             	test   %rbp,%rbp
   a:	0f 84 cb 01 00 00    	je     0x1db
  10:	e8 7a 8e 6f fc       	callq  0xfc6f8e8f
  15:	48 8d 7d 50          	lea    0x50(%rbp),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 d7 01 00 00    	jne    0x20b
  34:	48 8b 5d 50          	mov    0x50(%rbp),%rbx
  38:	48 85 db             	test   %rbx,%rbx
  3b:	0f                   	.byte 0xf
  3c:	84                   	.byte 0x84
  3d:	b5 00                	mov    $0x0,%ch


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
