Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8EB642442
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiLEIN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiLEINw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:13:52 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D7415FC9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:13:47 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id s1-20020a056e021a0100b003026adad6a9so11721460ild.18
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImatvGcoWVwWKPgUY4Fd3+jL0q2+fA/kMkw9Wu5gMPg=;
        b=XT+MLQZFQLM3mvho7EkY7t9ohAobJ6iuqLnZCzii5nc4IYtLhWP5UIev5ZnwXTNls/
         vi2i3lkJZiN7ovQGPlhtzuxqJ0BuWD9A+FXTd+fWpoyS1NOw3u1Iqs1HFnXhDxD6zVSu
         8NlvGCr9yFTa2o5zctj/8GTcTZkv2x25WaHaQMn1hikt8WQ7v0DbZ0D4ST8rBvIPNzAc
         xQfGw0N80LyBv2y3iVm3djg9Vp5nzZFynb6W3dpFvYkC1sC7VcoPhL0xe90gc1suYkU3
         WZItoU5a/1hNcxP2EcqftmFdbUvvNdn37/Zc3BtnFP3W/iiWNtIYcruY+PB/fulI6tCf
         OxSw==
X-Gm-Message-State: ANoB5pm+h6kKJjcYPzN+PXS8zwmZo10ETF8zrxj5yjWmCoL/qj4nkUd3
        EBgVDdgEqIgeHZPULFDmZ52js2kQDOfTYQopZpkFcEos+jF4
X-Google-Smtp-Source: AA0mqf5L5BHVyvsorkXfDnNcg4CzueQ/cJGqHTii+dZsAV03/iOj3UbOuRktoYNewj3DxhnTzNNJ1fAQvivRtihI/5pP3AC3w4uh
MIME-Version: 1.0
X-Received: by 2002:a5d:9745:0:b0:6df:5aa3:393c with SMTP id
 c5-20020a5d9745000000b006df5aa3393cmr20187316ioo.81.1670228026741; Mon, 05
 Dec 2022 00:13:46 -0800 (PST)
Date:   Mon, 05 Dec 2022 00:13:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a5c4905ef1044d6@google.com>
Subject: [syzbot] WARNING in get_vaddr_frames
From:   syzbot <syzbot+59a71007ccac79e8bb69@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com, tfiga@chromium.org
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

HEAD commit:    97ee9d1c1696 Merge tag 'block-6.1-2022-12-02' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ee14ad880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=59a71007ccac79e8bb69
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e4c55b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129047c3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/164011fb271c/disk-97ee9d1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46378a12aae7/vmlinux-97ee9d1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/72c541565fa3/bzImage-97ee9d1c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59a71007ccac79e8bb69@syzkaller.appspotmail.com

------------[ cut here ]------------
get_vaddr_frames() cannot follow VM_IO mapping
WARNING: CPU: 0 PID: 3635 at drivers/media/common/videobuf2/frame_vector.c:59 get_vaddr_frames drivers/media/common/videobuf2/frame_vector.c:59 [inline]
WARNING: CPU: 0 PID: 3635 at drivers/media/common/videobuf2/frame_vector.c:59 get_vaddr_frames+0x1f2/0x200 drivers/media/common/videobuf2/frame_vector.c:35
Modules linked in:
CPU: 0 PID: 3635 Comm: syz-executor248 Not tainted 6.1.0-rc7-syzkaller-00190-g97ee9d1c1696 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:get_vaddr_frames drivers/media/common/videobuf2/frame_vector.c:59 [inline]
RIP: 0010:get_vaddr_frames+0x1f2/0x200 drivers/media/common/videobuf2/frame_vector.c:35
Code: ae 4d fb e9 0b ff ff ff e8 bb ae 4d fb e9 d2 fe ff ff e8 c1 d5 00 fb 48 c7 c7 60 52 1b 8b c6 05 ee 29 bd 07 01 e8 fd c0 27 03 <0f> 0b e9 56 ff ff ff 0f 1f 80 00 00 00 00 41 57 41 56 41 55 41 54
RSP: 0018:ffffc90003c1f820 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88801ff1f000 RCX: 0000000000000000
RDX: ffff8880177f3a80 RSI: ffffffff8165749c RDI: fffff52000783ef6
RBP: ffff88801ff1f004 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 00000000fffffff2
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888073a41000
FS:  0000555556e79300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000002789f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vb2_create_framevec+0x59/0xd0 drivers/media/common/videobuf2/videobuf2-memops.c:50
 vb2_vmalloc_get_userptr+0x128/0x520 drivers/media/common/videobuf2/videobuf2-vmalloc.c:88
 __prepare_userptr+0x31e/0x1580 drivers/media/common/videobuf2/videobuf2-core.c:1159
 __buf_prepare+0x5e4/0x780 drivers/media/common/videobuf2/videobuf2-core.c:1401
 vb2_core_prepare_buf+0xe4/0x2c0 drivers/media/common/videobuf2/videobuf2-core.c:1540
 vb2_prepare_buf+0x103/0x170 drivers/media/common/videobuf2/videobuf2-v4l2.c:738
 v4l2_m2m_prepare_buf+0xe8/0x210 drivers/media/v4l2-core/v4l2-mem2mem.c:823
 v4l_prepare_buf drivers/media/v4l2-core/v4l2-ioctl.c:2148 [inline]
 v4l_prepare_buf+0x96/0xc0 drivers/media/v4l2-core/v4l2-ioctl.c:2142
 __video_do_ioctl+0xb9d/0xe20 drivers/media/v4l2-core/v4l2-ioctl.c:3037
 video_usercopy+0x3b8/0x17f0 drivers/media/v4l2-core/v4l2-ioctl.c:3384
 v4l2_ioctl+0x1b7/0x250 drivers/media/v4l2-core/v4l2-dev.c:364
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4abf6bcc49
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe26bf128 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4abf6bcc49
RDX: 0000000020000300 RSI: 00000000c058565d RDI: 0000000000000003
RBP: 00007f4abf680df0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4abf680e80
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
