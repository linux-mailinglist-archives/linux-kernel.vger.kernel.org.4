Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642A36AD4A4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCGCZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCGCZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:25:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649F72B610;
        Mon,  6 Mar 2023 18:25:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cy23so46639078edb.12;
        Mon, 06 Mar 2023 18:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678155955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0OImnvXE30615yFSuU+y0WJr5V6M6GufdN6hNO0u+w=;
        b=GA/poEVIJpqg9rZCv1nR1OdPgVEmWhihBKyk4ktwDG7wRth7vr3pbbqtGKZ4B8OM2k
         mss/Lg5SQT2cAkM3X6gTF23ihfLs5QBHlbct2bS6OGLomyN3WgNILv1VjOk5F6e18I+4
         NktHDWxmjgLoHhl1QoPu+6Ih2l5X812sEfEQI1FsgN4Jt3qpIQ0KE2Si+eGo7UkTsnf0
         BgCGQWBqTJlJu4thgwezefgxtxPc1ZVCJBMD5/MOQOqDBpPbQIsgFqxKy8PnjVJ1q3gN
         83HMbgMgbE/p1yE+I583c2TAeeQoBDzfqPsc6WdnlF1/p5d9TRVw9nrerhSl4jYXfXZW
         jsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678155955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0OImnvXE30615yFSuU+y0WJr5V6M6GufdN6hNO0u+w=;
        b=Q4asiuWC53fvxSMqUyD8uxKEQqxOt9TSApy/m0LCTtmjvph78A5AG8hByTJhWxBqDF
         uObe/KQSYLqQ7q/A01qhn+TuMtr5D7eu3mNeD6Vodu8/BebFaSu87hv4QsY0Ta/ICGdO
         vImmyLWn5pOEVB/ngDVJxoYNrhYu/BpSj/7MxX+O5Tkv9fd/GCoEgMayfYn9E/ssID/t
         ms5S639AauGi3bkznzEDzz3vdQVDUaxE3wk3ncjhVWRMWKO52U2bR4jaRUNRyRtwBjQk
         p9NdcsT6zo4PfkwzzWn+JsfoW7aM314kRKJefaC3YHxFqAp+N4KyPO9jWE8xeyh45MKs
         Wk0A==
X-Gm-Message-State: AO0yUKVAi+hcGS6anyyWLA3ZkSFRlTe6s8KJmIVnTpTMohBvqv0ZuS9r
        YCXAbb8tlZJoX6HPrW8yirjkoJoPo09abtXDpNQuUnJwzA8g1Q==
X-Google-Smtp-Source: AK7set+PYNQzrC6X2koOkFfG0i+Qn9+Vzwd9lMtQbr7M5T3BqoE41n8B1xNT7+UMARRkuXT3BRnH1+t8blqPKPACn3g=
X-Received: by 2002:a17:906:6d55:b0:8d0:2c55:1aa with SMTP id
 a21-20020a1709066d5500b008d02c5501aamr5726180ejt.0.1678155954763; Mon, 06 Mar
 2023 18:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
 <20230302125215.214014-2-keguang.zhang@gmail.com> <CAMRc=Me=Yrr5BuRaMd4r91URzmdYHWUvVGvLL9YFuZPaV0WYFA@mail.gmail.com>
In-Reply-To: <CAMRc=Me=Yrr5BuRaMd4r91URzmdYHWUvVGvLL9YFuZPaV0WYFA@mail.gmail.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Tue, 7 Mar 2023 10:25:38 +0800
Message-ID: <CAJhJPsVf8EvFc9N8eMtc8Qu2BhODv7PzZm9C5ePR+GdTFiAY1w@mail.gmail.com>
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

On Mon, Mar 6, 2023 at 5:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> On Thu, Mar 2, 2023 at 1:52=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
> >
> > Use SPDX-License-Identifier instead of the license text and
> > update the author information.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V1 -> V2: Keep GPLv2, just convert to SPDX identifier
> > ---
> >  drivers/gpio/gpio-loongson1.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson=
1.c
> > index 5d90b3bc5a25..8862c9ea0d41 100644
> > --- a/drivers/gpio/gpio-loongson1.c
> > +++ b/drivers/gpio/gpio-loongson1.c
> > @@ -1,11 +1,8 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> >  /*
> >   * GPIO Driver for Loongson 1 SoC
> >   *
> > - * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
> > - *
> > - * This file is licensed under the terms of the GNU General Public
> > - * License version 2. This program is licensed "as is" without any
> > - * warranty of any kind, whether express or implied.
> > + * Copyright (C) 2015-2023 Keguang Zhang <keguang.zhang@gmail.com>
> >   */
> >
> >  #include <linux/module.h>
> > @@ -90,6 +87,6 @@ static struct platform_driver ls1x_gpio_driver =3D {
> >
> >  module_platform_driver(ls1x_gpio_driver);
> >
> > -MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
>
> Why are you removing credits of the old author?
Kelvin Cheung and Keguang Zhang are the same person.
This change is to keep pace with the related entry of MAINTAINERS.

>
> Bart
>
> > +MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
> >  MODULE_DESCRIPTION("Loongson1 GPIO driver");
> >  MODULE_LICENSE("GPL");
> > --
> > 2.34.1
> >



--=20
Best regards,

Kelvin Cheung
