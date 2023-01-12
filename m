Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A8666F92
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbjALK1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjALKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:25:49 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6819392C7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:20:41 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id s26-20020a5e981a000000b007045ace9e1cso4694619ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4hi1RohH9BsccreIKVvgBIcVAblFjWKdFjZtUvK4oU=;
        b=h4WdLTYDUDF/8OP+JtfmKcZApmgAGYtCT6lbliH6F8ep+qumr3sjVCyLCVJRQBhN/c
         131f2ld2XPir2o1ghcmhg4fY2yo4wu2ij6vtMEzBbYFkSHebaitVgmIVaS7OvFW5pm6i
         oZfom6NFKfUKzuWSsFemSvHmgsdZ+pu8sRC31IreHpJpEtCYTO1OJhOD5sNqyOAC13h1
         XP5TNvC73W2ib32Ys22lBzMafrGbZANyIAVEa4uJcADaPgBE/e+nOhuS3E96pYNGgEox
         YxMVD/S3ujYn6+RR73BPnZQKwHcFvEi7Tq1N437hLPqAdaNKlgfK3eCELiGKbGeGs709
         ydUA==
X-Gm-Message-State: AFqh2kq5BJf6Lq/v+FYtiuvk2n//e9coQdL7Jj+b5Y/HSisQ4akDG87H
        SSS31eTnwl+nf6dGcJ3t3GXDa+Vd+RyNA1kzdd6kNX1vB+ae
X-Google-Smtp-Source: AMrXdXunS+welfar0PF3Q1cTbRJuR0u/n9Vu3yO+PZtoooR9BK02warcPxuX3el3BH9kgKjJLuaGKJWtYjrD/8FaL8A5FjTakv7X
MIME-Version: 1.0
X-Received: by 2002:a5d:8043:0:b0:6e0:bdd:6c9e with SMTP id
 b3-20020a5d8043000000b006e00bdd6c9emr6360591ior.79.1673518841325; Thu, 12 Jan
 2023 02:20:41 -0800 (PST)
Date:   Thu, 12 Jan 2023 02:20:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ff09e05f20e783e@google.com>
Subject: [syzbot] WARNING in __put_task_struct (3)
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

Hello,

syzbot found the following issue on:

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=106064a6480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=394b8403503a77a4aa45
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+394b8403503a77a4aa45@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 19865 at kernel/fork.c:845 __put_task_struct+0x330/0x3d0 kernel/fork.c:845
Modules linked in:
CPU: 0 PID: 19865 Comm: syz-executor.5 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__put_task_struct+0x330/0x3d0 kernel/fork.c:845
Code: 0e 4c 89 e6 e8 f1 3a 85 00 e9 22 ff ff ff e8 c7 aa 37 00 be 03 00 00 00 4c 89 e7 e8 fa 91 bf 02 e9 0b ff ff ff e8 b0 aa 37 00 <0f> 0b e9 1a fd ff ff e8 a4 aa 37 00 0f 0b e9 62 fd ff ff e8 98 aa
RSP: 0018:ffffc900075a78e8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880365dba80 RSI: ffffffff814a1230 RDI: 0000000000000005
RBP: ffff8880365dba80 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880365dbaa8
R13: ffff88807f931000 R14: ffff888144b0d150 R15: ffff888144b0d148
FS:  00007f87872b0700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5a71bde000 CR3: 000000002b805000 CR4: 00000000003506f0
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
RIP: 0033:0x7f878648c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f87872b0218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f87865abf88 RCX: 00007f878648c0c9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f87865abf88
RBP: 00007f87865abf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f87865abf8c
R13: 00007ffdd18e481f R14: 00007f87872b0300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
