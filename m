Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EF46ECB66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjDXLdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDXLdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:33:47 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3CF35BD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:33:42 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-32addcf3a73so163956275ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 04:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682336021; x=1684928021;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SMJMgZAxqZGdGqU/PGc8+SWsoR2KrJ6Rhefs/d5RoY=;
        b=XUFNAYOjYFWW7TAqzko7ixCkzZk0xE/PGQ1pTNfuEJZ1rCa7OBkV8NQZBwVpAJVIwX
         UWVf6xkoMVjyHQucT+ryKf03bWy9gyJPn215E2aEWFafzr3ztsvAeScHw4lLMmWvkGsO
         HU7dUgD/dMBTmfSaMyTBZoKAMknygO9F1A/BFRUYZdLySxQ6H01NwQJ9w+5tpAEQrx4e
         Ejcz7mADwF9mvMxYZL12vV401zXIhvn1TZSC/2csOVk8nCdmCcdNkxBW1cMtuGdQiJhb
         gQ3O0tceA1u77AmxJgok+/Msy2a+maYv3zdjPCGGCDZ1FkstbxkFPAW0q0NvoCHcM7J1
         CT2g==
X-Gm-Message-State: AAQBX9eoQ8NA26QWIo2c5vMAGyx34hFZgVovTD+/Ylk+Y56E4a6GU8Gg
        X3NVU3DQMaXE5JB9rbkR5aoGDMml2hJxDtNT1y5wPsKG1ML8
X-Google-Smtp-Source: AKy350b7cUA5Ah1nSmU7N+Cnp+pc6T7TQVN7O+yoUh9SH2+oqsVvwgp6Y8Ms3LsUmdpTtdCJ/ZivtiKp+UaBdvHQ4QHUD5dQgoEo
MIME-Version: 1.0
X-Received: by 2002:a92:d690:0:b0:325:dae2:4238 with SMTP id
 p16-20020a92d690000000b00325dae24238mr4671443iln.2.1682336021553; Mon, 24 Apr
 2023 04:33:41 -0700 (PDT)
Date:   Mon, 24 Apr 2023 04:33:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5275205fa1360ee@google.com>
Subject: [syzbot] [mm?] kernel BUG in truncate_inode_partial_folio
From:   syzbot <syzbot+77184b5e843d90d56ec1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d3e1ee0e67e7 Add linux-next specific files for 20230421
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=132ceedbc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53c789efbcc06cf6
dashboard link: https://syzkaller.appspot.com/bug?extid=77184b5e843d90d56ec1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c558a9e1fe6a/disk-d3e1ee0e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ec100a34c4c/vmlinux-d3e1ee0e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1afcd9936dc1/bzImage-d3e1ee0e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77184b5e843d90d56ec1@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at include/linux/highmem.h:275!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6335 Comm: syz-executor.2 Not tainted 6.3.0-rc7-next-20230421-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:zero_user_segments include/linux/highmem.h:275 [inline]
RIP: 0010:folio_zero_range include/linux/highmem.h:507 [inline]
RIP: 0010:truncate_inode_partial_folio+0x2f1/0x750 mm/truncate.c:237
Code: 45 16 cf ff 8b 04 24 83 f8 3f 0f 87 a5 f4 4c 08 e8 14 1a cf ff 4c 89 ee 4c 89 f7 e8 c9 15 cf ff 4d 39 ee 76 07 e8 ff 19 cf ff <0f> 0b e8 f8 19 cf ff be 08 00 00 00 48 89 ef e8 6b ff 21 00 48 89
RSP: 0018:ffffc900038af6b8 EFLAGS: 00010216
RAX: 000000000003db56 RBX: 00000000fff9e000 RCX: ffffc90010241000
RDX: 0000000000040000 RSI: ffffffff81b4cb51 RDI: 0000000000000006
RBP: ffffea00024e0000 R08: 0000000000000006 R09: 00000000fff9e000
R10: 0000000000200000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000200000 R14: 00000000fff9e000 R15: 0000000000000009
FS:  00007fcf4ef5f700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3dcd3f21c0 CR3: 000000007736f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 shmem_undo_range+0xb82/0x1240 mm/shmem.c:1039
 shmem_truncate_range mm/shmem.c:1067 [inline]
 shmem_fallocate+0xb80/0xef0 mm/shmem.c:3061
 vfs_fallocate+0x48b/0xe40 fs/open.c:324
 madvise_remove mm/madvise.c:989 [inline]
 madvise_vma_behavior+0xa59/0x20a0 mm/madvise.c:1013
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1248
 do_madvise.part.0+0x287/0x5e0 mm/madvise.c:1428
 do_madvise mm/madvise.c:1441 [inline]
 __do_sys_madvise mm/madvise.c:1441 [inline]
 __se_sys_madvise mm/madvise.c:1439 [inline]
 __x64_sys_madvise+0x117/0x150 mm/madvise.c:1439
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcf4e28c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcf4ef5f168 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fcf4e3ac1f0 RCX: 00007fcf4e28c169
RDX: 0000000000000009 RSI: 0000000000200000 RDI: 000000002019e000
RBP: 00007fcf4e2e7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc789c175f R14: 00007fcf4ef5f300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:zero_user_segments include/linux/highmem.h:275 [inline]
RIP: 0010:folio_zero_range include/linux/highmem.h:507 [inline]
RIP: 0010:truncate_inode_partial_folio+0x2f1/0x750 mm/truncate.c:237
Code: 45 16 cf ff 8b 04 24 83 f8 3f 0f 87 a5 f4 4c 08 e8 14 1a cf ff 4c 89 ee 4c 89 f7 e8 c9 15 cf ff 4d 39 ee 76 07 e8 ff 19 cf ff <0f> 0b e8 f8 19 cf ff be 08 00 00 00 48 89 ef e8 6b ff 21 00 48 89
RSP: 0018:ffffc900038af6b8 EFLAGS: 00010216
RAX: 000000000003db56 RBX: 00000000fff9e000 RCX: ffffc90010241000
RDX: 0000000000040000 RSI: ffffffff81b4cb51 RDI: 0000000000000006
RBP: ffffea00024e0000 R08: 0000000000000006 R09: 00000000fff9e000
R10: 0000000000200000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000200000 R14: 00000000fff9e000 R15: 0000000000000009
FS:  00007fcf4ef5f700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b1f50ea70 CR3: 000000007736f000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
