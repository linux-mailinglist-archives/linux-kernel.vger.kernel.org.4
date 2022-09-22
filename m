Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626185E60E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiIVLZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiIVLZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:25:04 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646A690196;
        Thu, 22 Sep 2022 04:25:02 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id k9so4736888vke.4;
        Thu, 22 Sep 2022 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=T0fV8qfFVOymVMbtoHPkEwXSMdBSnP/O9E+2YF7ZczE=;
        b=pq3ZSRqBHHbmcBt2BYQyxoh5C+vdrw+Gw3qOlz6A1HViDG/aVfXlK8+MXnpBhets3A
         9vuCt38X9FBzZ/yr/o8VNg+X5BOFF/b+zR0zbAsQp1XpWK2dAUye3DTI+aALNCG3Zh1H
         vElSlYbcoQd7NYoAGKXOEgonTLWGiocEnbu/XeA/02WvnGthmC/iTnnFreGIexJr/9s/
         pF80Uq/sfDzmyfkkmzpeNiWvgJZkFBDiRh2iXsCogUAZI/rfbmzZVqxxdGWeFBQZjmaz
         +zHkEgqklkhopJcDFCUPk5bQ0wyf18hREcow4DWcrnDFKGyw3IEduEnWjKv8xt+rmTfM
         CPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=T0fV8qfFVOymVMbtoHPkEwXSMdBSnP/O9E+2YF7ZczE=;
        b=YJ2JBRnT8cFsrfFVEuOzuWjeP3hrvbsWHGIg5hWsF18wW1BoIpPoD2O4ssY6lkQZsO
         bheAmGqeWSpoRqN1jwwYlfhxwhe6/JkC1W6YA3IhsbTPnsfcjXQMyIKdAZA51XOLde1U
         sIe+LhUEvtnYcQ9I3Vk2bbNd8IfMgO5coBGieDTdYjZ/ydSGl0hVifE1FMes0eI3EzGk
         NHQ8PFUyxF5Ig94Js7bbnooNF1QKWqV0xWFpDIPY6BCPhSHpWG/acow4IJnBdLIMFLOl
         RZkYU0NB6eeUiEmIwx3q5jE9qvyz3X8yQGodhvSSxyqY4PBVr5LY6Dili1NDA7u824fY
         kSIQ==
X-Gm-Message-State: ACrzQf1pNc3t9u2vZ7KrNSeRTFX6ukOKWVP4v+20QthlPcc/p1ny/771
        H6LELd9sf2OU+LVTQoAngavOXCxM6gCiy1/WXqNCNMjQDZnGKFSfc58=
X-Google-Smtp-Source: AMsMyM6fDKSnkXD0qtULBSBnik+q17FtRPF3CHQ9CNV+a1C2X25oRZoJtCq+edxKrcYqUMzp669A4tBohRg9omdfNqQ=
X-Received: by 2002:a1f:90c9:0:b0:3a4:281f:62b8 with SMTP id
 s192-20020a1f90c9000000b003a4281f62b8mr405627vkd.24.1663845901502; Thu, 22
 Sep 2022 04:25:01 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Thu, 22 Sep 2022 19:24:50 +0800
Message-ID: <CAB7eex+TLOB1-dnUZ=ELwNQcj9+QN_JTZVyMmNYNvAUqrJkQZg@mail.gmail.com>
Subject: WARNING in dvb_frontend_get_event
To:     mchehab@kernel.org, kernel@tuxforce.de,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

When fuzzing the Linux kernel driver v6.0-rc6, the following crash was
triggered.

HEAD commit: 521a547ced6477c54b4b0cc206000406c221b4d6
git tree: upstream

kernel config: https://pastebin.com/raw/hekxU61F
console output: https://pastebin.com/raw/r045maxd

Sorry for failing to extract the reproducer. But on other versions of
Linux, I also triggered this crash.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:
------------[ cut here ]------------
do not call blocking ops when !TASK_RUNNING; state=1 set at
[<ffffffff815b0c88>] prepare_to_wait_event+0x68/0x680
kernel/sched/wait.c:329
WARNING: CPU: 0 PID: 20443 at kernel/sched/core.c:9815
__might_sleep+0x105/0x150 kernel/sched/core.c:9815
Modules linked in:
CPU: 0 PID: 20443 Comm: syz-executor.2 Not tainted 6.0.0-rc6+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__might_sleep+0x105/0x150 kernel/sched/core.c:9815
Code: 6f 02 00 48 8d bb c8 16 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00
75 34 48 8b 93 c8 16 00 00 48 c7 c7 60 22 cc 89 e8 ce 04 d5 07 <0f> 0b
e9 75 ff ff ff e8 3f 7d 76 00 e9 26 ff ff ff 89 34 24 e8 42
RSP: 0018:ffffc90003537ac8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888041fcd7c0 RCX: 0000000000000000
RDX: ffffc9000f67a000 RSI: ffff888041fcd7c0 RDI: fffff520006a6f4b
RBP: ffffffff89cc8840 R08: ffffffff816154d8 R09: 0000000000000000
R10: 0000000000000005 R11: ffffed1005984f2d R12: 000000000000003a
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888061936260
FS: 00007ff9a1382700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbdcc616000 CR3: 0000000052e2c000 CR4: 0000000000350ef0
Call Trace:
<TASK>
down+0x19/0x90 kernel/locking/semaphore.c:58
dvb_frontend_test_event drivers/media/dvb-core/dvb_frontend.c:277 [inline]
dvb_frontend_get_event.isra.0+0x523/0x670
drivers/media/dvb-core/dvb_frontend.c:301
dvb_frontend_handle_ioctl+0x1bf4/0x2f00
drivers/media/dvb-core/dvb_frontend.c:2715
dvb_frontend_do_ioctl+0x1c0/0x2e0 drivers/media/dvb-core/dvb_frontend.c:2089
dvb_usercopy+0xb9/0x270 drivers/media/dvb-core/dvbdev.c:941
dvb_frontend_ioctl+0x55/0x80 drivers/media/dvb-core/dvb_frontend.c:2103
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:870 [inline]
__se_sys_ioctl fs/ioctl.c:856 [inline]
__x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff9a0ca80fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff9a1381bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff9a0d9c410 RCX: 00007ff9a0ca80fd
RDX: 00000000200001c0 RSI: 0000000080286f4e RDI: 0000000000000003
RBP: 00007ff9a0d0b606 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc30899fcf R14: 00007ffc3089a170 R15: 00007ff9a1381d80
</TASK>
