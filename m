Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A543748113
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjGEJhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbjGEJhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:37:25 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6191713;
        Wed,  5 Jul 2023 02:37:18 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso104820451fa.0;
        Wed, 05 Jul 2023 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688549837; x=1691141837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbjoiZq6AfX5dwbo6yRk76/MzLjNZXEKe0cX4GoX7M0=;
        b=HNGBF1f4AUCjmymimnNOxUZFpQrU9j20YdJheo6Pfq/sWvwSLruPPj/SOSnZhbLioX
         tIiNsG2GIa47kxXauDMAWQzxOSSnwpH1a2mRIq26Fw/+fimMDRemF2AypdMoYcdHxE0S
         wGwm2zGDkx5Dl1fA0cFiTe68DawpUrJQ0IPqGVw7m0RMGa3gyTGHhNBlFcLDQ56MpiCD
         gTQuvh3NDJqeIQE6JoT1ZXPLNjFHGSOzw9GN9T3dyUCAElRdrq1HhbsxUUA6xfXMotRq
         MUbCWOnue7f2Y/hw4Hdw8hYypwULZFLLdUtd/ELREQ4VVmoXQBtVHYDhUmMZnQ2lttMe
         qCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688549837; x=1691141837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbjoiZq6AfX5dwbo6yRk76/MzLjNZXEKe0cX4GoX7M0=;
        b=IdKgs17mwrBDoh7Ih8aB9DIGmXwdy5s3YWj53Nk56NtBav+BSUaQoL4KbYng+4WoKq
         QwGniB8q/HWYhSPBZ0DaDrKgHAzl3lL0MdR4phFq8dVfF/cKC40MmaPLoX1hwnxHVwH6
         Za/71zTnX+QH33ZX/cB1ywcdu1E+KXAzJW/ZqRo7Dut7ezCgKnKNpCboaPXteadwbOFj
         Bk7XiQPecBTddmZbKwChOMoW4AIaEEB0mf0uldPqoBbVaiFWLZAzXAWOmGx1JSXCdyS/
         IrXspNzABq/APtaWlbL4aEU++vdwB875pFFoH/v/mVrPj4W1ZzOJIWk105FgHOa6yAX+
         QTdA==
X-Gm-Message-State: ABy/qLZCt8s7AgvapUf2r0iWKZEinPbQ+4s+OaYki+SPnbytWtLrwLF8
        jSyj2xXKpsvLZj1dX8Ct4ZU0/omz1F0Ogd7Etr0=
X-Google-Smtp-Source: APBJJlGDw6J6azx15CuvTRtvSrLI2GdQaJ5ALHCmxzkCGNVAOfexBjwP2BvPaGDYEQKhm0vLNZt9SiWWGYzS1wBvHLg=
X-Received: by 2002:a2e:9cda:0:b0:2b2:90e:165d with SMTP id
 g26-20020a2e9cda000000b002b2090e165dmr10630878ljj.2.1688549836647; Wed, 05
 Jul 2023 02:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230622143227.30147-1-kimseer.paller@analog.com>
 <20230622143227.30147-2-kimseer.paller@analog.com> <20230702180315.00003dbe@Huawei.com>
 <fcf6daf6afec48b096df14d8b5308db0@analog.com> <20230705155530.00002074@Huawei.com>
 <CAHp75VfGFXtX2UCV+EzSMGaRMc5=WUpUJpRFB_K6NMJO2+iszg@mail.gmail.com> <20230705172834.00001853@Huawei.com>
In-Reply-To: <20230705172834.00001853@Huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jul 2023 12:36:40 +0300
Message-ID: <CAHp75Ve_pBvVRxHTyvFy_-cWq9dNapO0hYn=ujXCPCqgQ1obUA@mail.gmail.com>
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

On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> On Wed, 5 Jul 2023 11:53:17 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jul 5, 2023 at 10:55=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > > > > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > > > > Sent: Sunday, July 2, 2023 6:04 PM
> > > > > On Thu, 22 Jun 2023 22:32:27 +0800
> > > > > Kim Seer Paller <kimseer.paller@analog.com> wrote:

...

