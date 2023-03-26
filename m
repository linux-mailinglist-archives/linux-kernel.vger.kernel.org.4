Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6996C9723
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 19:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjCZRRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 13:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjCZRRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 13:17:10 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2177172B8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:17:09 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i7so7776370ybt.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679851028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GK/MQHNjQJLkecdxlQ+0zO3pcxidXAmMiqyowJ2WOPk=;
        b=FYoZtxqzQSH8SqIngKPrWHmt8bhkK5zlLv03FlcePW9ikXiqbRGrN+PUbF/FrNiBNP
         NDdfLgfzH6krTq+Hd3qgbVr8bU9bgmvm2+XV/k6hIA91VxUf5CMXnpyVyGAZuQ2tn1jY
         BZjkWmsmbny+/BD66+33aaLL4nriPjyYGG3VcHH5z9U5XZT3SpBZ5394oByXuNu99SoX
         a7hWo69yLsU8Y4uXRNGsrawj5BSqlNAm7WoXUC1Br7O2zSyGVSEseo+jVvzWJA/WlFKi
         cQHPTf337Rqxjw1rzwCzSGxtHh8fV/EA/7CoamA+J0U/Hm3KBohE3q6+z/2i7K8tDBjb
         Ugjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679851028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GK/MQHNjQJLkecdxlQ+0zO3pcxidXAmMiqyowJ2WOPk=;
        b=gKERF6kBo7hKxM+UTxNv/zKzz2QrJC4/QMxxlGD4GjN4O1oMhaHAWI1kvbvRzlncyD
         gYqtjLV82CprwCG6GRoZBLF7G18N9gheklU1ULqlyftumauacS+M8rJR/wBZu70oJPzB
         xzRtaFouqru7sK/4u44nDNz0V6+lyzxDBN/sGx0XLN8spEli29n59I/iWvAJ5+gr6rY5
         OBvP+GAXhkpkpC/1H4enO1+X0YXPJu4X6S6n2w+6fJu3F4SgS4/qdepeGp31nqMp7DoU
         4ie/i01gM63PgPWO6/0QyERpOuINMT80bGLJu/3vIsCx2hLlfGCNMDR7vzjhdXIFZxP5
         TDCw==
X-Gm-Message-State: AAQBX9dAHt7vXGUvbAE7fXZ8vAXzdssos/F2YTKWXiWZrMehyOT7NKs3
        b6D+zHZaCKQDzXz1H95obzBRSMBV9Dy7kcqiG5DEaA==
X-Google-Smtp-Source: AKy350a7x57zKqBR1ABQaGrJPb5PKgiPMnk7UrNH6PW2COMaR+NDnrsun2OByWcPmRF/KuxOhDzpme6XfPdo2MAFniQ=
X-Received: by 2002:a05:6902:1547:b0:b46:4a5e:365f with SMTP id
 r7-20020a056902154700b00b464a5e365fmr5684917ybu.8.1679851028072; Sun, 26 Mar
 2023 10:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230321115843.2688472-1-joychakr@google.com> <20230321192727.2ts4oabwiktblis3@mobilestation>
 <CAOSNQF3gOSz0z4Vyoh3zNpwaSw5fgWSJxkeimB4QbvFzTzj20g@mail.gmail.com> <20230323144859.varmlapdskpdcoqt@mobilestation>
In-Reply-To: <20230323144859.varmlapdskpdcoqt@mobilestation>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Sun, 26 Mar 2023 22:46:56 +0530
Message-ID: <CAOSNQF27O_u7E3uO7AszyByrqP2scYO9Z=JpS2jLnWTjfs6qzQ@mail.gmail.com>
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

