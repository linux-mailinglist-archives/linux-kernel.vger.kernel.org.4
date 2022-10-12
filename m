Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F6B5FC0DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJLGop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJLGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:44:42 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543AC65DE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:44:40 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s2-20020a056e02216200b002f9de38e484so12659804ilv.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/cEeMnxUyYtlzGNdJb4eRNAIE0sJPI54U1V6FnSsoY=;
        b=viuOOfxrgyFrKgLtzr+m+yELgPqRisocTvljR6o9bLQj7opuqNv3MWZ9ZeZ9xcsCPY
         EQfqp92vcEyHqI96N8xay3Ju/5FskDapmj1VRvMUMz4dhIl6Nd6AS0XM1LvdAz06DH0Z
         fmJ5ixEP1PyWL28IKdjQljHqdDZtps1AD7FECZM5SXUwUKxrnkpC78ntECeFFDlJ3Dix
         CcnfhsXdLcS5aYK8kEzbWeMfL8vKimxC+ydidF88xDIm5HlLoJpH1ey4I8FD41LWTXdo
         nXABoEbrtywNyDiv535b3Co0jPe+khRUX0czTmx1GIL6FREfKRdY73Q96MouK4XVSjHj
         6lsQ==
X-Gm-Message-State: ACrzQf2nJs3JyUJyv9cFHU+kaqlYKA9MYqJ012X/aROIAMqAVHk/c4no
        Eb7/ouekOqE6d7XZVAtNQa9nuY5xgzJDUIuzrsBnX4UHkuP2
X-Google-Smtp-Source: AMsMyM5mQjiP8MqSAgNvpIhJgd0zb3FsAWqVQ5iaq8KGovxqDBZKVfQ9+qDM4JcqcW72D+ejNEgYfNVbV2zi8BqK/nNYulKAuEPy
MIME-Version: 1.0
X-Received: by 2002:a02:a510:0:b0:363:7345:2f5f with SMTP id
 e16-20020a02a510000000b0036373452f5fmr13720641jam.314.1665557079729; Tue, 11
 Oct 2022 23:44:39 -0700 (PDT)
Date:   Tue, 11 Oct 2022 23:44:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000172d9905ead0babe@google.com>
Subject: [syzbot] kernel BUG in ntfs_prepare_pages_for_non_resident_write
From:   syzbot <syzbot+64f73ab552d413b202e2@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
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

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162a0194880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=64f73ab552d413b202e2
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64f73ab552d413b202e2@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/ntfs/file.c:951!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 26428 Comm: syz-executor.4 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:ntfs_prepare_pages_for_non_resident_write+0x72c1/0x7700 fs/ntfs/file.c:951
Code: 8a e8 23 5b 08 ff 0f 0b e8 dc 44 cc fe 0f 0b e8 d5 44 cc fe 4c 89 f7 48 c7 c6 c0 66 c5 8a e8 06 5b 08 ff 0f 0b e8 bf 44 cc fe <0f> 0b e8 b8 44 cc fe 0f 0b 83 fb e4 0f 85 1f 04 00 00 e8 a8 44 cc
RSP: 0018:ffffc900047ff680 EFLAGS: 00010293
RAX: ffffffff82ba3c91 RBX: 0000000000001000 RCX: ffff888022639d80
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000000001000
RBP: ffffc900047ff970 R08: ffffffff82b9eb44 R09: ffffffff82b9eab1
R10: 0000000000000002 R11: ffff888022639d80 R12: ffff88807cbcf830
R13: 0000000000000000 R14: 1ffff1100f979f06 R15: ffff88807f537a28
FS:  00007f829496f700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f829492cfc0 CR3: 0000000072b4c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_perform_write fs/ntfs/file.c:1844 [inline]
 ntfs_file_write_iter+0x1938/0x2d40 fs/ntfs/file.c:1917
 do_iter_write+0x6c2/0xc20 fs/read_write.c:861
 vfs_writev fs/read_write.c:934 [inline]
 do_pwritev+0x200/0x350 fs/read_write.c:1031
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f829388b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f829496f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f82939ac050 RCX: 00007f829388b5a9
RDX: 0000000000000001 RSI: 0000000020003380 RDI: 0000000000000003
RBP: 00007f82938e6580 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc7b4af7cf R14: 00007f829496f300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_prepare_pages_for_non_resident_write+0x72c1/0x7700 fs/ntfs/file.c:951
Code: 8a e8 23 5b 08 ff 0f 0b e8 dc 44 cc fe 0f 0b e8 d5 44 cc fe 4c 89 f7 48 c7 c6 c0 66 c5 8a e8 06 5b 08 ff 0f 0b e8 bf 44 cc fe <0f> 0b e8 b8 44 cc fe 0f 0b 83 fb e4 0f 85 1f 04 00 00 e8 a8 44 cc
RSP: 0018:ffffc900047ff680 EFLAGS: 00010293
RAX: ffffffff82ba3c91 RBX: 0000000000001000 RCX: ffff888022639d80
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000000001000
RBP: ffffc900047ff970 R08: ffffffff82b9eb44 R09: ffffffff82b9eab1
R10: 0000000000000002 R11: ffff888022639d80 R12: ffff88807cbcf830
R13: 0000000000000000 R14: 1ffff1100f979f06 R15: ffff88807f537a28
FS:  00007f829496f700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbfa8981998 CR3: 0000000072b4c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
