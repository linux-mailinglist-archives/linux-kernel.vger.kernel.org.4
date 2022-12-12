Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF265649923
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiLLHDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiLLHDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:03:04 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5C5C6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:03:03 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id y24-20020a5ec818000000b006e2c0847835so5693758iol.12
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFnkrqn569e2OndyNQxNbTLfH9dPwRk1pHBzW5nmI/w=;
        b=3HWhHZbkLE15N0of3ffT18fYtXgpSf5Ize9+qySnLyoQMQsthnRwEBWf3qHN3XOx0G
         rsPwdQuMbzfY5nplEqzZDcSEPUarQVW0UDSzWFTasBD11nyJcve+2ZQW0lWcadQxm0iU
         gLH1XILZi135cEKEETvrSmrrRPIIwlwxl9wVnk4wyraq5alpYKkOEUghUGZsDX3WD5uN
         PbXcPbnx11IFNYfLJyXEYzfJcytMOV4G9up2HIl/7agLmcx8xtfN3Y7qM3igtIMIlmBU
         KKHfO6+KF1oRNN0OxU353u1bzuRadkFJqjrWZ+JVgVZ9z/Zye5RClq+MmaEWsXn660RV
         ulUA==
X-Gm-Message-State: ANoB5plCt+IoZ0vDRDzPtQc0Us2un0lB/ka1YY94A7LDPWswjUaQHn68
        gHZ90n5urIGRl9QEhmm/CY90BmXR+Ogc1g1Bl5ckU+kPaI8v
X-Google-Smtp-Source: AA0mqf5PdzrCNSZRXvVmes7BxseB0VSlSEGeGI6WU2qojswJ4gAjCDSiz5q9kfodgNuWlGqn9XzMUwAE4gR45S72AHYT7j8P9UH2
MIME-Version: 1.0
X-Received: by 2002:a92:d18e:0:b0:302:ca31:62a1 with SMTP id
 z14-20020a92d18e000000b00302ca3162a1mr35293800ilz.42.1670828582871; Sun, 11
 Dec 2022 23:03:02 -0800 (PST)
Date:   Sun, 11 Dec 2022 23:03:02 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029b00c05ef9c1802@google.com>
Subject: [syzbot] WARNING in gfs2_check_blk_type
From:   syzbot <syzbot+092b28923eb79e0f3c41@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    4cee37b3a4e6 Merge tag 'mm-hotfixes-stable-2022-12-10-1' o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14da950b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=092b28923eb79e0f3c41
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f12ddb880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ebee1f880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/051fc9a10d4a/disk-4cee37b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c40b15750245/vmlinux-4cee37b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a25e4bc102fa/bzImage-4cee37b3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f10d144677a2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+092b28923eb79e0f3c41@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: first mount done, others may mount
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3635 at fs/gfs2/rgrp.c:2628 gfs2_rbm_from_block fs/gfs2/rgrp.c:279 [inline]
WARNING: CPU: 0 PID: 3635 at fs/gfs2/rgrp.c:2628 gfs2_check_blk_type+0x43d/0x660 fs/gfs2/rgrp.c:2627
Modules linked in:
CPU: 0 PID: 3635 Comm: syz-executor328 Not tainted 6.1.0-rc8-syzkaller-00164-g4cee37b3a4e6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:gfs2_check_blk_type+0x43d/0x660 fs/gfs2/rgrp.c:2628
Code: 85 c6 01 00 00 8b 1b 89 df 44 89 f6 e8 1c ae cd fd 4c 89 74 24 10 44 39 f3 76 21 e8 6d ac cd fd 45 31 ed eb 6d e8 63 ac cd fd <0f> 0b 41 bf f9 ff ff ff 48 8b 5c 24 18 e9 41 01 00 00 e8 4c ac cd
RSP: 0018:ffffc90003c0f8c0 EFLAGS: 00010293
RAX: ffffffff83bcf389 RBX: 0000000000000012 RCX: ffff88802243ba80
RDX: 0000000000000000 RSI: 0000000000000012 RDI: 0000000000000013
RBP: ffffc90003c0f9d0 R08: ffffffff83bcf37f R09: ffffed100e7a15dd
R10: ffffed100e7a15dd R11: 1ffff1100e7a15dc R12: 1ffff1100ea34806
R13: ffff8880751a4000 R14: 1ffff1100ea34805 R15: 0000000000000013
FS:  0000555556210300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bda9265e90 CR3: 000000001d27a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_inode_lookup+0xb66/0xd90 fs/gfs2/inode.c:173
 gfs2_lookup_by_inum+0x4d/0xe0 fs/gfs2/inode.c:241
 gfs2_get_dentry fs/gfs2/export.c:139 [inline]
 gfs2_fh_to_dentry+0x12d/0x1f0 fs/gfs2/export.c:162
 exportfs_decode_fh_raw+0x115/0x600 fs/exportfs/expfs.c:435
 exportfs_decode_fh+0x38/0x70 fs/exportfs/expfs.c:575
 do_handle_to_path fs/fhandle.c:152 [inline]
 handle_to_path fs/fhandle.c:207 [inline]
 do_handle_open+0x485/0x950 fs/fhandle.c:223
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f27f5ae1799
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd97d6fbf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f27f5ae1799
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007f27f5aa1030 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000124d6 R11: 0000000000000246 R12: 00007f27f5aa10c0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
