Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CD96CDAF0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjC2Nfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjC2Nfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:35:40 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C094EEF;
        Wed, 29 Mar 2023 06:35:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 20so16183658lju.0;
        Wed, 29 Mar 2023 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680096930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xs3l8xHeQN0QhWBPHkIY5Muif5eQvC6Mk/I7Rd6Zf28=;
        b=jZw+rW3YMHX6RRst6QgAfrweHt+DdeVRxGSxoB82qXyjy4Hulym29aWz22gRN4ZMKN
         YmHKZiy+nHrylSZi8w8FYIy8kUWoR6UNHj/V2iFKvZxuf3xY421uTHK5asEWkrOqC9Qq
         7Febh7ITJOt92exuBphLlmBlk/6wL9L2E0Uyoaf26ETtFVouypjfCh/Gnvy69BhT0RLv
         bsqbZvuNAjiQ1JvwxTTCEDMCMd66zJnDLc4BZ9UuXJM6daKHnFANxbzWChBZ/5bv73MA
         8z6m27+VskjVmjoIaGf/itTfdnNYkH0qkEfqq5Dfb0gfCYPwH1c4+n1QEqLeO9yKFfRS
         hLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680096930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xs3l8xHeQN0QhWBPHkIY5Muif5eQvC6Mk/I7Rd6Zf28=;
        b=OzAulT3ultrw54pA7DCp7LD0la201oVubLqNVVJdjJyeUl3epnaH6YdYE9IUcx2SvS
         oRsTHMS9AVy8ccEtDrKCxf205I3ZAqNCvHHEYnHBXCTFroB6TRQv5Y+Hv7Hq7RewKK7A
         E9jXCmDnUKYBAxbTh6TbYRpNabq3RHOymesesaan+5VK33HcoJsEvRJj4wGYsv7Y0qw0
         /7bCJKF6LXvlXMLBjNxWLeeywpojX4MvKFNIdiZVazSPIJL380yUyJ6vgCx/w8hCNTqj
         Voe8UmgqpbPojHDsCbcjdNlfluTwA8lg4ausQodnNsLrbfInOj4I5YLuW8tKUKwpoV7r
         sDMA==
X-Gm-Message-State: AAQBX9dZVR5KN2z+aAN6vUI1o/m/qgIEO6RC/YowQYRRK6gk/g0tLSS6
        3CpkzOPVf9rrN6+74jAB1ZU=
X-Google-Smtp-Source: AKy350YnGbQP8YaiMjzyUzFBdzeQEwQnIGz0Nf2VO9qfnROC0t2TnJIsAeIH8Jug7Vp/MuoIaA1iiQ==
X-Received: by 2002:a2e:9593:0:b0:29e:8a51:35d4 with SMTP id w19-20020a2e9593000000b0029e8a5135d4mr5748774ljh.12.1680096930164;
        Wed, 29 Mar 2023 06:35:30 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id v18-20020a2e9252000000b002934abfb109sm5520370ljg.45.2023.03.29.06.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:35:29 -0700 (PDT)
Date:   Wed, 29 Mar 2023 16:35:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v4 2/2] spi: dw: Add dma controller capability checks
Message-ID: <20230329133527.wa7u3osht7tfl47x@mobilestation>
References: <20230327043405.881645-1-joychakr@google.com>
 <20230327043405.881645-3-joychakr@google.com>
 <20230328180338.bpxvjwx4tn4ter3f@mobilestation>
 <CAOSNQF3r+6Oz=chnA94=4q7pugGFKm2W09ry+pS2F0oe1HZmcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF3r+6Oz=chnA94=4q7pugGFKm2W09ry+pS2F0oe1HZmcA@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 09:26:47AM +0530, Joy Chakraborty wrote:
> Hi Serge(y),
> 
> On Tue, Mar 28, 2023 at 11:33 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Mon, Mar 27, 2023 at 04:34:05AM +0000, Joy Chakraborty wrote:
> > > Check capabilities of DMA controller during init to make sure it is
> > > capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel
> > > and store addr_width capabilities to check per transfer to make sure the
> > > bits/word requirement can be met for that transfer.
> > >
> > > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > > ---
> > >  drivers/spi/spi-dw-dma.c | 54 ++++++++++++++++++++++++++++++++--------
> > >  drivers/spi/spi-dw.h     |  1 +
> > >  2 files changed, 44 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > > index b3a88bb75907..f47483ec369f 100644
> > > --- a/drivers/spi/spi-dw-dma.c
> > > +++ b/drivers/spi/spi-dw-dma.c
> > > @@ -23,6 +23,8 @@
> > >  #define DW_SPI_TX_BUSY               1
> > >  #define DW_SPI_TX_BURST_LEVEL        16
> > >
> > > +static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
> > > +
> > >  static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
> > >  {
> > >       struct dw_dma_slave *s = param;
> > > @@ -72,12 +74,15 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
> > >       dw_writel(dws, DW_SPI_DMATDLR, dws->txburst);
> > >  }
> > >
> > > -static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
> > > +static int dw_spi_dma_caps_init(struct dw_spi *dws)
> > >  {
> >
> > > +     int ret;
> > >       struct dma_slave_caps tx = {0}, rx = {0};
> >
> > 1. Preserve the reverse xmas tree order please (driver local convention).
> > 2. The zero-initialization can be dropped since the function will halt
> > on further procedures if any of the dma_get_slave_caps() calls fail.
> > Meanwhile if all of them are successfully executed the capability
> > structures will be sanely initialized.
> >
> 
> Sure, will update
> 
> > >
> > > -     dma_get_slave_caps(dws->txchan, &tx);
> > > -     dma_get_slave_caps(dws->rxchan, &rx);
> >
> > > +     ret = dma_get_slave_caps(dws->txchan, &tx);
> >         if (ret)
> >                 return ret;
> > < newline
> > > +     ret |= dma_get_slave_caps(dws->rxchan, &rx);
> > > +     if (ret)
> > > +             return ret;
> >
> > No OR-ing the errnos please. They aren't bitfields.
> 
> Sure, I will update this.

> In this case do you think we need an error print here to differentiate
> which slave caps failed ?

No. dw_spi_add_host() will inform (dev_warn()) about the
DMA-initialization failures. Printing something besides of that
won't help much since in any case an additional debugging would be
necessary.

> 
> >
> > >
> > >       if (tx.max_sg_burst > 0 && rx.max_sg_burst > 0)
> > >               dws->dma_sg_burst = min(tx.max_sg_burst, rx.max_sg_burst);
> > > @@ -87,6 +92,18 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
> > >               dws->dma_sg_burst = rx.max_sg_burst;
> > >       else
> > >               dws->dma_sg_burst = 0;
> > > +
> > > +     /*
> > > +      * Assuming both channels belong to the same DMA controller hence the
> > > +      * address width capabilities most likely would be the same.
> > > +      */
> > > +     dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
> > > +
> >
> > > +     if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
> > > +           rx.directions & BIT(DMA_DEV_TO_MEM)))
> > > +             return -ENXIO;
> >
> > Please move this to be right after the capabilities are retrieved.
> > There is no point in the SG-burst and addr-width data initializations
> > if a DMA-controller isn't suitable for the Tx/Rx DMAs.
> 
> On second thought I see that dma_get_slave_caps already checks if
> direction exists in dmaengine.c:
> ...
> int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
> ...
>     if (!device->directions)
>         return -ENXIO;
> ...
> But it does not check the capability w.r.t the type of channel i.e.
> tx/rx , so we can keep this check as well.

