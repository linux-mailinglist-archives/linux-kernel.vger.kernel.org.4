Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF235F1C87
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJANt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJANtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:49:47 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61824E0DF
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:49:44 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id k3-20020a056e02156300b002f5623faa62so5422581ilu.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=SBHgUWbR1+/7nvdRfZnEndFDM+zr2q8uXqNsyXZzZW8=;
        b=f+pzUEzA4dBifdMP1M1UevTn1IewKBdOhx08PnnLcV5Qt9OiKyGwYdy0UXGGmyxwiJ
         T3tiO20ke/eBSrf2PtGjD0Fn4hSeEayTgYkcqq3tW9i8Q2elTI2848tr0GJZ2o7d/shj
         yDTMeQWF1r9dvbZQ3KiXR5pR1mV1eOTeWjDUMH0e1SYX2m/M77HePfglCYopQfd8OnHO
         pRRqRubbOOh4eVDSShsi+yLX8sUMDyMk7BNrSDIH5FLZHCuA/b09RP2qYZTRDCPfaWSR
         q2tSr0cbEkF3YpzVRKUl4rJcmbp5oqawAMynwpm5+38cQP/LxlVwiXQ9Vz7t30KWWdWU
         3nOg==
X-Gm-Message-State: ACrzQf1/s9owM2XW2G5qhHDPK01RFM8+kvshe9y4iWSKU8TjN7DrVIbm
        Kie2AzjYusRVi/yOCIZFn7hFrns9fOKH+9Tw825USYqJgC50
X-Google-Smtp-Source: AMsMyM5vR8D8NYPoMRpZh3N0zDvUTv8PAOrnbg8MZAY3skW7vorBtxO93ipwjqWbpTF00iiAU5Sb7RyFRSyCMOIZZsPUWIe4knda
MIME-Version: 1.0
X-Received: by 2002:a92:da4a:0:b0:2f8:fa94:9dae with SMTP id
 p10-20020a92da4a000000b002f8fa949daemr6160581ilq.80.1664632183800; Sat, 01
 Oct 2022 06:49:43 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:49:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff4a1505e9f961a2@google.com>
Subject: [syzbot] general protection fault in dtSplitUp
From:   syzbot <syzbot+172bdd582e5d63486948@syzkaller.appspotmail.com>
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

HEAD commit:    5a77386984b5 Merge tag 'drm-fixes-2022-09-30-1' of git://a..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c1e370880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=172bdd582e5d63486948
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f2dc48880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1027d814880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87931d29c9af/disk-5a773869.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/afb91893f060/vmlinux-5a773869.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+172bdd582e5d63486948@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 3612 Comm: syz-executor263 Not tainted 6.0.0-rc7-syzkaller-00162-g5a77386984b5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:dtExtendPage fs/jfs/jfs_dtree.c:1661 [inline]
RIP: 0010:dtSplitUp+0x1528/0x5120 fs/jfs/jfs_dtree.c:1034
Code: c6 74 11 e8 3a 46 a1 fe 48 8b 44 24 20 49 8d 5e e8 48 89 18 e8 29 46 a1 fe 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 90 35 00 00 4c 8b 33 31 ff 4c 89 f6 e8 e1 42 a1
RSP: 0018:ffffc9000395f2c8 EFLAGS: 00010256
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82dac1f7 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888073ee333a R14: ffffc9000395f7f0 R15: ffff888073ee3270
FS:  00005555556d7300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005599fad45028 CR3: 000000001d4a7000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 dtInsert+0x82b/0xa10 fs/jfs/jfs_dtree.c:863
 jfs_create+0x5b7/0xac0 fs/jfs/namei.c:137
 lookup_open.isra.0+0xf05/0x12a0 fs/namei.c:3413
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x996/0x28f0 fs/namei.c:3688
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1340
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1da668d019
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff79c19d48 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f1da668d019
RDX: 0000000000161842 RSI: 000000002000c380 RDI: 00000000ffffff9c
RBP: 00007f1da664c7e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 0000000a00030083 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dtExtendPage fs/jfs/jfs_dtree.c:1661 [inline]
RIP: 0010:dtSplitUp+0x1528/0x5120 fs/jfs/jfs_dtree.c:1034
Code: c6 74 11 e8 3a 46 a1 fe 48 8b 44 24 20 49 8d 5e e8 48 89 18 e8 29 46 a1 fe 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 90 35 00 00 4c 8b 33 31 ff 4c 89 f6 e8 e1 42 a1
RSP: 0018:ffffc9000395f2c8 EFLAGS: 00010256
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82dac1f7 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888073ee333a R14: ffffc9000395f7f0 R15: ffff888073ee3270
FS:  00005555556d7300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005584d071b470 CR3: 000000001d4a7000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	74 11                	je     0x13
   2:	e8 3a 46 a1 fe       	callq  0xfea14641
   7:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   c:	49 8d 5e e8          	lea    -0x18(%r14),%rbx
  10:	48 89 18             	mov    %rbx,(%rax)
  13:	e8 29 46 a1 fe       	callq  0xfea14641
  18:	48 89 da             	mov    %rbx,%rdx
  1b:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  22:	fc ff df
  25:	48 c1 ea 03          	shr    $0x3,%rdx
* 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2d:	0f 85 90 35 00 00    	jne    0x35c3
  33:	4c 8b 33             	mov    (%rbx),%r14
  36:	31 ff                	xor    %edi,%edi
  38:	4c 89 f6             	mov    %r14,%rsi
  3b:	e8                   	.byte 0xe8
  3c:	e1 42                	loope  0x80
  3e:	a1                   	.byte 0xa1


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
