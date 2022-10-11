Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3B5FA8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 02:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJKAAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 20:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiJKAAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 20:00:41 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEA67268C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:00:40 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id h2-20020a056602154200b006bb5f8574afso8233509iow.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:00:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbvS0X3m3SbRe3ACMhfuRQZ14nncl70F/pfj7aK5Oak=;
        b=JRBxa6F0CWuOcInU3Lk1JS/w33cSFizdepHYuKKDvf0AtaQsdCE65F93eOD600d+V+
         zpV64XRA5re5AVgjHHnqZFeboUHWepbAAOwursxyLC12//o4/DO8Pfh8G7l5BNsrNwoE
         chNWkGdKMTQHb4oH4h0D/AR/GyeV1Sa1P8TmCCHepn7iTanIhBj4mU47L55tkZB8SANX
         gY4Z/HgUiFzqSqHxhNIXygIMCNL2l6l0L7C+qRl17KiU3bbVyuPmF7W9KyPmgme1GYM/
         0JGd+Q1Ud4PDHtSFCN9fOz+EOW8Tv1red+J5wMbikggrvG34pb8aEAJY9d2uY5EgRoEp
         7EbQ==
X-Gm-Message-State: ACrzQf1+X6D6YBqgJszY/ejMKj9W3Ckfx+ZDZ/WwaA4Prgl3snmixl/+
        oopVcJEMliLUttsYSsmCw55PkuRVrFOdtQegrR2KqgsSRQLl
X-Google-Smtp-Source: AMsMyM533gTkDEzvWDwybUS2DzbBpkMuCqS+TnEE3zECelkRknEw6C/GiR4OfzEHlyIKR+x0t5QPt09RpeVgRk8VK6zs4fUBILab
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3043:b0:341:d8a4:73e8 with SMTP id
 u3-20020a056638304300b00341d8a473e8mr11553257jak.239.1665446440106; Mon, 10
 Oct 2022 17:00:40 -0700 (PDT)
Date:   Mon, 10 Oct 2022 17:00:40 -0700
In-Reply-To: <00000000000093079705ea9aada2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007482b905eab6f749@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in dbFindCtl
From:   syzbot <syzbot+7edb85bc97be9f350d90@syzkaller.appspotmail.com>
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

HEAD commit:    4899a36f91a9 Merge tag 'powerpc-6.1-1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12ead462880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2021a61197ebe02
dashboard link: https://syzkaller.appspot.com/bug?extid=7edb85bc97be9f350d90
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1404403a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10789852880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1a98722ff83f/disk-4899a36f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a31d6690395/vmlinux-4899a36f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6fb347a504fa/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7edb85bc97be9f350d90@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1671:12
shift exponent 1834973817 is too large for 64-bit type 'long long int'
CPU: 0 PID: 3603 Comm: syz-executor644 Not tainted 6.0.0-syzkaller-09413-g4899a36f91a9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 dbFindCtl.cold+0x52/0x57 fs/jfs/jfs_dmap.c:1671
 dbAllocAny+0xa4/0x1a0 fs/jfs/jfs_dmap.c:1502
 dbAlloc+0x46d/0xa70 fs/jfs/jfs_dmap.c:859
 diNewExt+0x724/0x1a10 fs/jfs/jfs_imap.c:2251
 diAllocExt fs/jfs/jfs_imap.c:1945 [inline]
 diAllocAG+0x15f1/0x2200 fs/jfs/jfs_imap.c:1662
 diAlloc+0x82d/0x1730 fs/jfs/jfs_imap.c:1583
 ialloc+0x89/0xaa0 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1f0/0xab0 fs/jfs/namei.c:225
 vfs_mkdir+0x489/0x740 fs/namei.c:4013
 do_mkdirat+0x28c/0x310 fs/namei.c:4038
 __do_sys_mkdir fs/namei.c:4058 [inline]
 __se_sys_mkdir fs/namei.c:4056 [inline]
 __x64_sys_mkdir+0xf2/0x140 fs/namei.c:4056
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc402fc5c29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc056f56d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc402fc5c29
RDX: 00007fc402f84123 RSI: 0000000000000000 RDI: 00000000200052c0
RBP: 00007fc402f853f0 R08: 0000555555d8a2c0 R09: 0000000000000000
R10: 00007ffc056f55a0 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00080000000000f4 R15: 0000000000000000
 </TASK>
================================================================================

