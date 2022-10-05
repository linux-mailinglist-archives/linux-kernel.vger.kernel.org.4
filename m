Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E995F4D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 02:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJEA6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 20:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiJEA6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 20:58:42 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B01E4151A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:58:41 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id d6-20020a056e02214600b002fa23a188ebso2681301ilv.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 17:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=vckY3SR+Ei6YWKNbidFMpxUix3Jhbeta9t2Q8xWbWgM=;
        b=bqsyRNeeUnPaSmlz/3Nozaet8L8cCMINnhMe23O4hg1hDtUQu2CoFWI0Rj0FSNOCWy
         8dW7YiUd2/P9EGNxStaLWms0FdjDkRja0lthyWqfN/QeVKsmGJA/uZY2SxyPOx8IupaJ
         LzHAyIjF5hTx4PWPyM6KMoV2v9S/dExeegNOQrmnWc45gk5hbUu+D+YGJDYU40YXZS65
         iA+sTKx1jxdaAtegaJq6gTOe0XteTZ0s5Bl6V7XmhI+/mXjTBmQQVO6UKXjj+hjcSHk8
         KdMpRN7tpR07BD0oBkNGI/4Q2OCUdYCXK+aZkj3sR7yV7qYqW9x1kHlo9qZmB9gNBhNS
         9fYQ==
X-Gm-Message-State: ACrzQf0aTM5WNteuczziVHgw+HsqGWAHqjJEPwMRaHq9TsyP8wl7tl9x
        hffEcWmy6MOReR09MbKdzNhXzpeeG6BCN8rcC1mLYPTvBhNa
X-Google-Smtp-Source: AMsMyM5k4nCHDAPCWgLwVGS5st0KF3bs8lU56M/FqM8t3gC9hwEU5F46jlR2boLYsRqIibTq95yQXd/xqBLJKePDdIgo1FjFVC7H
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370d:b0:35a:91f0:e358 with SMTP id
 k13-20020a056638370d00b0035a91f0e358mr14180829jav.84.1664931520836; Tue, 04
 Oct 2022 17:58:40 -0700 (PDT)
Date:   Tue, 04 Oct 2022 17:58:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dffe3105ea3f1362@google.com>
Subject: [syzbot] general protection fault in ntfs_set_inode
From:   syzbot <syzbot+f553b35c5f71737636f7@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0326074ff465 Merge tag 'net-next-6.1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16880492880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1de7ca9efcc028c
dashboard link: https://syzkaller.appspot.com/bug?extid=f553b35c5f71737636f7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f553b35c5f71737636f7@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0004e2d052: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000027168290-0x0000000027168297]
CPU: 1 PID: 4671 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:ntfs_set_inode+0x4a/0x70 fs/ntfs3/inode.c:485
Code: 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 26 48 8d 7d 40 8b 1b 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 13 48 89 5d 40 31 c0 5b 5d c3 48 89 df e8 bf 73 1f
RSP: 0018:ffffc90022fe7968 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 000000000000000a RCX: ffffc90003851000
RDX: 0000000004e2d052 RSI: ffffffff82a8af0d RDI: 0000000027168290
RBP: 0000000027168250 R08: 0000000000000001 R09: 0000000000000003
R10: fffff520045fcf21 R11: 0000000000000000 R12: ffffc90022fe7cb0
R13: ffffffff82a8aeff R14: 0000000000000000 R15: ffff888027168278
FS:  0000000000000000(0000) GS:ffff88802c900000(0063) knlGS:00000000f7fc9b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f7612c78eb0 CR3: 0000000042c19000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 log_replay+0xf7f0/0xf7f0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_set_inode+0x4a/0x70 fs/ntfs3/inode.c:485
Code: 14 02 48 89 d8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 26 48 8d 7d 40 8b 1b 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 13 48 89 5d 40 31 c0 5b 5d c3 48 89 df e8 bf 73 1f
RSP: 0018:ffffc90022fe7968 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 000000000000000a RCX: ffffc90003851000
RDX: 0000000004e2d052 RSI: ffffffff82a8af0d RDI: 0000000027168290
RBP: 0000000027168250 R08: 0000000000000001 R09: 0000000000000003
R10: fffff520045fcf21 R11: 0000000000000000 R12: ffffc90022fe7cb0
R13: ffffffff82a8aeff R14: 0000000000000000 R15: ffff888027168278
FS:  0000000000000000(0000) GS:ffff88802c900000(0063) knlGS:00000000f7fc9b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00007f7612c78eb0 CR3: 0000000042c19000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	14 02                	adc    $0x2,%al
   2:	48 89 d8             	mov    %rbx,%rax
   5:	83 e0 07             	and    $0x7,%eax
   8:	83 c0 03             	add    $0x3,%eax
   b:	38 d0                	cmp    %dl,%al
   d:	7c 04                	jl     0x13
   f:	84 d2                	test   %dl,%dl
  11:	75 26                	jne    0x39
  13:	48 8d 7d 40          	lea    0x40(%rbp),%rdi
  17:	8b 1b                	mov    (%rbx),%ebx
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 13                	jne    0x43
  30:	48 89 5d 40          	mov    %rbx,0x40(%rbp)
  34:	31 c0                	xor    %eax,%eax
  36:	5b                   	pop    %rbx
  37:	5d                   	pop    %rbp
  38:	c3                   	retq
  39:	48 89 df             	mov    %rbx,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	bf                   	.byte 0xbf
  3e:	73 1f                	jae    0x5f


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
