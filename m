Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446A86CD108
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjC2EIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjC2EIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:08:04 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED98BC4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:08:01 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id l10-20020a056e0205ca00b00322fdda7261so9366217ils.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680062881; x=1682654881;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6FIhORUiy9XTRIPuHebwQvkH40JpM4p8Ltd3uLTvwc=;
        b=N25pYzEHd/cjv5PS9glw5lhJbUR4+erANBbuRSy/MBZk5PKmv/SVMKNHRVsDmLbqHl
         AyLnkma5qyhflEK3glhWNGmYNr2DatLn+KzFfH0FPCeiN5Ck7YRhpqcaSz2NYAFGDrr3
         GdiwDn/+e0Lck20Y4/mbZPB2Pe9KrHuIAyVlFHzQKPc6F9CpCShkKbmXOE0UxRsGqsfZ
         TilQ1hvs5TThAM706tjN3CuGRzbmHMy57MU8a8Tb92c37msfoujvMncd7qxUyfR8frU3
         moQn1UIFdA7tLnO3Q/JTvVsUg6Ge8qGCaX3KUDkIAgmaqs4/QJVm/3ltxxGGpvvLQWAm
         vmMA==
X-Gm-Message-State: AAQBX9dyTuPn7VhZxR8A4i7AQ4qNHR4ZNrO6T9ewYBKh/+SBCISNrvgx
        EefIj5jTPHf8zC3/hEFeklWg7RfOHlJ7KaeDFoaoVtHpM41A
X-Google-Smtp-Source: AKy350ZIX1k4/M05REDChOlzZNNvD5BIQYPrB6LEiu6iYcKDxliFghPbpUGv41h+xwDTMUuojHxXkouVcjr4xF3wx5kU0+6xjpse
MIME-Version: 1.0
X-Received: by 2002:a5d:87cf:0:b0:758:db6d:901b with SMTP id
 q15-20020a5d87cf000000b00758db6d901bmr394705ios.0.1680062881307; Tue, 28 Mar
 2023 21:08:01 -0700 (PDT)
Date:   Tue, 28 Mar 2023 21:08:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003da76805f8021fb5@google.com>
Subject: [syzbot] [xfs?] WARNING in xfs_bmap_extents_to_btree
From:   syzbot <syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f83651c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=0c383e46e9b4827b01b1
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/17229b6e6fe0/disk-1e760fa3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/69b5d310fba0/vmlinux-1e760fa3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c65624aace9/bzImage-1e760fa3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c383e46e9b4827b01b1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 24101 at fs/xfs/libxfs/xfs_bmap.c:660 xfs_bmap_extents_to_btree+0xe1b/0x1190
Modules linked in:
CPU: 1 PID: 24101 Comm: kworker/1:24 Not tainted 6.3.0-rc3-syzkaller-00031-g1e760fa3596e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: xfs-conv/loop0 xfs_end_io
RIP: 0010:xfs_bmap_extents_to_btree+0xe1b/0x1190 fs/xfs/libxfs/xfs_bmap.c:660
Code: 01 00 00 44 0f 44 f0 48 8b 84 24 88 00 00 00 42 0f b6 04 28 84 c0 0f 85 91 02 00 00 45 89 34 24 e9 10 fb ff ff e8 f5 81 75 fe <0f> 0b 41 bf e4 ff ff ff 48 8b 5c 24 18 e9 bd fa ff ff 89 d9 80 e1
RSP: 0018:ffffc9000346efe0 EFLAGS: 00010293
RAX: ffffffff8314eb2b RBX: ffffffffffffffff RCX: ffff8880338657c0
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: ffffffffffffffff
RBP: ffffc9000346f270 R08: ffffffff8314e358 R09: fffffbfff1ca6eae
R10: 0000000000000000 R11: dffffc0000000001 R12: 1ffff110038bc80f
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88801c5e4000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558b6f323000 CR3: 0000000042288000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xfs_bmap_add_extent_unwritten_real+0x1eec/0x31f0 fs/xfs/libxfs/xfs_bmap.c:2426
 xfs_bmapi_convert_unwritten+0x505/0x6e0 fs/xfs/libxfs/xfs_bmap.c:4191
 xfs_bmapi_write+0xb55/0x1980 fs/xfs/libxfs/xfs_bmap.c:4418
 xfs_iomap_write_unwritten+0x45f/0xc40 fs/xfs/xfs_iomap.c:615
 xfs_end_ioend+0x232/0x4d0 fs/xfs/xfs_aops.c:131
 xfs_end_io+0x2e5/0x370 fs/xfs/xfs_aops.c:173
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2390
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2537
 kthread+0x270/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
