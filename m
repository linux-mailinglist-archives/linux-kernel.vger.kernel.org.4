Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468A6645412
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiLGGhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGGhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:37:38 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ACF26D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 22:37:34 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id s1-20020a056e021a0100b003026adad6a9so16313473ild.18
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 22:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLB0Pkd9Nh7NeEoHOWKzVZZxxVBnkb2L55U5FarQQv8=;
        b=dsM62BitJH9wSqPJAflr5+KjyGOD4Nyt5PYzOAj/WWclN62nWqdaIqWEAgi68AVpUU
         4YLH6lgYLbzoHf1ED+Ufy2G059Su7D7X4YCs+8vAuaL9aUhgwgLJPVqqRAbdN2FqYiKU
         lXcsxXemKnG852Fh3eRgEujITp6O0vmKqRKDOr0HL9xiFG12sYjagT0SBZ1OPQydi+yp
         /HKrUjNAkg0JXVKXrcpJsTP+JnNjYFi3xqEpuW3a0o1G3TCW+IvCfoXSU995R+ux2Yj/
         ZMgWJbemBOR9da0OxxwCVeNxFCnetlWB/an7NVvmDCBvnu+SX2+W9Zrv+rJJlMKRStN5
         nUAA==
X-Gm-Message-State: ANoB5pmMQWb/vU2hLiuV73UpEL0SO3PjSSWfvwp8GEjuyC3WmoHSV2SX
        sSik+UdlpwqnabvVD6nVyejlPD3XtF5N5yNjgVjswT15Peoh
X-Google-Smtp-Source: AA0mqf7TgXh5vylvADljQhqHaiwecRdnnuXzSGRvqsKbHwUxxxBnRYDILWnZ1LBovpOHkHsFGBZfJvxVTOJrmpE1AH3DeMLOUPvw
MIME-Version: 1.0
X-Received: by 2002:a92:c852:0:b0:303:4797:d3f9 with SMTP id
 b18-20020a92c852000000b003034797d3f9mr9039874ilq.36.1670395054280; Tue, 06
 Dec 2022 22:37:34 -0800 (PST)
Date:   Tue, 06 Dec 2022 22:37:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d878ce05ef372791@google.com>
Subject: [syzbot] kernel BUG in rxrpc_destroy_all_locals
From:   syzbot <syzbot+e1391a5bf3f779e31237@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
        kuba@kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    15309fb26b87 net: sfp: clean up i2c-bus property parsing
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15431383880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c608c21151db14f2
dashboard link: https://syzkaller.appspot.com/bug?extid=e1391a5bf3f779e31237
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2919f1040d37/disk-15309fb2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2fb3e2516436/vmlinux-15309fb2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5638fcd36798/bzImage-15309fb2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1391a5bf3f779e31237@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at net/rxrpc/local_object.c:438!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4101 Comm: kworker/u4:7 Not tainted 6.1.0-rc7-syzkaller-01817-g15309fb26b87 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: netns cleanup_net
RIP: 0010:rxrpc_destroy_all_locals+0xe8/0x180 net/rxrpc/local_object.c:438
Code: e8 dd bb 98 f8 48 83 eb 20 49 bd 00 00 00 00 00 fc ff df e8 ca bb 98 f8 48 85 db 75 19 e8 c0 bb 98 f8 4c 89 e7 e8 a8 79 0b 01 <0f> 0b 48 89 ef e8 8e 79 e6 f8 eb be e8 a7 bb 98 f8 48 8d 6b 14 be
RSP: 0018:ffffc9000d8a7be0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880295b3a80
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc9000d8a7b28
RBP: ffff8880494f3814 R08: 0000000000000001 R09: ffffc9000d8a7b2f
R10: fffff52001b14f65 R11: 0000000000000000 R12: ffff8880215f42e8
R13: dffffc0000000000 R14: dffffc0000000000 R15: fffffbfff1c2fe10
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb41eed4620 CR3: 0000000027524000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rxrpc_exit_net+0x174/0x300 net/rxrpc/net_ns.c:128
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:169
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:606
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rxrpc_destroy_all_locals+0xe8/0x180 net/rxrpc/local_object.c:438
Code: e8 dd bb 98 f8 48 83 eb 20 49 bd 00 00 00 00 00 fc ff df e8 ca bb 98 f8 48 85 db 75 19 e8 c0 bb 98 f8 4c 89 e7 e8 a8 79 0b 01 <0f> 0b 48 89 ef e8 8e 79 e6 f8 eb be e8 a7 bb 98 f8 48 8d 6b 14 be
RSP: 0018:ffffc9000d8a7be0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880295b3a80
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc9000d8a7b28
RBP: ffff8880494f3814 R08: 0000000000000001 R09: ffffc9000d8a7b2f
R10: fffff52001b14f65 R11: 0000000000000000 R12: ffff8880215f42e8
R13: dffffc0000000000 R14: dffffc0000000000 R15: fffffbfff1c2fe10
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb41eed4620 CR3: 0000000026e44000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
