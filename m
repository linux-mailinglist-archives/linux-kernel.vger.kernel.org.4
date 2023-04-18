Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771BA6E596F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjDRGav convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 02:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDRGat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:30:49 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D484B119
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:30:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 96AFB64551DF;
        Tue, 18 Apr 2023 08:30:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id CZCQMMmRb5xL; Tue, 18 Apr 2023 08:30:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3B1826431C28;
        Tue, 18 Apr 2023 08:30:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hc7I4qRsRMGG; Tue, 18 Apr 2023 08:30:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 216AA64551DF;
        Tue, 18 Apr 2023 08:30:47 +0200 (CEST)
Date:   Tue, 18 Apr 2023 08:30:47 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Yu Hao <yhao016@ucr.edu>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <687864524.118195.1681799447034.JavaMail.zimbra@nod.at>
In-Reply-To: <CA+UBctDsHRpkLG5ppdiuV8Msn4Dx-ZJ2xDrxfa48VMb7ZE+xBA@mail.gmail.com>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com> <CA+UBctDsHRpkLG5ppdiuV8Msn4Dx-ZJ2xDrxfa48VMb7ZE+xBA@mail.gmail.com>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: divide error in ubi_attach_mtd_dev
Thread-Index: k4bIGdcIRmBd/MSU/l20Gs+2lMcsjQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yu Hao,

----- Ursprüngliche Mail -----
> Von: "Yu Hao" <yhao016@ucr.edu>
>> ubi: mtd0 is already attached to ubi0
>> ubi7: attaching mtd147
>> divide error: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 0 PID: 20023 Comm: syz-executor.0 Not tainted 6.2.0 #6
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> 1.13.0-1ubuntu1.1 04/01/2014
>> RIP: 0010:mtd_div_by_eb include/linux/mtd/mtd.h:580 [inline]
>> RIP: 0010:io_init drivers/mtd/ubi/build.c:620 [inline]
>> RIP: 0010:ubi_attach_mtd_dev+0x77f/0x2fe0 drivers/mtd/ubi/build.c:955
>> Code: fc ff df 48 c1 ea 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38
>> d0 7c 08 84 d2 0f 85 1f 25 00 00 41 8b 4c 24 10 48 89 d8 31 d2 <48> f7
>> f1 48 89 c3 e8 b6 f3 1b fc 48 8d 85 40 17 00 00 48 89 c2 48
>> RSP: 0018:ffffc9000be0fd30 EFLAGS: 00010246
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>> RDX: 0000000000000000 RSI: ffff888047a49d40 RDI: 0000000000000002
>> RBP: ffff888024e1c000 R08: 0000000000000016 R09: fffff520017c1f47
>> R10: ffffc9000be0fa37 R11: fffff520017c1f46 R12: ffff88806545a000
>> R13: 0000000000000000 R14: ffff88806545a010 R15: 0000000000000007
>> FS:  00007fd45e85c700(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007f64aeef53a4 CR3: 000000004f39a000 CR4: 0000000000350ef0
>> Call Trace:
>>  <TASK>
>>  ctrl_cdev_ioctl+0x303/0x3a0 drivers/mtd/ubi/cdev.c:1043

What kind of MTD you attaching?
Has it erasesize 0?

Thanks,
//richard
