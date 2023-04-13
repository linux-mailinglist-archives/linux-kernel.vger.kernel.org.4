Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574206E05CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjDMEJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDMEIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:08:48 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E790D83FF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:07:49 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id t16so1173133ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681358869; x=1683950869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOBwWrLFn3ZdjGR7GJPORLer17mWOJTBmbGgr0b3ytE=;
        b=K/PGhsFN9Ipz0NUKAqNFtG2UnNzrPkBVnyz2f4is6eGSYHhTBFfqqC9/wK/oGyWESM
         4Ier181lBI6rbUrSPlb1YliDEAWw4vHFmfB5UQrskATxgfyzh6/vBCjojWtnalOPshRK
         BB/lOxEWZfkYTExLo2c+nztplRXs0j9fNCmVsrw7SjZMWuJhVkQVXJUs4wyzfWniAai6
         xMuugoQau+PrJQTHfUzKRL1qFsDUNEWvaog4A7MxUn7t+HezyeMEBrcCkCfR+QXYau8F
         JlRlrW8boz/r3VxHfkX/yZtYUoFgpBICnM5yj+snIx+zk9g4ibc4tJ0i2pGgIe9xEPlL
         z+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681358869; x=1683950869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOBwWrLFn3ZdjGR7GJPORLer17mWOJTBmbGgr0b3ytE=;
        b=XI9tJSZwKj2lZmOkVAFMtC5KhbS3EWhutYmSm2MuNNrUZjzmivFU6SaMSzHCNPI0pm
         7/qEcG4/D0j2WaWqvAAWXYN8Fc1DI1Ubsm9RO6AUCzCNxiF7wrCiQbLZL9V1gVsWcN0F
         lqrsIzEs3kvxTF8xHPOmOvnl7CSDRcJ5AS90boC/ejMxrNRT2sLup8rvzgHPAsEYxoF2
         mpTOyn0BpHpaWNT5O2BwCRReDYyVFThT3bTEBNg65YzKdHzkZWsNuIG4P3xx35AA1fMB
         eGXo2W3E71Gp0Rb8pg2ItG+HpfPfbhX/ArD/zWKTLcuoKpz5HvGV5Z9OZl5nHQMqgWG6
         uC4w==
X-Gm-Message-State: AAQBX9egSpaLj3Ax0NDWJpFviTtsxRr2+nuno6tPhvtmiz6p1bZll2FC
        0vw0aeDdjxXzVjo6ibjdGE530uJ3o5N617snt9SICA==
X-Google-Smtp-Source: AKy350a7XpW8ILyth8Pj3l7qkWf4XbIWJMfT0RGrVaV5tlzX0k/n0fOMlk+CNbzM/RrYN9188OHk0zfIXxtcZm82LBQ=
X-Received: by 2002:a25:d70a:0:b0:b77:ae4b:1b27 with SMTP id
 o10-20020a25d70a000000b00b77ae4b1b27mr451912ybg.8.1681358868879; Wed, 12 Apr
 2023 21:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230330063450.2289058-2-joychakr@google.com> <ZDVO/fpOZm+lGVZE@smile.fi.intel.com>
 <20230411141115.vrfd6sud66u6xeog@mobilestation> <ZDVyyoN71cB7dvWW@smile.fi.intel.com>
 <20230411150916.24vagjzbhshaujse@mobilestation> <ZDV6FKd/TupHEPMf@smile.fi.intel.com>
 <CAOSNQF3JQKVgvp5M17SzeyF5LB85_ZvkRpp3PZkCYcGcqm8V2g@mail.gmail.com>
 <ZDWJJaYauhOl0Iue@smile.fi.intel.com> <CAOSNQF2dxwbCa7_MrN-qd5mrK9jfpaakeExuMBwctXbsQGmiJQ@mail.gmail.com>
 <CAOSNQF3uie_Jk9xmEu9w6LvZvigkGEu+k5at8+a6chxMLehQHQ@mail.gmail.com> <ZDaxJbFylAU68W3V@smile.fi.intel.com>
In-Reply-To: <ZDaxJbFylAU68W3V@smile.fi.intel.com>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Thu, 13 Apr 2023 09:37:35 +0530
Message-ID: <CAOSNQF0iVtMnX2H6fGZHG3XD+OYWgrWMmVMiPH6Y3V1NY3WsXg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
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

