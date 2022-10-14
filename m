Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228F15FEEE0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJNNpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJNNpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:45:13 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DADAC61107;
        Fri, 14 Oct 2022 06:45:03 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 6861EE0EAF;
        Fri, 14 Oct 2022 16:36:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=DFhKs9MrirQaiOZ32oCv
        Gy48XkIsr8wHKoyoiWR3Cp8=; b=GMMV3fVoX7j4TBDp+8qrYzp29d4RSyIj77yI
        T73LVMMS/6rs1XvOtSleAl2gKkSkw6nuS90aZf5Ixzn03N2tqOqPJj19ukNQCY/x
        aEW1PYu6dNVBbr4HwudSYXy0tMQjHqWdgXGc5wyFxCYs+ouKMf1lBUuhrb8DKcCn
        hwTs38A=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 51CC6E0E6A;
        Fri, 14 Oct 2022 16:36:24 +0300 (MSK)
Received: from mobilestation (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 14 Oct 2022 16:36:24 +0300
Date:   Fri, 14 Oct 2022 16:36:23 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Anders Roxell <anders.roxell@linaro.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <regressions@lists.linux.dev>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, <lkft-triage@lists.linaro.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Message-ID: <20221014133623.l6w4o7onoyhv2q34@mobilestation>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
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

Hello Damien, Anders

On Fri, Oct 14, 2022 at 09:22:34AM +0900, Damien Le Moal wrote:
> On 10/14/22 07:07, Anders Roxell wrote:
> [...]
> >> 8)
> >>> If reverting these patches restores the eSATA port on this board, then you need
> >>> to fix the defconfig for that board.
> >>
> >> OTOH,
> >> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
> >> device failed to boot.
> > 
> > I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
> 
> As mentioned in my previous reply to Naresh, this is a new driver added in
> 6.1. Your board was working before so this should not be the driver needed
> for it.
> 
> > However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
> > controller support")
> > from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
> > successful.
> 
> Which is very strange... There is only one hunk in that commit that could
> be considered suspicious:
> 
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 9b56490ecbc3..8f5572a9f8f1 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
>  static const struct of_device_id ahci_of_match[] = {
>         { .compatible = "generic-ahci", },
>         /* Keep the following compatibles for device tree compatibility */
> -       { .compatible = "snps,spear-ahci", },
>         { .compatible = "ibm,476gtr-ahci", },
> -       { .compatible = "snps,dwc-ahci", },
>         { .compatible = "hisilicon,hisi-ahci", },
>         { .compatible = "cavium,octeon-7130-ahci", },
>         { /* sentinel */ }
> 

> Is your board using one of these compatible string ?

No. My board isn't using them. As a quick-fix they could be got back
to the generic driver. But please see below.

> 
> Serge ?
> Any idea ?

The only difference between ahci_platform.c and ahci_dwc.c relevant to
these compatibles is in calling the next methods:
 ahci_dwc_check_cap(hpriv);
 ahci_dwc_init_timer(hpriv);
 ahci_dwc_init_dmacr(hpriv);
As a first step on debugging the problem I would comment them out and
try to boot the system with the snps,dwc-ahci device being probed by
the ahci_dwc.c driver.

Let's try to test that out first. Then we can narrow down the scale
by commenting out one of these methods and then up to some parts of
it. What do you think?

-Sergey

> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
> 

