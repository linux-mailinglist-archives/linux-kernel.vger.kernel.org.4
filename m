Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4D873CE7D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 06:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjFYE7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 00:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYE7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 00:59:00 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B91E5D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 21:58:59 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3420c84e530so13173075ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 21:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687669138; x=1690261138;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zh5fpvwsPKvfH2zfGfL3uL4oFqLx29Dszvhlc1s4o3Q=;
        b=kb0THBaJSKr1/0EoUl1syuIMLvcvMCq4ysS6uKANbqRPQwhezh+w6/N95VVMWxtWe2
         gZfKOUj49VSPJPA6/W5TVqp6Frs9Nfw+Vlaxczr1bgd0kigmHaed2Sy9Un+XQpbXMt4g
         /BlsOa5ieDxdlWGx8mrJUADUZ93/khg2kEWNH9qQjecY/xiv6e4c+ReArzPC1lZj0JCE
         YIczVatNHH1ACgUI1gxO0lJ+fxc7wMCNmiOHDmk7jBkhzBDj+Tt8cUHBGYsFzFpr2vSH
         pNVxgkdpC9Oagb18dZmtAJBbvC6yLRcslUa1cq5IiZfWYvm91HCtQ4l75+pfl2KG0kNu
         fhrw==
X-Gm-Message-State: AC+VfDxvmzIOuDqKC0bOU1M8oOv0voKtqI9DQQhYV0mDVHEQmj8fbuE3
        0en6cHR+UzxL63kLwd1I5t6c84Xm8QiI6HHNbstJUhv/gt9h
X-Google-Smtp-Source: ACHHUZ6QNHFQpVsYAW1OyDtioJuiu09y0HwMpWW6cIqKQYhzjCiiy74uJDi7On7ItlpKdnWzYqMDf5v2q56qCfsr+3EZGWS/zYFN
MIME-Version: 1.0
X-Received: by 2002:a92:603:0:b0:340:c135:a371 with SMTP id
 x3-20020a920603000000b00340c135a371mr9287824ilg.1.1687669138699; Sat, 24 Jun
 2023 21:58:58 -0700 (PDT)
Date:   Sat, 24 Jun 2023 21:58:58 -0700
In-Reply-To: <000000000000152bee05f8adb94c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082beb905feed17cf@google.com>
Subject: Re: [syzbot] [block?] WARNING in wait_til_done (2)
From:   syzbot <syzbot+9bc4da690ee5334f5d15@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13426150a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=24ce1b2abaee24cc
dashboard link: https://syzkaller.appspot.com/bug?extid=9bc4da690ee5334f5d15
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e0603b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137e080b280000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a92b7d26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86f5fbd54cd3/vmlinux-a92b7d26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72b4c75c41dd/bzImage-a92b7d26.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bc4da690ee5334f5d15@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5531 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 0 PID: 5531 at drivers/block/floppy.c:999 wait_til_done+0x350/0x3c0 drivers/block/floppy.c:2018
Modules linked in:
CPU: 0 PID: 5531 Comm: syz-executor276 Not tainted 6.4.0-rc7-syzkaller-00226-ga92b7d26c743 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:wait_til_done+0x350/0x3c0 drivers/block/floppy.c:2018
Code: fc 41 83 fd 01 7e ac e8 3e 49 60 fc 4c 89 e6 48 c7 c7 60 42 46 8d e8 df 0a 3e fc e8 2a 49 60 fc e9 c3 fd ff ff e8 20 49 60 fc <0f> 0b e9 4b fd ff ff e8 64 1f b2 fc e9 0f fe ff ff e8 0a 49 60 fc
RSP: 0018:ffffc900042ef738 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff9200085dee7 RCX: 0000000000000000
RDX: ffff888023961500 RSI: ffffffff85232220 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff8522dea0 R14: 0000000000000006 R15: 0000000000000003
FS:  00007fbbf86fe700(0000) GS:ffff88806b600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001ceb0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_check_events+0x35e/0x680 drivers/block/floppy.c:4098
 disk_check_events+0xc2/0x420 block/disk-events.c:193
 disk_clear_events block/disk-events.c:248 [inline]
 bdev_check_media_change+0x12a/0x350 block/disk-events.c:279
 floppy_open+0x873/0xe90 drivers/block/floppy.c:4057
 blkdev_get_whole+0x93/0x2c0 block/bdev.c:606
 blkdev_get_by_dev.part.0+0x5e2/0xb80 block/bdev.c:756
 blkdev_get_by_dev+0x6f/0x90 block/bdev.c:790
 blkdev_open+0x140/0x2d0 block/fops.c:493
 do_dentry_open+0x6cc/0x13f0 fs/open.c:920
 do_open fs/namei.c:3636 [inline]
 path_openat+0x1baa/0x2750 fs/namei.c:3791
 do_filp_open+0x1ba/0x410 fs/namei.c:3818
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbbf8f12444
Code: 84 00 00 00 00 00 44 89 54 24 0c e8 c6 f9 ff ff 44 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 f8 f9 ff ff 8b 44
RSP: 002b:00007fbbf86fdd60 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbbf8f12444
RDX: 0000000000000000 RSI: 00007fbbf86fdde0 RDI: 00000000ffffff9c
RBP: 00007fbbf86fdde0 R08: 0000000000000000 R09: 00007fbbf86fe700
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffdc0de869f R14: 00007fbbf86fe300 R15: 0000000000022000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
