Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B949E65563B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 00:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiLWXjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 18:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiLWXja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 18:39:30 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B8D24F2C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 15:37:42 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i21-20020a056e021d1500b003041b04e3ebso3264032ila.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 15:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=abW9eO7hhwarVLkkJyHp+PNS3L1/OX8HA8B9tTuHJUU=;
        b=QiKYui+91wL0nWvi0D7kXkSdKLMQyl0M9ii6cFFKTZ+zSfYrjO6bDkuzxnXLnROL/J
         NWYo5v6cKx/oABzpsht1dCj9EJX0c8+0bDExPoy0gQHNfsRDmhWCiW3A+vo6M4uKChoz
         KBrZ/8QDPztU1cOeSMT79+W9s8zwDKhxZdtkB616IUHmWpboycnKATJxBlAf6DWZxxXs
         +GE0sd+fDJYkvWtdqhRCG+zhDvPtfkm7XpS5Rm0VgsMy5egDFosyPDODIaIMoGzj48W6
         vQLCge6Qj2L3wmFM5n4PoyiFFq7eiIjm3/85Cl3vOR0q8ynfrV2aoz0c3oj0Sht+Y59n
         MPDA==
X-Gm-Message-State: AFqh2kpiujMjv5CivffJch9Y+rhywJ+RmutzZcIQnPz6SexFHN4pJegi
        OAKFHGnAVcMEgUd0i/pFKxMydL4APyfPe8WS8PhTHE+DE38n
X-Google-Smtp-Source: AMrXdXsHFU70lLDf+O1R092JYxGVrF0CiK4W8Pvyf84i+Fq9sQ/AZDjNJ2QYUY29fqiODG/TG1PuKouKhNIxPrKThDmDCq9//HUT
MIME-Version: 1.0
X-Received: by 2002:a05:6602:81c:b0:6da:46b4:85f6 with SMTP id
 z28-20020a056602081c00b006da46b485f6mr841342iow.147.1671838662168; Fri, 23
 Dec 2022 15:37:42 -0800 (PST)
Date:   Fri, 23 Dec 2022 15:37:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094982205f0874589@google.com>
Subject: [syzbot] [jfs?] [fat?] general protection fault in txEnd
From:   syzbot <syzbot+1d096d31de6a0491b55e@syzkaller.appspotmail.com>
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

HEAD commit:    aeba12b26c79 Merge tag 'nfsd-6.2-1' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17485bf0480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d348fc1e0f483c9
dashboard link: https://syzkaller.appspot.com/bug?extid=1d096d31de6a0491b55e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117aef10480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15206090480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/661fe33f851b/disk-aeba12b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c938bdcf3ad0/vmlinux-aeba12b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7f738de30b7/bzImage-aeba12b2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9ee3cffc6151/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d096d31de6a0491b55e@syzkaller.appspotmail.com

ERROR: (device loop0): remounting filesystem as read-only
general protection fault, probably for non-canonical address 0xdffffc0000000029: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000148-0x000000000000014f]
CPU: 1 PID: 5116 Comm: syz-executor317 Not tainted 6.1.0-syzkaller-13781-gaeba12b26c79 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:txEnd+0x1dc/0x560 fs/jfs/jfs_txnmgr.c:534
Code: 00 84 c0 0f 85 d8 02 00 00 66 41 89 1e 41 0f b7 c5 89 05 e7 5c 0b 0f 4c 8b 74 24 08 49 8d 9e 4c 01 00 00 48 89 d8 48 c1 e8 03 <42> 8a 04 20 84 c0 0f 85 c8 02 00 00 8b 2b 8d 75 ff 89 33 31 ff e8
RSP: 0018:ffffc90003d5f9f0 EFLAGS: 00010203
RAX: 0000000000000029 RBX: 000000000000014c RCX: 0000000000000000
RDX: ffff88807eb93a80 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff920004c6227 R08: ffffffff830c3c2f R09: fffffbfff20fb43a
R10: fffffbfff20fb43a R11: 1ffffffff20fb439 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000110
FS:  00007f2738801700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f273fc23000 CR3: 000000007e7a4000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 add_missing_indices fs/jfs/jfs_dtree.c:2658 [inline]
 jfs_readdir+0x277c/0x44b0 fs/jfs/jfs_dtree.c:3004
 iterate_dir+0x257/0x5f0
 __do_sys_getdents fs/readdir.c:286 [inline]
 __se_sys_getdents+0x1db/0x4d0 fs/readdir.c:271
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f273fc76709
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f27388012f8 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007f273fd017b0 RCX: 00007f273fc76709
RDX: 000000000000004c RSI: 0000000020000100 RDI: 0000000000000004
RBP: 0030656c69662f2e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 61746f7571727375
R13: 726765746e696f6e R14: 7261637369646f6e R15: 00007f273fd017b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:txEnd+0x1dc/0x560 fs/jfs/jfs_txnmgr.c:534
Code: 00 84 c0 0f 85 d8 02 00 00 66 41 89 1e 41 0f b7 c5 89 05 e7 5c 0b 0f 4c 8b 74 24 08 49 8d 9e 4c 01 00 00 48 89 d8 48 c1 e8 03 <42> 8a 04 20 84 c0 0f 85 c8 02 00 00 8b 2b 8d 75 ff 89 33 31 ff e8
RSP: 0018:ffffc90003d5f9f0 EFLAGS: 00010203
RAX: 0000000000000029 RBX: 000000000000014c RCX: 0000000000000000
RDX: ffff88807eb93a80 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 1ffff920004c6227 R08: ffffffff830c3c2f R09: fffffbfff20fb43a
R10: fffffbfff20fb43a R11: 1ffffffff20fb439 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000110
FS:  00007f2738801700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f273fc23000 CR3: 000000007e7a4000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 84 c0 0f 85 d8 02 	add    %al,0x2d8850f(%rax,%rax,8)
   7:	00 00                	add    %al,(%rax)
   9:	66 41 89 1e          	mov    %bx,(%r14)
   d:	41 0f b7 c5          	movzwl %r13w,%eax
  11:	89 05 e7 5c 0b 0f    	mov    %eax,0xf0b5ce7(%rip)        # 0xf0b5cfe
  17:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
  1c:	49 8d 9e 4c 01 00 00 	lea    0x14c(%r14),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 8a 04 20          	mov    (%rax,%r12,1),%al <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 c8 02 00 00    	jne    0x2fe
  36:	8b 2b                	mov    (%rbx),%ebp
  38:	8d 75 ff             	lea    -0x1(%rbp),%esi
  3b:	89 33                	mov    %esi,(%rbx)
  3d:	31 ff                	xor    %edi,%edi
  3f:	e8                   	.byte 0xe8


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
