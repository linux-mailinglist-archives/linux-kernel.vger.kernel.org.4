Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0125E73B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIWGMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIWGMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:12:40 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C875B1191A2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:12:37 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x14-20020a056e021cae00b002f1d5aca8c6so7160972ill.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=FaaTPbSkbQ7kmqxkVamqyS6g5Yg4/PYcUzSE6v30wKM=;
        b=AUnuUhiFhFZs+fa5x4foS9pvLLsqv+OeOFk9srsQpd1KoQ2Ldqn1PPIJi7luPf0boO
         5iT/Lj5DD/PEsPba68fmaFI5qHHhGAZI3CqIJd3t0qs8G+n5VzPc2U0nDQAY7EBwm/ie
         PaKibLXVQOyERu6OMIfiCLB6Y/xb0aKloc1KtJOQmZECcgT4go1NhN3NqzcArcFUe9No
         EZhuLpjOxnGYnwUXQmd0cGvRuod+0rs3t8l/Xr+usFFKhHT4l81h0t7eCYkKeECShklX
         HETAOlztatcB+UFGUiRPPn3Lg61WSXY6RSLW3iwNiHgxQ27rsvucIt7EuhOTCUNQLwIv
         MCfg==
X-Gm-Message-State: ACrzQf3T0JrBefU64osqL37OvzZveO66sWpKL6BI739fQEFl0hjiIp2P
        l3l0/uCT52zJvQvLbngfsZ0wwDZIsJ1GfCi8jDwTmsKuP2Ym
X-Google-Smtp-Source: AMsMyM5Zi7DcPO6cVdYtSrMXtzFo/D2gd1Qa/Ck0C7ddZIvL30/9wWHabyYBVFFElIs5FneHWPNaYM7jxKpkNusnmjykPeWXAmdU
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1506:b0:6a1:e92e:4ebe with SMTP id
 g6-20020a056602150600b006a1e92e4ebemr3135383iow.99.1663913557116; Thu, 22 Sep
 2022 23:12:37 -0700 (PDT)
Date:   Thu, 22 Sep 2022 23:12:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000824da605e9521001@google.com>
Subject: [syzbot] kernel BUG in gfs2_glock_nq (2)
From:   syzbot <syzbot+70f4e455dee59ab40c80@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    e47eb90a0a9a Add linux-next specific files for 20220901
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1622f1d8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7933882276523081
dashboard link: https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/d3bf639370bc/disk-e47eb90a.raw.xz
vmlinux: https://storage.googleapis.com/1c9c27c6eeef/vmlinux-e47eb90a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+70f4e455dee59ab40c80@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: G:  s:EX n:8/1 f:qb t:EX d:EX/0 a:0 v:0 r:5 m:20 p:0
gfs2: fsid=syz:syz.0:  H: s:EX f:cH e:0 p:15361 [syz-executor.5] gfs2_quota_sync+0x2e2/0x660 fs/gfs2/quota.c:1322
------------[ cut here ]------------
kernel BUG at fs/gfs2/glock.c:1541!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 15361 Comm: syz-executor.5 Not tainted 6.0.0-rc3-next-20220901-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
RIP: 0010:add_to_queue fs/gfs2/glock.c:1541 [inline]
RIP: 0010:gfs2_glock_nq.cold+0x2a1/0x2fa fs/gfs2/glock.c:1566
Code: 74 04 3c 03 7e 76 8b 53 18 44 89 f1 4c 89 ee 48 c7 c7 60 3a 3a 8a e8 8f 80 f3 ff ba 01 00 00 00 4c 89 e6 31 ff e8 fe f1 38 fa <0f> 0b e8 a7 3c 7e f8 4c 8b 04 24 e9 7f fd ff ff 45 31 f6 e9 fc fd
RSP: 0018:ffffc9000c52f7f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88803ee655e0 RCX: ffffc90003e01000
RDX: 0000000000040000 RSI: ffffffff8383b5be RDI: ffffffff8a3a6fb0
RBP: ffff888075ee90e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 6863657469676f6c R12: ffff88803ee655e0
R13: ffff888038445270 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f82a2a0a700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021000000 CR3: 0000000079881000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_glock_nq_init fs/gfs2/glock.h:263 [inline]
 do_sync+0x4b9/0xcf0 fs/gfs2/quota.c:914
 gfs2_quota_sync+0x2e2/0x660 fs/gfs2/quota.c:1322
 gfs2_sync_fs+0x40/0xb0 fs/gfs2/super.c:642
 sync_filesystem.part.0+0x75/0x1d0 fs/sync.c:56
 sync_filesystem+0x8b/0xc0 fs/sync.c:43
 generic_shutdown_super+0x70/0x410 fs/super.c:473
 kill_block_super+0x97/0xf0 fs/super.c:1427
 gfs2_kill_sb+0x104/0x160 fs/gfs2/ops_fstype.c:1733
 deactivate_locked_super+0x94/0x160 fs/super.c:331
 deactivate_super+0xad/0xd0 fs/super.c:362
 cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 get_signal+0x1c3/0x2610 kernel/signal.c:2635
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:294
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f82a188a93a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f82a2a09f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffec RBX: 0000000020000200 RCX: 00007f82a188a93a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f82a2a09fe0
RBP: 00007f82a2a0a020 R08: 00007f82a2a0a020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f82a2a09fe0 R15: 0000000020047a20
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:add_to_queue fs/gfs2/glock.c:1541 [inline]
RIP: 0010:gfs2_glock_nq.cold+0x2a1/0x2fa fs/gfs2/glock.c:1566
Code: 74 04 3c 03 7e 76 8b 53 18 44 89 f1 4c 89 ee 48 c7 c7 60 3a 3a 8a e8 8f 80 f3 ff ba 01 00 00 00 4c 89 e6 31 ff e8 fe f1 38 fa <0f> 0b e8 a7 3c 7e f8 4c 8b 04 24 e9 7f fd ff ff 45 31 f6 e9 fc fd
RSP: 0018:ffffc9000c52f7f0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88803ee655e0 RCX: ffffc90003e01000
RDX: 0000000000040000 RSI: ffffffff8383b5be RDI: ffffffff8a3a6fb0
RBP: ffff888075ee90e0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 6863657469676f6c R12: ffff88803ee655e0
R13: ffff888038445270 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f82a2a0a700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000021000000 CR3: 0000000079881000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
