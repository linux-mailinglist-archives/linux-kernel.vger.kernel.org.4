Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F596110F8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJ1MOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiJ1MNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:13:53 -0400
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1198BDB55A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:13:52 -0700 (PDT)
Received: by mail-qv1-f70.google.com with SMTP id nn2-20020a056214358200b004bb7bc3dfdcso2846590qvb.23
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6ne5l4wFuW3mDlWTj92zFRxrlKnOY6SlahMV9UlXFU=;
        b=GuGg6UdJb4l4sRu3OtCAOJ5jqPUyrl/aWk71jEKfI1gEPrRpuBJD8B0qF8GX+ZQMC5
         MtzrEI2WF/0JyHdZ6JKYtdmWuVfoRtWvGz7DCULfdz8EN42JG5+Bxn1rVS3CxTUCUtSl
         BPao74Wet58Nt6Y4Ho1o+L4kMCAfLAs5LM/Moc6z4Pxw+SHEfL493AWYEpxpf0l6H3zc
         ACG1JumU7MHQo6iiLTLywPdPrGNE1iWGMH4g2Fobc7iLqlaLaJbNBF/MQvC33y1F+UBb
         qmzOaEsxh4q/u00slZTFxLz/jma3PLdenODWk7Btf4bY5L7W6VduzduBoBDSM4LepQGH
         XJ1A==
X-Gm-Message-State: ACrzQf0vpEFtjdrI8vWW8v76mat5pY1sgthhBS8HtgnMAhoEQ8HXA1hY
        dH8qIiWvjNPJ/UYk1rNzVrwewLJjh1qa3R2CcNbPa7wnrCLO
X-Google-Smtp-Source: AMsMyM4q2ydnFVVPRFgahh5a3y2Hk6ZYLuulgKgwoqfWPdZkx26jfpTP2h1x9f7PJf7bsrmQ/8Bsv96gp0UBRSgYz+zz1O+JSDdf
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1450:b0:363:7052:9c30 with SMTP id
 l16-20020a056638145000b0036370529c30mr35103714jad.53.1666959221083; Fri, 28
 Oct 2022 05:13:41 -0700 (PDT)
Date:   Fri, 28 Oct 2022 05:13:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a534305ec1730ec@google.com>
Subject: [syzbot] kernel BUG in add_to_queue
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

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10f68cb6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=8a4b520a9affc6d8ea56
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a4b520a9affc6d8ea56@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: G:  s:EX n:8/1 f:qb t:EX d:EX/0 a:0 v:0 r:5 m:20 p:0
gfs2: fsid=syz:syz.0:  H: s:EX f:cH e:0 p:3072 [syz-executor.5] gfs2_quota_sync+0xf0/0x204 fs/gfs2/quota.c:1322
------------[ cut here ]------------
kernel BUG at fs/gfs2/glock.c:1521!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3072 Comm: syz-executor.5 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : add_to_queue+0x5e0/0x710 fs/gfs2/glock.c:1520
lr : add_to_queue+0x5e0/0x710 fs/gfs2/glock.c:1520
sp : ffff80001367ba40
x29: ffff80001367ba50 x28: ffff000131decee0 x27: ffff0000c91a1b00
x26: 0000000000000040 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000000000000 x22: ffff0000c91a1b00 x21: ffff00012b643270
x20: ffff000131decf18 x19: ffff0001172327f8 x18: 00000000000000c0
x17: 205d352e726f7475 x16: ffff80000db49158 x15: ffff0000c73c1a80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c73c1a80
x11: ff8080000926b160 x10: 0000000000000000 x9 : 8630f0a241885900
x8 : 8630f0a241885900 x7 : ffff80000819545c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000000
Call trace:
 add_to_queue+0x5e0/0x710 fs/gfs2/glock.c:1520
 gfs2_glock_nq+0x90/0x220 fs/gfs2/glock.c:1546
 gfs2_glock_nq_init fs/gfs2/glock.h:263 [inline]
 do_sync+0x1dc/0x650 fs/gfs2/quota.c:914
 gfs2_quota_sync+0xf0/0x204 fs/gfs2/quota.c:1322
 gfs2_sync_fs+0x30/0x78 fs/gfs2/super.c:642
 sync_filesystem+0x68/0x134 fs/sync.c:56
 generic_shutdown_super+0x38/0x190 fs/super.c:474
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
Code: 52800022 aa1f03e0 aa1303e1 97fff284 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
