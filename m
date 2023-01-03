Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38BD65BE83
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjACK7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbjACK6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:58:40 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D2CA47C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:58:38 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id h24-20020a056e021d9800b0030be8a5dd68so17806768ila.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 02:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6j1u/uhaamjB44e0V7q46pvvkGWmXy7wnn05i7TPfE4=;
        b=PaMPVvbV1ffvPOk80HgS7yEw+YxIpqB3GbgFoUlzVWb2NZuWfIek/U/e3CaBX6rlP7
         0PdK4t7smdRdXOVjBbWFLd3xecAWHZzx46D3AZ7Qaev+HlJzJY1Ow1ya9zQZawBZ2CLu
         MBvk10U0XPd4bsP1EFRKfEwkUKgQl5qpNFV4CtN/vkDRQi2yllY70z7USSoBGF8CtwL1
         TgnMHmtNcqSgZPHyxdINZxunWU6dlq/q46L9CWg6Ppu8Wcyes0MIDzxGwzDA+W9+gEXM
         jQoEe8IsmaDcam7E5ZBO+Sp+0ZAsBaeIdtdoDfQg9p16V45l0M/dkeIY9Q9CKfMNzljs
         AxMw==
X-Gm-Message-State: AFqh2kpVhHG0/Y50vzhGOSrcdXFFDNLr5L7IPufWsWO+MaxgjYqD6F8U
        BM3XELGUOrxFH8Eu1prS0lc4EUAsZ70/mynUmFruA+RKFKdQ
X-Google-Smtp-Source: AMrXdXtIrhIfXTl+QqlQgrVZzzeVZ2YJb3S6uX7a1D7gPukqHjpmc1VtYWJpd0Ad4+YFbjwVNBWRG1h84LL3itlTiuil6YhlyQWH
MIME-Version: 1.0
X-Received: by 2002:a5d:8144:0:b0:6e4:b7b8:c5db with SMTP id
 f4-20020a5d8144000000b006e4b7b8c5dbmr3398826ioo.189.1672743518220; Tue, 03
 Jan 2023 02:58:38 -0800 (PST)
Date:   Tue, 03 Jan 2023 02:58:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034388605f159f31e@google.com>
Subject: [syzbot] [ext4?] KMSAN: uninit-value in htree_dirblock_to_tree
From:   syzbot <syzbot+394aa8a792cb99dbc837@syzkaller.appspotmail.com>
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

HEAD commit:    5c6259d6d19f kmsan: fix memcpy tests
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1343a1e4480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2f77da22508204e
dashboard link: https://syzkaller.appspot.com/bug?extid=394aa8a792cb99dbc837
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76b6594632b8/disk-5c6259d6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/81a2113c440e/vmlinux-5c6259d6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd12d098edab/bzImage-5c6259d6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+394aa8a792cb99dbc837@syzkaller.appspotmail.com

[EXT4 FS bs=2048, gc=1, bpg=16384, ipg=32, mo=e000e01c, mo2=0002]
System zones: 0-11
EXT4-fs (loop4): mounted filesystem without journal. Quota mode: none.
=====================================================
BUG: KMSAN: uninit-value in htree_dirblock_to_tree+0x101b/0x1710 fs/ext4/namei.c:1116
 htree_dirblock_to_tree+0x101b/0x1710 fs/ext4/namei.c:1116
 ext4_htree_fill_tree+0x1ac9/0x1cc0 fs/ext4/namei.c:1204
 ext4_dx_readdir fs/ext4/dir.c:597 [inline]
 ext4_readdir+0x53cd/0x6450 fs/ext4/dir.c:142
 iterate_dir+0x3e5/0x9b0
 __do_compat_sys_getdents fs/readdir.c:537 [inline]
 __se_compat_sys_getdents+0x182/0x560 fs/readdir.c:522
 __ia32_compat_sys_getdents+0x8f/0xd0 fs/readdir.c:522
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Local variable hinfo created at:
 ext4_htree_fill_tree+0x5f/0x1cc0 fs/ext4/namei.c:1170
 ext4_dx_readdir fs/ext4/dir.c:597 [inline]
 ext4_readdir+0x53cd/0x6450 fs/ext4/dir.c:142

CPU: 0 PID: 6235 Comm: syz-executor.4 Not tainted 6.1.0-syzkaller-64311-g5c6259d6d19f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
