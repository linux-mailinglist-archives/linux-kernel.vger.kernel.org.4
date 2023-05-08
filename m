Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974786FA19E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjEHHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbjEHHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:53:58 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E06059E7
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 00:53:51 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3313d6bcc76so28632855ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 00:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683532430; x=1686124430;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6THjU9G7GWWkzKSUk+M6cXMclI+q/U9yXztnzFrTX5A=;
        b=FO86yvNFKoBMxX35lPUQfkobeoU6mHUx6JxAvb5Ot57ih11tU8VFvZGNKCEU2H7eUH
         vpCMfAINUacIa7Ios++n9Qe1UaDhG3+Sy94kF2Yk8nudGPz0hm0zTltG1NqgqG+aeyNp
         D4radR7HRH07E87A5cCowVHwPwn2Yt7HobYgejX4zsUrgZx/xS4ygIYO5dHOMtwZKA9L
         S2oB2IKRRgL1r54VOy3Pi98UtNAxwBpsifgRIEBj3L4GM63Nm4CTvWke+pscGBwMM/TP
         AvTuXfgmUeIOYa8hUk68neaiYfqePD3eqEMJbcgXrwodyAEpx/N8HsZBOWdZLs8O1aTd
         mlEg==
X-Gm-Message-State: AC+VfDzfkmdIDknNYoKjP6Of7eY9hz8UzK0LqUi+3AS7aYR+eKIg905Q
        ywUMgEINnUXVuME5t5rOhTeoJd6JqkLxlTWTNY5kxz+sxWE2
X-Google-Smtp-Source: ACHHUZ7uEWCFS94+1wObozpsCwTvPiLDKzdl4aPIC2cf3eu6FjwjmFnUWvT3535f/DiImxvwhew1x9MK0wsz/0lVb1BhN85rIrN+
MIME-Version: 1.0
X-Received: by 2002:a02:a145:0:b0:416:5d12:9550 with SMTP id
 m5-20020a02a145000000b004165d129550mr4759256jah.5.1683532430678; Mon, 08 May
 2023 00:53:50 -0700 (PDT)
Date:   Mon, 08 May 2023 00:53:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fa2d705fb29f046@google.com>
Subject: [syzbot] [crypto?] general protection fault in __aria_aesni_avx_gfni_crypt_16way
From:   syzbot <syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2e1e1337881b Merge tag '6.4-rc-ksmbd-server-fixes-part2' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122a50b8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c1d541e02d3faec
dashboard link: https://syzkaller.appspot.com/bug?extid=a6abcf08bad8b18fd198
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2e1e1337.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/38d33ceb7578/vmlinux-2e1e1337.xz
kernel image: https://storage.googleapis.com/syzbot-assets/91f968ac33ba/bzImage-2e1e1337.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com

