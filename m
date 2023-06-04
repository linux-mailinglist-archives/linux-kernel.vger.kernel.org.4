Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74A7219AE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 22:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjFDUVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 16:21:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6300CA;
        Sun,  4 Jun 2023 13:20:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5148e4a2f17so6330423a12.1;
        Sun, 04 Jun 2023 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685910056; x=1688502056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pc901lSB1t/5njyHaOGc8Szlz99xchoB9LNubqrB9pc=;
        b=DoNX4mNR4KsN0iXSQQhd4DQCDKAy/YiYQuMQD6ru8VRddZ5HU9qYoL1jaIugifNuZq
         7hZI3Fc7GCBMSXoxGBPUIekHPqx6cxXD+ifUYBWCSSi1VxGnmjlKDVzY3Yvqt0gsz7by
         B2jj1+gU6W63y37bzdsUk55TL10jVRoYRWDmsiD4IE/iyREUrHeUWdo8ZdmSmYW9byyP
         o2kUCLPpNeIMZDxH6g03V2Zx2o13q5xifpMdawywWXXZV1tF8ye3f/8BbGvMrNCYwByX
         WBLHgmVUNzFsAOQHrT9LEk6onwWScg0UncK9BSgbit/tQBh0JmLCWszHpOpeYgs7u2fl
         BSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685910056; x=1688502056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pc901lSB1t/5njyHaOGc8Szlz99xchoB9LNubqrB9pc=;
        b=DprAyRMGGl92/HehGDVoK686WLj28+7ZhXYy4/5ruDQFUfYfjffb5EDAqeB4C8ShfI
         YRwp/6D1SprIzbiAhHkM4DA2FxcDWVDuZaBKkLiMRMaT45imA8dU6aP4S+7qjbfCB00U
         OR6MVdF0YMUQ+IzduLvP8QDfGFmAcyglRvXUkhxc5lCvefnajZwUJ/J34vc9NwmqUuar
         AsmhNH8q/XPchpw4A61ruzg7bMf0dks3TBImgx9gmhodc4UB781t+VjHEerqPMg1R71V
         0L7D/bSqiFyNfofCYLPSPtMT+krMzI2TS6AAGTZTyHckEU7Dmrzf8OjuxENDNCryFjjn
         ucqw==
X-Gm-Message-State: AC+VfDwskFtNqjk0jsDdXZ/QKcFHBfcAEJoUqKfSFlebaYAGduOMSbjG
        vajI6Kzc04UcgX/qAd7bUpzWr5WEEn4FPymeb40=
X-Google-Smtp-Source: ACHHUZ7HJh+h9S1Y+0QLnh+mPkHQqhlWKeX5TeLGIsBww9yr2NxJpXCvJ2n+CmB71U+vMZhwSkpXWhlo0NM6x+JnCj0=
X-Received: by 2002:a17:906:730b:b0:970:132f:698f with SMTP id
 di11-20020a170906730b00b00970132f698fmr5945181ejc.2.1685910055898; Sun, 04
 Jun 2023 13:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230601223104.1243871-1-bigunclemax@gmail.com>
 <20230601223104.1243871-3-bigunclemax@gmail.com> <fbcc5688-387c-32fb-edac-17848c92b936@linaro.org>
In-Reply-To: <fbcc5688-387c-32fb-edac-17848c92b936@linaro.org>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sun, 4 Jun 2023 23:20:43 +0300
Message-ID: <CALHCpMizv52yj0rw0pR8pYjSys2UivS4L4GkWLgc-d91bdmDCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329/T507 SoCs GPADC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        William Breathitt Gray <william.gray@linaro.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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

=D0=BF=D1=82, 2 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 11:38, Krzy=
sztof Kozlowski
<krzysztof.kozlowski@linaro.org>:
Hi Krzysztof,
>
> On 02/06/2023 00:30, Maksim Kiselev wrote:
> > From: Maxim Kiselev <bigunclemax@gmail.com>
> >
> > Allwinner's D1/T113s/R329/T507 SoCs have a new general purpose ADC.
> > This ADC is the same for all of this SoCs. The only difference is
> > the number of available channels.
>
> Except that it wasn't tested...

Yes, you are right. I tested it only on the T113s board. And I will be glad=
 if
someone tests it on another SoC.

...

> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.

I got a warning about required maintainer property. Should I do
anything with this?
If yes, then who should be a maintainer?

...

> Hm? So you do not allow anything from adc.yaml related? Are you sure
> this is your intention?

I'm not sure about it. I looked at other ADC bindings and didn't find
another driver with 'additionalProperties: true'
