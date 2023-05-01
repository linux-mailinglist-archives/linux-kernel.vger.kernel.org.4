Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838BC6F3094
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjEAL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 07:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjEAL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 07:59:55 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9827C1AC
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 04:59:53 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-76371bc5167so348593939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 04:59:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682942393; x=1685534393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YX7rt7FHmGBSzibjRFSAD1tmmQxnbJAEajs/qTIELU=;
        b=IJz+z//6wruUEJj9PszzFO0PesBkFYfLBKbiuM5uHweoJhA/1r9DrlJC5dEplIylvv
         D93/IX84E8aNmn5U4xobGXenwIZt3AgMwBJJzkjN+rgO+M63RLYcMzqslGZlkGZrVlbZ
         F5g5JAxeYvBjWH2yGIkraTaGlSPBYKhX4Gv1qvl7vhrIiDpgeWGgNc73rLbJMS1Oj2d+
         3e9sB19+YZGsFeToazcuPcQI2Fkl0bn7G97qWsLxZeHP9dsrKYUSg7zAEBTUTGV0ZDmX
         z/qmQGk0LNVktJpm5oiwf3v2CKjW6O4sTCv+YMLuZbWFA6g35Q1BZVu97yQ0fvmmnfCR
         LPrA==
X-Gm-Message-State: AC+VfDyXksRsamPhgNM5AFgcCfQDkxzBfUZUwS10fGpQ8HXeo4eOUzh4
        Y7RB7xRDIdS7H2Xaq2mq/1Vi3BWab1EGmxWHCXdqzrd20XdV
X-Google-Smtp-Source: ACHHUZ6iY4KobvzdfiJCVti6rJKLevKOM2A4oEN9IDGKoGC5j0LMz/k1ZGazH/AEuQoHHbSZ66EZ8/M5D19cibm1pK/UkVUNOxYM
MIME-Version: 1.0
X-Received: by 2002:a6b:ee11:0:b0:763:5e6c:2a46 with SMTP id
 i17-20020a6bee11000000b007635e6c2a46mr6226135ioh.2.1682942392976; Mon, 01 May
 2023 04:59:52 -0700 (PDT)
Date:   Mon, 01 May 2023 04:59:52 -0700
In-Reply-To: <000000000000716a3705f9adb8ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082cdb705faa08ffb@google.com>
Subject: Re: [syzbot] [usb?] WARNING in usbtmc_ioctl/usb_submit_urb (2)
From:   syzbot <syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d08158280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d56ffc213bf6bf4a
dashboard link: https://syzkaller.appspot.com/bug?extid=ce77725b89b7bd52425c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15027ef7c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d7550c280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/51c43e265c8a/disk-58390c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c64f4eeaf4d/vmlinux-58390c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5d8f49c4804/bzImage-58390c8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ce77725b89b7bd52425c@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 3-1: BOGUS control dir, pipe 80000b80 doesn't match bRequestType fd
WARNING: CPU: 0 PID: 5100 at drivers/usb/core/urb.c:411 usb_submit_urb+0x14a7/0x1880 drivers/usb/core/urb.c:411
Modules linked in:
CPU: 0 PID: 5100 Comm: syz-executor428 Not tainted 6.3.0-syzkaller-12049-g58390c8ce1bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:usb_submit_urb+0x14a7/0x1880 drivers/usb/core/urb.c:411
Code: 7c 24 40 e8 1b 13 5c fb 48 8b 7c 24 40 e8 21 1d f0 fe 45 89 e8 44 89 f1 4c 89 e2 48 89 c6 48 c7 c7 e0 b5 fc 8a e8 19 c8 23 fb <0f> 0b e9 9f ee ff ff e8 ed 12 5c fb 0f b6 1d 12 8a 3c 08 31 ff 41
RSP: 0018:ffffc90003d2fb00 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8880789e9058 RCX: 0000000000000000
RDX: ffff888029593b80 RSI: ffffffff814c1447 RDI: 0000000000000001
RBP: ffff88801ea742f8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802915e528
R13: 00000000000000fd R14: 0000000080000b80 R15: ffff8880222b3100
FS:  0000555556ca63c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9ef4d18150 CR3: 0000000073e5b000 CR4: 00000000003506f0
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
RIP: 0033:0x7f9ef4ca4e49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8d0be0d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f9ef4ca4e49
RDX: 0000000020000040 RSI: 00000000c0105b08 RDI: 0000000000000004
RBP: 0000000000000000 R08: 000000000000000f R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000015f73
R13: 00007fff8d0be160 R14: 00007fff8d0be150 R15: 00007fff8d0be11c
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
