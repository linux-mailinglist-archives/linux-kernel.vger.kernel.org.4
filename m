Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62045F3398
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiJCQau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJCQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:30:45 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738F1F62B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 09:30:42 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id v20-20020a6b5b14000000b0069fee36308eso7254245ioh.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 09:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=rwiT/sy7NEzjdEE2iC1KVGA2WpvFuRRbJ9KhGB+mow8=;
        b=XryITkJOEtNYl3wU6PwdHbkmVZ/jdiANil0nLNQunooWgLnQ0zGuORSIGAbCHrbZdd
         njmNCNWTqp6lIB59DaNxAPMCTAT7B6iGC179ij9LFV7XWcXTWXrUIKSyNNzPyZ9vTEfd
         TgnA5BqaK2gJG0p/MiJ6IT8D72ynuHHjZ/ef31giejDDRJ3JH3SuFOSuF+NXbXgFUL4d
         l+X8MyQU8Fwd8y8386MiZBoRliqbJc/WHYXednN5bXrrdbteuaQyLue8jJiu419bidfh
         zRMj2ChxRZdFjCzmha0vGlvockqGCE9ODeK9RStdsV8FWoR6KhUDap2BR9LkB/SVtqFU
         B3hg==
X-Gm-Message-State: ACrzQf1CaAb88Ef7lcRE8sEGe2NqOrfokDZyeFy+Errd95ZAh6kXSHgO
        zCz93kGvtids3Or/uxOlUfKcZA2WHjTYpKzikxIHwQuKWtvz
X-Google-Smtp-Source: AMsMyM6RfSEwMALRq1yz1by1DkLwmWD/WZuVi30+r8h+l3uWqQ1Bfvg8P+352d88/PoBNDFMx1SZf61zjk7EcgNHAkYhQhiPl/4T
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41a8:b0:35a:2b7b:1a3f with SMTP id
 az40-20020a05663841a800b0035a2b7b1a3fmr10765404jab.101.1664814642148; Mon, 03
 Oct 2022 09:30:42 -0700 (PDT)
Date:   Mon, 03 Oct 2022 09:30:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005cc3d205ea23ddcf@google.com>
Subject: [syzbot] WARNING in nilfs_dat_prepare_end
From:   syzbot <syzbot+5d5d25f90f195a3cfcb4@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a962b54e162c Merge tag 'i2c-for-6.0-rc8' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16708124880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=5d5d25f90f195a3cfcb4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165b2f98880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c20e82880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7cf7771c181a/disk-a962b54e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dcd5516984d8/vmlinux-a962b54e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5d5d25f90f195a3cfcb4@syzkaller.appspotmail.com

NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3609 at fs/nilfs2/dat.c:151 nilfs_dat_prepare_end+0x247/0x2a0
Modules linked in:
CPU: 0 PID: 3609 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-00250-ga962b54e162c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:nilfs_dat_prepare_end+0x247/0x2a0 fs/nilfs2/dat.c:151
Code: 3f 40 fe 89 eb 89 d8 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 b8 3f 40 fe e8 b3 3c b9 fd e9 5a ff ff ff e8 a9 3f 40 fe <0f> 0b bb fe ff ff ff eb d2 44 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c
RSP: 0018:ffffc9000390f310 EFLAGS: 00010293
RAX: ffffffff834749d7 RBX: 00000000fffffffe RCX: ffff888027003b00
RDX: 0000000000000000 RSI: 00000000fffffffe RDI: 00000000fffffffe
RBP: 1ffff92000721e7c R08: ffffffff83474950 R09: ffffffff834596a3
R10: 0000000000000002 R11: ffff888027003b00 R12: ffffc9000390f3e0
R13: ffff88804cf90158 R14: ffffc9000390f3f8 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055db1609ac08 CR3: 000000000c88e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_dat_prepare_update+0x1f/0xd0 fs/nilfs2/dat.c:223
 nilfs_direct_propagate+0x1c2/0x390 fs/nilfs2/direct.c:274
 nilfs_bmap_propagate+0x6d/0x120 fs/nilfs2/bmap.c:337
 nilfs_segctor_apply_buffers+0x192/0x380 fs/nilfs2/segment.c:1012
 nilfs_segctor_scan_file+0x8b5/0xaf0 fs/nilfs2/segment.c:1072
 nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1170 [inline]
 nilfs_segctor_collect fs/nilfs2/segment.c:1497 [inline]
 nilfs_segctor_do_construct+0x1cce/0x6fe0 fs/nilfs2/segment.c:2039
 nilfs_segctor_construct+0x143/0x8d0 fs/nilfs2/segment.c:2375
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
 nilfs_segctor_thread+0x534/0x1180 fs/nilfs2/segment.c:2566
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
