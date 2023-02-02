Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BE9688206
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjBBP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjBBP1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:27:17 -0500
Received: from mail-io1-xd46.google.com (mail-io1-xd46.google.com [IPv6:2607:f8b0:4864:20::d46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B462791
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:26:44 -0800 (PST)
Received: by mail-io1-xd46.google.com with SMTP id z23-20020a6b6517000000b00718172881acso1286431iob.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:26:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xd2On2XmQn5CXKWHOS6M1UAV/maohIRlixrwDPpvrcY=;
        b=0Ok5bvMPn9HiCXp58llUBOqFZsMnFY1dTGTMmPiwAac+GH6kdlrWOX2aStYqeC5Xow
         AlkedAO9ikXnSQPad8hwlhbT202sb9a+hNRRYMTYGmKLbvRGiku+8KTN1G/uzSr+bnH0
         fmzpWhKZbakZ8pFEffaBwCK7VXPBnpDJG+kY8AUhreWYUI153HhefS+fMbAG7wIB5xyo
         uXhSYDElCdpqlKyQ1y/ZXYlsZYoomVl+i7FUev4jRIOWm7HaDrR+Lpla+IUmTiFV+LWC
         ceNFw1Aw/7J8cLjtK2HMi0Bn2CU57WwDIFZUnadnBLTEzMiF/h8THOVBC5RtRk+TvBnQ
         rf/A==
X-Gm-Message-State: AO0yUKWhkyxCbwLkqYszep5f6EzVUHvxxqIK4vRV5fpfzJiF14YVsYMx
        usOS7XJQcRheNWGWi+C29ZwvAlVgdSdZNosvk1d1HvACi9gR
X-Google-Smtp-Source: AK7set+RSMHIsloLHmsFgFRR06WgZYSviB4PN9lEB99m4iCLWxYAr0lbcJfguHZuV4GIWhuLD8IDxZEXZDY9K4oqeabgMfD9oMxn
MIME-Version: 1.0
X-Received: by 2002:a05:6602:358b:b0:71f:1cc6:e7ed with SMTP id
 bi11-20020a056602358b00b0071f1cc6e7edmr1445809iob.17.1675351539202; Thu, 02
 Feb 2023 07:25:39 -0800 (PST)
Date:   Thu, 02 Feb 2023 07:25:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e400005f3b92d4a@google.com>
Subject: [syzbot] WARNING: locking bug in process_one_work (4)
From:   syzbot <syzbot+adc9fc92128d14593562@syzkaller.appspotmail.com>
To:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c96618275234 Fix up more non-executable files marked execu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152e2ff5480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f11571733ab48ccb
dashboard link: https://syzkaller.appspot.com/bug?extid=adc9fc92128d14593562
compiler:       Debian clang version 13.0.1-6~deb11u1, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fab8705c1650/disk-c9661827.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b70b6b0c4b83/vmlinux-c9661827.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8b23433a6c65/bzImage-c9661827.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adc9fc92128d14593562@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 71 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4729 [inline]
WARNING: CPU: 1 PID: 71 at kernel/locking/lockdep.c:231 __lock_acquire+0xac2/0x1f60 kernel/locking/lockdep.c:5005
Modules linked in:
CPU: 1 PID: 71 Comm: kworker/u4:4 Not tainted 6.2.0-rc5-syzkaller-00205-gc96618275234 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Workqueue: events_unbound call_usermodehelper_exec_work
RIP: 0010:hlock_class kernel/locking/lockdep.c:231 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4729 [inline]
RIP: 0010:__lock_acquire+0xac2/0x1f60 kernel/locking/lockdep.c:5005
Code: 43 0d 00 0f 85 2b fa ff ff 31 db 48 c7 c7 00 98 0d 8b 48 c7 c6 a0 9a 0d 8b 31 c0 e8 58 79 e7 ff 48 ba 00 00 00 00 00 fc ff df <0f> 0b e9 25 fa ff ff e8 52 9d d3 02 85 c0 0f 84 b1 06 00 00 48 c7
RSP: 0018:ffffc900020ff928 EFLAGS: 00010046
RAX: 88e28de359f5bd00 RBX: 0000000000000000 RCX: ffff888018e33a80
RDX: dffffc0000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8170be4d R09: ffffed1017324f5b
R10: ffffed1017324f5b R11: 1ffff11017324f5a R12: 0000000000040000
R13: ffff888018e33a80 R14: 00000000000c1313 R15: ffff888018e34528
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002017f000 CR3: 0000000080fb5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
 complete+0x24/0x1c0 kernel/sched/completion.c:32
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
