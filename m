Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A1E6EC784
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjDXH6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXH6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:58:50 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCC111B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:58:48 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-32b532ee15bso157885965ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682323128; x=1684915128;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rS/fIEMWMpdB8AcMI+Y4zXjURKrKoFUpJdNl7oWNoq0=;
        b=eUcNcAdOqBigLumqaSePUBt29Q2HkSI7r4O9c3MCO/JSwM2Rz9da5wFQgtyje0Lkpk
         UWT2+CBxJVYDDcoJZkqVtG6OlkvzRUF/bV45lNe2YI7MCNkjSqedsKuP4/Fxj8vZU0fR
         hLytH7tLZ0r5ZKRX9SbCYorUHqQ85Zdbvz8na+FoWJSTPOPogHxePtroAQ4yvp5yzJsF
         KZvNIxaeF7lUVlvznBBFdAeNIcuhxS9coWQ2q00040ZjOFjzBQYI/AmlyBhufVNMc7Mi
         3WuMqCk0B2NL8RAwuJKxNHeRX+Fou+fsP7ZPBZhrWHFkskJZW0k+lpsSTTIlQkhcn0+U
         laqg==
X-Gm-Message-State: AAQBX9clCFMWbhLjjy0e2gHm0HPExR5Zg7YUwKflt8piiGb5yZhe42fA
        uhg8Y7yoIal1n3NE82QbKc6bIRIUJqhG52Q3snd85rVUvS8E
X-Google-Smtp-Source: AKy350YEezMEtjnIJb1UvONmy/IW2spEDeBjQyC9X5a40NbK6+Mh5r0gi+j/CbEjPEA4BImy6kZ7vhsIttNZf9qPzUSjJOSoa9oU
MIME-Version: 1.0
X-Received: by 2002:a92:d344:0:b0:32c:b806:d4a3 with SMTP id
 a4-20020a92d344000000b0032cb806d4a3mr4373088ilh.1.1682323128135; Mon, 24 Apr
 2023 00:58:48 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:58:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007337c705fa1060e2@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From:   syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
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

HEAD commit:    457391b03803 Linux 6.3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13226cf0280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c81c9a3d360ebcf
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6438dcb1c42d/disk-457391b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/20596c249e47/vmlinux-457391b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cb715366a3e5/bzImage-457391b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in generic_fillattr / shmem_mknod

read-write to 0xffff8881049a9408 of 8 bytes by task 3383 on cpu 0:
 shmem_mknod+0xdd/0x180 mm/shmem.c:2942
 shmem_create+0x34/0x40 mm/shmem.c:2994
 lookup_open fs/namei.c:3416 [inline]
 open_last_lookups fs/namei.c:3484 [inline]
 path_openat+0xd96/0x1d00 fs/namei.c:3712
 do_filp_open+0xf6/0x200 fs/namei.c:3742
 do_sys_openat2+0xb5/0x2a0 fs/open.c:1348
 do_sys_open fs/open.c:1364 [inline]
 __do_sys_openat fs/open.c:1380 [inline]
 __se_sys_openat fs/open.c:1375 [inline]
 __x64_sys_openat+0xf3/0x120 fs/open.c:1375
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff8881049a9408 of 8 bytes by task 4291 on cpu 1:
 i_size_read include/linux/fs.h:866 [inline]
 generic_fillattr+0x13f/0x1e0 fs/stat.c:58
 shmem_getattr+0x32a/0x3b0 mm/shmem.c:1068
 vfs_getattr_nosec+0x1e3/0x3c0 fs/stat.c:133
 vfs_getattr fs/stat.c:170 [inline]
 vfs_statx+0x156/0x300 fs/stat.c:242
 vfs_fstatat fs/stat.c:276 [inline]
 __do_sys_newfstatat fs/stat.c:446 [inline]
 __se_sys_newfstatat+0x8a/0x2a0 fs/stat.c:440
 __x64_sys_newfstatat+0x55/0x60 fs/stat.c:440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x0000000000001644 -> 0x0000000000001658

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 4291 Comm: udevd Not tainted 6.3.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
