Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E849B6C6791
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCWMEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjCWMD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:03:56 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58718B46B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:02:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r187so360106ybr.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679572941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xws43rog4pqkpgitzKHxHfHo5VMOIdj+RfJfT9wN6j8=;
        b=Mhp314zlKBDNcfgkCX43261VrLBf0tItdWxSa7S/953LgAtxRZReKawc9AasAoJcA5
         SdRoGlJ3lORTEi/kC1k1ThIxd02Hbg0XuXU7XUgrX8SdT1NMnMv4qGVYShrc9hyrKgkG
         Cwk26EPfQbGzXnOCXXpKYgH/0ERcRwO9aMfTcfYjl7x4+znHBbMLLczgmO0G3b28zsy1
         gQ4Da75Jyi6IVY2QFmeAIYYj4Qmmsswn4RUSvWyiAKds+0FBWVDVBFAhi7WvfyXPZ7Qc
         6AjJ72280QJU66MpGdy2a/1CQI/ryI9udjXgrnvkdvWhGHRCbTXFgGYUMiY9M5ObHPDu
         an7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679572941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xws43rog4pqkpgitzKHxHfHo5VMOIdj+RfJfT9wN6j8=;
        b=3W3MUsJQIV60mR+RVl5Q/AsF76iZyDCjEUMoKMBMczYR2mDB4Rj43/Q55E+vQDgStt
         3dYNSi4nxikjIanc9ev8xXlDqowv9GTUuYz0uPACWgxydJjSsKLcW5+I3rmb09WBCgHQ
         JmOf4uvPO/13JnukKecGCVQctzhrSNgMYVXQgHmqN2q0bjyAdcmhjO6jlLP/ztAkjW/9
         tKXL7ktidOzqc9Y1y+SPAL2c/xawsoWC3XhKKgiRHvneB++DUFe9FiTyNt6t4aJ4lwro
         3xBrBaaz0qQzXZYbdhWmFEL9UV/BEov/a0w0oJy/La743sKfmc7/oTK6gmbm3McEZjXf
         Lvyw==
X-Gm-Message-State: AAQBX9emeHYKBMAbybc7jAwDvYhPh0TUQcrXnMVF3r+giBaD7C3MZK22
        3KgfJGyuscVYZw8Cl9Wo7gajD6c4Lqa6bh5J0iAbQA==
X-Google-Smtp-Source: AKy350YM9dGzBqBLUMPf5VWZR3UNKydlMnXmMd9fxz4BkVlwSvNuHVKDU6puW/aaeacVBBgrILw3i4wezHZVwH0KaiY=
X-Received: by 2002:a05:6902:100e:b0:b74:ae90:8fd1 with SMTP id
 w14-20020a056902100e00b00b74ae908fd1mr1744234ybt.8.1679572941298; Thu, 23 Mar
 2023 05:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230321115843.2688472-1-joychakr@google.com> <20230321192727.2ts4oabwiktblis3@mobilestation>
In-Reply-To: <20230321192727.2ts4oabwiktblis3@mobilestation>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Thu, 23 Mar 2023 17:32:09 +0530
Message-ID: <CAOSNQF3gOSz0z4Vyoh3zNpwaSw5fgWSJxkeimB4QbvFzTzj20g@mail.gmail.com>
Subject: Re: [PATCH v2] spi: dw: Add 32 bpw support to DW DMA Controller
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge(y),

On Wed, Mar 22, 2023 at 12:57=E2=80=AFAM Serge Semin <fancer.lancer@gmail.c=
om> wrote:
>
> On Tue, Mar 21, 2023 at 11:58:43AM +0000, Joy Chakraborty wrote:
> > If DW Controller is capable of a maximum of 32 bits per word then SW or
> > DMA controller has to write up to 32bit or 4byte data to the FIFO at a
> > time.
> >
>
> > This Patch adds support for AxSize =3D 4 bytes configuration from dw dm=
a
>
> * sorry for referring to the newbie-doc, but please note:
> https://elixir.bootlin.com/linux/v6.3-rc1/source/Documentation/process/su=
bmitting-patches.rst#L77
> and
> https://elixir.bootlin.com/linux/v6.3-rc1/source/Documentation/process/su=
bmitting-patches.rst#L94
>

Thank you for the point, I will rephrase the commit text.

