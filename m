Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267955F9A05
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiJJHds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiJJHdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:33:18 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820BB6E2FD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:26:55 -0700 (PDT)
Received: by mail-pj1-f71.google.com with SMTP id y16-20020a17090aa41000b001fdf0a76a4eso4700406pjp.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egyq16isLZXDFcZNncivMYbIxfpIBcMFKVsC/gitSFc=;
        b=EOokfZc8Hi5Q37Ci9y1fT0wrxZLZEQ9NNVMAWDMHzLaU5qBV1+D6MEsFH+V6Dv+kyA
         HNvuv9I1HJONRiNS21YYZLufrIxx0llcmloWTZNcxTsznXM50LoZv7qubi/SBol0JVv0
         kNQikZgs05pcDTnxtVcMD12KdQPcgMMOqKEUANGkClO+g1EiEXSb5HqPJJ8OxGJh+9Oh
         eLfOQ0JZM9CPgVCAwDtvaDhgCItSZJ2jvbvSra8k2ol1YyAOiXuTn2s3PmOt4ivXU++M
         AtX6Jx132Udu7HgGBCFab5hbMU4QlqXj9OPgoZ7j7QAV2LnhEGu4nC7w/w4EftKHS67k
         T4Tg==
X-Gm-Message-State: ACrzQf0NHD+ed/FVCDOnJf0an4tF0fRt+0yLUD63UI1GJs08WPuWZDOX
        jtlNi3YVnecNhwIVa4ZHllff1GPTRtZtlH2aEgCC7EJpG1FK
X-Google-Smtp-Source: AMsMyM5iFDb56Nl7JMKFbmh1vtXYpDs5vZanMcXawPMoi/joYAUfgSc8pFei8oNZuKNaSGdiFkZdCLCL3V10VC0jtff5dCGYyqvy
MIME-Version: 1.0
X-Received: by 2002:a05:6602:346:b0:6bb:f236:ae68 with SMTP id
 w6-20020a056602034600b006bbf236ae68mr3724117iou.161.1665386203523; Mon, 10
 Oct 2022 00:16:43 -0700 (PDT)
Date:   Mon, 10 Oct 2022 00:16:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013300305eaa8f1bf@google.com>
Subject: [syzbot] WARNING in kernfs_active
From:   syzbot <syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4899a36f91a9 Merge tag 'powerpc-6.1-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15428b1c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=82d4dadec8e02fa1
dashboard link: https://syzkaller.appspot.com/bug?extid=590ce62b128e79cf0a35
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6191 at fs/kernfs/dir.c:36 kernfs_active+0xe8/0x120 fs/kernfs/dir.c:38
Modules linked in:
CPU: 1 PID: 6191 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-09413-g4899a36f91a9 #0
Hardware name: linux,dummy-virt (DT)
pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : kernfs_active+0xe8/0x120 fs/kernfs/dir.c:36
lr : lock_is_held include/linux/lockdep.h:283 [inline]
lr : kernfs_active+0x94/0x120 fs/kernfs/dir.c:36
sp : ffff8000182c7a00
x29: ffff8000182c7a00 x28: 0000000000000002 x27: 0000000000000001
x26: ffff00000ee1f6a8 x25: 1fffe00001dc3ed5 x24: 0000000000000000
x23: ffff80000ca1fba0 x22: ffff8000089efcb0 x21: 0000000000000001
x20: ffff0000091181d0 x19: ffff0000091181d0 x18: ffff00006a9e6b88
x17: 0000000000000000 x16: 0000000000000000 x15: ffff00006a9e6bc4
x14: 1ffff00003058f0e x13: 1fffe0000258c816 x12: ffff700003058f39
x11: 1ffff00003058f38 x10: ffff700003058f38 x9 : dfff800000000000
x8 : ffff80000e482f20 x7 : ffff0000091d8058 x6 : ffff80000e482c60
x5 : ffff000009402ee8 x4 : 1ffff00001bd1f46 x3 : 1fffe0000258c6d1
x2 : 0000000000000003 x1 : 00000000000000c0 x0 : 0000000000000000
Call trace:
 kernfs_active+0xe8/0x120 fs/kernfs/dir.c:38
 kernfs_find_and_get_node_by_id+0x6c/0x140 fs/kernfs/dir.c:708
 __kernfs_fh_to_dentry fs/kernfs/mount.c:102 [inline]
 kernfs_fh_to_dentry+0x88/0x1fc fs/kernfs/mount.c:128
 exportfs_decode_fh_raw+0x104/0x560 fs/exportfs/expfs.c:435
 exportfs_decode_fh+0x10/0x5c fs/exportfs/expfs.c:575
 do_handle_to_path fs/fhandle.c:152 [inline]
 handle_to_path fs/fhandle.c:207 [inline]
 do_handle_open+0x2a4/0x7b0 fs/fhandle.c:223
 __do_compat_sys_open_by_handle_at fs/fhandle.c:277 [inline]
 __se_compat_sys_open_by_handle_at fs/fhandle.c:274 [inline]
 __arm64_compat_sys_open_by_handle_at+0x6c/0x9c fs/fhandle.c:274
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
 do_el0_svc_compat+0x40/0x70 arch/arm64/kernel/syscall.c:212
 el0_svc_compat+0x54/0x140 arch/arm64/kernel/entry-common.c:772
 el0t_32_sync_handler+0x90/0x140 arch/arm64/kernel/entry-common.c:782
 el0t_32_sync+0x190/0x194 arch/arm64/kernel/entry.S:586
irq event stamp: 232
hardirqs last  enabled at (231): [<ffff8000081edf70>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (231): [<ffff8000081edf70>] finish_lock_switch kernel/sched/core.c:4943 [inline]
hardirqs last  enabled at (231): [<ffff8000081edf70>] finish_task_switch.isra.0+0x200/0x880 kernel/sched/core.c:5061
hardirqs last disabled at (232): [<ffff80000c888bb4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:404
softirqs last  enabled at (228): [<ffff800008010938>] _stext+0x938/0xf58
softirqs last disabled at (207): [<ffff800008019380>] ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
