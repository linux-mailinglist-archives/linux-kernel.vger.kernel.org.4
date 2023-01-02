Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1085265AF33
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjABKCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjABKBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:01:43 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BE410E7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:01:41 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y5-20020a056e021be500b0030bc4f23f0aso17663858ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2gTVxH1zp8JSpYvuSq3RyaiZ87QO7AjNm6jJ2nVfpLg=;
        b=iytW3Pfwlkn2BOp1uR0E44jRtOKC4Aa0EXRr0aW5RT96bQ+8/V2t7n27HiSQUXO70R
         nCOxDLgRZKW9q5VqntrfJbDzg631i28yRcedbFS0M3h1k58ChRUWR4UaOyR5B9IQwPRY
         utc53xsP72aAN2+OomNPbPCItVJLJ8ecyztCHjfsuolAmLX3dEvdaJ9HjBMV/LT1E6x2
         rO1OjpzAvBZ44FLDy6Y2m9wOOpMSMhIkw6RXxv8fFUtaTE1YFL2lCKP8Rfh8sQQKLMCp
         fmtWPxUJ4FtnuBr6glqj7ax6CtjAYuGk04Ij047G3nwYnefxIVVwQg9b6fBXYkCjxE83
         vxpg==
X-Gm-Message-State: AFqh2krTD6whu5fX/+UGziT2+i2RqbtEMuyab1NGThRu/8BBCr5CQea1
        YOb66+CVyCMfEiOea1jtXKtQugWCmcXMiWkJerqI1W+q+ZUT
X-Google-Smtp-Source: AMrXdXu4s9TXlbwA9vLcIWPeEO71I6oyEUfygDplgDzoYITeWFVQrFg4Jz5AHEBIW2DzsQP3QS5HGnpjbl7fpI/rEt5iQ7rXshIb
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:803:b0:304:c661:f53 with SMTP id
 u3-20020a056e02080300b00304c6610f53mr3385441ilm.155.1672653700643; Mon, 02
 Jan 2023 02:01:40 -0800 (PST)
Date:   Mon, 02 Jan 2023 02:01:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8c57205f1450921@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_abort_atomic_write
From:   syzbot <syzbot+9b7be0f1263ed2dbfbba@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e8d2e4480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2651619a26b4d687
dashboard link: https://syzkaller.appspot.com/bug?extid=9b7be0f1263ed2dbfbba
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d562ace1a56c/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/39f000fe6b9e/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1c67e48de5a0/bzImage-1b929c02.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b7be0f1263ed2dbfbba@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/inode.c:1763!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 533 Comm: syz-executor.3 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:iput+0x68/0x80 fs/inode.c:1763
Code: ff 83 e3 40 48 89 de e8 16 d0 9b ff 48 85 db 75 14 e8 3c d3 9b ff 48 89 ef e8 24 f7 ff ff 5b 5d e9 2d d3 9b ff e8 28 d3 9b ff <0f> 0b e8 d1 da e9 ff eb c5 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90014357be0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000000000000
RDX: ffff8880766d1d40 RSI: ffffffff81e57f18 RDI: 0000000000000007
RBP: ffff88808c1e5960 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000000 R12: ffff88808c1e04b0
R13: 0000000000000000 R14: ffff88808c1e5960 R15: 0000000000000000
FS:  00007f8898356700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8898335718 CR3: 00000000290d3000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 f2fs_abort_atomic_write+0xea/0x4f0 fs/f2fs/segment.c:196
 f2fs_ioc_commit_atomic_write+0x19f/0x260 fs/f2fs/file.c:2157
 __f2fs_ioctl+0x26f0/0xaaf0 fs/f2fs/file.c:4154
 f2fs_ioctl+0x18e/0x220 fs/f2fs/file.c:4242
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f889768c0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8898356168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f88977ac050 RCX: 00007f889768c0a9
RDX: 0000000000000000 RSI: 000000000000f502 RDI: 0000000000000004
RBP: 00007f88976e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc5d002faf R14: 00007f8898356300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput+0x68/0x80 fs/inode.c:1763
Code: ff 83 e3 40 48 89 de e8 16 d0 9b ff 48 85 db 75 14 e8 3c d3 9b ff 48 89 ef e8 24 f7 ff ff 5b 5d e9 2d d3 9b ff e8 28 d3 9b ff <0f> 0b e8 d1 da e9 ff eb c5 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90014357be0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000000000000
RDX: ffff8880766d1d40 RSI: ffffffff81e57f18 RDI: 0000000000000007
RBP: ffff88808c1e5960 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000000 R12: ffff88808c1e04b0
R13: 0000000000000000 R14: ffff88808c1e5960 R15: 0000000000000000
FS:  00007f8898356700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8898335718 CR3: 00000000290d3000 CR4: 0000000000350ef0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
