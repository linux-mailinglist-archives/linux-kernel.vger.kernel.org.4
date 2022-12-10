Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4138D648DEF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLJJ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:27:40 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FDD30F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:27:37 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id p3-20020a6bfa03000000b006df8582e11cso3562467ioh.22
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDjIi1VyrEy7+bbo+sMpceI+7TGx4ctZl9gqgSyd9QQ=;
        b=oOA7WVLRI+NJ98XAqGOGNWsIXbjuwGXZr1bgDo9Z+ReSlvIPnEvgDHxq3TQ7csz32v
         Vil+fceCfa6abcZ42AB5UytyoNgYxxNuSbOQjKEAnvbIhSIxD8wD8tMckXK95Den9XuM
         9qsDKV75PhNi5lnHhJDAOp6PUz+lWQFU/O+TYLbqDexnls1Bt00PnnLlweZgIP75TTZc
         HPrCIBI2+4kDRHAN9D8vIck5TaIvuqv/1CL8vUkRJNFv6pehPIHt1IzNKdEd7XT4Lq71
         mR1p2HaSmqq0J9WJmQ3J90PZQsdLbUGj869toB77boz0UZ5okSTA5kGpnMXgWLEdmYSu
         +SDQ==
X-Gm-Message-State: ANoB5plQV1Dn05cpfjNW7JKVo4WTMpFsgqWN2ZJOI9feEY6Nn5GiJ1R6
        DcsuDeJ23jKM9ZLtwgp43qyhscwOgWb/GFRszbesbM5k2a0a
X-Google-Smtp-Source: AA0mqf6ZO77dRbGN7eK1bzYJHqFXflny3CTFOkaEd41zRtKo3QETFjeDaLuoxnfx2H3Z1/yiNLVmuSdxCJnHkoeYvBXj9VL7sipf
MIME-Version: 1.0
X-Received: by 2002:a92:3603:0:b0:302:f382:3652 with SMTP id
 d3-20020a923603000000b00302f3823652mr31582495ila.110.1670664456430; Sat, 10
 Dec 2022 01:27:36 -0800 (PST)
Date:   Sat, 10 Dec 2022 01:27:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076ecae05ef75e1ee@google.com>
Subject: [syzbot] general protection fault in diRead
From:   syzbot <syzbot+d9588fb1e44f806d5138@syzkaller.appspotmail.com>
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

HEAD commit:    0d1409e4ff08 Merge tag 'drm-fixes-2022-12-09' of git://ano..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1212cf6d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=d9588fb1e44f806d5138
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d1d72f880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164dbf0f880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9ab0143f95cb/disk-0d1409e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e574d5eaa32f/vmlinux-0d1409e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/31109436b00b/bzImage-0d1409e4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a5a5905382dc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9588fb1e44f806d5138@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 3639 Comm: syz-executor311 Not tainted 6.1.0-rc8-syzkaller-00148-g0d1409e4ff08 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:diIAGRead fs/jfs/jfs_imap.c:2659 [inline]
RIP: 0010:diRead+0x17c/0xab0 fs/jfs/jfs_imap.c:315
Code: 81 c3 20 08 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 12 c4 db fe 4c 8b 2b 49 8d 5d 28 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 f5 c3 db fe bd 78 06 00 00 48 03
RSP: 0018:ffffc90003bdf3d0 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: ffffffff8169c7c6
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888070cf00d0
RBP: ffff888070cf0430 R08: dffffc0000000000 R09: ffffed100e19e01b
R10: ffffed100e19e01b R11: 1ffff1100e19e01a R12: 0000000000000021
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888070cf00c8
FS:  00007fb1603b1700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005586f97a6a78 CR3: 000000001cfd5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_iget+0x8a/0x3b0 fs/jfs/inode.c:35
 jfs_lookup+0x1bb/0x380 fs/jfs/namei.c:1462
 __lookup_slow+0x266/0x3a0 fs/namei.c:1685
 lookup_slow+0x53/0x70 fs/namei.c:1702
 walk_component fs/namei.c:1993 [inline]
 link_path_walk+0xa06/0xf00 fs/namei.c:2320
 path_openat+0x237/0x2df0 fs/namei.c:3710
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb160c12019
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb1603b1208 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fb160c96788 RCX: 00007fb160c12019
RDX: 0000000000101800 RSI: 00000000200000c0 RDI: ffffffffffffff9c
RBP: 00007fb160c96780 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000059 R11: 0000000000000246 R12: 00007fb160c9678c
R13: 00007ffdd855641f R14: 00007fb1603b1300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:diIAGRead fs/jfs/jfs_imap.c:2659 [inline]
RIP: 0010:diRead+0x17c/0xab0 fs/jfs/jfs_imap.c:315
Code: 81 c3 20 08 00 00 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 12 c4 db fe 4c 8b 2b 49 8d 5d 28 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 f5 c3 db fe bd 78 06 00 00 48 03
RSP: 0018:ffffc90003bdf3d0 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: ffffffff8169c7c6
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888070cf00d0
RBP: ffff888070cf0430 R08: dffffc0000000000 R09: ffffed100e19e01b
R10: ffffed100e19e01b R11: 1ffff1100e19e01a R12: 0000000000000021
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888070cf00c8
FS:  00007fb1603b1700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562224695088 CR3: 000000001cfd5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	81 c3 20 08 00 00    	add    $0x820,%ebx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 12 c4 db fe       	callq  0xfedbc42e
  1c:	4c 8b 2b             	mov    (%rbx),%r13
  1f:	49 8d 5d 28          	lea    0x28(%r13),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 f5 c3 db fe       	callq  0xfedbc42e
  39:	bd 78 06 00 00       	mov    $0x678,%ebp
  3e:	48                   	rex.W
  3f:	03                   	.byte 0x3


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
