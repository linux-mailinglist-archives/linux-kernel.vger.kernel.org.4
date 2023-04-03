Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B6E6D4B25
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjDCOzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbjDCOzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:55:18 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35A51695E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:54:54 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s6-20020a056e02216600b003264c778ef1so6097071ilv.23
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533694; x=1683125694;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vPkeM6iVQmH51RezuW+fSSVO087XA5s1H6NW6olKmYg=;
        b=OKwnaFG6cFSr766vEQ6LCPNWPuwT9M+VXF8R4C9PX0xvH8ojH/oGgDz/oZf+pbm7rr
         q5UPhMQ1m2GO+0oFzjmQrSPrUGYrqDRFU+U+I3DbiDThtFs91ex/nLqtWMVyR3taoMj1
         VYypcDDtCypTvWUcVTjF+lf7xbX8ghzm9iYqIp7uwtZZlGCqss2cmgrDs+c5JQLmoOFx
         HKMjKaQ0dVbbuK9PRyve271njMCkX4hf2oXqwQwwhbd8efJi0XuS+QLMRtcrNYmS6mkE
         rPa+xNarblOg+DrnWA4a6ghBnNM3WpOBoGPPBOkQanYET8f+TGt3bGLoP8UYxFZ14LHj
         cQ9A==
X-Gm-Message-State: AAQBX9fBCUVk5PEq0nONu5TBX0Bg6oQBHdzXq5D1jTZZ8cYC1FP9tyyf
        SZimr64vJRpN8UPkwP4sxHYxwA5XkREDv09j8zQdhl4EJsQ8
X-Google-Smtp-Source: AKy350bJ7Pe47KEb4vQQRIqXVM9pfr+NX+zTWRzXW+KSApy6hrByjHeELRIXUQkGOGzUpsQeEjEjuOOAQ4+VMciJxz7pyS1yvNG0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:322:fd25:872c with SMTP id
 j13-20020a056e02218d00b00322fd25872cmr18242499ila.2.1680533694048; Mon, 03
 Apr 2023 07:54:54 -0700 (PDT)
Date:   Mon, 03 Apr 2023 07:54:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddf5f505f86fbd72@google.com>
Subject: [syzbot] [block?] WARNING in process_fd_request
From:   syzbot <syzbot+1d4201dfe9f2386fdc0b@syzkaller.appspotmail.com>
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

HEAD commit:    ffe78bbd5121 Merge tag 'xtensa-20230327' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146bbb71c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d40b592130bb7abb
dashboard link: https://syzkaller.appspot.com/bug?extid=1d4201dfe9f2386fdc0b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d4201dfe9f2386fdc0b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 29261 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 0 PID: 29261 at drivers/block/floppy.c:999 process_fd_request+0x6b/0x70 drivers/block/floppy.c:2847
Modules linked in:
CPU: 0 PID: 29261 Comm: kworker/u8:17 Not tainted 6.3.0-rc4-syzkaller-00039-gffe78bbd5121 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: floppy floppy_shutdown
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request+0x6b/0x70 drivers/block/floppy.c:2847
Code: fc 5b bf 08 00 00 00 48 c7 c2 c0 78 45 8d 48 8b 35 6a a3 ec 0c 48 c7 05 7f 9e ec 0c b0 8c 1c 85 e9 ea 70 36 fc e8 05 6d 66 fc <0f> 0b eb ce 90 48 b8 00 00 00 00 00 fc ff df 41 55 49 89 fd 41 54
RSP: 0018:ffffc90002f7fcf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801d64ba80 RSI: ffffffff851c6b4b RDI: 0000000000000001
RBP: 0000000000000282 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90002f7fda8
R13: ffffffff8d457950 R14: ffff88800019f200 R15: ffff888012489000
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000584eb404 CR3: 0000000023f74000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_shutdown+0x135/0x230 drivers/block/floppy.c:1889
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
