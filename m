Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D087861695A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiKBQlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKBQkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:40:49 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDDE2D1C6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:35:48 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id l14-20020a056e021c0e00b00300770134f9so17646697ilh.16
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a8a8pdB9brqoxhciTuvtD2zUlSurbIuhzwcNEFt2vRY=;
        b=fCYUIxWWcRXzd+E4eL/TBxnBXwGXbwW8pepu0lY1l4ceWbMBmCAzx3+xxbwLd2GoPr
         QtidGqeoYxaP1L3DPA1mp6vuHhRvxoS7QALZs/MtRKoi5JsSUSnwsy4BJr+tAFIcYYRg
         QhDKe8K08fG2jbuuSpYdyHOZzuq5eaQ1nXoxSlBP7jF34mKi8gp2NOltPtSKIzbYwni9
         BJEP76Z63Ug21UvTB0Rn6ye+gDZJycCuwPOvfbSlwNDsJ9x2MugKh8sNzDmaRQPnhl4p
         JbTF+ciVgdd9reWsNnpvx2/SIoycnuS87IMjtTQ5FPG2NuQ6zx7p05YYmdLcqKxT8cqr
         PLdQ==
X-Gm-Message-State: ACrzQf2bsxMkzDIt2KUi5rpJaoMffvhR0gEa00u6mXjWtHww/Ahj3orV
        q6ktVRAKtXkeZARzKQP6TpcLQZYPSuniz6elpo0hD0mxN7Wv
X-Google-Smtp-Source: AMsMyM7JIQOJAJXlBbWfcco4f07XNP9vMPlk9wU6FI7MucFRDM3fai3m8UjPCUUv3L9kmvXXd89AFZELv55ydRPoC0zQzlCXZgC1
MIME-Version: 1.0
X-Received: by 2002:a02:ccab:0:b0:375:4a9b:1804 with SMTP id
 t11-20020a02ccab000000b003754a9b1804mr15562002jap.145.1667406947376; Wed, 02
 Nov 2022 09:35:47 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:35:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb639605ec7f6e10@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in ovl_set_acl
From:   syzbot <syzbot+3f6ef1c4586bb6fd1f61@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

