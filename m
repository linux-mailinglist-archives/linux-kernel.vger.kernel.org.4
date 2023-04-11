Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC616DDEBA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjDKPB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjDKPBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:01:01 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A37D526A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:00:57 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id h198so14949196ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681225257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agiD0fVmkG5x9YhF7RbgP1I7SfY10cQp3Rf/E83Dm34=;
        b=PuX0NfFzdI/T3eO+DH6Z+CbWLQSuXDpaGljvewscJBJoDlQWKD83rrTY8bM9AzwvoB
         GFyden3bkcmYSPX22mPj0l/bCXSzO+w9BXl0uzZvprwAflw4eWOESx9Cv5UitApXmSdo
         aRnj4O0ELL2bt+YS005AE0e1/Yk5X4TNXmmf0bel+gAAqNj0mu/Whynhsz/keksPC0+O
         jhDLEbiLSpEAAzAsiio/AS/4YI65fHMhMnr44MYK5znl6WWL+kBt3lFgKXJYqdSN5yyc
         lER47SEPfWPROGlUNHFCbdLUeUfIMGLaERjlITrtUQt4WskAriYLq5W9DNsG/04SQyGe
         H8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681225257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agiD0fVmkG5x9YhF7RbgP1I7SfY10cQp3Rf/E83Dm34=;
        b=CvhoV8r9ualIldZCJxPZiIYvwnmqdvFz1Tq9Qiu6KN2LH8vmMdxwH6N1KS1QStPAbM
         agbKXvvzw1LuT9zw19m1v6WF6mOHTLXp5rR0jpjGQPsSWxEb4d4AFUiwbMncJkFg8rdX
         zNQYXFj1gD2NXPv1cvoHUbjFaNuI+MbhsaR+DTjhv05Clqu6nqzV4CmUGpQZpolOM+KX
         Uz2MxInRztzqmJVwpmZiCYuryaf64BfKG5k9m2kJnVr6ZppaLnvzr5+4l28g1Hsu34Gw
         iaTOYkhLbIMzQyXbZopJNxsc/WOdpajejfxFUOJSZZspEdD2sLXgsrN8p7p/FBIgdz9Z
         1dKA==
X-Gm-Message-State: AAQBX9fpNb4Ug3ponUo5PcS7XQyB3Je6+V20Kj2dLFUx8m6C1oBi7Nm+
        KYTAj1X/jBZjHYY6PIh89IrSRrIZLXguVL24fSg9iA==
X-Google-Smtp-Source: AKy350b89tn9QD1vHapm2mUaRbz71A1zQ3NqZprWtp1YvRsh4G5XGprwo6ZFbJC7m2+WpCjKVjQGLISyLt+CVb+uHog=
X-Received: by 2002:a25:da44:0:b0:b8e:ce15:cb6c with SMTP id
 n65-20020a25da44000000b00b8ece15cb6cmr7496637ybf.8.1681225253347; Tue, 11 Apr
 2023 08:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230330063450.2289058-1-joychakr@google.com> <20230330063450.2289058-3-joychakr@google.com>
 <ZDVQGu/gBPTNbQPU@smile.fi.intel.com>
In-Reply-To: <ZDVQGu/gBPTNbQPU@smile.fi.intel.com>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Tue, 11 Apr 2023 20:30:41 +0530
Message-ID: <CAOSNQF0R7p7kW04w0nKF2egv1+8NrMhSXpggunYhjQnA+v-qMQ@mail.gmail.com>
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

Hello Andy,

On Tue, Apr 11, 2023 at 5:48=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Mar 30, 2023 at 06:34:50AM +0000, Joy Chakraborty wrote:
> > Check capabilities of DMA controller during init to make sure it is
> > capable of handling MEM2DEV for tx channel, DEV2MEM for rx channel
> > and store addr_width capabilities to check per transfer to make sure th=
e
> > bits/word requirement can be met for that transfer.
>
> ...
>
> > +static enum dma_slave_buswidth dw_spi_dma_convert_width(u8 n_bytes);
>
> Can we avoid forward declarations please?

We can, but for that I would have to move this api somewhere else in
the file is that acceptable?

>
> ...
>
> > +     if (!(tx.directions & BIT(DMA_MEM_TO_DEV) &&
> > +           rx.directions & BIT(DMA_DEV_TO_MEM)))
> > +             return -ENXIO;
>
> What about simplex transfers where we only care about sending or receivin=
g data
> and using dummy data for the other channel? Doesn't this make a regressio=
n for
> that types of transfers? (Or, if we don't support such, this should be ex=
plained
> in the commit message at least.)
>

Yes we can have simplex transfers for TX only, but for RX only there
is dummy data added by the SPI core as the dw-core driver adds
"SPI_CONTROLLER_MUST_TX".

But transfers aside, as per the current driver design the dw dma
driver needs both valid tx and rx channels to exist and be functional
as per implementation of api "dw_spi_dma_init_generic" :
...
dws->rxchan =3D dma_request_chan(dev, "rx");
if (IS_ERR(dws->rxchan)) {
ret =3D PTR_ERR(dws->rxchan);
dws->rxchan =3D NULL;
goto err_exit;
}

dws->txchan =3D dma_request_chan(dev, "tx");
if (IS_ERR(dws->txchan)) {
ret =3D PTR_ERR(dws->txchan);
dws->txchan =3D NULL;
goto free_rxchan;
}
...

Hence in terms of capability check we should check for directional
capability of both TX and RX is what I understand.
Please let me know if you think otherwise.

> ...
>
> > +     /*
> > +      * Assuming both channels belong to the same DMA controller hence=
 the
> > +      * address width capabilities most likely would be the same.
> > +      */
> > +     dws->dma_addr_widths =3D tx.dst_addr_widths & rx.src_addr_widths;
>
> I don't think so this is correct.
>
> Theoretically it's possible to have simplex transfers on which the one of
> the channel is simply ignored / not used. See above.
>

Yes, it is possible to have tx only transfers which would still be
possible to do with this implementation. What we have assumed here is
since the tx and rx channel both are a requirement for the dw dma
driver to be functional it would most likely have the same address
width capability.

But we can make this more elaborate by checking it for both tx and rx
separately.
Something like this
...
 dws->tx_dma_addr_widths =3D tx.dst_addr_widths;
 dws->rx_dma_addr_widths =3D rx.src_addr_widths;
...
...
static bool dw_spi_can_dma(struct spi_controller *master,
struct spi_device *spi, struct spi_transfer *xfer)
{
struct dw_spi *dws =3D spi_controller_get_devdata(master);
enum dma_slave_buswidth dma_bus_width;

if (xfer->len <=3D dws->fifo_len)
return false;

dma_bus_width =3D dw_spi_dma_convert_width(dws->n_bytes);

if (xfer->rx_buf && !(dws->rx_dma_addr_widths & BIT(dma_bus_width)))
return false;

return dws->tx_dma_addr_widths & BIT(dma_bus_width);
}
...

@Serge Semin Please share your thoughts on the same.

> --
> With Best Regards,
> Andy Shevchenko
>
>

I shall break this into 2 patches as per Serge(y)'s recommendation and
make changes as per replies.

Thanks
Joy
