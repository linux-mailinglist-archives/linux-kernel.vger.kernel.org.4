Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9500D6AFD16
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 03:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCHCyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 21:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCHCyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 21:54:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0665C24491;
        Tue,  7 Mar 2023 18:54:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x3so60265413edb.10;
        Tue, 07 Mar 2023 18:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678244047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiXxl4yublkr4NofbHFzE7KSc7LE/+7BUAxLqu/b6HI=;
        b=SPCuiHS3/Cul4e+pzd0NFK5eBb2FYG0wBr+VS7XcHRFkTO/vVwlrrjV2oMJYSvb9l7
         zr4TIdp8Ne3A11VLT0cvgADcNaCOw5zvwG2xIEt7glmtRTFUnSOP9sNJ/pNw2yD9KxYZ
         64IVBObFGcwtiaBHcQjkF4HY4Z9CJq0NQC9kqD+iicJc8EOKCLElUWY1pBKw0R5TLAQe
         oUl18Ce0Vxg1ZRYuqBAeDpNYyboIh5xXexqAjAhAEQaCwgUQdau32bW9Z3sI1LhsAYQy
         GH43rBnwKeYLFlEdZwPCSIeyo7UpN1uNfFR7sruaKCWqBdbwPJSHc7QNkRr3Q+45uT91
         1cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678244047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiXxl4yublkr4NofbHFzE7KSc7LE/+7BUAxLqu/b6HI=;
        b=2Ij1dN7828XAEjmhrUKkbSOb408MYP+kUxNirWxgmlh8p5CvoOlfvBv/pgOrltFvVi
         mrBr2cSwGLkCvR7R5Zkn/iyWVGCoaZexpe/XX/GaJ9IwGPUd/+mN0AoR29SPcCh8sv9U
         P3xS9vJ6m5oOCGB3HkmdnhtIa+1b6E/Snwr5zrf0HCdv1WuLIqc0pMcbUJZm89kUy+op
         K1ziXUpUp3VQqqxTaTkMXp1FeRn+xb1C13ueZHDpOjmjaiu2hHzfZX9kj1uwv8ewzCNR
         /cRkbBlXGG3j5+sYI3zUCcSeO95MhV02aou0MVN1ntaM6ya9Hu+Vw8MLFZ5TQBSucauL
         gJfw==
X-Gm-Message-State: AO0yUKU56TKtPMaabYZl3xmDR+Mf2389RPOmHY9Gpe1rxh7gJGmAGAiv
        rpHBop59namxl1kILuS80LXtiM5UMZHNcxyD63U=
X-Google-Smtp-Source: AK7set+EaCmlBw9yTmg007/wl/oizsGLSx3NxukJsTKz417BW8rt7+ijWCCigRN2ZGOwhcIjTS9lK7t5j3DiuUok61Y=
X-Received: by 2002:a17:906:498e:b0:901:e556:6e23 with SMTP id
 p14-20020a170906498e00b00901e5566e23mr8318026eju.0.1678244047392; Tue, 07 Mar
 2023 18:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
 <20230302125215.214014-2-keguang.zhang@gmail.com> <CAMRc=Me=Yrr5BuRaMd4r91URzmdYHWUvVGvLL9YFuZPaV0WYFA@mail.gmail.com>
 <CAJhJPsVf8EvFc9N8eMtc8Qu2BhODv7PzZm9C5ePR+GdTFiAY1w@mail.gmail.com> <CAMRc=Me3Lnf0W=Y0oMkUGJ59rVCRb+qGq2Eb3vqRZm5gQUwOxQ@mail.gmail.com>
In-Reply-To: <CAMRc=Me3Lnf0W=Y0oMkUGJ59rVCRb+qGq2Eb3vqRZm5gQUwOxQ@mail.gmail.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 8 Mar 2023 10:53:50 +0800
Message-ID: <CAJhJPsX1PRN_KKVMXNaEbPKfAc+PKbyir07pmkvLFVVUBcK=Mg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: loongson1: Convert to SPDX identifier
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 12:49=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Tue, Mar 7, 2023 at 3:25=E2=80=AFAM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
> >
> > On Mon, Mar 6, 2023 at 5:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > >
> > > On Thu, Mar 2, 2023 at 1:52=E2=80=AFPM Keguang Zhang <keguang.zhang@g=
mail.com> wrote:
> > > >
> > > > Use SPDX-License-Identifier instead of the license text and
> > > > update the author information.
> > > >
> > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > > ---
> > > > V1 -> V2: Keep GPLv2, just convert to SPDX identifier
> > > > ---
> > > >  drivers/gpio/gpio-loongson1.c | 9 +++------
> > > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loon=
gson1.c
> > > > index 5d90b3bc5a25..8862c9ea0d41 100644
> > > > --- a/drivers/gpio/gpio-loongson1.c
> > > > +++ b/drivers/gpio/gpio-loongson1.c
> > > > @@ -1,11 +1,8 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > >  /*
> > > >   * GPIO Driver for Loongson 1 SoC
> > > >   *
> > > > - * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com=
>
> > > > - *
> > > > - * This file is licensed under the terms of the GNU General Public
> > > > - * License version 2. This program is licensed "as is" without any
> > > > - * warranty of any kind, whether express or implied.
> > > > + * Copyright (C) 2015-2023 Keguang Zhang <keguang.zhang@gmail.com>
> > > >   */
> > > >
> > > >  #include <linux/module.h>
> > > > @@ -90,6 +87,6 @@ static struct platform_driver ls1x_gpio_driver =
=3D {
> > > >
> > > >  module_platform_driver(ls1x_gpio_driver);
> > > >
> > > > -MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
> > >
> > > Why are you removing credits of the old author?
> > Kelvin Cheung and Keguang Zhang are the same person.
> > This change is to keep pace with the related entry of MAINTAINERS.
> >
>
> Even so - how could I have possibly known this? Please put it into the
> commit message, it's crucial information for this change.
>
Sure. I will amend the commit message.
In addition, should I update this patch only? Or the whole patch series?

> Bart



--=20
Best regards,

Kelvin Cheung
