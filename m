Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1471974802B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjGEIx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjGEIx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:53:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206E2E47;
        Wed,  5 Jul 2023 01:53:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51d804c7d14so7306151a12.3;
        Wed, 05 Jul 2023 01:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688547233; x=1691139233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdE8F2uO38nQsHKjX0h4XqPkScCcUMmKFxPRZlkdB6k=;
        b=QJ8DEfmdrQwqqtb+exV62DRH/3rmSJIEKr/vH9ulSmYVG6BqI69DpipVTLt/Gc7X4U
         lgM1RMh7RyA3pfs5nO0xDH4kd045bx24gn9wEjVgYpTVVYxCM9en+Yuo73eI3zTH9/Uq
         J7xac1E4aib9ePEVp0oylp65yjJzFizyRpkY1Gi2qvZ8ysksndyDhilEg3PNqd5TxQmM
         3OpSpqbDFpUTPBqrgSqUPFFvWqXsp5wYm+hv/W/d1WXm6a1QVGGLmh7sRxaJplub5d6Y
         anj2JeSNVCTAwRCDe4dElkllipdza3YzAiAVmc/r/HRF1mQqnCVnxVI6IenvkI1l0d/d
         gsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688547233; x=1691139233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdE8F2uO38nQsHKjX0h4XqPkScCcUMmKFxPRZlkdB6k=;
        b=Z03Zuhdix2IHXTJgcI9O5vtLuz+pi//3iD1hPPWNMVHHDaSiw0OLG0WbFiRTr6xFXE
         SXi9CO8GGHjVFz742Dq2oy9qlc44Ml46YGLw5NgUOCRt1rLk+HN6o0DuGYmXFcpwGVDC
         heVT/OyLI/A4rJJCr9pPc7F4uo6XiGTzFcxC3/p6NODFTssICDPjkdqZj27UlXTv4OuD
         ufOja+4Z3cv8iMnxHgjnF1Me0vZxfVA50EQxucgC3Y/3xeoKTja+Gu+8GgwWrfVLuwOR
         LdVA3c4FCgSrjfObrpY5ENZ6/XuH06zMMLsOAeqeWipJPFCH2aWwwl6TqQUDHG32Tdpr
         Kccg==
X-Gm-Message-State: ABy/qLYjsbn4F/Vtt8klCxl6qOrp7iUdS2FFnWebmu/4HiabO3d2AQjo
        1wiMYIlB05oMwF0SYGARzeydE8D+f2c/mHIw4qs=
X-Google-Smtp-Source: APBJJlHAXbO3ehAkyzPZ0xSMx64aVJhLpOO5LcrJQQSzsY02UtCMV67bG32F3lT5dwi+EIgedhujuaC3R95Rbg4CiRM=
X-Received: by 2002:aa7:dad2:0:b0:51d:d0fc:9df8 with SMTP id
 x18-20020aa7dad2000000b0051dd0fc9df8mr9259242eds.41.1688547233393; Wed, 05
 Jul 2023 01:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230622143227.30147-1-kimseer.paller@analog.com>
 <20230622143227.30147-2-kimseer.paller@analog.com> <20230702180315.00003dbe@Huawei.com>
 <fcf6daf6afec48b096df14d8b5308db0@analog.com> <20230705155530.00002074@Huawei.com>
In-Reply-To: <20230705155530.00002074@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jul 2023 11:53:17 +0300
Message-ID: <CAHp75VfGFXtX2UCV+EzSMGaRMc5=WUpUJpRFB_K6NMJO2+iszg@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] iio: adc: max14001: New driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 10:55=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > Sent: Sunday, July 2, 2023 6:04 PM
> > > On Thu, 22 Jun 2023 22:32:27 +0800
> > > Kim Seer Paller <kimseer.paller@analog.com> wrote:

...

> > > > + /*
> > > > +  * Convert transmit buffer to big-endian format and reverse trans=
mit
> > > > +  * buffer to align with the LSB-first input on SDI port.
> > > > +  */
> > > > + st->spi_tx_buffer =3D
> > > cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_ADDR_MASK,
> > > > +                                                         reg_addr)=
));
> > > > +
> > > > + ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > > > + if (ret)
> > > > +         return ret;
> > > > +
> > > > + /*
> > > > +  * Align received data from the receive buffer, reversing and reo=
rdering
> > > > +  * it to match the expected MSB-first format.
> > > > +  */
> > > > + *data =3D (__force u16)(be16_to_cpu(bitrev16(st->spi_rx_buffer)))=
 &
