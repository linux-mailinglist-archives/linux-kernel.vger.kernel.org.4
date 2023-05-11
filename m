Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C4C6FFC00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 23:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbjEKVl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 17:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbjEKVlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 17:41:22 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593A7A88
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:41:12 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-76c56492fa0so594708639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 14:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683841271; x=1686433271;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTjs854kFVrlK1WSSeijLY6ud+VzKqMJvGStYdeesmI=;
        b=VBsqGyxc1qQpmnZYGsJQhPjgkVbn8IdJuiBZntFh/11sXmPcpCUv59lSBC1CONhtic
         Ry4GVy4nZ0o4V0kz4FyBGUIP3wQl07fG/ro0n/Yayq2vO2n0Sxb/Vxq9H269PwNdhhQ2
         XY8bjvEXeFnVWawX4NYZr9bRdxsO4wmmgEld49Bvvpb4bP6CePpawXa+yc6yn/dzA7A2
         zDVQeZ/P97bqiXfaYGh6+lW1//9phRqyNuAWhPHpXlYNv+qJVHqDizp+Im/goXkiUTrg
         bwrcnJ2KzXchJ7VtaJc7U8ZOAt9TrvjHMKlTCPwtmQeKBz9cP/TL+YJFFN5DO9JfbQfF
         ABTg==
X-Gm-Message-State: AC+VfDwPyJJ57oSRiYqlCTMgeQnmtx9+3DD9hO6HALk7MfX/OgWHdzh+
        JBQz+vS0LOLMUQNDPH70EbXSo7Ja/+WPCQsaIr2LouWzjI34mIE=
X-Google-Smtp-Source: ACHHUZ6nnx+mi6qhXdpqrGFmwFkIe6x57Fg1CvOAQfV7U6lhmTOJQT3H8OTuNHcoqBMbZS/bRl7E3AaWPLzFsp3PkdocVf6hJTjR
MIME-Version: 1.0
X-Received: by 2002:a02:860e:0:b0:40f:7382:e4aa with SMTP id
 e14-20020a02860e000000b0040f7382e4aamr5792489jai.2.1683841271335; Thu, 11 May
 2023 14:41:11 -0700 (PDT)
Date:   Thu, 11 May 2023 14:41:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6168c05fb71d816@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in update_sd_lb_stats
From:   syzbot <syzbot+cfb5d190e457dc724e57@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac9a78681b92 Linux 6.4-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1160fb12280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc86fee67199911d
dashboard link: https://syzkaller.appspot.com/bug?extid=cfb5d190e457dc724e57
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/c35b5b2731d2/non_bootable_disk-ac9a7868.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c04bec59d77d/vmlinux-ac9a7868.xz
kernel image: https://storage.googleapis.com/syzbot-assets/070113b307f3/zImage-ac9a7868.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cfb5d190e457dc724e57@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000004 when read
[00000004] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 206 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 15 Comm: rcu_preempt Not tainted 6.4.0-rc1-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at update_sd_lb_stats.constprop.0+0/0
LR is at update_sd_lb_stats.constprop.0+0/0
pc : [<8028aa74>]    lr : [<8028a8ec>]    psr: a0000193
sp : df855ba8  ip : df855c0c  fp : df855c3c
r10: ffff8e76  r9 : df855d34  r8 : 830b4640
r7 : 8309a800  r6 : ddddb400  r5 : df855bdc  r4 : 00000000
r3 : 00000000  r2 : fffffff0  r1 : 00000000  r0 : df855bdc
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 80003000  DAC: 00000000
Register r0 information: non-paged memory
Register r1 information:
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 000001ff when read
[000001ff] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 206 [#2] PREEMPT SMP ARM
Modules linked in:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
