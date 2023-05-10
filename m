Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E906B6FD7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbjEJHEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjEJHEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:04:00 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAFE8F;
        Wed, 10 May 2023 00:03:58 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7577ef2fa31so985015585a.0;
        Wed, 10 May 2023 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683702237; x=1686294237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+HCy3L2OnT5uHyCBmjF1m1zbqDCsY+LQg7JElf9toM=;
        b=kVYndPf5sb08mccQU66KR3JCC+q0Wdd4ROZcbwPKP6FR3dGSWvS+wZM27gbuKva/4i
         8ansQJVEPiS8/7temIWSXq9mdwMiaJeuJ0ZRHu2y5R6SL7FeDvozo03VTxGVNbGNMh7A
         LwSt8f6Bq96H8PNNp1qo735wQiBvIXK7WgOx6r3XDRA6/361NHbaoy5f82kvB0tOi91z
         iZRO654VRFHoCd3QeExHTeaL6mjESrpLoVgOSM4Ya7TvtZJH/mdLz+V15eqfeq5PXSR+
         DBuL1e1zzDie6JHFUv2zbHdx/e5aG8vDPkfBJIJHbBpx/rM7t+/1TYaz+swH+PyMd28J
         1d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683702237; x=1686294237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+HCy3L2OnT5uHyCBmjF1m1zbqDCsY+LQg7JElf9toM=;
        b=TnJjQ1KVFFZ0XDvvYcDl7MrYekGwY/nAothYwLlwVPKqcytxsLfDt/grCh5pOBWOoU
         kwOu1CEGWe87yh6ya6qQK3hK3SsDA8y4XiKefDglW2E9PeNLX5TkvTccFKqSOc19BKLL
         M7PS84yhjEiUkLByllntPQ0qS1fC1XC9BxnaFUHU4F8RfOliM/U2VFcuDw10g63dOiOY
         rhCYTNwOBU+0QmixG2eJi1rSb0U+9iuW9nIdKAltElyYrqDe+dRzpitOPQAulHEQcWj7
         brxwf3P5aSOHvMBYpXhA6qRQNpVLbRdonFHQhP7nW7SbprQogs4PjUE6HVbP5+IMftr8
         gyIA==
X-Gm-Message-State: AC+VfDx2opuOdnXzIcOrSosxsi2m6BMSvmXM8OQ87Q4nnC7ihTiO4jns
        VvExURTJqfCOjKu3CRSKbW7OJTLARCjx6bO7tog=
X-Google-Smtp-Source: ACHHUZ5Gj2ySOz0kMiZ6YZ+cJ3qh4WUDHZ4Brzpcqyv6S+0CxD50qj9STQcRmWDOHapDR7NxP0hHWt1vmcwQEnbbrZI=
X-Received: by 2002:a05:6214:491:b0:616:7977:2460 with SMTP id
 pt17-20020a056214049100b0061679772460mr26683509qvb.24.1683702237418; Wed, 10
 May 2023 00:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230426071045.20753-1-zhuyinbo@loongson.cn> <20230426071045.20753-3-zhuyinbo@loongson.cn>
 <ZFkPZhF8QqScXAmH@surfacebook> <ZFnOZptCM7JDFTQz@finisterre.sirena.org.uk>
In-Reply-To: <ZFnOZptCM7JDFTQz@finisterre.sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 May 2023 10:03:21 +0300
Message-ID: <CAHp75VcqQR0fFdkWG2QgXG0+SnKDs6_Zze6GMt+pHHEdE+8hkg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson spi controller
To:     Mark Brown <broonie@kernel.org>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
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

On Tue, May 9, 2023 at 7:39=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
> On Mon, May 08, 2023 at 06:04:06PM +0300, andy.shevchenko@gmail.com wrote=
:
> > Wed, Apr 26, 2023 at 03:10:45PM +0800, Yinbo Zhu kirjoitti:

...

> > > +           loongson_spi_write_reg(loongson_spi,
> > > +                                  LOONGSON_SPI_SFCS_REG,
> > > +                                  (val ? (0x11 << spi->chip_select) =
:
> > > +                                  (0x1 << spi->chip_select)) | cs);
>
> > Too many parentheses.
>
> The code is absolutely fine, there is nothing wrong with adding explicit
> parentheses even where not strictly needed if it helps to make things
> clear (which is obviously always a problem wiht ternery operator use).

> Please, stop this sort of nitpicking.  It is at times actively unhelpful.

Okay, sorry for the noise.

...

> > > +           bit =3D fls(div) - 1;
> > > +           if ((1<<bit) =3D=3D div)
> > > +                   bit--;
> > > +           div_tmp =3D rdiv[bit];
>
> > I believe this can be optimized.
>
> This isn't constructive feedback, if there is a concrete optimisation
> you want to suggest please just suggest it.

It goes together with the other questions in this function. But if you
think about some code proposal, here we are:

_original_

       const char rdiv[12] =3D {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};

               div =3D DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz);
               if (div < 2)
                       div =3D 2;
               if (div > 4096)
                       div =3D 4096;

               bit =3D fls(div) - 1;
               if ((1<<bit) =3D=3D div)
                       bit--;
               div_tmp =3D rdiv[bit];

               loongson_spi->spcr =3D div_tmp & 3;
               loongson_spi->sper =3D (div_tmp >> 2) & 3;

_proposed_

       const char rdiv[12] =3D {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};

// as far as I understood the above table
00 00  [0]  <=3D 2
00 01  [1]  <=3D 4
01 00  [2]  <=3D 8
00 10  [3]  <=3D 16
00 11  [4]  <=3D 32
01 01  [5]  <=3D 64
01 10  [6]  <=3D 128
01 11  [7]  <=3D 256
10 00  [8]  <=3D 512
10 01  [9]  <=3D 1024
10 10  [10]  <=3D 2048
10 11  [11]  <=3D 4096

               div =3D
clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2, 4096);
               div_tmp =3D rdiv[fls(div - 1)];

               loongson_spi->spcr =3D (div_tmp & GENMASK(1, 0)) >> 0;
               loongson_spi->sper =3D (div_tmp & GENMASK(3, 2)) >> 2;

But TBH I would expect the author to think about it more.

Also the check can be modified to have less indented code:

       if (hz && loongson_spi->hz =3D=3D hz)
          return 0;

       if (!((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK))
          return 0;

...


> > > +EXPORT_SYMBOL_GPL(loongson_spi_init_master);
>
> > Please, use _NS variant.
>
> It really does not matter, the chances of any collisions is pretty much
> zero.

The point is in preventing us from using those symbols outside of the scope=
.

--
With Best Regards,
Andy Shevchenko
