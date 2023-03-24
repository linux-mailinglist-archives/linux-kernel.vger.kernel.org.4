Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB576C7759
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 06:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjCXF3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 01:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjCXF3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:29:13 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613211ADC1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:27:36 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id d5-20020a923605000000b003232594207dso608476ila.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679635655;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GekIWwh8ZS9HnDwY0vD7YkKR/1x9wux71kJbPTyKEX0=;
        b=UKfwKL73zrH1ojcz8jLZSoycwVlXSq/ou9lcObBJnu6gRzK5UO1l6nFlvs7Ysd347r
         z2KefQcy8HhvgDNj7UZiwrZrmcYCWaIQImM+6qoJF2wae5pPMyKf8BG+rAScVYdflkm5
         3Fg18DFGZOuZNjhBb6A2WxvA9SjNL1v9L3bTJwr0Ua+xKmmjK3gToKDNBRG5GRE6+9qz
         qCjlQtoRjeV7tzBkXLoytvtwDGKTGVStBcZK4hoW+czKqhoKgHYAHhEXqdcnE1fAVMjY
         04hhmOU9Fe/F9ehT3rMIobgwHb1u8IIqzNfq3UImSGIAhV8HmNwZDdp34Aa7IGNeF8ub
         aO0g==
X-Gm-Message-State: AO0yUKXxig6pymKuyl7YJhb1cexfOOG+ai6ceRovs9y3IOblDnw6loDM
        LtubwHaK+j1xCO9nEIZfYuVHNtQnppCPt0Xvl0R1MZQhHl6c
X-Google-Smtp-Source: AK7set/WvhQfroGp62ozvULaa97iWtnnPtm2KCuEFAz3qcBe875U37WJaHveXQrlB69atQhVe8A254LiRcj3HAXRiDmgkklw2rMO
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2207:b0:323:ecc:daf1 with SMTP id
 j7-20020a056e02220700b003230eccdaf1mr4923228ilf.2.1679635655710; Thu, 23 Mar
 2023 22:27:35 -0700 (PDT)
Date:   Thu, 23 Mar 2023 22:27:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c5ff405f79ea630@google.com>
Subject: [syzbot] [mm?] general protection fault in vma_merge
From:   syzbot <syzbot+29fe1bbf3a023691de49@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7c4a254d78f8 Add linux-next specific files for 20230323
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15230839c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ba12b2f4a1ff93d
dashboard link: https://syzkaller.appspot.com/bug?extid=29fe1bbf3a023691de49
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c322f39e779d/disk-7c4a254d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc7ef0a3d51c/vmlinux-7c4a254d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3f17e539876/bzImage-7c4a254d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29fe1bbf3a023691de49@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000015: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000a8-0x00000000000000af]
CPU: 0 PID: 5796 Comm: modprobe Not tainted 6.3.0-rc3-next-20230323-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0010:vma_merge+0x234/0x1fd0 mm/mmap.c:952
Code: 08 00 0f 84 b0 03 00 00 e8 e9 54 bf ff 48 8b 44 24 08 48 8d b8 a8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 18 00 00 48 8b 44 24 08 48 8b b0 a8 00 00 00
RSP: 0018:ffffc9000c24fac8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88801cbb2100 RCX: 0000000000000000
RDX: 0000000000000015 RSI: ffffffff81c37957 RDI: 00000000000000a9
RBP: ffff888027fee400 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 00007faf14caa000 R15: ffff88801d2b3400
FS:  00007faf14ca4800(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007faf14dd3920 CR3: 0000000078d00000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mprotect_fixup+0x353/0xbd0 mm/mprotect.c:676
 do_mprotect_pkey+0x878/0xd20 mm/mprotect.c:862
 __do_sys_mprotect mm/mprotect.c:883 [inline]
 __se_sys_mprotect mm/mprotect.c:880 [inline]
 __x64_sys_mprotect+0x78/0xb0 mm/mprotect.c:880
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faf14fef297
Code: 44 00 00 b8 0b 00 00 00 0f 05 48 3d 01 f0 ff ff 73 01 c3 48 8d 0d 21 1f 01 00 f7 d8 89 01 48 83 c8 ff c3 b8 0a 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d 01 1f 01 00 f7 d8 89 01 48 83
RSP: 002b:00007ffda9278dc8 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007faf14cac000 RCX: 00007faf14fef297
RDX: 0000000000000001 RSI: 0000000000001000 RDI: 00007faf14caa000
RBP: 00007ffda9278ee0 R08: 000000000000ffff R09: 00007faf14dd2d00
R10: 00007faf14caaeb8 R11: 0000000000000206 R12: 00007faf14cac000
R13: 0000000000000007 R14: 0000001700000007 R15: 00007faf14ca75f8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vma_merge+0x234/0x1fd0 mm/mmap.c:952
Code: 08 00 0f 84 b0 03 00 00 e8 e9 54 bf ff 48 8b 44 24 08 48 8d b8 a8 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 4d 18 00 00 48 8b 44 24 08 48 8b b0 a8 00 00 00
RSP: 0018:ffffc9000c24fac8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88801cbb2100 RCX: 0000000000000000
RDX: 0000000000000015 RSI: ffffffff81c37957 RDI: 00000000000000a9
RBP: ffff888027fee400 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 00007faf14caa000 R15: ffff88801d2b3400
FS:  00007faf14ca4800(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020004000 CR3: 0000000078d00000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 00                	or     %al,(%rax)
   2:	0f 84 b0 03 00 00    	je     0x3b8
   8:	e8 e9 54 bf ff       	callq  0xffbf54f6
   d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  12:	48 8d b8 a8 00 00 00 	lea    0xa8(%rax),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 4d 18 00 00    	jne    0x1881
  34:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  39:	48 8b b0 a8 00 00 00 	mov    0xa8(%rax),%rsi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
