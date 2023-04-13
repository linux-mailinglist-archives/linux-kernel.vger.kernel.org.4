Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D776E15C5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjDMUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:23:41 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C99A76AA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:23:40 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id a13so16830277ybl.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681417419; x=1684009419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpZqH9F5O0fZ0UaszGUloIGsGAzSbIVCO3MewG/VXyw=;
        b=HXYqIuBf4skVk8d/Ld9UmuQTc/BXAFTaRRtXLppbaa3TIL5sI6IfY7YQC6e/RKK/2F
         KRfljJbR7hkPuVURmo5NYYPjSlD241eynMHyjDcpe28429It+aVeuiuQlk4zoRvgbUGC
         fLyHThAEg8IwZCUMfO4vyvGrycIXONSaWsGkHPjxZWcHMY0wDJasBVItr3epRn1zsfyl
         7s8RU5+a5hZ2auDoG/Y66c2KSY+8LxDL69vO2ZPBDU7YkgCP1Ty9v8v8QD617GTEOFbe
         Rj9tQZnNDo8fxIovkEl1Eb/VqRJYkidAMxV6+t2L8aZp31fWLYQl6tXeYzS+2botruK1
         0RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681417419; x=1684009419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpZqH9F5O0fZ0UaszGUloIGsGAzSbIVCO3MewG/VXyw=;
        b=Qm3dRisdS7RCYolmqPxdiu6002UOIT733yxjWnRL1GHQXlA99hkkUjYtdezeFQPZ1E
         rGxIHgXVPxkS4BopE7D3OqlTZ5jU0xb4oE6in6I2EfJ+bAZURgC35kpp22Tg6dDE5TQC
         6xrpPPjRIzNSZMjmw4XG/Hd1uHz5E/OKFes2oVBXqK9JaiMmzhKVpCq3J7axviGpy9Jm
         qqeSfMg4Eq2WHsVIFZYY7SZHZpOCXa+M4fE1ntvGA70CPE6nRp9oL5rnvoP9MQ2LAWDx
         06AB8Haoj1o4KnjowevnUT/6QDgAT+gwXq5a4CLyMTlOzLTuJCBCG6qundDa6wEeVcA0
         /7wQ==
X-Gm-Message-State: AAQBX9dJyPE4XST4SL1IcmHvM8Ti7PzVVwilEoY7b83Nw6ofeCgiT9QR
        EJbGXA02dzKCHka2W4JaiBoxaQCInV8Rn0FZYOk2jw==
X-Google-Smtp-Source: AKy350a1pei8YTdHBsvf0pvJZI1n5M8ANEYae2e0/0q/adP3jHdSJCfIDNz9udBOc+80j0SO5WvinYB6HJVZDh3xW2M=
X-Received: by 2002:a25:748c:0:b0:b8e:f726:d198 with SMTP id
 p134-20020a25748c000000b00b8ef726d198mr1879899ybc.8.1681417419099; Thu, 13
 Apr 2023 13:23:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230411141115.vrfd6sud66u6xeog@mobilestation>
 <ZDVyyoN71cB7dvWW@smile.fi.intel.com> <20230411150916.24vagjzbhshaujse@mobilestation>
 <ZDV6FKd/TupHEPMf@smile.fi.intel.com> <CAOSNQF3JQKVgvp5M17SzeyF5LB85_ZvkRpp3PZkCYcGcqm8V2g@mail.gmail.com>
 <ZDWJJaYauhOl0Iue@smile.fi.intel.com> <CAOSNQF2dxwbCa7_MrN-qd5mrK9jfpaakeExuMBwctXbsQGmiJQ@mail.gmail.com>
 <CAOSNQF3uie_Jk9xmEu9w6LvZvigkGEu+k5at8+a6chxMLehQHQ@mail.gmail.com>
 <ZDaxJbFylAU68W3V@smile.fi.intel.com> <CAOSNQF0iVtMnX2H6fGZHG3XD+OYWgrWMmVMiPH6Y3V1NY3WsXg@mail.gmail.com>
 <20230413134700.uwv6nh3vh7yi5mzc@mobilestation>
