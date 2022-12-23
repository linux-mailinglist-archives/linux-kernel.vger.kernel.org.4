Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D7B654C39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 06:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiLWFcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 00:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiLWFci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 00:32:38 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850901DDDB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 21:32:36 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id l21-20020a5d9315000000b006df7697880aso1558869ion.23
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 21:32:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni4mphJUAgKMmVIzV7kxWJxdUZPFnCiR6GRzfr562dI=;
        b=SqtrAyoe0c3t3KplDbJ8FKwjVw10u5va8HQ4o6gORUGcXBlyqhmY+TSkaLI7HTkvsZ
         muBH6GzZonZYfeNPnK0taeOiA6YSSq0tlp6sg4cHU2YRWhs387Zxf7KtQMHDmFFZjZ6v
         lFV1GQ94l9+/3YAUHlHGET72fv0FMoFMIr7p0nevTUWoN9H37nDzAWThGbnt+/lSk550
         6a7UyKhNG7JN36I2PIOAp11fNKsKw/kAwRq4SGjFUsgn9BCBf121GeaDyqkWfEvdrjVQ
         oZ87xYmI6bf67cuTaB++SGD+2hubslFNFFoTY7xEHdFNDQOU5tlsb6REzwekSqQvpS3/
         zNpA==
X-Gm-Message-State: AFqh2kofvP4GEvxei06nsl+W92A1Cl3coQJGpsiVFRzjGmvQFgpzeY7f
        ma7YPaMtIMGVZxvAnpnt1TG0IZDDJEv4bxMAXf3yOY8hCsbD
X-Google-Smtp-Source: AMrXdXteYysgp1onezYl2qAiqNPVZ7UUQkAAykSC78EksEOi4lbDygNp2+XhGAbZsP3KcqmegfzemxW1c1bp4hMInYiveCKCygcm
MIME-Version: 1.0
X-Received: by 2002:a92:b703:0:b0:309:1c59:dd30 with SMTP id
 k3-20020a92b703000000b003091c59dd30mr601758ili.225.1671773555919; Thu, 22 Dec
 2022 21:32:35 -0800 (PST)
Date:   Thu, 22 Dec 2022 21:32:35 -0800
In-Reply-To: <0000000000003b7fee05eec392a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f213ae05f0781c98@google.com>
Subject: Re: [syzbot] [reiserfs?] [fat?] BUG: unable to handle kernel paging
 request in take_dentry_name_snapshot
From:   syzbot <syzbot+90392eaed540afcc8fc3@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    8395ae05cb5a Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1310a5f8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85327a149d5f50f
dashboard link: https://syzkaller.appspot.com/bug?extid=90392eaed540afcc8fc3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16199460480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1797f274480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/71f6a8070e91/disk-8395ae05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f742b65488c/vmlinux-8395ae05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6e5588eaf267/bzImage-8395ae05.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4673a4f9cbbb/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+90392eaed540afcc8fc3@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffffffff81629
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD c48f067 P4D c48f067 PUD c491067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5251 Comm: syz-executor130 Not tainted 6.1.0-syzkaller-14446-g8395ae05cb5a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__lock_acquire+0xd8d/0x56d0 kernel/locking/lockdep.c:4925
Code: c8 00 00 00 89 05 83 4e 3c 0f e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 4e 31 00 00 <49> 81 3e e0 e5 f6 8f 0f 84 4c f3 ff ff 41 83 fc 01 0f 87 54 f3 ff
RSP: 0018:ffffc90004e0f7e8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 1ffff920009c1f2d RCX: 0000000000000000
RDX: 1fffffffffff02c5 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1ce5ada R11: 0000000000000000 R12: 0000000000000000
R13: ffff88802c3a1d40 R14: fffffffffff81629 R15: 0000000000000000
FS:  00007fab0371d700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffff81629 CR3: 000000006e8d9000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 take_dentry_name_snapshot+0x2b/0x170 fs/dcache.c:315
 ovl_check_rename_whiteout fs/overlayfs/super.c:1207 [inline]
 ovl_make_workdir fs/overlayfs/super.c:1329 [inline]
 ovl_get_workdir fs/overlayfs/super.c:1444 [inline]
 ovl_fill_super+0x1dd2/0x6330 fs/overlayfs/super.c:2000
 mount_nodev+0x64/0x120 fs/super.c:1405
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fab03f80209
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fab0371d208 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fab04005528 RCX: 00007fab03f80209
RDX: 0000000020000080 RSI: 00000000200000c0 RDI: 0000000000000000
RBP: 00007fab04005520 R08: 0000000020000480 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fab0400552c
R13: 00007ffcd399fc6f R14: 00007fab0371d300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: fffffffffff81629
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xd8d/0x56d0 kernel/locking/lockdep.c:4925
Code: c8 00 00 00 89 05 83 4e 3c 0f e9 bd 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 80 3c 02 00 0f 85 4e 31 00 00 <49> 81 3e e0 e5 f6 8f 0f 84 4c f3 ff ff 41 83 fc 01 0f 87 54 f3 ff
RSP: 0018:ffffc90004e0f7e8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 1ffff920009c1f2d RCX: 0000000000000000
RDX: 1fffffffffff02c5 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff1ce5ada R11: 0000000000000000 R12: 0000000000000000
R13: ffff88802c3a1d40 R14: fffffffffff81629 R15: 0000000000000000
FS:  00007fab0371d700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffffffff81629 CR3: 000000006e8d9000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	c8 00 00 00          	enterq $0x0,$0x0
   4:	89 05 83 4e 3c 0f    	mov    %eax,0xf3c4e83(%rip)        # 0xf3c4e8d
   a:	e9 bd 00 00 00       	jmpq   0xcc
   f:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  16:	fc ff df
  19:	4c 89 f2             	mov    %r14,%rdx
  1c:	48 c1 ea 03          	shr    $0x3,%rdx
  20:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  24:	0f 85 4e 31 00 00    	jne    0x3178
* 2a:	49 81 3e e0 e5 f6 8f 	cmpq   $0xffffffff8ff6e5e0,(%r14) <-- trapping instruction
  31:	0f 84 4c f3 ff ff    	je     0xfffff383
  37:	41 83 fc 01          	cmp    $0x1,%r12d
  3b:	0f                   	.byte 0xf
  3c:	87 54 f3 ff          	xchg   %edx,-0x1(%rbx,%rsi,8)

