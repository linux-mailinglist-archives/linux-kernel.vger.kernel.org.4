Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A65BACB0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiIPLrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiIPLrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:47:05 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F57695F;
        Fri, 16 Sep 2022 04:47:04 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a14so7770185uat.13;
        Fri, 16 Sep 2022 04:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=q87N2sosyMl//BaDbFeDlKHLhYa172AV0fEmU4MQXNA=;
        b=RuriKtQiSUmbZwhq743As0Y0Z6gGL7xY8v8a7vcZNTqDVSccpvhRZTJKhK0oEPXfaJ
         v/+WFz/fIoYzanZjTsxiVINUDBhGwTwprqWjgf1gVvR/hrdy+MTNmFSNKx1gDbxxUQsg
         5UEdqNelFbgCl5TWy9JxzNlat3Gu4a7nICUbpRMILU/7ZygH7vCDFkL+G29BjlN5L8bp
         +xb0wSCaWthK0yFBLLwNyAQipAfrosAmk4FHEVRwoby2T4Xj69XD7vTwJKyRXCAVAQPN
         NSZe1sas4mn0AiqhVhJZV1TqfK5sp/cFyxUdgHh/gwBZ9EB0rwDvlHGwJMZoiWuPVSvr
         d5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=q87N2sosyMl//BaDbFeDlKHLhYa172AV0fEmU4MQXNA=;
        b=HfmvJjObY5HDWbnMeDGhvvpcNcB8o13OhuTUsrvlpFTrAnMk7+dpDwsBWxqQBiD+SC
         Y5NvPPodzFwMdd3ugGTzdzxA8kgiwApha91++Amd1QbgSfPPDDKnrPHka2Dik3M/2gEV
         6M6rROgC6eagPJRqpg67SzQFzrNnulNsDLNiU2UiQ4OcUFDQNVRF5O2f0FgT+lhz57Vu
         xe08981Z50L0xGSOhO8+Nu2jB5XGMq4KjXqFRFrLJD11AtqESFSJusCacbl2pv29QOgy
         RzOvP75d6MAuVCGYm7COcyaDW/ako5/+tIGYju1RZKGnm8VaKTCR24AvuTg9gI7ViTIb
         arcQ==
X-Gm-Message-State: ACrzQf23+OXoV7qfGXKmGdxbNLprSNfBJGd4Rqida0FnW7VJP0ImVxky
        1rFqVgRMh8vk//Pi/PG1QggoPvcwZByTwlFBQDEBENFKV+ly7w==
X-Google-Smtp-Source: AMsMyM5YqZ/oXZ8odGWmoAleEiJ75oNIo/dxa76lcRun7/s3KpZB7+zO1yn4kgpBs8KVUC3l6tH7oZaskJFoQpChDcQ=
X-Received: by 2002:ab0:32d1:0:b0:3ab:7f86:2121 with SMTP id
 f17-20020ab032d1000000b003ab7f862121mr1721297uao.86.1663328823247; Fri, 16
 Sep 2022 04:47:03 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Fri, 16 Sep 2022 19:46:52 +0800
Message-ID: <CAB7eexKMDKDke=q5hsUONyuw5JLdR3eikKiSC4x90h3PSb86WA@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in holtek_kbd_input_event
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
triggered.

HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
git tree: upstream

kernel config: https://pastebin.com/raw/xtrgsXP3
console output: https://pastebin.com/raw/nHbNncrF

Basically,  we use the gadget module to emulate
attaching a USB device and executing some simple sequence of system calls.

Sorry I do not have c reproducer for this bug, but I would so
appreciate it if you have any idea how to solve this bug.

The crash report is as follows:

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 4519d067 P4D 4519d067 PUD 4650c067 PMD 0
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 13073 Comm: syz-executor.0 Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9001a6d7c60 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff88803c455a00 RCX: 0000000000000080
RDX: 0000000000000001 RSI: 0000000000000014 RDI: ffff88803c455a00
RBP: 0000000000000014 R08: ffffffff86d5d39a R09: 0000000000000000
R10: 0000000000000004 R11: fffffbfff1ac6947 R12: 0000000000000001
R13: 0000000000000080 R14: 0000000000000080 R15: 0000000000000003
FS:  00007f02dfa7e700(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001082e2000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 holtek_kbd_input_event+0x14e/0x1c0 drivers/hid/hid-holtek-kbd.c:136
 input_event_dispose+0x81/0x5e0 drivers/input/input.c:351
 input_handle_event+0x203/0xdc0 drivers/input/input.c:402
 input_inject_event+0x1c4/0x320 drivers/input/input.c:461
 evdev_do_ioctl drivers/input/evdev.c:1072 [inline]
 evdev_ioctl_handler+0x724/0x1af0 drivers/input/evdev.c:1272
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f02df2a80fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f02dfa7dbf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f02df39c340 RCX: 00007f02df2a80fd
RDX: 00000000200001c0 RSI: 0000000040084503 RDI: 0000000000000006
RBP: 00007f02df30b606 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd773bc70f R14: 00007ffd773bc8b0 R15: 00007f02dfa7dd80
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9001a6d7c60 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: ffff88803c455a00 RCX: 0000000000000080
RDX: 0000000000000001 RSI: 0000000000000014 RDI: ffff88803c455a00
RBP: 0000000000000014 R08: ffffffff86d5d39a R09: 0000000000000000
R10: 0000000000000004 R11: fffffbfff1ac6947 R12: 0000000000000001
R13: 0000000000000080 R14: 0000000000000080 R15: 0000000000000003
FS:  00007f02dfa7e700(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000001082e2000 CR4: 0000000000350ee0
