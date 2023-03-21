Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799BF6C30E6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjCULxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjCULxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:53:07 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F35D6198
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:53:03 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5416b0ab0ecso275841677b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679399582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYwUFzkuGCztXjVOM0tv5oP/w72wTB7y3VBxXHSOUw8=;
        b=YQpm1wpEJ/siPZEdPiGpFbH+SCBtul35ezgNvnFgwkSrDzL24Nnae1sENs7FWWRF0X
         +wUQmLT4ZFO+qZjl9q95BH+vWMmqAu717CpN7srblGruTziZchNmcl3FzSElAocWSHqU
         Dela09pNtt4RynWi57FrNeY6lSVuPxE97habC68EG/5FEI+/DvzYrsgzTF8HplJmnq75
         v2kJ0vcXz6BNl+0lXx8YrogfV4/Y2z697V2s7od4L6eWJ9ike96OU3OwV8JadOpwo5HF
         KdI+3OShzqocHBz4zeTuWRY/5QyErKjpPEEKwT4c+g602imXsuekw3n1Yyhym5I4OFn2
         tbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYwUFzkuGCztXjVOM0tv5oP/w72wTB7y3VBxXHSOUw8=;
        b=GB4icLlz4dHjujwMelVmNhv/MFF/BlWCkCZJI5bVUtInX5tMqIXAut2OfJJqZcpzhY
         D6D6RZWZzk1J+/O4Z0iz3ZAe6SDsDyhlaRej4ykU5VqwbpI0TGOQ59RmlUfVHNe/GmUz
         4n5t5Ite+YOQo3tZ8tzdKyuVYlVdVRlf/wW9S5IVtJ1hBwK4dCESe+tSMwgs1e2HKZea
         sXI+TmDdhIDe2HYWBDO1dZhsCOd3QNmcxuGbaHg9iPmtM+dzRaA3vxZdJoTqjazNJnfl
         9wPqkL0GWaCsO0CD3mtuMZsClcsYMbY3t3CDh7+evQ+qxGfAK4zH1DBrY1TyKtsD1TaR
         CrxQ==
X-Gm-Message-State: AAQBX9eHwBZ7/lobQD3Ph8TeTBgYvgZ9hfS+gkPnLCA+AzwiHMp/q7lf
        i3WIuMsFStf45js6iLM5Wwf+SCrSOiZX2PbGGKDZXxwz2nB9L5QQwb2MNw==
X-Google-Smtp-Source: AKy350Z3fthOUikgiL7zK9+jDaPbexuPe8Fd+x+E+kAm6rBBxz8kbL99ce5Ie+GrypGzkvzW5vsl/3/5Fwt6i4W5jE4=
X-Received: by 2002:a81:4412:0:b0:541:9f3a:ac46 with SMTP id
 r18-20020a814412000000b005419f3aac46mr906059ywa.8.1679399582381; Tue, 21 Mar
 2023 04:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230320055746.2070049-1-joychakr@google.com> <20230320140424.pfy4zf6dfwgf2xyj@mobilestation>
In-Reply-To: <20230320140424.pfy4zf6dfwgf2xyj@mobilestation>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Tue, 21 Mar 2023 17:22:51 +0530
Message-ID: <CAOSNQF3cZXtAFFCCAYr+CyBZC7JBPngE6di3+tP1bSMvBqE3sQ@mail.gmail.com>
Subject: Re: [PATCH] spi: dw: Add 32 bpw support to DW DMA Controller
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge(y),

