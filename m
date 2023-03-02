Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F726A80B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCBLJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCBLJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:09:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9343D09F;
        Thu,  2 Mar 2023 03:09:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s26so65880959edw.11;
        Thu, 02 Mar 2023 03:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RacVy3hXHfWoxAe1518Rm8TC6/ZADn7tUMEhIQdTBK0=;
        b=A0cz96ZWU3eXaL9NhIe2+pOXpgOGV+sZCxIIEyUSaKTrxOX9jFhW6z6lv50xAdV+FG
         et4oXwQc5jRha8/gxjLd5NF2IyCxM0JWuzCoi3eUFHzcsh1AENLcMY6TDnp+kK7z+m0N
         lAKah1cUalMDvw+43MtPHGzGScieosFKJkFaYFn8+6tbtC3LhlmmZ1pYy2v7fGIJscqd
         u5TT0MwNMDDwb/OsUMH+2nF9N4G+BnKzAZ9sukGODk6CpAY/1kepBCn5ivJj73/v3xrl
         UZwCrAeB05WezS5v+GaP4Hgvi2CdKSZwYE1jZ5Ls0qkEwPMlR6hwG3ffon9k2OUEPQ/m
         0w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RacVy3hXHfWoxAe1518Rm8TC6/ZADn7tUMEhIQdTBK0=;
        b=m0EmNRVSoXmn4yDFkqN0FzWsC35ThT3V7oHnLeP8wPGNnJad70TCZSK3a9GA0ICxoq
         Ftk6MAKCtFMxEi23WcnRlcWT11aeMUvtbrF380dLDugoH/q+6akp5x0pTi9+611CZcAb
         9H/LkWC8ZEUxG7wFN5OZmvtlfCxNuctw310HOAjT5AAZLlhtRBE8HSqcmUT8rWCimCj7
         iE2yFAPAjWroa0QhCEAhIVX+V3eANkT23Fer3iCirIZ4QL/5PumgNEg7kROZXPS7kFtT
         UOBAVmDckZw23XrbOGj9NHxAS4FihHkY5BS0EfLkjOce7HVNKY4lnWqqn2ZPYT3kt7t0
         feFw==
X-Gm-Message-State: AO0yUKUax9Q503tl5+4zQv489M+B0GNsKNCK3ZMDhhlWqCpZORtgmpNG
        xnqvyN2dvNiBKT2K+e8Iq85jxkbGhX4GXfpQ0gY=
X-Google-Smtp-Source: AK7set8CoEjHJ/rHs600IdSLGFBaSy3dFcnTU4ZobDw6qy431GZN2ZxCdzT53sLeJRp42zuqigihfrNwvq050079Sl0=
X-Received: by 2002:a17:906:c08c:b0:8f1:4cc5:f14c with SMTP id
 f12-20020a170906c08c00b008f14cc5f14cmr5084068ejz.0.1677755340793; Thu, 02 Mar
 2023 03:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20230222111213.2241633-1-keguang.zhang@gmail.com>
 <20230222111213.2241633-4-keguang.zhang@gmail.com> <Y/YIlb8axBVVW3VV@surfacebook>
In-Reply-To: <Y/YIlb8axBVVW3VV@surfacebook>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Thu, 2 Mar 2023 19:08:44 +0800
Message-ID: <CAJhJPsVUEe8h8an5ywWTjcLSXj3uHyxW7bg8q4=Byp-3CTgL0w@mail.gmail.com>
Subject: Re: [PATCH 3/4] gpio: loongson1: Add DT support
To:     andy.shevchenko@gmail.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 8:21=E2=80=AFPM <andy.shevchenko@gmail.com> wrote:
>
> Wed, Feb 22, 2023 at 07:12:12PM +0800, Keguang Zhang kirjoitti:
> > This patch adds DT support for Loongson-1 GPIO driver,
> > including the following changes.
> > - Add the of_match_table
> > - Parse the ngpios property
> > - Parse the alias id
>
> Split!
>
> ...
>
> > +     if (of_property_read_u32(dn, "ngpios", &ngpios)) {
> > +             dev_err(dev, "Missing ngpios OF property\n");
> > +             return -ENODEV;
> > +     }
>
> Why?! GPIO library has this already.
>
Will make use of gpiolib and remove this part.

> ...
>
> > +     id =3D of_alias_get_id(dn, "gpio");
> > +     if (id < 0) {
> > +             dev_err(dev, "Couldn't get OF id\n");
> > +             return id;
> > +     }
>
> What is this for?
>
Will remove this part.

> ...
>
> > +     ls1x_gc->gc.base =3D pdev->id * BITS_PER_LONG;
> > -     ls1x_gc->gc.base =3D pdev->id * 32;
>
> No way. This is change makes me thing that initially it's simply wrong. P=
lease,
> just use -1 for the base.
>
Sure. And this is already done by bgpio_init().
So I will simply remove this line.
> ...
>
> > +static const struct of_device_id ls1x_gpio_dt_ids[] =3D {
> > +     { .compatible =3D "loongson,ls1x-gpio", },
>
> Inner comma is not needed.
>
Will do.
> > +     { /* sentinel */ }
> > +};
>
> You missed MODULE_DEVICE_TABLE().
>
Will add MODULE_DEVICE_TABLE().
> --
> With Best Regards,
> Andy Shevchenko
>
>


--=20
Best regards,

Kelvin Cheung
