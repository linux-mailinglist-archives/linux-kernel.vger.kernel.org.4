Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C28F642A33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 15:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiLEOTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 09:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbiLEOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 09:19:44 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1235D13DF5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:19:43 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i7-20020a056e021b0700b003033a763270so10866154ilv.19
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 06:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/8Jk8KOOFBxQyZWRhL6bo/qrStKvX/xfP+IaTpaySrc=;
        b=owuF5B24w86NVmD+WgkFmN+4cbTQ0RErmZ6y/YBtzezmK9wmstnuINHaPRFwqvXFAG
         8O/TkA9ZwlcCDH+Ju8zT97aJUySxAm39U7YN0j5Ihf5rtZEPWPyTzPjTTjtOgCEEf9vW
         I2CpOcEaq16MpHKZ6u4hWliT2YIC/BS0FO/Kg/OlRAlOivwx7VEvJt7yPxRRNsyVB04E
         2hezW7OrBU6q/wmkhocSggnkqpHAxq80LBx9FsEGi0dUz8AGl6j7gsjirxNmCRbWAqKC
         4vflJGYs8ssaKVUObOjfiBxU74eIHaRn9oHlffoY4OsOYjXBxYaBoCfOFcMWayBKrXc8
         kP3w==
X-Gm-Message-State: ANoB5pk/iJuCp3oHXRRrQ0dVoeTf28xD10FRfAfgxvAzbiiAPWC3cNDo
        7ZoHG8GKEOXArYYWhJ/xm2IRufBND4SMMZbUMhRTUrAvOCyV
X-Google-Smtp-Source: AA0mqf6nJfXe1VS1PVIyKS0X/i2Qm5cE4J7MVXPFd+/DAvBa0aMgqaJDYbQ0rkWZULR2oqOK7DDJsoSqjaxIlovg/tVXWn/TPHGR
MIME-Version: 1.0
X-Received: by 2002:a02:2206:0:b0:371:d6e:c33a with SMTP id
 o6-20020a022206000000b003710d6ec33amr38687666jao.204.1670249982365; Mon, 05
 Dec 2022 06:19:42 -0800 (PST)
Date:   Mon, 05 Dec 2022 06:19:42 -0800
In-Reply-To: <0000000000007f649605ee57c509@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e29cae05ef1560ab@google.com>
Subject: Re: [syzbot] WARNING in diUnmount
From:   syzbot <syzbot+47366a6b503c7edf6bbb@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        okanatov@gmail.com, shaggy@kernel.org,
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

HEAD commit:    9e46a7996732 Add linux-next specific files for 20221125
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17e16583880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e19c740a0b2926
dashboard link: https://syzkaller.appspot.com/bug?extid=47366a6b503c7edf6bbb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12170129880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d77d6b880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/758d818cf966/disk-9e46a799.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7c8696b40a5/vmlinux-9e46a799.xz
kernel image: https://storage.googleapis.com/syzbot-assets/810f9750b87f/bzImage-9e46a799.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/87349f941ac3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47366a6b503c7edf6bbb@syzkaller.appspotmail.com

R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
jfs_mount_rw: diMount failed!
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5299 at mm/slab_common.c:923 mod_lruvec_page_state include/linux/vmstat.h:563 [inline]
WARNING: CPU: 1 PID: 5299 at mm/slab_common.c:923 free_large_kmalloc+0xad/0xe0 mm/slab_common.c:930
Modules linked in:
CPU: 1 PID: 5299 Comm: syz-executor293 Not tainted 6.1.0-rc6-next-20221125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:free_large_kmalloc+0xad/0xe0 mm/slab_common.c:923
Code: ee 48 89 ef 5d 41 5c 41 5d e9 cf bd 0d 00 e8 3a 22 d1 ff 44 89 e2 be 06 00 00 00 48 89 ef e8 2a fc 1f 00 e8 95 23 d1 ff eb c6 <0f> 0b 80 3d 06 a4 a6 0c 00 0f 84 e5 75 0b 08 48 8b 74 24 20 4c 89
RSP: 0018:ffffc90003dafbc8 EFLAGS: 00010246
RAX: 00fff00000000000 RBX: ffff8880765b2930 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88801d468000 RDI: ffffea0000751a00
RBP: ffffea0000751a00 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801d468000
R13: ffff88802009c200 R14: ffff8880765b0d70 R15: ffff8880765b2930
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559d632cbd28 CR3: 000000000c48e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 diUnmount+0xf1/0x130 fs/jfs/jfs_imap.c:195
 jfs_umount+0x189/0x410 fs/jfs/jfs_umount.c:63
 jfs_put_super+0x85/0x1a0 fs/jfs/super.c:194
 generic_shutdown_super+0x158/0x410 fs/super.c:492
 kill_block_super+0x9b/0xf0 fs/super.c:1428
 deactivate_locked_super+0x98/0x160 fs/super.c:332
 deactivate_super+0xb1/0xd0 fs/super.c:363
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1291
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xaa8/0x28d0 kernel/exit.c:820
 do_group_exit+0xd4/0x2a0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdcfc9f6ce9
Code: Unable to access opcode bytes at 0x7fdcfc9f6cbf.
RSP: 002b:00007ffe9b47d4c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fdcfca713f0 RCX: 00007fdcfc9f6ce9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00007ffe9b47d6b8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdcfca713f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

