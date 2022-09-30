Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892635F161C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiI3W1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiI3W0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:26:45 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA18EDE90
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:26:44 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id v20-20020a6b5b14000000b0069fee36308eso3661131ioh.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=yqzu+pQ7mY7EMK1zSooECdQ62Yy639KU9X1VTzHLljc=;
        b=WUTIB1S8P00JTRcVIFfVQMIo5xyWvNXTSAtSlKJ8/Blx3XPtwcnFfLyQTHWhTGvlTW
         /Rfmb7T3zKCP1FyjICvWpl9L2r/3DE7k1p7nOdGRvZCVlhxfHdA/qBQvc9/SEhMfQ8IN
         u3SUnTw2NCjOK3QQLTrHpGbb4vlij75gI2LAwGNFfACTCUjEY1EZ7lP3Zrl62yI/6lZz
         tF6ZG2W5+K2Au4ztVkPgLHzCLWO7/yop0BJ0pIY++YVkB1blU5QJ+k6o9DKLjEff2Lqy
         saihNPipuzILWOGT77Z+6fZku5VoV1PJiuaLZk0SGlEojBgyHb4GOPOknwascBiSIRnH
         lf7w==
X-Gm-Message-State: ACrzQf1V3wBPk7WwYwbl5uGfdtozTdpaH6mQ05gHFEA8vm8xplVSry9j
        cnYNjBrcZJ0VVIRCSyh2T7cPfBvLwVEidKByfwyfJHhc9lR/
X-Google-Smtp-Source: AMsMyM7tveVr9Hz8iwQCl5u9eG6MXCTvdyCYud3o0qSEgjjqPEiiGtPnuIvhgVL9F/veKLWIMNbfjjRghC8J0kio6sBXwOrCVx6R
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b8e:b0:2f9:167c:bd97 with SMTP id
 h14-20020a056e021b8e00b002f9167cbd97mr5256940ili.186.1664576803652; Fri, 30
 Sep 2022 15:26:43 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:26:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000154d2c05e9ec7df6@google.com>
Subject: [syzbot] WARNING in nilfs_dat_commit_end
From:   syzbot <syzbot+cbff7a52b6f99059e67f@syzkaller.appspotmail.com>
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

HEAD commit:    c3e0e1e23c70 Merge tag 'irq_urgent_for_v6.0' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10f98c04880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=cbff7a52b6f99059e67f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d224b8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d3e4d0880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e7f1f925f94e/disk-c3e0e1e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/830dabeedf0d/vmlinux-c3e0e1e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbff7a52b6f99059e67f@syzkaller.appspotmail.com

NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3609 at fs/nilfs2/dat.c:186 nilfs_dat_commit_end+0x56b/0x610
Modules linked in:
CPU: 0 PID: 3609 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-00081-gc3e0e1e23c70 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:nilfs_dat_commit_end+0x56b/0x610 fs/nilfs2/dat.c:186
Code: 48 89 ee 48 83 c4 38 5b 41 5c 41 5d 41 5e 41 5f 5d e9 69 77 03 00 e8 14 49 40 fe e8 0f 46 b9 fd e9 24 fd ff ff e8 05 49 40 fe <0f> 0b e9 75 fc ff ff e8 f9 48 40 fe e8 f4 45 b9 fd 43 80 7c 25 00
RSP: 0018:ffffc9000389f2a8 EFLAGS: 00010293
RAX: ffffffff8347407b RBX: ffff888079c311a0 RCX: ffff8880775a9d80
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 000023d50af30002
RBP: 0000000000000003 R08: ffffffff83473ce9 R09: ffffed100f211f9b
R10: ffffed100f211f9b R11: 1ffff1100f211f9a R12: ffff8880723fda40
R13: ffffc9000389f3b8 R14: ffff888074fb8180 R15: 000023d50af30002
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fec40ab81d0 CR3: 000000000c88e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_dat_commit_update+0x25/0x40 fs/nilfs2/dat.c:236
 nilfs_direct_propagate+0x215/0x390 fs/nilfs2/direct.c:277
 nilfs_bmap_propagate+0x6d/0x120 fs/nilfs2/bmap.c:337
 nilfs_collect_file_data+0x49/0xc0 fs/nilfs2/segment.c:568
 nilfs_segctor_apply_buffers+0x192/0x380 fs/nilfs2/segment.c:1012
 nilfs_segctor_scan_file+0x842/0xaf0 fs/nilfs2/segment.c:1061
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
