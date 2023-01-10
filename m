Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C62663B87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbjAJInz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbjAJInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:43:49 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EB11082
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:43:47 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id y24-20020a5ec818000000b006e2c0847835so6522156iol.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiFJsZTBRGTxunWRYDyU0p652wffhtdiEmqd9792gjQ=;
        b=nWfCZvICzSi/jLAwyr0NEqcKMbTNvV0bnkLPrMepD3CZF6589kQXoFNWcE1Ns9Clsx
         fKS8acxWyx68UPPCdZ3gWvME9QZwdB2xe0vLNIxGp3mL7wXkYoBE5VuS0IuMaVq8FtTo
         nL5lUiFS/qbxoRNfeC/pcNtMGKxgg10PQERHojHcbyxO3nByVgT1X2wn5T9cujv3/r6j
         GesEK7/7Aq+U+/3f37f18vaAXOjQsRYqGStmGLhuCbOC48g3ougNqTnNLHETsgG4Hquv
         m69ykERXMtajrI4Hjozj9DcWGLVNSkEM5gvDuhm6dpKex3jfs0ATQgsE2VxKWk+sPXsB
         bjYQ==
X-Gm-Message-State: AFqh2krCh3Xrbql3c4SL0CjKMla9QDBySWBvxIDfo09zzU9xmGS6X077
        Ov0zzepPvPmKNbzDr8QhEdtt+SIvfLuDTrZvZ+DAOIapbBdx
X-Google-Smtp-Source: AMrXdXv0Inb9uYDW4zOFhepIA74RMNVeQ00HyVT1a7ids7AtNe4h7K9nt4/dKONzGkKSBG+TLO/tlmxcdSfDjntVit79fH39UCDv
MIME-Version: 1.0
X-Received: by 2002:a92:d747:0:b0:303:1fe3:b88a with SMTP id
 e7-20020a92d747000000b003031fe3b88amr7096067ilq.77.1673340227317; Tue, 10 Jan
 2023 00:43:47 -0800 (PST)
Date:   Tue, 10 Jan 2023 00:43:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d677c405f1e4e1e6@google.com>
Subject: [syzbot] WARNING in vma_complete
From:   syzbot <syzbot+ea4b1a683ce48cd567b1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    435bf71af3a0 Add linux-next specific files for 20230110
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13fb585a480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2de08b99ad4f49c
dashboard link: https://syzkaller.appspot.com/bug?extid=ea4b1a683ce48cd567b1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8541d2e988c8/disk-435bf71a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09d8d0545d93/vmlinux-435bf71a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f99de1e244bf/bzImage-435bf71a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea4b1a683ce48cd567b1@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcce031f7f R14: 00007f2ba41fc300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3905 at mm/mmap.c:170 vma_iter_store mm/mmap.c:170 [inline]
WARNING: CPU: 1 PID: 3905 at mm/mmap.c:170 vma_complete.cold+0x9/0x2fb mm/mmap.c:634
Modules linked in:
CPU: 1 PID: 3905 Comm: syz-executor.1 Not tainted 6.2.0-rc3-next-20230110-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:vma_iter_store mm/mmap.c:170 [inline]
RIP: 0010:vma_complete.cold+0x9/0x2fb mm/mmap.c:634
Code: 37 00 48 c1 ea 03 48 c1 e0 2a 80 3c 02 00 74 08 48 89 ef e8 4f e3 10 f8 4c 8b 6d 00 e9 ce b3 ff f7 48 89 34 24 e8 fd f5 c2 f7 <0f> 0b 48 8b 34 24 4c 89 f2 48 c7 c7 e0 53 58 8a e8 45 d9 fe ff 49
RSP: 0018:ffffc900037afae0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffffc900037afb88 RCX: ffffc90004b59000
RDX: 0000000000040000 RSI: ffffffff89bec7c3 RDI: 0000000000000006
RBP: ffffc900037afd58 R08: 0000000000000006 R09: 0000000020003000
R10: 0000000021000000 R11: 0000000000000000 R12: ffff888065beeee0
R13: ffff88807c133600 R14: 0000000020003000 R15: ffffc900037afd60
FS:  00007f2ba41fc700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fccb2385058 CR3: 000000002d40b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __split_vma+0x61d/0x740 mm/mmap.c:2273
 split_vma+0xc6/0x110 mm/mmap.c:2300
 mlock_fixup+0x56a/0x810 mm/mlock.c:436
 apply_vma_lock_flags+0x23d/0x350 mm/mlock.c:506
 do_mlock+0x25a/0x6d0 mm/mlock.c:601
 __do_sys_mlock2 mm/mlock.c:628 [inline]
 __se_sys_mlock2 mm/mlock.c:618 [inline]
 __x64_sys_mlock2+0xc1/0x100 mm/mlock.c:618
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2ba348c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2ba41fc168 EFLAGS: 00000246 ORIG_RAX: 0000000000000145
RAX: ffffffffffffffda RBX: 00007f2ba35abf80 RCX: 00007f2ba348c0c9
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020000000
RBP: 00007f2ba34e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcce031f7f R14: 00007f2ba41fc300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