general protection fault, maybe for address 0xffffffff8c123858: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 19386 Comm: syz-executor.0 Not tainted 6.3.0-syzkaller-13390-g2e1e1337881b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:__aria_aesni_avx_gfni_crypt_16way+0x2a6/0x4f40 arch/x86/crypto/aria-aesni-avx-asm_64.S:1164
Code: d0 10 c4 e2 69 00 d7 c5 11 ef ea c5 e9 72 d0 08 c4 e2 69 00 d7 c5 09 ef f2 c4 e2 79 00 d7 c5 01 ef fa c5 f9 6f 05 5a ac c8 0a <c5> f9 6f 0d 4a ac c8 0a c5 f9 6f 15 5a ac c8 0a c5 f9 6f 1d 32 ac
RSP: 0018:ffffc90021a67048 EFLAGS: 00010286
RAX: ffff888027fc2890 RBX: 0000000000000000 RCX: ffff888027fc2890
RDX: ffff888027fc2890 RSI: ffff888027fc2890 RDI: ffff88802731c828
RBP: ffff888015ef8d00 R08: ffff888027fc2910 R09: ffff88802731c828
R10: ffff888015ef8c00 R11: ffff888015ef8c00 R12: ffff888015ef8d00
R13: ffff88802731c828 R14: dffffc0000000000 R15: ffff888027fc2890
FS:  00007f8122ec1700(0000) GS:ffff88802c700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002cc0 CR3: 0000000076f07000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 aria_aesni_avx_gfni_ctr_crypt_16way+0x1d/0x110 arch/x86/crypto/aria-aesni-avx-asm_64.S:1339
 aria_avx_ctr_encrypt+0x180/0x680 arch/x86/crypto/aria_aesni_avx_glue.c:103
 crypto_skcipher_encrypt+0xbc/0x100 crypto/skcipher.c:653
 crypto_skcipher_encrypt+0xbc/0x100 crypto/skcipher.c:653
 crypto_gcm_encrypt+0x393/0x4b0 crypto/gcm.c:459
 crypto_aead_encrypt+0xbc/0x100 crypto/aead.c:121
 tls_do_encryption net/tls/tls_sw.c:544 [inline]
 tls_push_record+0x12d8/0x30f0 net/tls/tls_sw.c:777
 bpf_exec_tx_verdict+0xdf0/0x1210 net/tls/tls_sw.c:817
 tls_sw_sendmsg+0x100b/0x1850 net/tls/tls_sw.c:1033
 inet6_sendmsg+0x9d/0xe0 net/ipv6/af_inet6.c:651
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 sock_write_iter+0x295/0x3d0 net/socket.c:1140
 call_write_iter include/linux/fs.h:1868 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x185/0x7e0 fs/read_write.c:860
 vfs_writev+0x1aa/0x670 fs/read_write.c:933
 do_writev+0x279/0x2f0 fs/read_write.c:976
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f812208c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8122ec1168 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f81221abf80 RCX: 00007f812208c169
RDX: 0000000000000001 RSI: 0000000020003d00 RDI: 0000000000000003
RBP: 00007f81220e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe74050cff R14: 00007f8122ec1300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__aria_aesni_avx_gfni_crypt_16way+0x2a6/0x4f40 arch/x86/crypto/aria-aesni-avx-asm_64.S:1164
Code: d0 10 c4 e2 69 00 d7 c5 11 ef ea c5 e9 72 d0 08 c4 e2 69 00 d7 c5 09 ef f2 c4 e2 79 00 d7 c5 01 ef fa c5 f9 6f 05 5a ac c8 0a <c5> f9 6f 0d 4a ac c8 0a c5 f9 6f 15 5a ac c8 0a c5 f9 6f 1d 32 ac
RSP: 0018:ffffc90021a67048 EFLAGS: 00010286
RAX: ffff888027fc2890 RBX: 0000000000000000 RCX: ffff888027fc2890
RDX: ffff888027fc2890 RSI: ffff888027fc2890 RDI: ffff88802731c828
RBP: ffff888015ef8d00 R08: ffff888027fc2910 R09: ffff88802731c828
R10: ffff888015ef8c00 R11: ffff888015ef8c00 R12: ffff888015ef8d00
R13: ffff88802731c828 R14: dffffc0000000000 R15: ffff888027fc2890
FS:  00007f8122ec1700(0000) GS:ffff88802c700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002cc0 CR3: 0000000076f07000 CR4: 0000000000350ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	d0 10                	rclb   (%rax)
   2:	c4 e2 69 00 d7       	vpshufb %xmm7,%xmm2,%xmm2
   7:	c5 11 ef ea          	vpxor  %xmm2,%xmm13,%xmm13
   b:	c5 e9 72 d0 08       	vpsrld $0x8,%xmm0,%xmm2
  10:	c4 e2 69 00 d7       	vpshufb %xmm7,%xmm2,%xmm2
  15:	c5 09 ef f2          	vpxor  %xmm2,%xmm14,%xmm14
  19:	c4 e2 79 00 d7       	vpshufb %xmm7,%xmm0,%xmm2
  1e:	c5 01 ef fa          	vpxor  %xmm2,%xmm15,%xmm15
  22:	c5 f9 6f 05 5a ac c8 	vmovdqa 0xac8ac5a(%rip),%xmm0        # 0xac8ac84
  29:	0a
* 2a:	c5 f9 6f 0d 4a ac c8 	vmovdqa 0xac8ac4a(%rip),%xmm1        # 0xac8ac7c <-- trapping instruction
  31:	0a
  32:	c5 f9 6f 15 5a ac c8 	vmovdqa 0xac8ac5a(%rip),%xmm2        # 0xac8ac94
  39:	0a
  3a:	c5                   	.byte 0xc5
  3b:	f9                   	stc
  3c:	6f                   	outsl  %ds:(%rsi),(%dx)
  3d:	1d                   	.byte 0x1d
  3e:	32                   	.byte 0x32
  3f:	ac                   	lods   %ds:(%rsi),%al


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
