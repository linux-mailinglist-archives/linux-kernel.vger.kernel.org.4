Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CA2734336
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 20:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjFQSw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 14:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjFQSw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 14:52:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F419BE;
        Sat, 17 Jun 2023 11:52:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-982acf0a4d2so268250166b.3;
        Sat, 17 Jun 2023 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687027945; x=1689619945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzK3QhwOQbNBL0QFe3mmmruOL89rBfwrLckQ4Lu4tw0=;
        b=U6pm4jaJS8m2UDl5VXEpxwxyEDkQHF9QkXqtVNIGqvYUOfLq7S32g4YLmC3Sqb+bpq
         A5aHeO5vtvvjURkrsSjRIErKQNawz2pmzcdyE0ETSHmd+rgVKxSzve3tBc6oaoKI+zXv
         W7S+slQW2VP9zijRGLMbvldmtrWYybAs4W+VatwcU1jy9/+JIyLI26+dHnTRKB4TgZmF
         O5Thtl2g9ai5+N5F1Fr8ztrekEbGqWHJhErXjKufts4RfAqdMKYk59yoUWcn3ztZ6lJX
         8MvELPPOFeC3fnLgW4NCPPg1DStOTN/jCqDb8npw3/tPveBPPE0cXRVc/Wzje4x1HxJw
         HSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687027945; x=1689619945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzK3QhwOQbNBL0QFe3mmmruOL89rBfwrLckQ4Lu4tw0=;
        b=eJEFYe/5kTNiAcBf7qULgb6o+s/cozlP0t8cu/kXGsJzzMLZeSid6VQosLWbpUJtfH
         2R6i//odQ7vs5qaQ5kNFbJF6Twob5x2sGS9NQwX9LE7AS9j2cJC1NgfbpYip2D71zONL
         613Pbf/8Bb+XnpRGqw2oA7EIJgY9ZNpbzs3bK6Li0Z2GaKFWjHzX13nVYMtLFOR+jJ1V
         2GYWazHrUK/pzWFFnu7y4pDJMy6qiPQS+O6LNEtJEw4XsbY0Ie5rMsphKxevyDy6waSU
         Y/TauS7zF5DxGCleBI0Aw6bTE30bvKilw1YbEyNr6azU7ET8c+me2qSMg4pa7ibcRoDK
         rrpA==
X-Gm-Message-State: AC+VfDwDeN3K/agzb9RI0f1mekMkb6wbgfqX4my2bQcthuYKNSfzX6WS
        EyeKMnJ7SmAzFk6xde8tZtvwOORak5FTxP8Q0LA=
X-Google-Smtp-Source: ACHHUZ5QbT7Jg6uOgdeAKNzv3ZBblzxwZ5KIiDFzExm5SfOEog04farQMGB0tuGmdV8OQf2IrM3SebaH7vJEO5LQFdE=
X-Received: by 2002:a17:907:7faa:b0:987:f7ae:4af6 with SMTP id
 qk42-20020a1709077faa00b00987f7ae4af6mr1496201ejc.35.1687027944402; Sat, 17
 Jun 2023 11:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230615205540.1803975-1-bigunclemax@gmail.com>
 <20230615205540.1803975-2-bigunclemax@gmail.com> <20230617144855.0388c4ff@jic23-huawei>
In-Reply-To: <20230617144855.0388c4ff@jic23-huawei>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sat, 17 Jun 2023 21:52:12 +0300
Message-ID: <CALHCpMgxNwz197qgiEueV9Y26LN7BBfYSGBHy6J4gOTFpiVUtw@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] iio: adc: Add Allwinner D1/T113s/R329/T507 SoCs GPADC
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
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

=D1=81=D0=B1, 17 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 16:49, Jon=
athan Cameron <jic23@kernel.org>:
>
> On Thu, 15 Jun 2023 23:55:20 +0300
> Maksim Kiselev <bigunclemax@gmail.com> wrote:
>
> > The General Purpose ADC (GPADC) can convert the external signal into
> > a certain proportion of digital value, to realize the measurement of
> > analog signal, which can be applied to power detection and key detectio=
n.
> >
> > Theoretically, this ADC can support up to 16 channels. All SoCs below
> > contain this GPADC IP. The only difference between them is the number
> > of available channels:
> >
> >  T113 - 1 channel
> >  D1   - 2 channels
> >  R329 - 4 channels
> >  T507 - 4 channels
> >
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > ---
> >  drivers/iio/adc/Kconfig            |  10 ++
> >  drivers/iio/adc/Makefile           |   1 +
> >  drivers/iio/adc/sun20i-gpadc-iio.c | 276 +++++++++++++++++++++++++++++
> >  3 files changed, 287 insertions(+)
> >  create mode 100644 drivers/iio/adc/sun20i-gpadc-iio.c
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index eb2b09ef5d5b..deff7ae704ce 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -1123,6 +1123,16 @@ config SUN4I_GPADC
> >         To compile this driver as a module, choose M here: the module w=
ill be
> >         called sun4i-gpadc-iio.
> >
> > +config SUN20I_GPADC
> > +     tristate "Support for the Allwinner SoCs GPADC"
> I applied this and started a build test before noticing that this Kconfig=
 description
> is very vague and matches the one for the existing 4i driver...

Indeed. I must have forgotten to change this line when copying from sun4i..=
.

> The 'Support for the' bit also isn't appropriate for what you see in make=
 menuconfig
> menu etc.   Please come up with something descriptive. Maybe
> "sun20i and similar SoC GPADC"?
>
> Bonus points if you change the text for the 4i at the same time to be
> more meaningful. I clearly missed that in review a long time ago!

Should I do this in a separate patch?
