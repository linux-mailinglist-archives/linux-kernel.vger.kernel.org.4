Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164CC5F381A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 23:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJCVtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJCVtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 17:49:19 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC4824BF8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 14:48:35 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id b9-20020a6be709000000b006a469cf388eso7731286ioh.19
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 14:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wLZsbe7ZmTnE9G212gTvxpJOOUYL5XML37732RJycqs=;
        b=sF+bwK52+CIyC0OwENodmS+8bDOGe6ksOjwF7P1Y1wDpLPD6Jxb1fEib0W1QLKY9Em
         jne7DXHX+5/LNT+9hb0a7aBdQsVfgnwBVuey+4hqTgXoi50w5fIqPe2ys8wBGXkWd2Ot
         7vUMjwDdnyHnZbaeEjfd7b2alPEmy3KQEyOyrAx7nzpj5t1tQsJj12Bum4nBYu6bDNI4
         s2W3bEfHmaBpEeVpFbb9ifCiOK0iEYyJQyHjBble8QEpBmMQ7p/JE57nbK7qBl2pQikD
         YTDZ24x3b1pqMPWtRl6A3uNBaQnQgR2tO6LUo2hXuatui0qMgYcW7+GXUx9SMx3szv5O
         ncew==
X-Gm-Message-State: ACrzQf2x08KlK+KzpifeXrRJ5NgiqyZkWStHwtuT5biNCVC7XaIR1h9I
        oT/mg7wKArxvngHay5JBVTte0gBvYQta6Fw0+rpOFsNx1WBB
X-Google-Smtp-Source: AMsMyM7e8C4zCP+elAA/KM9EH8v5YSPI9+GNc5bgbHjCzC46WkKvEYB0LhQkFRpneDstZXmEgwdB7brVUUiladG+L/EhyvB3s0W6
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2188:b0:35a:47c3:4784 with SMTP id
 s8-20020a056638218800b0035a47c34784mr11070778jaj.223.1664833715023; Mon, 03
 Oct 2022 14:48:35 -0700 (PDT)
Date:   Mon, 03 Oct 2022 14:48:35 -0700
In-Reply-To: <0000000000006ad0d505ea0b63ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031b62205ea284e99@google.com>
Subject: Re: [syzbot] UBSAN: shift-out-of-bounds in dbAllocCtl
From:   syzbot <syzbot+f0e5eba3996857670c88@syzkaller.appspotmail.com>
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

HEAD commit:    aaa11ce2ffc8 Add linux-next specific files for 20220923
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=120fd4cc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=f0e5eba3996857670c88
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140d5a0a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a2f712880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95c7bf83c07e/disk-aaa11ce2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b161cd56a7a3/vmlinux-aaa11ce2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0e5eba3996857670c88@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1785:12
shift exponent 1635280253 is too large for 64-bit type 'long long int'
CPU: 0 PID: 3609 Comm: syz-executor492 Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 dbAllocCtl.cold+0x75/0x7a fs/jfs/jfs_dmap.c:1785
 dbAllocAG+0x8da/0xd20 fs/jfs/jfs_dmap.c:1334
 dbAlloc+0x40d/0xa70 fs/jfs/jfs_dmap.c:858
 diNewIAG fs/jfs/jfs_imap.c:2500 [inline]
 diAllocExt fs/jfs/jfs_imap.c:1898 [inline]
 diAllocAG+0xb93/0x2200 fs/jfs/jfs_imap.c:1662
 diAlloc+0x82d/0x1730 fs/jfs/jfs_imap.c:1583
 ialloc+0x89/0xaa0 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1f0/0xab0 fs/jfs/namei.c:225
 vfs_mkdir+0x489/0x740 fs/namei.c:4013
 do_mkdirat+0x28c/0x310 fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0x115/0x170 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f732d8ecdd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff2953b988 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f732d8ecdd9
RDX: 0000000000000000 RSI: 0000000020000540 RDI: 0000000000000003
RBP: 00007f732d8ac5a0 R08: 0000000000000000 R09: 00007f732d8ac5a0
R10: 000055555602c2c0 R11: 0000000000000246 R12: 0000000200000004
R13: 0000000000000000 R14: 00080000000000f4 R15: 0000000000000000
 </TASK>
================================================================================

