Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F6B6B32DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCJAmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJAmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:42:49 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434EB10460A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 16:42:48 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id z128-20020a6bc986000000b0074d32ddcce7so1711172iof.21
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 16:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678408967;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVtzB2EVvNnZZOPbo8yS6jPCjjZQAZUKZOg8iD8VK84=;
        b=ss6MbSOOut8xefmF6tVTZT4gM2IXXt3bNFWjHrTKYBjKgCuuv5JeNtxFlhocN0OGZT
         lj+2fWNrydT4v5PHm++SytIvkQxQgm+2/+XqXUE8jkKMDxVvyaSmdi+m7yzUXyJqZH5f
         52qQ5BECRbNTRxyQQolPSpjNZKaje0Tnw8yJ5vTu1Y6B2naucSndSnaEDKWWs0RirFWm
         wSQ++6kTwaAr4Iny8C9TxwXTbFxyLYIG86zLLIoHMlB0MTUWH2bbwiuSZvHUPixeNzj3
         tLgZiFmgXmuenQ7onp1bNolWoXHJDT3utQGH/tJqZNtl+uEftFVmk441RpTJqqUJkbOY
         /ZDA==
X-Gm-Message-State: AO0yUKVNvuVkrvptx5VF5qNR1AOH3JtAGKnHfjos7nVVlWGnS5IsorS1
        GLjpW6/wIXsiQBWCjCpKJ3wIL2+p4rSS7dWWh+uy2yadSlwI
X-Google-Smtp-Source: AK7set+tjzsOI6UJ19cX98pT1tPPdh+2u6dZja/6/cJ2WNfVWIABuJvC9M7CwR+iCAcZDEGlTHWBJH5yTFKkAlLMg7PJYg8+9Uh7
MIME-Version: 1.0
X-Received: by 2002:a02:94a5:0:b0:3a9:6e13:781b with SMTP id
 x34-20020a0294a5000000b003a96e13781bmr12150227jah.3.1678408967596; Thu, 09
 Mar 2023 16:42:47 -0800 (PST)
Date:   Thu, 09 Mar 2023 16:42:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d318a05f6810a9f@google.com>
Subject: [syzbot] [kernel?] WARNING in c_start (2)
From:   syzbot <syzbot+96cae094d90877641f32@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    44889ba56cbb Merge tag 'net-6.3-rc2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13933824c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d677dcd743eef09
dashboard link: https://syzkaller.appspot.com/bug?extid=96cae094d90877641f32
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96cae094d90877641f32@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 5136 at include/linux/cpumask.h:143 cpu_max_bits_warn include/linux/cpumask.h:143 [inline]
WARNING: CPU: 3 PID: 5136 at include/linux/cpumask.h:143 cpumask_check include/linux/cpumask.h:150 [inline]
WARNING: CPU: 3 PID: 5136 at include/linux/cpumask.h:143 cpumask_next include/linux/cpumask.h:212 [inline]
WARNING: CPU: 3 PID: 5136 at include/linux/cpumask.h:143 c_start+0x1da/0x250 arch/x86/kernel/cpu/proc.c:156
Modules linked in:
CPU: 3 PID: 5136 Comm: syz-fuzzer Not tainted 6.3.0-rc1-syzkaller-00106-g44889ba56cbb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:143 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:150 [inline]
RIP: 0010:cpumask_next include/linux/cpumask.h:212 [inline]
RIP: 0010:c_start+0x1da/0x250 arch/x86/kernel/cpu/proc.c:156
Code: 49 11 8c e8 88 a9 51 00 4c 89 e0 5b 5d 41 5c 41 5d 41 5e c3 f3 48 0f bc db e8 72 a9 51 00 89 db e9 38 ff ff ff e8 66 a9 51 00 <0f> 0b e9 c1 fe ff ff 48 c7 c7 80 7f 77 8e e8 d3 49 a2 00 e9 67 ff
RSP: 0018:ffffc90001ee7c68 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000000000
RDX: ffff888023996000 RSI: ffffffff813279da RDI: 0000000000000004
RBP: ffffffff8e777f80 R08: 0000000000000004 R09: 0000000000000007
R10: 0000000000000004 R11: 0000000000000000 R12: ffff88801f2ded60
R13: 0000000000000008 R14: 0000000000000004 R15: 0000000000000000
FS:  0000000001ec53d0(0000) GS:ffff88802cb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f08961ed698 CR3: 00000000141a7000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 seq_read_iter+0x2ca/0x12d0 fs/seq_file.c:225
 proc_reg_read_iter+0x115/0x2d0 fs/proc/inode.c:301
 call_read_iter include/linux/fs.h:1845 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x681/0x930 fs/read_write.c:470
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x403ace
Code: 48 89 6c 24 38 48 8d 6c 24 38 e8 0d 00 00 00 48 8b 6c 24 38 48 83 c4 40 c3 cc cc cc 49 89 f2 48 89 fa 48 89 ce 48 89 df 0f 05 <48> 3d 01 f0 ff ff 76 15 48 f7 d8 48 89 c1 48 c7 c0 ff ff ff ff 48
RSP: 002b:000000c000561308 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000403ace
RDX: 0000000000000b49 RSI: 000000c0003ae4b7 RDI: 0000000000000003
RBP: 000000c000561348 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000000c000561488
R13: 0000000000000000 R14: 000000c0000061a0 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
