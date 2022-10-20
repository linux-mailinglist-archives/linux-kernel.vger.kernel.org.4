Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9B60573F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJTGRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJTGRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:17:43 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9936D1849A3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:17:42 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id s3-20020a5eaa03000000b006bbdfc81c6fso15896701ioe.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ta5MpRduwUsht0i2QMhM2lVMVgWREjI8RsgK+nyWoLk=;
        b=6PQJJmhglbyPgk/eXtof8moXt6ZZTNb0XBPEYINyYmV6m3DpIYkKpVOMdAOWwBbPwl
         wBNw+abqEBbOYcB4Dk3KtgYxeKMshdzayKqHvY2YLJ7/xg2AEstd35cX5+sZZfqrgpZd
         xWGZKwHKJ2revdMgWp1ABG6P1F7bj4PTI1EfC0uoY/1OSx9aypXa2nBEgfwnlfvSLRoh
         PMJQDbH4c5s+51xES/35VEM6Aw+ZAr4xKnm/5U9BTm3g3zSudmKgct2qA+uIPr0zlMGH
         cT6wbbeEk4lv2NjRCwkkZpsuGzzDMXsLcI42L4zHcNNQ9kY48rSMGYTtjZJRhs7NLVfl
         jYtA==
X-Gm-Message-State: ACrzQf1qmCUzjI6XwQx7u/QH9qTCwJpiDjHHNuN8j4HEvO2kmN25Qv57
        KpV8ynMGNK1uRn7aUYJ7NXosngheoaoWBtI4ePl77P5GwTlv
X-Google-Smtp-Source: AMsMyM4XoENKn2XfcsA8GCNHMS4eZqWCctRx+Nn7/K3ajeM95faXHkAPGKGYcv0cIG31nJrxpnFtHtyT3sQhRFR+4oS4D/AE9Omg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2d:b0:2f9:e735:a010 with SMTP id
 e13-20020a056e020b2d00b002f9e735a010mr8561834ilu.151.1666246661883; Wed, 19
 Oct 2022 23:17:41 -0700 (PDT)
Date:   Wed, 19 Oct 2022 23:17:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063d12705eb7148be@google.com>
Subject: [syzbot] WARNING in udf_table_free_blocks
From:   syzbot <syzbot+ff260305474b823e33a6@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136fead6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=ff260305474b823e33a6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff260305474b823e33a6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3765 at fs/udf/udfdecl.h:116 udf_add_free_space fs/udf/balloc.c:102 [inline]
WARNING: CPU: 0 PID: 3765 at fs/udf/udfdecl.h:116 udf_table_free_blocks+0x14b6/0x1920 fs/udf/balloc.c:384
Modules linked in:
CPU: 0 PID: 3765 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:114 [inline]
RIP: 0010:udf_add_free_space fs/udf/balloc.c:102 [inline]
RIP: 0010:udf_table_free_blocks+0x14b6/0x1920 fs/udf/balloc.c:384
Code: 89 ff e8 bd ec e5 fe 48 8b 9c 24 70 01 00 00 48 85 db 74 07 e8 fb 81 92 fe eb bc e8 f4 81 92 fe e9 2d ed ff ff e8 ea 81 92 fe <0f> 0b e9 fa ee ff ff 89 f9 80 e1 07 fe c1 38 c1 0f 8c 64 ec ff ff
RSP: 0018:ffffc900057df500 EFLAGS: 00010293
RAX: ffffffff82f3ff66 RBX: 0000000000000001 RCX: ffff888024a7bb00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900057df708 R08: ffffffff82f3ee55 R09: fffffbfff1c19fde
R10: fffffbfff1c19fde R11: 1ffffffff1c19fdd R12: dffffc0000000000
R13: ffff8880968ba01c R14: ffff88807aeea678 R15: 1ffff92000afbf30
FS:  0000555556550400(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00ebc4a80 CR3: 000000004cb15000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_free_blocks+0x1b2/0x240 fs/udf/balloc.c:662
 extent_trunc+0x3ae/0x4b0 fs/udf/truncate.c:56
 udf_truncate_extents+0x38d/0x11c0 fs/udf/truncate.c:230
 udf_setsize+0xeb9/0x1290 fs/udf/inode.c:1282
 udf_evict_inode+0x74/0x410 fs/udf/inode.c:145
 evict+0x2a4/0x620 fs/inode.c:664
 udf_free_partition fs/udf/super.c:279 [inline]
 udf_sb_free_partitions+0x134/0x570 fs/udf/super.c:306
 udf_put_super+0x10f/0x160 fs/udf/super.c:2361
 generic_shutdown_super+0x130/0x310 fs/super.c:491
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:331
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:169
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f20fc08ca17
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffebd6ce1e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f20fc08ca17
RDX: 00007ffebd6ce2bb RSI: 000000000000000a RDI: 00007ffebd6ce2b0
RBP: 00007ffebd6ce2b0 R08: 00000000ffffffff R09: 00007ffebd6ce080
R10: 00005555565518b3 R11: 0000000000000246 R12: 00007f20fc0e55f6
R13: 00007ffebd6cf370 R14: 0000555556551810 R15: 00007ffebd6cf3b0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
