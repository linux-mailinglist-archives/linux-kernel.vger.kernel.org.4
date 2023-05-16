Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09C5705456
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjEPQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjEPQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:49:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F34210CA;
        Tue, 16 May 2023 09:49:08 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-74e4f839ae4so721746785a.0;
        Tue, 16 May 2023 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684255747; x=1686847747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfMeeTNz4KdNFogm5/lMURgbE12PI2cJRgaXZWJ4/vA=;
        b=p8cQbU+0eQM1psYXflTkiqzIA55xA/lE6DXOsy9UuMwT5JHnY+LwuGodW31RRLVt0h
         2ByEYv1/ztVll+0FzaDP3x8hrOBC+caQHaUteYox0+ztQTU8/obQ2jNvgGNQnHxd4Cck
         7lhH/ntrQFayAV25FvBUIzGYrelxqS6WWIaX3UB9bepAIlBMhOfeNe7FuaBSccw43YfO
         6eHQm8ZLW8Yu80KNp6qywZZa+7Co+/wHhzQkOgKnmQmQGl99XPOENDA3ATJaWAjqKxoR
         psFFQLllkYWSCcfU0EpjNolGDKE0Fjgt0KIujC+CFWBJYgRvgTFKnuZuzs4Uyc6ItRpG
         cTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255747; x=1686847747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfMeeTNz4KdNFogm5/lMURgbE12PI2cJRgaXZWJ4/vA=;
        b=cCXWpb7sIYY4ISvXNZWE0gFKKCRVDfnQnmQQLnBDcGDqb2CXgSZajQhcqJ10N9teyw
         MyCqZigB4cEcm/g2VxnQqdKrEvBHdpVR5mqnKbdrwcE4vtU7n9nmT/MTbfL3onBig7V5
         PXvUBGSsgohfn5dcKeVqT5njHDDh6h971npxJpwBHqWNfFHoJD2+MWiaYpaHduIeWPpY
         tfZ+2W9LzkVsFxhjBPk108zAduRxzGzd9rTkcQHZKOiXrS+22aXCtwI8lX+ougzmZPla
         tZGnjzOf0J13r7lwtGXdkekHZjQ9v1elLqPDZzB3lFXitIa3iU3G/EnGE7KluxQZwWpD
         fqqw==
X-Gm-Message-State: AC+VfDzVsd7fsd9wi22Dmmt+TECNxeH0+VKfzqtbEy+bSwHRS1pYeiOr
        baua6LwdY7hmRJiygu05NRroGfwSgzNTWBXIh8g=
X-Google-Smtp-Source: ACHHUZ5PPNcP6rjvJ99DQHB/M4fd5a3CixtWwtj+Sk/dGljxQJadygNgZmpW++QO9CKOCvhTo+0XQI6uXOUcxI5WSXg=
X-Received: by 2002:a05:6214:c46:b0:621:45b2:3370 with SMTP id
 r6-20020a0562140c4600b0062145b23370mr38238682qvj.31.1684255747230; Tue, 16
 May 2023 09:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230512141755.1712358-1-eblanc@baylibre.com> <20230512141755.1712358-3-eblanc@baylibre.com>
 <ZF5yb4DbVDbfxVU4@surfacebook> <CSNQ2RRG7XDC.164H6P357UHSR@burritosblues>
In-Reply-To: <CSNQ2RRG7XDC.164H6P357UHSR@burritosblues>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 May 2023 19:48:31 +0300
Message-ID: <CAHp75VdNgBv5yVTXzDpY3rrF31p=p99cfXdEs0q7m8VmLLJwbg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
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

On Tue, May 16, 2023 at 4:05=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com>=
 wrote:
> On Fri May 12, 2023 at 7:07 PM CEST,  wrote:
> > Fri, May 12, 2023 at 04:17:54PM +0200, Esteban Blanc kirjoitti:

...

> > > +config PINCTRL_TPS6594
> > > +   tristate "Pinctrl and GPIO driver for TI TPS6594 PMIC"
> > > +   depends on MFD_TPS6594
> > > +   default MFD_TPS6594
> > > +   select PINMUX
> > > +   select GPIOLIB
> > > +   select REGMAP
> > > +   select GPIO_REGMAP
> > > +   help
> > > +     This driver supports GPIOs and pinmuxing for the TPS6594
> > > +     PMICs chip family.
> >
> > Module name?
>
> I'm not sure to understand what you are looking for. Something like this
> ?:
>
> To compile this driver as a module, choose M here: the
> module will be called pinctrl-tps6594.

Yes.

...

> > > +   pinctrl->pctl_dev =3D
> > > +           devm_pinctrl_register(&pdev->dev, pctrl_desc, pinctrl);
> >
> > One line?
>
> I use clang-format quite extensively so I would rather keep it like
> that to still be able to just run it over the whole file without having
> to fix this line every time.
> If you feel like I should not respect the 80 columns recommendation, I
> will fix it.

As you wish.

...

> > > -#define TPS6594_REG_GPIOX_CONF(gpio_inst)          (0x31 + (gpio_ins=
t))
> > > +#define TPS6594_REG_GPIO1_CONF                             0x31
> > > +#define TPS6594_REG_GPIOX_CONF(gpio_inst)  (TPS6594_REG_GPIO1_CONF +=
 (gpio_inst))
> >
> > Why? The original code with parameter 0 will issue the same.
>
> I felt that replacing 0x31 with a constant would make the computation
> in TPS6594_REG_GPIOX_CONFIG more understandable. What do you think?

The question is why that register is so special that you need to have
it as a constant explicitly?

--=20
With Best Regards,
Andy Shevchenko
