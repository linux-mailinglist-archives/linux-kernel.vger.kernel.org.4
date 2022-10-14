Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380835FEFC7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiJNOHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiJNOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:07:11 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15F72D57D7;
        Fri, 14 Oct 2022 07:06:57 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 87681E0EAF;
        Fri, 14 Oct 2022 17:06:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=8x0DQi0sc4Cp7zYGG0KG
        ETioxXW4LTwMCzYPtV24TFo=; b=Hdsk+2c3den3XYUl6CgB5pRzIh2FdQniC45R
        af5E24UGKk3h9ZpZ/gVYs0f6EuIke8RbT1kTOxMUvHZlLwpLmkVdjJ8iZpEIlmG3
        my+GvLRM9fPenxkpGCy1dEm1seeRArsdIp5rj7qPiItdgri23i9Y5PcLWOrudVTG
        1M7mKXk=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 77A7EE0E1C;
        Fri, 14 Oct 2022 17:06:34 +0300 (MSK)
Received: from mobilestation (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Oct 2022 17:06:34 +0300
Date:   Fri, 14 Oct 2022 17:06:33 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Anders Roxell <anders.roxell@linaro.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <regressions@lists.linux.dev>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, <lkft-triage@lists.linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Message-ID: <20221014140633.mlypet7skkxvt453@mobilestation>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
 <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 11:22:38AM +0200, Anders Roxell wrote:
> On Fri, 14 Oct 2022 at 09:53, Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
> >
> > On 10/14/22 16:31, Arnd Bergmann wrote:
> > > On Fri, Oct 14, 2022, at 2:22 AM, Damien Le Moal wrote:
> > >> On 10/14/22 07:07, Anders Roxell wrote:
> > >> [...]
> > >>>> 8)
> > >>>>> If reverting these patches restores the eSATA port on this board, then you need
> > >>>>> to fix the defconfig for that board.
> > >>>>
> > >>>> OTOH,
> > >>>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
> > >>>> device failed to boot.
> > >>>
> > >>> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
> > >>
> > >> As mentioned in my previous reply to Naresh, this is a new driver added in
> > >> 6.1. Your board was working before so this should not be the driver needed
> > >> for it.
> > >>
> > >>> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
> > >>> controller support")
> > >>> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
> > >>> successful.
> > >>
> > >> Which is very strange... There is only one hunk in that commit that could
> > >> be considered suspicious:
> > >>
> > >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > >> index 9b56490ecbc3..8f5572a9f8f1 100644
> > >> --- a/drivers/ata/ahci_platform.c
> > >> +++ b/drivers/ata/ahci_platform.c
> > >> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> > >>  static const struct of_device_id ahci_of_match[] = {
> > >>         { .compatible = "generic-ahci", },
> > >>         /* Keep the following compatibles for device tree compatibility */
> > >> -       { .compatible = "snps,spear-ahci", },
> > >>         { .compatible = "ibm,476gtr-ahci", },
> > >> -       { .compatible = "snps,dwc-ahci", },
> > >>         { .compatible = "hisilicon,hisi-ahci", },
> > >>         { .compatible = "cavium,octeon-7130-ahci", },
> > >>         { /* sentinel */ }
> > >>
> > >> Is your board using one of these compatible string ?
> > >
> > > The x15 uses "snps,dwc-ahci". I would expect it to detect the device
> > > with the new driver if that is loaded, but it's possible that the
> > > driver does not work on all versions of the dwc-ahci hardware.
> > >
> > > Anders, can you provide the boot log from a boot with the new driver
> > > built in? There should be some messages from dwc-ahci about finding
> > > the device, but then not ultimately working.
> > >
> > > Depending on which way it goes wrong, the safest fallback for 6.1 is
> > > probably to move the "snps,spear-ahci" and "snps,dwc-ahci" compatible
> > > strings back into the old driver, and leave the new one only for
> > > the "baikal,bt1-ahci" implementation of it, until it has been
> > > successfully verified on TI am5/dra7, spear13xx and exynos.
> >
> > OK. So a fix patch until further tests/debug is completed would be this:
> >
> > diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
> > index 8fb66860db31..7a0cbab00843 100644
> > --- a/drivers/ata/ahci_dwc.c
> > +++ b/drivers/ata/ahci_dwc.c
> > @@ -469,8 +469,6 @@ static struct ahci_dwc_plat_data ahci_bt1_plat = {
> >  };
> >
> >  static const struct of_device_id ahci_dwc_of_match[] = {
> > -       { .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
> > -       { .compatible = "snps,spear-ahci", &ahci_dwc_plat },
> >         { .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },
> >         {},
> >  };
> > diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > index 8f5572a9f8f1..9b56490ecbc3 100644
> > --- a/drivers/ata/ahci_platform.c
> > +++ b/drivers/ata/ahci_platform.c
> > @@ -80,7 +80,9 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> >  static const struct of_device_id ahci_of_match[] = {
> >         { .compatible = "generic-ahci", },
> >         /* Keep the following compatibles for device tree compatibility */
> > +       { .compatible = "snps,spear-ahci", },
> >         { .compatible = "ibm,476gtr-ahci", },
> > +       { .compatible = "snps,dwc-ahci", },
> >         { .compatible = "hisilicon,hisi-ahci", },
> >         { .compatible = "cavium,octeon-7130-ahci", },
> >         { /* sentinel */ }
> >
> > Anders, Naresh,
> >
> > Can you try this ?
> 

> Tested this patch on todays linux-next tag: next-20221014 without enabling
> CONFIG_AHCI_DWC and it worked as expected when booting [1].
> On the other hand I also tried a build/boot with CONFIG_AHCI_DWC enabled
> and it worked as expected to boot [2].

Expected result. The DWC driver will probe the device on our platform
only while your platform falls back to using the generic driver.
Anders, in order understand the root cause of the problem could you please
1. upload the bogus boot log.
2. try what I suggested here
Link: https://lore.kernel.org/linux-ide/20221014133623.l6w4o7onoyhv2q34@mobilestation/
and if the system fails to boot at some point upload the boot log.

-Sergey

> However, during building a warning [3] popped up:
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/2/build ARCH=arm
> CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
> arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
> /builds/linux/drivers/ata/ahci_dwc.c:462:34: warning: 'ahci_dwc_plat'
> defined but not used [-Wunused-variable]
>   462 | static struct ahci_dwc_plat_data ahci_dwc_plat = {
>          |                                  ^~~~~~~~~~~~~
> 
> 
> Cheers,
> Anders
> [1] https://lkft.validation.linaro.org/scheduler/job/5678031
> [2] https://lkft.validation.linaro.org/scheduler/job/5678152
> [3] https://builds.tuxbuild.com/2G7PDSV5uzjnQqCCBybK4WpoTxz/build.log
> 

