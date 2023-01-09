Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007DD661EAE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 07:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjAIGbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 01:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjAIGbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:31:45 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38FF1180E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 22:31:43 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id z19-20020a921a53000000b0030b90211df1so5412361ill.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 22:31:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlJwxp6GYj5ZaTzFBjTys5qzcJdyUszP5walHHnblyk=;
        b=mg+HN9DsR2SQOyI5T77byh9R8+Z1n9MR5mR36+wnqaXHbKmru7g24daWb2M5etqufO
         WdWLHdvNnjwU8OvGD8/tF5KTsrSM+Lur6NJkDRteO3/sT1mKdBTK98l5sAuwwy8F4oyd
         NM13gO06y72esKC6RjVCEbV2yDa11ETCD/8/u0cK1KQBSsuxGBuOp+6BMlmfkz2vSSgu
         WLd2VF/mKPo4fpURxBCtIswKNNvdJqSO+RGjNXDWFoTdUldZnKbttReq16AheitSQ6j8
         Szwq7Q1YgbTfQXCIglP7OdC6cx4jfKS01AWsiTXjVwWwkAUpbvdG+tjJKJxy/WK7qLB3
         IXBA==
X-Gm-Message-State: AFqh2kqqKVxODDcS20eDb7ycKUtIlZhfEw4982sL4IeCmuX7VaGOyvtv
        XijAz16BSIkKs8H4plLl79y3LqWYdkHJSN+zSnllheOJJw22
X-Google-Smtp-Source: AMrXdXvWhPisbEV3WlNIkC+gey5f9z0tGSL7PzIGqQn3Rino6VfEns2ytkpwQLrsJ61AOtuzq/r+ND22DXjB5mqB61mkCJndsa2g
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3986:b0:6e4:1c03:2520 with SMTP id
 bw6-20020a056602398600b006e41c032520mr5128978iob.59.1673245903344; Sun, 08
 Jan 2023 22:31:43 -0800 (PST)
Date:   Sun, 08 Jan 2023 22:31:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0ddad05f1ceeb5f@google.com>
Subject: [syzbot] [udf?] general protection fault in udf_fiiter_write_fi
From:   syzbot <syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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

HEAD commit:    c76083fac3ba Add linux-next specific files for 20221226
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13ce8194480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c217c755f1884ab6
dashboard link: https://syzkaller.appspot.com/bug?extid=aebf90eea2671c43112a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e388f26357fd/disk-c76083fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e24f0bae36d5/vmlinux-c76083fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5a69a059716/bzImage-c76083fa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 1 PID: 13485 Comm: syz-executor.3 Not tainted 6.2.0-rc1-next-20221226-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:udf_fiiter_write_fi+0x14e/0x9d0 fs/udf/directory.c:402
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1b 08 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 10 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ed 07 00 00 49 8b 44 24 28 48 8d 7b 18 48 89 fa
RSP: 0018:ffffc9000b327818 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffc9000b327ad0 RCX: ffffc9000cd16000
RDX: 0000000000000005 RSI: ffffffff82df7ad5 RDI: 0000000000000028
RBP: 0000000000000200 R08: 0000000000000001 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888082c31af8 R14: ffffc9000b327ad0 R15: ffff888082c30158
FS:  00007ff99c5ae700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020045000 CR3: 0000000078396000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_rename+0x69d/0xb80 fs/udf/namei.c:870
 vfs_rename+0x1162/0x1a90 fs/namei.c:4779
 do_renameat2+0xb22/0xc30 fs/namei.c:4930
 __do_sys_rename fs/namei.c:4976 [inline]
 __se_sys_rename fs/namei.c:4974 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:4974
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff99b88c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff99c5ae168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007ff99b9ac050 RCX: 00007ff99b88c0c9
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000020000040
RBP: 00007ff99b8e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdfd6d93ef R14: 00007ff99c5ae300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:udf_fiiter_write_fi+0x14e/0x9d0 fs/udf/directory.c:402
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1b 08 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 10 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ed 07 00 00 49 8b 44 24 28 48 8d 7b 18 48 89 fa
RSP: 0018:ffffc9000b327818 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffc9000b327ad0 RCX: ffffc9000cd16000
RDX: 0000000000000005 RSI: ffffffff82df7ad5 RDI: 0000000000000028
RBP: 0000000000000200 R08: 0000000000000001 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888082c31af8 R14: ffffc9000b327ad0 R15: ffff888082c30158
FS:  00007ff99c5ae700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3303f000 CR3: 0000000078396000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 fa                	mov    %edi,%edx
   2:	48 c1 ea 03          	shr    $0x3,%rdx
   6:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   a:	0f 85 1b 08 00 00    	jne    0x82b
  10:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  17:	fc ff df
  1a:	4c 8b 63 10          	mov    0x10(%rbx),%r12
  1e:	49 8d 7c 24 28       	lea    0x28(%r12),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 ed 07 00 00    	jne    0x821
  34:	49 8b 44 24 28       	mov    0x28(%r12),%rax
  39:	48 8d 7b 18          	lea    0x18(%rbx),%rdi
  3d:	48 89 fa             	mov    %rdi,%rdx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
