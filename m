Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38D05EFEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiI2Ukq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiI2Ukl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:40:41 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9181AFA0F7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:40:40 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h17-20020a056e021d9100b002f81bc83425so1976399ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=wftOwvU7tf4wzq4kPACBGiS4fY52mPam2mkuPp+O7kQ=;
        b=aHIkeglg49BAU/DV3xDcpwV8qbBwK5dgSRnvSvveSolPbtxVyO/WFFW8/SD70M9bke
         +oTlIflPMQh1D3jLebuYqUEKLsuMi6p4kh3+sFoH5/wsnr7UaPm3TL00YUdYn4VbTnNX
         VcjVv/VabVfd3dIeqSMswWmdV7/zZPQeIrbHzngHsJWQWryNziHtSJqvNriswohq0nT5
         4C5nTWchbBp6ITQ2VgtnshHi/0lYMkth+ZCqxbh27nl/bTbCdBqRSFEBHraSzJwHiYgT
         0Ym3UMQf+V1u0EEPUjTZ6eKMXcuxseGXNab7VNMSnmc6Q9Dqb3ATUoVsusxpv97IJcPF
         MMww==
X-Gm-Message-State: ACrzQf1JkLGaAGHFsujikzWdLNrXR78XFnUAJrLdYvnijcMNcEW13wNw
        n8WvXDRD6T79Dky+VOIdroyHO1eFKu5y3t6CQDuWqE2FfRiU
X-Google-Smtp-Source: AMsMyM7IiolDyHgkp8RG75SPSeq9/K9dP6DxqPlqzHe3VNbYggDpXaPZp0pjs61kAzd1QYrAnl8OFPbAz38hHnDk6ly8Ci+XR50e
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180a:b0:2f6:9b06:a184 with SMTP id
 a10-20020a056e02180a00b002f69b06a184mr2760314ilv.137.1664484039882; Thu, 29
 Sep 2022 13:40:39 -0700 (PDT)
Date:   Thu, 29 Sep 2022 13:40:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ee81a205e9d6e3d7@google.com>
Subject: [syzbot] general protection fault in lmLogSync (2)
From:   syzbot <syzbot+e14b1036481911ae4d77@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1599a048880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b404c0880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179f60b8880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7f1f925f94e/disk-c3e0e1e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/830dabeedf0d/vmlinux-c3e0e1e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e14b1036481911ae4d77@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 PID: 3619 Comm: syz-executor117 Not tainted 6.0.0-rc7-syzkaller-00081-gc3e0e1e23c70 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:write_special_inodes fs/jfs/jfs_logmgr.c:208 [inline]
RIP: 0010:lmLogSync+0x227/0xb00 fs/jfs/jfs_logmgr.c:937
Code: b2 fe 49 8d 5f f0 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 37 66 da fe 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 1a 66 da fe 48 8b 3b e8 32 89 b2
RSP: 0018:ffffc900039dfae0 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 4daf7eec4cfcb600
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900039dfbe8 R08: ffffffff81b29a43 R09: ffffc900039dfa30
R10: fffff5200073bf49 R11: 1ffff9200073bf46 R12: dffffc0000000000
R13: ffff88807736d800 R14: 0000000000000000 R15: ffff888020ba2638
FS:  00005555574fa300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555557503628 CR3: 0000000021420000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_syncpt+0x79/0x90 fs/jfs/jfs_logmgr.c:1041
 jfs_sync_fs+0x86/0xa0 fs/jfs/super.c:685
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x300 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 ptrace_notify+0x29a/0x340 kernel/signal.c:2353
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:249
 syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f50d6eec917
Code: 07 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf5fdfe28 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f50d6eec917
RDX: 00007ffcf5fdfee9 RSI: 000000000000000a RDI: 00007ffcf5fdfee0
RBP: 00007ffcf5fdfee0 R08: 00000000ffffffff R09: 00007ffcf5fdfcc0
R10: 00005555574fb653 R11: 0000000000000206 R12: 00007ffcf5fe0f50
R13: 00005555574fb5f0 R14: 00007ffcf5fdfe50 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:write_special_inodes fs/jfs/jfs_logmgr.c:208 [inline]
RIP: 0010:lmLogSync+0x227/0xb00 fs/jfs/jfs_logmgr.c:937
Code: b2 fe 49 8d 5f f0 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 37 66 da fe 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 1a 66 da fe 48 8b 3b e8 32 89 b2
RSP: 0018:ffffc900039dfae0 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 4daf7eec4cfcb600
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900039dfbe8 R08: ffffffff81b29a43 R09: ffffc900039dfa30
R10: fffff5200073bf49 R11: 1ffff9200073bf46 R12: dffffc0000000000
R13: ffff88807736d800 R14: 0000000000000000 R15: ffff888020ba2638
FS:  00005555574fa300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005613768c4db8 CR3: 0000000021420000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b2 fe                	mov    $0xfe,%dl
   2:	49 8d 5f f0          	lea    -0x10(%r15),%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 37 66 da fe       	callq  0xfeda6653
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 30          	add    $0x30,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 1a 66 da fe       	callq  0xfeda6653
  39:	48 8b 3b             	mov    (%rbx),%rdi
  3c:	e8                   	.byte 0xe8
  3d:	32                   	.byte 0x32
  3e:	89                   	.byte 0x89
  3f:	b2                   	.byte 0xb2


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
