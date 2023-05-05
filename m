Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEA36F818B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjEELX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjEELX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:23:57 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C0717DFE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:23:55 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a20a56a01so28149847b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 04:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683285835; x=1685877835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMh/43OBmVa5W+sApW1lWJ+8XgRig/QCp8MH47Ky4W4=;
        b=Gid/OSuLLgZJuvHMZ03uxW45BnHAT4yABfayVkZxEnTsaOgEJTcFhZW14vbUifPUpj
         4lvMtKPqbbn8/CSf2AySUrvJfmNSim2bD02RcxGP1MbrJ/TxjaZaA4/75Km0akf4erc5
         18pkEewruftfw+HEYwccY8czqRKyDbYuSAXNgXXX6frNuzVQZX3tQemHOwJ+Pt4Pzf3+
         FQTZD/HkzQN2VNqutAlJ5i3xIoyFEB4EQ5jIq0+ebA8TpL8ywdT0IFptsJTaV8guoM5K
         F7XFO/ItU5W8pgA9eAHmVeqCnbzeLm1XjjBmfgX6jrmtjp1O4uDTWhQPbj+JsIsZf+Ng
         4W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683285835; x=1685877835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMh/43OBmVa5W+sApW1lWJ+8XgRig/QCp8MH47Ky4W4=;
        b=jdof61IESZhHeS+Ltn9ukvt39Uf1N6WArLzNXFGVVop95MAY1gAv42OHgJQ3EuHU7l
         eHW4qjWnDc9lggcADygoZFs7PTkZbOajdDAsu+nVlJnnWAXWDFGjb7+F9XAyykvtgWJT
         BjySNfYSjKxfwY6ym46g0rmuLlqwkm8H8mqluk9P9rPBLTF2RsGfSuGbXxReZmgrEF+Q
         +IshTuvLmT1uR3R3D/8Zn89PMs1aMa/xwoyY2pzQnMmqJNtXPkkaNrVdQUnVcYrq6Z+e
         ETwl6e5M7nMux4wGCpRx9XFKabqoiX00UagAJ94vElhKz2IOgcgPO17lM3PXmmLxi/1+
         Cqqw==
X-Gm-Message-State: AC+VfDwPaCz4HyfBFr6SdkZOU9kqWvIrTN/ttg+ONA7OLlhu1bpQDdSJ
        DcSRT2Fbnd3Oj3EoXJum06AKlaFPf/6ko9vFLxA7kg==
X-Google-Smtp-Source: ACHHUZ7g/jGf+/fhUkp7+9iJZUlRlgX3ZtKgawdt5oBld8cJzk6/UtcrWYbHKVwfD5LPUh47aFlkCiOIuEXQlwfmOgw=
X-Received: by 2002:a0d:dd10:0:b0:559:eb47:fc65 with SMTP id
 g16-20020a0ddd10000000b00559eb47fc65mr1179026ywe.28.1683285835210; Fri, 05
 May 2023 04:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230414101217.1342891-1-eblanc@baylibre.com> <20230414101217.1342891-3-eblanc@baylibre.com>
 <CACRpkdab_26D9BMGeSygy_oa6SFa62ytXcy+Ydi3yPzQO3tU4A@mail.gmail.com> <CSCM20VPW7QB.RQD36XO6634I@burritosblues>
In-Reply-To: <CSCM20VPW7QB.RQD36XO6634I@burritosblues>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 5 May 2023 13:23:44 +0200
Message-ID: <CACRpkdZ8oudy3XfKggZm5srJfOxmRXoFUoiuA3P4i0RTCdc5fQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pinctrl: tps6594: add for TPS6594 PMIC
To:     Esteban Blanc <eblanc@baylibre.com>,
        Michael Walle <michael@walle.cc>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        jpanis@baylibre.com, jneanne@baylibre.com, aseketeli@baylibre.com,
        sterzik@ti.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 1:37=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com> =
wrote:
> On Fri Apr 21, 2023 at 10:34 AM CEST, Linus Walleij wrote:
> > Hi Esteban,
> >
> > thanks for your patch!
> >
> > On Fri, Apr 14, 2023 at 12:12=E2=80=AFPM Esteban Blanc <eblanc@baylibre=
.com> wrote:
> >
> > > TI TPS6594 PMIC has 11 GPIOs which can be used for different
> > > functions.
> > >
> > > This add a pinctrl and pinmux drivers in order to use those functions=
.
> > >
> > > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> > (...)
> > > +config PINCTRL_TPS6594
> > > +       tristate "Pinctrl and GPIO driver for TI TPS6594 PMIC"
> > > +       depends on MFD_TPS6594
> > > +       default MFD_TPS6594
> > > +       select PINMUX
> > > +       select GPIOLIB
> >
> > select GPIO_REGMAP
> > ?
> >
> > I think this driver can use the GPIO_REGMAP helper library.
> >
> > Please look into other drivers using this, such as
> > drivers/gpio/gpio-sl28cpld.c
>
> I had a look at this driver and gpio-regmap.c. I think I understood
> what's going on, but I'm not sure how to handle the
> gpio_regmap_set_direction case. It is using the same reg_mask_xlate to
> determine the register and value to write as gpio_regmap_set or
> gpio_regmap_read. The problem is that this PMIC has 1 register per GPIO
> for the configuration (GPIOX_CONF registers with a bit for direction),
> while the in and out register are used for 8 pins (GPIO_OUT_1,
> GPIO_OUT_2 and GPIO_IN_1, GPIO_IN_2). This means that the register and
> mask returned by reg_mask_xlate will be erroneous in one or the other
> case.
>
> I noticed that I could override reg_mask_xlate, so I should be able to
> "just" match on the base address given as argument to perform a
> different computation depending on whether we are using reg_mask_xlate in
> a "direction change" or not, but somehow this feels a bit wrong.
>
> Is this the correct solution?
> Am I missing something?

This is a question for Michael Walle who wrote gpio-regmap,
Michael, what do you say?

Yours,
Linus Walleij
