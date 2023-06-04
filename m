Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226D6721579
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjFDICy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFDICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:02:53 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383CBC4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 01:02:51 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7776b76cc59so279860439f.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 01:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685865770; x=1688457770;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pX3JrkxK3bl4mL5qQRzJ3YzJ93nC54ATg72Z3TueWFg=;
        b=Cn27lcB/f1xtvl6SJQaa0g0855ghagYBexu2L/YN4K9X6xeF0S1IGG9O8E3BLhhBkj
         KM++0/Qwv/BHDKbLE1EdwH6Djw0NQUagCij3lY4eSBjw8AJ91rXOcEa8+0Lx1ikBs0DX
         Jhebh7Y1FeEiLjr85JtF2fywORNPcvQas3ljRSRar6CS6dkumQq3n9f2A5zfF9LYvepz
         xYs//8yz8LQq4zk9gcTuJv70KVWv+DAE7DB5E0LmOaTi4a0mBd0txXb6f9GjwE+EplOR
         8lSFcwV3GS0p4n8NjT5WRtHMPFxtRXiGb4taSsqVpch6364wvGk1qjFK7aWGk5eW1pTo
         T0qQ==
X-Gm-Message-State: AC+VfDw78QdE+erR2L2RqBuHtUuM4GfcTac+SljCh7EtRdyh99PoRcBR
        fk0pKaDvc8UNSGw3hnoTdoc3y4qQKu9JQ4qeV5xa9ja7jpJ0
X-Google-Smtp-Source: ACHHUZ7qk0MWucJ4G9ALaHbToQi4eroKlaw30e7bZ4ghmojvQqN8CxQfvRbeszVQphZZMrO/BeyBLwC1EifGg3Yweyz2eooA6Ya1
MIME-Version: 1.0
X-Received: by 2002:a02:29c5:0:b0:41c:feac:7a9c with SMTP id
 p188-20020a0229c5000000b0041cfeac7a9cmr6425394jap.6.1685865770507; Sun, 04
 Jun 2023 01:02:50 -0700 (PDT)
Date:   Sun, 04 Jun 2023 01:02:50 -0700
In-Reply-To: <00000000000050314505d3429981@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063e8d005fd493617@google.com>
Subject: Re: [syzbot] [jfs?] kernel BUG in lbmIODone
From:   syzbot <syzbot+52ddb6c83a04ca55f975@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    715abedee4cd Add linux-next specific files for 20230515
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16769f33280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a2745d066dda0ec
dashboard link: https://syzkaller.appspot.com/bug?extid=52ddb6c83a04ca55f975
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1262d159280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e3b42d280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d4d1d06b34b8/disk-715abede.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ef33a86fdc8/vmlinux-715abede.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0006b413ed1/bzImage-715abede.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e03edfdf992b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52ddb6c83a04ca55f975@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_logmgr.c:2298 assert(bp->l_flag & lbmRELEASE)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_logmgr.c:2298!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.4.0-rc2-next-20230515-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:lbmIODone+0x111a/0x11d0 fs/jfs/jfs_logmgr.c:2298
Code: fe e9 97 f3 ff ff e8 25 70 95 fe 48 c7 c1 80 ac 89 8a ba fa 08 00 00 48 c7 c6 c0 aa 89 8a 48 c7 c7 00 ab 89 8a e8 26 58 79 fe <0f> 0b e8 df 70 e8 fe e9 09 f2 ff ff e8 f5 6f 95 fe 48 c7 c1 c0 ac
RSP: 0018:ffffc90000147c70 EFLAGS: 00010086
RAX: 000000000000003f RBX: ffff88814aa95200 RCX: 0000000000000100
RDX: 0000000000000000 RSI: ffffffff81689ddc RDI: 0000000000000005
RBP: 0000000000000020 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000101 R11: 0000000000000001 R12: 0000000000000246
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5731f31000 CR3: 00000000219b5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bio_endio+0x5af/0x6c0 block/bio.c:1608
 req_bio_endio block/blk-mq.c:761 [inline]
 blk_update_request+0x56a/0x14f0 block/blk-mq.c:906
 blk_mq_end_request+0x59/0x4c0 block/blk-mq.c:1023
 lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1101
 __do_softirq+0x1d4/0x905 kernel/softirq.c:553
 run_ksoftirqd kernel/softirq.c:921 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
 smpboot_thread_fn+0x659/0x9f0 kernel/smpboot.c:164
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lbmIODone+0x111a/0x11d0 fs/jfs/jfs_logmgr.c:2298
Code: fe e9 97 f3 ff ff e8 25 70 95 fe 48 c7 c1 80 ac 89 8a ba fa 08 00 00 48 c7 c6 c0 aa 89 8a 48 c7 c7 00 ab 89 8a e8 26 58 79 fe <0f> 0b e8 df 70 e8 fe e9 09 f2 ff ff e8 f5 6f 95 fe 48 c7 c1 c0 ac
RSP: 0018:ffffc90000147c70 EFLAGS: 00010086
RAX: 000000000000003f RBX: ffff88814aa95200 RCX: 0000000000000100
RDX: 0000000000000000 RSI: ffffffff81689ddc RDI: 0000000000000005
RBP: 0000000000000020 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000101 R11: 0000000000000001 R12: 0000000000000246
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5731f31000 CR3: 00000000219b5000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