In-Reply-To: <20230413134700.uwv6nh3vh7yi5mzc@mobilestation>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Fri, 14 Apr 2023 01:53:28 +0530
Message-ID: <CAOSNQF3Mf7T243cRK5TpiLSd0DbW1svkDizS02ZKAXdancTh5w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] spi: dw: Add 32 bpw support to DW DMA Controller
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
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

On Thu, Apr 13, 2023 at 7:17=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> Hi Joy
>
> On Thu, Apr 13, 2023 at 09:37:35AM +0530, Joy Chakraborty wrote:
> > On Wed, Apr 12, 2023 at 6:55=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > On Wed, Apr 12, 2023 at 02:51:44PM +0530, Joy Chakraborty wrote:
> > > > On Wed, Apr 12, 2023 at 1:11=E2=80=AFAM Joy Chakraborty <joychakr@g=
oogle.com> wrote:
> > > > > On Tue, Apr 11, 2023 at 9:52=E2=80=AFPM Andy Shevchenko
> > > > > <andriy.shevchenko@intel.com> wrote:
> > > > > > On Tue, Apr 11, 2023 at 08:48:52PM +0530, Joy Chakraborty wrote=
:
> > > > > > > On Tue, Apr 11, 2023 at 8:47=E2=80=AFPM Andy Shevchenko
> > > > > > > <andriy.shevchenko@intel.com> wrote:
> > > > > > > > On Tue, Apr 11, 2023 at 06:09:16PM +0300, Serge Semin wrote=
:
> > > > > > > > > On Tue, Apr 11, 2023 at 05:46:34PM +0300, Andy Shevchenko=
 wrote:
