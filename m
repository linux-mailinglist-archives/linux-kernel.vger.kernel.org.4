Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D932638B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiKYNUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKYNUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:20:50 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35EA391F2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:20:49 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id bf14-20020a056602368e00b006ce86e80414so2065771iob.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:20:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXqRuXYuGUoJFgGF+ex++PGvqKyl+qDrq/iTVDy8jNw=;
        b=UZIcWCwitcq1gUgJElNybBEcgO4G9nMlrwdDjquqWCWaGrLTq1Q1r+I8sj5ipfGCdU
         VSrQM2hHbUhHxXc+LtJ3hvC9Alq7LIwB1H4G8recMzuVZtrunkPcwYQ55v+jUW4MUL5k
         QTpRwMKVw/2knQKTukDYJ301vdZ7jpP7IdoBqiOL3rSxYwMf8wgSfA8KPCDpFTQN3qpo
         uSqtwh0gQ5BeTLI90DNeJzIf7cuQ1BrCXUthBO4L2j+H1RqL+uNHr6xcs4O8+ojjAEm2
         +TpyGfyvRsrr5uMcOjTD8DujRG0SJ6bORPEAKNy368JgiDsUyNShOlZW7ZD6OosyYmev
         gJmw==
X-Gm-Message-State: ANoB5pk5WNqbs+0YKSzxnNmO2yBDen8p+nblPPMvzxQ8q5/feZRRlltG
        qPjyXBcgs4EI0r9z/C2zvG/Zg/uj9z7Y3R5r47yHf9+vknPk
X-Google-Smtp-Source: AA0mqf6+3MsCevf+kGZRVM3HZLTbTF4ur77N/dqqUhaBqYmH3ON0dDjtE+elHsHRMWahzekuLsUIS93tzTaECj/Uiu86nQJAhFwO
MIME-Version: 1.0
X-Received: by 2002:a02:93ab:0:b0:363:738a:bb7c with SMTP id
 z40-20020a0293ab000000b00363738abb7cmr8494468jah.227.1669382448987; Fri, 25
 Nov 2022 05:20:48 -0800 (PST)
Date:   Fri, 25 Nov 2022 05:20:48 -0800
In-Reply-To: <0000000000003a534305ec1730ec@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddc6ce05ee4b637d@google.com>
Subject: Re: [syzbot] kernel BUG in add_to_queue
From:   syzbot <syzbot+8a4b520a9affc6d8ea56@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    65762d97e6fa Merge branch 'for-next/perf' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12198e75880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56d0c7c3a2304e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=8a4b520a9affc6d8ea56
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146e6e75880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1762a3ed880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52f702197b30/disk-65762d97.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72189c2789ce/vmlinux-65762d97.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec0349196c98/Image-65762d97.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/9fcb4ad786f5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a4b520a9affc6d8ea56@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: G:  s:EX n:8/1 f:qb t:EX d:EX/0 a:0 v:0 r:5 m:20 p:0
gfs2: fsid=syz:syz.0:  H: s:EX f:cH e:0 p:3074 [syz-executor203] gfs2_quota_sync+0xf0/0x204 fs/gfs2/quota.c:1318
------------[ cut here ]------------
kernel BUG at fs/gfs2/glock.c:1560!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3074 Comm: syz-executor203 Not tainted 6.1.0-rc6-syzkaller-32653-g65762d97e6fa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : add_to_queue+0x6ec/0x780 fs/gfs2/glock.c:1559
lr : add_to_queue+0x6ec/0x780 fs/gfs2/glock.c:1559
sp : ffff800012deb950
x29: ffff800012deb960 x28: ffff0000cbfa6e80 x27: ffff0000ccea2000
x26: ffff0000cbfa6e80 x25: 0000000000000400 x24: ffff0000c207a800
x23: 0000000000000000 x22: ffff0000c207a800 x21: ffff0000ccea3270
x20: ffff0000cbfa6eb8 x19: ffff0000c70fc550 x18: 00000000000000c0
x17: 5d333032726f7475 x16: ffff80000dbe6158 x15: ffff0000c4248000
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c4248000
x11: ff8080000926a440 x10: 0000000000000000 x9 : 739e9965397fe700
x8 : 739e9965397fe700 x7 : ffff80000c08e4f4 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 add_to_queue+0x6ec/0x780 fs/gfs2/glock.c:1559
 gfs2_glock_nq+0x90/0x220 fs/gfs2/glock.c:1585
 gfs2_glock_nq_init fs/gfs2/glock.h:264 [inline]
 do_sync+0x1dc/0x650 fs/gfs2/quota.c:910
 gfs2_quota_sync+0xf0/0x204 fs/gfs2/quota.c:1318
 gfs2_sync_fs+0x30/0x78 fs/gfs2/super.c:643
 sync_filesystem+0x68/0x134 fs/sync.c:56
 generic_shutdown_super+0x38/0x198 fs/super.c:474
 kill_block_super+0x30/0x78 fs/super.c:1428
 gfs2_kill_sb+0x68/0x78
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0x100/0x148 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x2dc/0xcac kernel/exit.c:820
 __arm64_sys_exit_group+0x0/0x18 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __wake_up_parent+0x0/0x40 kernel/exit.c:959
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 52800022 aa1f03e0 aa1303e1 97fff219 (d4210000) 
---[ end trace 0000000000000000 ]---

