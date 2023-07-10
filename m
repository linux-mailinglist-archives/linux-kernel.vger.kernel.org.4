Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4F274CEA2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGJHiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGJHis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:38:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0CFFA;
        Mon, 10 Jul 2023 00:38:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e362e4c61so4395660a12.0;
        Mon, 10 Jul 2023 00:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688974718; x=1691566718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0RrzppqWK8amO/hYoEe/sGNQQUvYJv9b/1K1O2WuZU=;
        b=F+ykSINOl4JRcwz99T0450qy+LEU7sfc349swulXvKki2qEkI+R5mVjp6cGVCUcaB+
         2/bT0MY6O2SPSnidD0o9U34h4ayAE5tYsXWKYz0hL6jr1y9AEJKel5ppzFKFClYULaUF
         PlVx1UmgaggLHEN7xpIH6Hc79U+/J3IvRJdX1ctKjGzwfGlDvGnsVPmuyBp/lvEWHiy5
         MkUhrbGeI/dRqAGPBoBhc5hI4QVR0p2aGyoEpDKc0WF/4+Dk1GmoGx943XmNyWte/IUD
         YaVzb2lmpoakA4dFgYnsH55BaIfbhDSQ7arKyUPZXY39F4oGdtev96ixkxBnekUJK2lB
         b2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974718; x=1691566718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0RrzppqWK8amO/hYoEe/sGNQQUvYJv9b/1K1O2WuZU=;
        b=Vdn8yLhnO+gfpN0WeWuaSqjZicMtSlrHltvJzSiikLEB+pm8AzvZmuVHQvdt/6yp2I
         9tkx5vq0QB2kxPHY0cuWQlpMDhxJvqCSjInepLSb8o280K3scf0a3BmjwpMztNeLMB+n
         xo8cYpnJU02Dj/6NWg6eBZB5tXMtyY5m8OAwo2Qa83V6dmutR0URqQ33ErehfqSP3VS1
         E/ZbGjZ8bIs/PL18ZAp3LmPUNFXcb9PS72BAslxkhXriNFmCqIsoeaRGuYb1cBeMH4bt
         bLizTH0R66Qf49Pq/sg1zX051/UoFrApC/eSFRDkW3V4IhIl+5YMH1951ULVcPouLCX2
         QjIw==
X-Gm-Message-State: ABy/qLaSlYyPzA3s8yvbL1aZeHr6YKcWA0Rsj4oT/s0BE7Crkr9NVmVf
        XmPzqGwKjJ4+2BPD8srAlHFlaLS8O0fMZyKQJrk=
X-Google-Smtp-Source: APBJJlGqkEdiipwucOvH/n8Bin+i1fTRMPJtr6nPaHPI0UGzqG1RimEwKjIAW5V0oxDqJelykWgtvGWC6FX/ZB54C7Q=
X-Received: by 2002:a17:906:15d:b0:993:ffcb:ad54 with SMTP id
 29-20020a170906015d00b00993ffcbad54mr4324698ejh.10.1688974718518; Mon, 10 Jul
 2023 00:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230710042723.46084-1-kimseer.paller@analog.com>
 <20230710042723.46084-2-kimseer.paller@analog.com> <CAHp75Vd386P9xM_+wLahp6B_XwYVq1AZxaFQeWvZ2pnk-tFGHA@mail.gmail.com>
In-Reply-To: <CAHp75Vd386P9xM_+wLahp6B_XwYVq1AZxaFQeWvZ2pnk-tFGHA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Jul 2023 10:38:02 +0300
Message-ID: <CAHp75VcvHQ7m8y5Rm6nVtF-iYop4Gjyzgoo=2jQQkWbc0SQ5Kg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] iio: adc: max14001: New driver
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 10:36=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jul 10, 2023 at 7:27=E2=80=AFAM Kim Seer Paller
> <kimseer.paller@analog.com> wrote:

...

> > V8 -> V9: Changed SPI buffer data types to __le16,
>
> Why?
>
> ...
>
> > +       __le16                  spi_tx_buffer __aligned(IIO_DMA_MINALIG=
N);
> > +       __le16                  spi_rx_buffer;
>
> ...
>
> > +       /*
> > +        * Prepare SPI transmit buffer 16 bit-value to big-endian forma=
t and
> > +        * reverses bit order to align with the LSB-first input on SDI =
port.
>
> reverse
>
> > +        */
> > +       st->spi_tx_buffer =3D bitrev16(cpu_to_be16(FIELD_PREP(MAX14001_=
ADDR_MASK,
> > +                                    reg_addr)));
>
> ...
>
> > +       /*
> > +        * Convert received 16-bit value from big-endian to little-endi=
an format
> > +        * and reverses bit order.
>
> reverse
>
> > +        */
> > +       *data =3D bitrev16(be16_to_cpu(st->spi_rx_buffer));

On top of that, this left unfixed.

...

> > +       /*
> > +        * Prepare SPI transmit buffer 16 bit-value to big-endian forma=
t and
> > +        * reverses bit order to align with the LSB-first input on SDI =
port.
>
> reverse
>
> > +        */
> > +       st->spi_tx_buffer =3D bitrev16(cpu_to_be16(
> > +                                    FIELD_PREP(MAX14001_ADDR_MASK, reg=
_addr) |
> > +                                    FIELD_PREP(MAX14001_SET_WRITE_BIT,=
 1) |
> > +                                    FIELD_PREP(MAX14001_DATA_MASK, dat=
a)));
>
> Obviously it's incorrect now even more than before.
> The types are defined as __le, while ops are against __be.


--=20
With Best Regards,
Andy Shevchenko