> > > > > > > > > > On Tue, Apr 11, 2023 at 05:11:15PM +0300, Serge Semin w=
rote:
> > > > > > > > > > > On Tue, Apr 11, 2023 at 03:13:49PM +0300, Andy Shevch=
enko wrote:
> > > > > > > > > > > > On Thu, Mar 30, 2023 at 06:34:49AM +0000, Joy Chakr=
aborty wrote:
> > >
> > > ...
> > >
> > > > > > > > > > > > > -     if (n_bytes =3D=3D 1)
> > > > > > > > > > > > > +     switch (n_bytes) {
> > > > > > > > > > > > > +     case 1:
> > > > > > > > > > > > >               return DMA_SLAVE_BUSWIDTH_1_BYTE;
> > > > > > > > > > > > > -     else if (n_bytes =3D=3D 2)
> > > > > > > > > > > > > +     case 2:
> > > > > > > > > > > > >               return DMA_SLAVE_BUSWIDTH_2_BYTES;
> > > > > > > > > > > > > -
> > > > > > > > > > > > > -     return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > > > > > > > > >
> > > > > > > > > > > > > +     case 3:
> > > > > > > > > > > >
> > > > > > > > > > > > I'm not sure about this.
> > > > > > > > > > >
> > > > > > > > > > > This actually makes sense seeing the function argumen=
t can have values
> > > > > > > > > > > 1, 2, _3_ and 4:
> > > > > > > > > > > dws->n_bytes =3D DIV_ROUND_UP(transfer->bits_per_word=
, BITS_PER_BYTE);
> > > > > > > > > > > transfer->bits_per_word =3D __F__(master->bits_per_wo=
rd_mask =3D SPI_BPW_RANGE_MASK(4, 32));
> > > > > > > > > > > ...
> > > > > > > > > > > dw_spi_dma_convert_width(dws->n_bytes)
> > > > > > > > > > >
> > > > > > > > > > > The spi_transfer.bits_per_word field value depends on=
 the
> > > > > > > > > > > SPI peripheral device communication protocol requirem=
ents which may
> > > > > > > > > > > imply the 3-bytes word xfers (even though it's indeed=
 unluckily).
> > > > > > > > > > >
> > > > > > > > > > > This semantic will also match to what we currently ha=
ve in the
> > > > > > > > > > > IRQ-based SPI-transfer implementation (see dw_writer(=
) and
> > > > > > > > > > > dw_reader()).
> > > > > > > > >
> > > > > > > > > > Nice, but we have DMA_SLAVE_BUSWIDTH_3_BYTES definition=
 for that. Why we don't
> > > > > > > > > > use it?
> > > > > > > > >
> > > > > > > > > We could but there are two more-or-less firm reasons not =
to do
> > > > > > > > > that:
> > > > > > > > > 1. There aren't that much DMA-engines with the
> > > > > > > > > DMA_SLAVE_BUSWIDTH_3_BYTES capability meanwhile the DW AP=
B SSI just
> > > > > > > > > ignores the upper bits if CTRLR0.DFS is less than the val=
ue actual
> > > > > > > > > written to the DR registers. Note DW DMAC engine isn't on=
e of such
> > > > > > > > > controllers. So if we get to meet a peripheral SPI-device=
 with 3-bytes
> > > > > > > > > word protocol transfers and the DMA-engine doesn't suppor=
t it the
> > > > > > > > > DMA-based transfers may fail (depending on the DMA-engine=
 driver
> > > > > > > > > implementation).
> > > > > > > > > 2. The DW APB SSIs (3.x and 4.x) can be synthesized with =
the APB Data
> > > > > > > > > Bus Width of 8, 16 and 32. So no matter whether DMA-engin=
e supports
> > > > > > > > > the 3-bytes bus width the system bus most likely will eit=
her convert
> > > > > > > > > the transfers to the proper sized bus-transactions or fai=
l.
> > > > > > > > >
> > > > > > > > > So taking all of the above into account not using the
> > > > > > > > > DMA_SLAVE_BUSWIDTH_3_BYTES macro here seems better than u=
sing it with
> > > > > > > > > a risk to fail some of the platform setups especially see=
ing the DW
> > > > > > > > > APB SSI ignores the upper bits anyway.
> > > > > > > >
> > > > > > > > But this is not about SPI host hardware, it's about the con=
sumers.
> > > > > > > > They should know about supported sizes. Either we add the c=
orresponding support
> > > > > > > > to the driver or remove 3 case as I suggested. I don't thin=
k it's correct to
> > > > > > > > use 3 as 4.
> > > > > > >
> > > > > > > Another thing to add is that as per spi.h even if bits per wo=
rd is a
> > > > > > > not a power of 2 the buffer should be formatted in memory as =
a power
> > > > > > > of 2
> > > > > > > ...
> > > > > > >  * @bits_per_word: Data transfers involve one or more words; =
word sizes
> > > > > > >  * like eight or 12 bits are common.  In-memory wordsizes are
> > > > > > >  * powers of two bytes (e.g. 20 bit samples use 32 bits).
> > > > > > >  * This may be changed by the device's driver, or left at the
> > > > > > >  * default (0) indicating protocol words are eight bit bytes.
> > > > > > >  * The spi_transfer.bits_per_word can override this for each =
transfer.
> > > > > > > ...
> > > > > > > Hence for n_bytes =3D 3 or 24 bits/per word we expect the cli=
ent SW to
> > > > > > > format it to 4 byte buffers hence the transaction generated s=
hould
> > > > > > > also be of size 4 from the DMA.
> > > > > >
> > > > > > You didn't get my point. The consumer wants to know if the 3 by=
tes is supported
> > > > > > or not, that's should be part of the DMA related thing, right?
> > > > > >
> > > > > > It's incorrectly to say 4 for 3 if the backend DMA controller b=
ehaves differently
> > > > > > on this. How do you know that (any) DMA controller integrated w=
ith this hardware
> > > > > > has no side effects for this change.
> > > > > >
> > > > > > So, I don't think the case 3 is correct in this patch.
> > > > >
> > > > > I see, I am of the opposite opinion in this case.
> > > > >
> > > > > Other then Serge(y)'s points,
> > > > > I was trying to say that irrespective of what the underlying DMA
> > > > > controller supports we should use DMA_SLAVE_BUSWIDTH_4_BYTES when
> > > > > n_bytes =3D 3 from SPI perspective as we get n_bytes from bits pe=
r word
> > > > > passed by the client / spi framework " dws->n_bytes =3D
> > > > > DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE) ".
> > > > > Based on the spi header what I perceive is that for bits/word bet=
ween
> > > > > 17 and 32 the data has to be stored in 32bit words in memory as p=
er
> > > > > the example in the header " (e.g. 20 bit samples use 32 bits) ".
> > > > >
> > > > > Hence, taking an example to transfer 6 bytes (say 0xAA 0xBB 0xCC =
0xDD
> > > > > 0xEE 0xFF) with bits per word as 24 (n_bytes =3D 3) i.e. a total =
of 2
> > > > > words I expect the buffer to look as follows which is coming from=
 the
