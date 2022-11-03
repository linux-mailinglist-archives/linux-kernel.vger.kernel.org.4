Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFBD617463
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiKCCsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiKCCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:48:47 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B4C5A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:48:46 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x6-20020a056e021ca600b002ffe4b15419so675590ill.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 19:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MorNkLlyKdmiA/KOpWn5tQYwjt5E6XfXmkHv3JZT2cI=;
        b=sz0Hli0qDMLLjyU1znZ/3dJ0TqfwGGMuuA08Fg6BBAzcib2TxP5BOIQNpmPHVuIlBp
         uhJlPi7OnwC2JLy/cJQUD6HpSYeTfCp/XJZdEn4CKF6pt+tfXRGWnfPeqlyPj3w9Qj7k
         xI3n1PJwJ5J1irpARH1O1D6UR3gyOzXoH0zlVPo1llEio4J0dfcR9mwSm8JCyGPUpDOX
         WKHnS333kUzSHTx5iDB3lU060jy+gcWDzC5l5u7A+YVIntxqZoGxLYq0ErW3pau1Ll3C
         AJqHn/1i+7Nzi5cHqYDjDexz9ztCtNF2PJRbgQRKyDbF4ZcdELgF+Ya+bOc8F8RXLKRL
         rq1w==
X-Gm-Message-State: ACrzQf3SjG3Jp+fggN4OD5QL9zF6bX5JUSAxd0bFAK7hurKKZJIAP2UC
        +IqMNe2FUV/UM2cJyo2jXIqdbpmSppoISdhEgc/25gl0bh5W
X-Google-Smtp-Source: AMsMyM4WPjL/oR2/rCw8TUFtgf0NXNBMMx/dT8WtESZq5wLYvzqjKsX//7mY4NBDQ79OHBSU9S6b4x4LqGR1jzwthELmTg6ppZx9
MIME-Version: 1.0
X-Received: by 2002:a92:cdaf:0:b0:2fa:27e1:727a with SMTP id
 g15-20020a92cdaf000000b002fa27e1727amr16797246ild.135.1667443725604; Wed, 02
 Nov 2022 19:48:45 -0700 (PDT)
Date:   Wed, 02 Nov 2022 19:48:45 -0700
In-Reply-To: <00000000000013300305eaa8f1bf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f29f2705ec87fe29@google.com>
Subject: Re: [syzbot] WARNING in kernfs_active
From:   syzbot <syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, brauner@kernel.org, dvyukov@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    61c3426aca2c Add linux-next specific files for 20221102
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12c40689880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acb529cc910d907c
dashboard link: https://syzkaller.appspot.com/bug?extid=590ce62b128e79cf0a35
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1457cdda880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179969da880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc56d88dd6a3/disk-61c3426a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5921b65b080f/vmlinux-61c3426a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/39cbd355fedd/bzImage-61c3426a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+590ce62b128e79cf0a35@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5234 at fs/kernfs/dir.c:36 kernfs_active+0x119/0x150 fs/kernfs/dir.c:36
Modules linked in:
CPU: 1 PID: 5234 Comm: syz-executor157 Not tainted 6.1.0-rc3-next-20221102-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:kernfs_active+0x119/0x150 fs/kernfs/dir.c:36
Code: e8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 1f 8b 5b 04 31 ff 89 de e8 06 9a 7e ff 89 d8 5b f7 d0 5d c1 e8 1f c3 e8 27 9d 7e ff <0f> 0b eb a5 48 89 ef e8 eb 2a cb ff eb d7 48 c7 c7 2c 1a e3 8d e8
RSP: 0018:ffffc90003cdfbc0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8881400f31d0 RCX: 0000000000000000
RDX: ffff88802707d7c0 RSI: ffffffff81fe4429 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881400f31d0
R13: ffff88802a48e000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000555555ffe300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005f6b40 CR3: 000000007edff000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernfs_find_and_get_node_by_id+0x84/0x170 fs/kernfs/dir.c:708
 __kernfs_fh_to_dentry+0xdb/0x270 fs/kernfs/mount.c:102
 exportfs_decode_fh_raw+0x127/0x7b0 fs/exportfs/expfs.c:435
 exportfs_decode_fh+0x38/0x90 fs/exportfs/expfs.c:575
 do_handle_to_path fs/fhandle.c:152 [inline]
 handle_to_path fs/fhandle.c:207 [inline]
 do_handle_open+0x2b6/0x8b0 fs/fhandle.c:223
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f51080a6ba9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd1c41c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f51080a6ba9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000005
RBP: 00007f510806ad50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f510806ade0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

