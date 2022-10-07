Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293675F79A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJGOUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJGOUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:20:42 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0663CBCB98
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:20:40 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id z4-20020a921a44000000b002f8da436b83so3898487ill.19
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 07:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P93AvNzX7xWtYgWFViNoiHNR6oJ154XiRau4RHqwpSg=;
        b=2C2bRQrQHqyB/wO+sRN0uka30onX0jioZS2zKnkaxjJj+V1ZGRGsjzJuDeq4+FbZbg
         ZaOL7vH9Tpp4eBRUCTI6aelm9R3Jbch+BUkX+xlGojBq24H4JbjQ2gIbnfZ2LvF7stkm
         Rnu4Dp0weVa+/AeQmtghzYYWdR2rHBqOR8EQT9f289DGhVIR3W6XSn/GDpByBQwRqtfC
         mIHpGOD6SGujN5XYGH2H1vYGd7BtQLCDWf9Pb52WuuHubvlAftucgFEim737kzvQwjpz
         BI7Hmx/A2eGeZaQTtJkXVl2PUfcDsvA2mkSP9x3uvpdYeKHRXt0gSYukP1a8EbvEECb4
         CeNA==
X-Gm-Message-State: ACrzQf25he0WxWeU3WsffJEvT2sZLLWcKIBMqNsCzig0BpSAXscr4Rco
        azIjCH7yK+VDxxU8qsmBEO9fN3qt06G+bZQ1CltWD6sDQLoU
X-Google-Smtp-Source: AMsMyM65eMOlIsu6ZWObVCjAkZM5EpOP47G2HGafvLAJ6O+Xv0t+REXonX86Hm1e6RxMkVbW18Q8OOvwYtFmtaJCRH2ZIQEB29Kq
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d83:b0:6a4:ea1e:3fe8 with SMTP id
 k3-20020a0566022d8300b006a4ea1e3fe8mr2440898iow.163.1665152439414; Fri, 07
 Oct 2022 07:20:39 -0700 (PDT)
Date:   Fri, 07 Oct 2022 07:20:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5fa2905ea7283f3@google.com>
Subject: [syzbot] WARNING: ODEBUG bug in usb_unbind_interface
From:   syzbot <syzbot+1dc86a35505aa14c1115@syzkaller.appspotmail.com>
To:     evgreen@chromium.org, gregkh@linuxfoundation.org,
        heghedus.razvan@gmail.com, jj251510319013@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        yuanjilin@cdjrlc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4fe89d07dcc2 Linux 6.0
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153e9148880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b8947ea4cc7fb5d
dashboard link: https://syzkaller.appspot.com/bug?extid=1dc86a35505aa14c1115
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/afc7f54b2a64/disk-4fe89d07.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e8dddd4401ab/vmlinux-4fe89d07.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1dc86a35505aa14c1115@syzkaller.appspotmail.com

usb 1-1: USB disconnect, device number 20
cdc_ncm 1-1:1.0 usb0: unregister 'cdc_ncm' usb-dummy_hcd.0-1, CDC NCM (NO ZLP)
------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: work_struct hint: usbnet_deferred_kevent+0x0/0xae0 drivers/net/usb/usbnet.c:1584
WARNING: CPU: 1 PID: 27 at lib/debugobjects.c:505 debug_print_object lib/debugobjects.c:502 [inline]
WARNING: CPU: 1 PID: 27 at lib/debugobjects.c:505 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
WARNING: CPU: 1 PID: 27 at lib/debugobjects.c:505 debug_check_no_obj_freed+0x46b/0x650 lib/debugobjects.c:1020
Modules linked in:
CPU: 1 PID: 27 Comm: kworker/1:1 Not tainted 6.0.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Workqueue: usb_hub_wq hub_event
RIP: 0010:debug_print_object lib/debugobjects.c:502 [inline]
RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
RIP: 0010:debug_check_no_obj_freed+0x46b/0x650 lib/debugobjects.c:1020
Code: 48 89 ef e8 47 32 a2 fd 48 8b 13 4c 8b 45 00 48 c7 c7 20 71 0a 8b 48 c7 c6 00 6e 0a 8b 44 89 f1 4d 89 f9 31 c0 e8 85 55 16 fd <0f> 0b 48 ba 00 00 00 00 00 fc ff df ff 05 9f cd ea 09 48 8b 5c 24
RSP: 0018:ffffc90000a2f0d8 EFLAGS: 00010246
RAX: 62d25ed28b046b00 RBX: ffffffff8b0a7198 RCX: 0000000000040000
RDX: ffffc90013401000 RSI: 0000000000014bfa RDI: 0000000000014bfb
RBP: ffffffff8aac8220 R08: ffffffff816d5a8d R09: ffffed10173667f1
R10: ffffed10173667f1 R11: 1ffff110173667f0 R12: ffff888091fa6c1c
R13: ffff888091fa6c28 R14: 0000000000000000 R15: ffffffff85fb5eb0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f462a01950 CR3: 0000000095603000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 slab_free_hook mm/slub.c:1734 [inline]
 slab_free_freelist_hook+0xcf/0x1a0 mm/slub.c:1785
 slab_free mm/slub.c:3539 [inline]
 kfree+0xda/0x210 mm/slub.c:4567
 device_release+0x98/0x1c0
 kobject_cleanup+0x235/0x470 lib/kobject.c:673
 usb_unbind_interface+0x1f2/0x860 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:550 [inline]
 __device_release_driver drivers/base/dd.c:1249 [inline]
 device_release_driver_internal+0x5bc/0x8a0 drivers/base/dd.c:1275
 bus_remove_device+0x2fd/0x410 drivers/base/bus.c:529
 device_del+0x6ec/0xbe0 drivers/base/core.c:3704
 usb_disable_device+0x3dd/0x820 drivers/usb/core/message.c:1419
 usb_disconnect+0x346/0x890 drivers/usb/core/hub.c:2235
 hub_port_connect+0x296/0x2930 drivers/usb/core/hub.c:5197
 hub_port_connect_change+0x619/0xbe0 drivers/usb/core/hub.c:5497
 port_event+0xec6/0x13b0 drivers/usb/core/hub.c:5653
 hub_event+0x5c1/0xd80 drivers/usb/core/hub.c:5735
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
