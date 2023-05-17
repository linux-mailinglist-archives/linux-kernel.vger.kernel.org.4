Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97937062F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjEQIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjEQIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:32:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EA81BF8;
        Wed, 17 May 2023 01:32:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64a9335a8e7so11482877b3a.0;
        Wed, 17 May 2023 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684312324; x=1686904324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aM66uzmo09xcCOOPPJQfJ1239TmOWVAFAFF8/sMHxJk=;
        b=M2qSdXX5XEjDy8173X1BQyXgfZWxgjnuDh7lfxjiN34F/rl1WyhGxThNwxIdFPtsgi
         nhPYtEGotdFU9fABOYPGOTeViZPn+sN1y3rteMpv+9zSSQzw7owwr6XhSuDET29KJnOq
         SzUYzqxXFajwPr4esZUy4N9FcQbLvXlr8ylsB7lxL7RoGg0D2Cm87JzFrSJX7jS0UwPA
         dlcw9V+VDEpkWCQUUgj1K9sIRZYsY+jmgYL6aB5i38iX2uRMu4QukHiJrUUteaShveAp
         ySYsz0PO1XP1ZSXkjtYxT0oH9gJHHhxkE8wyRfluXoTQIChsYGEjGNXB+UuKiLjqVtn/
         1m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312324; x=1686904324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aM66uzmo09xcCOOPPJQfJ1239TmOWVAFAFF8/sMHxJk=;
        b=Ld2ylL4LQkHm7qOz6DjR3UH8wwWYdlEe8cHQPFfHGUBw5EtJMW0qYYAWnNT7rDgF8g
         s/ScyggPaDwpub0/lXoy8viD+V2DhKPrF2IZ2DOemD2elza7uuL0LOAI4XHc5JjLDdYb
         ffB4ugOm2oR+F3FGwquCHA1WlzkcBIa1a/4eNlWhkssgqIWJ1Nvz96R0gKop2IWrTdbj
         nmGu7huy48BegEvVZwUeoC+EMsfHVY/26KDqHgdyPeZtASGaS/TiNaQjLfId6PFOUR8y
         QIFknrEIARI0I6/qaVLIfvDVFUMne/lXPBm+ss5SeJfS0C5MFvE3xZ3rVgWYLOchls9H
         fMbQ==
X-Gm-Message-State: AC+VfDxIVn/riSJTTICaWyCZ8MS6kXyVQOFO9KXpMQCqOuyTxdE2u3Q8
        j31JTkiB0LvcZkVESLSR5FsyuZ4GYcW5T8m6GvU=
X-Google-Smtp-Source: ACHHUZ4iyaYrxVZMxySGUTOPYWhxpLgFfi9ixRGluwwJJKuYvKkERWG25wDH/5UXmoUZ6NvcPCTfdzogMeS4zYeWaPw=
X-Received: by 2002:a17:90a:1181:b0:24e:3413:c7ff with SMTP id
 e1-20020a17090a118100b0024e3413c7ffmr1926164pja.7.1684312324177; Wed, 17 May
 2023 01:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230511135632.78344-1-bstruempfel@ultratronik.de> <BN7PR12MB280217A4D088BE2D951B9A6DDC789@BN7PR12MB2802.namprd12.prod.outlook.com>
