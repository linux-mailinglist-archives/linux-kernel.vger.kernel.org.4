Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F585606DB9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJUCZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJUCY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:24:59 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7DC57DFB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:24:41 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso1267134iob.20
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 19:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8z0FghAsBHnMdB7WGXgG8YDep4XEt+nnJJSIwCr3tZc=;
        b=VStT6PkBrn5gED8WWPPb6i9tFDAS9zjeukstM00+iP0DYuAo7wa5log9WOIat6DKX6
         GzGOE+XP7MOebvOJv8Y1HRz3X5+NEmKCX0NXfFB7n+5CQ4ltmQIhTen748e13NMZce1j
         8UKhposcq2X6wdfaxMwx9/K8eK9O9FjctRN9h1ZHjgWDWR1IsiLpAf4lqHvC/L+J9Bo/
         5+mQbK3tt26TvkvmtFJB+X3q7H+dXQsWU6UINdveYft6yHULwln3bIlNEkmyGWkWO5M1
         yhpFO3HiwOFtFmhuAiHCgNwFPg5fTnt0fPDeIVYtm4YuD0bk7oZXI+GooI3xuEAsolVP
         /mkg==
X-Gm-Message-State: ACrzQf1R5Slj7GHbUYAK8kHW4diRcUFNtigV6HLDSWK/0FA+wM+aP08i
        7udw1k5C2hTPexXHt9CESpgJEpbXLdTMdUh0nO3APyvv/HsZ
X-Google-Smtp-Source: AMsMyM65vtQwH2Ou10Smz/pqf6uyZTbbPhmQ4dwaoCP8DIXCxCygzHEHUCMEMYLnuZhuHbDhWOeZwREij2y54FFLprxcMkWkFVKX
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3285:b0:356:4df5:5d10 with SMTP id
 f5-20020a056638328500b003564df55d10mr13669104jav.19.1666319080824; Thu, 20
 Oct 2022 19:24:40 -0700 (PDT)
Date:   Thu, 20 Oct 2022 19:24:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e528a905eb822440@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in percpu_counter_add_batch
From:   syzbot <syzbot+96e659d35b9d6b541152@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, jiebin.sun@intel.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    aae703b02f92 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1686e478880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=883de36878e6d869
dashboard link: https://syzkaller.appspot.com/bug?extid=96e659d35b9d6b541152
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96e659d35b9d6b541152@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address ffff70000b978a00
KASAN: maybe wild-memory-access in range [0xffff80005cbc5000-0xffff80005cbc5007]
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000045dfb000
[ffff70000b978a00] pgd=00000000bfbeb003, p4d=00000000bfbeb003, pud=00000000bfbea003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 2820 Comm: kworker/0:3 Tainted: G        W          6.1.0-rc1-syzkaller-00025-gaae703b02f92 #0
Hardware name: linux,dummy-virt (DT)
Workqueue: events free_ipc
pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : percpu_counter_add_batch+0x78/0x2f0 lib/percpu_counter.c:87
lr : percpu_counter_add_batch+0x44/0x2f0 lib/percpu_counter.c:87
sp : ffff8000120979c0
x29: ffff8000120979c0 x28: ffff0000151ff800 x27: 1fffe00002a3ff24
x26: ffff80005cbc5000 x25: ffff00000eeac7b0 x24: 1fffe00001dd58f6
x23: 000000007fffffff x22: ffff80000cc4e800 x21: 0000000000000000
x20: 0000000000000000 x19: ffff00000eeac758 x18: ffff00006a9cbbc0
x17: 0000000000000000 x16: 0000000000000000 x15: ffff800008d9c830
x14: ffff800008d78ecc x13: ffff800008d752d4 x12: ffff600002a3ff01
x11: 1fffe00002a3ff00 x10: ffff600002a3ff00 x9 : dfff800000000000
x8 : ffff0000151ff800 x7 : 00000000f1f1f1f1 x6 : dfff800000000000
x5 : ffff700002412f32 x4 : 1ffff000020ef1ac x3 : 1ffff0000b978a00
x2 : dfff800000000000 x1 : 0000000000000003 x0 : ffff80005cbc5000
Call trace:
 percpu_counter_add_batch+0x78/0x2f0 lib/percpu_counter.c:87
 percpu_counter_add_local include/linux/percpu_counter.h:75 [inline]
 percpu_counter_sub_local include/linux/percpu_counter.h:225 [inline]
 freeque+0x20c/0x364 ipc/msg.c:292
 free_ipcs+0xa0/0x160 ipc/namespace.c:125
 msg_exit_ns+0x38/0x60 ipc/msg.c:1334
 free_ipc_ns ipc/namespace.c:138 [inline]
 free_ipc+0xd0/0x1c0 ipc/namespace.c:157
 process_one_work+0x780/0x184c kernel/workqueue.c:2289
 worker_thread+0x3cc/0xc40 kernel/workqueue.c:2436
 kthread+0x23c/0x2a0 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: f2fbffe2 92400801 d343fc03 11000c21 (38e26862) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	f2fbffe2 	movk	x2, #0xdfff, lsl #48
   4:	92400801 	and	x1, x0, #0x7
   8:	d343fc03 	lsr	x3, x0, #3
   c:	11000c21 	add	w1, w1, #0x3
* 10:	38e26862 	ldrsb	w2, [x3, x2] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
