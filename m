Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BD66FE66F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 23:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEJVtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 17:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 17:49:17 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79AB46A5
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:49:15 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32b5ec09cffso51727145ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 14:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683755355; x=1686347355;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1SGREDmcRfCOLqe/Yt3nb430iTEdmGYJDyvnyaeePE=;
        b=ULl7ALvUd8YPS5Ql0ijNPR46XYF02pFBYweXx2pqpAXBRQE+SyNxfqmDQa1hwfAoo8
         IGmlV62pLGxA7+5AZGIXhMRRHIBzvlOZgkJzVoKmIYQEwCL0idwtg0p95yIm0CkYnRL0
         D17D0iSqn/AL/FCVFagI1FA3xcQyRIxleP6dhUfM6fvraXChAuWAWJwbPEWPTijbzq3X
         qAQPz5KY29WntmjU4cMdtmFEof6moE4q1AuGb/NBdclppoeXOb02REcLLhrdvBwx+tDY
         yu46CXS/Px6/C54sfweb3RtQ9Z/XgcodtWeqs0F6rk9RZ9oUyom6/h9jSd0Vq2ycWJmi
         eglw==
X-Gm-Message-State: AC+VfDzJsdA1CxAe2/qAok7kKBGXtzTxQUvBUK6nuMy4tQ6dGWNnclm8
        AAYcfYN64VlBoAFIdaVdrTj2wmagH27/qOHSmoC/NA+CjytX
X-Google-Smtp-Source: ACHHUZ5RxOuGNZBLxewywHGqqnTg/z2+mfExTWYHm1eP9owdJyXGIgOFdY8rvNLrw1U9JIdALuIDsMRcQfGEAZwYOuijgs60pn5B
MIME-Version: 1.0
X-Received: by 2002:a92:90c:0:b0:331:3168:9c33 with SMTP id
 y12-20020a92090c000000b0033131689c33mr10139371ilg.0.1683755355037; Wed, 10
 May 2023 14:49:15 -0700 (PDT)
Date:   Wed, 10 May 2023 14:49:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d368dd05fb5dd7d3@google.com>
Subject: [syzbot] [reiserfs?] KMSAN: uninit-value in reiserfs_security_init
From:   syzbot <syzbot+00a3779539a23cbee38c@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    46e8b6e7cfeb string: use __builtin_memcpy() in strlcpy/str..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13ea03bc280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a7a1059074b7bdce
dashboard link: https://syzkaller.appspot.com/bug?extid=00a3779539a23cbee38c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad7fff770529/disk-46e8b6e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca6a66fcd14c/vmlinux-46e8b6e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9dc8f5fe8588/bzImage-46e8b6e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00a3779539a23cbee38c@syzkaller.appspotmail.com

REISERFS (device loop5): journal params: device loop5, size 512, journal first block 18, max trans len 256, max batch 225, max commit age 30, max trans age 30
REISERFS (device loop5): checking transaction log (loop5)
REISERFS (device loop5): Using r5 hash to sort names
reiserfs: enabling write barrier flush mode
=====================================================
BUG: KMSAN: uninit-value in reiserfs_security_init+0x663/0x750 fs/reiserfs/xattr_security.c:84
 reiserfs_security_init+0x663/0x750 fs/reiserfs/xattr_security.c:84
 reiserfs_mkdir+0x418/0xfc0 fs/reiserfs/namei.c:823
 xattr_mkdir fs/reiserfs/xattr.c:77 [inline]
 create_privroot fs/reiserfs/xattr.c:890 [inline]
 reiserfs_xattr_init+0x47e/0xc00 fs/reiserfs/xattr.c:1006
 reiserfs_remount+0xf9c/0x2390
 legacy_reconfigure+0x182/0x1d0 fs/fs_context.c:633
 reconfigure_super+0x346/0xdf0 fs/super.c:956
 do_remount fs/namespace.c:2701 [inline]
 path_mount+0x19c1/0x1ee0 fs/namespace.c:3361
 do_mount fs/namespace.c:3382 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3568
 __ia32_sys_mount+0xe3/0x150 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Local variable security created at:
 reiserfs_mkdir+0x5f/0xfc0 fs/reiserfs/namei.c:791
 xattr_mkdir fs/reiserfs/xattr.c:77 [inline]
 create_privroot fs/reiserfs/xattr.c:890 [inline]
 reiserfs_xattr_init+0x47e/0xc00 fs/reiserfs/xattr.c:1006

CPU: 1 PID: 7610 Comm: syz-executor.5 Not tainted 6.4.0-rc1-syzkaller-g46e8b6e7cfeb #0
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
