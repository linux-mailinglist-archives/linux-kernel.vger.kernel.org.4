Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC84A6687B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 00:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240653AbjALXAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 18:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbjALXAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 18:00:45 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1A05E663
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:00:43 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id g11-20020a056e021a2b00b0030da3e7916fso11009711ile.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 15:00:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzqjOvZ2EU76yqtwHnocprkxJJY/I7pPOLg2vL5iKcM=;
        b=NKafyx0Hb+C0WgTQJLufM2atlvWEo78EeYanpTkGqDOgl08z2KiiAcIeju0QFbImYJ
         PFgzroJFCHfQKwWO3Dju8+xEUpDhIUrwwVOvTdP10a5rQYSXtm6ToVSX6CaIxHv/w7xX
         YyQg/ZQQjvlveYM7gA5o20/1NRj8KYUJ1C4k/WETzD1kN05Sw/4MNtSVcpirgOfjYOFz
         /hwYvePI/yh9OXI54N4xgRE+d5EkYQWE8LAm9tDnAKD0eOLggwzIrxpIVt/xVLhpXad3
         2bwyd9IYjBZB5BelRZJhH7qJG7PariuUy9NGleG853z6qxJUXKZ0vxoqO2Qy4YwB7F6S
         4BaQ==
X-Gm-Message-State: AFqh2krXCC8EIY9kvKOzhA26Mxo8OrSycIORhItBSmEZwLp2YyC/cESD
        0aWysiandhUyD2L1IEH4oxSuCCNynE7rQBlA1HcZM8icvsSY
X-Google-Smtp-Source: AMrXdXsVoI53i4BgZjpggf4ad9ojXRm5vAdgQhIROtfV8M88ktrmTIXJpeEkYFnQqijVn3FXVr3m6Ue34fwqJhxFi5kySyRKp+Ow
MIME-Version: 1.0
X-Received: by 2002:a02:a307:0:b0:38a:160a:2a86 with SMTP id
 q7-20020a02a307000000b0038a160a2a86mr8632157jai.95.1673564443251; Thu, 12 Jan
 2023 15:00:43 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:00:43 -0800
In-Reply-To: <000000000000b0ddad05f1ceeb5f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000261eb005f2191696@google.com>
Subject: Re: [syzbot] [udf?] general protection fault in udf_fiiter_write_fi
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17a68186480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=aebf90eea2671c43112a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fae47e480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142ea65e480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/683a4cbc41b8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aebf90eea2671c43112a@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 5127 Comm: syz-executor298 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:udf_fiiter_write_fi+0x14e/0x9d0 fs/udf/directory.c:402
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1b 08 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 10 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ed 07 00 00 49 8b 44 24 28 48 8d 7b 18 48 89 fa
RSP: 0018:ffffc90003daf818 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffc90003dafad0 RCX: 0000000000000000
RDX: 0000000000000005 RSI: ffffffff82deb2c5 RDI: 0000000000000028
RBP: 0000000000000200 R08: 0000000000000001 R09: 0000000000000003
R10: 0000000000000001 R11: 0000000000094001 R12: 0000000000000000
R13: ffff888072c92e30 R14: ffffc90003dafad0 R15: ffff888072c93498
FS:  00007f1256075700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1256075718 CR3: 00000000204a4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_rename+0x69d/0xb80 fs/udf/namei.c:874
 vfs_rename+0x1162/0x1a90 fs/namei.c:4780
 do_renameat2+0xb22/0xc30 fs/namei.c:4931
 __do_sys_rename fs/namei.c:4977 [inline]
 __se_sys_rename fs/namei.c:4975 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:4975
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f125e4da5b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f12560752f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f125e55f7b0 RCX: 00007f125e4da5b9
RDX: 00007f1256075700 RSI: 0000000020000100 RDI: 0000000020000040
RBP: 0030656c69662f2e R08: 00007f1256075700 R09: 0000000000000000
R10: 00007f1256075700 R11: 0000000000000246 R12: 00007f125e52c0c0
R13: 0000000020000580 R14: f6f2cbf92df09e20 R15: 00007f125e55f7b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:udf_fiiter_write_fi+0x14e/0x9d0 fs/udf/directory.c:402
Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1b 08 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 10 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ed 07 00 00 49 8b 44 24 28 48 8d 7b 18 48 89 fa
RSP: 0018:ffffc90003daf818 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffffc90003dafad0 RCX: 0000000000000000
RDX: 0000000000000005 RSI: ffffffff82deb2c5 RDI: 0000000000000028
RBP: 0000000000000200 R08: 0000000000000001 R09: 0000000000000003
R10: 0000000000000001 R11: 0000000000094001 R12: 0000000000000000
R13: ffff888072c92e30 R14: ffffc90003dafad0 R15: ffff888072c93498
FS:  00007f1256075700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f125e51bc90 CR3: 00000000204a4000 CR4: 00000000003506f0
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

