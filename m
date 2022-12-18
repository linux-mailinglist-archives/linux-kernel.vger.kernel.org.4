Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A2064FF61
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiLRP6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 10:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiLRP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 10:58:46 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F64AE6A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 07:58:45 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a13-20020a056e0208ad00b003034c36b8b5so5307236ilt.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 07:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/LBx6WtV+CqZBaLfApw7W0yygAGxOitTY/dU8TCFyk=;
        b=0qXlaPDXtnbSTw5F57K+v1/SCFAXdg30xR3YRrGh42O5oXtYZDk/ve2PKdPCWz+B1h
         ZygXp98HBoelKwZ3Phdq5XATcPn2xtaK0x7YsEcJvQfv3zBm67UyUCyd1VMxwIx3nIlT
         VMkhpbUbu/mIookN2A8EVfc7YzuEjY7LH7X+AGo2n5wFzSEZ62uQvcdud1mqyqFLQ1LH
         M/ipEjCVClCBKq+gT/R7jxI4fiEB3JsHjn1cGmUZ5iwCNJ8FvNYNffwmxjGEGHzMYAGI
         HempM5M7txtBLNJElIB36a6kY0NTKVY4PszhNwBYjQ1KiaLHl+jpByZRb+Nfd+G9oYXG
         RtLQ==
X-Gm-Message-State: ANoB5pmHPdfk3x/UcLhhsrldElUD1iyKNPm7SHboPIaR5Z0Rxi2jiKrq
        dPkN0mMBh67e7xv+8FvCCLG2XL7yjywAjKHPkfXu83lipLZL
X-Google-Smtp-Source: AA0mqf6FDphjEyc8exfNPOTnCLkIAP3v3cDp+/X6PeqHy8THNmkayrYOB2dTSpI57ni2U9IQEZAwtDZU7lj2kb/sqXzKeBdgZ8Mk
MIME-Version: 1.0
X-Received: by 2002:a05:6638:223:b0:38a:4fbd:45da with SMTP id
 f3-20020a056638022300b0038a4fbd45damr10836755jaq.47.1671379124938; Sun, 18
 Dec 2022 07:58:44 -0800 (PST)
Date:   Sun, 18 Dec 2022 07:58:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000006ee3605f01c47bc@google.com>
Subject: [syzbot] divide error in flush_commit_list
From:   syzbot <syzbot+32134c00ff57e0343b6b@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org,
        damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e2ca6ba6ba01 Merge tag 'mm-stable-2022-12-13' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158718d7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=276eb8ff64eb2c27
dashboard link: https://syzkaller.appspot.com/bug?extid=32134c00ff57e0343b6b
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8aad47431ccd/disk-e2ca6ba6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/382636835ba9/vmlinux-e2ca6ba6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac62c9f6a7cf/bzImage-e2ca6ba6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+32134c00ff57e0343b6b@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5334 Comm: syz-executor.0 Not tainted 6.1.0-syzkaller-09941-ge2ca6ba6ba01 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:flush_commit_list+0x971/0x1bb0 fs/reiserfs/journal.c:1051
Code: 30 84 c0 4c 8b 6c 24 78 0f 85 c7 01 00 00 48 89 e8 48 c1 e8 03 0f b6 04 30 84 c0 0f 85 da 01 00 00 41 8b 0c 24 4c 89 f0 31 d2 <48> f7 f1 48 89 d3 49 83 c7 18 4c 89 f8 48 c1 e8 03 80 3c 30 00 74
RSP: 0018:ffffc90003c3f788 EFLAGS: 00010246
RAX: 000000000000003d RBX: ffff88802ded300c RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff88807664bb40
RBP: ffff88802ded3017 R08: dffffc0000000000 R09: ffffed100ecc9769
R10: ffffed100ecc9769 R11: 1ffff1100ecc9768 R12: ffff88802ded3014
R13: ffff888075848018 R14: 000000000000003d R15: ffff888075c33000
FS:  0000555556d5d400(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f82d3460000 CR3: 0000000047a19000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_journal_end+0x3858/0x4a30 fs/reiserfs/journal.c:4302
 do_journal_release+0x15f/0x4c0 fs/reiserfs/journal.c:1917
 journal_release+0x1b/0x30 fs/reiserfs/journal.c:1971
 reiserfs_put_super+0x245/0x4e0 fs/reiserfs/super.c:616
 generic_shutdown_super+0x130/0x310 fs/super.c:492
 kill_block_super+0x79/0xd0 fs/super.c:1386
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1291
 task_work_run+0x243/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb24988d547
Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef1d23d28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fb24988d547
RDX: 00007ffef1d23dfa RSI: 000000000000000a RDI: 00007ffef1d23df0
RBP: 00007ffef1d23df0 R08: 00000000ffffffff R09: 00007ffef1d23bc0
R10: 0000555556d5e873 R11: 0000000000000246 R12: 00007fb2498e6b24
R13: 00007ffef1d24eb0 R14: 0000555556d5e810 R15: 00007ffef1d24ef0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:flush_commit_list+0x971/0x1bb0 fs/reiserfs/journal.c:1051
Code: 30 84 c0 4c 8b 6c 24 78 0f 85 c7 01 00 00 48 89 e8 48 c1 e8 03 0f b6 04 30 84 c0 0f 85 da 01 00 00 41 8b 0c 24 4c 89 f0 31 d2 <48> f7 f1 48 89 d3 49 83 c7 18 4c 89 f8 48 c1 e8 03 80 3c 30 00 74
RSP: 0018:ffffc90003c3f788 EFLAGS: 00010246
RAX: 000000000000003d RBX: ffff88802ded300c RCX: 0000000000000000
RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff88807664bb40
RBP: ffff88802ded3017 R08: dffffc0000000000 R09: ffffed100ecc9769
R10: ffffed100ecc9769 R11: 1ffff1100ecc9768 R12: ffff88802ded3014
R13: ffff888075848018 R14: 000000000000003d R15: ffff888075c33000
FS:  0000555556d5d400(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f50d71fe000 CR3: 0000000047a19000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	30 84 c0 4c 8b 6c 24 	xor    %al,0x246c8b4c(%rax,%rax,8)
   7:	78 0f                	js     0x18
   9:	85 c7                	test   %eax,%edi
   b:	01 00                	add    %eax,(%rax)
   d:	00 48 89             	add    %cl,-0x77(%rax)
  10:	e8 48 c1 e8 03       	callq  0x3e8c15d
  15:	0f b6 04 30          	movzbl (%rax,%rsi,1),%eax
  19:	84 c0                	test   %al,%al
  1b:	0f 85 da 01 00 00    	jne    0x1fb
  21:	41 8b 0c 24          	mov    (%r12),%ecx
  25:	4c 89 f0             	mov    %r14,%rax
  28:	31 d2                	xor    %edx,%edx
* 2a:	48 f7 f1             	div    %rcx <-- trapping instruction
  2d:	48 89 d3             	mov    %rdx,%rbx
  30:	49 83 c7 18          	add    $0x18,%r15
  34:	4c 89 f8             	mov    %r15,%rax
  37:	48 c1 e8 03          	shr    $0x3,%rax
  3b:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1)
  3f:	74                   	.byte 0x74


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
