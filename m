Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F244360241E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJRGEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJRGEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:04:48 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8384C2B613
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:04:46 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id m9-20020a056e021c2900b002fadb905ddcso11477563ilh.18
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 23:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntB9ov/k0haLRVm8l+offq3gPwk3Ri7xX5xK34NeQ14=;
        b=BC+JvgWaW3SyFDWa2irD5jmGybvrzB85NY1D7Bd7+Aw0kfyt/kAqU0BhGmGIzJP/8l
         LFoi8Q1sSpN6UPr0aNYTt4EAg5Qx13XrnwrXsx1EnfMKZ4x2/U6XyZpjruLu4EYGJC6h
         D3DsRPwvmvVmt3JaIOAJBkjI4KtopzmkF4q4/6R9iTWKg8VZ1SE8MMvSNA+3aPr6WUVV
         B9Cj6wD/oJGGVxsm1zbw4EOkJr+ExmTutKjVQ3sO95Y/SGPaGjnvsyl/rNbqwxDPWB/j
         X+ZdZlq0bAKoA+Hlug8gDuersaYUpyQLegUygO3NN1pKMeRS5s5/+r6kq2eSItaL8e+9
         SLZg==
X-Gm-Message-State: ACrzQf14MPcAdyG5WqhTtKqfCvaRrsgsckgYLy+lAM+1TwnIHC7/hrGv
        pHAKS5Xng22L+MHhzy62AlYt2s5HEQsg8gC9DLj9hzJpOL4a
X-Google-Smtp-Source: AMsMyM7j4Z1zkqgUXIa1+J6nd7sasSFQwPgjo1E5tJCRZIYXqgCAU5KElp0l7ox1Yti4cvyjNZyTUjr1nCLk+zlqnpKa1HSemo7q
MIME-Version: 1.0
X-Received: by 2002:a6b:b887:0:b0:6bb:fc82:d94b with SMTP id
 i129-20020a6bb887000000b006bbfc82d94bmr864495iof.205.1666073085848; Mon, 17
 Oct 2022 23:04:45 -0700 (PDT)
Date:   Mon, 17 Oct 2022 23:04:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073b6d905eb48de3f@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in reiserfs_find_entry
From:   syzbot <syzbot+4654552e088ed458b10d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14e8a2c2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c29b6436e994d72e
dashboard link: https://syzkaller.appspot.com/bug?extid=4654552e088ed458b10d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c8f5131ab57d/disk-55be6084.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/77167f226f35/vmlinux-55be6084.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4654552e088ed458b10d@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 793df067 P4D 793df067 PUD 7601a067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 25700 Comm: syz-executor.4 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003c0f158 EFLAGS: 00010246
RAX: 1ffff11010973c1b RBX: ffff888084b9e0d8 RCX: 0000000000040000
RDX: ffffc9000c01a000 RSI: 0000000000000005 RDI: ffff88801f59f098
RBP: ffffc90003c0f2f0 R08: 0000000000000005 R09: ffffffff8222326d
R10: 0000000000000003 R11: ffff888023308000 R12: ffff888083088678
R13: dffffc0000000000 R14: ffff888037621c10 R15: 0000000000000005
FS:  00007feebdc43700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000036ec7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 get_third_component fs/reiserfs/namei.c:196 [inline]
 reiserfs_find_entry+0x253/0x1a10 fs/reiserfs/namei.c:317
 reiserfs_lookup+0x1e3/0x4a0 fs/reiserfs/namei.c:368
 __lookup_slow+0x286/0x3e0 fs/namei.c:1685
 lookup_slow fs/namei.c:1702 [inline]
 lookup_one_unlocked+0x3f8/0x670 fs/namei.c:2772
 ovl_lookup_positive_unlocked fs/overlayfs/namei.c:207 [inline]
 ovl_lookup_single+0x11f/0xa60 fs/overlayfs/namei.c:233
 ovl_lookup_layer+0x44e/0x540 fs/overlayfs/namei.c:320
 ovl_lookup+0xb09/0x2470 fs/overlayfs/namei.c:923
 __lookup_hash+0x115/0x240 fs/namei.c:1601
 do_renameat2+0x58b/0x1400 fs/namei.c:4850
 __do_sys_rename fs/namei.c:4953 [inline]
 __se_sys_rename fs/namei.c:4951 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:4951
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7feebca8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feebdc43168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007feebcbabf80 RCX: 00007feebca8b5a9
RDX: 0000000000000000 RSI: 0000000020000800 RDI: 00000000200007c0
RBP: 00007feebcae6580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff2dc3b58f R14: 00007feebdc43300 R15: 0000000000022000
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc90003c0f158 EFLAGS: 00010246
RAX: 1ffff11010973c1b RBX: ffff888084b9e0d8 RCX: 0000000000040000
RDX: ffffc9000c01a000 RSI: 0000000000000005 RDI: ffff88801f59f098
RBP: ffffc90003c0f2f0 R08: 0000000000000005 R09: ffffffff8222326d
R10: 0000000000000003 R11: ffff888023308000 R12: ffff888083088678
R13: dffffc0000000000 R14: ffff888037621c10 R15: 0000000000000005
FS:  00007feebdc43700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000036ec7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
