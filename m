Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA300637EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKXSYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXSYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:24:35 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7724DB5C43
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:24:34 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id q6-20020a056e020c2600b00302664fc72cso1544842ilg.14
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GiCsR6Blub8dAnK/MXT4xUyqZm1ylQDNXvyvsjlRQMY=;
        b=XhVAGgofQOsCvmadibRV8tYS/9Me3SK+hycD2tpDtmtChOHhjkphwxvsEerpzV6MWO
         8WQYN3vZudwX7az/7gpdnll+ZdM9WdYnjE0ydrMeCyWDLhBIImNSGhaXrl5vfLKhDmIT
         ZqzQjdumo/Rc1Z5C2gXHYqq7r/G4LgPTEq3rEei2CS9luD8lpe4cL7YNZexTh8sgVbKy
         EFkYEDc+MSl9YBaGPeY4yg6EhAZd6/6PpkLOT0arx2rd+BolzSZjWA3SBGSkE/pAGD30
         IxtpOjIMxt9tJ1SpG8bhILVEkK9c0d8gjc+e4XPUeT5U2tFW0p2NkNtZQUAZGr4RMXWI
         cU3A==
X-Gm-Message-State: ANoB5pleBRjuLu+tVMvS7y4TLfkiFdPOvF7yCrH41TG1yiNT4nymmX4W
        LZdS9iULVoE16EPPfi6VUteImMSSx1a/XnGAsD0ruTJ33NZi
X-Google-Smtp-Source: AA0mqf6Ufk8H/3k0OUmMHhiCgR+YJMyX0fmmw1TiC16M2O3qN8W0oCp49inyb/5cPqlaycZbXRs0fScyW5n/q2LwHvREHtPFxCTQ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1b08:b0:358:1594:9eb6 with SMTP id
 cb8-20020a0566381b0800b0035815949eb6mr1892867jab.236.1669314272490; Thu, 24
 Nov 2022 10:24:32 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:24:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003afb0305ee3b84f8@google.com>
Subject: [syzbot] WARNING in map_mft_record
From:   syzbot <syzbot+1a30e391e6703aa6a5a6@syzkaller.appspotmail.com>
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

HEAD commit:    77c51ba552a1 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1737f0e5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f9416d398342c83
dashboard link: https://syzkaller.appspot.com/bug?extid=1a30e391e6703aa6a5a6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a27a7d1ec024/disk-77c51ba5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e59c516a94e5/vmlinux-77c51ba5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26c4aae28027/bzImage-77c51ba5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1a30e391e6703aa6a5a6@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 29635 at kernel/locking/mutex.c:582 __mutex_lock_common+0x1bb0/0x26e0 kernel/locking/mutex.c:582
Modules linked in:
CPU: 0 PID: 29635 Comm: syz-executor.4 Not tainted 6.1.0-rc5-syzkaller-00326-g77c51ba552a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__mutex_lock_common+0x1bb0/0x26e0 kernel/locking/mutex.c:582
Code: 84 c0 0f 85 bd 08 00 00 83 3d 83 15 f9 03 00 0f 85 6f e5 ff ff 48 c7 c7 a0 98 ed 8a 48 c7 c6 20 99 ed 8a 31 c0 e8 40 81 b3 f6 <0f> 0b e9 53 e5 ff ff e8 a4 d5 61 f6 e9 5a fa ff ff 0f 0b e9 53 ef
RSP: 0018:ffffc9000cf8f7c0 EFLAGS: 00010246
RAX: de2c8b93a8915300 RBX: ffff888038b53b00 RCX: 0000000000040000
RDX: ffffc90006142000 RSI: 000000000001511b RDI: 000000000001511c
RBP: ffffc9000cf8f938 R08: ffffffff816e566d R09: ffffed1017304f1b
R10: ffffed1017304f1b R11: 1ffff11017304f1a R12: dffffc0000000000
R13: 1ffff920019f1f0c R14: 0000000000000000 R15: 0000000000000000
FS:  00007fae85b72700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0b82d7000 CR3: 000000007c25d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 map_mft_record+0x46/0x610 fs/ntfs/mft.c:154
 load_system_files+0x261b/0x4870 fs/ntfs/super.c:1855
 ntfs_fill_super+0x19a9/0x2bf0 fs/ntfs/super.c:2892
 mount_bdev+0x26c/0x3a0 fs/super.c:1401
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fae84e8cb6a
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae85b71f88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007fae84e8cb6a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fae85b71fe0
RBP: 00007fae85b72020 R08: 00007fae85b72020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007fae85b71fe0 R15: 0000000020077ea0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
