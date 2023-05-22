Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EEE70CBF1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbjEVVGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjEVVGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:06:06 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2CD9D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:06:04 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3382b8b357aso528825ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684789564; x=1687381564;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLNW8RUeV1ytOiHOrZ5VF3AFlqsNVobO/I7Gz9UWEkc=;
        b=Rmk9OiYtih0tKkkkN4TgVPh0MVmeTdYlsKHLFBWCmEmA7XQF9nV7n3W675I3NdoiRi
         Hd2e4ucjokJp3MHbmBR2DcUMHaBK53fTUs9R20HoA7MzwgA/cDW4c73Kj7JBgHSwx0VT
         10Bqjq1Pkh2aytrIW+i5XMW0s/jenR8Sq4WlJYLQVxcdMjiBWhTYCQti3N52YqWucV/i
         wHWNRlBpKMAxqkKcnh3OUSDpcueKGxTrE6VfxjVs1r54tZP3WC69PBr8qQOWVDAX8mZk
         vhbzqT4hhfztUjyQOnwcqwLmTDGjUN0HFJJ9dWMOhZFaX4jpz1lkhM2+U507bm8hov9n
         3hEw==
X-Gm-Message-State: AC+VfDx4rskwSwcsFN3fIGOuHlTOGXy7b4f5/97yVVRFNo6l3Bw3OtBP
        SNFs1Ns+FjTiLk7nb9Oykr12tBAK9MHxJT7S00n11n57Q9+m
X-Google-Smtp-Source: ACHHUZ5Ew0z7LmUWGcfvyMiI4Iuu9t5wCenKIe7OhFXWmTqZnghnDpVrBn+FezGc/jEfaT3nEJrp0MkHfq9QdKzlTMuUGXhfDEDV
MIME-Version: 1.0
X-Received: by 2002:a92:d6cf:0:b0:338:c5c6:91f9 with SMTP id
 z15-20020a92d6cf000000b00338c5c691f9mr4847639ilp.1.1684789564206; Mon, 22 May
 2023 14:06:04 -0700 (PDT)
Date:   Mon, 22 May 2023 14:06:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ef71705fc4ea3ad@google.com>
Subject: [syzbot] [usb?] WARNING in corrupted (3)
From:   syzbot <syzbot+27b0b464864741b18b99@syzkaller.appspotmail.com>
To:     duoming@zju.edu.cn, hverkuil-cisco@xs4all.nl,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4d6d4c7f541d Merge tag 'linux-kselftest-fixes-6.4-rc3' of ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a9a641280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac0db1213414a978
dashboard link: https://syzkaller.appspot.com/bug?extid=27b0b464864741b18b99
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bc26ee280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17684629280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ebfde1c1eecf/disk-4d6d4c7f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4938c9109cd4/vmlinux-4d6d4c7f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8c31ee617052/bzImage-4d6d4c7f.xz

The issue was bisected to:

commit ebad8e731c1c06adf04621d6fd327b860c0861b5
Author: Duoming Zhou <duoming@zju.edu.cn>
Date:   Mon Jan 23 02:04:38 2023 +0000

    media: usb: siano: Fix use after free bugs caused by do_submit_urb

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16584629280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15584629280000
console output: https://syzkaller.appspot.com/x/log.txt?x=11584629280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27b0b464864741b18b99@syzkaller.appspotmail.com
Fixes: ebad8e731c1c ("media: usb: siano: Fix use after free bugs caused by do_submit_urb")

usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1: Product: syz
usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: config 0 descriptor??
smsusb:smsusb_probe: board id=7, interface number 0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 897 at kernel/workqueue.c:3182 __flush_work+0x946/0xb60 kernel/workqueue.c:3182
Modules linked in:
CPU: 0 PID: 897 Comm: kworker/0:2 Not tainted 6.4.0-rc2-syzkaller-00018-g4d6d4c7f541d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:__flush_work+0x946/0xb60 kernel/workqueue.c:3182
Code: 00 48 c7 c6 9b f7 53 81 48 c7 c7 40 90 79 8c e8 d0 ec 11 00 e9 6f fc ff ff e8 06 4b 30 00 0f 0b e9 63 fc ff ff e8 fa 4a 30 00 <0f> 0b 45 31 ed e9 54 fc ff ff e8 5b 12 83 00 e9 3e fb ff ff e8 e1
RSP: 0018:ffffc90005026c08 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88801f5e20e8 RCX: 0000000000000000
RDX: ffff88801f431dc0 RSI: ffffffff8153f7d6 RDI: 0000000000000001
RBP: ffffc90005026da0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff81d6e1f2 R12: ffff88801f5e20e8
R13: 0000000000000001 R14: 0000000000000001 R15: ffff88801f5e2100
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560d76a382c8 CR3: 0000000026f34000 CR4: 0000000000350ef0
Call Trace:
 <TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