> > driver if n_bytes i.e. number of bytes per write to fifo is 3 or 4.
> > It also checks to see if the dma controller is capable of satisfying th=
e
> > width requirement to achieve a particular bits/word requirement per
> > transfer.
> >
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > ---
> >  drivers/spi/spi-dw-dma.c | 37 ++++++++++++++++++++++++++++++++-----
> >  drivers/spi/spi-dw.h     |  1 +
> >  2 files changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > index ababb910b391..9ac3a1c25e2d 100644
> > --- a/drivers/spi/spi-dw-dma.c
> > +++ b/drivers/spi/spi-dw-dma.c
> > @@ -23,6 +23,8 @@
> >  #define DW_SPI_TX_BUSY               1
> >  #define DW_SPI_TX_BURST_LEVEL        16
> >
> > +static inline enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_by=
tes);
> > +
> >  static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *param)
> >  {
> >       struct dw_dma_slave *s =3D param;
> > @@ -89,6 +91,16 @@ static void dw_spi_dma_sg_burst_init(struct dw_spi *=
dws)
> >               dws->dma_sg_burst =3D 0;
> >  }
> >
> > +static void dw_spi_dma_addr_widths_init(struct dw_spi *dws)
> > +{
> > +     struct dma_slave_caps tx =3D {0}, rx =3D {0};
> > +
>
> > +     dma_get_slave_caps(dws->txchan, &tx);
> > +     dma_get_slave_caps(dws->rxchan, &rx);
>
> Even though in this case any dma_get_slave_caps() failure will
> effectively disable the DMA-based transfers, in general it would be
> useful to have the dma_get_slave_caps() return value checked and halt
> further DMA-init in case if it's not zero. In addition to that if the
> Tx/Rx DMA device doesn't have the DMA_SLAVE capability or DEV2MEM and
> MEM2DEV direction specified the DMA device won't be suitable for
> SPI-ing. So further DMA-initialization are pointless in that case too.
> It's just a general note not obligating or requesting anything since
> the respective update should have been done in a separate patch
> anyway.
>

I shall add the checks suggested and put 'dw_spi_dma_addr_widths_init'
and 'dw_spi_dma_sg_burst_init' in one function.
I'll break this up into 2 patches in V3.

> > +
>
> > +     dws->dma_addr_widths =3D tx.dst_addr_widths & rx.src_addr_widths;
>
> Hm, in general the addr-width capabilities can mismatch. But it's very
> much unlikely since both DMA channels normally belong to the same
> controller. So I guess we can live with the suggested approach for now
> but please add a comment above that line about the
> assumption/limitation it implies.
>

Even if the address width capabilities mismatch since in dma mode only
full duplex is done, hence the subset of the capabilities which apply
to both tx and rx should be applicable.
I shall put the same as a comment

> > +}
> > +
> >  static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws=
)
> >  {
> >       struct dw_dma_slave dma_tx =3D { .dst_id =3D 1 }, *tx =3D &dma_tx=
;
> > @@ -128,6 +140,8 @@ static int dw_spi_dma_init_mfld(struct device *dev,=
 struct dw_spi *dws)
> >
> >       dw_spi_dma_sg_burst_init(dws);
> >
> > +     dw_spi_dma_addr_widths_init(dws);
> > +
> >       pci_dev_put(dma_dev);
> >
> >       return 0;
> > @@ -167,6 +181,8 @@ static int dw_spi_dma_init_generic(struct device *d=
ev, struct dw_spi *dws)
> >
> >       dw_spi_dma_sg_burst_init(dws);
> >
> > +     dw_spi_dma_addr_widths_init(dws);
> > +
> >       return 0;
> >
> >  free_rxchan:
> > @@ -202,18 +218,29 @@ static bool dw_spi_can_dma(struct spi_controller =
*master,
> >                          struct spi_device *spi, struct spi_transfer *x=
fer)
> >  {
> >       struct dw_spi *dws =3D spi_controller_get_devdata(master);
>
> > +     enum dma_slave_buswidth dma_bus_width;
> >
> > -     return xfer->len > dws->fifo_len;
> > +     if (xfer->len > dws->fifo_len) {
> > +             dma_bus_width =3D dw_spi_dma_convert_width(dws->n_bytes);
> > +             if (dws->dma_addr_widths & BIT(dma_bus_width))
> > +                     return true;
> > +     }
> < newline would have been nice, but...
> > +     return false;
>
> on the other hand a level of indentation could be decreased like this:
>
> +       enum dma_slave_buswidth width;
> +
> +       if (xfer->len <=3D dws->fifo_len)
> +               return false;
> +
> +       width =3D dw_spi_dma_convert_width(dws->n_bytes);
> +
> +       return !!(dws->dma_addr_widths & BIT(width));
>

Sure, I will restructure this but any reason to use '!!' here ?

> -Serge(y)
>
> >  }
> >
> >  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes)
> >  {
> > -     if (n_bytes =3D=3D 1)
> > +     switch (n_bytes) {
> > +     case 1:
> >               return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > -     else if (n_bytes =3D=3D 2)
> > +     case 2:
> >               return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > -
> > -     return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > +     case 3:
> > +     case 4:
> > +             return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +     default:
> > +             return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > +     }
> >  }
> >
> >  static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 s=
peed)
> > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> > index 9e8eb2b52d5c..3962e6dcf880 100644
> > --- a/drivers/spi/spi-dw.h
> > +++ b/drivers/spi/spi-dw.h
> > @@ -190,6 +190,7 @@ struct dw_spi {
> >       struct dma_chan         *rxchan;
> >       u32                     rxburst;
> >       u32                     dma_sg_burst;
> > +     u32                     dma_addr_widths;
> >       unsigned long           dma_chan_busy;
> >       dma_addr_t              dma_addr; /* phy address of the Data regi=
ster */
> >       const struct dw_spi_dma_ops *dma_ops;
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >

I shall upload a V3 based on these comments.

Thanks
Joy
