Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1150639531
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKZKI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 05:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKZKIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:08:53 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F96D2034F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 02:08:50 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id h10-20020a056e021b8a00b00302671bb5fdso4532962ili.21
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 02:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o/eBzmieVWbMy0ps2SBKBE/wiQFXeAbv0ogJHVN8cyQ=;
        b=4rE4ccdcLW7QCyvJKSNgiitbNeqNLoUJlw/A7G4cczc7Dq/FproKUrciQsilu4NN3H
         h067Prqp4XsbRiKfrKGroE7vDt1PFULXX1hquScpkhZovqt1BSoqCJqB4dCSb4i3yzVv
         ifg+H1SLccEhvluOEJOtkws9aRPRhk9oVd8eZel+c3RoJd7uTgp0nIG427iX0HiRmxQV
         V/VLsCrItyoKk4SvuM8zmFpFNIJo2+aK9d9W12Fqtztcpfgx36bEOtwRj+1vUD61hI0x
         LzPo/wRqGmmML1xaAjlsihL0NSzRW0U0LDGnaLCSszsOw5rOr1AtOo0ODVZu0uwV6vd/
         a+uA==
X-Gm-Message-State: ANoB5pmdNvyFx01zOQPtml0DJPoq8WCyM3CK9bJ8jNIU8L24FQYATRtp
        opS/x+hShBl0yctmj7aG5LGrekzFQfe3X31J1aYzDSSXW9C6
X-Google-Smtp-Source: AA0mqf68oXFFn7ydUN1if+AWx2jnKBjB/nv0AmL+yaAbA+YrPXL0QtP+S00CEPRG6oqK5vJ0onqgE+mO7GwNfaxZwQ/RWoLpN2Jh
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13d2:b0:300:e325:5677 with SMTP id
 v18-20020a056e0213d200b00300e3255677mr18206208ilj.119.1669457329775; Sat, 26
 Nov 2022 02:08:49 -0800 (PST)
Date:   Sat, 26 Nov 2022 02:08:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bebd305ee5cd30e@google.com>
Subject: [syzbot] WARNING in xfs_bmapi_convert_delalloc
From:   syzbot <syzbot+53b443b5c64221ee8bad@syzkaller.appspotmail.com>
To:     chandan.babu@oracle.com, dchinner@redhat.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
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

HEAD commit:    a77d28d13789 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15cd6d45880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4c990190d758078
dashboard link: https://syzkaller.appspot.com/bug?extid=53b443b5c64221ee8bad
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c4b04ddbeb3/disk-a77d28d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ecedb0cf6ca/vmlinux-a77d28d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/44c59c4393c7/Image-a77d28d1.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+53b443b5c64221ee8bad@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3540 at fs/xfs/libxfs/xfs_bmap.c:4592 xfs_bmapi_convert_delalloc+0x67c/0x6b8 fs/xfs/libxfs/xfs_bmap.c:4592
Modules linked in:
CPU: 0 PID: 3540 Comm: kworker/u4:11 Not tainted 6.1.0-rc6-syzkaller-32651-ga77d28d13789 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Workqueue: writeback wb_workfn (flush-7:1)
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : xfs_bmapi_convert_delalloc+0x67c/0x6b8 fs/xfs/libxfs/xfs_bmap.c:4592
lr : xfs_bmapi_convert_delalloc+0x67c/0x6b8 fs/xfs/libxfs/xfs_bmap.c:4592
sp : ffff800015c334a0
x29: ffff800015c33580 x28: 0000000000000000 x27: 0000000000000000
x26: ffff800015c334f0 x25: ffffffffffffffff x24: ffff000119443000
x23: ffff0001198af440 x22: ffff800015c338f8 x21: ffff00011aa80000
x20: 0000000000000000 x19: ffff0001198af400 x18: 00000000000000ea
x17: ffff80000c0ed83c x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000003 x12: ffff80000d601058
x11: ff80800008dd70f8 x10: 0000000000000000 x9 : ffff800008dd70f8
x8 : ffff0000f0c63480 x7 : ffff800008daa4cc x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff800008db0090
x2 : 0000000000000009 x1 : ffffffffffffffff x0 : ffffffffffffffff
Call trace:
 xfs_bmapi_convert_delalloc+0x67c/0x6b8 fs/xfs/libxfs/xfs_bmap.c:4592
 xfs_convert_blocks fs/xfs/xfs_aops.c:259 [inline]
 xfs_map_blocks+0x4a8/0x6d8 fs/xfs/xfs_aops.c:380
 iomap_writepage_map+0x190/0x8cc fs/iomap/buffered-io.c:1360
 iomap_do_writepage+0x1c0/0x560 fs/iomap/buffered-io.c:1523
 write_cache_pages+0x35c/0x8bc mm/page-writeback.c:2360
 iomap_writepages+0x44/0xec fs/iomap/buffered-io.c:1540
 xfs_vm_writepages+0x94/0xd4 fs/xfs/xfs_aops.c:500
 do_writepages+0x144/0x27c mm/page-writeback.c:2469
 __writeback_single_inode+0x64/0x2e4 fs/fs-writeback.c:1587
 writeback_sb_inodes+0x3e4/0x85c fs/fs-writeback.c:1870
 wb_writeback+0x198/0x328 fs/fs-writeback.c:2044
 wb_do_writeback+0xc8/0x384 fs/fs-writeback.c:2187
 wb_workfn+0x70/0x15c fs/fs-writeback.c:2227
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
irq event stamp: 21709788
hardirqs last  enabled at (21709787): [<ffff80000992ed1c>] get_random_u32+0x20c/0x294 drivers/char/random.c:510
hardirqs last disabled at (21709788): [<ffff80000c0a4074>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (21709658): [<ffff8000080102e4>] _stext+0x2e4/0x37c
softirqs last disabled at (21709557): [<ffff800008017c88>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
XFS (loop1): page discard on page fffffc00047d3f00, inode 0x62c, pos 13258752.
XFS (loop1): page discard on page fffffc00047d3f40, inode 0x62c, pos 13262848.
XFS (loop1): page discard on page fffffc00047d3f80, inode 0x62c, pos 13266944.
XFS (loop1): page discard on page fffffc00047d3fc0, inode 0x62c, pos 13271040.
XFS (loop1): page discard on page fffffc0004742800, inode 0x62c, pos 13275136.
XFS (loop1): page discard on page fffffc0004742840, inode 0x62c, pos 13279232.
XFS (loop1): page discard on page fffffc0004742880, inode 0x62c, pos 13283328.
XFS (loop1): page discard on page fffffc00047428c0, inode 0x62c, pos 13287424.
XFS (loop1): page discard on page fffffc0004742900, inode 0x62c, pos 13291520.
XFS (loop1): page discard on page fffffc0004742940, inode 0x62c, pos 13295616.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
