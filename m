Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BB7634097
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiKVPwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKVPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:52:40 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164C9640F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:52:39 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id w9-20020a056e021c8900b0030247910269so10653921ill.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyFmpCbDj8SY6mbbs6IR7GSkVbHICa/WwOJS5wT0u4M=;
        b=HQ1sKuohV4jVgKZD9LAXnrkYRxSiE7/SNlKOSDjRJTGNYVc+jXgrl/E0MoswnQ7uHd
         XLHsk67hHFoMPWapRcwzFOTHRen8pFmLAbhwvwQlcX+p7b0Ti7897pogv2ir1pATEW9i
         X48aL1JLA9lZYaX8deQVmKN47RJvEBcupb5XCAoc5H08Od7tqb+v510n/1KUkXuXXOh1
         Clf7LVtGtAO2wi7vAB0wr2fHeTcDh5jPlz9tNgKzD86l7Rvl3m3R57vdIO1Y2w/lREzQ
         Hiy5F+fr5jpVUB8CsCd5YQoZSasMGGPebTjwSplppRbCxci45gJpxuo7NcuoCZXsAJdS
         DWkQ==
X-Gm-Message-State: ANoB5pnWXnWZImiiea+juWojoZh0uAtP4icGvXF5WGlUyUjgA3LM+jNv
        G0ofBb7OOy6icuMfM23jgPJoGwltubiTUkMcP923nOeLMCTF
X-Google-Smtp-Source: AA0mqf7oHqwWD89saT3KJILzQ2ZJzy10H/9z6Df7FDbqUCDtjgyJuUD2sPpZn434D1GrYx9RIMUoNb3kAV60M3wyThvHa/2ylmSF
MIME-Version: 1.0
X-Received: by 2002:a02:6d54:0:b0:376:24f6:d0f4 with SMTP id
 e20-20020a026d54000000b0037624f6d0f4mr3496277jaf.206.1669132358411; Tue, 22
 Nov 2022 07:52:38 -0800 (PST)
Date:   Tue, 22 Nov 2022 07:52:38 -0800
In-Reply-To: <000000000000824da605e9521001@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e6dba05ee112956@google.com>
Subject: Re: [syzbot] kernel BUG in gfs2_glock_nq (2)
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    eb7081409f94 Linux 6.1-rc6
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d40efd880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cdf448d3b35234
dashboard link: https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156d55fd880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14946075880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a019f55c517/disk-eb708140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb36e890aa8b/vmlinux-eb708140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/feee2c23ec64/bzImage-eb708140.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/595931ddaae3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+70f4e455dee59ab40c80@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: new: gfs2_quota_sync+0x3da/0x8b0 fs/gfs2/quota.c:1318
gfs2: fsid=syz:syz.0: pid: 3642
gfs2: fsid=syz:syz.0: lock type: 8 req lock state : 1
gfs2: fsid=syz:syz.0: G:  s:EX n:8/1 f:qb t:EX d:EX/0 a:0 v:0 r:5 m:20 p:0
gfs2: fsid=syz:syz.0:  H: s:EX f:cH e:0 p:3642 [syz-executor297] gfs2_quota_sync+0x3da/0x8b0 fs/gfs2/quota.c:1318
------------[ cut here ]------------
kernel BUG at fs/gfs2/glock.c:1560!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3642 Comm: syz-executor297 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:add_to_queue fs/gfs2/glock.c:1560 [inline]
RIP: 0010:gfs2_glock_nq+0x1661/0x1890 fs/gfs2/glock.c:1585
Code: 0f b7 4d 00 48 c7 c7 00 42 3e 8b 48 8b 74 24 20 89 da 31 c0 e8 9c bf da 06 31 ff 48 8b 74 24 28 ba 01 00 00 00 e8 6f 7b ff ff <0f> 0b 89 d9 80 e1 07 fe c1 38 c1 0f 8c 94 ee ff ff 48 89 df e8 06
RSP: 0018:ffffc90003baf898 EFLAGS: 00010246
RAX: 366be81aeeac0c00 RBX: 0000000000000008 RCX: ffff88807253d7c0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888027cb365a R08: ffffffff83b90f42 R09: fffffbfff1d2f2de
R10: fffffbfff1d2f2de R11: 1ffffffff1d2f2dd R12: ffff888027cb3638
R13: ffff888073045340 R14: ffff888027cb3630 R15: 1ffff11004f966c3
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562ec3072000 CR3: 00000000714f0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_glock_nq_init fs/gfs2/glock.h:264 [inline]
 do_sync+0x3b1/0xc80 fs/gfs2/quota.c:910
 gfs2_quota_sync+0x3da/0x8b0 fs/gfs2/quota.c:1318
 gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:643
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x310 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1428
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1186
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x664/0x2070 kernel/exit.c:820
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9613abc989
Code: Unable to access opcode bytes at 0x7f9613abc95f.
RSP: 002b:00007ffe22a048c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f9613b6d330 RCX: 00007f9613abc989
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 000000000003b2d3
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9613b6d330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:add_to_queue fs/gfs2/glock.c:1560 [inline]
RIP: 0010:gfs2_glock_nq+0x1661/0x1890 fs/gfs2/glock.c:1585
Code: 0f b7 4d 00 48 c7 c7 00 42 3e 8b 48 8b 74 24 20 89 da 31 c0 e8 9c bf da 06 31 ff 48 8b 74 24 28 ba 01 00 00 00 e8 6f 7b ff ff <0f> 0b 89 d9 80 e1 07 fe c1 38 c1 0f 8c 94 ee ff ff 48 89 df e8 06
RSP: 0018:ffffc90003baf898 EFLAGS: 00010246
RAX: 366be81aeeac0c00 RBX: 0000000000000008 RCX: ffff88807253d7c0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888027cb365a R08: ffffffff83b90f42 R09: fffffbfff1d2f2de
R10: fffffbfff1d2f2de R11: 1ffffffff1d2f2dd R12: ffff888027cb3638
R13: ffff888073045340 R14: ffff888027cb3630 R15: 1ffff11004f966c3
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562ec3072000 CR3: 00000000714f0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

