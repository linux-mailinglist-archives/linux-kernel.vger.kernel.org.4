Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACAE619CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiKDQLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKDQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:11:40 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95387286D3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:11:39 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id r197-20020a6b8fce000000b006c3fc33424dso3259251iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 09:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hVJXuTFQBtDnEunFerABAeJSDQzBLOgQs4tefvCO+Y=;
        b=xI3r/VJ/Y0+pjufjtKtSakASCNuT7PDI+vL20CFmNdN3lREzF70JsCGz2ywnLLJtTD
         NNk+WuHEueY6YtF+iTAEPfotKoatRjqlGLC4k7HBUsnaYMIxpy84pbgBwNEi8QGm+Pj4
         RsEgoWxaqwT8xIPDY1YB1txpdTe8y58nx7lVdqkKXfQ4DzCOTV6je0C1UyhsEkAz7/G9
         o19ghuKG+6bRU8EwkC5iVCkxRcFrkrw3MgRVRVFqKLHIYshOsvS6YL548tJ/wmM1KK4o
         NSIzVHYSGO7y54t+XdvvUcSuOy7rFK4W3pVlYK2FYXq7UY/LSOmV1MctVXcgiisyZa/2
         kzwg==
X-Gm-Message-State: ACrzQf22MvkyhrZCIZileypOeOJNWV4oHrkgIVwdjaT4MltU5Y44A+HT
        WYoDwHWVnhyfuCoQcI/+pMmlUD1FOSOZuTEiem3YZwYFM0G/
X-Google-Smtp-Source: AMsMyM5rwpNIhl7AFVDDGlfSPxemvJzCe1+solre5RUwTI/7t9fqeMMmvwmi/Gp5Zhfuvt1Yutg9Cq8i0NxGslOaKGTkuoPMPBsX
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2103:b0:375:2ba6:b5d8 with SMTP id
 n3-20020a056638210300b003752ba6b5d8mr23187939jaj.27.1667578298920; Fri, 04
 Nov 2022 09:11:38 -0700 (PDT)
Date:   Fri, 04 Nov 2022 09:11:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002473fd05eca7540a@google.com>
Subject: [syzbot] WARNING in kernfs_find_and_get_node_by_id
From:   syzbot <syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        zhouchengming@bytedance.com
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

HEAD commit:    f2f32f8af2b0 Merge tag 'for-6.1-rc3-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=101fe196880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7e100ed8aaa828e
dashboard link: https://syzkaller.appspot.com/bug?extid=2fdf66e68f5f882c1074
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aa1051880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a863a6880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea126f52b953/disk-f2f32f8a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/815b36048854/vmlinux-f2f32f8a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b7d04bb936fd/bzImage-f2f32f8a.xz

The issue was bisected to:

commit c25491747b21536bd56dccb82a109754bbc8d52c
Author: Tejun Heo <tj@kernel.org>
Date:   Sun Aug 28 05:04:37 2022 +0000

    kernfs: Add KERNFS_REMOVING flags

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106731ee880000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=126731ee880000
console output: https://syzkaller.appspot.com/x/log.txt?x=146731ee880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
Fixes: c25491747b21 ("kernfs: Add KERNFS_REMOVING flags")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3608 at fs/kernfs/dir.c:36 kernfs_find_and_get_node_by_id+0x1f0/0x270 fs/kernfs/dir.c:708
Modules linked in:
CPU: 1 PID: 3608 Comm: syz-executor714 Not tainted 6.1.0-rc3-syzkaller-00152-gf2f32f8af2b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:kernfs_active fs/kernfs/dir.c:36 [inline]
RIP: 0010:kernfs_find_and_get_node_by_id+0x1f0/0x270 fs/kernfs/dir.c:708
Code: e8 25 fc 29 08 4c 89 f0 5b 41 5c 41 5e 41 5f 5d c3 e8 94 c9 74 ff e9 35 ff ff ff e8 8a c9 74 ff e9 2b ff ff ff e8 80 c9 74 ff <0f> 0b e9 2c ff ff ff 48 c7 c1 d4 e8 0d 8e 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc90003cdfb58 EFLAGS: 00010293
RAX: ffffffff821316a0 RBX: 0000000000000000 RCX: ffff88802937d7c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: dffffc0000000000 R08: ffffffff821315ab R09: fffff5200079bf5c
R10: fffff5200079bf5d R11: 1ffff9200079bf5c R12: dffffc0000000000
R13: 0000000000000002 R14: ffff8881400f4570 R15: 0000000000000005
FS:  00005555572ef300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000007806e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __kernfs_fh_to_dentry fs/kernfs/mount.c:102 [inline]
 kernfs_fh_to_dentry+0x129/0x1d0 fs/kernfs/mount.c:128
 exportfs_decode_fh_raw+0x115/0x600 fs/exportfs/expfs.c:435
 exportfs_decode_fh+0x38/0x70 fs/exportfs/expfs.c:575
 do_handle_to_path fs/fhandle.c:152 [inline]
 handle_to_path fs/fhandle.c:207 [inline]
 do_handle_open+0x485/0x950 fs/fhandle.c:223
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3991d2bbe9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8481e4e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3991d2bbe9
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007f3991cefd90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3991cefe20
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
