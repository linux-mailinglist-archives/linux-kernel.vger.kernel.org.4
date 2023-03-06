Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1D6ACBBF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjCFR7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjCFR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:59:02 -0500
Received: from mail-il1-x147.google.com (mail-il1-x147.google.com [IPv6:2607:f8b0:4864:20::147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E11B6BDE8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:58:27 -0800 (PST)
Received: by mail-il1-x147.google.com with SMTP id z8-20020a92cd08000000b00317b27a795aso5660142iln.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 09:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125405;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tK9ZXC6YfZH4j9qfqbaIVRSqmEgs/PeD52exQAy10PA=;
        b=MHVIHR5x04s6zcKJRVT0fPzp8nTPwUuSwHtQ5Eha2IN7rqScbsKBOfLbE1x41F7i1S
         43zID+fF68QnkpF+nFT1erHbPdpXEczpAYYulSJmlae3PCvr3FYwwbMD3Q/JMLhOpwiD
         hJwwUK3RJFe8d7PMPItjRrNMaO8GlUQpAagh4PL0Qwl5BmVKnoWllJZt5/sO550Ay1lI
         bAxy/OqtpqxwnW/su/iPv3byN+KJix3KASw9KvsKyDbNQn9qF2PAhGft0h5bhxLqSa9S
         a3NL1PBK8II0pOVCK026ZMO4aP/UiNsTm2GJ4PNgNVimEdtV6xNdLEO3c99tTn5+piAy
         bM7w==
X-Gm-Message-State: AO0yUKV6YdZ8i/KY1yBoJH7JV6PbQMDMEj0v2Br+H4dAV+dLSp6XJDZI
        4G+jZbQguZmN1RysjYhjwVK2q+LzOUjHLNQc+CPmOtXC5OOG
X-Google-Smtp-Source: AK7set/nYocyn99uYw4qf7ESqyd6k8CfSeNtM+qG6Atp4m9fkBoQ/6k7ClZzYpGooR74eEgHPOMJedA2zaz9yZF3AYQVHTUO7q3J
MIME-Version: 1.0
X-Received: by 2002:a5e:d60c:0:b0:74d:13bc:e9e6 with SMTP id
 w12-20020a5ed60c000000b0074d13bce9e6mr5672924iom.3.1678125404894; Mon, 06 Mar
 2023 09:56:44 -0800 (PST)
Date:   Mon, 06 Mar 2023 09:56:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5bd2d05f63f04ae@google.com>
Subject: [syzbot] [nilfs?] KMSAN: kernel-infoleak in nilfs_ioctl_wrap_copy
From:   syzbot <syzbot+132fdd2f1e1805fdc591@syzkaller.appspotmail.com>
To:     glider@google.com, konishi.ryusuke@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    97e36f4aa06f Revert "sched/core: kmsan: do not instrument ..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=106829a8c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46c642641b9ef616
dashboard link: https://syzkaller.appspot.com/bug?extid=132fdd2f1e1805fdc591
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9931a9627dc6/disk-97e36f4a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1aafdb2fd6dc/vmlinux-97e36f4a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/90df5872c7ff/bzImage-97e36f4a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+132fdd2f1e1805fdc591@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xc0/0x100 lib/usercopy.c:33
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0xc0/0x100 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:169 [inline]
 nilfs_ioctl_wrap_copy+0x6fa/0xc10 fs/nilfs2/ioctl.c:99
 nilfs_ioctl_get_info fs/nilfs2/ioctl.c:1173 [inline]
 nilfs_ioctl+0x2402/0x4450 fs/nilfs2/ioctl.c:1290
 nilfs_compat_ioctl+0x1b8/0x200 fs/nilfs2/ioctl.c:1343
 __do_compat_sys_ioctl fs/ioctl.c:968 [inline]
 __se_compat_sys_ioctl+0x7dd/0x1000 fs/ioctl.c:910
 __ia32_compat_sys_ioctl+0x93/0xd0 fs/ioctl.c:910
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 __alloc_pages+0x9f6/0xe90 mm/page_alloc.c:5572
 alloc_pages+0xab0/0xd80 mm/mempolicy.c:2287
 __get_free_pages+0x34/0xc0 mm/page_alloc.c:5599
 nilfs_ioctl_wrap_copy+0x223/0xc10 fs/nilfs2/ioctl.c:74
 nilfs_ioctl_get_info fs/nilfs2/ioctl.c:1173 [inline]
 nilfs_ioctl+0x2402/0x4450 fs/nilfs2/ioctl.c:1290
 nilfs_compat_ioctl+0x1b8/0x200 fs/nilfs2/ioctl.c:1343
 __do_compat_sys_ioctl fs/ioctl.c:968 [inline]
 __se_compat_sys_ioctl+0x7dd/0x1000 fs/ioctl.c:910
 __ia32_compat_sys_ioctl+0x93/0xd0 fs/ioctl.c:910
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Bytes 16-127 of 3968 are uninitialized
Memory access of size 3968 starts at ffff888014534000
Data copied to user address 000000002000002f

CPU: 0 PID: 18968 Comm: syz-executor.0 Not tainted 6.2.0-syzkaller-81152-g97e36f4aa06f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
