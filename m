Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270FA5E60F5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiIVL1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiIVL0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:26:42 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EC4E11B3;
        Thu, 22 Sep 2022 04:26:28 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id i17so3523905uaq.9;
        Thu, 22 Sep 2022 04:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=7/4en0JzQ3mEn0KNL06diZoNmw0KIWKD4kZ+f7UUSJ8=;
        b=phS/M8ALltQUhVnzQAb8UIReOE7J/fjBXyGM4pma0xwURPFRxUmz2neIpChhkQ6dMA
         N5MIxopUke3SgCUvF/oKN0IbfvwIf/jVLhs7eYbEwz7Ha37hhUcyprg2eiqdZyfcmIfO
         kJOoY1MvCfXHXe1kHT2DxK2KMhnXm28suiRIDtjgIPrF4cxW8deL7OVIbunCrQiJqtw8
         myDctepO1bXrIYrczqBsJsfHEiYQCl3onIwKFghA2CWCmsgkB3gOKVT2b0yg9iW8TQIU
         Fgi0Tm/P+tu6dZD3bNjcqituCxOMjHMLpouWc9RlgmyhxqF0TTZ9jiedyL71KPK5K+8y
         dakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=7/4en0JzQ3mEn0KNL06diZoNmw0KIWKD4kZ+f7UUSJ8=;
        b=bZr67ENHHD5M04MrXRNSezUJiajGD7iB/06oG5cr4ttf0mA4jZFXieOmFpL9IMRHY4
         iydij6LaQhp4OztDJJEatqXXOwxyTZe3VR77aNzU2zbq//cpKDHvYxGdCkZky0VDSsw8
         nEoKK0SGQM8nHJ8bFJF0KISL3ehMpQOMO0LGqWjOvscCiAzf5eisomBj2hkvsw8UfJYt
         F9FGYe780BnfnxE0HvpjzF0Ik/OYCNwgGthejiX+djY2LSgqNrUnEcV6WgrUocN2Dhik
         M646WgzLmmdxlAS5RszpiNVJWQO9CJx9i2zjjWmPm4HlWKEGDx+vZ8AQim5b8mfPayBI
         sibg==
X-Gm-Message-State: ACrzQf1Q3nOhoh5L1cf3MrGz1IGC2lGbkTtYe/lKXNYDs3JfwCjGnGp5
        x5cdZpRU9f2JduelVKFr+exTrrhmnHjrZSj2lcWR930nRiRuaIGbRcg=
X-Google-Smtp-Source: AMsMyM4iYhUDqtESM+cGazTaWUfJaX6ciWlPVn+pTzYxye20l2lty8RhvnBvpIOGmX9HFg+3ZSbcaIwgYavljqO2yhw=
X-Received: by 2002:a05:6130:9e:b0:3bf:2ea9:6e23 with SMTP id
 x30-20020a056130009e00b003bf2ea96e23mr1117293uaf.26.1663845987829; Thu, 22
 Sep 2022 04:26:27 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Thu, 22 Sep 2022 19:26:16 +0800
Message-ID: <CAB7eex+=azurdG2wbBR_2F349EqDaSSf7YDSvjkBYjw1RRHVjw@mail.gmail.com>
Subject: general protection fault in digitv_i2c_xfer
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
console output: https://pastebin.com/raw/eQmbXagT

Sorry for failing to extract the reproducer. But on other versions of
Linux, I also triggered this crash.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:
general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 3 PID: 14711 Comm: syz-executor.2 Not tainted 6.0.0-rc6+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:digitv_i2c_xfer+0xf2/0x3b0 drivers/media/usb/dvb-usb/digitv.c:67
Code: 5c 24 08 48 8d 7b 08 48 89 f8 48 c1 e8 03 42 80 3c 30 00 0f 85
6f 02 00 00 48 8b 6b 08 48 89 e8 48 89 ea 48 c1 e8 03 83 e2 07 <42> 0f
b6 04 30 38 d0 7f 08 84 c0 0f 85 40 02 00 00 0f b6 45 00 44
RSP: 0018:ffffc90006db7cd0 EFLAGS: 00010246
RAX: 0000000000000002 RBX: ffff8880005140e0 RCX: 0000000000040000
RDX: 0000000000000000 RSI: ffff8880180bba80 RDI: ffff8880005140e8
RBP: 0000000000000010 R08: ffffffff861bedfa R09: 0000000000000000
R10: 0000000000000005 R11: fffffbfff1d34d22 R12: 0000000000000000
R13: 0000000000000001 R14: dffffc0000000000 R15: 0000000000000001
FS: 00007fa593c8e700(0000) GS:ffff88807ed00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa593471b30 CR3: 0000000024995000 CR4: 0000000000350ee0
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
RIP: 0033:0x7fa5934a80fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa593c8dbf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa59359c340 RCX: 00007fa5934a80fd
RDX: 0000000020000640 RSI: 0000000000000707 RDI: 0000000000000003
RBP: 00007fa59350b606 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffea1fefa1f R14: 00007ffea1fefbc0 R15: 00007fa593c8dd80
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:digitv_i2c_xfer+0xf2/0x3b0 drivers/media/usb/dvb-usb/digitv.c:67
Code: 5c 24 08 48 8d 7b 08 48 89 f8 48 c1 e8 03 42 80 3c 30 00 0f 85
6f 02 00 00 48 8b 6b 08 48 89 e8 48 89 ea 48 c1 e8 03 83 e2 07 <42> 0f
b6 04 30 38 d0 7f 08 84 c0 0f 85 40 02 00 00 0f b6 45 00 44
RSP: 0018:ffffc90006db7cd0 EFLAGS: 00010246
RAX: 0000000000000002 RBX: ffff8880005140e0 RCX: 0000000000040000
RDX: 0000000000000000 RSI: ffff8880180bba80 RDI: ffff8880005140e8
RBP: 0000000000000010 R08: ffffffff861bedfa R09: 0000000000000000
R10: 0000000000000005 R11: fffffbfff1d34d22 R12: 0000000000000000
R13: 0000000000000001 R14: dffffc0000000000 R15: 0000000000000001
FS: 00007fa593c8e700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa59359d060 CR3: 0000000024995000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
0: 5c pop %rsp
1: 24 08 and $0x8,%al
3: 48 8d 7b 08 lea 0x8(%rbx),%rdi
7: 48 89 f8 mov %rdi,%rax
a: 48 c1 e8 03 shr $0x3,%rax
e: 42 80 3c 30 00 cmpb $0x0,(%rax,%r14,1)
13: 0f 85 6f 02 00 00 jne 0x288
19: 48 8b 6b 08 mov 0x8(%rbx),%rbp
1d: 48 89 e8 mov %rbp,%rax
20: 48 89 ea mov %rbp,%rdx
23: 48 c1 e8 03 shr $0x3,%rax
27: 83 e2 07 and $0x7,%edx
* 2a: 42 0f b6 04 30 movzbl (%rax,%r14,1),%eax <-- trapping instruction
2f: 38 d0 cmp %dl,%al
31: 7f 08 jg 0x3b
33: 84 c0 test %al,%al
35: 0f 85 40 02 00 00 jne 0x27b
3b: 0f b6 45 00 movzbl 0x0(%rbp),%eax
3f: 44 rex.R
