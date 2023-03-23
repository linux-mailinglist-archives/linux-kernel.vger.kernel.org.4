Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C506C6B78
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjCWOtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjCWOtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:49:08 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A2CEFA8;
        Thu, 23 Mar 2023 07:49:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id by8so21549866ljb.12;
        Thu, 23 Mar 2023 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679582944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tNdqiCV+z2t7fF6CLtRcLJqA7WR6c7iKxQf6NLHqs8I=;
        b=U7+N7VF2CoIWjgbWDQHJZEkGVzDB3mYX/WD6oq06WE6D8CmszHJqn98YT+qr7HkQT8
         +fkt1azEpW3TMuQjrlFg8v+Y3SuquhMT7sA1NIiB5LfYtdU12lfaeBh0k1BJ31LvMNgU
         6LOiHw5BzKf0+MHXAx8B649/1K1xZNQayBV0cQaMDNp7mTInJjN2nHqy3H1VNq981WNe
         /C7C56BbDPDlrHuEFDEDOA22ropX2NlG9gEiVOIIRbrBVhsgpFDYFGldA+nT9jBOY918
         n86CgwXCm6SJu92sE26cMVc24AxorYe7HJtd9AUxamOpGcYPMgXM0PNX17JAxAY/lU84
         q/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679582944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tNdqiCV+z2t7fF6CLtRcLJqA7WR6c7iKxQf6NLHqs8I=;
        b=wJRCQaChfYejlfKoxs4dt73OGWnW3lCWLa0Ff7OBhDg7UhD5wQ7hDY4/quIDohEG2B
         DQdx7imFvVBwiE9S8dJvUh68ZqxsWVin4xjG2tYYCPh54vPvGg+E+kg3S6oOHBbdAdAd
         bm8PVa8hB91UjgMu6P3chNhWxptmv2yB47smPifdmwbt0zdneQGKheecuP5wJOTz9Pgb
         MDhsRcmggBEsHFSjcc9kEKifX/KPn1hLE/VwYpN9DDF9x7+pqYxfoFpTCDCNUzwFQh49
         zkHj4mIifaGz2OkNFHNgadGq3P1ge5vaeVmcgUgY/XZiShup7WKDeN1tvPICTAQ8Z8TJ
         0yFg==
X-Gm-Message-State: AO0yUKU7klJ3iWsb4dOHnnTxHX82Q4FK4u6StPmN4s4I75CugeUSSuMd
        xbMGsQFj5NNqvhONZRiIyhsBQIhVl96MHA==
X-Google-Smtp-Source: AK7set9LN3UGX0MF8tiPj/+SkSWSCKggw8O0K17RQcm2YFH6u8EHYHPbBmzBBHt3ky5YDmGpHotVvA==
X-Received: by 2002:a2e:9c57:0:b0:292:b368:345d with SMTP id t23-20020a2e9c57000000b00292b368345dmr3259693ljj.48.1679582943839;
        Thu, 23 Mar 2023 07:49:03 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004d85789cef1sm2984757lfn.49.2023.03.23.07.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 07:49:03 -0700 (PDT)
Date:   Thu, 23 Mar 2023 17:48:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Subject: Re: [PATCH v2] spi: dw: Add 32 bpw support to DW DMA Controller
Message-ID: <20230323144859.varmlapdskpdcoqt@mobilestation>
References: <20230321115843.2688472-1-joychakr@google.com>
 <20230321192727.2ts4oabwiktblis3@mobilestation>
 <CAOSNQF3gOSz0z4Vyoh3zNpwaSw5fgWSJxkeimB4QbvFzTzj20g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF3gOSz0z4Vyoh3zNpwaSw5fgWSJxkeimB4QbvFzTzj20g@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:32:09PM +0530, Joy Chakraborty wrote:
