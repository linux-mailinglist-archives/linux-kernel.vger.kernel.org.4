Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10AB5F9A40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiJJHnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiJJHmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:42:18 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8DCEE27
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:37:36 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h10-20020a056e021d8a00b002f99580de6cso8150533ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mhx3CAe2+dSGVGWbh5A0XVveuC07dpAoSZWx+kYbg0U=;
        b=UKZa2xhTrTvg993JbTqnE66vx15g7aDW4PtY2vhtY7zSpziY1rW6aSoz+FUk8eXx/t
         kXCgQaRDREDA7tRqZ+kkyH299TgOkkf4M00CY0y/kaFc2aPsjBkh7qr9BVMy5v9CGpyK
         M3+A561RKNgD1scexN3vMoxrbC4mHi9uc3RHUsrTFSwEyQ5DJKR9IK5gcM3+ovi1V/25
         nrjv9DtcK8UQTWWXv9NIoK53lE/BGxJykJguxT4sWn+ZsB+jl57BjqJXvk93EaDDe93f
         j1i957RIvEMh6v+7F6OiUcUg5tMXIr+wvSAogTkvIvvk1ahLI0dzTtgn/PAxgwxALgrS
         YT/g==
X-Gm-Message-State: ACrzQf1mM9cLjigEpLpIYhzGkRkzW6JNo1H/a9FCt07C2Ihed4GKC9ik
        1YCui0mHl48cEvm//0y6u5ZjkghkPEkTx58u12sPA/J34Fk6
X-Google-Smtp-Source: AMsMyM4g1E9ZRPIwsQpQcy3XeKFlctSI65giWudHqqlyV0jYuZ/1ZxdHp18oL3P1SuDdkR3ASaxbdeHzyGBZJIgFwpWGDEtq1xNp
MIME-Version: 1.0
X-Received: by 2002:a92:2c0e:0:b0:2f5:64eb:34a4 with SMTP id
 t14-20020a922c0e000000b002f564eb34a4mr8462513ile.188.1665387455933; Mon, 10
 Oct 2022 00:37:35 -0700 (PDT)
Date:   Mon, 10 Oct 2022 00:37:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9753505eaa93b18@google.com>
Subject: [syzbot] possible deadlock in freeze_super (2)
From:   syzbot <syzbot+be899d4f10b2a9522dce@syzkaller.appspotmail.com>
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16b0403a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=be899d4f10b2a9522dce
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be899d4f10b2a9522dce@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
kworker/1:1H/76 is trying to acquire lock:
ffff000122d770e0 (&type->s_umount_key#113){+.+.}-{3:3}, at: freeze_super+0x40/0x1f0 fs/super.c:1696

but task is already holding lock:
ffff80000fb63d80 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x29c/0x504 kernel/workqueue.c:2264

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}:
       process_one_work+0x2c4/0x504 kernel/workqueue.c:2265
       worker_thread+0x340/0x610 kernel/workqueue.c:2436
       kthread+0x12c/0x158 kernel/kthread.c:376
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

-> #1 ((wq_completion)glock_workqueue){+.+.}-{0:0}:
       __flush_workqueue+0xb8/0x6dc kernel/workqueue.c:2809
       gfs2_gl_hash_clear+0x4c/0x1b0 fs/gfs2/glock.c:2207
       gfs2_put_super+0x318/0x390 fs/gfs2/super.c:619
       generic_shutdown_super+0x8c/0x190 fs/super.c:491
       kill_block_super+0x30/0x78 fs/super.c:1427
       gfs2_kill_sb+0x68/0x78
       deactivate_locked_super+0x70/0xe8 fs/super.c:332
       deactivate_super+0xd0/0xd4 fs/super.c:363
       cleanup_mnt+0x1f8/0x234 fs/namespace.c:1186
       __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
       task_work_run+0xc4/0x14c kernel/task_work.c:177
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
       prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
       exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
       el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #0 (&type->s_umount_key#113){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
       down_write+0x5c/0xcc kernel/locking/rwsem.c:1552
       freeze_super+0x40/0x1f0 fs/super.c:1696
       freeze_go_sync+0x84/0x1a8 fs/gfs2/glops.c:573
       do_xmote+0x180/0x954 fs/gfs2/glock.c:769
       run_queue+0x294/0x3c4 fs/gfs2/glock.c:893
       glock_work_func+0x190/0x288 fs/gfs2/glock.c:1059
       process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
       worker_thread+0x340/0x610 kernel/workqueue.c:2436
       kthread+0x12c/0x158 kernel/kthread.c:376
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

other info that might help us debug this:

Chain exists of:
  &type->s_umount_key#113 --> (wq_completion)glock_workqueue --> (work_completion)(&(&gl->gl_work)->work)

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((work_completion)(&(&gl->gl_work)->work));
                               lock((wq_completion)glock_workqueue);
                               lock((work_completion)(&(&gl->gl_work)->work));
  lock(&type->s_umount_key#113);

 *** DEADLOCK ***

2 locks held by kworker/1:1H/76:
 #0: ffff0000c0de2f38 ((wq_completion)glock_workqueue){+.+.}-{0:0}, at: process_one_work+0x270/0x504 kernel/workqueue.c:2262
 #1: ffff80000fb63d80 ((work_completion)(&(&gl->gl_work)->work)){+.+.}-{0:0}, at: process_one_work+0x29c/0x504 kernel/workqueue.c:2264

stack backtrace:
CPU: 1 PID: 76 Comm: kworker/1:1H Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Workqueue: glock_workqueue glock_work_func
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2053
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_write+0x5c/0xcc kernel/locking/rwsem.c:1552
 freeze_super+0x40/0x1f0 fs/super.c:1696
 freeze_go_sync+0x84/0x1a8 fs/gfs2/glops.c:573
 do_xmote+0x180/0x954 fs/gfs2/glock.c:769
 run_queue+0x294/0x3c4 fs/gfs2/glock.c:893
 glock_work_func+0x190/0x288 fs/gfs2/glock.c:1059
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
