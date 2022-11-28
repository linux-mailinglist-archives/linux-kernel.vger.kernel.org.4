Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6061063A603
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiK1KVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiK1KVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:21:40 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA69F1A3B4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:21:37 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id c20-20020a5d9754000000b006dbd4e6a5abso5617938ioo.17
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:21:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1csAodOOfFTg2xybZjeCII0lV5hjMsXkJZLvPjeyoy0=;
        b=ymEMIh/qSqoV33abbR5VYXDRMs6o8pWEu7woRHlJi0iWuild+Cxe4DU2ocwAPSEWC3
         IITxDmFVwUrOP5AynaQ+NskS7+F3XPdaHDbC3hTcS/CwpMuK3KM+fltzJhdWg67tWfNB
         UiJSjBr0dMUMLMKDKL4oKHP6FfAsuQb7T6bp9fykKlqnHzm8wOD3yBUrw4iMIftUXa/l
         uSADDlHIqSUL4yWzLSLmOz9lLg/SRM7UcptMrNGSOgTJNA/BJvyMQywftivvmTretFUZ
         lXOxQ4glm/SsqZBH1V/pRtjVxacekcs6Deu/3ZySpeKSuMQVNKCtvZsprxLvO6RV93YZ
         GE6A==
X-Gm-Message-State: ANoB5pmxdMablhP0h6u2WdChbsREafEi2yvFxO3enNk5ebkmHZYg0p4s
        og6gX/CQpgXiBV+/R9lH02H+W2Yh8dPxCo90uSYZvoyVQLlx
X-Google-Smtp-Source: AA0mqf6gZGi0RD86hLnTJwpIDE2GuntyPJSbxUcgoIz8JgoDCM1GiVRXrhZviO6dLDkDJA1nD/RLc9afsOn6lJTCm9I/FZEffC3M
MIME-Version: 1.0
X-Received: by 2002:a02:9712:0:b0:363:a1bb:343e with SMTP id
 x18-20020a029712000000b00363a1bb343emr23846504jai.175.1669630897186; Mon, 28
 Nov 2022 02:21:37 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:21:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000886fde05ee853c18@google.com>
Subject: [syzbot] general protection fault in gfs2_print_dbg
From:   syzbot <syzbot+9f366abe80cb91810c84@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
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

