Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC1760573B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJTGRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJTGRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:17:05 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC9918B779
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:16:58 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id m16-20020a17090ab79000b0020abf0d3ff4so8226820pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g3RhILIsdBjH805xVaYg94nPQyHHq7YNZ6eTkxF7o6U=;
        b=oS3XixdBYWs0AgGH4mz2MSZOUVuVfFaRk8eAcfKr1l/Zz5UBNbtRDlc9tg7ZsohvCh
         4hbD5fCZnr8Ciz0Kwywo+2sAc/U+7z4csOIQptS2sT2KCBJOdD/gC9aDTrrWdeIWw1a6
         u7TwgtObvb+wnKbnlxoraCJ62M551mRqLEZo94HrL+7+GWmOhaIOmppywSYMXoDwzyhM
         knFUW12rVQtkBwuJ/gvA7wwps36GwC+h9Mi6Dnz6dIXblA8PAxJzfFTQAGqtdO29HiXc
         NZf0yajBCy0q6K+l+kcoXqrwMaqh1++N/h6mvF/0W6OVm/uc/cUg5RBX13QGCq2VeRJi
         83mg==
X-Gm-Message-State: ACrzQf1fJMN6mHcB9itKnBOfMKwNaNX79oeLFrt3DlPfaL9+hmB+CU1y
        Hlz7YRiGm4Fkzd5CE4Ot3pQwRmemkV0KeisZWBYFxmNvxTpV
X-Google-Smtp-Source: AMsMyM6STQIWM4rzVxFj9lolU6gWFvxngXt5tC47tXItvVr0PK09wTot70Ku/eDM+TxMApGwQn7l4TPTbHPYcczHV0XTBR2472gN
MIME-Version: 1.0
X-Received: by 2002:a92:cd83:0:b0:2f9:c29a:9107 with SMTP id
 r3-20020a92cd83000000b002f9c29a9107mr10003805ilb.271.1666246608151; Wed, 19
 Oct 2022 23:16:48 -0700 (PDT)
Date:   Wed, 19 Oct 2022 23:16:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002feb6605eb71458e@google.com>
Subject: [syzbot] general protection fault in _parse_integer_fixup_radix
From:   syzbot <syzbot+db1d2ea936378be0e4ea@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a72b55bc981b Add linux-next specific files for 20221019
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1728c644880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=200524babbc01b2a
dashboard link: https://syzkaller.appspot.com/bug?extid=db1d2ea936378be0e4ea
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12afb08c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11001c72880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fa24fb5893fd/disk-a72b55bc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf1b7e7b579c/vmlinux-a72b55bc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+db1d2ea936378be0e4ea@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 3606 Comm: syz-executor141 Not tainted 6.1.0-rc1-next-20221019-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:_parse_integer_fixup_radix+0x60/0x290 lib/kstrtox.c:29
Code: 02 00 00 41 8b 2c 24 31 ff 89 ee e8 4a ae 76 fd 85 ed 75 62 e8 71 b1 76 fd 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 48 89 da 83 e2 07 38 d0 7f 08 84 c0 0f 85 e2 01 00 00
RSP: 0018:ffffc90003d3fa40 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8405d49f RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000008c001 R12: ffffc90003d3fa90
R13: ffffc90003d3fbd8 R14: 000000007fffffff R15: ffff8880798524d0
FS:  000055555732c300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000007b427000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 simple_strntoull+0x88/0x160 lib/vsprintf.c:68
 memparse+0x72/0x180 lib/cmdline.c:154
 shmem_parse_one+0x6a3/0xa60 mm/shmem.c:3478
 vfs_parse_fs_param fs/fs_context.c:148 [inline]
 vfs_parse_fs_param+0x1f9/0x3c0 fs/fs_context.c:129
 vfs_parse_fs_string+0xdb/0x170 fs/fs_context.c:191
 shmem_parse_options+0x15f/0x240 mm/shmem.c:3570
 do_new_mount fs/namespace.c:3036 [inline]
 path_mount+0x12de/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f012fe73e09
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed54dd188 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f012fe73e09
RDX: 0000000020000040 RSI: 0000000020000000 RDI: 0000000000000000
RBP: 00007f012fe37d20 R08: 0000000020000180 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f012fe37db0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:_parse_integer_fixup_radix+0x60/0x290 lib/kstrtox.c:29
Code: 02 00 00 41 8b 2c 24 31 ff 89 ee e8 4a ae 76 fd 85 ed 75 62 e8 71 b1 76 fd 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 48 89 da 83 e2 07 38 d0 7f 08 84 c0 0f 85 e2 01 00 00
RSP: 0018:ffffc90003d3fa40 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8405d49f RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000008c001 R12: ffffc90003d3fa90
R13: ffffc90003d3fbd8 R14: 000000007fffffff R15: ffff8880798524d0
FS:  000055555732c300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000007b427000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	02 00                	add    (%rax),%al
   2:	00 41 8b             	add    %al,-0x75(%rcx)
   5:	2c 24                	sub    $0x24,%al
   7:	31 ff                	xor    %edi,%edi
   9:	89 ee                	mov    %ebp,%esi
   b:	e8 4a ae 76 fd       	callq  0xfd76ae5a
  10:	85 ed                	test   %ebp,%ebp
  12:	75 62                	jne    0x76
  14:	e8 71 b1 76 fd       	callq  0xfd76b18a
  19:	48 89 da             	mov    %rbx,%rdx
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 da             	mov    %rbx,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 08                	jg     0x40
  38:	84 c0                	test   %al,%al
  3a:	0f 85 e2 01 00 00    	jne    0x222


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
