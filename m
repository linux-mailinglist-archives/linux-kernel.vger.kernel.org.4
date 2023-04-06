Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4546D9DF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbjDFQvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbjDFQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:51:43 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C9EAA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:51:42 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id g7-20020a056602242700b00758e7dbd0dbso25193845iob.16
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 09:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799901; x=1683391901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPNvMqwq7Vl/Pla7kHnqRsp93LF7NUEp/EVbRLBG6mk=;
        b=eIXjqlTN+P22+dcc7DVaR8BmnSLUi7qjUrcdZCi0QACpHbWF0ChCVgAMuXcgedBgRr
         c0zXko01fS+12DXriRCbx5e6Httpy2kPEBfDTFRD7T2RJCJoPxZ9JhTlkdl8GTmip0c0
         R6gXtfDlJqP7+CDg+KFQ4qmRd+IbrnnZKWg198SbkuAADy57UeXI9D98Lig3sowXyfzJ
         jTdJ7kGBEp3HGf6gBFudBRYK3sroUf4qepw91HBIdtI6WyWPTlFDh/skXsEr1V9KLDg1
         AP6wHyWOTy7AUA5DcNWvMP/JZv8cij438kO293UrBym++rmgrdgEO4cmpnh9ZtIreifL
         T8qw==
X-Gm-Message-State: AAQBX9dnUuzc0Wz6JRO6n3HQysalguFlUPTZPvQZ/sTaCzK3r/cmq3r7
        EH4hvUtqpOcz69o0k79ECy/THOvcWjExdQnQv8utBwgONsnt
X-Google-Smtp-Source: AKy350aB1kMwD47CTvFnGsBxN2BJukVoF5k7sg0VGqdBKEMNx7tpT5RRsDuCg8B6QiIdCc9xw5bQNvd3KLAqt4dizZMGHxGjCkyP
MIME-Version: 1.0
X-Received: by 2002:a6b:ed18:0:b0:745:68ef:e410 with SMTP id
 n24-20020a6bed18000000b0074568efe410mr100730iog.0.1680799901753; Thu, 06 Apr
 2023 09:51:41 -0700 (PDT)
Date:   Thu, 06 Apr 2023 09:51:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000152bee05f8adb94c@google.com>
Subject: [syzbot] [block?] WARNING in wait_til_done (2)
From:   syzbot <syzbot+9bc4da690ee5334f5d15@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    148341f0a2f5 Merge tag 'vfs.misc.fixes.v6.3-rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a10d3ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=adfc55aec6afccdd
dashboard link: https://syzkaller.appspot.com/bug?extid=9bc4da690ee5334f5d15
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9bc4da690ee5334f5d15@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 793 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 0 PID: 793 at drivers/block/floppy.c:999 wait_til_done+0x350/0x3c0 drivers/block/floppy.c:2018
Modules linked in:
CPU: 0 PID: 793 Comm: syz-executor.1 Not tainted 6.3.0-rc5-syzkaller-00005-g148341f0a2f5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:wait_til_done+0x350/0x3c0 drivers/block/floppy.c:2018
Code: fc 41 83 fd 01 7e ac e8 4e 7f 66 fc 4c 89 e6 48 c7 c7 e0 d4 44 8d e8 3f 7b 44 fc e8 3a 7f 66 fc e9 c3 fd ff ff e8 30 7f 66 fc <0f> 0b e9 4b fd ff ff e8 64 9f b6 fc e9 0f fe ff ff e8 1a 7f 66 fc
RSP: 0018:ffffc90004d4f738 EFLAGS: 00010216
RAX: 0000000000000b2f RBX: 1ffff920009a9ee7 RCX: ffffc900027ca000
RDX: 0000000000040000 RSI: ffffffff851b7940 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff851b35c0 R14: 0000000000000000 R15: 0000000000000003
FS:  00007fed1de7c700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc84fd52d38 CR3: 000000006e24b000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_check_events+0x35e/0x680 drivers/block/floppy.c:4098
 disk_check_events+0xc2/0x420 block/disk-events.c:193
 disk_clear_events block/disk-events.c:248 [inline]
 bdev_check_media_change+0x130/0x360 block/disk-events.c:279
 floppy_open+0x879/0xe90 drivers/block/floppy.c:4057
 blkdev_get_whole+0x99/0x2d0 block/bdev.c:594
 blkdev_get_by_dev.part.0+0x5e0/0xb80 block/bdev.c:744
 blkdev_get_by_dev+0x6f/0x90 block/bdev.c:778
 blkdev_open+0x140/0x2c0 block/fops.c:493
 do_dentry_open+0x6cc/0x13f0 fs/open.c:920
 do_open fs/namei.c:3560 [inline]
 path_openat+0x1baa/0x2750 fs/namei.c:3715
 do_filp_open+0x1ba/0x410 fs/namei.c:3742
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_openat fs/open.c:1380 [inline]
 __se_sys_openat fs/open.c:1375 [inline]
 __x64_sys_openat+0x143/0x1f0 fs/open.c:1375
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fed1d03e2f4
Code: Unable to access opcode bytes at 0x7fed1d03e2ca.
RSP: 002b:00007fed1de7bca0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 6666666666666667 RCX: 00007fed1d03e2f4
RDX: 0000000000000000 RSI: 00007fed1de7bd40 RDI: 00000000ffffff9c
RBP: 00007fed1de7bd40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffe2ee6a22f R14: 00007fed1de7c300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
