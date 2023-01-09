Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB74662C6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbjAIRPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbjAIRP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:15:27 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51BE19C1F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:14:42 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id 16-20020a5d9c10000000b00702de2ee669so4657745ioe.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 09:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1oGlPuHW58qF3L0UOY+vcORXMzYpH0psnmT6FGtAszg=;
        b=vyRuOtMyREsJs0McMT4sdnz7/8Pye7FWlYPHufA+HvWawXrM8FHqqjIZ240WUpknDY
         oLAHvkMo7yNWTNrLsRkaM+8ga5sPvM60ZvrE5NRqe8tUa7Avhr3RoD2u4o94Y/U1kZWg
         TT+FlH9cPiGjQoPkDikyrsLZa0CQKtRBag/1WQLzbcp7C/PF89SIz7MNEp+kgrAE5d55
         KamfwkkjtB3j0uoYo4cyGcBjQJ0kP4+PamVWA4/xmFD/zG2iy2vI1+qH669GZiu/mgcg
         tp7otMU5WRHf5xf+hPC2JKgOyay55zT/LQQd8q4BZR4r1edt9v7Li3KXcdLkNCs1+Nfe
         2orw==
X-Gm-Message-State: AFqh2kpul/DQR8uv1yVLWAm9G0Yl6b3kFL5xwvSHbDAzjVzvarmLO5v1
        vJuDOIa60BQssF6oKzWDQqujYeW8zyCUQfZOMgM4zMeNcvbD
X-Google-Smtp-Source: AMrXdXt68JUNpwYJfz7IuMX4B3V+rbFNsudid2OwfVeGVGNniP0ALunhW/R2JjgVTNEeZnNyy5vdJ00a6gDBEtrFdAFtWf3vK3P8
MIME-Version: 1.0
X-Received: by 2002:a02:23c5:0:b0:38a:590c:f742 with SMTP id
 u188-20020a0223c5000000b0038a590cf742mr5927517jau.201.1673284480814; Mon, 09
 Jan 2023 09:14:40 -0800 (PST)
Date:   Mon, 09 Jan 2023 09:14:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016552c05f1d7e734@google.com>
Subject: [syzbot] [tmpfs?] WARNING in shmem_evict_inode
From:   syzbot <syzbot+3d4aa0d3e784b29b1520@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

HEAD commit:    41c03ba9beea Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12fa0b4c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46221e8203c7aca6
dashboard link: https://syzkaller.appspot.com/bug?extid=3d4aa0d3e784b29b1520
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/029f81c97447/disk-41c03ba9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02b0f933f93e/vmlinux-41c03ba9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa82b725810f/bzImage-41c03ba9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d4aa0d3e784b29b1520@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1301 at mm/shmem.c:1175 shmem_evict_inode+0x873/0xb60 mm/shmem.c:1175
Modules linked in:
CPU: 0 PID: 1301 Comm: syz-executor.5 Not tainted 6.2.0-rc2-syzkaller-00057-g41c03ba9beea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:shmem_evict_inode+0x873/0xb60 mm/shmem.c:1175
Code: 89 fe e8 50 2b cd ff 45 85 ff 75 ab e8 96 2e cd ff 48 8b 74 24 18 48 8b 7c 24 20 e8 b7 41 ac ff e9 fc fd ff ff e8 7d 2e cd ff <0f> 0b e9 a0 f8 ff ff e8 71 2e cd ff 4c 89 ea 48 b8 00 00 00 00 00
RSP: 0018:ffffc90000107830 EFLAGS: 00010293
RAX: 0000000000000000 RBX: fffffffffffffda0 RCX: 0000000000000000
RDX: ffff88807e8d57c0 RSI: ffffffff81b423e3 RDI: 0000000000000007
RBP: ffffc90000107928 R08: 0000000000000007 R09: 0000000000000000
R10: fffffffffffffda0 R11: 0000000000000000 R12: ffff88803073b378
R13: ffff88803073b3c8 R14: ffff88803073b2a8 R15: ffff88803073b2b8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f734d1b0 CR3: 0000000050492000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x59b/0x880 fs/inode.c:1773
 iput+0x5c/0x80 fs/inode.c:1763
 dentry_unlink_inode+0x2b1/0x460 fs/dcache.c:401
 __dentry_kill+0x3c0/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x80a/0xdb0 fs/dcache.c:913
 __fput+0x3cc/0xa90 fs/file_table.c:328
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xaa8/0x2950 kernel/exit.c:867
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 get_signal+0x21c3/0x2450 kernel/signal.c:2859
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 __do_fast_syscall_32+0x72/0xf0 arch/x86/entry/common.c:181
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fd3549
Code: Unable to access opcode bytes at 0xf7fd351f.
RSP: 002b:00000000f7fad5cc EFLAGS: 00000296 ORIG_RAX: 0000000000000004
RAX: 000000000001b000 RBX: 0000000000000006 RCX: 00000000200009c0
RDX: 00000000fffffd9d RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
