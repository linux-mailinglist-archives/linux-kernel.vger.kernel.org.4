Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010E6714C15
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjE2Obf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2ObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:31:14 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A4A0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:31:12 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-33832662ba5so44152325ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 07:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370672; x=1687962672;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kcy6OuZtdRNwc/jzZDtZWOVoC4LwS2/1EIUPcPzZysk=;
        b=SqQzXpO1+1tdOlc1ux1rDNg+Rs7lFQyr8tS02Zo4qEtpor2F31q/+vMRQCpVwPSYMF
         OpZ2hreh0ZDAxmxqX8SrKLPt3kgYHWIPFgCcKUIKq3Qia67Zww25weeMsGryPc45fZMT
         +TatEAFDgowtLCjpraa1omgRXzQvRSNeF3rSSpEsFamxD6Itaa6NSktInbeY5QX3N60h
         T5w2LELf1Dj9XxWwZVchgubBnzM7l6s7SUL9E3Ud0Ed7ekU9QedKWuiPIOInXbpvX58A
         ez0K8Yu9s6OznsgK7zI8KbUrbR/B0D0WMxcHZS3gtj4rS+IpDOJ3TDsBb8aKHWXd2ZFH
         jYMA==
X-Gm-Message-State: AC+VfDweHPQj8nwQ6bz3VHZdXJaK2k0YqQmJAvFyJNaTx1PfeflX19Hc
        CwJ8Vm3JmPTuNbIgTpXmjhIjLBdkvTDYcp8kPUGuBj8pNNa70BH/pw==
X-Google-Smtp-Source: ACHHUZ7lqWN311dhhLfep6MLf69vWKCEyseYLBgHu90x/JmTpUCVg23pab3eJziJ+Bbe0EcCDycv6evADt9GUBH7HP4FQQd7dxQv
MIME-Version: 1.0
X-Received: by 2002:a92:d392:0:b0:331:2a69:96f9 with SMTP id
 o18-20020a92d392000000b003312a6996f9mr3156984ilo.2.1685370672129; Mon, 29 May
 2023 07:31:12 -0700 (PDT)
Date:   Mon, 29 May 2023 07:31:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a2f8505fcd5f06b@google.com>
Subject: [syzbot] [kernel?] WARNING: ODEBUG bug in __mod_timer
From:   syzbot <syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Hello,

syzbot found the following issue on:

HEAD commit:    44bf136283e5 Add linux-next specific files for 20230420
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1026a757c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba413c0527139246
dashboard link: https://syzkaller.appspot.com/bug?extid=7937ba6a50bdd00fffdf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/db069eb0e403/disk-44bf1362.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f9f4ca6cfb8/vmlinux-44bf1362.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e53d01b894f7/bzImage-44bf1362.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7937ba6a50bdd00fffdf@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 5171 at lib/debugobjects.c:505 debug_print_object+0x194/0x2c0 lib/debugobjects.c:505
Modules linked in:
CPU: 1 PID: 5171 Comm: kworker/1:5 Not tainted 6.3.0-rc7-next-20230420-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: rcu_gp wait_rcu_exp_gp
RIP: 0010:debug_print_object+0x194/0x2c0 lib/debugobjects.c:505
Code: df 48 89 fe 48 c1 ee 03 80 3c 16 00 0f 85 c7 00 00 00 48 8b 14 dd c0 0f a7 8a 50 4c 89 ee 48 c7 c7 80 03 a7 8a e8 7c ec 35 fd <0f> 0b 58 83 05 86 75 63 0a 01 48 83 c4 20 5b 5d 41 5c 41 5d 41 5e
RSP: 0018:ffffc900056af890 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: ffff88801e71d7c0 RSI: ffffffff814be0c7 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff8a4ecb40
R13: ffffffff8aa70a60 R14: ffffc900056af950 R15: ffffffff817267d0
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020404030 CR3: 000000002bc8b000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_assert_init+0x20f/0x310 lib/debugobjects.c:912
 debug_timer_assert_init kernel/time/timer.c:792 [inline]
 debug_assert_init kernel/time/timer.c:837 [inline]
 __mod_timer+0x9b/0xe80 kernel/time/timer.c:1020
 schedule_timeout+0x149/0x2b0 kernel/time/timer.c:2166
 synchronize_rcu_expedited_wait_once kernel/rcu/tree_exp.h:572 [inline]
 synchronize_rcu_expedited_wait kernel/rcu/tree_exp.h:624 [inline]
 rcu_exp_wait_wake+0x2ae/0x1550 kernel/rcu/tree_exp.h:693
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


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
