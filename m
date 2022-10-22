Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24E608CAF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiJVLcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiJVLcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:32:35 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7112D0822
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:11:43 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id y13-20020a056e021bed00b002faba3c4afbso5480115ilv.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ubwkma3WiLh/S5iM+1pCyfwwQgQOHzaRNUkLcPRHQk=;
        b=KxFwR4U/GcvXcbA7PQ21mCjeF+D59hyn1S39NqSKpPOUOGNzBZ336t8whZyfMifq59
         T9PRn2ktH2ADUgmWlNwugLa0xaCCHY3s43MgBgRo8cTeyuHrjyqC46NrCKCQhS7+ZT9t
         c08ldY3GPDPcpCxYAG7vA/dpuXIP3LCm6pS35cdfk+0eJvRuvKhWIqAlOYMrJYPGsxa9
         FYnK9rFhGa4N3lxtHlmUOFXpZe4CuFseGnNsHXcuZgbNC6JKRxdq6TyVpvqZfp9mc8+T
         kIOaEBNntdESFCLnnvaKRkTBA/wpHUjy6uHzPG+s17JZZdmD4rOFYasLhGCcH/D+HIuG
         QZ7A==
X-Gm-Message-State: ACrzQf0ICVn9xz4lLhmX8WBqNqMDqjCFAsee/h1wKiycmOzNT4o9ES8y
        jFVyydFnFo7NUQs4NiT51Y2EfXTUcrlfEQmymkDWRmLzZFWK
X-Google-Smtp-Source: AMsMyM4jixRPnzXRGeyGH2ujWO81AivWxSyQpvbJ3ZylO4NeIrIwHruzsuohkd8Atkyjd06kDtUEtmBdu0UK4Z47lwxdxAfnfcJt
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150c:b0:363:a4f4:fdc6 with SMTP id
 b12-20020a056638150c00b00363a4f4fdc6mr17715479jat.185.1666437102521; Sat, 22
 Oct 2022 04:11:42 -0700 (PDT)
Date:   Sat, 22 Oct 2022 04:11:42 -0700
In-Reply-To: <000000000000075fb105e8c52ada@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008954f305eb9d9f7c@google.com>
Subject: Re: [syzbot] WARNING in gfs2_ri_update
From:   syzbot <syzbot+f8bc4176e51e87e0928f@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    440b7895c990 Merge tag 'mm-hotfixes-stable-2022-10-20' of ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=128087a4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afc317c0f52ce670
dashboard link: https://syzkaller.appspot.com/bug?extid=f8bc4176e51e87e0928f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ed90f2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16717fc2880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/105038975fc9/disk-440b7895.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/edd7302c8fc8/vmlinux-440b7895.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/95d6d27d2d50/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8bc4176e51e87e0928f@syzkaller.appspotmail.com

gfs2: fsid=syz:syz: Now mounting FS (format 1801)...
gfs2: fsid=syz:syz.0: journal 0 mapped with 1 extents in 0ms
gfs2: fsid=syz:syz.0: first mount done, others may mount
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3611 at mm/page_alloc.c:5530 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5530
Modules linked in:
CPU: 1 PID: 3611 Comm: syz-executor282 Not tainted 6.1.0-rc1-syzkaller-00158-g440b7895c990 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5530
Code: 5c 24 04 0f 85 f3 00 00 00 44 89 e1 81 e1 7f ff ff ff a9 00 00 04 00 41 0f 44 cc 41 89 cc e9 e3 00 00 00 c6 05 a1 ab 29 0c 01 <0f> 0b 83 fb 0a 0f 86 c8 fd ff ff 31 db 48 c7 44 24 20 0e 36 e0 45
RSP: 0018:ffffc90003c5f4a0 EFLAGS: 00010246
RAX: ffffc90003c5f500 RBX: 0000000000000012 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90003c5f528
RBP: ffffc90003c5f5b8 R08: dffffc0000000000 R09: ffffc90003c5f500
R10: fffff5200078bea5 R11: 1ffff9200078bea0 R12: 0000000000040d40
R13: 1ffff9200078be9c R14: dffffc0000000000 R15: 1ffff9200078be98
FS:  0000555555781300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 0000000079874000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node include/linux/gfp.h:223 [inline]
 alloc_pages_node include/linux/gfp.h:246 [inline]
 __kmalloc_large_node+0x8a/0x1a0 mm/slab_common.c:1098
 __do_kmalloc_node mm/slab_common.c:943 [inline]
 __kmalloc+0xfe/0x1a0 mm/slab_common.c:968
 kmalloc_array include/linux/slab.h:628 [inline]
 kcalloc include/linux/slab.h:659 [inline]
 compute_bitstructs fs/gfs2/rgrp.c:766 [inline]
 read_rindex_entry fs/gfs2/rgrp.c:931 [inline]
 gfs2_ri_update+0x537/0x17f0 fs/gfs2/rgrp.c:1001
 gfs2_rindex_update+0x313/0x3f0 fs/gfs2/rgrp.c:1051
 init_inodes+0x242/0x340 fs/gfs2/ops_fstype.c:917
 gfs2_fill_super+0x1bb2/0x2700 fs/gfs2/ops_fstype.c:1247
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb4bd4a797a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc73f0a0b8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb4bd4a797a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffc73f0a0d0
RBP: 00007ffc73f0a0d0 R08: 00007ffc73f0a110 R09: 00005555557812c0
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000004
R13: 00007ffc73f0a110 R14: 000000000000091b R15: 000000002000dc88
 </TASK>

