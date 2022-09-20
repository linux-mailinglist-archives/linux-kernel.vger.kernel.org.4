Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73285BE950
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiITOrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiITOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:46:58 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DDB58B79;
        Tue, 20 Sep 2022 07:46:57 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id p4so3334821vsa.9;
        Tue, 20 Sep 2022 07:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Fj6dboJTb8QVBM7b90QPIoepjKNIqv8f0qJ6KlT424g=;
        b=RzPeb+NLewrB2638saBiOcjXWm8GX05H4D5beoiBDptP7n7P56EN05kgLBRHSMhbFY
         1/FgWeNvl4a0y5mNUD516ghnPzdVE+Ap2PNFZt1mJEKY92CHRypzRldkwdMZuFYV/zZp
         n6010D9crgUmGNCj8JbDN7EM5g/RoaJYbKGVO/2Nvft1vXv97rz3vIwLCVkFdfv3XLA1
         fGrJSTWK3WkpbQF+knSD0K8JNbzeBshScibW6igOV5u8kdp4VHoRkUXEcp6fZ4nxe/jn
         K66C5lk3lpSk3Sh1qwJNdU7pYt45hXZndGdKYlepZyWp75uZOvx8g1Wi4k9TAsNoEPkZ
         O87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Fj6dboJTb8QVBM7b90QPIoepjKNIqv8f0qJ6KlT424g=;
        b=Wr9K/ADvzv18oGyqw250moNBWY6JiN5hPwRzHYSjjHblwdbYJe0yh/cl5MXwVTuix8
         MeK/55gK5pIVU3Lj2WdcQEOW6RclEjHiNCvtq38tJJFH3ZwBMFYquP4z7xgaxTH8npSu
         Dl8kYEdFYYXDvcon3tND8GvDy46PQ3+1zRZKzGEsRbvxLQzdQR2ydlaW0wb9MJb4UsOB
         z4Ws0eNn9V3OfkvkuCdur71ZCDPPEwgsRBX1dP27pxZ7GQofixq78kbbC/a5wtpFBvMt
         efYKOPuXaDkgOVMMG8EG+67Wu200nIbfj8Wpj9Tp7V2nIxJKutGZ0KoXOcBTQyDpgq3Q
         5vrw==
X-Gm-Message-State: ACrzQf3U4Mt3TxfFkdallO7fyiRag3/aWTCCfvKT+twU62Jmpl2AcCG9
        8K0Ba292rKLAoBSCNx4rmuh0WFfCr56gTM4tgTY=
X-Google-Smtp-Source: AMsMyM4DY56uSJuv1OB3XA4+/NChNXQO6s7gM+ANW7XylJ7yZgmVY6nurvifY1QhaJcbKdgY/8UtSw4p6gJsr1rerU0=
X-Received: by 2002:a67:be16:0:b0:398:c2e4:e01f with SMTP id
 x22-20020a67be16000000b00398c2e4e01fmr8206428vsq.33.1663685216652; Tue, 20
 Sep 2022 07:46:56 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Tue, 20 Sep 2022 22:46:45 +0800
Message-ID: <CAB7eexL-RMqozuX43uCTwzs7V9Vdk+kQzqnn_X4YR78mcH-+Ww@mail.gmail.com>
Subject: general protection fault in su3000_i2c_transfer
To:     mchehab@kernel.org, vasilyev@ispras.ru,
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
console output: https://pastebin.com/raw/rNPrPV51

Sorry for failing to extract the reproducer. But on other versions of
Linux, I also triggered this crash.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:
general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 16814 Comm: syz-executor.1 Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:su3000_i2c_transfer+0x796/0xb00 drivers/media/usb/dvb-usb/dw2102.c:712
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 5b 03 00 00
48 b8 00 00 00 00 00 fc ff df 48 8b 5b 08 48 89 da 48 c1 ea 03 <0f> b6
04 02 48 89 da 83 e2 07 38 d0 7f 08 84 c0 0f 85 38 02 00 00
RSP: 0018:ffffc90018c8fcd8 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 0000000000000010 RCX: 0000000000040000
RDX: 0000000000000002 RSI: ffff888017691d40 RDI: ffff888064450f08
RBP: ffff88802429bd00 R08: ffffffff861e5272 R09: 0000000000001a00
R10: 0000000000000003 R11: fffffbfff1d34742 R12: ffff888024534000
R13: ffff888024534fc0 R14: ffff888024534ea0 R15: 0000000000001900
FS: 00007f4a477eb700(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4a4719d060 CR3: 0000000064626000 CR4: 0000000000350ee0
Call Trace:
<TASK>
__i2c_transfer drivers/i2c/i2c-core-base.c:2109 [inline]
__i2c_transfer+0x4c2/0x16a0 drivers/i2c/i2c-core-base.c:2074
i2c_transfer+0x1e6/0x3e0 drivers/i2c/i2c-core-base.c:2170
i2cdev_ioctl_rdwr.isra.0+0x2ea/0x6a0 drivers/i2c/i2c-dev.c:297
i2cdev_ioctl+0x488/0x7b0 drivers/i2c/i2c-dev.c:458
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:870 [inline]
__se_sys_ioctl fs/ioctl.c:856 [inline]
__x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4a470a80fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a477eabf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f4a4719c340 RCX: 00007f4a470a80fd
RDX: 0000000020002180 RSI: 0000000000000707 RDI: 0000000000000003
RBP: 00007f4a4710b606 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff0c6db6ff R14: 00007fff0c6db8a0 R15: 00007f4a477ead80
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:su3000_i2c_transfer+0x796/0xb00 drivers/media/usb/dvb-usb/dw2102.c:712
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 5b 03 00 00
48 b8 00 00 00 00 00 fc ff df 48 8b 5b 08 48 89 da 48 c1 ea 03 <0f> b6
04 02 48 89 da 83 e2 07 38 d0 7f 08 84 c0 0f 85 38 02 00 00
RSP: 0018:ffffc90018c8fcd8 EFLAGS: 00010212
RAX: dffffc0000000000 RBX: 0000000000000010 RCX: 0000000000040000
RDX: 0000000000000002 RSI: ffff888017691d40 RDI: ffff888064450f08
RBP: ffff88802429bd00 R08: ffffffff861e5272 R09: 0000000000001a00
R10: 0000000000000003 R11: fffffbfff1d34742 R12: ffff888024534000
R13: ffff888024534fc0 R14: ffff888024534ea0 R15: 0000000000001900
FS: 00007f4a477eb700(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f18040450a8 CR3: 0000000064626000 CR4: 0000000000350ee0
----------------
Code disassembly (best guess), 3 bytes skipped:
0: df 48 89 fisttps -0x77(%rax)
3: fa cli
4: 48 c1 ea 03 shr $0x3,%rdx
8: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1)
c: 0f 85 5b 03 00 00 jne 0x36d
12: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
19: fc ff df
1c: 48 8b 5b 08 mov 0x8(%rbx),%rbx
20: 48 89 da mov %rbx,%rdx
23: 48 c1 ea 03 shr $0x3,%rdx
* 27: 0f b6 04 02 movzbl (%rdx,%rax,1),%eax <-- trapping instruction
2b: 48 89 da mov %rbx,%rdx
2e: 83 e2 07 and $0x7,%edx
31: 38 d0 cmp %dl,%al
33: 7f 08 jg 0x3d
35: 84 c0 test %al,%al
37: 0f 85 38 02 00 00 jne 0x275
