Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847E46D3D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 08:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjDCGXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 02:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDCGXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 02:23:46 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553F6869B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 23:23:43 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id c6-20020a056e020bc600b00325da077351so18431323ilu.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 23:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680503022; x=1683095022;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oaZXQ2ba6Ab/wLxSXZqIahvgtFDIRKyVitfh3mF1ldQ=;
        b=d3JN85RXocsvkkYO5Z0PeUv3MZJ/VKRVYsFt8GDMFs9OWYwrfH3rI3Qc0A6Yq8W2eH
         FmiDBe1EAvtlxwVHKj2jJBlqzQmZXCpQoYa0DLfx9f3aDJGvGmb67l1+dP1nWQGG9Qyc
         Qo9swkwCjGXVTIpQXzY3VqgXY3PPF12/UIfQmYWbMmxca5ZQWpIrxdqpDX5+OYcZD2ns
         wq+0yGIgvoK2tDbB3/x+/Op7+we2BxEAxxsJl/U4LD58dYOjrHSc5Q3mU7low2HifFaT
         eUOZSE4EtnIwr6v7k76QhsSGKv+4qHpbTe5AaWO7UpnM59wWEtfKqpZmzFBcSFCQ708D
         XANA==
X-Gm-Message-State: AO0yUKWFSUv5NJOrnJMTEssH+WzlJ4rsUzcsDYsnBR6OPoOH+/HuCwVn
        Yansxm5ykVhygZ400JjjP4WGiK7l8JwKM5gi1Fub+d8NCLt7
X-Google-Smtp-Source: AK7set/IM3vxpgFqa2JS+aZBQG34XsIRHkYBLe0ciubaCRik6yDZsK3FV3jEVZEYuOP5AMu8AHqgs2vERfhvWA244nR59EkVQNuC
MIME-Version: 1.0
X-Received: by 2002:a6b:f010:0:b0:752:fa5a:6188 with SMTP id
 w16-20020a6bf010000000b00752fa5a6188mr12847137ioc.1.1680503022690; Sun, 02
 Apr 2023 23:23:42 -0700 (PDT)
Date:   Sun, 02 Apr 2023 23:23:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b62b5b05f8689972@google.com>
Subject: [syzbot] [fs?] KMSAN: kernel-infoleak in sys_name_to_handle_at (2)
From:   syzbot <syzbot+fbc7d315ac68168b2bd6@syzkaller.appspotmail.com>
To:     brauner@kernel.org, glider@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    90ea0df61c98 kmsan: add test_stackdepot_roundtrip
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=17f50711c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bfbc1ed9c2e8818f
dashboard link: https://syzkaller.appspot.com/bug?extid=fbc7d315ac68168b2bd6
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/904650d5b897/disk-90ea0df6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/421ab8e12064/vmlinux-90ea0df6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/170979c11e5a/bzImage-90ea0df6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fbc7d315ac68168b2bd6@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 256
=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xc0/0x100 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0xc0/0x100 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:169 [inline]
 do_sys_name_to_handle fs/fhandle.c:73 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:109 [inline]
 __se_sys_name_to_handle_at+0x7c8/0x910 fs/fhandle.c:93
 __ia32_sys_name_to_handle_at+0xe3/0x150 fs/fhandle.c:93
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:774
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x518/0x920 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 do_sys_name_to_handle fs/fhandle.c:40 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:109 [inline]
 __se_sys_name_to_handle_at+0x3a2/0x910 fs/fhandle.c:93
 __ia32_sys_name_to_handle_at+0xe3/0x150 fs/fhandle.c:93
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x37/0x80 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Bytes 18-19 of 20 are uninitialized
Memory access of size 20 starts at ffff88809f7ed5c0
Data copied to user address 0000000020000300

CPU: 1 PID: 6126 Comm: syz-executor.3 Not tainted 6.3.0-rc3-syzkaller-g90ea0df61c98 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
