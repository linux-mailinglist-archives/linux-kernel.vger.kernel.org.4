Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6796ACBD6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjCFSCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjCFSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:02:37 -0500
Received: from mail-io1-xd45.google.com (mail-io1-xd45.google.com [IPv6:2607:f8b0:4864:20::d45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A776E686
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 10:02:10 -0800 (PST)
Received: by mail-io1-xd45.google.com with SMTP id d25-20020a0566022bf900b00745469852cfso5651115ioy.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 10:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125404;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpXeWn+ld/QoRYa6dboRl0RpYBuFcgqvSJPJnISHoDQ=;
        b=B8dvPtrd2H+37V//sNcl3fQy2AAWZ1df00ikOgbPkIr6AYPYm7lmf1qxPtdYjjgARC
         1jg8meLfxa5GFw7YcQMV1j7D5KTTN/7ilnoxUQnoaNXluf6bRu2uNBxa939FJKIEHxcE
         caepcBWI4je4xG0w38G+ndS936yf4xtfxl6Nazp+zYodxOZvCWeeYxNhQyvv1+IMNxbE
         HCQy1/LhLshVbpBH1TP3L8jC2t71jbPml2IFS4dEgkxfh3O4fAVD/f+Fxwz9yKCMIjUE
         EDImi31RMy/L5ULMrHhNjLbIub/jw9/HNCVs53SjpAjeR5GDdW+IbvP3ZZEL7baHmu1m
         QPLA==
X-Gm-Message-State: AO0yUKVR8GkJ0Is5Canw1rWC1hm0tGJcSkpCgddkB7Fop6SfsRhtKkWY
        ttnv0KwPvNERFiVMyTwtS5hvslsYYHO454F4NyfVt90zciBY
X-Google-Smtp-Source: AK7set8vBerzS4513rHfr/KAGU/J5MHnpDKCUEBSnoM1kK8r1zMTjhA2CY+QPO1mQZiE3SCrv3zk82UWAIGMPkYIWwn8u9IL0dXJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13f3:b0:310:d348:e59b with SMTP id
 w19-20020a056e0213f300b00310d348e59bmr5881132ilj.4.1678125404672; Mon, 06 Mar
 2023 09:56:44 -0800 (PST)
Date:   Mon, 06 Mar 2023 09:56:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a25ab205f63f0461@google.com>
Subject: [syzbot] [btrfs?] KMSAN: uninit-value in extent_fiemap
From:   syzbot <syzbot+8d245945ddc97769435f@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, glider@google.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    49a9a20768f5 kmsan: allow using __msan_instrument_asm_stor..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1597ff87880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d901b2d28729cb6a
dashboard link: https://syzkaller.appspot.com/bug?extid=8d245945ddc97769435f
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4a944f9f50fb/disk-49a9a207.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a2ec5594e201/vmlinux-49a9a207.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3aafc1a9ba37/bzImage-49a9a207.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d245945ddc97769435f@syzkaller.appspotmail.com

BTRFS info (device loop0): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop0): using free space tree
BTRFS info (device loop0): enabling ssd optimizations
=====================================================
BUG: KMSAN: uninit-value in extent_fiemap+0x2ece/0x6040 fs/btrfs/extent_io.c:3966
 extent_fiemap+0x2ece/0x6040 fs/btrfs/extent_io.c:3966
 btrfs_fiemap+0x20c/0x260 fs/btrfs/inode.c:8126
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x2daa/0x3c20 fs/ioctl.c:810
 __do_compat_sys_ioctl fs/ioctl.c:962 [inline]
 __se_compat_sys_ioctl+0x68c/0xfa0 fs/ioctl.c:910
 __ia32_compat_sys_ioctl+0x8f/0xd0 fs/ioctl.c:910
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was stored to memory at:
 read_extent_buffer fs/btrfs/extent_io.c:5185 [inline]
 btrfs_item_key fs/btrfs/ctree.h:2201 [inline]
 btrfs_item_key_to_cpu fs/btrfs/ctree.h:2306 [inline]
 extent_fiemap+0x2092/0x6040 fs/btrfs/extent_io.c:3965
 btrfs_fiemap+0x20c/0x260 fs/btrfs/inode.c:8126
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x2daa/0x3c20 fs/ioctl.c:810
 __do_compat_sys_ioctl fs/ioctl.c:962 [inline]
 __se_compat_sys_ioctl+0x68c/0xfa0 fs/ioctl.c:910
 __ia32_compat_sys_ioctl+0x8f/0xd0 fs/ioctl.c:910
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x9f1/0xe80 mm/page_alloc.c:5581
 __alloc_pages_bulk+0x1a99/0x2690 mm/page_alloc.c:5506
 alloc_pages_bulk_array include/linux/gfp.h:201 [inline]
 btrfs_alloc_page_array fs/btrfs/extent_io.c:1317 [inline]
 btrfs_clone_extent_buffer+0x48d/0x1230 fs/btrfs/extent_io.c:4303
 fiemap_search_slot fs/btrfs/extent_io.c:3688 [inline]
 extent_fiemap+0x1cf4/0x6040 fs/btrfs/extent_io.c:3940
 btrfs_fiemap+0x20c/0x260 fs/btrfs/inode.c:8126
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x2daa/0x3c20 fs/ioctl.c:810
 __do_compat_sys_ioctl fs/ioctl.c:962 [inline]
 __se_compat_sys_ioctl+0x68c/0xfa0 fs/ioctl.c:910
 __ia32_compat_sys_ioctl+0x8f/0xd0 fs/ioctl.c:910
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 0 PID: 6991 Comm: syz-executor.0 Not tainted 6.1.0-rc7-syzkaller-63931-g49a9a20768f5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
