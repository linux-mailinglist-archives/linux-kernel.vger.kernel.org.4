Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806FE64F860
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 10:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiLQJBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 04:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiLQJBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 04:01:44 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3DEE032
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 01:01:43 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id b24-20020a056602219800b006e2bf9902cbso2325716iob.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 01:01:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYvJo8yuqCoES5ZZikY7SREAaKv4YPjwh9IFzyN29mE=;
        b=5RXVTdB8Pdgxhiuda0buxH8wJ5lCu5ZulYsCnaJdI4RxoFV4HX6pgduy7HGc+InRUl
         rpyzzRUxaKHaLq8SY2ZN/zYc3fZ7gZsuqZN5pSPOXiTqF6R/wu0ESrIoW5NY5lViHSvx
         04BkCAytiiLh2EGrKL/FPsC+seac7T7iQ6/JSYBY9ZLIUhEKysXV1+EIUFl07zzN5hxe
         kKIYc44ZLEQLktS2jbsGBBV47hPvCZ4Xi3UNZZbjQ/3uNWbpNrFj65VDv0uagNXLYSeM
         H1DQHfyE9RtqZrXymAlLu/9fe9fI2WVXAHvgSeQZTsY5g0BkeWw+HxRTr1LRIWIMevfs
         4nUw==
X-Gm-Message-State: ANoB5pnySj7g4tcxBg8+XaN//596nZNnOMgmLxrXDzkdmy12nsR65lj8
        YUCiEQIsbqXBOurgXfliNzuiMVi4FtmUi/9IitsmuGF1me3c
X-Google-Smtp-Source: AA0mqf6i/ECzHp8mYrFcEWNWBqOnwQvD+KbO/XLMiyNrAJIrn362K2jZ79eX1Hv4gR6onBAXHfnvwx6T9TPT1I5EZhTu8KV222Hs
MIME-Version: 1.0
X-Received: by 2002:a02:7403:0:b0:363:a229:57c3 with SMTP id
 o3-20020a027403000000b00363a22957c3mr1284306jac.231.1671267703001; Sat, 17
 Dec 2022 01:01:43 -0800 (PST)
Date:   Sat, 17 Dec 2022 01:01:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c31da505f0025531@google.com>
Subject: [syzbot] [udf?] WARNING in udf_setsize
From:   syzbot <syzbot+0937935b993956ba28ab@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, jack@suse.com, jack@suse.cz,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    764822972d64 Merge tag 'nfsd-6.2' of git://git.kernel.org/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11536087880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c59170b68d26a55
dashboard link: https://syzkaller.appspot.com/bug?extid=0937935b993956ba28ab
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c41f07880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137b3913880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c840c19749d/disk-76482297.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdfd51618ae0/vmlinux-76482297.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fef17b5d4d6d/bzImage-76482297.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f0caf90549db/mount_0.gz

The issue was bisected to:

commit 16d0556568148bdcaa45d077cac9f8f7077cf70a
Author: Jan Kara <jack@suse.cz>
Date:   Wed Dec 7 17:17:34 2022 +0000

    udf: Discard preallocation before extending file with a hole

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1790d4e7880000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1450d4e7880000
console output: https://syzkaller.appspot.com/x/log.txt?x=1050d4e7880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0937935b993956ba28ab@syzkaller.appspotmail.com
Fixes: 16d055656814 ("udf: Discard preallocation before extending file with a hole")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3631 at fs/udf/inode.c:639 udf_setsize+0xf9e/0x1380 fs/udf/inode.c:1236
Modules linked in:
CPU: 1 PID: 3631 Comm: syz-executor194 Not tainted 6.1.0-syzkaller-03225-g764822972d64 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:udf_extend_file fs/udf/inode.c:638 [inline]
RIP: 0010:udf_setsize+0xf9e/0x1380 fs/udf/inode.c:1236
Code: 8e fe 45 85 f6 49 bf 00 00 00 00 00 fc ff df 74 0a e8 86 28 8e fe e9 34 ff ff ff e8 7c 28 8e fe e9 fa fd ff ff e8 72 28 8e fe <0f> 0b e9 61 f6 ff ff 89 d9 80 e1 07 38 c1 0f 8c 1a f1 ff ff 48 89
RSP: 0018:ffffc90003cefb00 EFLAGS: 00010293
RAX: ffffffff82fd3d5e RBX: 0000000000000800 RCX: ffff888022760000
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000000000800
RBP: ffffc90003cefcd8 R08: ffffffff82fd33b8 R09: ffffed100df29024
R10: ffffed100df29024 R11: 1ffff1100df29023 R12: 1ffff9200079df70
R13: ffffc90003cefc10 R14: 0000000000001000 R15: 0000000000000009
FS:  00005555566c83c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560387521d28 CR3: 0000000073ea7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_setattr+0x362/0x530 fs/udf/file.c:281
 notify_change+0xe50/0x1100 fs/attr.c:482
 do_truncate+0x200/0x2f0 fs/open.c:65
 do_sys_ftruncate+0x2bc/0x360 fs/open.c:193
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd454550da9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb8edd258 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
RAX: ffffffffffffffda RBX: 00007ffeb8edd268 RCX: 00007fd454550da9
RDX: ffffffffffffffc0 RSI: 00000000000007fb RDI: 0000000000000004
RBP: 00007ffeb8edd260 R08: 00007fd45450e360 R09: 00007fd45450e360
R10: 00007ffeb8edd260 R11: 0000000000000246 R12: 0000000000000000
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
