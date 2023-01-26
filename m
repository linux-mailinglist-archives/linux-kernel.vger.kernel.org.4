Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442C267D857
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbjAZW15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjAZW1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:27:54 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200057698
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:27:52 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id z19-20020a056602205300b0070756e30008so1737300iod.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:27:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7hjOlddiOxqdHgHgdLYxOVdX5juPyt+zxhAK5C1hyE=;
        b=OI/h6egZvQRjWhVQM4iE1d/FBcysFdvUjUqPuc+nQ5nCwcbxmY/Tju5LATcqoSnyqC
         u6sOL5zgh47tucmeTLdKuzDddIU1mFMzf+9E8VJlRkYqPqm8KGHZLadMarhTmjhHe53B
         37wpNt7Y/W4rm0fVeFPVFte+fBcFzxgQrY21unHZ+/dW68luPl0/6yw9Wn49DfLfrWZc
         LlTxgvD7NcbgwOkBGldY0+7tjAaJaO6JaWoFlXce2T6yu4rP6M8sygqKqGIu5ILU7D0q
         YZiuNfI9T01o4w6t7PaV+2sKakhzh6qFJw1IfpANVK9LE3+Yt77vP+GOmXpOSIRU+6IM
         cYxw==
X-Gm-Message-State: AFqh2krVdDt9IJAPdhtzzxkdObMWvFUtxV5axv+Iwiozl2Oo01Lunt2d
        cNz7SXbJRVGMP/tgchxoyqlJr0prOmnv3BRokoKZl8V32caG
X-Google-Smtp-Source: AMrXdXvb2DUqf3i3GfcENyefXSJxhi7AYOzpihbJ0uO0iOK7AhK+d/X23ixwMoqyJRW9B2aAp4bwRkJLz+vEkjSM6AsF5PeAATQt
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4497:b0:3a3:2315:cb31 with SMTP id
 bv23-20020a056638449700b003a32315cb31mr5170520jab.190.1674772071444; Thu, 26
 Jan 2023 14:27:51 -0800 (PST)
Date:   Thu, 26 Jan 2023 14:27:51 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065f83305f3324254@google.com>
Subject: [syzbot] WARNING: locking bug in umh_complete
From:   syzbot <syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    71ab9c3e2253 net: fix UaF in netns ops registration error ..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10f86a56480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=899d86a7610a0ea0
dashboard link: https://syzkaller.appspot.com/bug?extid=6cd18e123583550cf469
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54c953096fdb/disk-71ab9c3e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/644d72265810/vmlinux-71ab9c3e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/16e994579ca5/bzImage-71ab9c3e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cd18e123583550cf469@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 0 PID: 46 at kernel/locking/lockdep.c:231 hlock_class kernel/locking/lockdep.c:231 [inline]
WARNING: CPU: 0 PID: 46 at kernel/locking/lockdep.c:231 hlock_class kernel/locking/lockdep.c:220 [inline]
WARNING: CPU: 0 PID: 46 at kernel/locking/lockdep.c:231 check_wait_context kernel/locking/lockdep.c:4729 [inline]
WARNING: CPU: 0 PID: 46 at kernel/locking/lockdep.c:231 __lock_acquire+0x13ae/0x56d0 kernel/locking/lockdep.c:5005
Modules linked in:
CPU: 0 PID: 46 Comm: kworker/u4:3 Not tainted 6.2.0-rc4-syzkaller-00191-g71ab9c3e2253 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Workqueue: events_unbound call_usermodehelper_exec_work
RIP: 0010:hlock_class kernel/locking/lockdep.c:231 [inline]
RIP: 0010:hlock_class kernel/locking/lockdep.c:220 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4729 [inline]
RIP: 0010:__lock_acquire+0x13ae/0x56d0 kernel/locking/lockdep.c:5005
Code: 08 84 d2 0f 85 56 41 00 00 8b 15 55 7b 0f 0d 85 d2 0f 85 d5 fd ff ff 48 c7 c6 c0 51 4c 8a 48 c7 c7 20 4b 4c 8a e8 92 e1 5b 08 <0f> 0b 31 ed e9 50 f0 ff ff 48 c7 c0 a8 2b 73 8e 48 ba 00 00 00 00
RSP: 0018:ffffc90000b77a30 EFLAGS: 00010082
RAX: 0000000000000000 RBX: ffff88801272a778 RCX: 0000000000000000
RDX: ffff888012729d40 RSI: ffffffff8166822c RDI: fffff5200016ef38
RBP: 0000000000001b2c R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000001 R11: 0000000000000001 R12: ffff88801272a7c8
R13: ffff888012729d40 R14: ffffc9000397fb28 R15: 0000000000040000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa5a95e81d0 CR3: 00000000284d2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 complete+0x1d/0x1f0 kernel/sched/completion.c:32
 umh_complete+0x32/0x90 kernel/umh.c:59
 call_usermodehelper_exec_sync kernel/umh.c:144 [inline]
 call_usermodehelper_exec_work+0x115/0x180 kernel/umh.c:167
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
