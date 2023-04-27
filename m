Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF5B6F0D79
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjD0Uuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0Uux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:50:53 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E521DC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:50:50 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-766588051b3so137847939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628650; x=1685220650;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6D7HRIAwrsObnR9dyvXF3uP+7wKnGIKQal8KLKI9eXw=;
        b=H5mc/4POYmq1NBIHFeqwHvwUoB/PqxpyOiYQBF+9VuPdSOFQHmxRk0Nt1/aQC8r5xW
         ViyEljU/myc2gisZCgGFxIRUWFjrvNnzdR7r2dmkQ/NcR2LIXujSesmQlDOsVak4pKOj
         kP4qoJlO9i2BYSmsSxdRbkkr2GXDOHU+633A1zc3ThigwiAzHicoysFKKSfofphBwQx6
         1EDbpCHj81pda+beB0R/LQf/XTBxQiqDOV2ikyB8M589h0x8bNhxSWfc10eJGOvDhjCS
         dBBt2YDyGRYq9zMNpLf+8YmsJ93kj4PerL055Dh657o3hSQaYHd1/kySh1+JzNqHOgl4
         70zw==
X-Gm-Message-State: AC+VfDy2uqztIB1d5oitdAXv/viXjqbRsryg4prlirII8rb95viSbayU
        lFw8q1vt8gI3xtNheUNnJTJeOLDEfXSyUd8aKQv5vo2lP/ad
X-Google-Smtp-Source: ACHHUZ4O3E/9FC8Do7EX3PLXGXOn7rcfY2qg1X1VNPP7GAW/K2fREoO4osuhYIThQEftQ9zV9NQ1ymcLTmTPjd5dx+clfI33GVT0
MIME-Version: 1.0
X-Received: by 2002:a02:9505:0:b0:40f:b3a8:6e43 with SMTP id
 y5-20020a029505000000b0040fb3a86e43mr1431971jah.6.1682628649835; Thu, 27 Apr
 2023 13:50:49 -0700 (PDT)
Date:   Thu, 27 Apr 2023 13:50:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f66a3005fa578223@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
From:   syzbot <syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    81af97bdef5e printk: Export console trace point for kcsan/..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=178eaf77c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60f9227cd7ef4e36
dashboard link: https://syzkaller.appspot.com/bug?extid=a6d6b8fffa294705dbd8
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/959cdbc34509/disk-81af97bd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21bf12585d87/vmlinux-81af97bd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d46348c365bd/bzImage-81af97bd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com

