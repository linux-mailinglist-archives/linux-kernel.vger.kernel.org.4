Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C717F630DD3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 10:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiKSJcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 04:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiKSJcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 04:32:47 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693918FFA0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:32:46 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so4885282ild.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:32:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzgvcnu4RehLlaIos2qw74V1Rm/ANtY+0e1pgohKtVc=;
        b=KX2OQMz9VdmLOfDPcICkPcjfXUTJqtXqpnMjCYrGAwsVhFp9TKVvGKHhD/w+NL5hBJ
         P0/j0vr0Tk6zXJ5QJO1/QT8h7vFK34XTDg6SQkeRnW+QWneKgAE7wsT56d0O4I9L4O/2
         psOsCOVc5ZhCzvJDB2UUwfA9+cwMtqniqSgy5t/qO7ojL7i/ll8I/eqVmb6nAEMQSYs0
         tMf5E6Sxrb1LXM/xyOk6PN2KtOK3DdFxgzHDJDpBtzDli61UD+TtYy+sfwYM69BP5vdF
         4QjPzQtiYwVIWvBvvAirlRuyRapZViSpUII6oy5twYI/FH4jqg2iGKoy0zosrSjd4BcZ
         6ZRA==
X-Gm-Message-State: ANoB5pkKX4KHyzVMvktTlv1rd3VPqDKKD55zl6wCKJcV2llqr9ChUl8W
        /YEPFs86U9YvRQOTV4dr6eKCkYrgpYD+DSIyxB5vOjvCTY9v
X-Google-Smtp-Source: AA0mqf7M34HLaReQ7iZxJI6lr+tDpY4FARUliJwgjpFrVOM2hnrKidFbnLhng2IytDkaqRhYMOFvq3JOwb26lfsuXNkpIvKv5POv
MIME-Version: 1.0
X-Received: by 2002:a92:d90c:0:b0:2fc:b8b7:484e with SMTP id
 s12-20020a92d90c000000b002fcb8b7484emr4772923iln.122.1668850365654; Sat, 19
 Nov 2022 01:32:45 -0800 (PST)
Date:   Sat, 19 Nov 2022 01:32:45 -0800
In-Reply-To: <00000000000009854205ebd33650@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a702c05edcf81ef@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in jfs_statfs
From:   syzbot <syzbot+3424c9550a49659f1704@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    ab290eaddc4c Merge tag 's390-6.1-5' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1006e331880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f9416d398342c83
dashboard link: https://syzkaller.appspot.com/bug?extid=3424c9550a49659f1704
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a0ec6e880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105d8d45880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a3af44347ffd/disk-ab290ead.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4331229e5ff9/vmlinux-ab290ead.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b0c12f02efc3/bzImage-ab290ead.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6e5bfebe2bc7/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3424c9550a49659f1704@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/super.c:140:14
shift exponent 1749508610 is too large for 64-bit type 's64' (aka 'long long')
CPU: 0 PID: 3634 Comm: syz-executor222 Not tainted 6.1.0-rc5-syzkaller-00241-gab290eaddc4c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 jfs_statfs+0x503/0x510 fs/jfs/super.c:140
 statfs_by_dentry fs/statfs.c:66 [inline]
 vfs_statfs+0x136/0x310 fs/statfs.c:90
 user_statfs fs/statfs.c:105 [inline]
 __do_sys_statfs fs/statfs.c:195 [inline]
 __se_sys_statfs fs/statfs.c:192 [inline]
 __x64_sys_statfs+0x120/0x230 fs/statfs.c:192
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0501ab8f79
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffffd945308 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f0501ab8f79
RDX: 00007f0501a77473 RSI: 0000000000000000 RDI: 0000000020004c80
RBP: 00007f0501a78740 R08: 0000555555fe32c0 R09: 0000000000000000
R10: 00007ffffd9451d0 R11: 0000000000000246 R12: 0a0a0a0a0a0a0a0a
R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
 </TASK>
================================================================================