Right. dma_get_slave_caps() doesn't check the particular channel
dir capability which is essential for us in this case. So please keep the
directions check here.

> Either Way, in case we keep it I shall move this as you suggested.

Ok. Thanks.

-Serge(y)

> 
> >
> > -Serge(y)
> >
> > > +
> > > +     return 0;
> > >  }
> > >
> > >  static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> > > @@ -95,6 +112,7 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> > >       struct dw_dma_slave dma_rx = { .src_id = 0 }, *rx = &dma_rx;
> > >       struct pci_dev *dma_dev;
> > >       dma_cap_mask_t mask;
> > > +     int ret = -EBUSY;
> > >
> > >       /*
> > >        * Get pci device for DMA controller, currently it could only
> > > @@ -124,20 +142,24 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> > >
> > >       init_completion(&dws->dma_completion);
> > >
> > > -     dw_spi_dma_maxburst_init(dws);
> > > +     ret = dw_spi_dma_caps_init(dws);
> > > +     if (ret)
> > > +             goto free_txchan;
> > >
> > > -     dw_spi_dma_sg_burst_init(dws);
> > > +     dw_spi_dma_maxburst_init(dws);
> > >
> > >       pci_dev_put(dma_dev);
> > >
> > >       return 0;
> > > -
> > > +free_txchan:
> > > +     dma_release_channel(dws->txchan);
> > > +     dws->txchan = NULL;
> > >  free_rxchan:
> > >       dma_release_channel(dws->rxchan);
> > >       dws->rxchan = NULL;
> > >  err_exit:
> > >       pci_dev_put(dma_dev);
> > > -     return -EBUSY;
> > > +     return ret;
> > >  }
> > >
> > >  static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
> > > @@ -163,12 +185,16 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
> > >
> > >       init_completion(&dws->dma_completion);
> > >
> > > -     dw_spi_dma_maxburst_init(dws);
> > > +     ret = dw_spi_dma_caps_init(dws);
> > > +     if (ret)
> > > +             goto free_txchan;
> > >
> > > -     dw_spi_dma_sg_burst_init(dws);
> > > +     dw_spi_dma_maxburst_init(dws);
> > >
> > >       return 0;
> > > -
> > > +free_txchan:
> > > +     dma_release_channel(dws->txchan);
> > > +     dws->txchan = NULL;
> > >  free_rxchan:
> > >       dma_release_channel(dws->rxchan);
> > >       dws->rxchan = NULL;
> > > @@ -202,8 +228,14 @@ static bool dw_spi_can_dma(struct spi_controller *master,
> > >                          struct spi_device *spi, struct spi_transfer *xfer)
> > >  {
> > >       struct dw_spi *dws = spi_controller_get_devdata(master);
> > > +     enum dma_slave_buswidth dma_bus_width;
> > > +
> > > +     if (xfer->len <= dws->fifo_len)
> > > +             return false;
> > > +
> > > +     dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
> > >
> > > -     return xfer->len > dws->fifo_len;
> > > +     return dws->dma_addr_widths & BIT(dma_bus_width);
> > >  }
> > >
> > >  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
> > > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> > > index 9e8eb2b52d5c..3962e6dcf880 100644
> > > --- a/drivers/spi/spi-dw.h
> > > +++ b/drivers/spi/spi-dw.h
> > > @@ -190,6 +190,7 @@ struct dw_spi {
> > >       struct dma_chan         *rxchan;
> > >       u32                     rxburst;
> > >       u32                     dma_sg_burst;
> > > +     u32                     dma_addr_widths;
> > >       unsigned long           dma_chan_busy;
> > >       dma_addr_t              dma_addr; /* phy address of the Data register */
> > >       const struct dw_spi_dma_ops *dma_ops;
> > > --
> > > 2.40.0.348.gf938b09366-goog
> > >
> 
> Thanks
> Joy
