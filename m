Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F028666F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjALK3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbjALK2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:28:01 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FB4DF38
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:25:40 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id h24-20020a056e021d9800b0030be8a5dd68so13071511ila.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 02:25:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kw4ldf34KKwQJFbqI8sJn48aCZGzATF3l5fLGibU/RM=;
        b=zDnWKyI5AqVI4MLmxQHFQmQod1zcGXaGkzL+huqEQkfkFR+aObuGPJDzLdXeZflA0X
         BtNYiQBj9uo7Az6vH7sef2t/GveRHfpPN09WXSoY+/S1spoMi5LGaWZUDF7vYwVDe7mD
         03U7lnzKAUtPp8hzRWBRPA3alEa10QXMeVX/nUQCXDb89rK3sBTlCdzdzlGBoWhMapUq
         Ysu+WADq5X8Didw7psSD9oUbwYr+iWGBfmjwKQLf8jyI1qpxWPSbAvLSajD2KteeSny4
         NM+wmPyNfT6E0m+hUEcPe55vqoOdrxkXlHp/rANVYAN+38/7TY54GA1wPP/N7f2pVNq3
         OeJg==
X-Gm-Message-State: AFqh2koZKMSZVVlU8SDPnAmMUt2rq6vb0uGWk3mOtPtGirZjq7ff4QcL
        32SOTlYSHxKF618EnwzHY59BrH1ppg8Hz5syosZuAndIaFXV
X-Google-Smtp-Source: AMrXdXtYV4/OEOs9KND78/jPEaBxMhtuwzseWgl+eWin9zEmgeb0+6TYyJB4nSSXlhbLvU0mCQVU4zKfh/T6ujAneNYc9et1wq7u
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11aa:b0:30e:d531:a2e with SMTP id
 10-20020a056e0211aa00b0030ed5310a2emr55189ilj.318.1673519139759; Thu, 12 Jan
 2023 02:25:39 -0800 (PST)
Date:   Thu, 12 Jan 2023 02:25:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9ae1305f20e89bd@google.com>
Subject: [syzbot] [tmpfs?] kernel BUG in folio_flags
From:   syzbot <syzbot+fa6f2ee9039b87ef86c4@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c67c5e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=fa6f2ee9039b87ef86c4
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fa6f2ee9039b87ef86c4@syzkaller.appspotmail.com

 dentry_kill fs/dcache.c:745 [inline]
 dput+0x6ac/0xe10 fs/dcache.c:913
 __fput+0x3cc/0xa90 fs/file_table.c:329
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xb17/0x2a90 kernel/exit.c:867
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 get_signal+0x225f/0x24f0 kernel/signal.c:2859
------------[ cut here ]------------
kernel BUG at include/linux/page-flags.h:317!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 10782 Comm: syz-executor.1 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:folio_flags.constprop.0+0x122/0x150 include/linux/page-flags.h:317
Code: 52 ff ff ff e8 ff f2 cd ff 48 8d 43 ff 49 39 c4 0f 84 40 ff ff ff e8 ed f2 cd ff 48 c7 c6 40 0b 57 8a 4c 89 e7 e8 2e e4 05 00 <0f> 0b e8 57 c2 1b 00 e9 fe fe ff ff e8 4d c2 1b 00 eb a9 4c 89 e7
RSP: 0018:ffffc90005437b00 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc90014e22000
RDX: 0000000000040000 RSI: ffffffff81b3ca02 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000b28100
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffffd400016502c
FS:  00007f1e422fd700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005642ce910130 CR3: 000000001cef4000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 folio_test_head include/linux/page-flags.h:780 [inline]
 folio_test_large include/linux/page-flags.h:801 [inline]
 folio_nr_pages include/linux/mm.h:1735 [inline]
 compound_nr include/linux/mm.h:1747 [inline]
 zero_user_segments.constprop.0+0x262/0x350 include/linux/highmem.h:288
 shmem_write_end+0x684/0x780 mm/shmem.c:2600
 generic_perform_write+0x316/0x570 mm/filemap.c:3783
 __generic_file_write_iter+0x2ae/0x500 mm/filemap.c:3900
 generic_file_write_iter+0xe3/0x350 mm/filemap.c:3932
 call_write_iter include/linux/fs.h:1852 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9ed/0xe10 fs/read_write.c:584
 ksys_write+0x12b/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1e4168c0c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1e422fd168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f1e417abf80 RCX: 00007f1e4168c0c9
RDX: 0000000000000004 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007f1e416e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc7e6ac66f R14: 00007f1e422fd300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folio_flags.constprop.0+0x122/0x150 include/linux/page-flags.h:317
Code: 52 ff ff ff e8 ff f2 cd ff 48 8d 43 ff 49 39 c4 0f 84 40 ff ff ff e8 ed f2 cd ff 48 c7 c6 40 0b 57 8a 4c 89 e7 e8 2e e4 05 00 <0f> 0b e8 57 c2 1b 00 e9 fe fe ff ff e8 4d c2 1b 00 eb a9 4c 89 e7
RSP: 0018:ffffc90005437b00 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc90014e22000
RDX: 0000000000040000 RSI: ffffffff81b3ca02 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000b28100
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffffd400016502c
FS:  00007f1e422fd700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005642ce910130 CR3: 000000001cef4000 CR4: 00000000003506e0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
