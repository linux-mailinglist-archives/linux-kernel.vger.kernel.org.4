Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718A26EAEED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjDUQUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjDUQUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:20:46 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D253D2111
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:20:44 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7606d6bbc60so171599039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094044; x=1684686044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AGnzK40NDwWKAf2P8qQGz+Q1vBUuoeUsc6vFTLahuv8=;
        b=E2XElfFDJa6918OoFPfOVN91ETPqiJHZIKCOZlm+BrxfbdXQwO0ljCzcXS4b1F1jaf
         WZrIoeEOb3p8aJXhcxcL79e4EDBslQyY/4AANB0B3cHZ1kI0H8cTKg0MwP8J99DRIWMh
         aeJobx5pfFYnIKfeDGKqOQ1/Pja13ulGF4cBBXWmbJ9xmVXr+davF6tZbo5gZ8Y//Pal
         1aoI3sOqnEFwXXqqWPY0bzCkXgtIxRxlMLA1XLVjQK5SBO8uhPlWHuo33jpL7FEd9IDx
         DNqnwYopGw8KRe3E9XlaEGYPwmzLfDzIbru9WOnkWGtlRnGAQ1p3M/SVNEToTSHhkhet
         MYjA==
X-Gm-Message-State: AAQBX9dYapGU24PMBVhHcnXfD4YFW7XmMiuCsMF72+Ra6MBSy3xA9rMP
        T77OAj4crpPSu9wH6vqmoSHRED9qHCQ9JpffGP7W/HXizOVhplb69w==
X-Google-Smtp-Source: AKy350b+cuV/JkUBy1fggl7DCgKug3fDDRvUs7kpgXTGa2HQw/jy8vjuxXjnGR59xawE48yT+5CM0DWynxVEgFioeohKAzxAWtmE
MIME-Version: 1.0
X-Received: by 2002:a02:9547:0:b0:406:29c8:2d7c with SMTP id
 y65-20020a029547000000b0040629c82d7cmr2665412jah.5.1682094044171; Fri, 21 Apr
 2023 09:20:44 -0700 (PDT)
Date:   Fri, 21 Apr 2023 09:20:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb562705f9db0909@google.com>
Subject: [syzbot] [kernel?] kernel BUG in commit_creds (2)
From:   syzbot <syzbot+57f29dd5bfc4c89532f9@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6a8f57ae2eb0 Linux 6.3-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122152afc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4afb87f3ec27b7fd
dashboard link: https://syzkaller.appspot.com/bug?extid=57f29dd5bfc4c89532f9
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da19cc95d265/disk-6a8f57ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/508e5ccb6948/vmlinux-6a8f57ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aa14910af715/bzImage-6a8f57ae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+57f29dd5bfc4c89532f9@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at kernel/cred.c:456!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7314 Comm: iou-wrk-7310 Not tainted 6.3.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:commit_creds+0x11fc/0x1210 kernel/cred.c:456
Code: f9 ff ff 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c 99 f9 ff ff 48 8b 7c 24 18 e8 4e 60 83 00 e9 8a f9 ff ff e8 b4 9f 2d 00 <0f> 0b e8 ad 9f 2d 00 0f 0b e8 a6 9f 2d 00 0f 0b 0f 1f 40 00 f3 0f
RSP: 0018:ffffc90014fdf758 EFLAGS: 00010293
RAX: ffffffff815cd70c RBX: ffff88807e7cd7c0 RCX: ffff88807e7cd7c0
RDX: 0000000000000000 RSI: ffffffff8aea7d00 RDI: ffff888021df9500
RBP: ffff88807e7cdfb8 R08: dffffc0000000000 R09: fffffbfff1ca6946
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88807e7cdfb0
R13: dffffc0000000000 R14: ffff88801e3fdd00 R15: 1ffff11004dc6098
FS:  00007feb6d00b700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f795b584558 CR3: 000000001f493000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 smk_write_relabel_self+0x4d7/0x540 security/smack/smackfs.c:2798
 loop_rw_iter+0x35c/0x590
 io_write+0xebf/0x1340 io_uring/rw.c:923
 io_issue_sqe+0x2f0/0xb20 io_uring/io_uring.c:1907
 io_wq_submit_work+0x41a/0x800 io_uring/io_uring.c:1983
 io_worker_handle_work+0x817/0xd90 io_uring/io-wq.c:587
 io_wqe_worker+0x3d1/0xe00 io_uring/io-wq.c:632
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:commit_creds+0x11fc/0x1210 kernel/cred.c:456
Code: f9 ff ff 48 8b 4c 24 18 80 e1 07 80 c1 03 38 c1 0f 8c 99 f9 ff ff 48 8b 7c 24 18 e8 4e 60 83 00 e9 8a f9 ff ff e8 b4 9f 2d 00 <0f> 0b e8 ad 9f 2d 00 0f 0b e8 a6 9f 2d 00 0f 0b 0f 1f 40 00 f3 0f
RSP: 0018:ffffc90014fdf758 EFLAGS: 00010293
RAX: ffffffff815cd70c RBX: ffff88807e7cd7c0 RCX: ffff88807e7cd7c0
RDX: 0000000000000000 RSI: ffffffff8aea7d00 RDI: ffff888021df9500
RBP: ffff88807e7cdfb8 R08: dffffc0000000000 R09: fffffbfff1ca6946
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff88807e7cdfb0
R13: dffffc0000000000 R14: ffff88801e3fdd00 R15: 1ffff11004dc6098
FS:  00007feb6d00b700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31d21000 CR3: 000000001f493000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
