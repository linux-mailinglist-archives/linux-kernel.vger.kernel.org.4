Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8F738EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjFUS3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjFUS2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:28:52 -0400
Received: from mail-io1-xd50.google.com (mail-io1-xd50.google.com [IPv6:2607:f8b0:4864:20::d50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E6B2716
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:28:18 -0700 (PDT)
Received: by mail-io1-xd50.google.com with SMTP id ca18e2360f4ac-76c5c78bc24so651470939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687372033; x=1689964033;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SM44jaBHDK4+HpvQQwzk0Gkvb0ZUSmlYthl5LL2RKq4=;
        b=FrpVhH8OvPs8PPmURPyWJn2iMay/wA60a86wJIfB0rbjVCJL2Qnz3p0ezD4zWQyrty
         Zhoe1dITmvoxL4sLwyIz05mMgMHEM+KvBh11mTEhPcTY4WeXFLWntu99Uza5xFqSsRws
         RMICOTe77FBYhoZchuL0//Tmxc9aIoxVcwKNOJN1LioWn0eJjOMQHKhQSNnqCsD4zu8z
         ty9bdz5R4W3724KnpncFEp8ehFsmteFxl+L+X9tHhL6dT2dF/qd8Yavk2915YWoPUpfq
         jVuSzIuTOesGy8hLnAMiMlE3P3QzmupKMRPWyEIxG2UBYfLJ5SXudpniMNUoISBeWP6k
         zrtg==
X-Gm-Message-State: AC+VfDwckGmG7dW7jBr78/NpsCW2IbVXsDhofq469BohD2Wzt5Jo1WC+
        2Yitd7yg4Qkw3v8dY7378t6rNLFmDkwoCu58DofrqjFw8YpR
X-Google-Smtp-Source: ACHHUZ7jHo5FZZPRy71WKzHWombGzEdTy3syd1PGh14WTAvKMyegefApYIwOM5qO5JZsvxJE4Ymtvh1w2P2gpX99qmq0SKTpEGsy
MIME-Version: 1.0
X-Received: by 2002:a02:9402:0:b0:426:7963:1177 with SMTP id
 a2-20020a029402000000b0042679631177mr3463331jai.0.1687372033518; Wed, 21 Jun
 2023 11:27:13 -0700 (PDT)
Date:   Wed, 21 Jun 2023 11:27:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a973eb05fea7ea3d@google.com>
Subject: [syzbot] [batman?] WARNING in batadv_dat_free (2)
From:   syzbot <syzbot+6c881e6772625dc7feed@syzkaller.appspotmail.com>
To:     a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org,
        sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    970308a7b544 selftests/bpf: Set the default value of consu..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1788094b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba5f40cc4484255a
dashboard link: https://syzkaller.appspot.com/bug?extid=6c881e6772625dc7feed
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc4c2bba1144/disk-970308a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1075dd8a55dc/vmlinux-970308a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/59f3fdc83b37/bzImage-970308a7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c881e6772625dc7feed@syzkaller.appspotmail.com

bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): Released all slaves
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1005 at kernel/workqueue.c:642 set_work_data kernel/workqueue.c:642 [inline]
WARNING: CPU: 1 PID: 1005 at kernel/workqueue.c:642 clear_work_data kernel/workqueue.c:705 [inline]
WARNING: CPU: 1 PID: 1005 at kernel/workqueue.c:642 __cancel_work_timer+0x4d1/0x570 kernel/workqueue.c:3278
Modules linked in:
CPU: 1 PID: 1005 Comm: kworker/u4:5 Not tainted 6.4.0-rc3-syzkaller-00722-g970308a7b544 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: netns cleanup_net
RIP: 0010:set_work_data kernel/workqueue.c:642 [inline]
RIP: 0010:clear_work_data kernel/workqueue.c:705 [inline]
RIP: 0010:__cancel_work_timer+0x4d1/0x570 kernel/workqueue.c:3278
Code: e8 34 08 0e 00 e9 e1 fb ff ff e8 2a 41 30 00 e8 55 f5 bb 08 e9 51 fd ff ff e8 1b 41 30 00 0f 0b e9 a6 fc ff ff e8 0f 41 30 00 <0f> 0b e9 c0 fd ff ff e8 b3 4e 83 00 e9 fd fe ff ff e8 f9 40 30 00
RSP: 0018:ffffc90005237920 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802076d940 RSI: ffffffff815401c1 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888019b654b0
R13: 1ffff92000a46f25 R14: 0000000000000001 R15: ffff88802076d940
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f31ad4beba8 CR3: 000000002a10a000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 batadv_dat_free+0x45/0xe0 net/batman-adv/distributed-arp-table.c:840
 batadv_mesh_free+0x89/0x170 net/batman-adv/main.c:270
 batadv_softif_free+0x15/0x20 net/batman-adv/soft-interface.c:984
 netdev_run_todo+0x6bf/0x1100 net/core/dev.c:10395
 default_device_exit_batch+0x456/0x5b0 net/core/dev.c:11395
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:175
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:614
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
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
