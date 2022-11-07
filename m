Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B564F61EE53
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiKGJKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiKGJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:10:45 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5F56461
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:10:44 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id u7-20020a056e021a4700b00300b1379a2fso8267311ilv.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlVBuPXj60Q1X2Uftzi7nOgFj7t+1wvfRBpV6fcx/Mo=;
        b=sZYbEqhOikMdkMIuT4yvWwoDQlItHHWhJWA173dO9r9w6FbxhaaBgd6eUD3jcCouLU
         JKNuy2x15ceQBHDE7b7nHlX2zz7wpMOdwJ5DeDdenc1fUUYn0HnXDMAhu9rav9nRha4A
         y0CNrE6POKVoR73+UvitzfJ9tfXmyP4xXcLYBLCoLbVIY0PP0yPpF/R37K2Cc7KG5HN/
         X/aRq+JgiH8dqJkp0VSXc3eKvdUzZk1xtzo9z6r4QEZPB5W5jjkO484XhQr5wzTyYz3U
         xscYIOgD2Tu6JHhBpGuWT3dSruQrCLAEOz1RSFnKTFFZJHjKvtHgyP/wzNIEl9z9O9x/
         hWkg==
X-Gm-Message-State: ACrzQf3onLAhJr64T41bRWNo7QV9gNk3AWS4OtOhvLwaiXiUj0wrmcNv
        eSMTBWOd2tN2ZWpgcDbpdlDVur0McmWlntLiy5Tx99R4rjS5
X-Google-Smtp-Source: AMsMyM7R0clutN9KKUf7fMNTLDyS4wswTq7TL6Yezf5C5jeRoHCv2RDnXesEDUpB7EqI6ZBs/6zBkbJuSvUNoV5oOi2qta5bpxX8
MIME-Version: 1.0
X-Received: by 2002:a92:6b0e:0:b0:2ff:df3e:995b with SMTP id
 g14-20020a926b0e000000b002ffdf3e995bmr27549733ilc.193.1667812243851; Mon, 07
 Nov 2022 01:10:43 -0800 (PST)
Date:   Mon, 07 Nov 2022 01:10:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058d01705ecddccb0@google.com>
Subject: [syzbot] KMSAN: uninit-value in pagecache_write
From:   syzbot <syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, glider@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    968c2729e576 x86: kmsan: fix comment in kmsan_shadow.c
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=11d01ad6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=131312b26465c190
dashboard link: https://syzkaller.appspot.com/bug?extid=9767be679ef5016b6082
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c78ce21b953f/disk-968c2729.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/22868d826804/vmlinux-968c2729.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9767be679ef5016b6082@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in pagecache_write+0x655/0x720 fs/ext4/verity.c:91
 pagecache_write+0x655/0x720 fs/ext4/verity.c:91
 ext4_write_merkle_tree_block+0x84/0xa0 fs/ext4/verity.c:389
 build_merkle_tree_level+0x972/0x1250 fs/verity/enable.c:121
 build_merkle_tree fs/verity/enable.c:182 [inline]
 enable_verity+0xede/0x1920 fs/verity/enable.c:268
 fsverity_ioctl_enable+0x895/0xab0 fs/verity/enable.c:392
 __ext4_ioctl fs/ext4/ioctl.c:1572 [inline]
 ext4_ioctl+0x26dd/0x8c50 fs/ext4/ioctl.c:1606
 ext4_compat_ioctl+0x702/0x800 fs/ext4/ioctl.c:1682
 __do_compat_sys_ioctl fs/ioctl.c:968 [inline]
 __se_compat_sys_ioctl+0x781/0xfa0 fs/ioctl.c:910
 __ia32_compat_sys_ioctl+0x8f/0xd0 fs/ioctl.c:910
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Local variable fsdata created at:
 pagecache_write+0x21c/0x720 fs/ext4/verity.c:85
 ext4_write_merkle_tree_block+0x84/0xa0 fs/ext4/verity.c:389

CPU: 1 PID: 15121 Comm: syz-executor.3 Not tainted 6.0.0-rc5-syzkaller-48543-g968c2729e576 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
