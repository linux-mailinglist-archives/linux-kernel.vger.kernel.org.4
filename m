Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E573268A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbjFPFQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjFPFQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:16:54 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5609B273F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:16:53 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77ac4ec0bb7so30507139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686892612; x=1689484612;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5j/gYo6vg1LSe9UBhqCBkXaJyDKB590MeB3K1NctuuY=;
        b=EOqyRbIZXDVePWJPusqBEav485C1BZMPP51OYD1kDGsMROVEpyG9u6ziMNTQjlhJuf
         dgrAzUMzb+JvkdWJm6wURYvUiya5MbuNTwxemrbSdLHgoI0cS9ZeI/wEcnnC1427HLhn
         exGZNybpEmXnJvwCxXqSkhGTXqdQTGm99ZkktsWwQcrSWiLbtPbVRxwC8AyppO9DNvm2
         4Uk5J95uC1z6Su979C+tHR/RbVZm0wRZvJdLnsGtvdhd+IIXetLgQguM3yyVb/47wr7Q
         ZIR9Y+SDfLdXafiann2NSeiYjgtrMtSOzt9jUccX5WoPoc4qP98QDpV180GMwQ2cFPLd
         E1Bw==
X-Gm-Message-State: AC+VfDy1ot6GSsB4wm/M5DmmhYsqr19jFZIQ1vJ3zIe6ZOR0mfY4fu1P
        p+zDfjkDQQjGP0R+pRxkWd4muybWJ8k7xfkByFjch/Horjk7
X-Google-Smtp-Source: ACHHUZ4YdtYyxfCvD3RDzA7iOrU38uBMuvhpgWw3mOOS09Ww9UUauReyhRkPI9ZtYIhG6fmiDhVWojUr7qXsyyvsjQenbnAceMBi
MIME-Version: 1.0
X-Received: by 2002:a02:9581:0:b0:423:b10:736a with SMTP id
 b1-20020a029581000000b004230b10736amr233780jai.2.1686892612684; Thu, 15 Jun
 2023 22:16:52 -0700 (PDT)
Date:   Thu, 15 Jun 2023 22:16:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4124405fe384ab3@google.com>
Subject: [syzbot] [lsm?] [keyrings?] kernel BUG in assoc_array_insert (3)
From:   syzbot <syzbot+f0d059ae6ba48c088dff@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4c605260bc60 Merge tag 'x86_urgent_for_v6.4_rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c8dcd9280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=f0d059ae6ba48c088dff
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba00476ada42/disk-4c605260.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24e77bf33514/vmlinux-4c605260.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1671769ce82d/bzImage-4c605260.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0d059ae6ba48c088dff@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at lib/assoc_array.c:652!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 895 Comm: kworker/1:2 Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Workqueue: afs afs_manage_cell_work
RIP: 0010:assoc_array_insert_into_terminal_node lib/assoc_array.c:652 [inline]
RIP: 0010:assoc_array_insert+0x2472/0x2eb0 lib/assoc_array.c:1000
Code: c1 ea 03 80 3c 02 00 0f 84 c4 fe ff ff e8 a6 de bf fd e9 ba fe ff ff e8 fc 13 6d fd 0f 0b e8 f5 13 6d fd 0f 0b e8 ee 13 6d fd <0f> 0b e8 e7 13 6d fd 0f 0b e8 e0 13 6d fd 0f 0b 4c 89 ee 48 c7 c7
RSP: 0018:ffffc900049af790 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000009 RCX: 0000000000000000
RDX: ffff88801f531dc0 RSI: ffffffff841732f2 RDI: ffff8880575b1458
RBP: ffff8880575b1490 R08: 0000000000000005 R09: 0000000000000010
R10: 0000000000000010 R11: 0000000000094001 R12: ffff88802acb6c90
R13: 000000000000000f R14: ffff88807badaf01 R15: ffff88807980f000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e321000 CR3: 000000003dd87000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 __key_link_begin+0xf0/0x250 security/keys/keyring.c:1314
 construct_alloc_key security/keys/request_key.c:407 [inline]
 construct_key_and_link security/keys/request_key.c:502 [inline]
 request_key_and_link+0x7f6/0x1340 security/keys/request_key.c:640
 request_key_tag+0x52/0xc0 security/keys/request_key.c:704
 dns_query+0x2ac/0x790 net/dns_resolver/dns_query.c:128
 afs_dns_query+0x126/0x3a0 fs/afs/addr_list.c:249
 afs_update_cell fs/afs/cell.c:404 [inline]
 afs_manage_cell fs/afs/cell.c:771 [inline]
 afs_manage_cell_work+0xa25/0x1290 fs/afs/cell.c:827
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:assoc_array_insert_into_terminal_node lib/assoc_array.c:652 [inline]
RIP: 0010:assoc_array_insert+0x2472/0x2eb0 lib/assoc_array.c:1000
Code: c1 ea 03 80 3c 02 00 0f 84 c4 fe ff ff e8 a6 de bf fd e9 ba fe ff ff e8 fc 13 6d fd 0f 0b e8 f5 13 6d fd 0f 0b e8 ee 13 6d fd <0f> 0b e8 e7 13 6d fd 0f 0b e8 e0 13 6d fd 0f 0b 4c 89 ee 48 c7 c7
RSP: 0018:ffffc900049af790 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000009 RCX: 0000000000000000
RDX: ffff88801f531dc0 RSI: ffffffff841732f2 RDI: ffff8880575b1458
RBP: ffff8880575b1490 R08: 0000000000000005 R09: 0000000000000010
R10: 0000000000000010 R11: 0000000000094001 R12: ffff88802acb6c90
R13: 000000000000000f R14: ffff88807badaf01 R15: ffff88807980f000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb7a79831b8 CR3: 0000000020ac2000 CR4: 0000000000350ee0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
