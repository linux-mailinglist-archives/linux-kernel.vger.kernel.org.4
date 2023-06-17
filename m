Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669E1733FA1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbjFQI2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjFQI2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:28:05 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70BA10CF
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:28:03 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77b25d256aaso155372039f.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686990483; x=1689582483;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvzkMc9H5Qu3CfLh6Ayp0HxbA/K5f7RFDZ+Yf/cv0ic=;
        b=Koeq4+G41m4ftdcI/vPoS/6GNoYsdJpy8FkYLm5gAHIuhe8hbdbiDIxClPmb9s9AI+
         h1Oz/ML1iS5v3lZF1SDDR91/6D6kw+D474WWWizJ5Jmc/VfN29a5w/PWxRimBe1gljFN
         3+hGDtUGHoIfpK20bRiRY2qLskeJ8/YJk1xeYUpH+znUn0tadu051Q8IN9ZAoeXX4SYG
         wKwwzOcaGW3moYtrcqhv7FjjqjkbBH/T8ZHQ3cFPMasaX89VAaJ7s0UrQA/ds/WaqfTB
         vof3HZ+hQxAtCMW0vNUWN8CEEaRV+VtZtlmv6GYCuDGESxRr4I3SxU4+jTYgUE/BLWZA
         n0Zg==
X-Gm-Message-State: AC+VfDxarzx32rbWuebDAFsyzy3QcIpTsu64coRYao/w9OYlnhauq01Z
        LiGLt5QafiJQhi2TRhuiK70Kf/G/dBCTRzh8S0corulG//NU
X-Google-Smtp-Source: ACHHUZ5VaKdxrt3XJL1Kd65bRkQ2/NqG1BaMZjE2EcapUA6Ieh2QN2UA7P+X2TjTaXSFIL6Mdt7XLUorkRhe6kEevEIAHB1f4hC4
MIME-Version: 1.0
X-Received: by 2002:a5e:860f:0:b0:774:8e68:1ce6 with SMTP id
 z15-20020a5e860f000000b007748e681ce6mr1098962ioj.3.1686990483134; Sat, 17 Jun
 2023 01:28:03 -0700 (PDT)
Date:   Sat, 17 Jun 2023 01:28:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ca70405fe4f149a@google.com>
Subject: [syzbot] [block?] WARNING in blkdev_put (3)
From:   syzbot <syzbot+04625c80899f4555de39@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f7efed9f38f8 Add linux-next specific files for 20230616
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12240d17280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
dashboard link: https://syzkaller.appspot.com/bug?extid=04625c80899f4555de39
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11bc386b280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bbc85b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95bcbee03439/disk-f7efed9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fd295caa4de/vmlinux-f7efed9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69c038a34b5f/bzImage-f7efed9f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b37a2f98c970/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04625c80899f4555de39@syzkaller.appspotmail.com

REISERFS (device loop0): journal params: device loop0, size 512, journal first block 18, max trans len 256, max batch 225, max commit age 30, max trans age 30
REISERFS (device loop0): checking transaction log (loop0)
REISERFS (device loop0): Using r5 hash to sort names
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5034 at block/bdev.c:617 bd_end_claim block/bdev.c:617 [inline]
WARNING: CPU: 1 PID: 5034 at block/bdev.c:617 blkdev_put+0x562/0x8a0 block/bdev.c:901
Modules linked in:
CPU: 1 PID: 5034 Comm: syz-executor379 Not tainted 6.4.0-rc6-next-20230616-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:bd_end_claim block/bdev.c:617 [inline]
RIP: 0010:blkdev_put+0x562/0x8a0 block/bdev.c:901
Code: c0 74 08 3c 03 0f 8e 23 03 00 00 41 83 ac 24 f0 04 00 00 01 e9 2b fe ff ff e8 1a 39 90 fd 0f 0b e9 4b fc ff ff e8 0e 39 90 fd <0f> 0b e9 e0 fb ff ff e8 02 39 90 fd 4c 8d ab a8 00 00 00 31 f6 4c
RSP: 0018:ffffc90003b5fa28 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888148c8c500 RCX: 0000000000000000
RDX: ffff888025959dc0 RSI: ffffffff83f42912 RDI: 0000000000000001
RBP: ffff88801f459000 R08: 0000000000000000 R09: fffffbfff1d53172
R10: ffffffff8ea98b97 R11: 0000000000000003 R12: ffff888148c8c538
R13: ffffc90003b81000 R14: ffff88801f459460 R15: ffff888148c8c500
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f42f1a5f140 CR3: 000000000c775000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 release_journal_dev fs/reiserfs/journal.c:2592 [inline]
 free_journal_ram+0x421/0x5c0 fs/reiserfs/journal.c:1896
 do_journal_release fs/reiserfs/journal.c:1960 [inline]
 journal_release+0x276/0x630 fs/reiserfs/journal.c:1971
 reiserfs_put_super+0xe4/0x5c0 fs/reiserfs/super.c:616
 generic_shutdown_super+0x158/0x480 fs/super.c:499
 kill_block_super+0x64/0xb0 fs/super.c:1422
 deactivate_locked_super+0x98/0x160 fs/super.c:330
 deactivate_super+0xb1/0xd0 fs/super.c:361
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1247
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xadc/0x2a30 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f42f19ea9c9
Code: Unable to access opcode bytes at 0x7f42f19ea99f.
RSP: 002b:00007fffc2761718 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f42f1a61330 RCX: 00007f42f19ea9c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 0000000000001111
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f42f1a61330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
