Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B53463C16E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiK2Ntq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiK2Ntj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:49:39 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2639D2A95B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:49:38 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id d2-20020a056e020be200b00300ecc7e0d4so12089628ilu.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWWXwmr3mAg5BAn+N+S13w1zc/J644qPAvKtNELTnP8=;
        b=J8cbzqYKRUjDpH90XlJZxkRt6Sa6tKvvG37HZotqxuL4wbgKWYu2QOBNq0m4UeflEO
         8cQ8mg/N6rO77BubLB3OejyF9HGIcEBKP5rN2VXdd49/Uss9Emq7AnwoXd8A7wJFx7y2
         Spq9HGmPdKO/L538JrrXVpYeWlzeolNDbG7keJTo2p8ofQXCuD4UCsjcFhlaHAdPHA0N
         dIpRvep5iYydpX3mDCT8tXHvg/HP1WpGWM4N0SvO81WZdK4t05L0m4fVUcwYld+NIYc1
         QgNS4pDQ8qaUaOIul7FxWIN1vQ9BLUZsYDOPDs75tVypC0ZqS/qRYg0I1zxKWZXvnmAM
         l70A==
X-Gm-Message-State: ANoB5pkNFEl7GlQ5JnL4r0uPC3tRI4W4saiswa5gdW/KSYDKWlJ+g7/E
        3svOWd7+OjfyjS7TdKZJpQYInalbU5XYyQjLXuCsPo0Jz2Th
X-Google-Smtp-Source: AA0mqf6vHJnJzJ8gfjeJauMYuv2qOfnheOifH+9TYRgYIEqfPWcLIm3TSZyY6wfuq2jeQj6kU9U1fRXLLkXjznb48E0SX/S5KKWo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:268:b0:388:a49f:6aae with SMTP id
 x8-20020a056638026800b00388a49f6aaemr13007217jaq.63.1669729777564; Tue, 29
 Nov 2022 05:49:37 -0800 (PST)
Date:   Tue, 29 Nov 2022 05:49:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043463e05ee9c4277@google.com>
Subject: [syzbot] WARNING in journal_end
From:   syzbot <syzbot+d43f346675e449548021@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        song@kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9e46a7996732 Add linux-next specific files for 20221125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12c4ff75880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e19c740a0b2926
dashboard link: https://syzkaller.appspot.com/bug?extid=d43f346675e449548021
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/758d818cf966/disk-9e46a799.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7c8696b40a5/vmlinux-9e46a799.xz
kernel image: https://storage.googleapis.com/syzbot-assets/810f9750b87f/bzImage-9e46a799.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d43f346675e449548021@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 28237 at fs/reiserfs/journal.c:3395 journal_end+0x2da/0x330 fs/reiserfs/journal.c:3395
Modules linked in:
CPU: 0 PID: 28237 Comm: syz-executor.0 Not tainted 6.1.0-rc6-next-20221125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:journal_end+0x2da/0x330 fs/reiserfs/journal.c:3395
Code: ff 4c 89 e7 e8 17 80 b5 ff e9 c0 fd ff ff 4c 89 e7 e8 aa 80 b5 ff e9 01 ff ff ff e8 00 80 b5 ff e9 3a ff ff ff e8 36 5e 67 ff <0f> 0b 41 bc fb ff ff ff e9 ef fe ff ff e8 04 80 b5 ff e9 4c fd ff
RSP: 0018:ffffc9000367fb40 EFLAGS: 00010212
RAX: 0000000000029f05 RBX: 0000000000000000 RCX: ffffc9000f945000
RDX: 0000000000040000 RSI: ffffffff82196b8a RDI: 0000000000000005
RBP: ffffc9000367fbb8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000367fbcc
R13: 0000000000000001 R14: ffff888072d58ef8 R15: ffffc9000367fbb8
FS:  00007f6730b9f700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557391848 CR3: 00000000175c7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reiserfs_truncate_file+0x1c0/0xee0 fs/reiserfs/inode.c:2311
 reiserfs_setattr+0xed3/0x1460 fs/reiserfs/inode.c:3395
 notify_change+0xca7/0x1420 fs/attr.c:482
 do_truncate+0x143/0x200 fs/open.c:65
 do_sys_ftruncate+0x51f/0x710 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f672fe8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6730b9f168 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007f672ffac120 RCX: 00007f672fe8c0d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007f672fee7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe43a9deef R14: 00007f6730b9f300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
