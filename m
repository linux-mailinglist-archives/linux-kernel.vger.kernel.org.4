Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D34F6DDEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDKPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDKPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:08:14 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7280049FD
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:07:46 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54c17fa9ae8so262608787b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681225665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PSuQdFw67OdfJka21SpX+ck/dMbcmU+4LZ8fmiBHQY=;
        b=f60hJyL0f50g0ycAuZcH5/F0BREXbNOfNXKc3bOf4hufb3VBWanzUEgIkp0mimVyf1
         TLAoNGyqU9ezk8CtSOf9AesYomBYuxfI6V+0fjiOPuewCgjyg3xDBPhix/iB0Z/umb3k
         cGNelsXYX5ejumj92gc4hHB172XyYdPyHVASkKFV14+b27sz4fWRwbnFV/1SfmimdXkO
         dLP7W/mRmgdFOreswUAmCT6n8+uFRbAUgBMt/1QpDEm3zJ4+dDWXGs6onsddziPTRHJC
         rdI8XFxmiuXOPZzuMw5kkW4EpwbvLSs3ROhH1zOLCZbSx769c08uM0fHVxyXGIxZQEnD
         Ff8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PSuQdFw67OdfJka21SpX+ck/dMbcmU+4LZ8fmiBHQY=;
        b=ElsjlCB2/pkk1cmqE+B7410OHXAYYMymdF1re/UlCm3fyydYlFDIsSJuFqoxmgI4Qe
         DNrl80OaKLcjkBP+pbo+ObNqox4tUcZQdrbbUQkaWAmQI3cKtDzgt8WAfv4b2aMB0t8Q
         1QJA9qkb+jLdf5m6RQ3mNko99HG7PlNpMJ1kiLXrQb5FNU49oD38vL8RrFflj38to0ev
         NjBglh8XtjOslSCd/Py2zvKWIZfu+KPAlCAEkAkzAVh1EfCjrV84WNq5aN+Jc96ZwglF
         aL+YyLtMPOQJAi/0a8N3uqvK4pNGUKS/6koDMPXjP+I/5AqxGBzXAuq9D4qkbbMZIQV9
         JLyg==
X-Gm-Message-State: AAQBX9dJhw2oqPti34pWFuDgyMgQoQflIt4D3rXgCfQTpb2hKrHhbmLi
        uSAzaEL2YKVewkBqBGOx1kdM/Q98LN5QtTZwe8guVg==
X-Google-Smtp-Source: AKy350Y6K0kJlfIed6W39qBzz38TW3EONSttk7PSDtQjhPb1wAjOu/SDALBFlpcxs4YTfJERKF0xgSDJ/ZFPi2060MM=
X-Received: by 2002:a81:ad5e:0:b0:541:8c77:93b1 with SMTP id
 l30-20020a81ad5e000000b005418c7793b1mr7886674ywk.8.1681225664692; Tue, 11 Apr
 2023 08:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230330063450.2289058-1-joychakr@google.com> <20230330063450.2289058-3-joychakr@google.com>
 <ZDVQGu/gBPTNbQPU@smile.fi.intel.com> <CAOSNQF0R7p7kW04w0nKF2egv1+8NrMhSXpggunYhjQnA+v-qMQ@mail.gmail.com>
In-Reply-To: <CAOSNQF0R7p7kW04w0nKF2egv1+8NrMhSXpggunYhjQnA+v-qMQ@mail.gmail.com>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Tue, 11 Apr 2023 20:37:33 +0530
Message-ID: <CAOSNQF2zg5ymTfZWWbFLAgvKdcxRcggAjGt+Zy+qUzrR5=MERw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] spi: dw: Add dma controller capability checks
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
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

Sorry I think the emails crossed.

So as per the discussion, are these the possible changes:
1> Move "dw_spi_dma_convert_width" to avoid forward declaration .
2> Update the commit text to include more explanation.
3> Divide this into 2 patches?

Thanks
Joy

Joy

