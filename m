Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68066EC7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjDXIKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjDXIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:10:45 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C2110E7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:10:44 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-32b532ee15bso158253735ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 01:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682323844; x=1684915844;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4Thap/qwRVufaop68eOVJQ7fBEi7/5eZ9UQ8PDKIuY=;
        b=Xl8QcYnwHocCYS0v5doYWEEsr90DEY7zZdSLjM4EU4gJUHn8p2r4ABZf+MTW4pG9ZY
         5hMIRoEaj8tV/UieKd6lIF6LxWguYaEgR7csbqMaODxhHAmOy2/3l0ArKkFj/tjS+Cfj
         BuKi8Y/Ai5PvB9v2waKuMXDMu/RU65B0Q4v+GpLoL3K3onyn+rNu7t9YjfKhreZOVApA
         x5hURcnoxAhRP9itWOfVzATLeQcUnmhWgEeA54ZvBnu+IlRb01CSJ4nXa+Jw9wTFiHE1
         RdVKjN1NgH2DWuXZCV/ibLykIugtMoo3kn5+MdWkjl0CvFCsfhrpjR+oObv5QJGWoM5R
         59mQ==
X-Gm-Message-State: AAQBX9ftv6M1PO00QbQD8S9Oq1G9tCCT0IAX4fj3Z0akjK944Rygxa4x
        UfDGRwIIJDJHI7glbL+qDSj1o/669RBNP48zbqwqVRYoR/qX
X-Google-Smtp-Source: AKy350Z7uv951DiaYOSOQ6JIDidOJwfg3OH4lG/yAU0fMxWugT/qADoXQM8wXDBFMvFrmYgSbXbcVALiJIvmy79KV1Jzkw7cu+cV
MIME-Version: 1.0
X-Received: by 2002:a92:cda9:0:b0:329:719b:4875 with SMTP id
 g9-20020a92cda9000000b00329719b4875mr5766978ild.2.1682323843952; Mon, 24 Apr
 2023 01:10:43 -0700 (PDT)
Date:   Mon, 24 Apr 2023 01:10:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001db82205fa108b35@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_unlink (3)
From:   syzbot <syzbot+f682b67a78ce05867e78@syzkaller.appspotmail.com>
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

HEAD commit:    cb0856346a60 Merge tag 'mm-hotfixes-stable-2023-04-19-16-3..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b9e8bfc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
dashboard link: https://syzkaller.appspot.com/bug?extid=f682b67a78ce05867e78
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a02dd7789fb2/disk-cb085634.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a1a1eac454f6/vmlinux-cb085634.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb0447014913/bzImage-cb085634.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f682b67a78ce05867e78@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in generic_fillattr / shmem_unlink

read-write to 0xffff888104d167b8 of 8 bytes by task 23887 on cpu 1:
 shmem_unlink+0x102/0x190 mm/shmem.c:3036
 vfs_unlink+0x261/0x3e0 fs/namei.c:4250
 do_unlinkat+0x266/0x4f0 fs/namei.c:4316
 __do_sys_unlink fs/namei.c:4364 [inline]
 __se_sys_unlink fs/namei.c:4362 [inline]
 __x64_sys_unlink+0x30/0x40 fs/namei.c:4362
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888104d167b8 of 8 bytes by task 27823 on cpu 0:
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

value changed: 0x00000000000000c8 -> 0x00000000000000b4

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 27823 Comm: udevd Not tainted 6.3.0-rc7-syzkaller-00089-gcb0856346a60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
