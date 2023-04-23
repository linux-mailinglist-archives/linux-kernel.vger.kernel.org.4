Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923FF6EBCB3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 05:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDWDj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 23:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjDWDj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 23:39:56 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB9B2128
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 20:39:55 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-32b5ec09cffso22669735ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 20:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682221195; x=1684813195;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=npvT4Nc+3jsQslBncgvFu5I8Z+wKN+EOxAHFerKKXVc=;
        b=G6QUdLWWu2vNrmvkJn8EFfylSVUHsFEfkKjtvVzJHJSdQRf3635MEO0aBX2xsUU5Ww
         bVddl9Zrq14B92qWK5LPAK65ZlOAIhD3zUhf98IPcgScKE75A/PEdeFMQ52wi3+85EYo
         NU+jnQB6FsIPEPG2mkDjH9BfJnpVpcbvtNYWoIvJRac27QVNq4gYm5sNy0J7bFslMm99
         UA62QF6PjW699lnyIpNtCKgoKGSa3fl5UuCIm/xQH6MXjr2U7EkSM9OGqqkhxBT7GdhP
         4Q1+YUTs8DHegHSvgHA7hMmbYlw+SlHqyGpug1/bYg0rnXODnVdhzXJ8EqaDn314k2At
         bDDA==
X-Gm-Message-State: AAQBX9c3PCiBRnOUTCQWZuNW3QO748BXrBb/6tcDWdc4Q5c1arj9Nc1P
        YhSoh/qD6Odw4CbWamClvuFkX56p7ICtrWRKnMJ3VDeckuXP
X-Google-Smtp-Source: AKy350Z7l98dnzXjreJ4hDiZKSJunzAGGuLRtXfuD8/8FdEnIL8cYmY/ZOqir9TvKdeaAxJgOl2QJmNfVdM9yIjsrHiPCsZVH+7X
MIME-Version: 1.0
X-Received: by 2002:a92:d9cf:0:b0:32b:8bf:4d77 with SMTP id
 n15-20020a92d9cf000000b0032b08bf4d77mr2406958ilq.1.1682221194864; Sat, 22 Apr
 2023 20:39:54 -0700 (PDT)
Date:   Sat, 22 Apr 2023 20:39:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0f30f05f9f8a464@google.com>
Subject: [syzbot] [block?] WARNING in __floppy_read_block_0 (2)
From:   syzbot <syzbot+4bc99b8be4d209da97f2@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    af67688dca57 Merge tag 'mmc-v6.3-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ad3cb3c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11869c60f54496a7
dashboard link: https://syzkaller.appspot.com/bug?extid=4bc99b8be4d209da97f2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4bc99b8be4d209da97f2@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 15731 at drivers/block/floppy.c:999 schedule_bh drivers/block/floppy.c:999 [inline]
WARNING: CPU: 0 PID: 15731 at drivers/block/floppy.c:999 process_fd_request drivers/block/floppy.c:2847 [inline]
WARNING: CPU: 0 PID: 15731 at drivers/block/floppy.c:999 __floppy_read_block_0.isra.0+0x28b/0x320 drivers/block/floppy.c:4160
Modules linked in:
CPU: 0 PID: 15731 Comm: syz-executor.2 Not tainted 6.3.0-rc7-syzkaller-00043-gaf67688dca57 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:schedule_bh drivers/block/floppy.c:999 [inline]
RIP: 0010:process_fd_request drivers/block/floppy.c:2847 [inline]
RIP: 0010:__floppy_read_block_0.isra.0+0x28b/0x320 drivers/block/floppy.c:4160
Code: 84 24 b8 01 00 00 65 48 2b 04 25 28 00 00 00 0f 85 9e 00 00 00 48 81 c4 c0 01 00 00 5b 5d 41 5c 41 5d 41 5e c3 e8 65 0f 66 fc <0f> 0b e9 5a ff ff ff e8 19 21 b7 fc e9 80 fe ff ff e8 4f 0f 66 fc
RSP: 0018:ffffc90002cef6c8 EFLAGS: 00010216
RAX: 0000000000000ca1 RBX: 0000000000000001 RCX: ffffc9000cea8000
RDX: 0000000000040000 RSI: ffffffff851cdbfb RDI: 0000000000000001
RBP: ffffea0001b91c40 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 1ffff9200059ded9
R13: ffffc90002cef798 R14: dffffc0000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c600000(0063) knlGS:00000000f7fdfb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000040 CR3: 000000004ed67000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 floppy_revalidate.isra.0+0x7ed/0xbf0 drivers/block/floppy.c:4206
 floppy_open+0xacc/0xe90 drivers/block/floppy.c:4058
 blkdev_get_whole+0x99/0x2d0 block/bdev.c:594
 blkdev_get_by_dev.part.0+0x5e0/0xb80 block/bdev.c:744
 blkdev_get_by_dev+0x6f/0x90 block/bdev.c:778
 blkdev_open+0x140/0x2c0 block/fops.c:493
 do_dentry_open+0x6cc/0x13f0 fs/open.c:920
 do_open fs/namei.c:3560 [inline]
 path_openat+0x1baa/0x2750 fs/namei.c:3715
 do_filp_open+0x1ba/0x410 fs/namei.c:3742
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_compat_sys_openat fs/open.c:1424 [inline]
 __se_compat_sys_openat fs/open.c:1422 [inline]
 __ia32_compat_sys_openat+0x143/0x1f0 fs/open.c:1422
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fe4579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7fdf170 EFLAGS: 00000286 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00000000ffffff9c RCX: 00000000f7fdf1c0
RDX: 0000000000004000 RSI: 0000000000000000 RDI: 00000000f734e000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	retq
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
