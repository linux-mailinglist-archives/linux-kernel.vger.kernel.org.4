Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6E5F4D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJEBAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJEA75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 20:59:57 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551AFDFA9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:59:54 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id t21-20020a056602181500b006b3a8e8450eso1692296ioh.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 17:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=YHUyIr0Z4lNXcW70yHEPnPkNnSFUdrIFsfZTWmB0ysc=;
        b=K/O24XgYaEUmqL4qAcmFxPznR3s4ZP6/pMnyCG3RcQvBJEUiQM3RqHwi1xfXcXDY6y
         KBZkN1OWLIASJpCyH64vr5Jc2fijkp0caJLW71Di8iog5iTH1TXr/BQcVyXjogIkEP16
         O+pSZDNRhtaVcixu2ml2g4J5Ts9cfLKA+FVVVzgtj5J9NhHiXqewwAAxXFp61uzKEupY
         AW2omamQLRca+8y2CXSvkaV13hKYRXaK6jgZyotdyS3QkAiP3rrPz8OgZVclpKLs0vk9
         DWnKNgZjYzC5ehzHLCKZALf/eLZKZihXIdCa/E5eCEOw/ws7+LufG7JjcV8Xdzghl5Dc
         087w==
X-Gm-Message-State: ACrzQf2pAPHjQFiZCYdeZwIPvXPhKNDZ8U2bxLFizwX1yUabqAoE2uWd
        LNjIXbspU52Fn36pC+koZgjvjDWbKUJPVXqIa3dZpzJoGq2n
X-Google-Smtp-Source: AMsMyM58LKgMFzycBM/mWQDV3u0tUxz/rsoP3qOEYBk9hz3eoYkRZQRfM91pWE2ozVFJ24o3FHUNXZ9Tvkw+Kb1CK3Z+b+Xlw2W9
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4d:b0:2f9:bb5c:3988 with SMTP id
 u13-20020a056e021a4d00b002f9bb5c3988mr6420770ilv.239.1664931593735; Tue, 04
 Oct 2022 17:59:53 -0700 (PDT)
Date:   Tue, 04 Oct 2022 17:59:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000385cbf05ea3f1862@google.com>
Subject: [syzbot] general protection fault in kernfs_get_inode
From:   syzbot <syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

HEAD commit:    0326074ff465 Merge tag 'net-next-6.1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1067555c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1de7ca9efcc028c
dashboard link: https://syzkaller.appspot.com/bug?extid=534ee3d24c37c411f37f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43729d6ce2fc/disk-0326074f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f76d6f68eb3/vmlinux-0326074f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+534ee3d24c37c411f37f@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
CPU: 1 PID: 29107 Comm: syz-executor.3 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:kernfs_ino include/linux/kernfs.h:358 [inline]
RIP: 0010:kernfs_get_inode+0x2e/0x520 fs/kernfs/inode.c:254
Code: 41 56 41 55 41 54 49 89 fc 53 48 89 f3 e8 1a 04 7e ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 3a 04 00 00 48 8b b3 90 00 00 00 4c 89 e7 e8 79
RSP: 0018:ffffc9000323fa30 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc900069ba000
RDX: 0000000000000012 RSI: ffffffff81fd1156 RDI: 0000000000000090
RBP: ffffc9000323fa50 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000000007c R12: ffff8880205d4000
R13: ffff88802368b000 R14: ffff88801ba6d880 R15: ffff88802378e000
FS:  00007fa73c7aa700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd6239b0000 CR3: 00000000782f6000 CR4: 00000000003526e0
Call Trace:
 <TASK>
 cgroup_may_write+0x86/0x120 kernel/cgroup/cgroup.c:4937
 cgroup_css_set_fork kernel/cgroup/cgroup.c:6237 [inline]
 cgroup_can_fork+0x961/0xec0 kernel/cgroup/cgroup.c:6331
 copy_process+0x43ed/0x7090 kernel/fork.c:2358
 kernel_clone+0xe7/0xab0 kernel/fork.c:2671
 __do_sys_clone3+0x1cd/0x2e0 kernel/fork.c:2963
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa73b68a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa73c7aa038 EFLAGS: 00000246 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007fa73b7abf80 RCX: 00007fa73b68a5a9
RDX: 0000000000000000 RSI: 0000000000000058 RDI: 00007fa73c7aa050
RBP: 00007fa73b6e5580 R08: 0000000000000000 R09: 0000000000000058
R10: 00007fa73c7aa050 R11: 0000000000000246 R12: 0000000000000058
R13: 00007fa73bcdfb1f R14: 00007fa73c7aa300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kernfs_ino include/linux/kernfs.h:358 [inline]
RIP: 0010:kernfs_get_inode+0x2e/0x520 fs/kernfs/inode.c:254
Code: 41 56 41 55 41 54 49 89 fc 53 48 89 f3 e8 1a 04 7e ff 48 8d bb 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 3a 04 00 00 48 8b b3 90 00 00 00 4c 89 e7 e8 79
RSP: 0018:ffffc9000323fa30 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc900069ba000
RDX: 0000000000000012 RSI: ffffffff81fd1156 RDI: 0000000000000090
RBP: ffffc9000323fa50 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000000007c R12: ffff8880205d4000
R13: ffff88802368b000 R14: ffff88801ba6d880 R15: ffff88802378e000
FS:  00007fa73c7aa700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200e6000 CR3: 00000000782f6000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	41 56                	push   %r14
   2:	41 55                	push   %r13
   4:	41 54                	push   %r12
   6:	49 89 fc             	mov    %rdi,%r12
   9:	53                   	push   %rbx
   a:	48 89 f3             	mov    %rsi,%rbx
   d:	e8 1a 04 7e ff       	callq  0xff7e042c
  12:	48 8d bb 90 00 00 00 	lea    0x90(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 3a 04 00 00    	jne    0x46e
  34:	48 8b b3 90 00 00 00 	mov    0x90(%rbx),%rsi
  3b:	4c 89 e7             	mov    %r12,%rdi
  3e:	e8                   	.byte 0xe8
  3f:	79                   	.byte 0x79


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