> Hi Serge(y),
> 
> On Wed, Mar 22, 2023 at 12:57 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Tue, Mar 21, 2023 at 11:58:43AM +0000, Joy Chakraborty wrote:
> > > If DW Controller is capable of a maximum of 32 bits per word then SW or
> > > DMA controller has to write up to 32bit or 4byte data to the FIFO at a
> > > time.
> > >
> >
> > > This Patch adds support for AxSize = 4 bytes configuration from dw dma
> >
> > * sorry for referring to the newbie-doc, but please note:
> > https://elixir.bootlin.com/linux/v6.3-rc1/source/Documentation/process/submitting-patches.rst#L77
> > and
> > https://elixir.bootlin.com/linux/v6.3-rc1/source/Documentation/process/submitting-patches.rst#L94
> >
> 
> Thank you for the point, I will rephrase the commit text.
> 
> > > driver if n_bytes i.e. number of bytes per write to fifo is 3 or 4.
> > > It also checks to see if the dma controller is capable of satisfying the
> > > width requirement to achieve a particular bits/word requirement per
> > > transfer.
> > >
> > > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > > ---
> > >  drivers/spi/spi-dw-dma.c | 37 ++++++++++++++++++++++++++++++++-----
> > >  drivers/spi/spi-dw.h     |  1 +
> > >  2 files changed, 33 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > > index ababb910b391..9ac3a1c25e2d 100644
> > > --- a/drivers/spi/spi-dw-dma.c
> > > +++ b/drivers/spi/spi-dw-dma.c
> > > @@ -23,6 +23,8 @@
> > >  #define DW_SPI_TX_BUSY               1
> > >  #define DW_SPI_TX_BURST_LEVEL        16
> > >
> > > +static inline enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
> > > +
> > >  static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
> > >  {
> > >       struct dw_dma_slave *s = param;
> > > @@ -89,6 +91,16 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
> > >               dws->dma_sg_burst = 0;
> > >  }
> > >
> > > +static void dw_spi_dma_addr_widths_init(struct dw_spi *dws)
> > > +{
> > > +     struct dma_slave_caps tx = {0}, rx = {0};
> > > +
> >
> > > +     dma_get_slave_caps(dws->txchan, &tx);
> > > +     dma_get_slave_caps(dws->rxchan, &rx);
> >
> > Even though in this case any dma_get_slave_caps() failure will
> > effectively disable the DMA-based transfers, in general it would be
> > useful to have the dma_get_slave_caps() return value checked and halt
> > further DMA-init in case if it's not zero. In addition to that if the
> > Tx/Rx DMA device doesn't have the DMA_SLAVE capability or DEV2MEM and
> > MEM2DEV direction specified the DMA device won't be suitable for
> > SPI-ing. So further DMA-initialization are pointless in that case too.
> > It's just a general note not obligating or requesting anything since
> > the respective update should have been done in a separate patch
> > anyway.
> >
> 

> I shall add the checks suggested and put 'dw_spi_dma_addr_widths_init'
> and 'dw_spi_dma_sg_burst_init' in one function.
> I'll break this up into 2 patches in V3.

Sounds good. Thanks.

> 
> > > +
> >
> > > +     dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
> >
> > Hm, in general the addr-width capabilities can mismatch. But it's very
> > much unlikely since both DMA channels normally belong to the same
> > controller. So I guess we can live with the suggested approach for now
> > but please add a comment above that line about the
> > assumption/limitation it implies.
> >
> 

> Even if the address width capabilities mismatch since in dma mode only
> full duplex is done, hence the subset of the capabilities which apply
> to both tx and rx should be applicable.
> I shall put the same as a comment

Actually half-duplex xfers are also possible. See what happens if
rx_buf is Null or what the SPI_CONTROLLER_MUST_TX flag means (it's set
if the dma_init callback is successfully executed). In the former case
the Rx data will be just ignored, in the later case Tx-data will be
read from a dummy Tx-buffer. In both cases it doesn't matter what
bus-width is initialized in the DMA-controller. But in anyway as I
said before it's not that a big deal to have the widths combined.

> 
> > > +}
> > > +
> > >  static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> > >  {
> > >       struct dw_dma_slave dma_tx = { .dst_id = 1 }, *tx = &dma_tx;
> > > @@ -128,6 +140,8 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> > >
> > >       dw_spi_dma_sg_burst_init(dws);
> > >
> > > +     dw_spi_dma_addr_widths_init(dws);
> > > +
> > >       pci_dev_put(dma_dev);
> > >
> > >       return 0;
> > > @@ -167,6 +181,8 @@ static int dw_spi_dma_init_generic(struct device *dev, struct dw_spi *dws)
> > >
> > >       dw_spi_dma_sg_burst_init(dws);
> > >
> > > +     dw_spi_dma_addr_widths_init(dws);
> > > +
> > >       return 0;
> > >
> > >  free_rxchan:
> > > @@ -202,18 +218,29 @@ static bool dw_spi_can_dma(struct spi_controller *master,
> > >                          struct spi_device *spi, struct spi_transfer *xfer)
> > >  {
> > >       struct dw_spi *dws = spi_controller_get_devdata(master);
> >
> > > +     enum dma_slave_buswidth dma_bus_width;
> > >
> > > -     return xfer->len > dws->fifo_len;
> > > +     if (xfer->len > dws->fifo_len) {
> > > +             dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
> > > +             if (dws->dma_addr_widths & BIT(dma_bus_width))
> > > +                     return true;
> > > +     }
> > < newline would have been nice, but...
> > > +     return false;
> >
> > on the other hand a level of indentation could be decreased like this:
> >
> > +       enum dma_slave_buswidth width;
> > +
> > +       if (xfer->len <= dws->fifo_len)
> > +               return false;
> > +
> > +       width = dw_spi_dma_convert_width(dws->n_bytes);
> > +
> > +       return !!(dws->dma_addr_widths & BIT(width));
> >
> 
> Sure, I will restructure this but

> any reason to use '!!' here ?

No. It can be omitted indeed. The resultant integer will be implicitly
converted to one of the _Bool type values {true, false}.

-Serge(y)

> 
> > -Serge(y)
> >
> > >  }
> > >
> > >  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
> > >  {
> > > -     if (n_bytes == 1)
> > > +     switch (n_bytes) {
> > > +     case 1:
> > >               return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > -     else if (n_bytes == 2)
> > > +     case 2:
> > >               return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > -
> > > -     return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > +     case 3:
> > > +     case 4:
> > > +             return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > +     default:
> > > +             return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > +     }
> > >  }
> > >
> > >  static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
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
> > > 2.40.0.rc1.284.g88254d51c5-goog
> > >
> 
> I shall upload a V3 based on these comments.
> 
> Thanks
> Joy
