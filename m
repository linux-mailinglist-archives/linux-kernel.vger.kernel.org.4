Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C081601300
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 17:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiJQPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 11:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJQPwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:52:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9392966874;
        Mon, 17 Oct 2022 08:52:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r14so18205795lfm.2;
        Mon, 17 Oct 2022 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xwn9lDC6qeLpckKuqyKYPC8KqluzBnCmAuCKvK4EiN8=;
        b=TxDVu2SvdVGSD0Eqblix56bCl3aJ8/0KnuvUdesjmnKa9wxMv9qDqAeE5FZYTumwAu
         Yb8eyMv9jz9ZVd9MzbnFPWMnVbfUFCiSCIJzTKoTUCNhYxfsA2bQEiLqYpL9dqsrCMIh
         BCRFAKLklF7ALLKU6sOJQHpHQYMzlERpNhgQgRTPi4FLsDdC/4bN9WVuctJqAE9zzeSJ
         fzTv5PgBNBlBj1wU1oOFQ4o0ywyfJGIp4QIP7aAfwDqxM6OrKMj06PuZ2SdEYywpbrIp
         wwg4UL4FXsgj01RFPtJhsS94UvQBB48J1AlCsl9HVF7V/h2tF9O5+j9afpAS27o1rJxR
         EXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwn9lDC6qeLpckKuqyKYPC8KqluzBnCmAuCKvK4EiN8=;
        b=xgpoHPp911isgNxiT/Hzar3wnUDELL6U1cA8cFfnFPjqF0KkbWCKxP1+kacMp9NhYN
         g6LwEldpHMwbRdJ3vOBm9obXUDMDga+mhEDbJu5qOoQQwDFc+M0QlLwpggyRJpzJElZ6
         GPUdtDtG94qPFouEL/i1+cOYosCq/OTXDdmZ9M/6Hnkm3qyuT9ueSmxwW1YBVi0yiegY
         ne22iLuV7lvwSMxGlou9OryivbKdEvLvQoRb4x9ecUtKDSSvo8mmenL9iezb3fF7ELhs
         IXYe2dH50Ve6OwOEpQQrHtymWOhIeuUrPnsFLfJWXcnnqBnYq1849iMch9YDG7NfWpdJ
         YdJw==
X-Gm-Message-State: ACrzQf2aONZ5pE1s+u1HpVFAn0XCTiDTWkKWdJwtcRBWQppcIt1920C5
        3ILm456fP0NWVyMRwby6Vak=
X-Google-Smtp-Source: AMsMyM4c62yxCuiYr9QR5J6H8Zs0A56qFxHUrUwBdUC8cax9F+RqMVpaVQbP2D4fczz9WMM5GBeSGQ==
X-Received: by 2002:ac2:514e:0:b0:4a2:34a4:2d9b with SMTP id q14-20020ac2514e000000b004a234a42d9bmr4501195lfd.166.1666021969636;
        Mon, 17 Oct 2022 08:52:49 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id i25-20020a196d19000000b004a1e7216131sm1473532lfc.116.2022.10.17.08.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 08:52:49 -0700 (PDT)
Date:   Mon, 17 Oct 2022 18:52:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        regressions@lists.linux.dev,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006
 tag
Message-ID: <20221017155246.zxal2cfehjgaajcu@mobilestation>
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com>
 <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com>
 <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com>
 <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation>
 <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 09:43:24AM +0200, Anders Roxell wrote:
