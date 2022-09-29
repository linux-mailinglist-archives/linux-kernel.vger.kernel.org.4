Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962FC5EFD13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiI2Sau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiI2Sar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:30:47 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37018F3717
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:30:46 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id s15-20020a056e021a0f00b002f1760d1437so1736132ild.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 11:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nCnqXNalR9iIGXpPSclD1EyfxFkehYSCOstpd8agXRo=;
        b=iz+zT3wP3d3weAskZXkzRsvoElcY2tSeFcsgiIAgghOJyufOhQyp3x5UQ7PbkCsClP
         F+1m0kD0ibVZ1IgLrPpaoOnXoXw9exFA86pqMentxYxXEu7KNgdNHKU6ldVbQpn+OOt0
         XbL1bMtv5iYSJt3pulsNpmYjQ2B6F2i8QG94jgM6MmAOMBPuZHdBmdaIOBb6x6L3/+g0
         2ySZuJfkI8glQYTJrMcYWwQXoigcEnkfcBCWK+U5nnAthlXMdE6VoCnPbojRes6+T778
         8UDYZuUR85nTUqcbGwzsbXlO7SqEVRUkU980QrtKhlqXhOUY6iHOAdnInG/IGWriCWHK
         EiJw==
X-Gm-Message-State: ACrzQf2N25FBJ/UsCrXjjtdxXfBHOdy/4LYXsw1QqSU1uxdBrQqtr6V8
        ZDasCrj2zCejl8O46ppbg9+bgyxZjp4jOeIs+kbgxdshxRt2
X-Google-Smtp-Source: AMsMyM7X+YZz+V3SPr3Pq0Zfo99JljV7ajBx+9NYUoHoz6ULafPMRNH8U/1l9c6OMU4kPAiotWWWQGMaX6DHfyD+XwOlCHT3LTLU
MIME-Version: 1.0
X-Received: by 2002:a02:344b:0:b0:35a:ffdb:4649 with SMTP id
 z11-20020a02344b000000b0035affdb4649mr2592447jaz.8.1664476245610; Thu, 29 Sep
 2022 11:30:45 -0700 (PDT)
Date:   Thu, 29 Sep 2022 11:30:45 -0700
In-Reply-To: <000000000000678d0f05e9931411@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b564805e9d513dc@google.com>
Subject: Re: [syzbot] kernel BUG in dbFindLeaf
From:   syzbot <syzbot+dcea2548c903300a400e@syzkaller.appspotmail.com>
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

HEAD commit:    c3e0e1e23c70 Merge tag 'irq_urgent_for_v6.0' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b24c1f080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=dcea2548c903300a400e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d5fe98880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e224b8880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/67576e43d5c7/disk-c3e0e1e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e568fb42b955/vmlinux-c3e0e1e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcea2548c903300a400e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
BUG at fs/jfs/jfs_dmap.c:2984 assert(bitno < 32)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_dmap.c:2984!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3605 Comm: syz-executor593 Not tainted 6.0.0-rc7-syzkaller-00081-gc3e0e1e23c70 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:dbFindBits.cold+0xa1/0xa3 fs/jfs/jfs_dmap.c:2984
Code: fa e9 92 e0 95 f9 e8 91 ac 38 f8 48 c7 c1 80 67 29 8a ba a8 0b 00 00 48 c7 c6 00 66 29 8a 48 c7 c7 40 66 29 8a e8 e9 80 f8 ff <0f> 0b e8 6b ac 38 f8 49 63 d4 48 89 ee 48 c7 c7 c0 fd 4b 8c e8 09
RSP: 0018:ffffc9000393f000 EFLAGS: 00010282
RAX: 0000000000000030 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888025469d80 RSI: ffffffff8161f2a8 RDI: fffff52000727df2
RBP: 0000000000000000 R08: 0000000000000030 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000001
FS:  0000555556112300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef28f2000 CR3: 0000000072e93000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 dbAllocDmapLev+0x223/0x2c0 fs/jfs/jfs_dmap.c:1950
 dbAllocCtl+0x131/0x780 fs/jfs/jfs_dmap.c:1793
 dbAllocAG+0x8da/0xd20 fs/jfs/jfs_dmap.c:1334
 dbAlloc+0x40d/0xa70 fs/jfs/jfs_dmap.c:858
 dtSplitUp+0x365/0x5120 fs/jfs/jfs_dtree.c:974
 dtInsert+0x82b/0xa10 fs/jfs/jfs_dtree.c:863
 jfs_create+0x5b7/0xac0 fs/jfs/namei.c:137
 lookup_open.isra.0+0xf05/0x12a0 fs/namei.c:3413
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x996/0x28f0 fs/namei.c:3688
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_open fs/open.c:1337 [inline]
 __se_sys_open fs/open.c:1333 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1333
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f954faecf09
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef28f1458 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f954faecf09
RDX: 0000000000000000 RSI: 00000000000000f0 RDI: 0000000020000140
RBP: 00007f954faac6d0 R08: 00005555561122c0 R09: 0000000000000000
R10: 00007ffef28f1320 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dbFindBits.cold+0xa1/0xa3 fs/jfs/jfs_dmap.c:2984
Code: fa e9 92 e0 95 f9 e8 91 ac 38 f8 48 c7 c1 80 67 29 8a ba a8 0b 00 00 48 c7 c6 00 66 29 8a 48 c7 c7 40 66 29 8a e8 e9 80 f8 ff <0f> 0b e8 6b ac 38 f8 49 63 d4 48 89 ee 48 c7 c7 c0 fd 4b 8c e8 09
RSP: 0018:ffffc9000393f000 EFLAGS: 00010282
RAX: 0000000000000030 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888025469d80 RSI: ffffffff8161f2a8 RDI: fffff52000727df2
RBP: 0000000000000000 R08: 0000000000000030 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000001
FS:  0000555556112300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffef28f2000 CR3: 0000000072e93000 CR4: 0000000000350ef0

