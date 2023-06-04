Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41120721A03
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 22:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbjFDUxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjFDUxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 16:53:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E609CE;
        Sun,  4 Jun 2023 13:53:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-973bf581759so661196766b.0;
        Sun, 04 Jun 2023 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685912023; x=1688504023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMdRlD3RmAquqJCxpsCbMeN6ju6zKj6JUFR8/2WFs3c=;
        b=SiYLabF9JME+54M7MIop3FXo02GsPPG737XXA75vfgXysx6JEEVveTtcYnD4M351P1
         /s/rKCh7h1fZ+wwaITQAKu5C94jPce1i5zUiPFL4LGx5VgSldI62tkTy6V1D3AOmASrR
         B0QssVgniWHFxAKQBO2a+zn1Cm1fvjfSDjYNnpuRK3B4alME2Cd0LkjNY+gFdcsSBa2v
         4CTiIqGSsDWOK9Nih35PvQ0p0HvA6cOr8fZYSVRZOkeHsXGTyXUZs2KVHaOHFayUuL2z
         3e/iAwBBcI6aS3YdhO6SnLp8YcfiBCpMu2Zd0SM+3/6f/V4Ne8nI98FNeahGUEatZj+W
         W+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685912023; x=1688504023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMdRlD3RmAquqJCxpsCbMeN6ju6zKj6JUFR8/2WFs3c=;
        b=LXTLheQPtOmCpF+LFBIE5ff8HFQpoagzXPriyOVV0J7IT+Bv7+7WRBL7lYZvxA/BZT
         N0uTXMFDt0HZp8Pd4g+vVkDGu6fYioaRU6ekO0rk0m6dtLmpPhgW/o3zaBxyy8pQRQa7
         JEpTIjSEB4vkfYvHjpVRenxMtSKxS6tnnwTKn2M913nMKa6vlEuaKPE483OT2D9NuVHi
         1qngbqgY0ll0ZxS5aMWTAc6DmNyLM2jnbsSb14dkKEmDswKBXyp2ReswrzKkC8vdJJHW
         /gU4xPG3W++96v8mRsvSTN07ArIGdbhWS7l4Tx8mBFLdBkZswodp9Pq7Cn9iqF0SpT45
         VmqQ==
X-Gm-Message-State: AC+VfDw6qLZx3mCAWnSK7beTGa1WQr6qYuPL3gtzjnh6MnWOdjbYb8a2
        S/i1vfNv+JDJb1iZNaKa4H8Xft0s5Labug1yDJc=
X-Google-Smtp-Source: ACHHUZ7GR+ovbrMerE3jxZsLZ74is1r45C4hfWtsepG9CDX8PQO48qsjVKDBY5/BCpbiDVBGRDX1z+EO138N2+BqZ7g=
X-Received: by 2002:a17:907:d29:b0:969:e7da:fcb1 with SMTP id
 gn41-20020a1709070d2900b00969e7dafcb1mr6049931ejc.13.1685912022545; Sun, 04
 Jun 2023 13:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230601223104.1243871-1-bigunclemax@gmail.com>
 <20230601223104.1243871-2-bigunclemax@gmail.com> <ZHoBXxM80aqvLZNt@smile.fi.intel.com>
In-Reply-To: <ZHoBXxM80aqvLZNt@smile.fi.intel.com>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sun, 4 Jun 2023 23:53:30 +0300
Message-ID: <CALHCpMjc5+rsNvTHyy3V-+0bJ3yez+ewnGwyk+k-hvmNaF6TsQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
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

=D0=BF=D1=82, 2 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 17:49, Andy=
 Shevchenko <andriy.shevchenko@linux.intel.com>:

...

> The locks should be explained (what are they for? what do they protect?).
I added the explanation comment in the next version.

...

> > +static const struct regmap_config sun20i_gpadc_regmap_config =3D {
> > +     .reg_bits =3D 32,
> > +     .val_bits =3D 32,
> > +     .reg_stride =3D 4,
> > +     .fast_io =3D true,
>
> I forgot if I asked about regmap lock do you need it?

I think we could drop the regmap altogether. As Andy suggested in
previous series.

...

> > +     if (num_channels > SUN20I_GPADC_MAX_CHANNELS) {
> > +             dev_err(dev, "num of channel children out of range");
> > +             return -EINVAL;
> > +     }
>
> Is it really critical error?

Yes, as Jonathan already noted, this may lead to out of range error.

=D0=B2=D1=81, 4 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 13:46, Jona=
than Cameron <jic23@kernel.org>:

...

> We try to make this name identify the chip in question.
> If the driver name is sufficient for these platforms then fair enough.
> It should certainly be enough to distinguish this from other ADCs on the
> platform.

I believe the driver name should be enough. All listed SoCs have the
same GPADC register
layout and differ only in the number of channels.