> On Fri, 14 Oct 2022 at 16:06, Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > On Fri, Oct 14, 2022 at 11:22:38AM +0200, Anders Roxell wrote:
> > > On Fri, 14 Oct 2022 at 09:53, Damien Le Moal
> > > <damien.lemoal@opensource.wdc.com> wrote:
> > > >
> > > > On 10/14/22 16:31, Arnd Bergmann wrote:
> > > > > On Fri, Oct 14, 2022, at 2:22 AM, Damien Le Moal wrote:
> > > > >> On 10/14/22 07:07, Anders Roxell wrote:
> > > > >> [...]
> > > > >>>> 8)
> > > > >>>>> If reverting these patches restores the eSATA port on this board, then you need
> > > > >>>>> to fix the defconfig for that board.
> > > > >>>>
> > > > >>>> OTOH,
> > > > >>>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
> > > > >>>> device failed to boot.
> > > > >>>
> > > > >>> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
> > > > >>
> > > > >> As mentioned in my previous reply to Naresh, this is a new driver added in
> > > > >> 6.1. Your board was working before so this should not be the driver needed
> > > > >> for it.
> > > > >>
> > > > >>> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
> > > > >>> controller support")
> > > > >>> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
> > > > >>> successful.
> > > > >>
> > > > >> Which is very strange... There is only one hunk in that commit that could
> > > > >> be considered suspicious:
> > > > >>
> > > > >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > > > >> index 9b56490ecbc3..8f5572a9f8f1 100644
> > > > >> --- a/drivers/ata/ahci_platform.c
> > > > >> +++ b/drivers/ata/ahci_platform.c
> > > > >> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> > > > >>  static const struct of_device_id ahci_of_match[] = {
> > > > >>         { .compatible = "generic-ahci", },
> > > > >>         /* Keep the following compatibles for device tree compatibility */
> > > > >> -       { .compatible = "snps,spear-ahci", },
> > > > >>         { .compatible = "ibm,476gtr-ahci", },
> > > > >> -       { .compatible = "snps,dwc-ahci", },
> > > > >>         { .compatible = "hisilicon,hisi-ahci", },
> > > > >>         { .compatible = "cavium,octeon-7130-ahci", },
> > > > >>         { /* sentinel */ }
> > > > >>
> > > > >> Is your board using one of these compatible string ?
> > > > >
> > > > > The x15 uses "snps,dwc-ahci". I would expect it to detect the device
> > > > > with the new driver if that is loaded, but it's possible that the
> > > > > driver does not work on all versions of the dwc-ahci hardware.
> > > > >
> > > > > Anders, can you provide the boot log from a boot with the new driver
> > > > > built in? There should be some messages from dwc-ahci about finding
> > > > > the device, but then not ultimately working.
> > > > >
> > > > > Depending on which way it goes wrong, the safest fallback for 6.1 is
> > > > > probably to move the "snps,spear-ahci" and "snps,dwc-ahci" compatible
> > > > > strings back into the old driver, and leave the new one only for
> > > > > the "baikal,bt1-ahci" implementation of it, until it has been
> > > > > successfully verified on TI am5/dra7, spear13xx and exynos.
> > > >
> > > > OK. So a fix patch until further tests/debug is completed would be this:
> > > >
> > > > diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
> > > > index 8fb66860db31..7a0cbab00843 100644
> > > > --- a/drivers/ata/ahci_dwc.c
> > > > +++ b/drivers/ata/ahci_dwc.c
> > > > @@ -469,8 +469,6 @@ static struct ahci_dwc_plat_data ahci_bt1_plat = {
> > > >  };
> > > >
> > > >  static const struct of_device_id ahci_dwc_of_match[] = {
> > > > -       { .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
> > > > -       { .compatible = "snps,spear-ahci", &ahci_dwc_plat },
> > > >         { .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },
> > > >         {},
> > > >  };
> > > > diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > > > index 8f5572a9f8f1..9b56490ecbc3 100644
> > > > --- a/drivers/ata/ahci_platform.c
> > > > +++ b/drivers/ata/ahci_platform.c
> > > > @@ -80,7 +80,9 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> > > >  static const struct of_device_id ahci_of_match[] = {
> > > >         { .compatible = "generic-ahci", },
> > > >         /* Keep the following compatibles for device tree compatibility */
> > > > +       { .compatible = "snps,spear-ahci", },
> > > >         { .compatible = "ibm,476gtr-ahci", },
> > > > +       { .compatible = "snps,dwc-ahci", },
> > > >         { .compatible = "hisilicon,hisi-ahci", },
> > > >         { .compatible = "cavium,octeon-7130-ahci", },
> > > >         { /* sentinel */ }
> > > >
> > > > Anders, Naresh,
> > > >
> > > > Can you try this ?
> > >
> >
> > > Tested this patch on todays linux-next tag: next-20221014 without enabling
> > > CONFIG_AHCI_DWC and it worked as expected when booting [1].
> > > On the other hand I also tried a build/boot with CONFIG_AHCI_DWC enabled
> > > and it worked as expected to boot [2].
> >
> > Expected result. The DWC driver will probe the device on our platform
> > only while your platform falls back to using the generic driver.
> > Anders, in order understand the root cause of the problem could you please
> > 1. upload the bogus boot log.
>
 
> This [1] is the bogus boot log.
> 
> > 2. try what I suggested here
> > Link: https://lore.kernel.org/linux-ide/20221014133623.l6w4o7onoyhv2q34@mobilestation/
> > and if the system fails to boot at some point upload the boot log.
> 
> Only doing this:
> 
> --- a/drivers/ata/ahci_dwc.c
> +++ b/drivers/ata/ahci_dwc.c
> @@ -316,12 +316,13 @@ static int ahci_dwc_init_host(struct
> ahci_host_priv *hpriv)
>   if (rc)
>   goto err_disable_resources;
>   }
> -
> +/*
>   ahci_dwc_check_cap(hpriv);
> 
>   ahci_dwc_init_timer(hpriv);
> 
>   rc = ahci_dwc_init_dmacr(hpriv);
> +*/
>   if (rc)
>   goto err_clear_platform;
> 
> and enable CONFIG_AHCI_DWC made the mkfs to detect the SATA drive [2].

Judging by what is in [1] and [2] I have much doubt that [1] was
executed with the CONFIG_AHCI_DWC config enabled because the boot log has
nothing about the ahci-dwc driver probe failure or none of the logs
messages seen in [2] (see every line with the ahci-dwc word in it).

1. If you had the device probe procedure failed at some point you
would have got a line like this:
< ahci-dwc: probe of 4a140000.sata failed with error -errno
But there is no such line in [1]. There is literally nothing
AHCI/SATA/SCSI/DWC AHCI/ahci-dwc/etc in it.

2. If you had the DW AHCI device probe at least performed, then the next
calls-chain would have been executed:
ahci_dwc_probe()
+-> ahci_dwc_get_resources()
    +-> ahci_platform_get_resources()
        +-> ...
        +-> devm_regulator_get(...)
        +-> ...
which would have caused the next log messages:
< [] ahci-dwc 4a140000.sata: supply ahci not found, using dummy regulator
< [] ahci-dwc 4a140000.sata: supply phy not found, using dummy regulator
< [] ahci-dwc 4a140000.sata: supply target not found, using dummy regulator
You do have these lines in [2] but missing them in [1]. Should you
have any errors in ahci_dwc_probe() detected before that you would
have an error printed as I noted in 1.

3. Should the problem was in the commented out code lines you would
have at least got the messages above printed to the log [1] because
the commented out code is executed after the resources request
procedure (see the ahci_dwc_init_host() method is called after
ahci_dwc_get_resources()).

4. Finally the commented out code doesn't really do any actions which
could have caused the device probe to silently halt.

All of that makes me thinking that the DW AHCI SATA wasn't even probed
in [1] which most likely means that either the driver config was
omitted there or the device was disabled. So could you please re-start
the system like in [2] but uncomment the lines above?

* Please make sure the Damien's fix
https://www.spinics.net/lists/arm-kernel/msg1017920.html
isn't applied on the kernel [2].

[1] https://lkft.validation.linaro.org/scheduler/job/5634743#L2580
[2] https://lkft.validation.linaro.org/scheduler/job/5679278#L2617

-Sergey

> 
> Cheers,
> Anders
> [1] https://lkft.validation.linaro.org/scheduler/job/5634743#L2580
> [2] https://lkft.validation.linaro.org/scheduler/job/5679278#L2617