> > > > > > + /*
> > > > > > +  * Convert transmit buffer to big-endian format and reverse t=
ransmit
> > > > > > +  * buffer to align with the LSB-first input on SDI port.
> > > > > > +  */
> > > > > > + st->spi_tx_buffer =3D
> > > > > cpu_to_be16(bitrev16(FIELD_PREP(MAX14001_ADDR_MASK,
> > > > > > +                                                         reg_a=
ddr)));
> > > > > > +
> > > > > > + ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > > > > > + if (ret)
> > > > > > +         return ret;
> > > > > > +
> > > > > > + /*
> > > > > > +  * Align received data from the receive buffer, reversing and=
 reordering
> > > > > > +  * it to match the expected MSB-first format.
> > > > > > +  */
> > > > > > + *data =3D (__force u16)(be16_to_cpu(bitrev16(st->spi_rx_buffe=
r))) &
> > > > > > +
> > > > >     MAX14001_DATA_MASK;
> > > > > > +
> > > > > These sequences still confuse me a lot because I'd expect the val=
ues in tx
> > > > > to have the opposite operations applied to those for rx and that'=
s not the
> > > > > case.
> > > > >
> > > > > Let's take a le system.
> > > > > tx =3D cpu_to_be16(bitrev16(x))
> > > > >    =3D cpu_to_be16((__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)=
);
> > > > >    =3D __bitrev8(x & 0xff) | (__bitrev8(x >> 8) << 8)
> > > > > or swap all the bits in each byte, but don't swap the bytes.
> > > > >
> > > > > rx =3D cpu_to_be16(bitrev16(x))
> > > > >    =3D be16_to_cpu(((__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8=
)_
> > > > >    =3D __bitrev8(x & 0xff) | __bitrev(x >> 8)
> > > > >
> > > > > also swap all the bits in each byte, but don't swap the bytes.
> > > > >
> > > > > So it is the reverse because the bytes swaps unwind themselves so=
mewhat.
> > > > > For a be system cpu_to_be16 etc are noop.
> > > > > tx =3D (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)
> > > > > rx =3D (__bitrev8(x & 0xff) << 8) | __bitrev8(x >> 8)
> > > > >
> > > > > So in this case swap all 16 bits.
> > > > >
> > > > > Now, given I'd expected them to be reversed for the tx vs rx case=
.
> > > > > E.g.
> > > > > tx =3D cpu_to_be16(bitrev16(x))
> > > > > As above.
> > > > > For rx, le host
> > > > > rx =3D bitrev16(be16_to_cpu(x))
> > > > >    =3D __bitrev8((x >> 8) & 0xff) << 8) |  __bitrev8((((x & 0xff)=
 << 8) >> 8)
> > > > > same as above (if you swap the two terms I think.
> > > > >
> > > > > For be the be16_to_cpu is a noop again, so it's just bitrev16(x) =
as expected.
> > > > >
> > > > > Hence if I've understood this correctly you could reverse the ter=
ms so that
> > > > > it was 'obvious' you were doing the opposite for the tx term vs t=
he rx one
> > > > > without making the slightest bit of difference....
> > > > >
> > > > > hmm. Might be worth doing simply to avoid questions.
> > > >
> > > > Thank you for your feedback. I have tested the modifications based =
on your
> > > > suggestions, taking the le system into account, and it appears that=
 the code is
> > > > functioning correctly. Before sending the new patch version, I woul=
d like to
> > > > confirm if this aligns with your comments.
> >
> > > Yes. This looks good to me.
> >
> > I think the implementation is still incorrect. See below.
> >
> > > > static int max14001_read(void *context, unsigned int reg_addr, unsi=
gned int *data)
> > > > {
> > > >       struct max14001_state *st =3D context;
> > > >       int ret;
> > > >
> > > >       struct spi_transfer xfers[] =3D {
> > > >               {
> > > >                       .tx_buf =3D &st->spi_tx_buffer,
> > > >                       .len =3D sizeof(st->spi_tx_buffer),
> > > >                       .cs_change =3D 1,
> > > >               }, {
> > > >                       .rx_buf =3D &st->spi_rx_buffer,
> > > >                       .len =3D sizeof(st->spi_rx_buffer),
> > > >               },
> > > >       };
> >
> > > >       st->spi_tx_buffer =3D cpu_to_be16(bitrev16(FIELD_PREP(MAX1400=
1_ADDR_MASK, reg_addr)));
> >
> > Here we got bits in CPU order, reversed them and converted to BE16.
> >
> > > >       ret =3D spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > > >       if (ret)
> > > >               return ret;
> >
> > > >       *data =3D cpu_to_be16(bitrev16(st->spi_rx_buffer));
> >
> > Here we take __be16 response, reverse them and convert to BE16?!
> > This is weird. You should have be16_to_cpu() somewhere, not the opposit=
e.
> Good point - though functionally they end up the same (and the bitrev
> is making mess of type markings anyway). It is more logical
> to ensure the direction is reversed as you suggest.

Also a question why we don't do that in reversed order.
Logically it sounds like bitrev16(be16_to_cpu()) should be.
Will it give the wrong results?

All in all this algo should be described in the comment in the code
(if not yet).

> > > >       return 0;
> > > > }

--=20
With Best Regards,
Andy Shevchenko
