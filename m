Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E346091A7
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 09:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJWH3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 03:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJWH3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 03:29:48 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328691FCCC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:29:45 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id s2-20020a056e02216200b002f9de38e484so6768347ilv.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T49Ky00Q6rRNQe4pUU5ynRg2+0qQfgYGOd9OM+3Bnzc=;
        b=nENZ25RagezwVYA/wsJ9SXisMFjkyfJNsRZZYGYPrqXu3GNUmFwrbKgyPmzkYAibWb
         IhNSwUMKiy0ez8Oib9ZsaZKh55XEnWdqO1ee8sZ65ON6sEZimNnfwhbN5jhn4M+5fUG3
         EUIv/t1ASc5io9IIt9jL7m5eTF8RUkLFMixWWnfYALtIGQk1d3mc13W4LtkvuN1OmiLc
         7Vts/2v19DVTjMaWBCMnw4oRiiPQIs61hB+Jzfnb4338Gw5u7FBFcheYp2J7e7fnRZLI
         +QxdD7I0Y/4c5T5qPzsiVKQL4rIODNZ5LF0WuAJO7/6N5cDFfcuGdiv6s18wKKDLmdRu
         rBfg==
X-Gm-Message-State: ACrzQf1FEkyHFYgKOM1eyLcZzZfzKTmVXTxrhZ5SgyjE/Qaxn5NVNBQd
        aUBtn/Kvjkx7KnEgt9elxbMKBcJGMA+EXYfWq4oGkoLixEHP
X-Google-Smtp-Source: AMsMyM5embqrGQGEktcVUkIOyI5bNCUz6O1vuIdPBVcD0bynMJG12mHyRGcrPErVP2agfNiwkBEQRAo5rXJtqEo1+lSkqHDb/SQu
MIME-Version: 1.0
X-Received: by 2002:a5e:9806:0:b0:6bc:7de8:239f with SMTP id
 s6-20020a5e9806000000b006bc7de8239fmr17561500ioj.20.1666510184427; Sun, 23
 Oct 2022 00:29:44 -0700 (PDT)
Date:   Sun, 23 Oct 2022 00:29:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008eb80505ebaea3d3@google.com>
Subject: [syzbot] general protection fault in gfs2_parse_param
From:   syzbot <syzbot+da97a57c5b742d05db51@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
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

Hello,

syzbot found the following issue on:

HEAD commit:    4d48f589d294 Add linux-next specific files for 20221021
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15e511ba880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
dashboard link: https://syzkaller.appspot.com/bug?extid=da97a57c5b742d05db51
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e2fbe6880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1146d66a880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c86bd0b39a0/disk-4d48f589.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/074059d37f1f/vmlinux-4d48f589.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1c147a66d1a0/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da97a57c5b742d05db51@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 3602 Comm: syz-executor230 Not tainted 6.1.0-rc1-next-20221021-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:strnlen+0x3b/0x70 lib/string.c:430
Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
RSP: 0018:ffffc90003b6fb40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
RBP: 0000000000000040 R08: 0000000000000005 R09: 0000000000000017
R10: 0000000000000002 R11: 000000000008c001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8880217bf680 R15: ffff88807ccb24d0
FS:  0000555557389300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 0000000026706000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 strnlen include/linux/fortify-string.h:186 [inline]
 strscpy include/linux/fortify-string.h:331 [inline]
 gfs2_parse_param+0x1e6/0xe50 fs/gfs2/ops_fstype.c:1455
 vfs_parse_fs_param fs/fs_context.c:148 [inline]
 vfs_parse_fs_param+0x1f9/0x3c0 fs/fs_context.c:129
 vfs_parse_fs_string+0xdb/0x170 fs/fs_context.c:191
 generic_parse_monolithic+0x16f/0x1f0 fs/fs_context.c:231
 do_new_mount fs/namespace.c:3036 [inline]
 path_mount+0x12de/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdafa8bc4ba
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe056c9ee8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fdafa8bc4ba
RDX: 0000000020000080 RSI: 00000000200000c0 RDI: 00007ffe056c9f00
RBP: 00007ffe056c9f00 R08: 00007ffe056c9f40 R09: 00005555573892c0
R10: 000000000180c082 R11: 0000000000000282 R12: 0000000000000004
R13: 00007ffe056c9f40 R14: 0000000000000002 R15: 0000000020000330
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strnlen+0x3b/0x70 lib/string.c:430
Code: 74 3c 48 bb 00 00 00 00 00 fc ff df 49 89 fc 48 89 f8 eb 09 48 83 c0 01 48 39 e8 74 1e 48 89 c2 48 89 c1 48 c1 ea 03 83 e1 07 <0f> b6 14 1a 38 ca 7f 04 84 d2 75 11 80 38 00 75 d9 4c 29 e0 48 83
RSP: 0018:ffffc90003b6fb40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000040 RDI: 0000000000000000
RBP: 0000000000000040 R08: 0000000000000005 R09: 0000000000000017
R10: 0000000000000002 R11: 000000000008c001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8880217bf680 R15: ffff88807ccb24d0
FS:  0000555557389300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000061ba0c CR3: 0000000026706000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	74 3c                	je     0x3e
   2:	48 bb 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbx
   9:	fc ff df
   c:	49 89 fc             	mov    %rdi,%r12
   f:	48 89 f8             	mov    %rdi,%rax
  12:	eb 09                	jmp    0x1d
  14:	48 83 c0 01          	add    $0x1,%rax
  18:	48 39 e8             	cmp    %rbp,%rax
  1b:	74 1e                	je     0x3b
  1d:	48 89 c2             	mov    %rax,%rdx
  20:	48 89 c1             	mov    %rax,%rcx
  23:	48 c1 ea 03          	shr    $0x3,%rdx
  27:	83 e1 07             	and    $0x7,%ecx
* 2a:	0f b6 14 1a          	movzbl (%rdx,%rbx,1),%edx <-- trapping instruction
  2e:	38 ca                	cmp    %cl,%dl
  30:	7f 04                	jg     0x36
  32:	84 d2                	test   %dl,%dl
  34:	75 11                	jne    0x47
  36:	80 38 00             	cmpb   $0x0,(%rax)
  39:	75 d9                	jne    0x14
  3b:	4c 29 e0             	sub    %r12,%rax
  3e:	48                   	rex.W
  3f:	83                   	.byte 0x83


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
