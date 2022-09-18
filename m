Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D95BBC1C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIRGNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 02:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRGNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 02:13:37 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83CB2558E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 23:13:35 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id e9-20020a6b7309000000b006a27af93e45so2236852ioh.9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 23:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=9gdl4dbmcDv+JqgHxREFdUmtszZUf796osg3y1YJ7is=;
        b=ifZoaTeC3E71sEWnYdfsbecro1snrNfSgsNzpaZA30RC1QfjsL2izbPBbH/niOuUIY
         nqTOvcWBA3U9iZR72lQUGF0wxfBuFUa+axX+ldj8mc1ncTc3Sn5xFAL4SMqTLzDeuemT
         EWzb9a19Z1fuRN5UdnJ8SieSm5sMRZXjFJhp1/N4lrwgm/f9h+Qy/NZKrB8jLkdbsxkn
         NZVoQaeO+oTYqVp5/vWm0KxmGKpn9QT2kbStSqPNSj7Vbcrj9kQzllt+iNg3Rm52NbJk
         82G1txSqQsc1gjAN2mcvF0+qlxDVnhBA3YNPk2WsvrmzQ31u4rWASt5WbrcygeiEdhrF
         hlug==
X-Gm-Message-State: ACrzQf3r6dCBwYGz5aODf0jO6jNDevLaDBwM3Y1tNr8X/wUuj0IcUjJM
        v1ib2dr+0MYNefVrXssAPIytRUT1janR6AZlkHaWmCkCvpIL
X-Google-Smtp-Source: AMsMyM65hrkxcYs02f8zJw7Xo+S6SQclxSL9w9c8JWJNgmbe+C935/q0VZPlHWZmPYnu0q9NP1BneOgOQcR9V1qBrMFfgpaYR4R+
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1546:b0:2f1:9280:9df8 with SMTP id
 j6-20020a056e02154600b002f192809df8mr5197743ilu.83.1663481615017; Sat, 17 Sep
 2022 23:13:35 -0700 (PDT)
Date:   Sat, 17 Sep 2022 23:13:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0ee8705e8ed7e7e@google.com>
Subject: [syzbot] BUG: corrupted list in kref_put
From:   syzbot <syzbot+e07ad07cb2283bc5bf57@syzkaller.appspotmail.com>
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

HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=104c56a0880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
dashboard link: https://syzkaller.appspot.com/bug?extid=e07ad07cb2283bc5bf57
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/81b491dd5861/disk-a6b44374.raw.xz
vmlinux: https://storage.googleapis.com/69c979cdc99a/vmlinux-a6b44374.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e07ad07cb2283bc5bf57@syzkaller.appspotmail.com

list_del corruption. prev->next should be ffff0000c953d4c8, but was 0000000000000000. (prev=ffff0000fc3536c8)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 44 Comm: kworker/u5:0 Not tainted 6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Workqueue: hci5 hci_error_reset
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0xbc/0xd0 lib/list_debug.c:59
lr : __list_del_entry_valid+0xbc/0xd0 lib/list_debug.c:59
sp : ffff80000f683b10
x29: ffff80000f683b10 x28: ffff80000d2bb000 x27: ffff0000c6e49c25
x26: 0000000000000000 x25: 0000000000000000 x24: ffff0000c0dec980
x23: ffff0000c0d93500 x22: ffff800009a56428 x21: ffff0000c0f30149
x20: ffff0000c953d4c0 x19: ffff0000c953d4d8 x18: 00000000000000c0
x17: 20747562202c3863 x16: ffff80000db78658 x15: ffff0000c0d93500
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c0d93500
x11: ff808000081c1fa0 x10: 0000000000000000 x9 : 74f127b5afecc300
x8 : 74f127b5afecc300 x7 : ffff8000081965e0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000100000001 x0 : 000000000000006d
Call trace:
 __list_del_entry_valid+0xbc/0xd0 lib/list_debug.c:59
 __list_del_entry include/linux/list.h:134 [inline]
 list_del include/linux/list.h:148 [inline]
 klist_release lib/klist.c:189 [inline]
 kref_put+0x6c/0x1d0 include/linux/kref.h:65
 klist_dec_and_del lib/klist.c:206 [inline]
 klist_put lib/klist.c:217 [inline]
 klist_del+0x58/0xb0 lib/klist.c:230
 device_del+0x280/0x5bc drivers/base/core.c:3699
 hci_conn_del_sysfs+0xb0/0xfc net/bluetooth/hci_sysfs.c:78
 hci_conn_cleanup+0x2d4/0x380 net/bluetooth/hci_conn.c:147
 hci_conn_del+0x144/0x2a8 net/bluetooth/hci_conn.c:1022
 hci_conn_hash_flush+0xe8/0x148 net/bluetooth/hci_conn.c:2367
 hci_dev_close_sync+0x48c/0x9e0 net/bluetooth/hci_sync.c:4476
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_error_reset+0xac/0x154 net/bluetooth/hci_core.c:1050
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
Code: d001b4a0 91365000 aa0803e3 94a7897a (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