HEAD commit:    faf68e3523c2 Merge tag 'kbuild-fixes-v6.1-4' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cf6cad880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=9f366abe80cb91810c84
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3bfa6577f378/disk-faf68e35.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7bf0af58cde3/vmlinux-faf68e35.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e15d7d640b0/bzImage-faf68e35.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f366abe80cb91810c84@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000108420: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000000842100-0x0000000000842107]
CPU: 0 PID: 16312 Comm: syz-executor.3 Not tainted 6.1.0-rc6-syzkaller-00315-gfaf68e3523c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:string_nocheck lib/vsprintf.c:643 [inline]
RIP: 0010:string+0x1b5/0x2d0 lib/vsprintf.c:725
Code: 89 de 49 ff ce 31 ed 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 8d 3c 2c 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 75 6a 49 8d 5c 2d 00 45 0f b6 3c 2c 31 ff 44 89
RSP: 0018:ffffc90005fc6990 EFLAGS: 00010003
RAX: 0000000000108420 RBX: ffffffffffffffff RCX: dffffc0000000000
RDX: ffff88807def3a80 RSI: 00000000ffffffff RDI: 0000000000842107
RBP: 0000000000000000 R08: ffffffff8a8cb389 R09: ffffffff8a8c7c8f
R10: 0000000000000012 R11: ffff88807def3a80 R12: 0000000000842107
R13: ffffc90005fc6ee6 R14: fffffffffffffffe R15: 0000000000000000
FS:  00007fa7a6873700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33622000 CR3: 000000007ba24000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vsnprintf+0x1221/0x1ce0 lib/vsprintf.c:2800
 va_format lib/vsprintf.c:1685 [inline]
 pointer+0x845/0xfa0 lib/vsprintf.c:2431
 vsnprintf+0xe73/0x1ce0 lib/vsprintf.c:2804
 vprintk_store+0x3b0/0x1050 kernel/printk/printk.c:2152
 vprintk_emit+0x9a/0x1e0 kernel/printk/printk.c:2249
 _printk+0xc0/0x100 kernel/printk/printk.c:2289
 gfs2_print_dbg+0x172/0x180 fs/gfs2/glock.c:1456
 dump_holder fs/gfs2/glock.c:2342 [inline]
 gfs2_dump_glock+0x149f/0x1b60 fs/gfs2/glock.c:2447
 gfs2_consist_inode_i+0xf3/0x110 fs/gfs2/util.c:465
 gfs2_dirent_scan+0x535/0x650 fs/gfs2/dir.c:602
 gfs2_dirent_search+0x2ea/0xb10 fs/gfs2/dir.c:850
 gfs2_dir_search+0x8c/0x2a0 fs/gfs2/dir.c:1650
 gfs2_lookupi+0x465/0x650 fs/gfs2/inode.c:323
 __gfs2_lookup+0x8c/0x260 fs/gfs2/inode.c:870
 __lookup_slow+0x266/0x3a0 fs/namei.c:1685
 lookup_slow+0x53/0x70 fs/namei.c:1702
 walk_component+0x2e1/0x410 fs/namei.c:1993
 lookup_last fs/namei.c:2450 [inline]
 path_lookupat+0x17d/0x450 fs/namei.c:2474
 filename_lookup+0x274/0x650 fs/namei.c:2503
 user_path_at_empty+0x40/0x1a0 fs/namei.c:2876
 do_readlinkat+0x10c/0x3d0 fs/stat.c:468
 __do_sys_readlink fs/stat.c:501 [inline]
 __se_sys_readlink fs/stat.c:498 [inline]
 __x64_sys_readlink+0x7b/0x90 fs/stat.c:498
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa7a5a8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa7a6873168 EFLAGS: 00000246 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 00007fa7a5bac120 RCX: 00007fa7a5a8c0d9
RDX: 0000000000000047 RSI: 0000000020000140 RDI: 0000000020000000
RBP: 00007fa7a5ae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffde5ef481f R14: 00007fa7a6873300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:string_nocheck lib/vsprintf.c:643 [inline]
RIP: 0010:string+0x1b5/0x2d0 lib/vsprintf.c:725
Code: 89 de 49 ff ce 31 ed 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 8d 3c 2c 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 75 6a 49 8d 5c 2d 00 45 0f b6 3c 2c 31 ff 44 89
RSP: 0018:ffffc90005fc6990 EFLAGS: 00010003
RAX: 0000000000108420 RBX: ffffffffffffffff RCX: dffffc0000000000
RDX: ffff88807def3a80 RSI: 00000000ffffffff RDI: 0000000000842107
RBP: 0000000000000000 R08: ffffffff8a8cb389 R09: ffffffff8a8c7c8f
R10: 0000000000000012 R11: ffff88807def3a80 R12: 0000000000842107
R13: ffffc90005fc6ee6 R14: fffffffffffffffe R15: 0000000000000000
FS:  00007fa7a6873700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33622000 CR3: 000000007ba24000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 de                	mov    %ebx,%esi
   2:	49 ff ce             	dec    %r14
   5:	31 ed                	xor    %ebp,%ebp
   7:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   e:	00 00 00
  11:	0f 1f 40 00          	nopl   0x0(%rax)
  15:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
  19:	48 89 f8             	mov    %rdi,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	75 6a                	jne    0x9c
  32:	49 8d 5c 2d 00       	lea    0x0(%r13,%rbp,1),%rbx
  37:	45 0f b6 3c 2c       	movzbl (%r12,%rbp,1),%r15d
  3c:	31 ff                	xor    %edi,%edi
  3e:	44                   	rex.R
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