> > > > > client:
> > > > > _ _____address|__________0________4________8________C
> > > > >     SD:00000000|>00CCBBAA 00FFEEDD 00000000 00000000
> > > > > Hence to transfer this successfully the DMA controller would need=
 to
> > > > > copy 4 bytes per word .
> > > > >
> > > > > Please correct me if my understanding of this is incorrect.
> > >
> > > Thank you for finding the answer for me by yourself!
> > >
> > > > On the other hand I do see that in the fifo driver dw_writer() /
> > > > dw_reader() increments the pointer with 3 incase n_bytes =3D 3 even
> > > > though it copies 4 bytes.
> > > > ...
> > > >    if (dws->n_bytes =3D=3D 1)
> > > >       txw =3D *(u8 *)(dws->tx);
> > > >    else if (dws->n_bytes =3D=3D 2)
> > > >       txw =3D *(u16 *)(dws->tx);
> > > >    else
> > > >       txw =3D *(u32 *)(dws->tx);
> > > >
> > > > dws->tx +=3D dws->n_bytes;
> > > > ...
> > > > This will not behave as using DMA_SLAVE_BUSWIDTH_4_BYTES in the DMA=
 so
> > > > maybe I am not correct in interpretting the spi.h header file.
> > > > Can CPU's in general access u32 from unaligned odd addresses ?
> > >
> > > Generally speaking the above code must check number of bytes for bein=
g 4.
> > >
> > > > From Serge(y)'s comment regarding this, the APB interface writing d=
ata
> > > > to the FIFO register definitely cannot handle
> > > > DMA_SLAVE_BUSWIDTH_3_BYTES since it handles a power of 2 only.
> > > > Hence we can possibly remove "case 3:" completely and also mask out
> > > > DMA_SLAVE_BUSWIDTH_3_BYTES from dma_addr_width capabilities so that
> > > > can_dma api does not allow n_bytes =3D 3 to use DMA.
> > > >
> > > > Would that be correct ?
> > >
> > > We have to fix the above and the DIV_ROUND_UP(transfer->bits_per_word=
,
> > > BITS_PER_BYTE) one to be something like
> > >
> > > roundup_pow_of_two(round_up(..., BITS_PER_BYTE))
> > >
> >
> > Hello Serge(y),
> >
> > Are we okay in removing n_bytes=3D3 support from the dma driver switch =
case ?
> > This will also lead to can_dma returning false for n_bytes=3D3 which
> > will essentially make it fall back to fifo mode.
>
> Yes, I am ok with dropping the "3"-case from
> dw_spi_dma_convert_width() in your patch. Could you also provide an
> additional patch in your series which would replace
> DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE) with
> roundup_pow_of_two() as @Andy suggests? It is supposed to be a bug-fix
> AFAICS to the commit a51acc2400d4 ("spi: dw: Add support for 32-bits
> max xfer size").
>
> -Serge(y)
>

Sure, I will update this patch series and resend.

Thanks
Joy
> >
> > > > > > > > > > > > > +     case 4:
> > > > > > > > > > > > > +             return DMA_SLAVE_BUSWIDTH_4_BYTES;
> > > > > > > > > > > > > +     default:
> > > > > > > > > > > > > +             return DMA_SLAVE_BUSWIDTH_UNDEFINED=
;
> > > > > > > > > > > > > +     }
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
