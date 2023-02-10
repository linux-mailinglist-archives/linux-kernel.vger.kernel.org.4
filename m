Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B9C69194F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjBJHm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjBJHmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:42:50 -0500
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E575360AA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 23:42:49 -0800 (PST)
Received: by mail-il1-f205.google.com with SMTP id o4-20020a92d384000000b00314025337e7so3622466ilo.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 23:42:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ynKzp7M2iniu/ZO3+psH340wl9RCB3nYdijLmARScgw=;
        b=RDFRUiAVZUBy48s1uJak39I2699ShGQ8aiigVonGWcdzzyf7BNB31y4WhzDoSkY9p/
         c0bt2ZiTY5Z3ZCq0Xgj3QqVRXCF9ZF8uio/U5djPLxn6wtLgq/11AwqAcx+D/kTD5BFD
         BHl1NtqLZA+GLNj99w8IhooX2wNA8tbbZAlj0/IiXP8S9TD9v0yLJggdYmeTElrV86ws
         Z4J1SlJX0hV3LHwmer1am9MRnUQJSV8z/8rPDSsaBGpLANfLfXIbrsxyGUgy0neXSwIY
         nT69jucOKvsLLR2Kn5rSGmM5xgSXYpu2KXZSuoIheS5qo3I2jDWGZjBzAHq1c5y1cfct
         03rQ==
X-Gm-Message-State: AO0yUKUC0WHQb707ICm4coYFQlPnDMNM9jpYFS/YgzCOosi7SJesG+eV
        AXYwlz8wYECNX7QSeUgzyHYmxt8AoDAcTpTJ2SjK406uc5Ve
X-Google-Smtp-Source: AK7set9YTzz38QnjyCksWeRrCUcyEjpXFF3YcJyzeRY9gbU+Sq4JgBqzPEiR8NYhkniEQIS+BceEu9kBz5jpsIOqxZzLeZw/BvbM
MIME-Version: 1.0
X-Received: by 2002:a5d:8f8e:0:b0:71a:5a1f:544c with SMTP id
 l14-20020a5d8f8e000000b0071a5a1f544cmr8338986iol.5.1676014968689; Thu, 09 Feb
 2023 23:42:48 -0800 (PST)
Date:   Thu, 09 Feb 2023 23:42:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8d95805f453a4f3@google.com>
Subject: [syzbot] [xfs?] KMSAN: uninit-value in xfs_getfsmap_helper
From:   syzbot <syzbot+090ae72d552e6bd93cfe@syzkaller.appspotmail.com>
To:     djwong@kernel.org, glider@google.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    eda666ff2276 kmsan: silence -Wmissing-prototypes warnings
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10edfcbd480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f27365aeb365b358
dashboard link: https://syzkaller.appspot.com/bug?extid=090ae72d552e6bd93cfe
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc16035efde4/disk-eda666ff.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/084efc06a321/vmlinux-eda666ff.xz
kernel image: https://storage.googleapis.com/syzbot-assets/35c07fcfcbf2/bzImage-eda666ff.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+090ae72d552e6bd93cfe@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 32768
XFS (loop4): Mounting V5 Filesystem c496e05e-540d-4c72-b591-04d79d8b4eeb
XFS (loop4): Ending clean mount
=====================================================
BUG: KMSAN: uninit-value in xfs_getfsmap_helper+0xbd5/0x1b20 fs/xfs/xfs_fsmap.c:341
 xfs_getfsmap_helper+0xbd5/0x1b20 fs/xfs/xfs_fsmap.c:341
 xfs_getfsmap_datadev_bnobt_helper+0x225/0x2d0 fs/xfs/xfs_fsmap.c:385
 xfs_getfsmap_datadev_bnobt_query+0xad/0x2e0 fs/xfs/xfs_fsmap.c:744
 __xfs_getfsmap_datadev+0x13e8/0x1f70 fs/xfs/xfs_fsmap.c:676
 xfs_getfsmap_datadev_bnobt+0x8a/0xd0 fs/xfs/xfs_fsmap.c:765
 xfs_getfsmap+0x1690/0x18d0 fs/xfs/xfs_fsmap.c:962
 xfs_ioc_getfsmap+0x5e6/0x1080 fs/xfs/xfs_ioctl.c:1558
 xfs_file_ioctl+0x1c5/0x27a0 fs/xfs/xfs_ioctl.c:1952
 xfs_file_compat_ioctl+0x334/0xbb0
 __do_compat_sys_ioctl fs/ioctl.c:968 [inline]
 __se_compat_sys_ioctl+0x781/0xfa0 fs/ioctl.c:910
 __ia32_compat_sys_ioctl+0x8f/0xd0 fs/ioctl.c:910
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was stored to memory at:
 xfs_getfsmap_datadev_bnobt_helper+0x29b/0x2d0 fs/xfs/xfs_fsmap.c:380
 xfs_getfsmap_datadev_bnobt_query+0xad/0x2e0 fs/xfs/xfs_fsmap.c:744
 __xfs_getfsmap_datadev+0x13e8/0x1f70 fs/xfs/xfs_fsmap.c:676
 xfs_getfsmap_datadev_bnobt+0x8a/0xd0 fs/xfs/xfs_fsmap.c:765
 xfs_getfsmap+0x1690/0x18d0 fs/xfs/xfs_fsmap.c:962
 xfs_ioc_getfsmap+0x5e6/0x1080 fs/xfs/xfs_ioctl.c:1558
 xfs_file_ioctl+0x1c5/0x27a0 fs/xfs/xfs_ioctl.c:1952
 xfs_file_compat_ioctl+0x334/0xbb0
 __do_compat_sys_ioctl fs/ioctl.c:968 [inline]
 __se_compat_sys_ioctl+0x781/0xfa0 fs/ioctl.c:910
 __ia32_compat_sys_ioctl+0x8f/0xd0 fs/ioctl.c:910
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Local variable akeys created at:
 xfs_getfsmap_datadev_bnobt+0x50/0xd0 fs/xfs/xfs_fsmap.c:762
 xfs_getfsmap+0x1690/0x18d0 fs/xfs/xfs_fsmap.c:962

CPU: 1 PID: 7205 Comm: syz-executor.4 Not tainted 6.2.0-rc6-syzkaller-80422-geda666ff2276 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
