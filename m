Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C816DC2F2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 05:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDJDTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 23:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjDJDTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 23:19:36 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48151D3
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 20:19:35 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id i141-20020a6b3b93000000b00758a1ed99c2so3075487ioa.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 20:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681096774; x=1683688774;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7yRHWFPppOqFB/wqW1+J9Lrkdgg9pyRRB0DdRZBUOA=;
        b=1igklnRMtQm7Rsr+KMlbYSIFuBVVvFVnQ/F0QsjEOrCx47qaTeJ6yNeHMR2XHIj6Wu
         Khfi6ca3wPtQViH/IoolyzopZu5miydZ0Z4BR9zd4/PHM7iv+2huh/ZwSgQUcnMMb54V
         R/Pm6SIqiCeSE/eWwrNV5rCtIT/m7/odgAdMX6LOP62fGzIVqN55I4TdMBQ9UA2visjD
         PnbsKVqiL6kfee1ik0fg4vq7KqpMwhGIMYXTkoOAtsSmfsZOnsAtub8gCB6+MN7Ol1Gq
         dHrMlacfyIg014z+EEQp9YyFBKLZlGNu0oW7+0vq+vq7yIMwFDlvDzlmPycfP1L+hF4u
         IK2Q==
X-Gm-Message-State: AAQBX9c/xJTvNqlXj1QBeq7+6hsVOG3NZh4LT88sG5J4IkGV1X/y9L4N
        8Mn0jnpl7HmkyRCSbPlGT9z5IKgDUwiP2cNepJ5ADOM2Vt10
X-Google-Smtp-Source: AKy350bOmpUHaAdGCHmz4X1aCdsD+ximqKkWVSJWxue5Ect/utk68/h/Zgdq16fOS43dGFoFTKHxHsa6NMfI+Focm56OglBNd0bJ
MIME-Version: 1.0
X-Received: by 2002:a5d:85c5:0:b0:740:7bea:5287 with SMTP id
 e5-20020a5d85c5000000b007407bea5287mr4103012ios.3.1681096774633; Sun, 09 Apr
 2023 20:19:34 -0700 (PDT)
Date:   Sun, 09 Apr 2023 20:19:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015cf6405f8f2d817@google.com>
Subject: [syzbot] [btrfs?] WARNING in btrfs_free_block_groups
From:   syzbot <syzbot+ba5b9ee1d6b1efe0eacf@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    99ddf2254feb Merge tag 'trace-v6.3-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10d37ab3c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5666fa6aca264e42
dashboard link: https://syzkaller.appspot.com/bug?extid=ba5b9ee1d6b1efe0eacf
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/907a43450c5c/disk-99ddf225.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a142637e5396/vmlinux-99ddf225.xz
kernel image: https://storage.googleapis.com/syzbot-assets/447736ad6200/bzImage-99ddf225.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba5b9ee1d6b1efe0eacf@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5126 at fs/btrfs/block-group.c:4290 btrfs_free_block_groups+0xbb9/0xe80 fs/btrfs/block-group.c:4289
Modules linked in:
CPU: 1 PID: 5126 Comm: syz-executor.4 Not tainted 6.3.0-rc5-syzkaller-00032-g99ddf2254feb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:btrfs_free_block_groups+0xbb9/0xe80 fs/btrfs/block-group.c:4289
Code: ef e8 9b 9a 36 fe 48 8d 83 50 ff ff ff 48 89 44 24 08 48 8b 6d 00 31 ff 48 89 ee e8 41 e6 e0 fd 48 85 ed 74 1c e8 f7 e1 e0 fd <0f> 0b 48 8b 7c 24 10 48 8b 74 24 08 31 d2 31 c9 e8 c2 e4 fd ff eb
RSP: 0018:ffffc900047bfab8 EFLAGS: 00010293
RAX: ffffffff83a9832a RBX: ffff8881465a30b0 RCX: ffff888024043a80
RDX: 0000000000000000 RSI: 000000000005e000 RDI: 0000000000000000
RBP: 000000000005e000 R08: ffffffff83a980c8 R09: ffffed1028cb4601
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff8880303c9128
R13: dffffc0000000000 R14: 1ffff11006079225 R15: ffff8880303c9a00
FS:  0000555556f8e400(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555ced708 CR3: 000000002ffce000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 close_ctree+0x742/0xd30 fs/btrfs/disk-io.c:4635
 generic_shutdown_super+0x134/0x340 fs/super.c:500
 kill_anon_super+0x3b/0x60 fs/super.c:1107
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2133
 deactivate_locked_super+0xa4/0x110 fs/super.c:331
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1177
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f019388d5d7
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdff37d528 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f019388d5d7
RDX: 00007ffdff37d5fb RSI: 000000000000000a RDI: 00007ffdff37d5f0
RBP: 00007ffdff37d5f0 R08: 00000000ffffffff R09: 00007ffdff37d3c0
R10: 0000555556f8f8b3 R11: 0000000000000246 R12: 00007f01938e6cdc
R13: 00007ffdff37e6b0 R14: 0000555556f8f810 R15: 00007ffdff37e6f0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