On Wed, Apr 12, 2023 at 6:55=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Apr 12, 2023 at 02:51:44PM +0530, Joy Chakraborty wrote:
> > On Wed, Apr 12, 2023 at 1:11=E2=80=AFAM Joy Chakraborty <joychakr@googl=
e.com> wrote:
> > > On Tue, Apr 11, 2023 at 9:52=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Tue, Apr 11, 2023 at 08:48:52PM +0530, Joy Chakraborty wrote:
> > > > > On Tue, Apr 11, 2023 at 8:47=E2=80=AFPM Andy Shevchenko
> > > > > <andriy.shevchenko@intel.com> wrote:
> > > > > > On Tue, Apr 11, 2023 at 06:09:16PM +0300, Serge Semin wrote:
> > > > > > > On Tue, Apr 11, 2023 at 05:46:34PM +0300, Andy Shevchenko wro=
te:
> > > > > > > > On Tue, Apr 11, 2023 at 05:11:15PM +0300, Serge Semin wrote=
:
> > > > > > > > > On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevchenko=
 wrote:
> > > > > > > > > > On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakrabor=
ty wrote:
>
> ...
>
> > > > > > > > > > > -     if (n_bytes =3D=3D 1)
> > > > > > > > > > > +     switch (n_bytes) {
> > > > > > > > > > > +     case 1:
> > > > > > > > > > >               return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > > > > > > > > > -     else if (n_bytes =3D=3D 2)
> > > > > > > > > > > +     case 2:
> > > > > > > > > > >               return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > > > > > > > > > -
> > > > > > > > > > > -     return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > > > > > > >
> > > > > > > > > > > +     case 3:
> > > > > > > > > >
> > > > > > > > > > I'm not sure about this.
> > > > > > > > >
> > > > > > > > > This actually makes sense seeing the function argument ca=
n have values
> > > > > > > > > 1, 2, _3_ and 4:
> > > > > > > > > dws->n_bytes =3D DIV_ROUND_UP(transfer->bits_per_word, BI=
TS_PER_BYTE);
> > > > > > > > > transfer->bits_per_word =3D __F__(master->bits_per_word_m=
ask =3D SPI_BPW_RANGE_MASK(4, 32));
> > > > > > > > > ...
> > > > > > > > > dw_spi_dma_convert_width(dws->n_bytes)
> > > > > > > > >
> > > > > > > > > The spi_transfer.bits_per_word field value depends on the
> > > > > > > > > SPI peripheral device communication protocol requirements=
 which may
> > > > > > > > > imply the 3-bytes word xfers (even though it's indeed unl=
uckily).
> > > > > > > > >
> > > > > > > > > This semantic will also match to what we currently have i=
n the
> > > > > > > > > IRQ-based SPI-transfer implementation (see dw_writer() an=
d
> > > > > > > > > dw_reader()).
> > > > > > >
> > > > > > > > Nice, but we have DMA_SLAVE_BUSWIDTH_3_BYTES definition for=
 that. Why we don't
> > > > > > > > use it?
> > > > > > >
> > > > > > > We could but there are two more-or-less firm reasons not to d=
o
> > > > > > > that:
> > > > > > > 1. There aren't that much DMA-engines with the
> > > > > > > DMA_SLAVE_BUSWIDTH_3_BYTES capability meanwhile the DW APB SS=
I just
> > > > > > > ignores the upper bits if CTRLR0.DFS is less than the value a=
ctual
> > > > > > > written to the DR registers. Note DW DMAC engine isn't one of=
 such
> > > > > > > controllers. So if we get to meet a peripheral SPI-device wit=
h 3-bytes
> > > > > > > word protocol transfers and the DMA-engine doesn't support it=
 the
> > > > > > > DMA-based transfers may fail (depending on the DMA-engine dri=
ver
> > > > > > > implementation).
> > > > > > > 2. The DW APB SSIs (3.x and 4.x) can be synthesized with the =
APB Data
> > > > > > > Bus Width of 8, 16 and 32. So no matter whether DMA-engine su=
pports
> > > > > > > the 3-bytes bus width the system bus most likely will either =
convert
> > > > > > > the transfers to the proper sized bus-transactions or fail.
> > > > > > >
> > > > > > > So taking all of the above into account not using the
> > > > > > > DMA_SLAVE_BUSWIDTH_3_BYTES macro here seems better than using=
 it with
> > > > > > > a risk to fail some of the platform setups especially seeing =
the DW
> > > > > > > APB SSI ignores the upper bits anyway.
> > > > > >
> > > > > > But this is not about SPI host hardware, it's about the consume=
rs.
> > > > > > They should know about supported sizes. Either we add the corre=
sponding support
> > > > > > to the driver or remove 3 case as I suggested. I don't think it=
's correct to
> > > > > > use 3 as 4.
> > > > >
> > > > > Another thing to add is that as per spi.h even if bits per word i=
s a
> > > > > not a power of 2 the buffer should be formatted in memory as a po=
wer
> > > > > of 2
> > > > > ...
> > > > >  * @bits_per_word: Data transfers involve one or more words; word=
 sizes
> > > > >  * like eight or 12 bits are common.  In-memory wordsizes are
> > > > >  * powers of two bytes (e.g. 20 bit samples use 32 bits).
> > > > >  * This may be changed by the device's driver, or left at the
> > > > >  * default (0) indicating protocol words are eight bit bytes.
> > > > >  * The spi_transfer.bits_per_word can override this for each tran=
sfer.
> > > > > ...
> > > > > Hence for n_bytes =3D 3 or 24 bits/per word we expect the client =
SW to
> > > > > format it to 4 byte buffers hence the transaction generated shoul=
d
> > > > > also be of size 4 from the DMA.
> > > >
> > > > You didn't get my point. The consumer wants to know if the 3 bytes =
is supported
> > > > or not, that's should be part of the DMA related thing, right?
> > > >
> > > > It's incorrectly to say 4 for 3 if the backend DMA controller behav=
es differently
> > > > on this. How do you know that (any) DMA controller integrated with =
this hardware
> > > > has no side effects for this change.
> > > >
> > > > So, I don't think the case 3 is correct in this patch.
> > >
> > > I see, I am of the opposite opinion in this case.
> > >
> > > Other then Serge(y)'s points,
> > > I was trying to say that irrespective of what the underlying DMA
> > > controller supports we should use DMA_SLAVE_BUSWIDTH_4_BYTES when
> > > n_bytes =3D 3 from SPI perspective as we get n_bytes from bits per wo=
rd
> > > passed by the client / spi framework " dws->n_bytes =3D
> > > DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE) ".
> > > Based on the spi header what I perceive is that for bits/word between
> > > 17 and 32 the data has to be stored in 32bit words in memory as per
> > > the example in the header " (e.g. 20 bit samples use 32 bits) ".
> > >
> > > Hence, taking an example to transfer 6 bytes (say 0xAA 0xBB 0xCC 0xDD
> > > 0xEE 0xFF) with bits per word as 24 (n_bytes =3D 3) i.e. a total of 2
> > > words I expect the buffer to look as follows which is coming from the
> > > client:
> > > _ _____address|__________0________4________8________C
> > >     SD:00000000|>00CCBBAA 00FFEEDD 00000000 00000000
> > > Hence to transfer this successfully the DMA controller would need to
> > > copy 4 bytes per word .
> > >
> > > Please correct me if my understanding of this is incorrect.
>
> Thank you for finding the answer for me by yourself!
>
> > On the other hand I do see that in the fifo driver dw_writer() /
> > dw_reader() increments the pointer with 3 incase n_bytes =3D 3 even
> > though it copies 4 bytes.
> > ...
> >    if (dws->n_bytes =3D=3D 1)
> >       txw =3D *(u8 *)(dws->tx);
> >    else if (dws->n_bytes =3D=3D 2)
> >       txw =3D *(u16 *)(dws->tx);
> >    else
> >       txw =3D *(u32 *)(dws->tx);
> >
> > dws->tx +=3D dws->n_bytes;
> > ...
> > This will not behave as using DMA_SLAVE_BUSWIDTH_4_BYTES in the DMA so
> > maybe I am not correct in interpretting the spi.h header file.
> > Can CPU's in general access u32 from unaligned odd addresses ?
>
> Generally speaking the above code must check number of bytes for being 4.
>
> > From Serge(y)'s comment regarding this, the APB interface writing data
> > to the FIFO register definitely cannot handle
> > DMA_SLAVE_BUSWIDTH_3_BYTES since it handles a power of 2 only.
> > Hence we can possibly remove "case 3:" completely and also mask out
> > DMA_SLAVE_BUSWIDTH_3_BYTES from dma_addr_width capabilities so that
> > can_dma api does not allow n_bytes =3D 3 to use DMA.
> >
> > Would that be correct ?
>
> We have to fix the above and the DIV_ROUND_UP(transfer->bits_per_word,
> BITS_PER_BYTE) one to be something like
>
> roundup_pow_of_two(round_up(..., BITS_PER_BYTE))
>

Hello Serge(y),

Are we okay in removing n_bytes=3D3 support from the dma driver switch case=
 ?
This will also lead to can_dma returning false for n_bytes=3D3 which
will essentially make it fall back to fifo mode.

> > > > > > > > > > > +     case 4:
> > > > > > > > > > > +             return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > > > > > > > > > +     default:
> > > > > > > > > > > +             return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > > > > > > > > +     }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
