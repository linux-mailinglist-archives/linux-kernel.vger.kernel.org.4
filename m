Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98185609AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJXHEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJXHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:04:42 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A706FD01
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:04:37 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id u11-20020a6b490b000000b006bbcc07d893so5930366iob.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guQBpKVE1fSZKSKrsCy/ErG3GRc+o9cC6FZBdBYutjA=;
        b=Ijvq2WVejKY0D1OD1izVwuzroaLihHdJULURJxX/sk31SC0rIpe0bvq0SFG20o2Jkv
         SamrW2xm8RwE7q1Q3798IZLDzWyZAWpCc6j8QEzzXEVFwbKfKsD3BFEelh+FmrB/dOxt
         TBmVVFg4254PbBklmC8a86ZolfnuoyETbJGikWXQc5miBZCtm99Z+TsZ7OdyhLIuO+Rn
         0R/ZuyCKEL6cvZnzBJIvATL8vyrdYi1sGjitDYm3p9iQ44NxDyecNgqRmjmjuDleMEtk
         S7v6CRNT0ko/VNb94K+Y0eNM3Ep5kmv7OLSlvaVkBg4sB1jT8zNcVYf4p6DLhgP2uvCy
         UPpA==
X-Gm-Message-State: ACrzQf2zrTqrU2RXMR2uu6A4z0nU0OyHEUO7Yg2r37C1XY1ERfF+Lwja
        pzzITVqa3Yx3bqFtYb5lvwYwrAEwu3Q6CKYpQqUsdgkYnwS5
X-Google-Smtp-Source: AMsMyM7EwbZCuDoIyQG4Ron635vfyqLAh7wG4Ie5hHRvFbDKNZBBIgKkEd/stYNePJN3ZWUSnODwwzrXBHuWCgDWL25KyUnfc5rL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:2fa:a78c:1d8b with SMTP id
 n7-20020a056e02148700b002faa78c1d8bmr21651995ilk.264.1666595076614; Mon, 24
 Oct 2022 00:04:36 -0700 (PDT)
Date:   Mon, 24 Oct 2022 00:04:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086b13105ebc267f8@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in diAllocBit
From:   syzbot <syzbot+cfb3836ee00e264151bc@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    d47136c28015 Merge tag 'hwmon-for-v6.1-rc2' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1564d752880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afc317c0f52ce670
dashboard link: https://syzkaller.appspot.com/bug?extid=cfb3836ee00e264151bc
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/93767c1bd2e7/disk-d47136c2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c8bee7ab7d48/vmlinux-d47136c2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cfb3836ee00e264151bc@syzkaller.appspotmail.com

UBSAN: shift-out-of-bounds in fs/jfs/jfs_imap.c:2039:9
shift exponent 3328 is too large for 64-bit type '__u64' (aka 'unsigned long long')
CPU: 0 PID: 19191 Comm: syz-executor.2 Not tainted 6.1.0-rc1-syzkaller-00427-gd47136c28015 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 diAllocBit+0x9d7/0xd30 fs/jfs/jfs_imap.c:2039
 diAllocIno fs/jfs/jfs_imap.c:1837 [inline]
 diAllocAG+0x1418/0x1f80 fs/jfs/jfs_imap.c:1669
 diAlloc+0x3dd/0x1700 fs/jfs/jfs_imap.c:1583
 ialloc+0x8c/0xa80 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x141/0xb00 fs/jfs/namei.c:225
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4035
 do_mkdirat+0x279/0x550 fs/namei.c:4060
 __do_sys_mkdir fs/namei.c:4080 [inline]
 __se_sys_mkdir fs/namei.c:4078 [inline]
 __x64_sys_mkdir+0x6a/0x80 fs/namei.c:4078
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7246c8b5f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7247dad168 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007f7246dac050 RCX: 00007f7246c8b5f9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020007040
RBP: 00007f7246ce67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc5fe2b60f R14: 00007f7247dad300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