XFS: attr2 mount option is deprecated.
XFS (loop3): Mounting V5 Filesystem a2f82aab-77f8-4286-afd4-a8f747a74bab
XFS (loop3): Ending clean mount
XFS (loop3): Quotacheck needed: Please wait.
=====================================================
BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:112 [inline]
BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
BUG: KMSAN: uninit-value in __crc32c_le_base+0x467/0xd80 lib/crc32.c:201
 crc32_body lib/crc32.c:112 [inline]
 crc32_le_generic lib/crc32.c:179 [inline]
 __crc32c_le_base+0x467/0xd80 lib/crc32.c:201
 chksum_update+0x5b/0xd0 crypto/crc32c_generic.c:88
 crypto_shash_update+0x28f/0x400 crypto/shash.c:121
 crc32c+0xd9/0x1a0 lib/libcrc32c.c:47
 xlog_cksum fs/xfs/xfs_log.c:1867 [inline]
 xlog_sync+0xf66/0x11e0 fs/xfs/xfs_log.c:2111
 xlog_state_release_iclog+0x3d0/0x7e0 fs/xfs/xfs_log.c:619
 xlog_force_iclog fs/xfs/xfs_log.c:888 [inline]
 xlog_force_and_check_iclog fs/xfs/xfs_log.c:3172 [inline]
 xfs_log_force+0x9d3/0xf20 fs/xfs/xfs_log.c:3249
 xfs_qm_dqflush+0x11d9/0x17f0 fs/xfs/xfs_dquot.c:1293
 xfs_qm_flush_one+0x148/0x5b0 fs/xfs/xfs_qm.c:1260
 xfs_qm_dquot_walk+0x2be/0x7b0 fs/xfs/xfs_qm.c:87
 xfs_qm_quotacheck+0x4e1/0xb20 fs/xfs/xfs_qm.c:1338
 xfs_qm_mount_quotas+0x3ef/0x890 fs/xfs/xfs_qm.c:1457
 xfs_mountfs+0x2184/0x2410 fs/xfs/xfs_mount.c:959
 xfs_fs_fill_super+0x1fb3/0x22b0 fs/xfs/xfs_super.c:1677
 get_tree_bdev+0x890/0xd10 fs/super.c:1303
 xfs_fs_get_tree+0x34/0x40 fs/xfs/xfs_super.c:1724
 vfs_get_tree+0xa5/0x500 fs/super.c:1510
 do_new_mount+0x69a/0x1580 fs/namespace.c:3042
 path_mount+0x725/0x1ee0 fs/namespace.c:3372
 do_mount fs/namespace.c:3385 [inline]
 __do_sys_mount fs/namespace.c:3594 [inline]
 __se_sys_mount+0x734/0x840 fs/namespace.c:3571
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3571
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was stored to memory at:
 xlog_write_iovec fs/xfs/xfs_log.c:2259 [inline]
 xlog_write_full fs/xfs/xfs_log.c:2294 [inline]
 xlog_write+0x1c3c/0x21a0 fs/xfs/xfs_log.c:2563
 xlog_cil_write_chain fs/xfs/xfs_log_cil.c:973 [inline]
 xlog_cil_push_work+0x30c7/0x4430 fs/xfs/xfs_log_cil.c:1318
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2390
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2537
 kthread+0x31f/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Uninit was created at:
 slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:774
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x518/0x920 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 xlog_kvmalloc fs/xfs/xfs_log_priv.h:700 [inline]
 xlog_cil_alloc_shadow_bufs fs/xfs/xfs_log_cil.c:338 [inline]
 xlog_cil_commit+0x493/0x4c80 fs/xfs/xfs_log_cil.c:1629
 __xfs_trans_commit+0x78e/0x13d0 fs/xfs/xfs_trans.c:1005
 xfs_trans_roll+0x10a/0x6e0 fs/xfs/xfs_trans.c:1153
 xfs_defer_trans_roll+0x10f/0x590 fs/xfs/libxfs/xfs_defer.c:366
 xfs_defer_finish_noroll+0x49d/0x2d40 fs/xfs/libxfs/xfs_defer.c:551
 __xfs_trans_commit+0x979/0x13d0 fs/xfs/xfs_trans.c:970
 xfs_trans_commit+0x2f/0x40 fs/xfs/xfs_trans.c:1049
 xfs_dquot_disk_alloc+0xd4f/0x11a0 fs/xfs/xfs_dquot.c:384
 xfs_qm_dqread+0x149/0x950 fs/xfs/xfs_dquot.c:665
 xfs_qm_dqget+0x32c/0xb40 fs/xfs/xfs_dquot.c:870
 xfs_qm_quotacheck_dqadjust+0xc4/0x860 fs/xfs/xfs_qm.c:1085
 xfs_qm_dqusage_adjust+0x51b/0x910 fs/xfs/xfs_qm.c:1190
 xfs_iwalk_ag_recs+0x5ca/0xa50 fs/xfs/xfs_iwalk.c:220
 xfs_iwalk_run_callbacks+0x27f/0x590 fs/xfs/xfs_iwalk.c:376
 xfs_iwalk_ag+0xee3/0x1080 fs/xfs/xfs_iwalk.c:482
 xfs_iwalk_ag_work+0x207/0x300 fs/xfs/xfs_iwalk.c:624
 xfs_pwork_work+0x97/0x2b0 fs/xfs/xfs_pwork.c:47
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2390
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2537
 kthread+0x31f/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

CPU: 1 PID: 5349 Comm: syz-executor.3 Not tainted 6.3.0-syzkaller-g81af97bdef5e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
=====================================================


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
