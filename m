Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533E6660295
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjAFOxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjAFOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:52:50 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4812981118
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 06:52:46 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so1229433ilj.14
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 06:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwJj3ukHBS4HhOdjJwZf2jh6ZvUSsH4w4Bs6U9FQIQg=;
        b=GZJOmXzJxETNf2EoTuk2zImT0Q3bGOMKFqMhpBe74gbG+UFjCcY+7wEvO5YBp9RMl/
         5Zjoyh/UszH3hqozIKsKP3jHTE8Qjn006X7hQXDqQgRwC+7117i4BUHaSdThzterldb+
         iJMl07f50FBo4hr2TpELu+6CNvN3qNHv9edWyhEpS026Z5Cf5xpURIKenma3pnFMPIEM
         DA1FOvfeYzuf2ag2I5Tajdb6FX3kpXh+PcQGBVuB56XRs7nKVg1H8JQ5O53pGgeKMiLM
         mhek3GfW4Xff3O1gQN4lDD5QQoU0y1L9Klplp+yqbL1Xd4Qg/52Coe2WAR6d0gDcV/zd
         yLwQ==
X-Gm-Message-State: AFqh2kqLsQTNi+L2lI3iRxmPJqjeemtG0Rv9d9re7fzzbBHsskr7S5AD
        mn4bzNbAgTVT8GxSQOeUUIawQiKsl/s86ACpjmjBrJ6s/TKT
X-Google-Smtp-Source: AMrXdXuj7qVm8nk030l3GLBPLuv16v0qfH0zpe3TrpwrRJCMSwtD005L/vBAiJxeevnSltDmoJZpL+50vzsimjTouiCOHUvkX+9B
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:deb:b0:30c:1e65:b594 with SMTP id
 m11-20020a056e020deb00b0030c1e65b594mr3002705ilj.45.1673016765901; Fri, 06
 Jan 2023 06:52:45 -0800 (PST)
Date:   Fri, 06 Jan 2023 06:52:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008f1d405f1999228@google.com>
Subject: [syzbot] WARNING in __usbnet_read_cmd/usb_submit_urb
From:   syzbot <syzbot+2a0e7abd24f1eb90ce25@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mailhol.vincent@wanadoo.fr,
        mkl@pengutronix.de, syzkaller-bugs@googlegroups.com
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

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=128acc94480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19062640e84d2e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=2a0e7abd24f1eb90ce25
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/22dc9b4a71a2/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3a88668bf3ce/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ff0c2e45492/bzImage-1b929c02.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a0e7abd24f1eb90ce25@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 3-1: BOGUS control dir, pipe 80003d80 doesn't match bRequestType c0
WARNING: CPU: 1 PID: 2386 at drivers/usb/core/urb.c:411 usb_submit_urb+0x14a3/0x1880 drivers/usb/core/urb.c:411
Modules linked in:
CPU: 1 PID: 2386 Comm: dhcpcd Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:usb_submit_urb+0x14a3/0x1880 drivers/usb/core/urb.c:411
Code: 7c 24 40 e8 8f af 8b fd 48 8b 7c 24 40 e8 e5 2c 19 ff 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 00 df aa 86 e8 5b e6 15 02 <0f> 0b e9 9f ee ff ff e8 61 af 8b fd 0f b6 1d 89 5f 18 05 31 ff 41
RSP: 0018:ffffc9000147f598 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888118cdc058 RCX: 0000000000000000
RDX: ffff888116045400 RSI: ffffffff812d3e48 RDI: fffff5200028fea5
RBP: ffff888108e1cf78 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810dcc37a8
R13: 00000000000000c0 R14: 0000000080003d80 R15: ffff88810b3e5600
FS:  00007f22d5f1d740(0000) GS:ffff8881f6900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f54a3e45440 CR3: 0000000112062000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_start_wait_urb+0x101/0x4b0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 __usbnet_read_cmd+0xb9/0x390 drivers/net/usb/usbnet.c:2010
 usbnet_read_cmd+0x92/0xf0 drivers/net/usb/usbnet.c:2068
 pl_vendor_req drivers/net/usb/plusb.c:60 [inline]
 pl_set_QuickLink_features drivers/net/usb/plusb.c:75 [inline]
 pl_reset+0x2b/0xf0 drivers/net/usb/plusb.c:85
 usbnet_open+0xc8/0x5d0 drivers/net/usb/usbnet.c:889
 __dev_open+0x297/0x4d0 net/core/dev.c:1417
 __dev_change_flags+0x583/0x750 net/core/dev.c:8530
 dev_change_flags+0x93/0x170 net/core/dev.c:8602
 devinet_ioctl+0x1601/0x1ce0 net/ipv4/devinet.c:1147
 inet_ioctl+0x1e6/0x320 net/ipv4/af_inet.c:979
 sock_do_ioctl+0xcc/0x230 net/socket.c:1169
 sock_ioctl+0x2f1/0x640 net/socket.c:1286
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f22d600b0e7
Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 61 9d 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc78c609f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f22d5f1d6c8 RCX: 00007f22d600b0e7
RDX: 00007ffc78c70be8 RSI: 0000000000008914 RDI: 0000000000000005
RBP: 00007ffc78c80d98 R08: 00007ffc78c70ba8 R09: 00007ffc78c70b58
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc78c70be8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