On Thu, Mar 23, 2023 at 8:19=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Thu, Mar 23, 2023 at 05:32:09PM +0530, Joy Chakraborty wrote:
> > Hi Serge(y),
> >
> > On Wed, Mar 22, 2023 at 12:57=E2=80=AFAM Serge Semin <fancer.lancer@gma=
il.com> wrote:
> > >
> > > On Tue, Mar 21, 2023 at 11:58:43AM +0000, Joy Chakraborty wrote:
> > > > If DW Controller is capable of a maximum of 32 bits per word then S=
W or
> > > > DMA controller has to write up to 32bit or 4byte data to the FIFO a=
t a
> > > > time.
> > > >
> > >
> > > > This Patch adds support for AxSize =3D 4 bytes configuration from d=
w dma
> > >
> > > * sorry for referring to the newbie-doc, but please note:
> > > https://elixir.bootlin.com/linux/v6.3-rc1/source/Documentation/proces=
s/submitting-patches.rst#L77
> > > and
> > > https://elixir.bootlin.com/linux/v6.3-rc1/source/Documentation/proces=
s/submitting-patches.rst#L94
> > >
> >
> > Thank you for the point, I will rephrase the commit text.
> >
> > > > driver if n_bytes i.e. number of bytes per write to fifo is 3 or 4.
> > > > It also checks to see if the dma controller is capable of satisfyin=
g the
> > > > width requirement to achieve a particular bits/word requirement per
> > > > transfer.
> > > >
> > > > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > > > ---
> > > >  drivers/spi/spi-dw-dma.c | 37 ++++++++++++++++++++++++++++++++----=
-
> > > >  drivers/spi/spi-dw.h     |  1 +
> > > >  2 files changed, 33 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > > > index ababb910b391..9ac3a1c25e2d 100644
> > > > --- a/drivers/spi/spi-dw-dma.c
> > > > +++ b/drivers/spi/spi-dw-dma.c
> > > > @@ -23,6 +23,8 @@
> > > >  #define DW_SPI_TX_BUSY               1
> > > >  #define DW_SPI_TX_BURST_LEVEL        16
> > > >
> > > > +static inline enum dma_slave_buswidth dw_spi_dma_convert_width(u8 =
n_bytes);
> > > > +
> > > >  static bool dw_spi_dma_chan_filter(struct dma_chan *chan, void *pa=
ram)
> > > >  {
> > > >       struct dw_dma_slave *s =3D param;
> > > > @@ -89,6 +91,16 @@ static void dw_spi_dma_sg_burst_init(struct dw_s=
pi *dws)
> > > >               dws->dma_sg_burst =3D 0;
> > > >  }
> > > >
> > > > +static void dw_spi_dma_addr_widths_init(struct dw_spi *dws)
> > > > +{
> > > > +     struct dma_slave_caps tx =3D {0}, rx =3D {0};
> > > > +
> > >
> > > > +     dma_get_slave_caps(dws->txchan, &tx);
> > > > +     dma_get_slave_caps(dws->rxchan, &rx);
> > >
> > > Even though in this case any dma_get_slave_caps() failure will
> > > effectively disable the DMA-based transfers, in general it would be
> > > useful to have the dma_get_slave_caps() return value checked and halt
> > > further DMA-init in case if it's not zero. In addition to that if the
> > > Tx/Rx DMA device doesn't have the DMA_SLAVE capability or DEV2MEM and
> > > MEM2DEV direction specified the DMA device won't be suitable for
> > > SPI-ing. So further DMA-initialization are pointless in that case too=
.
> > > It's just a general note not obligating or requesting anything since
> > > the respective update should have been done in a separate patch
> > > anyway.
> > >
> >
>
> > I shall add the checks suggested and put 'dw_spi_dma_addr_widths_init'
> > and 'dw_spi_dma_sg_burst_init' in one function.
> > I'll break this up into 2 patches in V3.
>
> Sounds good. Thanks.
>
> >
> > > > +
> > >
> > > > +     dws->dma_addr_widths =3D tx.dst_addr_widths & rx.src_addr_wid=
ths;
> > >
> > > Hm, in general the addr-width capabilities can mismatch. But it's ver=
y
> > > much unlikely since both DMA channels normally belong to the same
> > > controller. So I guess we can live with the suggested approach for no=
w
> > > but please add a comment above that line about the
> > > assumption/limitation it implies.
> > >
> >
>
> > Even if the address width capabilities mismatch since in dma mode only
> > full duplex is done, hence the subset of the capabilities which apply
> > to both tx and rx should be applicable.
> > I shall put the same as a comment
>
> Actually half-duplex xfers are also possible. See what happens if
> rx_buf is Null or what the SPI_CONTROLLER_MUST_TX flag means (it's set
> if the dma_init callback is successfully executed). In the former case
> the Rx data will be just ignored, in the later case Tx-data will be
> read from a dummy Tx-buffer. In both cases it doesn't matter what
> bus-width is initialized in the DMA-controller. But in anyway as I
> said before it's not that a big deal to have the widths combined.
>

Got it, for TX only transfers we can have half duplex but for RX only
transfers the framework will attach a dummy Tx buffer to make it full
duplex. But i shall keep it combined for simplicity and keep a
comment.

> >
> > > > +}
> > > > +
> > > >  static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi =
*dws)
> > > >  {
> > > >       struct dw_dma_slave dma_tx =3D { .dst_id =3D 1 }, *tx =3D &dm=
a_tx;
> > > > @@ -128,6 +140,8 @@ static int dw_spi_dma_init_mfld(struct device *=
dev, struct dw_spi *dws)
> > > >
> > > >       dw_spi_dma_sg_burst_init(dws);
> > > >
> > > > +     dw_spi_dma_addr_widths_init(dws);
> > > > +
> > > >       pci_dev_put(dma_dev);
> > > >
> > > >       return 0;
> > > > @@ -167,6 +181,8 @@ static int dw_spi_dma_init_generic(struct devic=
e *dev, struct dw_spi *dws)
> > > >
> > > >       dw_spi_dma_sg_burst_init(dws);
> > > >
> > > > +     dw_spi_dma_addr_widths_init(dws);
> > > > +
> > > >       return 0;
> > > >
> > > >  free_rxchan:
> > > > @@ -202,18 +218,29 @@ static bool dw_spi_can_dma(struct spi_control=
ler *master,
> > > >                          struct spi_device *spi, struct spi_transfe=
r *xfer)
> > > >  {
> > > >       struct dw_spi *dws =3D spi_controller_get_devdata(master);
> > >
> > > > +     enum dma_slave_buswidth dma_bus_width;
> > > >
> > > > -     return xfer->len > dws->fifo_len;
> > > > +     if (xfer->len > dws->fifo_len) {
> > > > +             dma_bus_width =3D dw_spi_dma_convert_width(dws->n_byt=
es);
> > > > +             if (dws->dma_addr_widths & BIT(dma_bus_width))
> > > > +                     return true;
> > > > +     }
> > > < newline would have been nice, but...
> > > > +     return false;
> > >
> > > on the other hand a level of indentation could be decreased like this=
:
> > >
> > > +       enum dma_slave_buswidth width;
> > > +
> > > +       if (xfer->len <=3D dws->fifo_len)
> > > +               return false;
> > > +
> > > +       width =3D dw_spi_dma_convert_width(dws->n_bytes);
> > > +
> > > +       return !!(dws->dma_addr_widths & BIT(width));
> > >
> >
> > Sure, I will restructure this but
>
> > any reason to use '!!' here ?
>
> No. It can be omitted indeed. The resultant integer will be implicitly
> converted to one of the _Bool type values {true, false}.
>
> -Serge(y)
>
> >
> > > -Serge(y)
> > >
> > > >  }
> > > >
> > > >  static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes=
)
> > > >  {
> > > > -     if (n_bytes =3D=3D 1)
> > > > +     switch (n_bytes) {
> > > > +     case 1:
> > > >               return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > > -     else if (n_bytes =3D=3D 2)
> > > > +     case 2:
> > > >               return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > > -
> > > > -     return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > +     case 3:
> > > > +     case 4:
> > > > +             return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > > +     default:
> > > > +             return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > +     }
> > > >  }
> > > >
> > > >  static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u=
32 speed)
> > > > diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> > > > index 9e8eb2b52d5c..3962e6dcf880 100644
> > > > --- a/drivers/spi/spi-dw.h
> > > > +++ b/drivers/spi/spi-dw.h
> > > > @@ -190,6 +190,7 @@ struct dw_spi {
> > > >       struct dma_chan         *rxchan;
> > > >       u32                     rxburst;
> > > >       u32                     dma_sg_burst;
> > > > +     u32                     dma_addr_widths;
> > > >       unsigned long           dma_chan_busy;
> > > >       dma_addr_t              dma_addr; /* phy address of the Data =
register */
> > > >       const struct dw_spi_dma_ops *dma_ops;
> > > > --
> > > > 2.40.0.rc1.284.g88254d51c5-goog
> > > >
> >
> > I shall upload a V3 based on these comments.
> >
> > Thanks
> > Joy

Creating a V3 Patch with the updates.

Thanks
Joy
