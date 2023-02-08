Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4404668F2A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBHQAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBHQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:00:46 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0319A8A60
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:00:44 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id g6-20020a6b7606000000b007297c4996c7so10746868iom.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=owLCGfndvEnfANmDmt4Szh/S5ZYNgPvGNXOVcbfFK/4=;
        b=yzYYRN3QFP6N8PGXZRS2Dj/py71gZQevi1SlnXrW5bJx/nvVkTLO4WNpkNu29u7cBh
         kjZgX0pp6Yv7wPSRR0V/Ji71+ufZdZvCHW0fierqYcI2rvnoMqWwCsO7UugJfyTjHGOZ
         KT9TZOU4w3cZhJgb5birtEfR3JFG2CDTBDUq/fbXTPZQk5qHbKIjj7Iewx1zdXQTveNW
         fqIDsr0MH3lXEuVDT5ryo2WNZD6K5wqZClY/2sOYH8Tl0J5MmAiO7lalRh97T8raWC4L
         a3Iwil2ILDMdEQ1BxGCqpaQRM4Xzubwq3Gvoy5MDzff0N1iIBrK+AawNg2S5Y2tvbioe
         wnfw==
X-Gm-Message-State: AO0yUKW5VF5yVWOcV2+AkWiJtT5oMqzTHqqhBoXvQUSNka0A+GYP7BRn
        FeWaVPgY9YHYYoHshoO7KNvQeV48dNJ5/2QzhtCq35u6HcfD
X-Google-Smtp-Source: AK7set8QDeVKVZSAVW5NeJBWPPMwxQ8OxU+TKZZwlFseudIegdhuOgP7yepTb1xsK3io05E+xkGjxCNjal1erZBTt3I1xFIotFSV
MIME-Version: 1.0
X-Received: by 2002:a05:6602:81:b0:720:33b0:ae4c with SMTP id
 h1-20020a056602008100b0072033b0ae4cmr4010367iob.51.1675872044302; Wed, 08 Feb
 2023 08:00:44 -0800 (PST)
Date:   Wed, 08 Feb 2023 08:00:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3c8b405f4325d5e@google.com>
Subject: [syzbot] general protection fault in kernfs_link_sibling (3)
From:   syzbot <syzbot+c26da44ece0427e40573@syzkaller.appspotmail.com>
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

HEAD commit:    38d2b86a665b Add linux-next specific files for 20230208
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11293d87480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3691b32dd4410e01
dashboard link: https://syzkaller.appspot.com/bug?extid=c26da44ece0427e40573
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0a9d60e90514/disk-38d2b86a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71311be5f1a1/vmlinux-38d2b86a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a242870cc8eb/bzImage-38d2b86a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c26da44ece0427e40573@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 PID: 10023 Comm: syz-executor.4 Not tainted 6.2.0-rc7-next-20230208-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:__rb_insert lib/rbtree.c:115 [inline]
RIP: 0010:rb_insert_color+0x71/0x7a0 lib/rbtree.c:436
Code: 48 89 d8 48 c1 e8 03 42 80 3c 28 00 0f 85 48 05 00 00 48 8b 2b 40 f6 c5 01 0f 85 81 01 00 00 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 01 05 00 00 4c 8b 75 08 49 39 de 0f 84 6d 01
RSP: 0018:ffffc900064b7610 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff8880228552f8 RCX: ffffc9000cdac000
RDX: 1ffff1100450ab9e RSI: ffff88801c5f6070 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000004 R09: 000000000f8bd940
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888022855cf0
R13: dffffc0000000000 R14: ffff888022855cb0 R15: 0000000000000000
FS:  00007f35ebeae700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32830000 CR3: 000000001cf73000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernfs_link_sibling+0x2a7/0x470 fs/kernfs/dir.c:383
 kernfs_add_one+0x210/0x4f0 fs/kernfs/dir.c:768
 __kernfs_create_file+0x2a0/0x350 fs/kernfs/file.c:1076
 sysfs_add_file_mode_ns+0x213/0x3f0 fs/sysfs/file.c:294
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x322/0xb80 fs/sysfs/group.c:148
 internal_create_groups.part.0+0x90/0x140 fs/sysfs/group.c:188
 internal_create_groups fs/sysfs/group.c:184 [inline]
 sysfs_create_groups+0x29/0x50 fs/sysfs/group.c:214
 device_add_groups drivers/base/core.c:2531 [inline]
 device_add_attrs drivers/base/core.c:2640 [inline]
 device_add+0x678/0x1e10 drivers/base/core.c:3388
 netdev_register_kobject+0x185/0x400 net/core/net-sysfs.c:2015
 register_netdevice+0xd77/0x1640 net/core/dev.c:10051
 __ip_tunnel_create+0x398/0x5b0 net/ipv4/ip_tunnel.c:267
 ip_tunnel_init_net+0x1f9/0x5d0 net/ipv4/ip_tunnel.c:1073
 ops_init+0xb9/0x6b0 net/core/net_namespace.c:135
 setup_net+0x793/0xe60 net/core/net_namespace.c:333
 copy_net_ns+0x320/0x6b0 net/core/net_namespace.c:483
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x449/0x920 kernel/fork.c:3205
 __do_sys_unshare kernel/fork.c:3276 [inline]
 __se_sys_unshare kernel/fork.c:3274 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3274
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f35eb08c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35ebeae168 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f35eb1abf80 RCX: 00007f35eb08c0f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000200
RBP: 00007f35eb0e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdbc64066f R14: 00007f35ebeae300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__rb_insert lib/rbtree.c:115 [inline]
RIP: 0010:rb_insert_color+0x71/0x7a0 lib/rbtree.c:436
Code: 48 89 d8 48 c1 e8 03 42 80 3c 28 00 0f 85 48 05 00 00 48 8b 2b 40 f6 c5 01 0f 85 81 01 00 00 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 01 05 00 00 4c 8b 75 08 49 39 de 0f 84 6d 01
RSP: 0018:ffffc900064b7610 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff8880228552f8 RCX: ffffc9000cdac000
RDX: 1ffff1100450ab9e RSI: ffff88801c5f6070 RDI: 0000000000000008
RBP: 0000000000000000 R08: 0000000000000004 R09: 000000000f8bd940
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888022855cf0
R13: dffffc0000000000 R14: ffff888022855cb0 R15: 0000000000000000
FS:  00007f35ebeae700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32d36000 CR3: 000000001cf73000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 d8             	mov    %rbx,%rax
   3:	48 c1 e8 03          	shr    $0x3,%rax
   7:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
   c:	0f 85 48 05 00 00    	jne    0x55a
  12:	48 8b 2b             	mov    (%rbx),%rbp
  15:	40 f6 c5 01          	test   $0x1,%bpl
  19:	0f 85 81 01 00 00    	jne    0x1a0
  1f:	48 8d 7d 08          	lea    0x8(%rbp),%rdi
  23:	48 89 f8             	mov    %rdi,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	0f 85 01 05 00 00    	jne    0x536
  35:	4c 8b 75 08          	mov    0x8(%rbp),%r14
  39:	49 39 de             	cmp    %rbx,%r14
  3c:	0f                   	.byte 0xf
  3d:	84 6d 01             	test   %ch,0x1(%rbp)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
