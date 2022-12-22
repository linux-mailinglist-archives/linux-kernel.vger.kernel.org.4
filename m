Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D142653C89
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 08:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiLVHb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 02:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiLVHbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 02:31:42 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E10248C6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 23:31:40 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id j11-20020a056e02218b00b00304b148969dso707502ila.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 23:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Vj70vXqAi1mevmse7PywnzjwLNIX/DY/2s63bH6r/c=;
        b=D0jUGi4EuMAcE85308yaGT4DqnZeEX+fM41m2Xd7KlqrfvFJ2ZFoScfTDQ5yaNFrNK
         2tUIYYA9AaLfZ+5gx8QdkqDITFDxJS6IvEPm3NScM5X467/8MMBEeloCPdDhpqXdRVxZ
         t0l24c4I7hi56pTp0K7wfZa4/N1zDqJ9mv8kYSQ65bGmF8Ju1QZFCiTNPGejj0/9RqOp
         E11WqMEoWqYz8fuHZiunRs+EdzIn+jXHzWg7trn7AZko7IymOWmvsO5IV8W75HmiswT8
         Bs1eeCYDA4U+n3rLWZhG00Hc/egBakiJmKgcxUJcqSUu2VESFS8mmhZQAz3koZpC4c3x
         w04g==
X-Gm-Message-State: AFqh2koL07+jexHLPHrdaKC8vQ6XNWT29KfMX5p4I8tAMs1LYbJ9O3NK
        Vf2b5tvsSZusyRuxpucLu+5f+3Z7KnbsDrJbw8FMBI+1aFou
X-Google-Smtp-Source: AMrXdXuVevLm+5oTk0G2BTm+4+OJEgoP44HeGXufw7OedfqsYvd9X+5ofk/y3Vufpg7PmgFWHRTYJcr7HyD8I5rln8vH+Hdw2sxA
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1790:b0:6df:f58c:6932 with SMTP id
 y16-20020a056602179000b006dff58c6932mr333894iox.137.1671694299269; Wed, 21
 Dec 2022 23:31:39 -0800 (PST)
Date:   Wed, 21 Dec 2022 23:31:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1923c05f065a8dc@google.com>
Subject: [syzbot] [udf?] WARNING in udf_rename
From:   syzbot <syzbot+932c11aa5a73e344a857@syzkaller.appspotmail.com>
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

HEAD commit:    e45fb347b630 Add linux-next specific files for 20221220
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=101f5464480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ae91cba504b4da8
dashboard link: https://syzkaller.appspot.com/bug?extid=932c11aa5a73e344a857
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116bc780480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12aa9b94480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1ae2b280f860/disk-e45fb347.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/253fc221144a/vmlinux-e45fb347.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2695a52406f/bzImage-e45fb347.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0ec2a53bda86/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+932c11aa5a73e344a857@syzkaller.appspotmail.com

memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=5073 'syz-executor109'
loop0: detected capacity change from 0 to 2048
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5073 at fs/udf/namei.c:802 udf_rename+0x914/0xb60 fs/udf/namei.c:802
Modules linked in:
CPU: 1 PID: 5073 Comm: syz-executor109 Not tainted 6.1.0-next-20221220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:udf_rename+0x914/0xb60 fs/udf/namei.c:802
Code: 48 89 da 48 8b 7c 24 58 e8 89 c5 ff ff 31 ff 89 c3 89 c6 e8 3e 38 a2 fe 85 db 0f 84 5d fa ff ff e9 c9 fd ff ff e8 7c 3b a2 fe <0f> 0b 48 8b 7c 24 30 bb 8b ff ff ff e8 8b 58 01 00 e9 ae fd ff ff
RSP: 0018:ffffc900039df5d0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888022559d40 RSI: ffffffff82df1964 RDI: 0000000000000005
RBP: ffffc900039dfbe8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff888073571490 R14: ffffc900039df660 R15: ffff888073571af8
FS:  0000555556037300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000002a4df000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_rename+0x1162/0x1a90 fs/namei.c:4779
 do_renameat2+0xb22/0xc30 fs/namei.c:4930
 __do_sys_rename fs/namei.c:4976 [inline]
 __se_sys_rename fs/namei.c:4974 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:4974
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4a792ed819
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd557425e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f4a792ed819
RDX: 00007f4a792ed819 RSI: 0000000020000400 RDI: 00000000200003c0
RBP: 00007f4a792ad0b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000bea R11: 0000000000000246 R12: 00007f4a792ad140
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
