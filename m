Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8300063867C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiKYJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiKYJox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:44:53 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCCC3AC2F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:44:46 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id i8-20020a056e0212c800b00302578e6d78so2610361ilm.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kn5J0PDBpydiWw4C/8UfIOnIQ57GtBd5BpTMRXaXG98=;
        b=UmjWbtjKoT3OQEYDdoimLvCos/H8IITbwTLv4cpf0p4/ZwBNOA8g3/FXrwxR9YSvCA
         Z4t/3rD+Z3AXyeGNOp0xKBB3sWg1ybJwCVxtuP9Anv1PXAFSePvhyQbyUq1PaGy2cSPp
         QgUOI0XwQNbBZWT9qU7P0Sn5zSTR+20XH6g+DQeKoi4Vs4KhF07kpg+DWtaTvTdMAnPA
         asXIbguXn+f1oHK2f+2tA4mbfDaj6pXBAdDGtKyldDobpSGAlYJFRcfvb8Fo6xIHqDWX
         EJW4wcwvnOlF7x2ysJZGdZkK044SQKmx9VXMBFSWM8GYSkkUxbgzRLi7F73KeptgqqwH
         yQCQ==
X-Gm-Message-State: ANoB5pmEijei9zYWH3gyKOTGBl4n7Id0cbvsnsD9Zr/c/T2GfPZ5bqkL
        2R7IwczKfyk7Ld5J6PlJr7xwR52CmAtGcfRAULxQaQI8Upsx
X-Google-Smtp-Source: AA0mqf5c9tfej0Zb0v9T4Pibq6Op5mFJ4lFlaUWbe3XbLoU/+EiaM8f4ZcxugGEi6AHflH0ycfZ2y0mLRTCSX5AgWVNvL1WgdCvq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f52:b0:302:b44f:a09 with SMTP id
 y18-20020a056e020f5200b00302b44f0a09mr9744698ilj.227.1669369486205; Fri, 25
 Nov 2022 01:44:46 -0800 (PST)
Date:   Fri, 25 Nov 2022 01:44:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000396ded05ee485f93@google.com>
Subject: [syzbot] BUG: corrupted list in remove_nodes
From:   syzbot <syzbot+9cb68ebbbe46dc73843e@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    9500fc6e9e60 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10bf96b5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b25c9f218686dd5e
dashboard link: https://syzkaller.appspot.com/bug?extid=9cb68ebbbe46dc73843e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1363e60652f7/disk-9500fc6e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fcc4da811bb6/vmlinux-9500fc6e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b554298f1fa/Image-9500fc6e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9cb68ebbbe46dc73843e@syzkaller.appspotmail.com

list_del corruption. next->prev should be ffff0000c9d7ea00, but was 0000000000000000. (next=ffff0000cc0a8d00)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:64!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 8731 Comm: syz-executor.4 Not tainted 6.1.0-rc5-syzkaller-32269-g9500fc6e9e60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0xcc/0xd0 lib/list_debug.c:62
lr : __list_del_entry_valid+0xcc/0xd0 lib/list_debug.c:62
sp : ffff8000153a3990
x29: ffff8000153a3990 x28: ffff0000cc0a8d00 x27: ffff800009a8825c
x26: ffff800009a88240 x25: ffff0000cc0a8d00 x24: ffff0000c6bb5ec0
x23: ffff0000c9d7ea00 x22: 0000000000000000 x21: ffff0000fa4e1730
x20: ffff8000153a3a08 x19: 0000000000000000 x18: 00000000000000c0
x17: 20747562202c3030 x16: ffff80000dc18158 x15: ffff000102341a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff000102341a40
x11: ff808000081c6510 x10: 0000000000000000 x9 : 31ba0981391d2e00
x8 : 31ba0981391d2e00 x7 : ffff80000c0b2b74 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcc8 x1 : 0000000100000001 x0 : 000000000000006d
Call trace:
 __list_del_entry_valid+0xcc/0xd0 lib/list_debug.c:62
 __list_del_entry include/linux/list.h:134 [inline]
 list_move_tail include/linux/list.h:229 [inline]
 remove_nodes+0xbc/0x2d0 drivers/base/devres.c:455
 devres_release_all+0x80/0x194 drivers/base/devres.c:529
 device_release+0x28/0xe0 drivers/base/core.c:2321
 kobject_cleanup+0xe8/0x280 lib/kobject.c:673
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x94/0xf8 lib/kobject.c:721
 put_device+0x28/0x40 drivers/base/core.c:3624
 hci_free_dev+0x24/0x34 net/bluetooth/hci_core.c:2560
 vhci_release+0x4c/0x80 drivers/bluetooth/hci_vhci.c:569
 __fput+0x198/0x3e4 fs/file_table.c:320
 ____fput+0x20/0x30 fs/file_table.c:348
 task_work_run+0x100/0x148 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x2dc/0xcac kernel/exit.c:820
 do_group_exit+0x98/0xcc kernel/exit.c:950
 get_signal+0xabc/0xb2c kernel/signal.c:2858
 do_signal+0x128/0x438 arch/arm64/kernel/signal.c:1071
 do_notify_resume+0xc0/0x1f0 arch/arm64/kernel/signal.c:1124
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 asm_exit_to_user_mode+0x70/0x84 arch/arm64/kernel/entry-common.c:149
 ret_from_fork+0x1c/0x20 arch/arm64/kernel/entry.S:866
Code: d4210000 f001b780 912e0800 94aa876b (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
