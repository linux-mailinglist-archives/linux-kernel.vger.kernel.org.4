Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC46007F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJQHnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiJQHnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:43:39 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6125AC57
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:43:36 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 70so10230046pjo.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rPe4UeCT4utjHaWsW73z6gTqrta8SnxVBVme5GLMWDo=;
        b=XURPRulyI7GBQkDYjbL29j6b7fNvlGFidOglpITLHCDt5F+d3TwghzPEurh5SVX0pV
         tXVr/4xjzWfQXw7n8X4tX0YytM5fZGaPEYpYqsaqrG2nP8qOqL3ONC+f+W3OACBskxHG
         5g4qTa3vYKROE/9I1BwZC1NwRKXPCawbTS/1WbyFCehUzGwOs2FH+QhyyS0CWxCY0YwD
         6RZ8MjFhYpzQXWQoAQLPz/VpOQLLE3JJb/Hdd3+hpDS5d2oTq30np5PkY4+eobDN6Wle
         Tn6aB5DmbXLPAZ5lnnNtn8qUUXw61kawSCiInP1KYMCwimZCcfmXiqeG2SViSys2AZOS
         WO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPe4UeCT4utjHaWsW73z6gTqrta8SnxVBVme5GLMWDo=;
        b=t6209EqFE8frJkQBkNfUmp0S6SdumvifZcBP5zvf7hVPL8StCcpaJP9cC/A120WGxE
         Ycj5kUkZX/cVcdEvt49Y5OFf1ZeBktmeszSv56AHXkIGhFyF+0oO9jOBqfli3cxSYJn/
         OQb7+NGTChzLCuVh1v6eBJFgPpoPdV4lBpbsUJPLAa6uCI3oXo2PB4mLMOY6n3kNgnfW
         E/JZJ1uga+DiFyus16J8+LOc2GB766Fuljeix/GrKAOYArQ+k2Nq2IeKQptu22tAO2vF
         HXyju877BC0y6A6V226+SDtE/7l/rBnpjOh+ZRBriQVghQPwohN50Pgtpef39n903y4J
         8iuw==
X-Gm-Message-State: ACrzQf2thtEPsvyVZiR01qyiBUPR69tnvLNOSZ707dgXFBHsxLEjXQqv
        HRHpDDlvMemven2PaZlpJO8jlTfshSYIOlip2Tnq6w==
X-Google-Smtp-Source: AMsMyM6zOiheEh4N7KSI0CXPvmDFJU1CBHXMIaYT5uIJkfwzlmGNQlwE0vxfa7DWYKMARCwt5PbD8BFew/kViQjETJQ=
X-Received: by 2002:a17:90b:4f87:b0:20b:12e3:32ae with SMTP id
 qe7-20020a17090b4f8700b0020b12e332aemr12370517pjb.236.1665992614969; Mon, 17
 Oct 2022 00:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvRXkjeO+yDEQxwJ8+GjSmwhZ7XHHAaVWAsxAaSngj5gg@mail.gmail.com>
 <bf1b053d-ffa6-48ab-d2d2-d59ab21afc19@opensource.wdc.com> <CA+G9fYvUnn0cS+_DZm8hAfi=FnMB08+6Xnhud6yvi9Bxh=DU+Q@mail.gmail.com>
 <CADYN=9L8tt2T-8O+u5NSMSUOkZDvEggnvzxH6aMmd5Rn9yDeuw@mail.gmail.com>
 <ca8d3fff-0365-24d9-fd53-5799ac34f336@opensource.wdc.com> <7ee4a1bd-0674-42d8-8980-8b029ca09e71@app.fastmail.com>
 <75eaeab3-7781-d60a-ae61-ae837f5dcec9@opensource.wdc.com> <CADYN=9JiX-=PcKMzAcSm=p7Dh6kYT7Kbv-8kcNF0MQ4=1hFS5g@mail.gmail.com>
 <20221014140633.mlypet7skkxvt453@mobilestation>
