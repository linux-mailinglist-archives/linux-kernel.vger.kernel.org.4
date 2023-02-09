Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6268FF91
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjBIE5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBIE5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:57:48 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD4524D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 20:57:46 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id d73-20020a6bb44c000000b0072805fbd06aso561924iof.17
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 20:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+erUzoCHaqk5du4PJ0oGSK+/VqB1+7mP3IK1FH0XP8k=;
        b=pnCcWe+wedO3gmqzynD1v0MtNVG1cEynUt8h8rD1HBuG/wZd2SzlIv+gw+O6OyJBtW
         1+MSKZHY8Q4uCucFH5hcXY3vbVxt0oO2FKikR+3aecTnFACfqfkzrICW3vg9unSJyPGp
         6/CS8v9be4xqQkvmYWR4YoRmsSe6gX9mGr0yY5MvoXn65PuTrbDr1oQLqVa9+NH5IvkD
         vQx8oQ9djz8MKL6XRnghXyTfBBIwjLJdcfQXoHtdd80GZV9uRx8OrvzHwawba9+lANbv
         YmH02TY7507YsHYOHiGOdNxq0HhBCCIxaMVliIs+iTSkzMszz1gxWg41HR6dlFMItn/m
         FLVw==
X-Gm-Message-State: AO0yUKVWX/35wYu1EtdTpPhJLjhCpmvdkI+vmF2j2DBGtQh7laRoQOnX
        Knmevebs8WbvWoT7a56KcE8aMgmo6wVD5rBPLovPdW0CfXvs
X-Google-Smtp-Source: AK7set+uFHdb2wAs55dEu7OLkoZKIE8AST9jA3k+ecFS4TrNdnp/hqKbnmGqWNHkUBD0b3tIEWPEw8+EoJBgII/yc8N3vtIAADHQ
MIME-Version: 1.0
X-Received: by 2002:a02:cc84:0:b0:3c4:84de:111d with SMTP id
 s4-20020a02cc84000000b003c484de111dmr1776606jap.7.1675918666324; Wed, 08 Feb
 2023 20:57:46 -0800 (PST)
Date:   Wed, 08 Feb 2023 20:57:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c75fdb05f43d384a@google.com>
Subject: [syzbot] [udf?] WARNING in udf_expand_dir_adinicb
From:   syzbot <syzbot+111eaa994ff74f8d440f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, gorcunov@gmail.com, jack@suse.com,
        jack@suse.cz, linux-kernel@vger.kernel.org, penberg@cs.helsinki.fi,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    4fafd96910ad Add linux-next specific files for 20230203
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14f92223480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=111eaa994ff74f8d440f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fa724b480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13558fad480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/348cc2da441a/disk-4fafd969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2dedc500f12/vmlinux-4fafd969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fae710d9ebd8/bzImage-4fafd969.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f80faa04675e/mount_0.gz

The issue was bisected to:

commit 0aba4860b0d0216a1a300484ff536171894d49d8
Author: Jan Kara <jack@suse.cz>
Date:   Tue Dec 20 11:38:45 2022 +0000

    udf: Allocate name buffer in directory iterator on heap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d3f2bb480000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17d3f2bb480000
console output: https://syzkaller.appspot.com/x/log.txt?x=13d3f2bb480000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+111eaa994ff74f8d440f@syzkaller.appspotmail.com
Fixes: 0aba4860b0d0 ("udf: Allocate name buffer in directory iterator on heap")

RSP: 002b:00007ffedf8b9a28 EFLAGS: 00000246 ORIG_RAX: 0000000000000085
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcaa035f9a9
RDX: 0000000000000701 RSI: 0000000000000000 RDI: 0000000020000200
RBP: 00007ffedf8b9a50 R08: 0000000000000002 R09: 00007ffedf8b9a60
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00007ffedf8b9a90 R14: 00007ffedf8b9a70 R15: 000000000000000c
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5101 at fs/udf/namei.c:220 udf_expand_dir_adinicb+0xbd8/0xe00 fs/udf/namei.c:220
Modules linked in:
CPU: 0 PID: 5101 Comm: syz-executor305 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:udf_expand_dir_adinicb+0xbd8/0xe00 fs/udf/namei.c:220
Code: 89 44 24 18 e8 49 21 ee fe 4c 8b 44 24 18 e9 c9 f9 ff ff e8 8a 1d 9f fe 4c 89 ef e8 b2 99 0d ff e9 20 f8 ff ff e8 78 1d 9f fe <0f> 0b e9 fd fd ff ff 41 bc 8b ff ff ff e9 56 f6 ff ff 41 bc f4 ff
RSP: 0018:ffffc90003d0f858 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: 0000000000000000
RDX: ffff88801d95d7c0 RSI: ffffffff82e54d28 RDI: 0000000000000005
RBP: ffff8880741e0158 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000000 R12: 00000000fffffff4
R13: ffff888074218910 R14: ffffc90003d0f928 R15: 0000000000000000
FS:  0000555555946300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcaa0334610 CR3: 0000000017f44000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_fiiter_add_entry+0xcf2/0x1080 fs/udf/namei.c:270
 udf_add_nondir+0xdb/0x3a0 fs/udf/namei.c:361
 udf_create+0xda/0x120 fs/udf/namei.c:394
 vfs_create fs/namei.c:3118 [inline]
 vfs_create+0x1a9/0x3a0 fs/namei.c:3102
 do_mknodat+0x3d9/0x530 fs/namei.c:3966
 __do_sys_mknod fs/namei.c:3999 [inline]
 __se_sys_mknod fs/namei.c:3997 [inline]
 __x64_sys_mknod+0x11e/0x180 fs/namei.c:3997
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcaa035f9a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffedf8b9a28 EFLAGS: 00000246 ORIG_RAX: 0000000000000085
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fcaa035f9a9
RDX: 0000000000000701 RSI: 0000000000000000 RDI: 0000000020000200
RBP: 00007ffedf8b9a50 R08: 0000000000000002 R09: 00007ffedf8b9a60
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
R13: 00007ffedf8b9a90 R14: 00007ffedf8b9a70 R15: 000000000000000c
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
