Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2C652CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbiLUGDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiLUGDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:03:39 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4550114D05
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:03:38 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so9643254iln.21
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onq5DwacPyPQ+cFXzEgJdtVxJlTaEMuU0hdJQMmJGfk=;
        b=Dlv6gJY+u+jsPYwUz+2VAXiKx2kOJoxo9r06/PBKy+2UTDZPRzR4EEJAGGPeHtxjVo
         sPNF06aRvxUHBLcnVPlYNfqLFflZmJdpyShvdkf2I+ik0LkCHaqAEkmkjafYfS5NZXJJ
         W4mrRQNAAHeGnolJSGsK3micC8kmwzcbtpph9qZN/rKISqsTIHkAgKSlhjhBE5/I1wRh
         OCAfW9JTG3L/OczUpxKnW1vGRYIuJwaARbebcvbogV/AH+wun1XoszttgQGQUV1hNZ3w
         b1GL8diTMjLHCClZwUyRoVELXq5Ds8AnIG4neOp1Co3z2FbBmUL/glMTtlnI6PakSHfp
         Ucqw==
X-Gm-Message-State: AFqh2kpgjTn5/i0qeid8drGmA9WvZiaWKPBVoMX2jgx/xMYi1Z1wHmdZ
        F8rvPrmiM+Ca30ep3Pzupbd7UjWAMfwNDAqVRqYdro6pykPc
X-Google-Smtp-Source: AMrXdXup3/6FtCOVwF+ggAVabPMfxpo3hhvQn492Lvgs5n7McxQfpEyT76UpsdnFjt15xS7mmclJaPP01o/yFnkIBrSF+v+I4OcB
MIME-Version: 1.0
X-Received: by 2002:a92:cb42:0:b0:304:ad4b:974a with SMTP id
 f2-20020a92cb42000000b00304ad4b974amr77296ilq.93.1671602617584; Tue, 20 Dec
 2022 22:03:37 -0800 (PST)
Date:   Tue, 20 Dec 2022 22:03:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a14a905f05050b0@google.com>
Subject: [syzbot] WARNING in io_sync_cancel
From:   syzbot <syzbot+7df055631cd1be4586fd@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
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

HEAD commit:    77856d911a8c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102b57e0480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=334a10f27a9ee2e0
dashboard link: https://syzkaller.appspot.com/bug?extid=7df055631cd1be4586fd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ac9ee7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142b36b7880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/84863f051feb/disk-77856d91.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/87614e2a8a26/vmlinux-77856d91.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb76bad63a90/bzImage-77856d91.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7df055631cd1be4586fd@syzkaller.appspotmail.com

------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=1 set at [<ffffffff81607e7c>] prepare_to_wait+0x7c/0x380 kernel/sched/wait.c:272
WARNING: CPU: 1 PID: 5096 at kernel/sched/core.c:9908 __might_sleep+0x109/0x160 kernel/sched/core.c:9908
Modules linked in:
CPU: 1 PID: 5096 Comm: syz-executor144 Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__might_sleep+0x109/0x160 kernel/sched/core.c:9908
Code: ac 03 00 48 8d bb b8 16 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 75 34 48 8b 93 b8 16 00 00 48 c7 c7 80 d6 2b 8a e8 74 f6 5b 08 <0f> 0b e9 75 ff ff ff e8 7b 78 78 00 e9 26 ff ff ff 89 34 24 e8 8e
RSP: 0018:ffffc90003dffad0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888022358000 RCX: 0000000000000000
RDX: ffff888022358000 RSI: ffffffff8166707c RDI: fffff520007bff4c
RBP: ffffffff8a2c3500 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000000244
R13: dffffc0000000000 R14: 00000000fffffffc R15: ffffc90003dffd28
FS:  00007fe7d4cb4700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe7d4c93718 CR3: 000000007bdf1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0x9f/0x1360 kernel/locking/mutex.c:747
 io_sync_cancel+0x590/0x630 io_uring/cancel.c:297
 __io_uring_register io_uring/io_uring.c:4130 [inline]
 __do_sys_io_uring_register+0x1006/0x1440 io_uring/io_uring.c:4164
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe7d4d44f09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe7d4cb41f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 00007fe7d4dcd408 RCX: 00007fe7d4d44f09
RDX: 0000000020000080 RSI: 0000000000000018 RDI: 0000000000000003
RBP: 00007fe7d4dcd400 R08: 00007fe7d4cb4700 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007fe7d4dcd40c
R13: 00007ffc08404dcf R14: 00007fe7d4cb4300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
