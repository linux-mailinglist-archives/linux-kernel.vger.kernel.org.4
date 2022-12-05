Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9240564258C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiLEJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiLEJOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:14:38 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0860C11C33
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:14:38 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso936764ilu.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OCCvnH6uv1l51v88/CU3IDqaUyGOYZt7ZdkI5+Fzfw=;
        b=JFEiBwv70ZnU/G0aGHzTSmn+mba3mavRN3jDafrG2FEITOWF9ZU6eNPcQORAej6Qov
         B0AbLNPPKlRQpeujjxYe9xZbcG6ZEuIXeSjIOsohNhG0ovnR6zjGEtezhM1Ig0HYGLm2
         9YHxBhzk46Kz/hB2sNyEglxSNGcjyTQcPmfUgRHhLkXm3kfOI12OMgQgvvBKO6WNbu31
         ZbjH6Y/EDhZ2e7CAQj03190FkXAmAe+X74cwVpw69nuuBHz97HtYwfHKKQ5v4vRNUPja
         6INe7rIscwqOUERfzcqxMx9/oxgxz97Rejenq834wJ9zDnHL0H8MdaWDKm+1wXq/lCDw
         xR1w==
X-Gm-Message-State: ANoB5plndhmr61b2cRV58xgPkw4GJFR7f3XPMqKixfQkGiFQAf6ci3jI
        nCe3ziKTZ/rg6/m7x88ZbpceeOVNOv96UM2uSK36bHmSv0Uf
X-Google-Smtp-Source: AA0mqf69NQh7ggeF9gM8lEdakOq3V+fPQlIthqQDWWS5LlF9TTyHRTKnyAEykT6MushBq0DtD+EzBSq5sCipun6LjHNzHzpqn8FY
MIME-Version: 1.0
X-Received: by 2002:a92:d741:0:b0:300:b96f:56a8 with SMTP id
 e1-20020a92d741000000b00300b96f56a8mr29109428ilq.213.1670231677277; Mon, 05
 Dec 2022 01:14:37 -0800 (PST)
Date:   Mon, 05 Dec 2022 01:14:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1205405ef111d3f@google.com>
Subject: [syzbot] kernel BUG in LogSyncRelease
From:   syzbot <syzbot+e3f67d10138647b6effa@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    e3cb714fb489 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1049346b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec7118319bfb771e
dashboard link: https://syzkaller.appspot.com/bug?extid=e3f67d10138647b6effa
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/832eb1866f2c/disk-e3cb714f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5fd572b7d96d/vmlinux-e3cb714f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/34c82908beda/Image-e3cb714f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3f67d10138647b6effa@syzkaller.appspotmail.com

read_mapping_page failed!
BUG at fs/jfs/jfs_txnmgr.c:2790 assert(mp->nohomeok)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:2790!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 17148 Comm: syz-executor.2 Not tainted 6.1.0-rc7-syzkaller-33097-ge3cb714fb489 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : LogSyncRelease+0x120/0x240 fs/jfs/jfs_txnmgr.c:2790
lr : LogSyncRelease+0x120/0x240 fs/jfs/jfs_txnmgr.c:2790
sp : ffff80001366b9d0
x29: ffff80001366b9d0 x28: ffff80000efd4000 x27: 0000000000000000
x26: 0000000000003cc8 x25: ffff00011c6c5e60 x24: ffff80000efd4308
x23: ffff80000efd4000 x22: 000000000000000d x21: ffff80000d5a8b88
x20: 0000000000000000 x19: ffff00011c6c5e60 x18: 000000000000ba7e
x17: ffff80000c0cd83c x16: ffff80000dbe6158 x15: ffff00010eb99a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff00010eb99a40
x11: ff808000081c4d64 x10: 0000000000000000 x9 : 878bda7d75e5d900
x8 : 878bda7d75e5d900 x7 : ffff80000816678c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : 0000000100000000 x0 : 0000000000000034
Call trace:
 LogSyncRelease+0x120/0x240 fs/jfs/jfs_txnmgr.c:2790
 txAbort+0xf0/0x260 fs/jfs/jfs_txnmgr.c:2616
 txCommit+0x348/0x1824 fs/jfs/jfs_txnmgr.c:1349
 jfs_mkdir+0x450/0x490 fs/jfs/namei.c:290
 vfs_mkdir+0x1f8/0x2b0 fs/namei.c:4036
 do_mkdirat+0xe4/0x22c fs/namei.c:4061
 __do_sys_mkdirat fs/namei.c:4076 [inline]
 __se_sys_mkdirat fs/namei.c:4074 [inline]
 __arm64_sys_mkdirat+0x40/0x54 fs/namei.c:4074
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 91097021 912ee063 52815cc2 94cbe7d5 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
