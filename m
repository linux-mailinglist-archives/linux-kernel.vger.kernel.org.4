Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99647420A2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjF2GrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjF2GrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:47:08 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960E358B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:46:56 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-39cdf9f9d10so397275b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688021216; x=1690613216;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7ab+kIFc4NfZgpCon9+cnUevyxh1afHJUp133YFjuo=;
        b=R/DdtUmEHth9kdb0uxd3DsR0cvomTELmEgB02exuQgXRdl5kJOvVU6W4B8fTPBKdW9
         KWyQuHoswIbi106PBBoxYMhnGwwDR2lY3F11ECmOfpv7P1npOPCbZNNG9yPvXDoIq6+x
         aMcYB4Q8txAxZ33EVoKJoNmYR6FtB+NoRutbUD17ZXIcFpMC9pEiFcoF3hU8s/7haW3C
         ojhGDTUn9+pnVUANtWnzbQddcaKCLMTfEaAlgdw1P15K7Mp4/bO7rvDtQ6xgvegKXLjX
         nuq8Ms7LGPDbaIGvE6cw7iHjO7pgjED/l1MBhALmih7shw0fU0g87nCDLiXkTpzumxdz
         2j4Q==
X-Gm-Message-State: AC+VfDxlK3qevADZBuLtjxu+NyaUlnikP+miIgKrw8yxyEYQgFiIdMlF
        ht4vDMT5WDvoPWlDtfJrnQaeB4vbUsLoTZt6cHnA2hwzKQOi
X-Google-Smtp-Source: ACHHUZ5uznqkOUZLG3MW49GlIq7/aK8P5lChwrOpRhSTc9ZnEY3hJJOeO/ek7Qx8uZhASuF0SBV1HVcxsXZx2w5Lz9HLY41nsWCm
MIME-Version: 1.0
X-Received: by 2002:aca:b9c6:0:b0:39e:ced7:602b with SMTP id
 j189-20020acab9c6000000b0039eced7602bmr10002788oif.2.1688021215900; Wed, 28
 Jun 2023 23:46:55 -0700 (PDT)
Date:   Wed, 28 Jun 2023 23:46:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f27b1005ff3f1047@google.com>
Subject: [syzbot] [btrfs?] kernel BUG in btrfs_run_defrag_inodes
From:   syzbot <syzbot+afec8fb60a29eee6de33@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1446e8e0a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=afec8fb60a29eee6de33
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/51be0f38ba27/disk-a92b7d26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b31a945d3cb5/vmlinux-a92b7d26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0b145c24307/bzImage-a92b7d26.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afec8fb60a29eee6de33@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/inode.c:1763!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5767 Comm: btrfs-cleaner Not tainted 6.4.0-rc7-syzkaller-00226-ga92b7d26c743 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:iput+0x8e8/0x8f0 fs/inode.c:1763
Code: e8 ff e9 b5 fb ff ff 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 46 fe ff ff 4c 89 e7 e8 c2 ec e8 ff e9 39 fe ff ff e8 c8 09 91 ff <0f> 0b 66 0f 1f 44 00 00 f3 0f 1e fa 55 41 57 41 56 53 48 89 f5 48
RSP: 0018:ffffc90015e37c70 EFLAGS: 00010293
RAX: ffffffff81fa7b28 RBX: 0000000000000040 RCX: ffff8880290cd940
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
RBP: ffff888075690448 R08: ffffffff81fa72a3 R09: fffffbfff1cabba6
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: ffff8880214be130 R14: 0000000000000005 R15: ffff8880214be108
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4c3eb6dd50 CR3: 000000002cd46000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __btrfs_run_defrag_inode fs/btrfs/defrag.c:282 [inline]
 btrfs_run_defrag_inodes+0xa90/0xe20 fs/btrfs/defrag.c:328
 cleaner_kthread+0x287/0x3c0 fs/btrfs/disk-io.c:1739
 kthread+0x2b8/0x350 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput+0x8e8/0x8f0 fs/inode.c:1763
Code: e8 ff e9 b5 fb ff ff 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 46 fe ff ff 4c 89 e7 e8 c2 ec e8 ff e9 39 fe ff ff e8 c8 09 91 ff <0f> 0b 66 0f 1f 44 00 00 f3 0f 1e fa 55 41 57 41 56 53 48 89 f5 48
RSP: 0018:ffffc90015e37c70 EFLAGS: 00010293
RAX: ffffffff81fa7b28 RBX: 0000000000000040 RCX: ffff8880290cd940
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
RBP: ffff888075690448 R08: ffffffff81fa72a3 R09: fffffbfff1cabba6
R10: 0000000000000000 R11: dffffc0000000001 R12: dffffc0000000000
R13: ffff8880214be130 R14: 0000000000000005 R15: ffff8880214be108
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c02af7e000 CR3: 0000000036a4b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
