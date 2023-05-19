Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658ED70A12E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjESVEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjESVEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:04:08 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC561A6;
        Fri, 19 May 2023 14:04:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f50e26b8bso331178866b.2;
        Fri, 19 May 2023 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684530245; x=1687122245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkFYXyw6E6pRYTnNx+J/HE05WAp42aJlf5/0x0V1JCs=;
        b=rkRtv4x5WBfjnsuw2tXqLklYYFCadX+a4fTsoPj5ATokjuxnDYf4rwcGcDTp8hO1iG
         jfUNr8Xrfn7KNAf5WXvhdjHDQUF+tsTzHerKfs3pQbaCMyZ+djRZhan6J0JTbfl5sr51
         zMa1wCqHO9jjvkx0BGEVagVyL8xLifC9PEL8M3q2R2uUNPXshj0PgRdkQdtQvS6dulpW
         TftRKlnCNANMIegInpEDA3mb+axeIfmq/7FRfVKZkf18Fl5mZ2MVFfQDZyYeF3BzwSkY
         FkVP9EoYaktsb/0z3jufmXu+IuOu8+FlF51lhIWMC5UJnxgnoClWFwiBLm2PHiVAQjxA
         terQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530245; x=1687122245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkFYXyw6E6pRYTnNx+J/HE05WAp42aJlf5/0x0V1JCs=;
        b=f7qKXJnY5Q9+YwfRfJI5bIBPMFEcYtUWpnxsjEODfYYAZwTPAR/FtAgtK7l1HCW3I8
         PRzFbWPpFyJpUl3nII2dPmojObaFNBBWLCf/C4RzthPETBYg8x6HRvIDN+uZ249fh74n
         7WYmSp+mjiLphPJ1y3EaXEzOuc2YogHO4wtt52Rwwi+bLn25aAdb2a5iHtk/bF2FWfoL
         vzV5QVEB5x4+MviSG9O0NUaFh9bagY5Jng/Jbptm8+rIgNuOcsaMWkcQjf4JofzacBpI
         /Or2d4C5c0VvhBH0OIxOxAQn8PClhLXXXVNrrBGGLyvZupj62DPKJ7ZXLV0tyrE/9sQ8
         gtnw==
X-Gm-Message-State: AC+VfDzVllbAZzoF0gspiau/FS/4jBRA5ivMlMdven/LyNLQFQBBOCvF
        wuzqamN6DKgs1KkXUhM9sMO7Bb93gI7j8DXgm1ZZ4huqEnk=
X-Google-Smtp-Source: ACHHUZ4c1gf0Sah0Blf/COARZBm2a1CGAAUrMBuEcAMrXckhdoCEp5PwqVEXLbfiq/huUY/m0gEr44qJf4A+Df/VnbY=
X-Received: by 2002:a17:907:1c8b:b0:94e:48ac:9a51 with SMTP id
 nb11-20020a1709071c8b00b0094e48ac9a51mr3825374ejc.4.1684530245293; Fri, 19
 May 2023 14:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230517133309.9874-1-ddrokosov@sberdevices.ru> <20230517133309.9874-7-ddrokosov@sberdevices.ru>
In-Reply-To: <20230517133309.9874-7-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 19 May 2023 23:03:54 +0200
Message-ID: <CAFBinCBs7-9CvfQLxLoG5=FjmSK+S5eGsLXOAyQN9kNOg2q-2g@mail.gmail.com>
Subject: Re: [PATCH v15 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, May 17, 2023 at 3:33=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> +static struct clk_regmap sys_b_sel =3D {
> +       .data =3D &(struct clk_regmap_mux_data){
> +               .offset =3D SYS_CLK_CTRL0,
> +               .mask =3D 0x7,
> +               .shift =3D 26,
> +               .table =3D mux_table_sys,
> +       },
> +       .hw.init =3D &(struct clk_init_data){
> +               .name =3D "sys_b_sel",
> +               .ops =3D &clk_regmap_mux_ro_ops,
the sys_*_sel muxes and sys_*_gate are _ro...

> +               .parent_data =3D sys_parents,
> +               .num_parents =3D ARRAY_SIZE(sys_parents),
> +       },
> +};
> +
> +static struct clk_regmap sys_b_div =3D {
> +       .data =3D &(struct clk_regmap_div_data){
> +               .offset =3D SYS_CLK_CTRL0,
> +               .shift =3D 16,
> +               .width =3D 10,
> +       },
> +       .hw.init =3D &(struct clk_init_data){
> +               .name =3D "sys_b_div",
> +               .ops =3D &clk_regmap_divider_ops,
...but the sys_*_div aren't
Is this on purpose? If it is: why can the divider be changed at
runtime but the mux can't?

[...]
> +/*
> + * the index 2 is sys_pll_div16, it will be implemented in the CPU clock=
 driver,
We need to add the "sys_pll_div16" input to the dt-bindings since they
should always describe the hardware (regardless of what the driver
implements currently).
I'm not sure how to manage this while we don't have the CPU clock
driver ready yet but I'm sure Rob or Krzysztof will be able to help us
here.

> + * the index 4 is the clock measurement source, it's not supported yet
I suspect that this comes from the clock measurer IP block and if so
the dt-bindings should probably describe this input. But again, we'd
need to keep it optional for now since our clock measurer driver
doesn't even implement a clock controller.

[...]
> +static struct clk_regmap pwm_a_sel =3D {
> +       .data =3D &(struct clk_regmap_mux_data){
> +               .offset =3D PWM_CLK_AB_CTRL,
> +               .mask =3D 0x1,
> +               .shift =3D 9,
> +       },
> +       .hw.init =3D &(struct clk_init_data){
> +               .name =3D "pwm_a_sel",
> +               .ops =3D &clk_regmap_mux_ops,
> +               .parent_data =3D pwm_abcd_parents,
> +               .num_parents =3D ARRAY_SIZE(pwm_abcd_parents),
> +               /* For more information, please refer to rtc clock */
> +               .flags =3D CLK_SET_RATE_NO_REPARENT,
As mentioned in [0] we'll work with Heiner to see if we can improve
the decision making process of the PWM controller driver so that we
can just have .flags =3D 0 here.
This applies to all other occurrences of the same comment about the rtc clo=
ck.


Best regards,
Martin
