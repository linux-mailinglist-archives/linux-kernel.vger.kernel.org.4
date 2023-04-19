Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B666E7742
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjDSKQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjDSKQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:16:44 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566E5449D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:16:43 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-32aff21222eso43763155ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681899402; x=1684491402;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHjfQRfXbjdHN3NrBo1io8SY3+2TWu2ff8M792CObcc=;
        b=XZdCc9yFAKRL3iD6aDBOx/xMVzLampR0r6uhkAaVr6/FfY28Kvcy/GVX9ukiP+GRy5
         iZWFpFwoACDYTGgvH0osvUBr0WqKhgDWiddcEkrfKKiVeGz0vvvQnwbioLurPiQpZk9U
         Q5tuB5YgE8IhARGUOPk6neztae2B9Jhj7HxrPUpKnYCPQUCykjMf90Ma1D3UCRH8njSW
         Jpeytb4UTHySAezvUB7+XB+YP2dLKjmeY+MuxOwODGWflCTQWWPGer0DUrTsXBtSr+pA
         BM3Zx32EWj5EOSPML/6533Xdqqqeka4P0YMwkXd3LohMk5v6E/vn1fDb9LdSC5gEp6p0
         ZuxQ==
X-Gm-Message-State: AAQBX9dITGIghusezBnvxvM3iQv1Xvsgy3fLSzyDZzI7uWkICnR5n4Po
        HIFAzwZWBkKE6YthW0rJK2uZDTkXMF+lXZqTHvrsm4Nv5qed
X-Google-Smtp-Source: AKy350aVck6E004kOFNJwGkuHTlYaLDG6WD9XBP8Yly2G+nSNeCt6nhF79T17FQO1m70rA6dp2uoLCbWQ96YSF4gk1jCjg2938m9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:106:b0:325:a8e7:126c with SMTP id
 t6-20020a056e02010600b00325a8e7126cmr10031345ilm.0.1681899402649; Wed, 19 Apr
 2023 03:16:42 -0700 (PDT)
Date:   Wed, 19 Apr 2023 03:16:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000716a3705f9adb8ee@google.com>
Subject: [syzbot] [usb?] WARNING in usbtmc_ioctl/usb_submit_urb (2)
From:   syzbot <syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    95abc817ab3a Merge tag 'acpi-6.3-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137cee2bc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
dashboard link: https://syzkaller.appspot.com/bug?extid=ce77725b89b7bd52425c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4eed56ed732d/disk-95abc817.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e3d153beec24/vmlinux-95abc817.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61c1a80c61a8/bzImage-95abc817.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 23804 at drivers/usb/core/urb.c:411 usb_submit_urb+0x14a7/0x1880 drivers/usb/core/urb.c:411
Modules linked in:
CPU: 0 PID: 23804 Comm: syz-executor.1 Not tainted 6.3.0-rc6-syzkaller-00168-g95abc817ab3a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:usb_submit_urb+0x14a7/0x1880 drivers/usb/core/urb.c:411
Code: 7c 24 40 e8 eb 8e 64 fb 48 8b 7c 24 40 e8 31 cd f2 fe 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 60 39 fb 8a e8 19 04 2d fb <0f> 0b e9 9f ee ff ff e8 bd 8e 64 fb 0f b6 1d b6 82 43 08 31 ff 41
RSP: 0018:ffffc90007e97b00 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88807bff7058 RCX: ffffc900042b3000
RDX: 0000000000040000 RSI: ffffffff814b6237 RDI: 0000000000000001
RBP: ffff88807ebb10f0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88802bd88410
R13: 0000000000000080 R14: 0000000080006f80 R15: ffff88802a7c7200
FS:  00007f2f0b7e3700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0eb75831b8 CR3: 000000002255b000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_start_wait_urb+0x101/0x4b0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x320/0x4a0 drivers/usb/core/message.c:153
 usbtmc_ioctl_request drivers/usb/class/usbtmc.c:1954 [inline]
 usbtmc_ioctl+0x1b3d/0x2840 drivers/usb/class/usbtmc.c:2097
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2f0aa8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f0b7e3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f2f0ababf80 RCX: 00007f2f0aa8c169
RDX: 0000000020000040 RSI: 00000000c0105b08 RDI: 0000000000000004
RBP: 00007f2f0aae7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2f0accfb1f R14: 00007f2f0b7e3300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
