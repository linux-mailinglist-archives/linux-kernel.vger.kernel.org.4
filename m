Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A7E68CF6E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjBGGYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBGGX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:23:58 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C35FEB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:23:57 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so9920821ilj.14
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 22:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOQi11Ec8g69gVZc/TZnzKhiY2Aonnj64kR8RrBBUAQ=;
        b=I0Ku+EPg36r3b5I/EWdNTrFmqHxdk150AcX3RNFcntIzbkA6F1fBuz9q5dcmjdcmpB
         LLrNnWi49VNoR2wip6j5BA4kpI0hO95htLx8Keh8Dnl12CftJ3noos5ac7TDVKYd1mv7
         8hej51knEmFmnU/6gL5O7uVFZW3wteWyjLesxuBHg2yK8p1iuA6ZmDUxGdWYXk6qG4ku
         o0DR+S5lgfkTXc1XPtAbk5m4hgnv0wn6K4EGhxk1HwFKoysWXGc4+uLVmPR44o6KSRSX
         El/jXUaDEuNhgv2m9+wcEGAOUDtK+HFMZ2Xg6IMXBQE5tbHUpMJgNuIJsMa8mHnDEUbp
         hCmw==
X-Gm-Message-State: AO0yUKVDY+Rs+Hr/wZs7FpAOKXkQNJVTFXuy9AR5mQkO9Ixe9/omUar6
        iXVGsYVWuCX5oliHWuqK5maJvKxi19fqtyu/ldDUOgD5mmnq
X-Google-Smtp-Source: AK7set8uT9ar1/CJ2JJfpGXEF+tDP7F7c/TQY1kYfnqGKVIk/VpqtyF0VUB6Ra6jRctjcxFwXWb/TLHf2vm3kx5xrYOfb+WFiOeT
MIME-Version: 1.0
X-Received: by 2002:a92:cdac:0:b0:313:e345:6340 with SMTP id
 g12-20020a92cdac000000b00313e3456340mr702593ild.118.1675751037010; Mon, 06
 Feb 2023 22:23:57 -0800 (PST)
Date:   Mon, 06 Feb 2023 22:23:56 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b0d5205f41631be@google.com>
Subject: [syzbot] WARNING in is_valid_gup_args
From:   syzbot <syzbot+1f0c9407f4d20f7488b9@syzkaller.appspotmail.com>
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

HEAD commit:    49a8133221c7 Add linux-next specific files for 20230207
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15016013480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3691b32dd4410e01
dashboard link: https://syzkaller.appspot.com/bug?extid=1f0c9407f4d20f7488b9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6277c699d71e/disk-49a81332.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbef27c2f238/vmlinux-49a81332.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c0c68d93ac8/bzImage-49a81332.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f0c9407f4d20f7488b9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 11452 at mm/gup.c:2121 is_valid_gup_args+0x1d8/0x230 mm/gup.c:2121
Modules linked in:
CPU: 1 PID: 11452 Comm: syz-executor.0 Not tainted 6.2.0-rc7-next-20230207-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
RIP: 0010:is_valid_gup_args+0x1d8/0x230 mm/gup.c:2121
Code: c7 ff 48 83 3c 24 00 0f 85 7a ff ff ff e8 10 3a c7 ff 0f 0b 45 31 e4 eb cd e8 04 3a c7 ff 0f 0b 45 31 e4 eb c1 e8 f8 39 c7 ff <0f> 0b 45 31 e4 eb b5 e8 ec 39 c7 ff 0f 0b 45 31 e4 eb a9 e8 e0 39
RSP: 0018:ffffc900091f72c0 EFLAGS: 00010212
RAX: 000000000000165e RBX: 0000000000040000 RCX: ffffc90003dc1000
RDX: 0000000000040000 RSI: ffffffff81bd3248 RDI: 0000000000000005
RBP: ffffc900091f7320 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000040000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000040000 R15: 0000000000040000
FS:  00007f31c3ca4700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31624000 CR3: 0000000027a30000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 pin_user_pages_fast+0x83/0x100 mm/gup.c:3089
 iov_iter_extract_user_pages lib/iov_iter.c:2160 [inline]
 iov_iter_extract_pages+0x2b9/0x1e20 lib/iov_iter.c:2229
 __bio_iov_iter_get_pages block/bio.c:1267 [inline]
 bio_iov_iter_get_pages block/bio.c:1340 [inline]
 bio_iov_iter_get_pages+0x354/0x1580 block/bio.c:1327
 iomap_dio_bio_iter+0x830/0x1440 fs/iomap/direct-io.c:323
 iomap_dio_iter fs/iomap/direct-io.c:436 [inline]
 __iomap_dio_rw+0xd81/0x1d80 fs/iomap/direct-io.c:594
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:682
 ext4_dio_write_iter fs/ext4/file.c:587 [inline]
 ext4_file_write_iter+0x1053/0x1710 fs/ext4/file.c:698
 call_write_iter include/linux/fs.h:1851 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_writev+0x1aa/0x670 fs/read_write.c:934
 do_pwritev+0x1b6/0x270 fs/read_write.c:1031
 __do_sys_pwritev2 fs/read_write.c:1090 [inline]
 __se_sys_pwritev2 fs/read_write.c:1081 [inline]
 __x64_sys_pwritev2+0xef/0x150 fs/read_write.c:1081
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f31c2e8c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f31c3ca4168 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007f31c2fabf80 RCX: 00007f31c2e8c0c9
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000003
RBP: 00007f31c2ee7ae9 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000001400 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff54ef18ef R14: 00007f31c3ca4300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
