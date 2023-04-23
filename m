Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84146EC266
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 23:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjDWVMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 17:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWVMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 17:12:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2791B3;
        Sun, 23 Apr 2023 14:12:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f7a0818aeso522605266b.2;
        Sun, 23 Apr 2023 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682284359; x=1684876359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRKnMw4QG50vnSFwd6Sq3W6Jkn3ZJ2yur8UiF0FgUbM=;
        b=bQs61RS+BXawVW4hK2pXsIzqZif6LIir0t7z6rldZ2pSXl/J7TnR5PH81Xnrjs9rbS
         /l/LyNd7WQrQJrp0egB9ucSZ2q9xJj7TuYqO2XLs1UWnVN6Z1Pl/QRUvcYvYs6tCwKUI
         BtUL+eizagvmjUSMhrnTQXL+mVcYJRSJXaBW5XOlmqrs5Jbsnufir/3QgA5Ym9LjQaMp
         upZwDwTP5dXgWGq5CBi41Rit8LZx5+v1I+eanfKvTGhCdMOcmdRvmYnR4UYz0AMhD+ia
         y43NYxdUmugr+9kM0/w0W9YcrO3IgUYc4gaOjUXbNtgaQJM/nprXEPrC6xjvdBMrmyqC
         0GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682284359; x=1684876359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRKnMw4QG50vnSFwd6Sq3W6Jkn3ZJ2yur8UiF0FgUbM=;
        b=Ybr8NdBybXwP7FgMhRj+BR6ZMI8WBxeF/tMThoHhVQmcCE2cEb3CAS2O+TP+pdJom4
         coYt4336Hq3vDoUbpXJyOIeB/NAc2dVYdrs22JUknCDkSPIlOQzkv3xW+TFhXIqrPNo2
         YrVJmB90f71nz2JtEshnjFXxIxY0JVxqeJE4gmG/KhvSNuhgAQcVDuTlXI9RUV4MZrUe
         T3Zo2Qdp3ewTs4uBcpzg+jp0+1cq83GvMjXM/rLeTzuzEc5dRW/ZGYzAyx5tDsDpI3Vw
         YanBj+/HFeEM9PJp1vOUdMNbhIwLehqPjMzAotEBDmKa/yRBCKkbrmmOL3u003p7JEm3
         eWHg==
X-Gm-Message-State: AAQBX9c/jC2a/RFG6mXY9GTOIrEjlG1SIZea057nWoIPkmgP4QvM2qXd
        VVTebCf/h9SYMCvCydknvLr9vr3l34oLk5h3yz8=
X-Google-Smtp-Source: AKy350a5xYCoNTfH85jnfhrovh3KaFGyGvbTHqG+qrISXQKZrEMxqacX9V1s3QID4AJY4Rh6Ep1iATOzSQZQjOo9zEU=
X-Received: by 2002:a17:906:abd9:b0:94a:5d5c:fe6f with SMTP id
 kq25-20020a170906abd900b0094a5d5cfe6fmr8162781ejb.47.1682284358711; Sun, 23
 Apr 2023 14:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru> <20230405195927.13487-5-ddrokosov@sberdevices.ru>
In-Reply-To: <20230405195927.13487-5-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 23:12:27 +0200
Message-ID: <CAFBinCA3uZXzr3RgnWnKV5Qr-CPaZQX5joDg319i_cgzhLJy2g@mail.gmail.com>
Subject: Re: [PATCH v13 4/6] clk: meson: a1: add Amlogic A1 PLL clock
 controller driver
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

Hello Dmitry,

currently Jerome is busy so I am trying to continue where he left off.
I have followed the previous iterations a bit but may have missed some
details. So apologies if I'm repeating some questions that Jerome
previously asked.

On Wed, Apr 5, 2023 at 9:59=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevice=
s.ru> wrote:
[...]
> +config COMMON_CLK_A1_PLL
> +       tristate "Meson A1 SoC PLL controller support"
Should this be "Amlogic A1 SoC PLL controller support"?
My understanding is that the "meson" name was dropped for this
generation of SoCs.

[...]
> +static const struct of_device_id a1_pll_clkc_match_table[] =3D {
> +       { .compatible =3D "amlogic,a1-pll-clkc", },
> +       {},
nit-pick: please drop the comma after {}
This empty entry is a sentinel, no other entries are supposed to come
after this - so a trailing comma is not necessary.

[...]
> +/* PLL register offset */
> +#define ANACTRL_FIXPLL_CTRL0   0x0
> +#define ANACTRL_FIXPLL_CTRL1   0x4
> +#define ANACTRL_FIXPLL_STS     0x14
> +#define ANACTRL_HIFIPLL_CTRL0  0xc0
> +#define ANACTRL_HIFIPLL_CTRL1  0xc4
> +#define ANACTRL_HIFIPLL_CTRL2  0xc8
> +#define ANACTRL_HIFIPLL_CTRL3  0xcc
> +#define ANACTRL_HIFIPLL_CTRL4  0xd0
> +#define ANACTRL_HIFIPLL_STS    0xd4
Here I have a question that will potentially affect patch 3/6
("dt-bindings: clock: meson: add A1 PLL clock controller bindings").
In the cover-letter you mentioned that quite a few clocks have been omitted=
.
Any dt-bindings that we create need to be stable going forward. That
means: the dt-bindings will always need to describe what the hardware
is capable of, not what the driver implements.
So my question is: do we have all needed inputs described in the
dt-bindings (even though we're omitting quite a few registers here
that will only be added/used in the future)?
Older SoCs require (temporarily) using the XTAL clock for CPU clock
tree changes. To make a long story short: I'm wondering if - at least
- the XTAL clock input is missing.

PS: I don't have an A1 datasheet nor a vendor kernel source (and even
less a board for testing). So I can't verify any of this myself and
I'm asking questions instead.


Best regards,
Martin
