Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188CB63A5A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiK1KEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiK1KEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:04:41 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F60110BD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:04:39 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id k11-20020a056e021a8b00b003030ec907c7so2443891ilv.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zkU8DKyT8h5uQbsxAZF6Th+TAqNYWVm8OMIsDSZWCoo=;
        b=iBWZOwUVFD1Wm4myz7eX6LlpZ7L4G8BeLyLj6xMMe8tPSrhZXvpuK75bLvr0VZ64GJ
         q+MsmMFEk44lRW/MpTyL4aJUMdoMQgShsNAR9RJmpMMF8K7A+mbxu38I5h6wnZcYQj5P
         DQSVitH6ZnFzZUj51s1HMgLoT78+wwG2txxEf4rq0M0MA6vVO/87fL463fRHRB54piRd
         Cn9/bQCmY9DYpn9GdTEy7rhAfJ/LS5vLMGwthIe9PRZ/eHlOiSe9Y2BwRwKPLXhpDteO
         5gIWifIaZcZpQLv90Xr3KE0EKCF38twjsdwBklQTjEB2MAD7PJbi/MzbKO83Qe9XHXLM
         nNFQ==
X-Gm-Message-State: ANoB5plvUFYYkOtE+hxRyWL7LCoraaHp9bNFKyEgfmccxC5Mkb2HGEhU
        vEj6BJ9fKdZf+xUPoR7K/FX7Df9Ru4cWmC8OsdbZjtm9vGZX
X-Google-Smtp-Source: AA0mqf7/JMFO/itGaijjg7p+PTEZcydslt3sHG0FopbTI3QI3qLt+xT7D2m2c5G9p+fU+Wi0v6dwzpYU+l4IrrmsNRPI2Uje9/y0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:505:b0:303:148c:692c with SMTP id
 d5-20020a056e02050500b00303148c692cmr1143004ils.114.1669629878863; Mon, 28
 Nov 2022 02:04:38 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:04:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d60fa905ee84ff8d@google.com>
Subject: [syzbot] KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
From:   syzbot <syzbot+c6d8e1bffb0970780d5c@syzkaller.appspotmail.com>
To:     glider@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a472f15b3d1e kmsan: allow using __msan_instrument_asm_stor..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14886381880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1429f86b132e6d40
dashboard link: https://syzkaller.appspot.com/bug?extid=c6d8e1bffb0970780d5c
compiler:       clang version 15.0.0 (https://github.com/llvm/llvm-project.git 610139d2d9ce6746b3c617fb3e2f7886272d26ff), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a8bf743ab4c3/disk-a472f15b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7248eae68bc7/vmlinux-a472f15b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e33e55592a5/bzImage-a472f15b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6d8e1bffb0970780d5c@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hfsplus_attr_bin_cmp_key+0xed/0x180 fs/hfsplus/attributes.c:42
 hfsplus_attr_bin_cmp_key+0xed/0x180 fs/hfsplus/attributes.c:42
 hfs_find_rec_by_key+0xac/0x240 fs/hfsplus/bfind.c:100
 __hfsplus_brec_find+0x27a/0x7d0 fs/hfsplus/bfind.c:135
 hfsplus_brec_find+0x46a/0x9d0 fs/hfsplus/bfind.c:195
 hfsplus_find_attr+0x308/0x380
 __hfsplus_getxattr+0x380/0xe50 fs/hfsplus/xattr.c:522
 hfsplus_getxattr+0x11f/0x1d0 fs/hfsplus/xattr.c:590
 hfsplus_security_getxattr+0x4f/0x60 fs/hfsplus/xattr_security.c:20
 __vfs_getxattr+0x699/0x6f0 fs/xattr.c:407
 cap_inode_need_killpriv+0x52/0xb0 security/commoncap.c:301
 security_inode_need_killpriv+0x8f/0x140 security/security.c:1422
 dentry_needs_remove_privs+0x1b4/0x3f0 fs/inode.c:1995
 do_truncate+0x11f/0x2d0 fs/open.c:57
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x4cf7/0x5600 fs/namei.c:3713
 do_filp_open+0x249/0x660 fs/namei.c:3740
 do_sys_openat2+0x1f0/0x910 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __ia32_sys_creat+0xed/0x160 fs/open.c:1396
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:742 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 __kmem_cache_alloc_node+0x6ee/0xc90 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0x11d/0x3c0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 hfsplus_find_init+0x8d/0x250 fs/hfsplus/bfind.c:21
 __hfsplus_getxattr+0x2d1/0xe50 fs/hfsplus/xattr.c:516
 hfsplus_getxattr+0x11f/0x1d0 fs/hfsplus/xattr.c:590
 hfsplus_security_getxattr+0x4f/0x60 fs/hfsplus/xattr_security.c:20
 __vfs_getxattr+0x699/0x6f0 fs/xattr.c:407
 cap_inode_need_killpriv+0x52/0xb0 security/commoncap.c:301
 security_inode_need_killpriv+0x8f/0x140 security/security.c:1422
 dentry_needs_remove_privs+0x1b4/0x3f0 fs/inode.c:1995
 do_truncate+0x11f/0x2d0 fs/open.c:57
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x4cf7/0x5600 fs/namei.c:3713
 do_filp_open+0x249/0x660 fs/namei.c:3740
 do_sys_openat2+0x1f0/0x910 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __ia32_sys_creat+0xed/0x160 fs/open.c:1396
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0xa2/0x100 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:246
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

CPU: 0 PID: 3846 Comm: syz-executor.3 Not tainted 6.1.0-rc6-syzkaller-63555-ga472f15b3d1e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
