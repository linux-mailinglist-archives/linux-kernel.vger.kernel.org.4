Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750746E9AB6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjDTR1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDTR1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:27:48 -0400
Received: from mx6.ucr.edu (unknown [138.23.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15EFE57
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1682011667; x=1713547667;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc:content-transfer-encoding;
  bh=m0FRJv82Zu1t4DuQsvNt8pTR3GIZGjnpBIZPnMMIx84=;
  b=oz7MF/u4ax3z3vKqb5AIF75LQ8ozNO43fGi5lJ0oZMdmVvRJiYOLEPA5
   +hfZgIlHOMdKe3UUzqj2KbwzpYhDScaEyD70YFg+6uFBZOkwcXSY216e9
   RYFhpetOpccbgNkApuFJky8YB0G+v++IySfXhIiA1TAGnBemoBnFic+ag
   58sfgJz4/HQBIcMBaSPHF4ZeKYBsx7LL/TLTxVhnag/7G6utr1Kcabp7C
   MzK4OwzxZ0W5KdJckYAc2nagBdvrjE1vRtatLj48zEgOvdZ+j0/qkjl8f
   YVmJvgmfUICe3/oTlW2TbsBZsnzbsUeUNumRFyNn1EM782IZ0Ho7OxyyR
   A==;
Received: from mail-wr1-f71.google.com ([209.85.221.71])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Apr 2023 10:27:46 -0700
Received: by mail-wr1-f71.google.com with SMTP id j16-20020adfa550000000b002fee71f4a42so188687wrb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1682011663; x=1684603663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prvqaHMzKrn9ZWtMPIRK+7YzVsgpCm9+YP37nwvlG5A=;
        b=d7/Jv556EmH3rd6PUv3RPTf3yuNhvrJJt4q3g/YdqN9fLQo0X7DMY/d3JPgA0GOVMq
         fANtzSR05UqLofG2RfR4fzlLZ+OwDH3odceGC/K57pTWH5/V3t+XjMyEj/f7YyCbXSjm
         xrOWHPR4Zca3cSFnSSUam4ahzA5gIwwu0m3ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011663; x=1684603663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prvqaHMzKrn9ZWtMPIRK+7YzVsgpCm9+YP37nwvlG5A=;
        b=JEOWmwCLQD9+w2HNqSATdTdftsjC+juA/rOZVQ2W6bU4fOFCNATaPzu2WUzn7hYckG
         yn0XtYj/QD1U705VCDdGHHEH71cdx2eiSe+SrmU3l+wW2j0NkOIHLzdI6A3Q3ERVBG9E
         KLdCf62GxE0VJuEDSY3HIDMdGU7W0BIeXF+TIUIL5MVsDiOueR0jub8FV6kWMIqWpv3X
         UPzKj1nbZQ2T2AVL2ZorhVpwQrwiZmT1v9UC5kE4Aa9S6n5n6zPj68cYbo1RZXcG2fL2
         9Y3GKn6KIjkB03qqgWISmNGnwnQ9nsjXK7UTlpI6qgtR9Zp33EbOZEGC4ODsGVpowas3
         Fa2Q==
X-Gm-Message-State: AAQBX9f+ivfVvDHbvfyLEMwBgO9AClOV6jyn8MJkdXVIW/P1xRXvMN2l
        0tIFjDi5b6AiI4E09I3CcH99c7kVNIKAYuhrmVcUGf16kzoWETrOZdOUKuDlbbbJwXujai5LmIV
        UcdIe/TXtAGMCzyD70/pWWuilgiea5vdMgu8Mripg5g==
X-Received: by 2002:a05:600c:288:b0:3f1:75c5:bd56 with SMTP id 8-20020a05600c028800b003f175c5bd56mr2085093wmk.8.1682011663486;
        Thu, 20 Apr 2023 10:27:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZBaqyafrj2kes9Nec8JC/21lZni+HBdg86ODg3DHsVpIWmSpqTEZeXvOZepxdLJoIx2dtZq8drz44GlnaEZ9c=
X-Received: by 2002:a05:600c:288:b0:3f1:75c5:bd56 with SMTP id
 8-20020a05600c028800b003f175c5bd56mr2085079wmk.8.1682011663141; Thu, 20 Apr
 2023 10:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com>
 <CA+UBctDsHRpkLG5ppdiuV8Msn4Dx-ZJ2xDrxfa48VMb7ZE+xBA@mail.gmail.com>
 <687864524.118195.1681799447034.JavaMail.zimbra@nod.at> <ff419c45-7d76-0219-a598-f6f4d081e29c@huawei.com>
In-Reply-To: <ff419c45-7d76-0219-a598-f6f4d081e29c@huawei.com>
From:   Yu Hao <yhao016@ucr.edu>
Date:   Thu, 20 Apr 2023 10:27:32 -0700
Message-ID: <CA+UBctBVHouL-3rM3zKYLpk01fXFvCpBnU7EpSRVdGW7cEjcJQ@mail.gmail.com>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 19, 2023 at 9:49=E2=80=AFPM Zhihao Cheng <chengzhihao1@huawei.c=
om> wrote:
>
> Hi
> > Yu Hao,
> >
> > ----- Urspr=C3=BCngliche Mail -----
> >> Von: "Yu Hao" <yhao016@ucr.edu>
> >>> ubi: mtd0 is already attached to ubi0
> >>> ubi7: attaching mtd147
> >>> divide error: 0000 [#1] PREEMPT SMP KASAN
> >>> CPU: 0 PID: 20023 Comm: syz-executor.0 Not tainted 6.2.0 #6
> >>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> >>> 1.13.0-1ubuntu1.1 04/01/2014
> >>> RIP: 0010:mtd_div_by_eb include/linux/mtd/mtd.h:580 [inline]
> >>> RIP: 0010:io_init drivers/mtd/ubi/build.c:620 [inline]
> >>> RIP: 0010:ubi_attach_mtd_dev+0x77f/0x2fe0 drivers/mtd/ubi/build.c:955
> >>> Code: fc ff df 48 c1 ea 03 0f b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38
> >>> d0 7c 08 84 d2 0f 85 1f 25 00 00 41 8b 4c 24 10 48 89 d8 31 d2 <48> f=
7
> >>> f1 48 89 c3 e8 b6 f3 1b fc 48 8d 85 40 17 00 00 48 89 c2 48
> >>> RSP: 0018:ffffc9000be0fd30 EFLAGS: 00010246
> >>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> >>> RDX: 0000000000000000 RSI: ffff888047a49d40 RDI: 0000000000000002
> >>> RBP: ffff888024e1c000 R08: 0000000000000016 R09: fffff520017c1f47
> >>> R10: ffffc9000be0fa37 R11: fffff520017c1f46 R12: ffff88806545a000
> >>> R13: 0000000000000000 R14: ffff88806545a010 R15: 0000000000000007
> >>> FS:  00007fd45e85c700(0000) GS:ffff88802ca00000(0000) knlGS:000000000=
0000000
> >>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> CR2: 00007f64aeef53a4 CR3: 000000004f39a000 CR4: 0000000000350ef0
> >>> Call Trace:
> >>>   <TASK>
> >>>   ctrl_cdev_ioctl+0x303/0x3a0 drivers/mtd/ubi/cdev.c:1043
> >
> > What kind of MTD you attaching?
> > Has it erasesize 0?
> >
>
> Yes, I agree with Richard's point, I guess UBI got an mtd device with
> zero erasesize.
>

The kernel is in qemu. We find that the `mtd` is from
`mtd =3D get_mtd_device(NULL, req.mtd_num);` in function `ctrl_cdev_ioctl`.
 And we are still trying to figure out what MTD is.

>
>   568 static inline uint32_t mtd_div_by_eb(uint64_t sz, struct mtd_info
> *mtd)
>   569 {
>   570         if (mtd->erasesize_shift)       // erasesize_shift is 0
>   571                 return sz >> mtd->erasesize_shift;
>   572         do_div(sz, mtd->erasesize);    // erasesize is 0 too
>   573         return sz;
>   574 }
>
> Yu Hao, how do you find the problem, by syzkaller? Can you provide the
> reproducing program or reproducing log?

We find this by syzkaller with customized syscall descriptions.
There is not any reproducing program now.
