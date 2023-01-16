Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B1466B834
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjAPHbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjAPHbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:31:44 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8AAE3A1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:31:39 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id y11-20020a056e02178b00b0030c048d64a7so20462160ilu.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5LFjPBPQX5VTHahUWFGvW547MY3Vx8HfP9h5GwFmub8=;
        b=V933kmroj7tMZnNg/Vm62Bo5BVgQ6oq4BX9TkKr2I/maRzYYgXWWWeyifEuBK4Iz8p
         PDcNyAjxrzFoaPWQygZ9paUUehxpb0mszRJ3IWWiILss4gbUplfYLy7qLb7Qt0sORWGP
         TNbymFXWBRzeBiGcKZWPvokqrGus+yZ8VbKtaZ/NIfG4/xbZzftQDLZCpq82uOKK65Vf
         M07ZNAYiz9MSS5yYDGu1YqD6nRbp5jTGLptA+C7mWwf9AowFBVT8rvx80g4awoaS7TCC
         xPXduaUW154xo0Z3vFrP28/rSNTwKEXPrJsBiUVbfhQpOBFc5paxjLPGqbADEUrulhrr
         iJ0A==
X-Gm-Message-State: AFqh2koEYpu3cstNCmWVLy3QHWuPr2E4CXRzdQbkjkQ7X1aR6sxfb4+9
        XfZG0vXECo6lnWt51TrxFpVizCJyVMAIxMHQ/tW6QXrGa68i
X-Google-Smtp-Source: AMrXdXu4XZN0wDcSySC8AMwWQl/jizq1t7VTmrIwnoMQySbRGBJlPVF/OqfItPwmXFohrpIxKOWhIyukT3bPjsCoaClxE7eHEXAf
MIME-Version: 1.0
X-Received: by 2002:a92:c5a3:0:b0:30e:ec1e:2dac with SMTP id
 r3-20020a92c5a3000000b0030eec1e2dacmr573106ilt.75.1673854298771; Sun, 15 Jan
 2023 23:31:38 -0800 (PST)
Date:   Sun, 15 Jan 2023 23:31:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e259c105f25c92da@google.com>
Subject: [syzbot] WARNING: refcount bug in mm_update_next_owner
From:   syzbot <syzbot+1d4c86ac0fed92e3fc78@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org,
        ebiederm@xmission.com, jannh@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16a8e102480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=1d4c86ac0fed92e3fc78
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d4c86ac0fed92e3fc78@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 5316 at lib/refcount.c:25 refcount_warn_saturate+0x17c/0x1f0 lib/refcount.c:25
Modules linked in:
CPU: 0 PID: 5316 Comm: syz-executor.4 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:refcount_warn_saturate+0x17c/0x1f0 lib/refcount.c:25
Code: 0a 31 ff 89 de e8 d4 13 78 fd 84 db 0f 85 2e ff ff ff e8 57 17 78 fd 48 c7 c7 60 87 a6 8a c6 05 e0 ce 54 0a 01 e8 98 a7 b2 05 <0f> 0b e9 0f ff ff ff e8 38 17 78 fd 0f b6 1d ca ce 54 0a 31 ff 89
RSP: 0018:ffffc90005967d80 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880829f3a80 RSI: ffffffff8166972c RDI: fffff52000b2cfa2
RBP: ffff888082ae3aa8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88807e520900
R13: ffff888082ae3fa8 R14: 0000000000000000 R15: ffff888082ae3aa8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f23000 CR3: 000000007716c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:199 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 get_task_struct include/linux/sched/task.h:110 [inline]
 mm_update_next_owner+0x585/0x7b0 kernel/exit.c:504
 exit_mm kernel/exit.c:562 [inline]
 do_exit+0x9a4/0x2a90 kernel/exit.c:854
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f51f5a8c0c9
Code: Unable to access opcode bytes at 0x7f51f5a8c09f.
RSP: 002b:00007ffe3c730ad8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007f51f5a8c0c9
RDX: 00007f51f5a3df7b RSI: ffffffffffffffb8 RDI: 0000000000000000
RBP: 0000000000000000 R08: 000000002ed3101e R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000001 R15: 00007ffe3c730bc0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
