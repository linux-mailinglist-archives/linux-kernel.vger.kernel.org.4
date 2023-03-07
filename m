Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291226AD5C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCGDmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCGDmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:42:16 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74A04A1FD;
        Mon,  6 Mar 2023 19:42:13 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cy23so47066962edb.12;
        Mon, 06 Mar 2023 19:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678160532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUgly7YYB0R4fj5VR431uxUP1gbN+PQTNeOG+pJqBBQ=;
        b=EWJEuh3rpJ43SBA5AtoVdrGDZOeqXZUC5ABXGvf+lYX1aeuWQKy+A/vxX00O2h3MFi
         szOYBq4PCBnyPbPvIE4Rpd1xUR1U84B25dp5iDYvEDZO2U3Mh6ikVeo4aP0n1YWYp0dO
         QR1MIGhrH7KZR/dOuJlKHsuzMHyFpPp4lNXHgEsJ37QObOLNmsecFWy5M1Wtut3xy8qm
         5sQa8cMdrg3oDf280aZsxffhy85COb9cMNG9ZrDNgbpfBSYeZO1T7jJbf83YcO+qjV0Q
         hqZpLVG427b8J9vgPbaps1/TFgcs0LgP5KODVrAm4R9+wYLxdc+k3kJ2DNxxYPgPYdHG
         dy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678160532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUgly7YYB0R4fj5VR431uxUP1gbN+PQTNeOG+pJqBBQ=;
        b=NiJVnBdpatAQKj/NUUz/AoPbehjF6ZBeS/KdhUwoDnIyG9Bl6qBSUi1AMBtarfkG/Z
         FhJoBKhcMuTUUWoXsKtKHbW65VDI6o2PGQvluhZyI+1nl+x3EbZfMXJIPceXTIiZgQh8
         G+8LtaGX1qZUSeO03QQCFDVXSabP8FQtGHhUjiNwfo/m+qCFOafA9XXP+x9fErClXADe
         vzt6uT2VGNoo4f8+hB6rxn9nDzQ1I/jEufukGCKJPiokKgF3edUbhmoVRxX5l7oQWDoN
         Iv+EdCmk4T3lAqtaHmUP1qw+6YN8q1xWPO9B6JpWnhIB7qDQkSutAthK5l5UY6eXducp
         DhLw==
X-Gm-Message-State: AO0yUKXLlaHjSF33vfWNAf7vT8RC2NV+OdWMSR1tAnoXAYagEliAG7wq
        9mT8FQ5K1ZOyE6Jb8u8Pbd2tzuCzLTmpu4Nph9YaZC9DkRaooA==
X-Google-Smtp-Source: AK7set/Mm/nt+hqKES4r23aLNO7uHziSS9Peg0Xbn9ZFYMiOBcW8AgPsncil4eCSG1D5hMJuAkllxsNt0ly5qyjVmJ8=
X-Received: by 2002:a17:906:d041:b0:877:747d:4a82 with SMTP id
 bo1-20020a170906d04100b00877747d4a82mr6414471ejb.0.1678160532255; Mon, 06 Mar
 2023 19:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
 <20230302125215.214014-5-keguang.zhang@gmail.com> <CAMRc=McLt2+NJhmzFRuKF5LWMOqyZa-Y-eH7Ecx2ZiMHsTf1ag@mail.gmail.com>
In-Reply-To: <CAMRc=McLt2+NJhmzFRuKF5LWMOqyZa-Y-eH7Ecx2ZiMHsTf1ag@mail.gmail.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Tue, 7 Mar 2023 11:41:55 +0800
Message-ID: <CAJhJPsVJUvWN4PS4-H4iT+3kQJ=5b-4j7ArF=wUHFQka3fhqcQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] gpio: loongson1: Add DT support
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 5:39=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> On Thu, Mar 2, 2023 at 1:53=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
> >
> > This patch adds DT support for Loongson-1 GPIO driver.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V1 -> V2: Let gpiolib parse ngpios property
> >           Remove unnecessary alias id parsing
> >           Remove superfluous initialization done by bgpio_init()
> >           Add MODULE_DEVICE_TABLE()
> >           Other minor fixes
> > ---
> >  drivers/gpio/gpio-loongson1.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson=
1.c
> > index 3ac9e49e7efb..94ac0ccb450f 100644
> > --- a/drivers/gpio/gpio-loongson1.c
> > +++ b/drivers/gpio/gpio-loongson1.c
> > @@ -68,25 +68,38 @@ static int ls1x_gpio_probe(struct platform_device *=
pdev)
> >         ls1x_gc->gc.owner =3D THIS_MODULE;
> >         ls1x_gc->gc.request =3D ls1x_gpio_request;
> >         ls1x_gc->gc.free =3D ls1x_gpio_free;
> > -       ls1x_gc->gc.base =3D pdev->id * 32;
> > +       /*
> > +        * Clear ngpio to let gpiolib get the correct number
> > +        * by reading ngpios property
> > +        */
> > +       ls1x_gc->gc.ngpio =3D 0;
> >
>
> Who could have set it before and why would this information need to be
> unconditionally discarded?
>
'ngpio' has been set to 32 by bgpio_init().
But this is incorrect for LS1B who has different number of GPIOs for each g=
roup.
To get the right number, I have to discard this default value to let
gpiolib parse 'ngpios' property.


> Bart
>
> >         ret =3D devm_gpiochip_add_data(dev, &ls1x_gc->gc, ls1x_gc);
> >         if (ret)
> >                 goto err;
> >
> >         platform_set_drvdata(pdev, ls1x_gc);
> > -       dev_info(dev, "Loongson1 GPIO driver registered\n");
> > +
> > +       dev_info(dev, "GPIO controller registered with %d pins\n",
> > +                ls1x_gc->gc.ngpio);
> >
> >         return 0;
> >  err:
> > -       dev_err(dev, "failed to register GPIO device\n");
> > +       dev_err(dev, "failed to register GPIO controller\n");
> >         return ret;
> >  }
> >
> > +static const struct of_device_id ls1x_gpio_dt_ids[] =3D {
> > +       { .compatible =3D "loongson,ls1x-gpio" },
> > +       { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ls1x_gpio_dt_ids);
> > +
> >  static struct platform_driver ls1x_gpio_driver =3D {
> >         .probe  =3D ls1x_gpio_probe,
> >         .driver =3D {
> >                 .name   =3D "ls1x-gpio",
> > +               .of_match_table =3D ls1x_gpio_dt_ids,
> >         },
> >  };
> >
> > --
> > 2.34.1
> >



--
Best regards,

Kelvin Cheung
