Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27EF60EC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbiJZX3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiJZX3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:29:50 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B163B47B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 16:29:48 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso2229613ilj.17
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 16:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TAbld4UtZoBRGRCs9SA2Vo9mf3zAKcvQiEVsqXN8F6Q=;
        b=Uk2psE8PdPTUEImeic1rFQp/gOIzUFgpqxYsBwNT4n9jzPjRJTQDdmK94wshjmAofb
         slJG6q+SVNakxFDXFKlzsxJmtKWLWF+veGnekXbOtTXejO/RxufeOIy/GyG21dI7iQ1t
         0cxfBd3gejHRhbgKOz59H7KRWd842kke+cnQE+ZhcQh40XmbFfbgkZy+3xZOG6a5BEz7
         Dc6moLTuhzr/abndnbiOpB02/lOZfb4DhpyVRuThYS8PUVQsrNFd4a5l/DcR2EnHktMp
         yjM3oMnlqD8XRx9H5HazTYbuLZ3B5X625Hvdxzm3alohRC8UhB1VFfvTG/+vMUTw+T9e
         /1rQ==
X-Gm-Message-State: ACrzQf1gWe6P+eWdnW8vYiQqN+fIoe7yUU1qipphpKaJtPMysFObFI7m
        gb3UMI1VhJHXRNiy9ttbb/dHIuR4n8FH7PGnwx8E5ASQD4bB
X-Google-Smtp-Source: AMsMyM55HzvN5BpmI9JgGF1Q9rYeWQHGJsllqKVmeN/VrYcd+3KYVDs28wIPbLRnioYbJOovM0PkbvpKKuy1DyEY5hMdo7NbU/6p
MIME-Version: 1.0
X-Received: by 2002:a6b:6709:0:b0:6bc:269e:e81a with SMTP id
 b9-20020a6b6709000000b006bc269ee81amr27420312ioc.174.1666826988275; Wed, 26
 Oct 2022 16:29:48 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:29:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089d01005ebf866f2@google.com>
Subject: [syzbot] kernel BUG in dbFindCtl
From:   syzbot <syzbot+884094a86cde3d3e37ef@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, paskripkin@gmail.com, r33s3n6@gmail.com,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4d48f589d294 Add linux-next specific files for 20221021
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=119b63d2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
dashboard link: https://syzkaller.appspot.com/bug?extid=884094a86cde3d3e37ef
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cd2386880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bbbf6a880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c86bd0b39a0/disk-4d48f589.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/074059d37f1f/vmlinux-4d48f589.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/8b860bb9b972/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+884094a86cde3d3e37ef@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BUG at fs/jfs/jfs_dmap.c:2994 assert(bitno < 32)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_dmap.c:2994!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3608 Comm: syz-executor549 Not tainted 6.1.0-rc1-next-20221021-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:dbFindCtl.cold-0x2/0x57
Code: fa e9 5f aa 87 f9 e8 ae c8 28 f8 48 c7 c1 80 b2 09 8a ba b2 0b 00 00 48 c7 c6 00 b1 09 8a 48 c7 c7 40 b1 09 8a e8 66 6f f8 ff <0f> 0b e8 88 c8 28 f8 49 63 d4 48 89 ee 48 c7 c7 c0 74 2c 8c e8 a6
RSP: 0018:ffffc90003cdf008 EFLAGS: 00010286
RAX: 0000000000000030 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801d9d0000 RSI: ffffffff81621a58 RDI: fffff5200079bdf3
RBP: 0000000000000000 R08: 0000000000000030 R09: 0000000000000000
R10: 0000000080000000 R11: 6620746120475542 R12: 0000000000000001
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000001
FS:  0000555555d65300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f73e30a0020 CR3: 000000001e2d3000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dbAllocDmapLev+0x223/0x2c0 fs/jfs/jfs_dmap.c:1960
 dbAllocCtl+0x131/0x780 fs/jfs/jfs_dmap.c:1803
 dbAllocAG+0x8da/0xd20 fs/jfs/jfs_dmap.c:1344
 dbAlloc+0x40d/0xa70 fs/jfs/jfs_dmap.c:868
 dtSplitUp+0x365/0x5130 fs/jfs/jfs_dtree.c:974
 dtInsert+0x82b/0xa10 fs/jfs/jfs_dtree.c:863
 jfs_create+0x5b7/0xac0 fs/jfs/namei.c:137
 lookup_open.isra.0+0xf05/0x12a0 fs/namei.c:3413
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x990/0x2850 fs/namei.c:3710
 do_filp_open+0x1b6/0x400 fs/namei.c:3740
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f73e30c7f09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff2dfe1fd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f73e30c7f09
RDX: 0000000000000000 RSI: 00000000000000f0 RDI: 0000000020000140
RBP: 00007f73e30876d0 R08: 0000555555d652c0 R09: 0000000000000000
R10: 00007fff2dfe1ea0 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dbFindCtl.cold-0x2/0x57
Code: fa e9 5f aa 87 f9 e8 ae c8 28 f8 48 c7 c1 80 b2 09 8a ba b2 0b 00 00 48 c7 c6 00 b1 09 8a 48 c7 c7 40 b1 09 8a e8 66 6f f8 ff <0f> 0b e8 88 c8 28 f8 49 63 d4 48 89 ee 48 c7 c7 c0 74 2c 8c e8 a6
RSP: 0018:ffffc90003cdf008 EFLAGS: 00010286
RAX: 0000000000000030 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88801d9d0000 RSI: ffffffff81621a58 RDI: fffff5200079bdf3
RBP: 0000000000000000 R08: 0000000000000030 R09: 0000000000000000
R10: 0000000080000000 R11: 6620746120475542 R12: 0000000000000001
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000001
FS:  0000555555d65300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f5e9479d28 CR3: 000000001e2d3000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
