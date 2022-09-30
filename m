Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8326F5F161B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiI3W1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiI3W0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:26:46 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7547EDE96
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:26:44 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id 23-20020a5ea517000000b006a496fee582so3618825iog.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=A4M1jwcikAykUnpmEqYfdsXGYXIV8qxX9cM/wCryjFA=;
        b=WVmC4wT2gLfTMLBO0yvhMehwkqSj3Q+jNupGoCziy9qUWHK4DZ30nH3yG3sFfV19LB
         cZYGalsy+zKTP7vm2dTaEsx1gPclKh2cIRNFioh7q4GjfnhqYzvJBADFfCmWyYllYIHp
         eyGFKTHaFe0Ry39eh4Ta573aqhruoG9TjjoIEqJip2eCl9AmnRREvOdYpR1P6A74AsYi
         /rbnC3cE/d3lqvCsHYu+paF1jRiFXDSFszwxjTt4tsL6M/TsBw8gZSthfHDnqLG5/r06
         ZP8NdfzsRePYDW3xP/SShs0ufMbTN4+D+0lwIOG+6gPKZNdFYqbBQVWaFa9f6PK6DV/I
         QxhA==
X-Gm-Message-State: ACrzQf2erD8PQPNcQgnj2bZ+OhWs+AkzqY9nsvSaH6AdzIdbhQgMCTec
        jQ4CmcStS7sn8cj3ndNcs63r6GncioVsny/tVJSSrOCd6KaW
X-Google-Smtp-Source: AMsMyM5wBmYLJIZGt2NUUsb9sb2VUHmrt2IHTrpUCqF+rYn/un+Qx9Op7Ri/KnIJF+Ezx5jYVhocvR0B8QK9h24viw35p0yYLanv
MIME-Version: 1.0
X-Received: by 2002:a05:6638:379d:b0:35a:41a4:778f with SMTP id
 w29-20020a056638379d00b0035a41a4778fmr5738338jal.102.1664576804012; Fri, 30
 Sep 2022 15:26:44 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:26:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ac89b05e9ec7db6@google.com>
Subject: [syzbot] general protection fault in write_special_inodes
From:   syzbot <syzbot+c732e285f8fc38d15916@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    c3e0e1e23c70 Merge tag 'irq_urgent_for_v6.0' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11189000880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
dashboard link: https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1079c41f080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154912e0880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e29a1fa19166/disk-c3e0e1e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd7739458f56/vmlinux-c3e0e1e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c732e285f8fc38d15916@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 PID: 3611 Comm: syz-executor329 Not tainted 6.0.0-rc7-syzkaller-00081-gc3e0e1e23c70 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:write_special_inodes+0xa6/0x170 fs/jfs/jfs_logmgr.c:208
Code: 8b 7d 30 41 ff d4 48 8d 7b 28 48 89 f8 48 c1 e8 03 80 3c 28 00 0f 85 ab 00 00 00 4c 8b 6b 28 49 8d 7d 30 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 88 00 00 00 49 8b 7d 30 41 ff d4 48 8d bb b0 00
RSP: 0018:ffffc90003037c20 EFLAGS: 00010206
RAX: 0000000000000006 RBX: ffff888017347c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81a29052 RDI: 0000000000000030
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81a39370
R13: 0000000000000000 R14: ffff88807d3ed800 R15: ffff88801a953040
FS:  0000555556aaa300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557c33749000 CR3: 0000000016fbf000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lmLogSync+0x458/0x7b0 fs/jfs/jfs_logmgr.c:937
 jfs_syncpt+0x89/0xa0 fs/jfs/jfs_logmgr.c:1041
 jfs_sync_fs+0x80/0xa0 fs/jfs/super.c:685
 sync_filesystem.part.0+0x75/0x1d0 fs/sync.c:56
 sync_filesystem+0x8b/0xc0 fs/sync.c:43
 generic_shutdown_super+0x70/0x400 fs/super.c:474
 kill_block_super+0x97/0xf0 fs/super.c:1427
 deactivate_locked_super+0x94/0x160 fs/super.c:332
 deactivate_super+0xad/0xd0 fs/super.c:363
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 ptrace_notify+0x114/0x140 kernel/signal.c:2353
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work kernel/entry/common.c:249 [inline]
 syscall_exit_to_user_mode_prepare+0x129/0x280 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0x9/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd021dc0917
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed2de9fd8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fd021dc0917
RDX: 00007ffed2dea099 RSI: 000000000000000a RDI: 00007ffed2dea090
RBP: 00007ffed2dea090 R08: 00000000ffffffff R09: 00007ffed2de9e70
R10: 0000555556aab653 R11: 0000000000000206 R12: 00007ffed2deb100
R13: 0000555556aab5f0 R14: 00007ffed2dea000 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:write_special_inodes+0xa6/0x170 fs/jfs/jfs_logmgr.c:208
Code: 8b 7d 30 41 ff d4 48 8d 7b 28 48 89 f8 48 c1 e8 03 80 3c 28 00 0f 85 ab 00 00 00 4c 8b 6b 28 49 8d 7d 30 48 89 f8 48 c1 e8 03 <80> 3c 28 00 0f 85 88 00 00 00 49 8b 7d 30 41 ff d4 48 8d bb b0 00
RSP: 0018:ffffc90003037c20 EFLAGS: 00010206
RAX: 0000000000000006 RBX: ffff888017347c00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81a29052 RDI: 0000000000000030
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81a39370
R13: 0000000000000000 R14: ffff88807d3ed800 R15: ffff88801a953040
FS:  0000555556aaa300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff786565d8 CR3: 0000000016fbf000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b 7d 30             	mov    0x30(%rbp),%edi
   3:	41 ff d4             	callq  *%r12
   6:	48 8d 7b 28          	lea    0x28(%rbx),%rdi
   a:	48 89 f8             	mov    %rdi,%rax
   d:	48 c1 e8 03          	shr    $0x3,%rax
  11:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  15:	0f 85 ab 00 00 00    	jne    0xc6
  1b:	4c 8b 6b 28          	mov    0x28(%rbx),%r13
  1f:	49 8d 7d 30          	lea    0x30(%r13),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	0f 85 88 00 00 00    	jne    0xbc
  34:	49 8b 7d 30          	mov    0x30(%r13),%rdi
  38:	41 ff d4             	callq  *%r12
  3b:	48                   	rex.W
  3c:	8d                   	.byte 0x8d
  3d:	bb                   	.byte 0xbb
  3e:	b0 00                	mov    $0x0,%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
