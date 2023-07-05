Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59F5748B34
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 20:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjGESCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 14:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjGESCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 14:02:18 -0400
Received: from mail-pj1-f77.google.com (mail-pj1-f77.google.com [209.85.216.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12131703
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 11:02:17 -0700 (PDT)
Received: by mail-pj1-f77.google.com with SMTP id 98e67ed59e1d1-262cf62e9b4so9611567a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 11:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688580137; x=1691172137;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gFPCCg8zvDneik0VHuBo3IySlvWosQfa0VtoeNFj+c=;
        b=FfR6HcN29pf6CL/r80/X87+MKvEVCNsbFLoY5+JqgWfS4mqmXi5Ew5Z5nNhxcF6jyr
         0tzvLEo/KWqK1P+XNESwz8mK10G2u475mh+xPM69LUl1ca968eBYzV6eHKhETuVeA/mE
         lbwCC+toX8gFtcFVYplc170ew/Rkg8aUG8NEJmX1KCAj0AXw6InoYUQ5QJHFDdIpQyXM
         ZAyZE17HnrwvVEGOrWkIKqbTfqHw7iVNbr3Y4QQ19TfdAzBqTilBPDbhlcATFaZuX1gS
         01mjwgx4gqxYKCli8kAXeFvga3YFOxPDLMWppdeUKFi3jVASWM1A0Ofd76GVmmgCd7qd
         WgHw==
X-Gm-Message-State: ABy/qLYfrtAX6EYSv30Q8ihsPjh1VybGb+yJpPuUs0Smhftkqv+FJk5X
        wM8DYT5dfFG4WFzWW/mbntaXBTB1YStTSqK4jBgqfzWfQn3b
X-Google-Smtp-Source: APBJJlEvZo8KlDShC0mL15wRDN4gxADoIqfIGthya/Q40ebBrhQbb7IciKvbLj9ePl2PGXr1zOeHtQ/Z6IVpDJhVUn9qmQLEj4VQ
MIME-Version: 1.0
X-Received: by 2002:a17:90a:9d82:b0:262:e5cb:6c12 with SMTP id
 k2-20020a17090a9d8200b00262e5cb6c12mr13023247pjp.6.1688580137099; Wed, 05 Jul
 2023 11:02:17 -0700 (PDT)
Date:   Wed, 05 Jul 2023 11:02:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f2db705ffc133d2@google.com>
Subject: [syzbot] [crypto?] WARNING in extract_iter_to_sg
From:   syzbot <syzbot+f2c120b449b209d89efa@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3674fbf0451d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=10e4a802a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=f2c120b449b209d89efa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/42ed556782c3/disk-3674fbf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1913e16e8565/vmlinux-3674fbf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/469804b58a7c/bzImage-3674fbf0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2c120b449b209d89efa@syzkaller.appspotmail.com

extract_iter_to_sg(3) unsupported
------------[ cut here ]------------
WARNING: CPU: 0 PID: 26699 at lib/scatterlist.c:1362 extract_iter_to_sg lib/scatterlist.c:1361 [inline]
WARNING: CPU: 0 PID: 26699 at lib/scatterlist.c:1362 extract_iter_to_sg+0xf02/0x1960 lib/scatterlist.c:1339
Modules linked in:
CPU: 0 PID: 26699 Comm: syz-executor.2 Not tainted 6.4.0-rc7-syzkaller-01944-g3674fbf0451d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:extract_iter_to_sg lib/scatterlist.c:1362 [inline]
RIP: 0010:extract_iter_to_sg+0xf02/0x1960 lib/scatterlist.c:1339
Code: ff ff 48 c1 e3 06 48 01 c3 e9 8c fe ff ff e8 65 78 73 fd 40 0f b6 d5 48 c7 c6 e0 c7 a6 8a 48 c7 c7 00 c7 a6 8a e8 ee 58 57 fd <0f> 0b 48 c7 44 24 18 fb ff ff ff e9 1b fc ff ff e8 39 78 73 fd 48
RSP: 0018:ffffc90009937680 EFLAGS: 00010286
RAX: 0000000000000021 RBX: 0000000000000001 RCX: ffffc9000c714000
RDX: 0000000000000000 RSI: ffffffff8168bc0c RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: ffff88802dcea248
R13: ffff88802dcea268 R14: ffff88802dcea268 R15: ffffc90009937a40
FS:  00007fc151532700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc14effe718 CR3: 000000002b366000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 af_alg_get_rsgl+0x24d/0x7c0 crypto/af_alg.c:1249
 _skcipher_recvmsg crypto/algif_skcipher.c:77 [inline]
 skcipher_recvmsg+0x8ee/0xe40 crypto/algif_skcipher.c:157
 sock_recvmsg_nosec net/socket.c:1019 [inline]
 sock_recvmsg+0xe2/0x160 net/socket.c:1040
 sock_read_iter+0x2bd/0x3b0 net/socket.c:1106
 call_read_iter include/linux/fs.h:1862 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:420
 sock_splice_read+0xed/0x120 net/socket.c:1076
 do_splice_to+0x1b9/0x240 fs/splice.c:1007
 splice_file_to_pipe+0x104/0x120 fs/splice.c:1246
 do_splice+0x10e7/0x1e50 fs/splice.c:1335
 __do_splice+0x14e/0x270 fs/splice.c:1385
 __do_sys_splice fs/splice.c:1596 [inline]
 __se_sys_splice fs/splice.c:1578 [inline]
 __x64_sys_splice+0x19c/0x250 fs/splice.c:1578
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc15088c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc151532168 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007fc1509ac120 RCX: 00007fc15088c389
RDX: 000000000000000f RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007fc1508d7493 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffc693848f R14: 00007fc151532300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
