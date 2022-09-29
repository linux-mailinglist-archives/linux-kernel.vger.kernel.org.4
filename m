Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784C05EFEC4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiI2Ukt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiI2Ukm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:40:42 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFF82766
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:40:40 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x6-20020a056e021bc600b002f8c7ccd2c4so1960072ilv.17
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/QpcA4v08ivrXcCw9Nxsv/8IXApK1v/9fpeqY0wcnxY=;
        b=lO2EhusVgDMijBX0kp6Al7ahhREwjjCaDdhuAyaxKfKwhKZujV6PCXrKfJnTzvcf2v
         tGYcoUSvivDOXOSyQLHQorazT+sgbxJIPLEbPqVVMwHtDSiN8UvJGZVZhFusF0NdHc2F
         LfzUut0mxQKPxbg8Xn6MMEh7QU1pXxT9kvHzlyh5J8PJn8oDc6mMmtEO5xUgI7BbCz1N
         WCEj/s0PkrltbSWj5FSWxZksBGRPsK35YnkumE/kFyxbuVL8405P/CkMRvhc9LPZrBwi
         CA+cIp1LvTSejB7VNnkuJ1p/7dPUh06oCokhIpBclEMtZ0ZpdHkN8pHnjVBOsyxKyeIT
         MrSQ==
X-Gm-Message-State: ACrzQf2j/bf5sRafk7C1yfn8IH4TRwMzpNl/vMgqthbCtLm5hiADLcag
        KiYHRt38arZ2eSijxMA8xOo855/+zgUkhkooVGR53BISORBY
X-Google-Smtp-Source: AMsMyM5wHoYE6X1cBubZyWEMRTydwHFwWwfjik8M1Rd84Pjktu44cAD3HENVl2pfC93mBCqE3bjcfQwfy81pTwLQuKpN7fz0gKkn
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1606:b0:35a:5472:fa1b with SMTP id
 x6-20020a056638160600b0035a5472fa1bmr2766762jas.241.1664484040144; Thu, 29
 Sep 2022 13:40:40 -0700 (PDT)
Date:   Thu, 29 Sep 2022 13:40:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f280bf05e9d6e31c@google.com>
Subject: [syzbot] general protection fault in diUpdatePMap
From:   syzbot <syzbot+f7b4e42c28602e81aab3@syzkaller.appspotmail.com>
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

HEAD commit:    3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1073636c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=f7b4e42c28602e81aab3
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16022898880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a945ff080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f7b4e42c28602e81aab3@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xfbd59c0000000021: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xdead000000000108-0xdead00000000010f]
CPU: 1 PID: 121 Comm: jfsCommit Not tainted 6.0.0-rc7-syzkaller-00029-g3800a713b607 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:__list_add_valid+0x39/0x100 lib/list_debug.c:27
Code: 00 00 00 49 89 d6 48 85 d2 0f 84 9b 00 00 00 49 89 f4 49 89 ff 49 bd 00 00 00 00 00 fc ff df 49 8d 5e 08 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 f8 40 a5 fd 48 8b 13 4c 39 e2 75
RSP: 0018:ffffc9000225fc10 EFLAGS: 00010806
RAX: 1bd5a00000000021 RBX: dead000000000108 RCX: dffffc0000000000
RDX: dead000000000100 RSI: ffffc90002271120 RDI: ffff88801d761da0
RBP: ffff88801d761d90 R08: ffffffff82fc6834 R09: fffff5200044bf64
R10: fffff5200044bf65 R11: 1ffff9200044bf64 R12: ffffc90002271120
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88801d761da0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f86dc15d290 CR3: 0000000025a6f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add include/linux/list.h:88 [inline]
 diUpdatePMap+0x5d6/0xda0 fs/jfs/jfs_imap.c:2821
 txUpdateMap+0x7c4/0xaa0 fs/jfs/jfs_txnmgr.c:2351
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x433/0xba0 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid+0x39/0x100 lib/list_debug.c:27
Code: 00 00 00 49 89 d6 48 85 d2 0f 84 9b 00 00 00 49 89 f4 49 89 ff 49 bd 00 00 00 00 00 fc ff df 49 8d 5e 08 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 f8 40 a5 fd 48 8b 13 4c 39 e2 75
RSP: 0018:ffffc9000225fc10 EFLAGS: 00010806
RAX: 1bd5a00000000021 RBX: dead000000000108 RCX: dffffc0000000000
RDX: dead000000000100 RSI: ffffc90002271120 RDI: ffff88801d761da0
RBP: ffff88801d761d90 R08: ffffffff82fc6834 R09: fffff5200044bf64
R10: fffff5200044bf65 R11: 1ffff9200044bf64 R12: ffffc90002271120
R13: dffffc0000000000 R14: dead000000000100 R15: ffff88801d761da0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f86dc15d290 CR3: 0000000025a6f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	49 89 d6             	mov    %rdx,%r14
   5:	48 85 d2             	test   %rdx,%rdx
   8:	0f 84 9b 00 00 00    	je     0xa9
   e:	49 89 f4             	mov    %rsi,%r12
  11:	49 89 ff             	mov    %rdi,%r15
  14:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
  1b:	fc ff df
  1e:	49 8d 5e 08          	lea    0x8(%r14),%rbx
  22:	48 89 d8             	mov    %rbx,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 f8 40 a5 fd       	callq  0xfda54130
  38:	48 8b 13             	mov    (%rbx),%rdx
  3b:	4c 39 e2             	cmp    %r12,%rdx
  3e:	75                   	.byte 0x75


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