On Mon, Mar 20, 2023 at 7:34=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> Hello Joy.
>
> On Mon, Mar 20, 2023 at 05:57:46AM +0000, Joy Chakraborty wrote:
> > If DW Controller is capable of 32 bits per word support then SW or DMA
> > controller has to write 32bit or 4byte data to the FIFO at a time.
> >
> > This Patch adds support for AxSize =3D 4 bytes configuration from dw dm=
a
> > driver if n_bytes i.e. number of bytes per write to fifo is 4.
> >
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
>
> > ---
> >  drivers/spi/spi-dw-dma.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > index ababb910b391..7d06ecfdebe1 100644
> > --- a/drivers/spi/spi-dw-dma.c
> > +++ b/drivers/spi/spi-dw-dma.c
> > @@ -212,6 +212,8 @@ static enum dma_slave_buswidth dw_spi_dma_convert_w=
idth(u8 n_bytes)
> >               return DMA_SLAVE_BUSWIDTH_1_BYTE;
> >       else if (n_bytes =3D=3D 2)
> >               return DMA_SLAVE_BUSWIDTH_2_BYTES;
>
> > +     else if (n_bytes =3D=3D 4)
> > +             return DMA_SLAVE_BUSWIDTH_4_BYTES;
>
> In case of the DFS-width being of 32-bits size n_bytes can be 4 and
> theoretically _3_ (practically it's unluckily, but anyway). Here
> it is:
> ...
> if (dws->caps & DW_SPI_CAP_DFS32)
>         master->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
> ...
> dws->n_bytes =3D DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> ...
>
> So what about converting the dw_spi_dma_convert_width() method to
> having the switch-case statement and adding the adjacent "case 3:
> case 4:" statement there?
>
> * We could add the individual case-3 branch with DMA_SLAVE_BUSWIDTH_3_BYT=
ES
> * returned, but the DMA-engines with 3-bytes bus width capability are
> * so rare. So is the case of having n_bytes =3D=3D 3. Thus I guess it
> * won't hurt to extend the bus up to four bytes even though there are
> * only three bytes required.
>
> Please also note. Currently the spi-dw-dma.o driver doesn't make sure
> that the requested buswidth is actually supported by the DMA-engine
> (see dma_slave_caps.{src,dst}_addr_widths fields semantics). It would
> be nice to have some sanity check in there, but until then note DMA
> may still fail even if you specify a correct buswidth.
>
> -Serge(y)

Will be creating a V2 Patch with the suggested changes.
For the case of n_bytes =3D 3 would be using DMA_SLAVE_BUSWIDTH_4_BYTES
since that is what
the FIFO driver is doing as well while writing to the FIFO register in
the core driver:
...
        if (dws->n_bytes =3D=3D 1)
                txw =3D *(u8 *)(dws->tx);
        else if (dws->n_bytes =3D=3D 2)
                txw =3D *(u16 *)(dws->tx);
        else
                txw =3D *(u32 *)(dws->tx);
...

For the case of sanity checking of dma capability, I am planning to
add it to can_dma function so that it
defaults to a non-dma mode if the DMA controller is not capable of
satisfying the bits/word requirement.

Thanks
Joy
>
> >
> >       return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> >  }
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >


On Mon, Mar 20, 2023 at 7:34=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> Hello Joy.
>
> On Mon, Mar 20, 2023 at 05:57:46AM +0000, Joy Chakraborty wrote:
> > If DW Controller is capable of 32 bits per word support then SW or DMA
> > controller has to write 32bit or 4byte data to the FIFO at a time.
> >
> > This Patch adds support for AxSize =3D 4 bytes configuration from dw dm=
a
> > driver if n_bytes i.e. number of bytes per write to fifo is 4.
> >
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
>
> > ---
> >  drivers/spi/spi-dw-dma.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> > index ababb910b391..7d06ecfdebe1 100644
> > --- a/drivers/spi/spi-dw-dma.c
> > +++ b/drivers/spi/spi-dw-dma.c
> > @@ -212,6 +212,8 @@ static enum dma_slave_buswidth dw_spi_dma_convert_w=
idth(u8 n_bytes)
> >               return DMA_SLAVE_BUSWIDTH_1_BYTE;
> >       else if (n_bytes =3D=3D 2)
> >               return DMA_SLAVE_BUSWIDTH_2_BYTES;
>
> > +     else if (n_bytes =3D=3D 4)
> > +             return DMA_SLAVE_BUSWIDTH_4_BYTES;
>
> In case of the DFS-width being of 32-bits size n_bytes can be 4 and
> theoretically _3_ (practically it's unluckily, but anyway). Here
> it is:
> ...
> if (dws->caps & DW_SPI_CAP_DFS32)
>         master->bits_per_word_mask =3D SPI_BPW_RANGE_MASK(4, 32);
> ...
> dws->n_bytes =3D DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> ...
>
> So what about converting the dw_spi_dma_convert_width() method to
> having the switch-case statement and adding the adjacent "case 3:
> case 4:" statement there?
>
> * We could add the individual case-3 branch with DMA_SLAVE_BUSWIDTH_3_BYT=
ES
> * returned, but the DMA-engines with 3-bytes bus width capability are
> * so rare. So is the case of having n_bytes =3D=3D 3. Thus I guess it
> * won't hurt to extend the bus up to four bytes even though there are
> * only three bytes required.
>
> Please also note. Currently the spi-dw-dma.o driver doesn't make sure
> that the requested buswidth is actually supported by the DMA-engine
> (see dma_slave_caps.{src,dst}_addr_widths fields semantics). It would
> be nice to have some sanity check in there, but until then note DMA
> may still fail even if you specify a correct buswidth.
>
> -Serge(y)
>
> >
> >       return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> >  }
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >
