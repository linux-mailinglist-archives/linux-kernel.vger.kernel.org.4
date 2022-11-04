Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9570B61A2A6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiKDUrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:47:38 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B604298A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:47:37 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n1-20020a6b7701000000b006d1f2c2850aso3743210iom.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMcUo3E8P00VPKuetMbQKg3svT224XRpO7k7+T4p6Aw=;
        b=5pxKWTzFLCLeBasETgb4mE8azHPAhr//adQ29TsmpOXGFGif+feZafSeeOcaWK6VFm
         h+9YeAhDeONM9zD1EA9SpsBGuVmPf5lFvXRyeMv9MVjFvwhAGUpO641swSMNZbTSCPqy
         +HBHrrq/7nYKxd3g/LIsneg+hv1H4vLtl9RfS3QpGftOGI5eYh+mZzyNHmbecekE/Kgg
         J4UofGkFPB+NWRrHWK3rqrCN0lar1AZg60ndDmBjthVGg95qkMdMTItBSt4M4fO+jfE+
         PSu2RHrr1uNzXflsmcZiRZ/+Aq8r6l3v97AHNIx7AFtiSePXEVhiMdJTmHu2nSQHclHc
         90VA==
X-Gm-Message-State: ACrzQf27wOx3AC0gXCBVZ2sKrWt5gfxiLFYL4sE4QgY8+eXHjJWVoM84
        J3pmEKwO4QSx1c3RX3jxNHv6+fAlMPtiB1kzvEqheIf8wLL1
X-Google-Smtp-Source: AMsMyM78bicH4K8m851cxvZOJk2DMBuF7xAwb7xHGU7YOQ/2hEWp3nGMFcgv1tTwwX73mkXGlkV5pM2l64vVuC4sx0pK6WRP6ucE
MIME-Version: 1.0
X-Received: by 2002:a6b:c3cc:0:b0:6d8:b8e8:4694 with SMTP id
 t195-20020a6bc3cc000000b006d8b8e84694mr134523iof.193.1667594856427; Fri, 04
 Nov 2022 13:47:36 -0700 (PDT)
Date:   Fri, 04 Nov 2022 13:47:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bf89905ecab2f86@google.com>
Subject: [syzbot] WARNING in usbtmc_ioctl_request/usb_submit_urb
From:   syzbot <syzbot+588a3c76a3b2f453a909@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1111f646880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=701f2aae1cb0470e
dashboard link: https://syzkaller.appspot.com/bug?extid=588a3c76a3b2f453a909
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d9d974225814/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a71771368ee9/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2f6c9e8f9713/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+588a3c76a3b2f453a909@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 5-1: BOGUS control dir, pipe 80005f80 doesn't match bRequestType ff
WARNING: CPU: 1 PID: 25513 at drivers/usb/core/urb.c:413 usb_submit_urb+0x12f4/0x1920 drivers/usb/core/urb.c:411
Modules linked in:
CPU: 1 PID: 25513 Comm: syz-executor.2 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:usb_submit_urb+0x12f4/0x1920 drivers/usb/core/urb.c:411
Code: 20 84 c0 0f 85 a3 05 00 00 48 8b 44 24 18 44 0f b6 00 48 c7 c7 20 ff 53 8b 48 8b 74 24 60 48 89 da 89 e9 31 c0 e8 9c ed 38 fb <0f> 0b 4d 89 e6 44 8b 64 24 48 4c 8b 7c 24 58 e9 c5 f2 ff ff 89 d9
RSP: 0018:ffffc90015a67a90 EFLAGS: 00010246
RAX: 47ea9dc414312400 RBX: ffff88807e3da410 RCX: 0000000000040000
RDX: ffffc9000d9ea000 RSI: 0000000000005526 RDI: 0000000000005527
RBP: 0000000080005f80 R08: ffffffff816ced5d R09: fffff52002b4cf0d
R10: fffff52002b4cf0d R11: 1ffff92002b4cf0c R12: dffffc0000000000
R13: ffff8880565d4b00 R14: dffffc0000000000 R15: ffff88806bd570a8
FS:  00007f4059244700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f96fa5a7110 CR3: 0000000021e2b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_start_wait_urb+0x10e/0x510 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x2a5/0x4b0 drivers/usb/core/message.c:153
 usbtmc_ioctl_request+0x421/0x920 drivers/usb/class/usbtmc.c:1954
 usbtmc_ioctl+0x63f/0x800 drivers/usb/class/usbtmc.c:2097
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f405848b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4059244168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f40585ac050 RCX: 00007f405848b5a9
RDX: 0000000020000280 RSI: 00000000c0105b08 RDI: 0000000000000004
RBP: 00007f40584e67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd78225cef R14: 00007f4059244300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
