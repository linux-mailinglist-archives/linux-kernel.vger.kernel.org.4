Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00696262AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 21:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiKKURz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 15:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKKURx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 15:17:53 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A635E11175
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:17:51 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id m9-20020a056e021c2900b002fadb905ddcso4678377ilh.18
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 12:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyaZcp8B8nRUIyPycYcHuv+4RGt52VgPhOpupxsL+qw=;
        b=RIRdBUfsqfki1EZJa45+xJQl0Gym/Hd9lqEU8pbdgg3fLnbE9iWph+r5/WXrpAvfHn
         56DUNzJwMhWsExq+vZgW4b4Nvo1hSaWdV+mrf4ek6ZMjeQgR/B72gg2hil/irSNd2wg4
         VNIc3Dp9xKm3M0FZ8ny5dlhqPFETuX96j3SLA/iWwLEPoIJkWcDAxoOInrc95wXYRPkE
         FIHeNehY56fVvqIi8vCShrayTq4+agKAp8rYqTy3kROChXGyS3HCZKr46rIbZT9CSSQ9
         wfYeWamwZVoXebx+2nAkNkWy9v5xKDPj82Fg/ZEakLMn4eQyrWtpqzllszMyj9f6CKWg
         SNcg==
X-Gm-Message-State: ANoB5pmARCaS1n8fOQUzH4tAJZugCLQS/H79ZD7yXDm+AgK/LCPMifXl
        /3c7+fNBmQjOUVwboC/44jlGo/62PJ9P8AALV+LSDgqLY24g
X-Google-Smtp-Source: AA0mqf7aY02f/kA19ZQ1ZdkUtTdYfGVMXDVjfXYR51Rq8aSOU+asihFQhkFWO5oFHHuZ0HKrmu5hAbVvT2p4SGDGFglCBefL6CU7
MIME-Version: 1.0
X-Received: by 2002:a92:c144:0:b0:302:36a2:4d3b with SMTP id
 b4-20020a92c144000000b0030236a24d3bmr1783894ilh.258.1668197870991; Fri, 11
 Nov 2022 12:17:50 -0800 (PST)
Date:   Fri, 11 Nov 2022 12:17:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008400d405ed3795a5@google.com>
Subject: [syzbot] WARNING in ida_free
From:   syzbot <syzbot+84a3c66e4b9dbbb678a8@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, ericvh@gmail.com,
        linux-kernel@vger.kernel.org, linux_oss@crudebyte.com,
        lucho@ionkov.net, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f0c4d9fc9cc9 Linux 6.1-rc4
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17204056880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff27f0c8b406726e
dashboard link: https://syzkaller.appspot.com/bug?extid=84a3c66e4b9dbbb678a8
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92c7e839ac32/disk-f0c4d9fc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b7bedbc08fb4/vmlinux-f0c4d9fc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3fe25e2dfdb7/Image-f0c4d9fc.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+84a3c66e4b9dbbb678a8@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=0 which is not allocated.
WARNING: CPU: 0 PID: 3066 at lib/idr.c:525 ida_free+0x1b0/0x208 lib/idr.c:525
Modules linked in:
CPU: 0 PID: 3066 Comm: syz-executor.1 Not tainted 6.1.0-rc4-syzkaller-31833-gf0c4d9fc9cc9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : ida_free+0x1b0/0x208 lib/idr.c:525
lr : ida_free+0x1b0/0x208 lib/idr.c:525
sp : ffff800012bf3c40
x29: ffff800012bf3c80 x28: ffff0000c4048000 x27: 0000000000000000
x26: 00000000000000c0 x25: 0000000000000002 x24: ffff80000d2dd050
x23: 0007fffffffffffe x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000000 x19: 0000000000000000 x18: 000000000000033b
x17: 0000000000000000 x16: ffff80000db2a158 x15: ffff0000c4048000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c4048000
x11: ff808000081c06c8 x10: 0000000000000000 x9 : 16d63cd4e166ba00
x8 : 16d63cd4e166ba00 x7 : ffff800008162114 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecc8 x1 : 0000000100000000 x0 : 0000000000000030
Call trace:
 ida_free+0x1b0/0x208 lib/idr.c:525
 free_anon_bdev fs/super.c:1073 [inline]
 kill_anon_super+0x34/0x44 fs/super.c:1087
 v9fs_kill_super+0x24/0x50 fs/9p/vfs_super.c:223
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 13153724
hardirqs last  enabled at (13153723): [<ffff8000081621a4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1366 [inline]
hardirqs last  enabled at (13153723): [<ffff8000081621a4>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4950
hardirqs last disabled at (13153724): [<ffff80000c00eacc>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (13153716): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (13153683): [<ffff800008017c68>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
list_del corruption, ffff00012527d000->next is NULL
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:50!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3066 Comm: syz-executor.1 Tainted: G        W          6.1.0-rc4-syzkaller-31833-gf0c4d9fc9cc9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0x70/0xd0 lib/list_debug.c:49
lr : __list_del_entry_valid+0x70/0xd0 lib/list_debug.c:49
sp : ffff800012bf3cc0
x29: ffff800012bf3cc0 x28: ffff0000c4048000 x27: 0000000000000000
x26: 00000000000000c0 x25: 0000000000000002 x24: ffff80000d2dd050
x23: ffff80000d2d9000 x22: 0000000000000000 x21: 0000000000000000
x20: 0000000000000000 x19: ffff00012527d000 x18: 00000000000000c0
x17: ffff80000dcec198 x16: ffff80000db2a158 x15: ffff0000c4048000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c4048000
x11: ff808000081c06c8 x10: 0000000000000000 x9 : 16d63cd4e166ba00
x8 : 16d63cd4e166ba00 x7 : ffff80000c01c69c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcc8 x1 : 0000000100000001 x0 : 0000000000000033
Call trace:
 __list_del_entry_valid+0x70/0xd0 lib/list_debug.c:49
 __list_del_entry include/linux/list.h:134 [inline]
 list_del_init include/linux/list.h:206 [inline]
 __put_super+0x48/0x198 fs/super.c:289
 put_super fs/super.c:311 [inline]
 deactivate_locked_super+0xa0/0xe8 fs/super.c:343
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: d65f03c0 b001b160 91341000 94a843f8 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