On Tue, Apr 11, 2023 at 8:30=E2=80=AFPM Joy Chakraborty <joychakr@google.co=
m> wrote:
>
> Hello Andy,
>
> On Tue, Apr 11, 2023 at 5:48=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Thu, Mar 30, 2023 at 06:34:50AM +0000, Joy Chakraborty wrote:
> > > Check capabilities of DMA controller during init to make sure it is
> > > capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel
> > > and store addr_width capabilities to check per transfer to make sure =
the
> > > bits/word requirement can be met for that transfer.
> >
> > ...
> >
> > > +static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
> >
> > Can we avoid forward declarations please?
>
> We can, but for that I would have to move this api somewhere else in
> the file is that acceptable?
>
> >
> > ...
> >
> > > +     if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
> > > +           rx.directions & BIT(DMA_DEV_TO_MEM)))
> > > +             return -ENXIO;
> >
> > What about simplex transfers where we only care about sending or receiv=
ing data
> > and using dummy data for the other channel? Doesn't this make a regress=
ion for
> > that types of transfers? (Or, if we don't support such, this should be =
explained
> > in the commit message at least.)
> >
>
> Yes we can have simplex transfers for TX only, but for RX only there
> is dummy data added by the SPI core as the dw-core driver adds
> "SPI_CONTROLLER_MUST_TX".
>
> But transfers aside, as per the current driver design the dw dma
> driver needs both valid tx and rx channels to exist and be functional
> as per implementation of api "dw_spi_dma_init_generic" :
> ...
> dws->rxchan =3D dma_request_chan(dev, "rx");
> if (IS_ERR(dws->rxchan)) {
> ret =3D PTR_ERR(dws->rxchan);
> dws->rxchan =3D NULL;
> goto err_exit;
> }
>
> dws->txchan =3D dma_request_chan(dev, "tx");
> if (IS_ERR(dws->txchan)) {
> ret =3D PTR_ERR(dws->txchan);
> dws->txchan =3D NULL;
> goto free_rxchan;
> }
> ...
>
> Hence in terms of capability check we should check for directional
> capability of both TX and RX is what I understand.
> Please let me know if you think otherwise.
>
> > ...
> >
> > > +     /*
> > > +      * Assuming both channels belong to the same DMA controller hen=
ce the
> > > +      * address width capabilities most likely would be the same.
> > > +      */
> > > +     dws->dma_addr_widths =3D tx.dst_addr_widths & rx.src_addr_width=
s;
> >
> > I don't think so this is correct.
> >
> > Theoretically it's possible to have simplex transfers on which the one =
of
> > the channel is simply ignored / not used. See above.
> >
>
> Yes, it is possible to have tx only transfers which would still be
> possible to do with this implementation. What we have assumed here is
> since the tx and rx channel both are a requirement for the dw dma
> driver to be functional it would most likely have the same address
> width capability.
>
> But we can make this more elaborate by checking it for both tx and rx
> separately.
> Something like this
> ...
>  dws->tx_dma_addr_widths =3D tx.dst_addr_widths;
>  dws->rx_dma_addr_widths =3D rx.src_addr_widths;
> ...
> ...
> static bool dw_spi_can_dma(struct spi_controller *master,
> struct spi_device *spi, struct spi_transfer *xfer)
> {
> struct dw_spi *dws =3D spi_controller_get_devdata(master);
> enum dma_slave_buswidth dma_bus_width;
>
> if (xfer->len <=3D dws->fifo_len)
> return false;
>
> dma_bus_width =3D dw_spi_dma_convert_width(dws->n_bytes);
>
> if (xfer->rx_buf && !(dws->rx_dma_addr_widths & BIT(dma_bus_width)))
> return false;
>
> return dws->tx_dma_addr_widths & BIT(dma_bus_width);
> }
> ...
>
> @Serge Semin Please share your thoughts on the same.
>
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
>
> I shall break this into 2 patches as per Serge(y)'s recommendation and
> make changes as per replies.
>
> Thanks
> Joy
