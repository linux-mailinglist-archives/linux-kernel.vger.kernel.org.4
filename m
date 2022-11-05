Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2FD61DA83
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 14:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiKENBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 09:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKENBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 09:01:46 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733BD28E15
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 06:01:45 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id l9-20020a5d8f89000000b006bd33712128so4575677iol.17
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 06:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ycXCPEKEsTXjbyLJhHsbRB2hFF5zxExdk2bJRthjSY=;
        b=pFZ0QCBmcG5DXkB4Bh0GV0Cl/lTLu69/0YLDIoPU6Qf0TUTQLX8KqsD999wjDPuoBw
         S6/fu4yGReXvRRCTR4qlTGQbHNISuva6PFinQEsmUcptpIFCurWUm2SerCnn1HjyRK0w
         EWJN3NyuCoNbdX2v+ju390o/h3kjtL2P4juTo3Is8mA09c6/VTnvxQKs9OMDCY6Hj0R6
         DUgLYF2xrPWh54cMdVlm3wjt2Sg2PEJ1B4bAx/eNc+kWko8Vwm9VOYMWvX5MLljjXZs6
         rL0WCXmhGnF76IbNNCb3nhbEa4TEGx+fCMb6oeFtLfigWimQsv0xuAzUiQy5Oxw7AwvL
         gFKA==
X-Gm-Message-State: ACrzQf2yQHPrG0zO72AQnYIGHp+hkHJBsS8VwK/1AaELvzL6k5/fkho6
        ts4KF0sDHN98qss9/mBn5q/3egB9Eer9bYw+epJTVUWM3p/A
X-Google-Smtp-Source: AMsMyM6h74czd14/cg2Tq+KbR1L+rGK+Mp6OIVISwKdvZ6+3Ti46o98dqt+zJCmAYua0h9v+W1XH/0LzDXCTtkq702NeGq2HbC5a
MIME-Version: 1.0
X-Received: by 2002:a02:ca48:0:b0:375:806e:5f79 with SMTP id
 i8-20020a02ca48000000b00375806e5f79mr10517355jal.83.1667653304808; Sat, 05
 Nov 2022 06:01:44 -0700 (PDT)
Date:   Sat, 05 Nov 2022 06:01:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d77ab905ecb8cab2@google.com>
Subject: [syzbot] WARNING in udf_add_free_space
From:   syzbot <syzbot+46e1bd3863f22513085b@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11bac051880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=46e1bd3863f22513085b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba5b49fa77de/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c061f2ae4dc/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc45c1300e9b/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46e1bd3863f22513085b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3638 at fs/udf/udfdecl.h:114 udf_add_free_space.isra.0+0x1b2/0x200 fs/udf/udfdecl.h:114
Modules linked in:
CPU: 0 PID: 3638 Comm: syz-executor.5 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:udf_add_free_space.isra.0+0x1b2/0x200 fs/udf/udfdecl.h:114
Code: 02 84 c0 74 04 3c 03 7e 25 c7 83 50 01 00 00 01 00 00 00 5b 5d 41 5c 41 5d e9 9a 83 a8 fe e8 95 83 a8 fe 0f 0b e8 8e 83 a8 fe <0f> 0b eb b2 e8 45 d4 f4 fe eb d4 e8 de d3 f4 fe e9 6b fe ff ff e8
RSP: 0018:ffffc9000465f608 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888037ff6400 RCX: 0000000000000000
RDX: ffff888023bb57c0 RSI: ffffffff82d418f2 RDI: 0000000000000005
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 1ffffffff17f25f9 R12: ffff88802b2be000
R13: 0000000000000000 R14: 0000000000000020 R15: ffff88808b2a9490
FS:  00005555562f1400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe2c217f1b8 CR3: 000000008261b000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 udf_table_free_blocks fs/udf/balloc.c:384 [inline]
 udf_free_blocks+0x42c/0x15c0 fs/udf/balloc.c:662
 extent_trunc+0x348/0x3c0 fs/udf/truncate.c:56
 udf_truncate_extents+0x2d3/0x930 fs/udf/truncate.c:230
 udf_setsize+0x3de/0x1080 fs/udf/inode.c:1276
 udf_evict_inode+0x35c/0x580 fs/udf/inode.c:145
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1747 [inline]
 iput.part.0+0x59b/0x880 fs/inode.c:1773
 iput+0x58/0x70 fs/inode.c:1763
 udf_free_partition fs/udf/super.c:279 [inline]
 udf_sb_free_partitions.isra.0+0x325/0x560 fs/udf/super.c:306
 udf_put_super+0x133/0x220 fs/udf/super.c:2361
 generic_shutdown_super+0x154/0x410 fs/super.c:491
 kill_block_super+0x97/0xf0 fs/super.c:1427
 deactivate_locked_super+0x94/0x160 fs/super.c:331
 deactivate_super+0xad/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f924548ca17
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc94d110d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f924548ca17
RDX: 00007ffc94d111ab RSI: 000000000000000a RDI: 00007ffc94d111a0
RBP: 00007ffc94d111a0 R08: 00000000ffffffff R09: 00007ffc94d10f70
R10: 00005555562f28b3 R11: 0000000000000246 R12: 00007f92454e5826
R13: 00007ffc94d12260 R14: 00005555562f2810 R15: 00007ffc94d122a0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