HEAD commit:    61c3426aca2c Add linux-next specific files for 20221102
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178f72ac880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acb529cc910d907c
dashboard link: https://syzkaller.appspot.com/bug?extid=3f6ef1c4586bb6fd1f61
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc56d88dd6a3/disk-61c3426a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5921b65b080f/vmlinux-61c3426a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39cbd355fedd/bzImage-61c3426a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f6ef1c4586bb6fd1f61@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffffc3
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD bc8f067 P4D bc8f067 PUD bc91067 PMD 0 
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 25127 Comm: syz-executor.4 Not tainted 6.1.0-rc3-next-20221102-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:arch_atomic_fetch_sub arch/x86/include/asm/atomic.h:190 [inline]
RIP: 0010:atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:177 [inline]
RIP: 0010:__refcount_sub_and_test include/linux/refcount.h:272 [inline]
RIP: 0010:__refcount_dec_and_test include/linux/refcount.h:315 [inline]
RIP: 0010:refcount_dec_and_test include/linux/refcount.h:333 [inline]
RIP: 0010:posix_acl_release include/linux/posix_acl.h:57 [inline]
RIP: 0010:posix_acl_release include/linux/posix_acl.h:55 [inline]
RIP: 0010:ovl_set_or_remove_acl fs/overlayfs/inode.c:624 [inline]
RIP: 0010:ovl_set_acl+0x730/0x910 fs/overlayfs/inode.c:685
Code: a3 24 ff 4c 89 ff 49 89 c4 e8 cc 2f 81 fe 4d 85 e4 74 7f e8 52 e9 ac fe be 04 00 00 00 4c 89 e7 bb ff ff ff ff e8 60 7a f9 fe <f0> 41 0f c1 1c 24 bf 01 00 00 00 89 de e8 fe e5 ac fe 83 fb 01 0f
RSP: 0018:ffffc9001264fad8 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 00000000ffffffff RCX: ffffffff82cff810
RDX: fffffbfffffffff9 RSI: 0000000000000004 RDI: ffffffffffffffc3
RBP: ffff88804ebd2bc0 R08: 0000000000000001 R09: ffffffffffffffc6
R10: fffffbfffffffff8 R11: 0000000000000001 R12: ffffffffffffffc3
R13: ffff88804e8985f8 R14: 1ffff920024c9f60 R15: ffff88801f580100
FS:  00007fb9df1ff700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffc3 CR3: 000000004dcf4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 set_posix_acl+0x257/0x320 fs/posix_acl.c:957
 vfs_remove_acl+0x272/0x630 fs/posix_acl.c:1209
 removexattr+0x12a/0x1b0 fs/xattr.c:894
 path_removexattr+0x174/0x1a0 fs/xattr.c:910
 __do_sys_removexattr fs/xattr.c:924 [inline]
 __se_sys_removexattr fs/xattr.c:921 [inline]
 __x64_sys_removexattr+0x55/0x80 fs/xattr.c:921
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb9dfe8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb9df1ff168 EFLAGS: 00000246 ORIG_RAX: 00000000000000c5
RAX: ffffffffffffffda RBX: 00007fb9dffabf80 RCX: 00007fb9dfe8b5a9
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 00007fb9dfee67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdbc7f682f R14: 00007fb9df1ff300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: ffffffffffffffc3
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_fetch_sub arch/x86/include/asm/atomic.h:190 [inline]
RIP: 0010:atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:177 [inline]
RIP: 0010:__refcount_sub_and_test include/linux/refcount.h:272 [inline]
RIP: 0010:__refcount_dec_and_test include/linux/refcount.h:315 [inline]
RIP: 0010:refcount_dec_and_test include/linux/refcount.h:333 [inline]
RIP: 0010:posix_acl_release include/linux/posix_acl.h:57 [inline]
RIP: 0010:posix_acl_release include/linux/posix_acl.h:55 [inline]
RIP: 0010:ovl_set_or_remove_acl fs/overlayfs/inode.c:624 [inline]
RIP: 0010:ovl_set_acl+0x730/0x910 fs/overlayfs/inode.c:685
Code: a3 24 ff 4c 89 ff 49 89 c4 e8 cc 2f 81 fe 4d 85 e4 74 7f e8 52 e9 ac fe be 04 00 00 00 4c 89 e7 bb ff ff ff ff e8 60 7a f9 fe <f0> 41 0f c1 1c 24 bf 01 00 00 00 89 de e8 fe e5 ac fe 83 fb 01 0f
RSP: 0018:ffffc9001264fad8 EFLAGS: 00010246
RAX: 0000000000000001 RBX: 00000000ffffffff RCX: ffffffff82cff810
RDX: fffffbfffffffff9 RSI: 0000000000000004 RDI: ffffffffffffffc3
RBP: ffff88804ebd2bc0 R08: 0000000000000001 R09: ffffffffffffffc6
R10: fffffbfffffffff8 R11: 0000000000000001 R12: ffffffffffffffc3
R13: ffff88804e8985f8 R14: 1ffff920024c9f60 R15: ffff88801f580100
FS:  00007fb9df1ff700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffc3 CR3: 000000004dcf4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	a3 24 ff 4c 89 ff 49 	movabs %eax,0xc48949ff894cff24
   7:	89 c4
   9:	e8 cc 2f 81 fe       	callq  0xfe812fda
   e:	4d 85 e4             	test   %r12,%r12
  11:	74 7f                	je     0x92
  13:	e8 52 e9 ac fe       	callq  0xfeace96a
  18:	be 04 00 00 00       	mov    $0x4,%esi
  1d:	4c 89 e7             	mov    %r12,%rdi
  20:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  25:	e8 60 7a f9 fe       	callq  0xfef97a8a
* 2a:	f0 41 0f c1 1c 24    	lock xadd %ebx,(%r12) <-- trapping instruction
  30:	bf 01 00 00 00       	mov    $0x1,%edi
  35:	89 de                	mov    %ebx,%esi
  37:	e8 fe e5 ac fe       	callq  0xfeace63a
  3c:	83 fb 01             	cmp    $0x1,%ebx
  3f:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
