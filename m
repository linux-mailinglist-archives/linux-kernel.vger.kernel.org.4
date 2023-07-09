Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832AD74C164
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 09:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGIHM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 03:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGIHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 03:12:55 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205F9E0
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 00:12:54 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-55bf3002ac7so4995570a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 00:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688886773; x=1691478773;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tN9eCuoQJK5r7yO0Q3UwOJTk3JYRippue8vhC0f4wvw=;
        b=X5B+U+Li9fELRp1hDQOWpmcEfTsNT4Nl5kCw1fpX/0+QfoINqTjRNbt2yIC1ANPM7z
         1c9p810a3gpdrDniPgAicstIi3TCUzS2LDD6JdraZ+iBqRZUlI81j9iuak7Kb0SDBHDJ
         rRJMmyLHHEgvIHdoQpG7rPfCXImuXaXgLz6CNtfeiZxL1MINusFithvJfEFAms1rhjNx
         /oH9n/jKRia4DKewwnFsTJ4WIUh69b2Ww1F356pvINGbjMucfhU8cgxr8sfKWbih/5GW
         3QRqeXqY7kTRrMpaV1Vp2pYZSvcD7Ra8DJFF4t7UjO6ZFFyhceKTiUckclwh83nXhzCl
         uxkw==
X-Gm-Message-State: ABy/qLbH1hftiSU0M1zL2d0E+2zOxpw823snW+IKIx2dAxc+9+h/UTeS
        1ysDq6cM6ysC+FRPe2zkZCOjMqfkI8+mTiJN1z9cRvOHWcfE
X-Google-Smtp-Source: APBJJlHoIdLrINdMqDqRopJ83TYrqT5+tNvqbXszhLzVJRaazf8xVWx3TvBArCledJQ8QV9zoa/a/A1aa6FAfvrOfos2MvO8UKqr
MIME-Version: 1.0
X-Received: by 2002:a63:b10b:0:b0:55b:f64a:dd50 with SMTP id
 r11-20020a63b10b000000b0055bf64add50mr6614578pgf.0.1688886773647; Sun, 09 Jul
 2023 00:12:53 -0700 (PDT)
Date:   Sun, 09 Jul 2023 00:12:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000358f04060008984c@google.com>
Subject: [syzbot] [mm?] general protection fault in filemap_release_folio
From:   syzbot <syzbot+05a4b28d3ba52e73b4c6@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    123212f53f3e Add linux-next specific files for 20230707
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12cd9964a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ec80b62f588543
dashboard link: https://syzkaller.appspot.com/bug?extid=05a4b28d3ba52e73b4c6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/098f7ee2237c/disk-123212f5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88defebbfc49/vmlinux-123212f5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5e9343ec16a/bzImage-123212f5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05a4b28d3ba52e73b4c6@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xffdffc001fc10009: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xff000000fe080048-0xff000000fe08004f]
CPU: 0 PID: 17492 Comm: syz-executor.4 Not tainted 6.4.0-next-20230707-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
RIP: 0010:filemap_release_folio+0x1e6/0x2a0 mm/filemap.c:4082
Code: 48 c1 ea 03 80 3c 02 00 0f 85 ac 00 00 00 48 8b 9b e8 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 48 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 90 00 00 00 48 8b 5b 48 48 85 db 74 23 e8 a2 dd
RSP: 0018:ffffc900053f71b8 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ff000000fe080001 RCX: ffffc9000c36a000
RDX: 1fe000001fc10009 RSI: ffffffff81b10a98 RDI: ff000000fe080049
RBP: ffffea0000c5af00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000cc0 R14: 0000000000000000 R15: ffff88807d7950d1
FS:  00007f39a8bfa700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f39a8c19698 CR3: 0000000026575000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 shrink_folio_list+0x291e/0x3e60 mm/vmscan.c:2068
 reclaim_folio_list+0xd0/0x390 mm/vmscan.c:2801
 reclaim_pages+0x442/0x670 mm/vmscan.c:2837
 madvise_cold_or_pageout_pte_range+0x100e/0x1ee0 mm/madvise.c:533
 walk_pmd_range mm/pagewalk.c:140 [inline]
 walk_pud_range mm/pagewalk.c:218 [inline]
 walk_p4d_range mm/pagewalk.c:253 [inline]
 walk_pgd_range+0x9e7/0x1470 mm/pagewalk.c:290
 __walk_page_range+0x651/0x780 mm/pagewalk.c:392
 walk_page_range+0x311/0x4a0 mm/pagewalk.c:490
 madvise_pageout_page_range mm/madvise.c:591 [inline]
 madvise_pageout+0x2fe/0x560 mm/madvise.c:618
 madvise_vma_behavior+0x61a/0x21a0 mm/madvise.c:1039
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1268
 do_madvise.part.0+0x276/0x490 mm/madvise.c:1448
 do_madvise mm/madvise.c:1461 [inline]
 __do_sys_madvise mm/madvise.c:1461 [inline]
 __se_sys_madvise mm/madvise.c:1459 [inline]
 __x64_sys_madvise+0x117/0x150 mm/madvise.c:1459
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f39a7e8c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f39a8bfa168 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f39a7fac050 RCX: 00007f39a7e8c389
RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00007f39a7ed7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe1ce83f1f R14: 00007f39a8bfa300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:filemap_release_folio+0x1e6/0x2a0 mm/filemap.c:4082
Code: 48 c1 ea 03 80 3c 02 00 0f 85 ac 00 00 00 48 8b 9b e8 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 48 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 90 00 00 00 48 8b 5b 48 48 85 db 74 23 e8 a2 dd
RSP: 0018:ffffc900053f71b8 EFLAGS: 00010a06

RAX: dffffc0000000000 RBX: ff000000fe080001 RCX: ffffc9000c36a000
RDX: 1fe000001fc10009 RSI: ffffffff81b10a98 RDI: ff000000fe080049
RBP: ffffea0000c5af00 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000cc0 R14: 0000000000000000 R15: ffff88807d7950d1
FS:  00007f39a8bfa700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3c3a1831b8 CR3: 0000000026575000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 ac 00 00 00    	jne    0xba
   e:	48 8b 9b e8 01 00 00 	mov    0x1e8(%rbx),%rbx
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 8d 7b 48          	lea    0x48(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 90 00 00 00    	jne    0xc4
  34:	48 8b 5b 48          	mov    0x48(%rbx),%rbx
  38:	48 85 db             	test   %rbx,%rbx
  3b:	74 23                	je     0x60
  3d:	e8                   	.byte 0xe8
  3e:	a2                   	.byte 0xa2
  3f:	dd                   	.byte 0xdd


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
