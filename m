Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC83A5E7DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiIWPMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiIWPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:12:13 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B781397FC;
        Fri, 23 Sep 2022 08:12:10 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id q26so221816vsr.7;
        Fri, 23 Sep 2022 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=zHGyfSmNvc3wB4LiKUCDLTcpSsX1c2bBxmkLn5/IPrQ=;
        b=edEgxGDkDEqXMKU56qOXfRRGXvRIjrZvczCzsEysaFrZFJmxsqzpZXdb5I80JBgUtH
         o8fqfqga6yV0JqH+3oWmJFt8+Zld/gXwrhXkiYNLaYZc2i+80igpatpsdnVQ4X4H9mzh
         HJfvhxouHTZWasaQfS7syjAl4/LLy+j25qvIATh3xpACcbb8sGIrSQNNgUzPz9kAKsF9
         nWWEdU97LF6buoq8raOUzWWeLDESGs3UZDw2zRK/mOAMMAljWtSiJo+VRqE9inBf/GFq
         MjAYilJPS2tXnMrIL7oVO12QY0V6RageEj4AcPqZSfUJUcc9djKffy2WfL87ejHxQoPb
         JuKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=zHGyfSmNvc3wB4LiKUCDLTcpSsX1c2bBxmkLn5/IPrQ=;
        b=E38UWRiVXk7BNSe5OPejom7TfvRlelWF81uiZrqbOSDy7uAHU7LmBm7BH28KA+K2QF
         PCUyR3nihmDkyY9WXNA0iUEPdsyCYuzfbLa6yRdaxpZKoo9pb6kl8pGLnSG7IUkXcdkr
         osI9Dv5BN4zTQX+iwd3ha3SfP13u0bUHyvlyH0OSae9yJh3k5pRq+bOpfIttueWxvRu/
         CEwJjPNAx1S/3dWRNSNLwTlJ4kNQ0m5xVuCd43fILmu+uF24mZEfbgYwLwa98uosh1WG
         gpSCFvFJ8Pk9p8ZmQaLvo2PPjnOUGzcufhyKd4dkYpmE1G8rt52DSFPu6os9x0v+8ckd
         sJFQ==
X-Gm-Message-State: ACrzQf2UrH9V5z452hTiEIgNElsxzcgc08bZQilW1UUtKVPljv0oVg1n
        q6PV9p4r+RXtjHRIxJ7mQlHnlaYsrsWj3TIj7Pu3hPD8J8KRW5ke
X-Google-Smtp-Source: AMsMyM71tErENRXaW1xnaUB82c9pS6a8qIMPDF/G1JMES474bSdgnfUtrl/U3t08dcHnsZPk9Sgxl8FPTR5koTwrGr0=
X-Received: by 2002:a67:d793:0:b0:398:506b:747b with SMTP id
 q19-20020a67d793000000b00398506b747bmr3650735vsj.19.1663945928830; Fri, 23
 Sep 2022 08:12:08 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Fri, 23 Sep 2022 23:11:57 +0800
Message-ID: <CAB7eex+r2g4HhL1D-M26+N7e=S3zKMTk_4FETXqkx4A73Y+w5g@mail.gmail.com>
Subject: WARNING in vb2_start_streaming
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        christian.koenig@amd.com
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
console output: https://pastebin.com/raw/ZSCg16sG

Sorry for failing to extract the reproducer. But on other versions of
Linux, I also triggered this crash.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:

msi2500 2-1:1.0: failed -32, cmd 41, data 608008
usb 2-1: selecting invalid altsetting 1
msi2500 2-1:1.0: failed -32, cmd 43, data 0000
------------[ cut here ]------------
WARNING: CPU: 1 PID: 18451 at
drivers/media/common/videobuf2/videobuf2-core.c:1612
vb2_start_streaming+0x246/0x4c0
drivers/media/common/videobuf2/videobuf2-core.c:1612
Modules linked in:
CPU: 1 PID: 18451 Comm: syz-fuzzer Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:vb2_start_streaming+0x246/0x4c0
drivers/media/common/videobuf2/videobuf2-core.c:1612
Code: 00 00 00 00 00 fc ff df 48 89 ea 48 c1 ea 03 80 3c 02 00 0f 85
04 02 00 00 48 8b 83 60 02 00 00 48 39 c5 74 0c e8 9a 5a 63 fb <0f> 0b
eb 03 45 31 e4 e8 8e 5a 63 fb 44 89 e0 48 83 c4 10 5b 5d 41
RSP: 0018:ffffc9001457fb18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88804eb987f0 RCX: ffff88801ab91d40
RDX: 0000000000000000 RSI: ffff88801ab91d40 RDI: 0000000000000002
RBP: ffff88804eb98a50 R08: ffffffff86178d96 R09: 0000000000000000
R10: 0000000000000005 R11: ffffed1009d73149 R12: 00000000ffffffe0
R13: 0000000000000000 R14: 0000000000000008 R15: 0000000000000008
FS: 000000c001d53090(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f620c0431a8 CR3: 000000001d598000 CR4: 0000000000350ee0
Call Trace:
<TASK>
vb2_core_streamon drivers/media/common/videobuf2/videobuf2-core.c:2113 [inline]
vb2_core_streamon+0x1da/0x2c0
drivers/media/common/videobuf2/videobuf2-core.c:2080
__vb2_init_fileio+0xa18/0xcf0
drivers/media/common/videobuf2/videobuf2-core.c:2685
vb2_core_poll+0x4d2/0x7c0 drivers/media/common/videobuf2/videobuf2-core.c:2465
vb2_poll+0x31/0x150 drivers/media/common/videobuf2/videobuf2-v4l2.c:970
vb2_fop_poll+0x10e/0x360 drivers/media/common/videobuf2/videobuf2-v4l2.c:1217
v4l2_poll+0x158/0x220 drivers/media/v4l2-core/v4l2-dev.c:348
vfs_poll include/linux/poll.h:88 [inline]
ep_item_poll.isra.0+0xd8/0x170 fs/eventpoll.c:853
ep_insert fs/eventpoll.c:1522 [inline]
do_epoll_ctl+0x1bc4/0x3080 fs/eventpoll.c:2163
__do_sys_epoll_ctl fs/eventpoll.c:2214 [inline]
__se_sys_epoll_ctl fs/eventpoll.c:2205 [inline]
__x64_sys_epoll_ctl+0x13f/0x1c0 fs/eventpoll.c:2205
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x466938
Code: 10 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 8b 7c 24
08 8b 74 24 0c 8b 54 24 10 4c 8b 54 24 18 b8 e9 00 00 00 0f 05 <89> 44
24 20 c3 cc cc cc 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 44
RSP: 002b:000000c0042bda88 EFLAGS: 00000206 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 0000000000466938
RDX: 000000000000002d RSI: 0000000000000001 RDI: 0000000000000003
RBP: 000000c0042bdad8 R08: 0000000000000000 R09: 0000000000000060
R10: 000000c0042bdac4 R11: 0000000000000206 R12: 0000000000203000
R13: 0000000000000050 R14: 000000c000092340 R15: 00007f94d7f54c87
</TASK>
