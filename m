Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA7361DBE4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 17:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiKEQHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKEQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 12:07:54 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459E310068
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 09:07:53 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id bf14-20020a056602368e00b006ce86e80414so4719223iob.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 09:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SrkMdh2rzSEfUpITUGJrHhsutoE7n5vCXPNepIr4K2k=;
        b=t++IHxtiYhJnZEFuXAJ01GL1iEYqFnThQBPDRRwzRrTc6tK+e9GrcPOYIZNH5f5heT
         GVxp+O/02TW94bleAQ7M8M5tiqTcDTfjmMLHjm7s0bYR8S1glCll+40Quf1o/Vy326rq
         JJYjuduPu+s+ms433pKpwbyXmQtg7ThtZhhxRMkTyDH5JsvhipU3Sdmivqn5knPIJmFf
         V5sgbvhVvPZMF5ScL8cETlWrW5v1GSdv9G5aQvpG8QhVqs3bZqSj/cW+TphmRtmc17j1
         PY+PAnQgnFG3U4eGUFVYzuG/8WkBrhMxbC2v0jNTUZeMEiLfSsIiIfn7dKQWY7/5Fjym
         Z2UQ==
X-Gm-Message-State: ACrzQf2XccjURid4XXp3H/+AXRDesUxzTbS7LbsTXurYuacyHtPH50yJ
        hw+NPy48eFQoKs4slIseaLOrDc/YuBKQXHHCkR6csHRxyjao
X-Google-Smtp-Source: AMsMyM6ys/LYnOhuTYOgkQ7MFHH4ecac145EmKuKP9CrJkMvbn34KrtBesqKzcBYna0D2fV2xIFVycZ7w9BmJZ5cZKkPFQ2r0IDY
MIME-Version: 1.0
X-Received: by 2002:a05:6638:ce:b0:373:fccb:63e3 with SMTP id
 w14-20020a05663800ce00b00373fccb63e3mr24202249jao.66.1667664472626; Sat, 05
 Nov 2022 09:07:52 -0700 (PDT)
Date:   Sat, 05 Nov 2022 09:07:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007edb6605ecbb6442@google.com>
Subject: [syzbot] INFO: trying to register non-static key in f2fs_handle_error
From:   syzbot <syzbot+40642be9b7e0bb28e0df@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        terrelln@fb.com
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

HEAD commit:    10d916c86eca Merge tag 'soc-fixes-6.1-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117b4251880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ddb381fe9a8f6a8b
dashboard link: https://syzkaller.appspot.com/bug?extid=40642be9b7e0bb28e0df
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/73d5475b518c/disk-10d916c8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ce12d00f04a/vmlinux-10d916c8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d23719c0557/bzImage-10d916c8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+40642be9b7e0bb28e0df@syzkaller.appspotmail.com

loop1: detected capacity change from 0 to 264192
F2FS-fs (loop1): inaccessible inode: 2, run fsck to repair
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 28028 Comm: syz-executor.1 Not tainted 6.1.0-rc3-syzkaller-00239-g10d916c86eca #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 assign_lock_key+0x22a/0x240 kernel/locking/lockdep.c:981
 register_lock_class+0x287/0x9b0 kernel/locking/lockdep.c:1294
 __lock_acquire+0xe4/0x1f60 kernel/locking/lockdep.c:4934
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:350 [inline]
 f2fs_save_errors fs/f2fs/super.c:3868 [inline]
 f2fs_handle_error+0x29/0x230 fs/f2fs/super.c:3896
 f2fs_iget+0x215/0x4bb0 fs/f2fs/inode.c:516
 f2fs_fill_super+0x47d3/0x7b50 fs/f2fs/super.c:4222
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2e3/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5a7388cada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5a74682f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f5a7388cada
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f5a74682fe0
RBP: 00007f5a74683020 R08: 00007f5a74683020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f5a74682fe0 R15: 00000000200005c0
 </TASK>
F2FS-fs (loop1): Failed to read F2FS meta data inode


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
