Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C931562F2DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiKRKow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiKRKor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:44:47 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1E11A23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:44:46 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i26-20020a056e021d1a00b003025434c04eso3069040ila.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ot4kKwTDVUpBEN/3kPWp+z40LpuYnbr0KRtnnKBPj9s=;
        b=Xm4IeiBffbEQVteo6TO6Kr54v7b5YcDmxG/cn+39yt0QFpwH4oA1Gaizd1kCtR6nZG
         twg32O3YUlmywcQrCdPsMvBa+gi5tRB2+/v7Hghi1qapGiWgwQHm05x2Y3fFSxbcPlL9
         rT5g1mOZJtvNhOxamN669/WM+/dJAzUoEix8WABJwFNxvq9x3aHwjdV02fWGhzxzRflW
         E37uTGB3n9jmkDoaxzuzvJP+GIUd/Ko/3PNdsgt9qVoPDDnVN9qBQsw14D9b9hP75+lt
         FaakbtNmgAWk7FjGd+jYTnJmlim2Vc8WVmXi6azG/+UHEz9xaVDNV81zqXp/jcbFLjMe
         nIDw==
X-Gm-Message-State: ANoB5ply6NPmoMWMUd6YDrxiw/F8GurB4eBZGXFMBbrSK5/yvZYTfVxR
        Z+KKEq9jW59YczN3yfJ1rtbDNHa/LKcTSdIYHGiWNxKwDG0k
X-Google-Smtp-Source: AA0mqf6KxmCKBeQ3htPU6c4JhE+TEBxm4YuIIm5BI4dPsD63nR49fl4si9jJ0h5uIoE717cQR1ucbLSesL3vyxMyjpEdq5wc92lD
MIME-Version: 1.0
X-Received: by 2002:a92:6c12:0:b0:2eb:1f07:5a7e with SMTP id
 h18-20020a926c12000000b002eb1f075a7emr3069865ilc.0.1668768285643; Fri, 18 Nov
 2022 02:44:45 -0800 (PST)
Date:   Fri, 18 Nov 2022 02:44:45 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0d9a705edbc6497@google.com>
Subject: [syzbot] WARNING in bh_lru_install
From:   syzbot <syzbot+f275cebe321308c38cc1@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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

HEAD commit:    9500fc6e9e60 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=152c606e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b25c9f218686dd5e
dashboard link: https://syzkaller.appspot.com/bug?extid=f275cebe321308c38cc1
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1363e60652f7/disk-9500fc6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcc4da811bb6/vmlinux-9500fc6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b554298f1fa/Image-9500fc6e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f275cebe321308c38cc1@syzkaller.appspotmail.com

------------[ cut here ]------------
VFS: brelse: Trying to free free buffer
WARNING: CPU: 0 PID: 10338 at fs/buffer.c:1145 __brelse fs/buffer.c:1145 [inline]
WARNING: CPU: 0 PID: 10338 at fs/buffer.c:1145 brelse include/linux/buffer_head.h:326 [inline]
WARNING: CPU: 0 PID: 10338 at fs/buffer.c:1145 bh_lru_install+0x2cc/0x320 fs/buffer.c:1259
Modules linked in:
CPU: 0 PID: 10338 Comm: syz-executor.2 Not tainted 6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __brelse fs/buffer.c:1145 [inline]
pc : brelse include/linux/buffer_head.h:326 [inline]
pc : bh_lru_install+0x2cc/0x320 fs/buffer.c:1259
lr : __brelse fs/buffer.c:1145 [inline]
lr : brelse include/linux/buffer_head.h:326 [inline]
lr : bh_lru_install+0x2cc/0x320 fs/buffer.c:1259
sp : ffff800013ab3710
x29: ffff800013ab3710 x28: 0000000000000138 x27: 0000000000000002
x26: 0000000000000002 x25: 00000000000000fe x24: 0000000000000003
x23: ffff000119749d20 x22: 00000000000007f0 x21: 0000000000000008
x20: ffff0001197c2690 x19: 0000000000000000 x18: 00000000000003ef
x17: ffff80000c0ed83c x16: ffff80000dc18158 x15: ffff00012b181a40
x14: 0000000000000000 x13: 00000000ffffffff x12: 0000000000040000
x11: 000000000001385f x10: ffff800017409000 x9 : fa1ee85d90993c00
x8 : fa1ee85d90993c00 x7 : ffff800008165f54 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : 0000000100000000 x0 : 0000000000000027
Call trace:
 __brelse fs/buffer.c:1145 [inline]
 brelse include/linux/buffer_head.h:326 [inline]
 bh_lru_install+0x2cc/0x320 fs/buffer.c:1259
 __find_get_block fs/buffer.c:1309 [inline]
 __getblk_slow fs/buffer.c:1034 [inline]
 __getblk_gfp+0x1b4/0x21c fs/buffer.c:1333
 __bread_gfp+0x3c/0x90 fs/buffer.c:1367
 udf_read_tagged+0x7c/0x2e0 fs/udf/misc.c:219
 udf_load_sparable_map fs/udf/super.c:1359 [inline]
 udf_load_logicalvol+0x4ac/0xb70 fs/udf/super.c:1450
 udf_process_sequence+0x3b8/0x518 fs/udf/super.c:1766
 udf_load_sequence fs/udf/super.c:1813 [inline]
 udf_check_anchor_block+0xf8/0x1e8 fs/udf/super.c:1852
 udf_scan_anchors+0xb0/0x300 fs/udf/super.c:1885
 udf_find_anchor+0x4c/0x1d4 fs/udf/super.c:1941
 udf_load_vrs+0x88/0x240 fs/udf/super.c:2006
 udf_fill_super+0x29c/0x858 fs/udf/super.c:2184
 mount_bdev+0x1b8/0x210 fs/super.c:1401
 udf_mount+0x44/0x58 fs/udf/super.c:122
 legacy_get_tree+0x30/0x74 fs/fs_context.c:610
 vfs_get_tree+0x40/0x140 fs/super.c:1531
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x890 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 1278
hardirqs last  enabled at (1277): [<ffff800008165fe4>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1366 [inline]
hardirqs last  enabled at (1277): [<ffff800008165fe4>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4950
hardirqs last disabled at (1278): [<ffff80000c0a4f34>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (1254): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (1249): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