In-Reply-To: <BN7PR12MB280217A4D088BE2D951B9A6DDC789@BN7PR12MB2802.namprd12.prod.outlook.com>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Wed, 17 May 2023 10:31:53 +0200
Message-ID: <CAEktqcsFUT=2236bj37xAbcFO750UxQrbPvi+jczZmS-hNJSdA@mail.gmail.com>
Subject: Re: [PATCH] spi: Add option to keep the MOSI line low, when it is idle.
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc:     "bstruempfel@ultratronik.de" <bstruempfel@ultratronik.de>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 15. Mai 2023 um 08:37 Uhr schrieb Mahapatra, Amit Kumar
<amit.kumar-mahapatra@amd.com>:
>
> Hello,
>
> > -----Original Message-----
> > From: Boerge Struempfel <boerge.struempfel@gmail.com>
> > Sent: Thursday, May 11, 2023 7:27 PM
> > Cc: boerge.struempfel@gmail.com; bstruempfel@ultratronik.de; Mark
> > Brown <broonie@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha
> > Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; NXP
> > Linux Team <linux-imx@nxp.com>; linux-spi@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH] spi: Add option to keep the MOSI line low, when it is idle.
> >
> > CAUTION: This message has originated from an External Source. Please use
> > proper judgment and caution when opening attachments, clicking links, or
> > responding to this email.
> >
> >
> > By default, the imx spi controller uses a high mosi line, whenever it is idle.
> > This may not be desired in all use cases. For example neopixel leds can get
> > confused and flicker due to misinterpreting the idle state.
> > Therefore, we introduce a new spi-mode bit, with which the idle behaviour
> > can be overwritten on a per device basis.
> >
> > Signed-off-by: Boerge Struempfel <bstruempfel@ultratronik.de>
> > ---
> >  drivers/spi/spi-imx.c        | 9 ++++++++-
> >  drivers/spi/spi.c            | 2 ++
> >  include/uapi/linux/spi/spi.h | 3 ++-
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > 34e5f81ec431e..6acab2b4ffaa5 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -281,6 +281,7 @@ static bool spi_imx_can_dma(struct spi_controller
> > *controller, struct spi_device  #define MX51_ECSPI_CONFIG_SCLKPOL(cs)  (1
> > << ((cs & 3) +  4))  #define MX51_ECSPI_CONFIG_SBBCTRL(cs)  (1 << ((cs & 3) +
> > 8))
> >  #define MX51_ECSPI_CONFIG_SSBPOL(cs)   (1 << ((cs & 3) + 12))
> > +#define MX51_ECSPI_CONFIG_DATACTL(cs)  (1 << ((cs & 3) + 16))
> >  #define MX51_ECSPI_CONFIG_SCLKCTL(cs)  (1 << ((cs & 3) + 20))
> >
> >  #define MX51_ECSPI_INT         0x10
> > @@ -573,6 +574,11 @@ static int mx51_ecspi_prepare_message(struct
> > spi_imx_data *spi_imx,
> >                 cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi_get_chipselect(spi, 0));
> >         }
> >
> > +       if (spi->mode & SPI_MOSI_IDLE_LOW)
> > +               cfg |= MX51_ECSPI_CONFIG_DATACTL(spi->chip_select);
>
> Kindly replace all occurrence of spi->chip_select with spi_get_chipselect(spi, 0)
> https://github.com/torvalds/linux/commit/9e264f3f85a56cc109cc2d6010a48aa89d5c1ff1
Thank you very much for noticing this. I have changed it for the next
version of the patch.
>
> > +       else
> > +               cfg &= ~MX51_ECSPI_CONFIG_DATACTL(spi->chip_select);
>
> > +
> >         if (spi->mode & SPI_CS_HIGH)
> >                 cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi_get_chipselect(spi, 0));
> >         else
> > @@ -1743,7 +1749,8 @@ static int spi_imx_probe(struct platform_device
> > *pdev)
> >         spi_imx->controller->prepare_message = spi_imx_prepare_message;
> >         spi_imx->controller->unprepare_message =
> > spi_imx_unprepare_message;
> >         spi_imx->controller->slave_abort = spi_imx_slave_abort;
> > -       spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
> > SPI_NO_CS;
> > +       spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH
> > | SPI_NO_CS |
> > +                                        SPI_MOSI_IDLE_LOW;
> >
> >         if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
> >             is_imx53_ecspi(spi_imx))
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c index
> > 9291b2a0e8871..3ad538b317a84 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -2260,6 +2260,8 @@ static int of_spi_parse_dt(struct spi_controller
> > *ctlr, struct spi_device *spi,
> >                 spi->mode |= SPI_LSB_FIRST;
> >         if (of_property_read_bool(nc, "spi-cs-high"))
> >                 spi->mode |= SPI_CS_HIGH;
> > +       if (of_property_read_bool(nc, "spi-mosi-idle-low"))
> > +               spi->mode |= SPI_MOSI_IDLE_LOW;
> >
> >         /* Device DUAL/QUAD mode */
> >         if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) { diff --git
> > a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h index
> > 9d5f580597039..ca56e477d1619 100644
> > --- a/include/uapi/linux/spi/spi.h
> > +++ b/include/uapi/linux/spi/spi.h
> > @@ -28,6 +28,7 @@
> >  #define        SPI_RX_OCTAL            _BITUL(14)      /* receive with 8 wires */
> >  #define        SPI_3WIRE_HIZ           _BITUL(15)      /* high impedance
> > turnaround */
> >  #define        SPI_RX_CPHA_FLIP        _BITUL(16)      /* flip CPHA on Rx only xfer
> > */
> > +#define SPI_MOSI_IDLE_LOW      _BITUL(17)      /* leave mosi line low when
> > idle */
> >
> >  /*
> >   * All the bits defined above should be covered by SPI_MODE_USER_MASK.
> > @@ -37,6 +38,6 @@
> >   * These bits must not overlap. A static assert check should make sure of
> > that.
> >   * If adding extra bits, make sure to increase the bit index below as well.
> >   */
> > -#define SPI_MODE_USER_MASK     (_BITUL(17) - 1)
> > +#define SPI_MODE_USER_MASK     (_BITUL(18) - 1)
> >
> >  #endif /* _UAPI_SPI_H */
> > --
> > 2.25.1
>