In-Reply-To: <20221014140633.mlypet7skkxvt453@mobilestation>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 17 Oct 2022 09:43:24 +0200
Message-ID: <CADYN=9LrKHRNMON3GA4piDvWeSWTASQ1u2=D30rXFdvo1L18bg@mail.gmail.com>
Subject: Re: TI: X15 the connected SSD is not detected on Linux next 20221006 tag
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 at 16:06, Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> On Fri, Oct 14, 2022 at 11:22:38AM +0200, Anders Roxell wrote:
> > On Fri, 14 Oct 2022 at 09:53, Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> > >
> > > On 10/14/22 16:31, Arnd Bergmann wrote:
> > > > On Fri, Oct 14, 2022, at 2:22 AM, Damien Le Moal wrote:
> > > >> On 10/14/22 07:07, Anders Roxell wrote:
> > > >> [...]
> > > >>>> 8)
> > > >>>>> If reverting these patches restores the eSATA port on this board, then you need
> > > >>>>> to fix the defconfig for that board.
> > > >>>>
> > > >>>> OTOH,
> > > >>>> Anders, enabled the new config CONFIG_AHCI_DWC=y  and tried but the
> > > >>>> device failed to boot.
> > > >>>
> > > >>> I thought it would work with enabling CONFIG_AHCI_DWC=y, but it didn't...
> > > >>
> > > >> As mentioned in my previous reply to Naresh, this is a new driver added in
> > > >> 6.1. Your board was working before so this should not be the driver needed
> > > >> for it.
> > > >>
> > > >>> However, reverting patch 33629d35090f ("ata: ahci: Add DWC AHCI SATA
> > > >>> controller support")
> > > >>> from next-20221013 was a success, kernel booted  and the 'mkfs.ext4' cmd was
> > > >>> successful.
> > > >>
> > > >> Which is very strange... There is only one hunk in that commit that could
> > > >> be considered suspicious:
> > > >>
> > > >> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > > >> index 9b56490ecbc3..8f5572a9f8f1 100644
> > > >> --- a/drivers/ata/ahci_platform.c
> > > >> +++ b/drivers/ata/ahci_platform.c
> > > >> @@ -80,9 +80,7 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> > > >>  static const struct of_device_id ahci_of_match[] = {
> > > >>         { .compatible = "generic-ahci", },
> > > >>         /* Keep the following compatibles for device tree compatibility */
> > > >> -       { .compatible = "snps,spear-ahci", },
> > > >>         { .compatible = "ibm,476gtr-ahci", },
> > > >> -       { .compatible = "snps,dwc-ahci", },
> > > >>         { .compatible = "hisilicon,hisi-ahci", },
> > > >>         { .compatible = "cavium,octeon-7130-ahci", },
> > > >>         { /* sentinel */ }
> > > >>
> > > >> Is your board using one of these compatible string ?
> > > >
> > > > The x15 uses "snps,dwc-ahci". I would expect it to detect the device
> > > > with the new driver if that is loaded, but it's possible that the
> > > > driver does not work on all versions of the dwc-ahci hardware.
> > > >
> > > > Anders, can you provide the boot log from a boot with the new driver
> > > > built in? There should be some messages from dwc-ahci about finding
> > > > the device, but then not ultimately working.
> > > >
> > > > Depending on which way it goes wrong, the safest fallback for 6.1 is
> > > > probably to move the "snps,spear-ahci" and "snps,dwc-ahci" compatible
> > > > strings back into the old driver, and leave the new one only for
> > > > the "baikal,bt1-ahci" implementation of it, until it has been
> > > > successfully verified on TI am5/dra7, spear13xx and exynos.
> > >
> > > OK. So a fix patch until further tests/debug is completed would be this:
> > >
> > > diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
> > > index 8fb66860db31..7a0cbab00843 100644
> > > --- a/drivers/ata/ahci_dwc.c
> > > +++ b/drivers/ata/ahci_dwc.c
> > > @@ -469,8 +469,6 @@ static struct ahci_dwc_plat_data ahci_bt1_plat = {
> > >  };
> > >
> > >  static const struct of_device_id ahci_dwc_of_match[] = {
> > > -       { .compatible = "snps,dwc-ahci", &ahci_dwc_plat },
> > > -       { .compatible = "snps,spear-ahci", &ahci_dwc_plat },
> > >         { .compatible = "baikal,bt1-ahci", &ahci_bt1_plat },
> > >         {},
> > >  };
> > > diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > > index 8f5572a9f8f1..9b56490ecbc3 100644
> > > --- a/drivers/ata/ahci_platform.c
> > > +++ b/drivers/ata/ahci_platform.c
> > > @@ -80,7 +80,9 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
> > >  static const struct of_device_id ahci_of_match[] = {
> > >         { .compatible = "generic-ahci", },
> > >         /* Keep the following compatibles for device tree compatibility */
> > > +       { .compatible = "snps,spear-ahci", },
> > >         { .compatible = "ibm,476gtr-ahci", },
> > > +       { .compatible = "snps,dwc-ahci", },
> > >         { .compatible = "hisilicon,hisi-ahci", },
> > >         { .compatible = "cavium,octeon-7130-ahci", },
> > >         { /* sentinel */ }
> > >
> > > Anders, Naresh,
> > >
> > > Can you try this ?
> >
>
> > Tested this patch on todays linux-next tag: next-20221014 without enabling
> > CONFIG_AHCI_DWC and it worked as expected when booting [1].
> > On the other hand I also tried a build/boot with CONFIG_AHCI_DWC enabled
> > and it worked as expected to boot [2].
>
> Expected result. The DWC driver will probe the device on our platform
> only while your platform falls back to using the generic driver.
> Anders, in order understand the root cause of the problem could you please
> 1. upload the bogus boot log.

This [1] is the bogus boot log.

> 2. try what I suggested here
> Link: https://lore.kernel.org/linux-ide/20221014133623.l6w4o7onoyhv2q34@mobilestation/
> and if the system fails to boot at some point upload the boot log.

Only doing this:

--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -316,12 +316,13 @@ static int ahci_dwc_init_host(struct
ahci_host_priv *hpriv)
  if (rc)
  goto err_disable_resources;
  }
-
+/*
  ahci_dwc_check_cap(hpriv);

  ahci_dwc_init_timer(hpriv);

  rc = ahci_dwc_init_dmacr(hpriv);
+*/
  if (rc)
  goto err_clear_platform;

and enable CONFIG_AHCI_DWC made the mkfs to detect the SATA drive [2].

Cheers,
Anders
[1] https://lkft.validation.linaro.org/scheduler/job/5634743#L2580
[2] https://lkft.validation.linaro.org/scheduler/job/5679278#L2617
