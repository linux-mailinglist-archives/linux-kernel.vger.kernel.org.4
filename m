Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F67C64B45C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiLMLml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiLMLmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:42:39 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA85395
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:42:37 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id o15-20020a6bf80f000000b006de313e5cfeso1697528ioh.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nzcefoxpg77f8NRJkj+YK7P0MI1lkm4SAhWKpjm0eRA=;
        b=eY0RQjjscLmSn0A3B032m65SbmlLFYDg2vxuXTvnuhc3+4vCgXFZHOQG6jAr/G7k4U
         u8ik+cBruY3yXBMiDjsy/mk/5p1d2XrzHlYCuIW3Y20ZOIbVBPaYY34mbc8JZn9EF9Y8
         ZOXTLY/5FMnIU2J4KhmgAbUaHeiDlhy7vshmdlxEaVN8xk0KcHdn3Hb7EOh8GOPPrNRg
         Xg1p8oUaBJ3vjoUeCHAP4wjbG7Uk1gR4n9YJmCqIcW9RQ5Lukamt90zmcQnenqzgfJGO
         m2gynhSqLN5RqjvV8R2rq1PaIG77iE6K17MHmE9dbDyTNhn3YO2/RYqQ9u5RkW/aFdyg
         ymOA==
X-Gm-Message-State: ANoB5pkjQdUITKHhHinNCheDNDaEP+RhUljTB+7u6mXifDdLiEVIgoS4
        55/xwxI+KXMbB7f7DC8hspt2dd+5+4afu8YOtALfXJxUNk07
X-Google-Smtp-Source: AA0mqf6pWHrieU2RXJM1g31rjSEXEFbmUh7tFyfL9gEtfq7Vz9eE+FxGQKfblbb5LNXMIi5O23gZQ98OEUJOqZmxjBHfCW6X4JS9
MIME-Version: 1.0
X-Received: by 2002:a6b:d117:0:b0:6a3:a0cf:ea32 with SMTP id
 l23-20020a6bd117000000b006a3a0cfea32mr37861276iob.155.1670931757069; Tue, 13
 Dec 2022 03:42:37 -0800 (PST)
Date:   Tue, 13 Dec 2022 03:42:37 -0800
In-Reply-To: <000000000000839ff805e9f9e286@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2fe7205efb41d2c@google.com>
Subject: Re: [syzbot] general protection fault in do_xmote
From:   syzbot <syzbot+ececff266234ba40fe13@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    764822972d64 Merge tag 'nfsd-6.2' of git://git.kernel.org/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1428fb0b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c59170b68d26a55
dashboard link: https://syzkaller.appspot.com/bug?extid=ececff266234ba40fe13
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ce69c0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1016950b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c840c19749d/disk-76482297.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdfd51618ae0/vmlinux-76482297.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fef17b5d4d6d/bzImage-76482297.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a114b1cb5db6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ececff266234ba40fe13@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000097: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000004b8-0x00000000000004bf]
CPU: 1 PID: 1273 Comm: kworker/1:1H Not tainted 6.1.0-syzkaller-03225-g764822972d64 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: glock_workqueue glock_work_func
RIP: 0010:is_system_glock fs/gfs2/glock.c:725 [inline]
RIP: 0010:do_xmote+0xdde/0x13d0 fs/gfs2/glock.c:835
Code: 00 48 03 5d 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 91 e1 27 fe bd b8 04 00 00 48 03 2b 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 73 e1 27 fe 4c 8b 64 24 08 4c 39
RSP: 0018:ffffc900061a7b70 EFLAGS: 00010202
RAX: 0000000000000097 RBX: ffff888021dd8718 RCX: ffff888021c93a80
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000000000000
RBP: 00000000000004b8 R08: ffffffff83b7d986 R09: ffffed10043bb016
R10: ffffed10043bb016 R11: 1ffff110043bb015 R12: ffff888075bf0548
R13: 0000000000000818 R14: dffffc0000000000 R15: ffff888021dd8000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002080 CR3: 000000007a61b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 glock_work_func+0x2c2/0x450 fs/gfs2/glock.c:1082
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:is_system_glock fs/gfs2/glock.c:725 [inline]
RIP: 0010:do_xmote+0xdde/0x13d0 fs/gfs2/glock.c:835
Code: 00 48 03 5d 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 91 e1 27 fe bd b8 04 00 00 48 03 2b 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 ef e8 73 e1 27 fe 4c 8b 64 24 08 4c 39
RSP: 0018:ffffc900061a7b70 EFLAGS: 00010202
RAX: 0000000000000097 RBX: ffff888021dd8718 RCX: ffff888021c93a80
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000000000000
RBP: 00000000000004b8 R08: ffffffff83b7d986 R09: ffffed10043bb016
R10: ffffed10043bb016 R11: 1ffff110043bb015 R12: ffff888075bf0548
R13: 0000000000000818 R14: dffffc0000000000 R15: ffff888021dd8000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002080 CR3: 000000007e6e4000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 48 03             	add    %cl,0x3(%rax)
   3:	5d                   	pop    %rbp
   4:	00 48 89             	add    %cl,-0x77(%rax)
   7:	d8 48 c1             	fmuls  -0x3f(%rax)
   a:	e8 03 42 80 3c       	callq  0x3c804212
   f:	30 00                	xor    %al,(%rax)
  11:	74 08                	je     0x1b
  13:	48 89 df             	mov    %rbx,%rdi
  16:	e8 91 e1 27 fe       	callq  0xfe27e1ac
  1b:	bd b8 04 00 00       	mov    $0x4b8,%ebp
  20:	48 03 2b             	add    (%rbx),%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 73 e1 27 fe       	callq  0xfe27e1ac
  39:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
  3e:	4c                   	rex.WR
  3f:	39                   	.byte 0x39