> > > > +
> > >     MAX14001_DATA_MASK;
> > > > +
> > > These sequences still confuse me a lot because I'd expect the values =
in tx
> > > to have the opposite operations applied to those for rx and that's no=
t the
> > > case.
> > >
> > > Let's take a le system.
> > > tx =3D cpu_to_be16(bitrev16(x))
> > >    =3D cpu_to_be16((__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8));
> > >    =3D __bitrev8(x & 0xff) | (__bitrev8(x >> 8) << 8)
> > > or swap all the bits in each byte, but don't swap the bytes.
> > >
> > > rx =3D cpu_to_be16(bitrev16(x))
> > >    =3D be16_to_cpu(((__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)_
> > >    =3D __bitrev8(x & 0xff) | __bitrev(x >> 8)
> > >
> > > also swap all the bits in each byte, but don't swap the bytes.
> > >
> > > So it is the reverse because the bytes swaps unwind themselves somewh=
at.
> > > For a be system cpu_to_be16 etc are noop.
> > > tx =3D (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)
> > > rx =3D (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)
> > >
> > > So in this case swap all 16 bits.
> > >
> > > Now, given I'd expected them to be reversed for the tx vs rx case.
> > > E.g.
> > > tx =3D cpu_to_be16(bitrev16(x))
> > > As above.
> > > For rx, le host
> > > rx =3D bitrev16(be16_to_cpu(x))
> > >    =3D __bitrev8((x >> 8) & 0xff) << 8) |  __bitrev8((((x & 0xff) << =
8) >> 8)
> > > same as above (if you swap the two terms I think.
> > >
> > > For be the be16_to_cpu is a noop again, so it's just bitrev16(x) as e=
xpected.
> > >
> > > Hence if I've understood this correctly you could reverse the terms s=
o that
> > > it was 'obvious' you were doing the opposite for the tx term vs the r=
x one
> > > without making the slightest bit of difference....
> > >
> > > hmm. Might be worth doing simply to avoid questions.
> >
> > Thank you for your feedback. I have tested the modifications based on y=
our
> > suggestions, taking the le system into account, and it appears that the=
 code is
> > functioning correctly. Before sending the new patch version, I would li=
ke to
> > confirm if this aligns with your comments.

> Yes. This looks good to me.

I think the implementation is still incorrect. See below.

> > static int max14001_read(void *context, unsigned int reg_addr, unsigned=
 int *data)
> > {
> >       struct max14001_state *st =3D context;
> >       int ret;
> >
> >       struct spi_transfer xfers[] =3D {
> >               {
> >                       .tx_buf =3D &st->spi_tx_buffer,
> >                       .len =3D sizeof(st->spi_tx_buffer),
> >                       .cs_change =3D 1,
> >               }, {
> >                       .rx_buf =3D &st->spi_rx_buffer,
> >                       .len =3D sizeof(st->spi_rx_buffer),
> >               },
> >       };

> >       st->spi_tx_buffer =3D cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_AD=
DR_MASK, reg_addr)));

Here we got bits in CPU order, reversed them and converted to BE16.

> >       ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> >       if (ret)
> >               return ret;

> >       *data =3D cpu_to_be16(bitrev16(st->spi_rx_buffer));

Here we take __be16 response, reverse them and convert to BE16?!
This is weird. You should have be16_to_cpu() somewhere, not the opposite.

> >       return 0;
> > }

Isn't, btw, the reinvented spi_...write_then_read() (or what is it
called?) call?

> > static int max14001_write(void *context, unsigned int reg_addr, unsigne=
d int data)
> > {
> >       struct max14001_state *st =3D context;
> >
> >       st->spi_tx_buffer =3D cpu_to_be16(bitrev16(
> >                               FIELD_PREP(MAX14001_ADDR_MASK, reg_addr) =
|
> >                               FIELD_PREP(MAX14001_SET_WRITE_BIT, 1) |
> >                               FIELD_PREP(MAX14001_DATA_MASK, data)));
> >
> >       return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx_b=
uffer));
> > }

--=20
With Best Regards,
Andy Shevchenko
