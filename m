Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35965668425
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjALUog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjALUnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:43:15 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8686777AF1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:12:39 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so14261025ilj.14
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:12:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EftGUsNsjfT7RQtoyk/uc6bwdnvcX05Q647H15WFPkg=;
        b=ccrEP86Z6czTaOVmqNHuO/BF0oekjNFibkH/qvfJj7/V7q/34RFo5Eb0jCz8/LM1Yv
         /j/1Ed4gcehcGLls+uz3tDls513yxW8g20TgH/t+LjgPoZlhgbi6TyVB7HK59yV63sP1
         dq0GnIRa+lVqWmOQ5/nUd5R3LOrcX0Q8OyNY0BO76OUz1OVyWSd2iaxxD8OzgVKc6OiG
         LqJdQZ83rxt4qsEhERA+xtH8VXg3gmGE2Ijyb2oCreSs9nIvGjKUF0yeejwLjfHlulQx
         Rd4F0umuvk/IOAhxlvlOWhhiMmX6QRQHYAKiB7fPjBbIbnARQDfh3dWnxWj2/7tElRHH
         u+9g==
X-Gm-Message-State: AFqh2krlg78i0XYV/t9+hteduzhpDR/p25pBx9hIkJweZl7H0uFF9mAZ
        VHbxcks4JmltSJJ8mX26ur0USttV4iZgzJ79Djv+zldgMiA6
X-Google-Smtp-Source: AMrXdXsaLdEYVuPBDT+QN4YI4pNAA070sYITL1ytzWSDsa+MVChijIzgNgFFWuxfGmOWL6mcPku+kDCp4e3rLkxHqHZpIW4KkJfU
MIME-Version: 1.0
X-Received: by 2002:a92:d24e:0:b0:30d:a2e8:2301 with SMTP id
 v14-20020a92d24e000000b0030da2e82301mr2470433ilg.231.1673554358422; Thu, 12
 Jan 2023 12:12:38 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:12:38 -0800
In-Reply-To: <0000000000000ff09e05f20e783e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bd3bc05f216bd1b@google.com>
Subject: Re: [syzbot] WARNING in __put_task_struct (3)
From:   syzbot <syzbot+394b8403503a77a4aa45@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=112ca00e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=394b8403503a77a4aa45
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c34e86480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103a000e480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+394b8403503a77a4aa45@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5070 at kernel/fork.c:845 __put_task_struct+0x330/0x3d0 kernel/fork.c:845
Modules linked in:
CPU: 0 PID: 5070 Comm: syz-executor239 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__put_task_struct+0x330/0x3d0 kernel/fork.c:845
Code: 0e 4c 89 e6 e8 f1 3a 85 00 e9 22 ff ff ff e8 c7 aa 37 00 be 03 00 00 00 4c 89 e7 e8 fa 91 bf 02 e9 0b ff ff ff e8 b0 aa 37 00 <0f> 0b e9 1a fd ff ff e8 a4 aa 37 00 0f 0b e9 62 fd ff ff e8 98 aa
RSP: 0018:ffffc90003c0f8e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801e819d40 RSI: ffffffff814a1230 RDI: 0000000000000005
RBP: ffff88801e819d40 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801e819d68
R13: ffff888146dadc00 R14: ffff888149d0f150 R15: ffff888149d0f148
FS:  0000555555e76300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c456f42840 CR3: 0000000027d03000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 put_task_struct include/linux/sched/task.h:119 [inline]
 io_wq_exit_workers io_uring/io-wq.c:1266 [inline]
 io_wq_put_and_exit+0xb47/0xd80 io_uring/io-wq.c:1294
 io_uring_clean_tctx+0x117/0x178 io_uring/tctx.c:193
 io_uring_cancel_generic+0x5ae/0x606 io_uring/io_uring.c:3229
 io_uring_files_cancel include/linux/io_uring.h:55 [inline]
 do_exit+0x522/0x2a90 kernel/exit.c:822
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 get_signal+0x225f/0x24f0 kernel/signal.c:2859
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f721ce0f219
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe04029958 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000004 RCX: 00007f721ce0f219
RDX: 0000000000002020 RSI: 00000000200021c0 RDI: 0000000000000006
RBP: 0000000000000000 R08: 00007ffe04029af8 R09: 00007ffe04029af8
R10: 000000000000000d R11: 0000000000000246 R12: 00007f721cdd2810
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

