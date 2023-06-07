Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBEB72660B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjFGQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFGQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:31:57 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4D1FE9;
        Wed,  7 Jun 2023 09:31:35 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f6a3a76665so5664781cf.1;
        Wed, 07 Jun 2023 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686155494; x=1688747494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMOFB4JJGmoV1XbQl4gTRvTqeANtKDZzMS/LRnvTFpM=;
        b=kk4XI2XKxz3V9gXPi7C8hg1MU/byVPuUGGYJH57/s7uYmhx6xXUSncxPifwOfDClBy
         LQhIlSwV0AvCjiF1KYx0h6L8NnM01HtDoGMoUteKF96yW73g+djNcHrmOsBCEmdaAfNT
         VIvJ6AnBl4qAl2A/iMDP8+fcyvdoxROvyxKKQemP4LIp69x9xUyoG4HM7x0O7KtcafaN
         69Rg9y3SbLm1aBtEbvTE6YC6kF0KspHOChWqskC7WeN0URtDnKBkKTpX9nqV+iBjSZEY
         HVcUUoce1SjKvBao/SYfl6I7+P4DbWPie6B4Id/jNq4Mt0ZNbGkMUzIUW8Dfcug+46fZ
         2y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686155494; x=1688747494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMOFB4JJGmoV1XbQl4gTRvTqeANtKDZzMS/LRnvTFpM=;
        b=RXcXnIzJiIFAkC+KR3/Z6+IKDb/prWUUnLhpp2RexYyJupWu6GCDs6aJ2y9eXyBE6T
         nToGzGF9R2wjomP30HuDwv/Oma0zWWvX9R36VH3wu0vOqYCbnMrPy7W3fu1cV/csy5Ar
         xGA/d2WGq/tP0X636sTltmxRQ+xgdUkDBAIJ00LnbHVybwEmc7V2JJGI53Vo2+3pH9DI
         DJZHAJ2KTGxna75SCoX6SSsJeqa6CYt9RSqqjwUF5i2g7LP+fGIkkZMF5IJ1usTOJ+Ty
         +Oubji5Im9wR2xAxitXg6vpUQwEZMIlalI4UpX2hOLbIeKTLh3HvbqyTUuCzRywfCP73
         sCCw==
X-Gm-Message-State: AC+VfDy6CFHoqwRJf1j2ExY/YSBC+Jg+ALKS5h1qiV5A0PEKIUACLNRO
        bPOBjzCDmhPxaYUsSMJHj/lRAHCbs+9TTF6i8Gc4HSv+sqg=
X-Google-Smtp-Source: ACHHUZ4MvLuw7hRwzpCFhQVzjMbD4+ffaxerOaY5eRCwawJJepPJvp9KF10oDSX0A2kYG0JUnTuplI2JnbTYL0C8zKY=
X-Received: by 2002:a05:6214:518b:b0:626:2dec:e357 with SMTP id
 kl11-20020a056214518b00b006262dece357mr4062561qvb.9.1686155494263; Wed, 07
 Jun 2023 09:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230606014234.29491-1-nick.hawkins@hpe.com> <20230606014234.29491-3-nick.hawkins@hpe.com>
 <ZH76x6E9cbfrJHeu@surfacebook> <DM4PR84MB19278E9DD0BF34C570F714708852A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <CAHp75Vcc9hh6MYPSCJa1vniU=rC4Y+j9pCS4Np-b-Pyh5eUwNg@mail.gmail.com> <81CFCEE8-5276-475A-A2AB-A814DEDA04B2@hpe.com>
In-Reply-To: <81CFCEE8-5276-475A-A2AB-A814DEDA04B2@hpe.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Jun 2023 19:30:58 +0300
Message-ID: <CAHp75VeZkLSTw8OFmDMYb+im0qK0NQRHpndzBM7fMHm=HZCzeA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
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

On Wed, Jun 7, 2023 at 7:07=E2=80=AFPM Hawkins, Nick <nick.hawkins@hpe.com>=
 wrote:

...

> > > > Why are you not using gpio-regmap?
> > >
> > > Is there are good example or previous commit you would recommend
> > > looking at that shows how to convert from regmap to gpio-regmap?
> > > Later in the code I am using regmap_read and regmap_update_bits
> > > with large differences in offset registers, and not so much a
> > > contiguous block.
>
>
> > I don't know how good these are, but that's what we have currently as
> > most prominent use of gpio-regmap
>
>
> > 1) (ongoing) https://lore.kernel.org/linux-gpio/20230606092107.764621-6=
-jiawenwu@trustnetic.com <mailto:20230606092107.764621-6-jiawenwu@trustneti=
c.com>/
> > 2) (in the repo)
> > https://elixir.bootlin.com/linux/v6.4-rc4/source/drivers/gpio/gpio-i825=
5.c <https://elixir.bootlin.com/linux/v6.4-rc4/source/drivers/gpio/gpio-i82=
55.c>
> > 3) (in the repo)
> > https://elixir.bootlin.com/linux/v6.4-rc4/source/drivers/gpio/gpio-104-=
idi-48.c <https://elixir.bootlin.com/linux/v6.4-rc4/source/drivers/gpio/gpi=
o-104-idi-48.c>
>
>
> > 2) & 3) were converted, so you may see by executing respective `git
> > log -p -- drivers/gpio/...`.
>
> Greetings Andy,
>
> Thank you for those links, I have observed the gpio_regmap code
> they have implemented in that case. It appears that the regmap
> code is opening the entire range of memory to be read. For my
> particular purpose I am not wanting to expose all the 0-0xff byte
> range of the GPIOs.

This is also supported by regmap (and regmap has caches for the sparse
registers as well).

> In my case is it still necessary to use the
> gpio_regmap code?

It does care about things the average GPIO controller driver needs to
repeat. So at least you may try and see how it will look.

> If gpio_regmap is required, how do I create a direct correlation
> between a specific gpio-line and a register offset? For example, in
> gpio-gxp-pl.c. Gpio-line at offset 0 (IOPLED) is at register 0x04. The
> gpio-line at offset 8 (FAN_INST) is at register 0x27.

You may remap registers. See, for example, gpio-pca953x, where some of
the registers (with high bit set) are actually virtual rather than
real offsets. Similar idea can be used in your case.

> Additionally, is it required to remove gpio_chip if gpio_regmap is
> used?

I don't think gpio_chip will be needed.

--=20
With Best Regards,
Andy Shevchenko
