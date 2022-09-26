Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00375EA80C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbiIZOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiIZOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:11:38 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1714597522
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:22:24 -0700 (PDT)
Received: by mail-qt1-f197.google.com with SMTP id b13-20020ac87fcd000000b0035cbe5d58afso4594755qtk.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=GgYODxeZzEYkixpmmtDscTLqUfdrR0WfPFtLIUS23Ms=;
        b=mtvAAA/6CakO122kKlHOLpjzRHNsUPt9mnSXYA3icma6uNgo75SMnuGZxe2X4BwG+c
         ovX+9CZIIDXc3+XxI8tqVxCBkRI/1tEusOPV3PaAge3FXwGLo7pL/qP4NhYyssPUQaW4
         XAW/uYw7ZRZRJsGhU4xiIM3L0VldXA/j4ekPjaqA3o1iUaQwOUVEhfOjPe+nXI4hk+x4
         GGDdsigSteTLWfpaHBFWNVgB5DWzQ7lSizq0xQ5pJ3nQ+vVaY3ZT4sDphMgFVJGkiKAp
         4YnpDr9bxAk5IwfShV0MIxJ9wvzCzFv0TmUL+rzNSMKBZgHdym/4tzFYlPQcAXSQutQR
         8UtA==
X-Gm-Message-State: ACrzQf2Qd5ANA1WkoQ3RxQP+hgJKOb+7EDwhgdjwk3rKZCtwP4HI33YD
        RPwbfwLJpeVoMYOkVvLUtewvyhJxf1ewHEX0NLrVh+fgijr1
X-Google-Smtp-Source: AMsMyM5U0UPpuKfCMiewlqeNWOa23DyLgYZSk88997HOVh1/kbO2T3h/HTj36m2DPbYJPLgw2ZrEWKNCBoLfW91crdDJ+CnErkpE
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2191:b0:35a:3730:8893 with SMTP id
 s17-20020a056638219100b0035a37308893mr11392730jaj.231.1664192795345; Mon, 26
 Sep 2022 04:46:35 -0700 (PDT)
Date:   Mon, 26 Sep 2022 04:46:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000678d0f05e9931411@google.com>
Subject: [syzbot] kernel BUG in dbFindLeaf
From:   syzbot <syzbot+dcea2548c903300a400e@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bf682942cd26 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c966df080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a27f1315833f/disk-bf682942.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10067330020a/vmlinux-bf682942.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcea2548c903300a400e@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_dmap.c:2933 assert(n < 4)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_dmap.c:2933!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 15799 Comm: syz-executor.3 Not tainted 6.0.0-rc6-syzkaller-00210-gbf682942cd26 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:dbFindLeaf+0x43c/0x440 fs/jfs/jfs_dmap.c:2933
Code: dd fe eb 87 e8 05 1d 8a fe 48 c7 c7 a0 49 cd 8a 48 c7 c6 60 57 cd 8a ba 75 0b 00 00 48 c7 c1 40 54 cd 8a 31 c0 e8 15 34 23 07 <0f> 0b 66 90 55 41 57 41 56 41 55 41 54 53 48 83 ec 68 49 89 ff 49
RSP: 0018:ffffc900036ef3d8 EFLAGS: 00010246
RAX: 000000000000002b RBX: 0000000000000055 RCX: 5cb50556273a0200
RDX: ffffc9000c694000 RSI: 0000000000003f80 RDI: 0000000000003f81
RBP: 00000000ffffffff R08: ffffffff816bd4bd R09: ffffed10173667f1
R10: ffffed10173667f1 R11: 1ffff110173667f0 R12: ffff888024f0a010
R13: 0000000000000000 R14: ffff888024f0a079 R15: 0000000000000058
FS:  00007fab7c85a700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e522000 CR3: 000000004da39000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dbAllocDmapLev+0xa9/0x420 fs/jfs/jfs_dmap.c:1937
 dbAlloc+0xa7b/0xc90 fs/jfs/jfs_dmap.c:825
 extBalloc fs/jfs/jfs_extent.c:321 [inline]
 extAlloc+0x4b9/0xff0 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x342/0xce0 fs/jfs/inode.c:248
 __block_write_begin_int+0x5f6/0x1ba0 fs/buffer.c:2006
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x93/0x1e0 fs/buffer.c:2117
 jfs_write_begin+0x2d/0x60 fs/jfs/inode.c:304
 generic_perform_write+0x2a8/0x5b0 mm/filemap.c:3738
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3866
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3898
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:578
 ksys_write+0x177/0x2a0 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fab7b68a669
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fab7c85a168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fab7b7abf80 RCX: 00007fab7b68a669
RDX: 000000000000fd14 RSI: 0000000020001700 RDI: 0000000000000003
RBP: 00007fab7b6e5560 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe028f583f R14: 00007fab7c85a300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dbFindLeaf+0x43c/0x440 fs/jfs/jfs_dmap.c:2933
Code: dd fe eb 87 e8 05 1d 8a fe 48 c7 c7 a0 49 cd 8a 48 c7 c6 60 57 cd 8a ba 75 0b 00 00 48 c7 c1 40 54 cd 8a 31 c0 e8 15 34 23 07 <0f> 0b 66 90 55 41 57 41 56 41 55 41 54 53 48 83 ec 68 49 89 ff 49
RSP: 0018:ffffc900036ef3d8 EFLAGS: 00010246
RAX: 000000000000002b RBX: 0000000000000055 RCX: 5cb50556273a0200
RDX: ffffc9000c694000 RSI: 0000000000003f80 RDI: 0000000000003f81
RBP: 00000000ffffffff R08: ffffffff816bd4bd R09: ffffed10173667f1
R10: ffffed10173667f1 R11: 1ffff110173667f0 R12: ffff888024f0a010
R13: 0000000000000000 R14: ffff888024f0a079 R15: 0000000000000058
FS:  00007fab7c85a700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110f337234 CR3: 000000004da39000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
