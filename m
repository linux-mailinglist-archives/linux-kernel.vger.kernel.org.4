Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954135F1CAE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJAOZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJAOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:25:41 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F704315A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:25:40 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id f4-20020a056e020b4400b002f6681cca5bso5496119ilu.14
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=LUy/tjvgRCWhk1HECUhsa9oaVDHitFE+5z0QHJIJrDk=;
        b=Nd9eqeHz4DFpN7qOQ4kXQ6wJZLPy6eXJZQ5cAsavvFEUudNlw7k7/j8Kt8fUV1JhSq
         AQ9tgGvlziHPXcdP2M9vRS/6Vb11OL/B5VrUJofcIZkBXBXTxMKcmD7K3ywfnK7slsXe
         kcx4/XXjBJZwPKpMjfQqgW7bWb3kqsyu8ARhHCM8y7yGhSUscoaEzAmG/8kGohwzp0KG
         zc6Hb36CS61GdYx3J8+GM46KdQOSndh4yH7XtfqTdc3ggw4Q8zMU3fnBT3s2Jh3Jaci4
         yxgzESS4hIMsar/ofV9s+MDVDJUqLv5mTM5pZNDE1hOsLoUeDryHdy9zreht32N/FvRH
         UOAQ==
X-Gm-Message-State: ACrzQf3Dco2HtCXyuJSmsTVQL2Qa5ZYt8JUAKL+HMG+h94cUZtWCGBgf
        didMtQFxjTD8wVwewljIQubid9AsZNUQyq4VYkkiFhFjunte
X-Google-Smtp-Source: AMsMyM6QKDLIC0PEuC4WQgqNd8jC5wM3xSN89nX9Vre8+QjKAjWbAv3v8+bW8779T+Td2OpQiO7PwTbGNPFGt25H6giu/pZqPCGM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:2f9:253c:d3f3 with SMTP id
 14-20020a056e0216ce00b002f9253cd3f3mr6215809ilx.56.1664634339957; Sat, 01 Oct
 2022 07:25:39 -0700 (PDT)
Date:   Sat, 01 Oct 2022 07:25:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000839ff805e9f9e286@google.com>
Subject: [syzbot] general protection fault in do_xmote
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

Hello,

syzbot found the following issue on:

HEAD commit:    c3e0e1e23c70 Merge tag 'irq_urgent_for_v6.0' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11664a70880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
dashboard link: https://syzkaller.appspot.com/bug?extid=ececff266234ba40fe13
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ececff266234ba40fe13@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000097: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000004b8-0x00000000000004bf]
CPU: 2 PID: 70 Comm: kworker/2:1H Not tainted 6.0.0-rc7-syzkaller-00081-gc3e0e1e23c70 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: glock_workqueue glock_work_func
RIP: 0010:is_system_glock fs/gfs2/glock.c:720 [inline]
RIP: 0010:do_xmote+0x492/0xc40 fs/gfs2/glock.c:828
Code: 03 80 3c 02 00 0f 85 2f 07 00 00 4d 8b ad 18 07 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d bd b8 04 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ed 06 00 00 49 3b ad b8 04 00 00 0f 84 77 05 00
RSP: 0018:ffffc90000aa7c50 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888027624000 RCX: 0000000000000000
RDX: 0000000000000097 RSI: ffffffff8381e370 RDI: 00000000000004b8
RBP: ffff888074ceea90 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888074ceeaf8 R15: ffff888074ceeab0
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000990140 CR3: 0000000076461000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 run_queue+0x3cf/0x660 fs/gfs2/glock.c:893
 glock_work_func+0xbe/0x3a0 fs/gfs2/glock.c:1059
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:is_system_glock fs/gfs2/glock.c:720 [inline]
RIP: 0010:do_xmote+0x492/0xc40 fs/gfs2/glock.c:828
Code: 03 80 3c 02 00 0f 85 2f 07 00 00 4d 8b ad 18 07 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d bd b8 04 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ed 06 00 00 49 3b ad b8 04 00 00 0f 84 77 05 00
RSP: 0018:ffffc90000aa7c50 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888027624000 RCX: 0000000000000000
RDX: 0000000000000097 RSI: ffffffff8381e370 RDI: 00000000000004b8
RBP: ffff888074ceea90 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff888074ceeaf8 R15: ffff888074ceeab0
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000990140 CR3: 0000000076461000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 2f 07 00 00    	jne    0x739
   a:	4d 8b ad 18 07 00 00 	mov    0x718(%r13),%r13
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	49 8d bd b8 04 00 00 	lea    0x4b8(%r13),%rdi
  22:	48 89 fa             	mov    %rdi,%rdx
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 ed 06 00 00    	jne    0x720
  33:	49 3b ad b8 04 00 00 	cmp    0x4b8(%r13),%rbp
  3a:	0f                   	.byte 0xf
  3b:	84 77 05             	test   %dh,0x5(%rdi)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
