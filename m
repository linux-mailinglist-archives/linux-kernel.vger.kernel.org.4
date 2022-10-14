Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6871E5FEEBF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJNNiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJNNiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:38:17 -0400
X-Greylist: delayed 105 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Oct 2022 06:38:11 PDT
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BB701CEC18;
        Fri, 14 Oct 2022 06:38:11 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 493A7E0EB0;
        Fri, 14 Oct 2022 16:38:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=tB3OHq7bYnhkcWPFlFs5
        S7PCgQ9HEyIk8ZzvhKNoftg=; b=ovGonsdt2qJz2rPQrFmlmhF1O+1Va9yh6CuK
        +ugln6+efOHDJKjYYHGesL6HZenZVyZ7+OSn8qXhzRuEeC552HRSQFssikMeWh2Z
        Z2Kr1dj7SFoCwPhS5x2JNDyaAuilQRjp3aMyGW3n8imkbv8nGqopUjgj/HeFyS8E
        d6JPlwY=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 3412FE0E6A;
        Fri, 14 Oct 2022 16:38:10 +0300 (MSK)
Received: from mobilestation (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Oct 2022 16:38:09 +0300
Date:   Fri, 14 Oct 2022 16:38:09 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Anders Roxell <anders.roxell@linaro.org>,
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
Message-ID: <20221014133809.y7wvbxx2cvmsjoo7@mobilestation>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
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

On Fri, Oct 14, 2022 at 09:31:55AM +0200, Arnd Bergmann wrote:
> On Fri, Oct 14, 2022, at 2:22 AM, Damien Le Moal wrote:
> > On 10/14/22 07:07, Anders Roxell wrote:
> > [...]
> >>> 8)
> >>>> If reverting these patches restores the eSATA port on this board, then you need
> >>>> to fix the defconfig for that board.
> >>>
> >>> OTOH,
> >>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
> >>> device failed to boot.
> >> 
> >> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
> >
> > As mentioned in my previous reply to Naresh, this is a new driver added in
> > 6.1. Your board was working before so this should not be the driver needed
> > for it.
> >
> >> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
> >> controller support")
> >> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
> >> successful.
> >
> > Which is very strange... There is only one hunk in that commit that could
> > be considered suspicious:
> >
> > diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > index 9b56490ecbc3..8f5572a9f8f1 100644
> > --- a/drivers/ata/ahci_platform.c
> > +++ b/drivers/ata/ahci_platform.c
> > @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> >  static const struct of_device_id ahci_of_match[] = {
> >         { .compatible = "generic-ahci", },
> >         /* Keep the following compatibles for device tree compatibility */
> > -       { .compatible = "snps,spear-ahci", },
> >         { .compatible = "ibm,476gtr-ahci", },
> > -       { .compatible = "snps,dwc-ahci", },
> >         { .compatible = "hisilicon,hisi-ahci", },
> >         { .compatible = "cavium,octeon-7130-ahci", },
> >         { /* sentinel */ }
> >
> > Is your board using one of these compatible string ?
> 
> The x15 uses "snps,dwc-ahci". I would expect it to detect the device
> with the new driver if that is loaded, but it's possible that the
> driver does not work on all versions of the dwc-ahci hardware.
> 

> Anders, can you provide the boot log from a boot with the new driver
> built in? There should be some messages from dwc-ahci about finding
> the device, but then not ultimately working.
> 

Yes. The boot-log would be very useful.

> Depending on which way it goes wrong, the safest fallback for 6.1 is
> probably to move the "snps,spear-ahci" and "snps,dwc-ahci" compatible
> strings back into the old driver, and leave the new one only for 
> the "baikal,bt1-ahci" implementation of it, until it has been
> successfully verified on TI am5/dra7, spear13xx and exynos.

Right. This would be a possible solution. But I'd rather suggest to at
least try to debug the problem.

-Sergey

> 
>      Arnd
> 

