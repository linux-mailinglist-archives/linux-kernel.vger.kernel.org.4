Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787AE661EE3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 07:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjAIG6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 01:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjAIG6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:58:46 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C99562FA
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 22:58:45 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so5571552ilh.22
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 22:58:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T0sDTq2JREp0I2nGgOojTQd0cqOlGH4qHnE6WSC1FvU=;
        b=LAcdmkv7NaCJ+FxSxJM7TvtboN61H8L78RC+zO5rrgQ2BvuJ74qsiZjNDjffUK/X2N
         ImhtHQJ3wXBrTC9cefU2X1Eu8w+b8uCh2uW7KoDkBMRkJiga/HMl9kAHhG+H5DdTe+f1
         M6eBkU7C1DXtsWMmKD47HGeJbk/lDHlB4NfyOuvCueM792nd7IMuR8RQNb6MdUYMRhcm
         /BaSiYK0s+8mSICaxbo2fpt1+qaVZImV4bMvDnJRgFbdcr88oxkIhVv4mc7XP9d8n33t
         uVs0/9jQdXfCLBnP9HmXv8kGrxYqFnVgJl1GDv/Az8hMVxrzutmnXb5879kZJ2GG3Qs1
         FDsg==
X-Gm-Message-State: AFqh2kpjtqqKZU7ZgM9e6+Lv0Vhz6Fnopi6yqr6Hpt1GCgQxztgXsNMi
        P2ec6Ax/39ao96cvR7p0V8QdIWLEKkhnOPWyCn+6WLuUIKcG
X-Google-Smtp-Source: AMrXdXsu2mTlScMyTHkRT2m0IZAdv/KbR+YW0/zDCPVeyuhxOYIQlJGgQA0rU+ALskXAcITvO0f/0ZJusLuo8+h9V0Ji2VAtb3Ru
MIME-Version: 1.0
X-Received: by 2002:a92:d10f:0:b0:300:7a6d:c37c with SMTP id
 a15-20020a92d10f000000b003007a6dc37cmr5595518ilb.32.1673247524588; Sun, 08
 Jan 2023 22:58:44 -0800 (PST)
Date:   Sun, 08 Jan 2023 22:58:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053159f05f1cf4cad@google.com>
Subject: [syzbot] WARNING in mbind_range
From:   syzbot <syzbot+502859d610c661e56545@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    543b9b2fe10b Add linux-next specific files for 20230109
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1609b0ce480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ceb6f70a080e19c3
dashboard link: https://syzkaller.appspot.com/bug?extid=502859d610c661e56545
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/22f2428ec2eb/disk-543b9b2f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6003c7af47cc/vmlinux-543b9b2f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ac9a6ad60347/bzImage-543b9b2f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+502859d610c661e56545@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 30709 at mm/mempolicy.c:797 mbind_range+0x5d2/0x760 mm/mempolicy.c:797
Modules linked in:
CPU: 0 PID: 30709 Comm: syz-executor.3 Not tainted 6.2.0-rc3-next-20230109-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:mbind_range+0x5d2/0x760 mm/mempolicy.c:797
Code: 96 e8 f2 c7 b4 ff 4d 85 e4 74 8c e8 e8 c7 b4 ff 4c 89 e7 e8 10 7d ff ff e9 7a ff ff ff 45 31 f6 e9 72 ff ff ff e8 ce c7 b4 ff <0f> 0b 45 31 f6 e9 63 ff ff ff e8 bf ae 02 00 e9 6d fc ff ff 4c 89
RSP: 0018:ffffc90003ac7ca8 EFLAGS: 00010216
RAX: 000000000000022c RBX: ffff888075406c00 RCX: ffffc900146ed000
RDX: 0000000000040000 RSI: ffffffff81cce582 RDI: ffffc90003ac7d20
RBP: dffffc0000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000020c12000
R13: 0000000000000000 R14: 0000000020012000 R15: 0000000000000000
FS:  00007f0dd0398700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020319000 CR3: 00000000485d1000 CR4: 00000000003506e0
Call Trace:
 <TASK>
 do_mbind mm/mempolicy.c:1320 [inline]
 kernel_mbind+0x473/0x7c0 mm/mempolicy.c:1474
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0dcf68c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0dd0398168 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
RAX: ffffffffffffffda RBX: 00007f0dcf7abf80 RCX: 00007f0dcf68c0c9
RDX: 0000000000000000 RSI: 0000000000c00000 RDI: 0000000020012000
RBP: 00007f0dcf6e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdc142a6cf R14: 00007f0dd0398300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
