Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7615FEB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJNJWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJNJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:22:51 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EE11BE1F6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:22:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c24so4194838pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E5dHqmsGt5x/ibVS7C2KP9W7Xq57N2db5FdvVrUVbOU=;
        b=D2h+Wop90g0YPLvq0/itoDRoDkV4i8mL5jZgAMr66oLRqL++TeQwzCJnd24aYOGqCq
         M+Eiou8ACzqtPjdV6oznbCrAN5dTNP/FVylg5z2/XBaXIcnZhPogpbD1mrz+Y0qyVQJI
         UjGZQIhCY2OkjfXlijN4ea3lpY5sDQpgkTQh3b5/l8tUGfTSoD+I9Nm2AWINgj8We/3E
         0jXHrEH3db0ENkNDKiXNEdD3ACfb+/PAxat2RMHOQp2nJz8Uu6zbU15cCgGOF3yGI/D9
         +dpyRxh7v2b9HGmDFpmnquVxcgJrF8Rtxhz6ratICcRPpqkTVQmqcjhhOEIz7U1F38ln
         0MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5dHqmsGt5x/ibVS7C2KP9W7Xq57N2db5FdvVrUVbOU=;
        b=Bqbnx7Tsr3BAW0plHtds0YvDwuYlTLxYOk8qIOP/UOQisPMaZFmPJXM1GkWFPkVvWU
         yOSg7ZzQnN9M01VCrJEjeKmD2MoWD9wasiAhVpCMnMp9VcTgsbk1OoGQW+AQIU/j/MWD
         ocX0ma+AJp4YmGtYNJ93PY8qdUTfz9CQRwQXjw3p/RrYo4Vgf8ztXaEf7VYyCVLlDWFW
         CsKgDOcN0gV31JvNp6NMQ7FS9Rxdr6sraFDbWP2IEMhZ5SsHuSOOSH7rxbzDfYjKb9JS
         yyD6l/dMWHEch8EwoxO/6dAKHwhAdFF9as4+OjkmSbU4a1GmSn3CLkrYtHNUhhbigHU3
         zNCw==
X-Gm-Message-State: ACrzQf1PBIPLVDOcDYhasTMVDD1ZkXgqyaIj2585IzajRF+ZK/QLvrif
        HrHXnrHQvWgqmn66runKnYmW215i/flFx1nQCeeNIQ==
X-Google-Smtp-Source: AMsMyM72Z7WXqecPOsima7MyAX3naNW0+GG3m5+Cc1fPA2iqBdOh7VdTkcAsrvefy7FXih6bxdf9CPFn2ipJ1C49CtI=
X-Received: by 2002:a17:902:ec83:b0:17c:afb3:d1ec with SMTP id
 x3-20020a170902ec8300b0017cafb3d1ecmr4185102plg.172.1665739369636; Fri, 14
 Oct 2022 02:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com> <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com> <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
In-Reply-To: <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 14 Oct 2022 11:22:38 +0200
Message-ID: <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006 tag
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sergey.Semin@baikalelectronics.ru,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 at 09:53, Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 10/14/22 16:31, Arnd Bergmann wrote:
> > On Fri, Oct 14, 2022, at 2:22 AM, Damien Le Moal wrote:
> >> On 10/14/22 07:07, Anders Roxell wrote:
> >> [...]
> >>>> 8)
> >>>>> If reverting these patches restores the eSATA port on this board, then you need
> >>>>> to fix the defconfig for that board.
> >>>>
> >>>> OTOH,
> >>>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
> >>>> device failed to boot.
> >>>
> >>> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
> >>
> >> As mentioned in my previous reply to Naresh, this is a new driver added in
> >> 6.1. Your board was working before so this should not be the driver needed
> >> for it.
> >>
> >>> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
> >>> controller support")
> >>> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
> >>> successful.
> >>
> >> Which is very strange... There is only one hunk in that commit that could
> >> be considered suspicious:
> >>
> >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> >> index 9b56490ecbc3..8f5572a9f8f1 100644
> >> --- a/drivers/ata/ahci_platform.c
> >> +++ b/drivers/ata/ahci_platform.c
> >> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> >>  static const struct of_device_id ahci_of_match[] = {
> >>         { .compatible = "generic-ahci", },
> >>         /* Keep the following compatibles for device tree compatibility */
> >> -       { .compatible = "snps,spear-ahci", },
> >>         { .compatible = "ibm,476gtr-ahci", },
> >> -       { .compatible = "snps,dwc-ahci", },
> >>         { .compatible = "hisilicon,hisi-ahci", },
> >>         { .compatible = "cavium,octeon-7130-ahci", },
> >>         { /* sentinel */ }
> >>
> >> Is your board using one of these compatible string ?
> >
> > The x15 uses "snps,dwc-ahci". I would expect it to detect the device
> > with the new driver if that is loaded, but it's possible that the
> > driver does not work on all versions of the dwc-ahci hardware.
> >
> > Anders, can you provide the boot log from a boot with the new driver
> > built in? There should be some messages from dwc-ahci about finding
> > the device, but then not ultimately working.
> >
> > Depending on which way it goes wrong, the safest fallback for 6.1 is
> > probably to move the "snps,spear-ahci" and "snps,dwc-ahci" compatible
> > strings back into the old driver, and leave the new one only for
> > the "baikal,bt1-ahci" implementation of it, until it has been
> > successfully verified on TI am5/dra7, spear13xx and exynos.
>
> OK. So a fix patch until further tests/debug is completed would be this:
>
> diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
> index 8fb66860db31..7a0cbab00843 100644
> --- a/drivers/ata/ahci_dwc.c
> +++ b/drivers/ata/ahci_dwc.c
> @@ -469,8 +469,6 @@ static struct ahci_dwc_plat_data ahci_bt1_plat = {
>  };
>
>  static const struct of_device_id ahci_dwc_of_match[] = {
> -       { .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
> -       { .compatible = "snps,spear-ahci", &ahci_dwc_plat },
>         { .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },
>         {},
>  };
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 8f5572a9f8f1..9b56490ecbc3 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -80,7 +80,9 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
>  static const struct of_device_id ahci_of_match[] = {
>         { .compatible = "generic-ahci", },
>         /* Keep the following compatibles for device tree compatibility */
> +       { .compatible = "snps,spear-ahci", },
>         { .compatible = "ibm,476gtr-ahci", },
> +       { .compatible = "snps,dwc-ahci", },
>         { .compatible = "hisilicon,hisi-ahci", },
>         { .compatible = "cavium,octeon-7130-ahci", },
>         { /* sentinel */ }
>
> Anders, Naresh,
>
> Can you try this ?

Tested this patch on todays linux-next tag: next-20221014 without enabling
CONFIG_AHCI_DWC and it worked as expected when booting [1].
On the other hand I also tried a build/boot with CONFIG_AHCI_DWC enabled
and it worked as expected to boot [2]. However, during building a
warning [3] popped up:

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/2/build ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
/builds/linux/drivers/ata/ahci_dwc.c:462:34: warning: 'ahci_dwc_plat'
defined but not used [-Wunused-variable]
  462 | static struct ahci_dwc_plat_data ahci_dwc_plat = {
         |                                  ^~~~~~~~~~~~~


Cheers,
Anders
[1] https://lkft.validation.linaro.org/scheduler/job/5678031
[2] https://lkft.validation.linaro.org/scheduler/job/5678152
[3] https://builds.tuxbuild.com/2G7PDSV5uzjnQqCCBybK4WpoTxz/build.log
