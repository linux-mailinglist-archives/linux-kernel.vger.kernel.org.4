Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D5566BA78
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjAPJey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjAPJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:34:42 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C916AF3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:34:41 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id y24-20020a5ec818000000b006e2c0847835so17465340iol.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XG+8BKQZXmEP0/38FNg8FgT9PiBrBcckD5PCX9//6rU=;
        b=sv9SeDH2DiQxGD03V92WQbGi+I3Ud32TaPQLEgfcP4WNWiDbaC/QpeVZR6W/Ql7zQw
         vLQEHBSU6m6Gzi0lUrVs28ibTlrgm5f0vZ7qmrgJeL9tYDNiFnyPRwfz3hBtKzJQ6W/s
         f7nm+3Q7jkxOol7vR0MKhsDTa5Jgbii2YYsqceu01PohHyz4biwFUG42dVEl5E5WBfDe
         isL8tWoDMCEriIjytyiHrAkUZUmU+MyJWsUt0iqJfQRieAFu/4SIj1gyARW0tU4UtkiB
         io68PeagbU3tXaBomrtgL979gXf5xJDWRiflTO8QUfqrLNiQ8bV6eVGxC0q61Zc4lxRJ
         bo8Q==
X-Gm-Message-State: AFqh2kqplo/FVaTjraMyykm+fO3q4+kqmRaL+jVPJWsNG8yevJ0jA0WF
        zxbQkHYqvXusFHuSWcNYJOVmbRfOrU03Cr/5+mk+MWAIAm9F
X-Google-Smtp-Source: AMrXdXtBLIVPzMJ8XpSauUJN2DKRtc8QZaJS45FfN41f/bGLULX92rcj7lmH8JfkgZvHuYsG9bJuxoQi7SZfmB+9vDLqiPOPvhzP
MIME-Version: 1.0
X-Received: by 2002:a02:aa18:0:b0:39e:a033:90c with SMTP id
 r24-20020a02aa18000000b0039ea033090cmr2060004jam.254.1673861681074; Mon, 16
 Jan 2023 01:34:41 -0800 (PST)
Date:   Mon, 16 Jan 2023 01:34:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e75aad05f25e4a1e@google.com>
Subject: [syzbot] general protection fault in sock_poll
From:   syzbot <syzbot+026ab7dc882b578abd78@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, syzkaller-bugs@googlegroups.com
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a3e136480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=026ab7dc882b578abd78
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+026ab7dc882b578abd78@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 1 PID: 24704 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:sock_poll+0xc0/0x5d0 net/socket.c:1341
Code: 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 7e 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 20 48 8d 7b 40 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 51 04 00 00 48 8b 5b 40 31 c0 48 85 db 74 7f e8
RSP: 0000:ffffc900037d79e0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90004011000
RDX: 0000000000000008 RSI: ffffffff87bf3d08 RDI: 0000000000000040
RBP: ffff88808540aa00 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900037d7a88
R13: ffff88802bfad900 R14: ffff88808540aa20 R15: ffff888083c93a78
FS:  00007f544b91d700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8c14da8000 CR3: 000000001da7b000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_poll include/linux/poll.h:88 [inline]
 io_poll_check_events io_uring/poll.c:279 [inline]
 io_poll_task_func+0x3a6/0x1220 io_uring/poll.c:327
 handle_tw_list+0xa8/0x460 io_uring/io_uring.c:1169
 tctx_task_work+0x12e/0x530 io_uring/io_uring.c:1224
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x24f0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f544ac8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f544b91d218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007f544adabf88 RCX: 00007f544ac8c0c9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f544adabf8c
RBP: 00007f544adabf80 R08: 00007ffdfa9bc080 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f544adabf8c
R13: 00007ffdfa9359ef R14: 00007f544b91d300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sock_poll+0xc0/0x5d0 net/socket.c:1341
Code: 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 7e 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 20 48 8d 7b 40 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 51 04 00 00 48 8b 5b 40 31 c0 48 85 db 74 7f e8
RSP: 0000:ffffc900037d79e0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90004011000
RDX: 0000000000000008 RSI: ffffffff87bf3d08 RDI: 0000000000000040
RBP: ffff88808540aa00 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900037d7a88
R13: ffff88802bfad900 R14: ffff88808540aa20 R15: ffff888083c93a78
FS:  00007f544b91d700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3343a000 CR3: 000000001da7b000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	4c 89 f2             	mov    %r14,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 7e 04 00 00    	jne    0x48f
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	48 8b 5d 20          	mov    0x20(%rbp),%rbx
  1f:	48 8d 7b 40          	lea    0x40(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 51 04 00 00    	jne    0x485
  34:	48 8b 5b 40          	mov    0x40(%rbx),%rbx
  38:	31 c0                	xor    %eax,%eax
  3a:	48 85 db             	test   %rbx,%rbx
  3d:	74 7f                	je     0xbe
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
