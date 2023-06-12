Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD9972C719
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjFLOM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbjFLOM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:12:56 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D9810C4;
        Mon, 12 Jun 2023 07:12:55 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-75da00a1eddso433835485a.3;
        Mon, 12 Jun 2023 07:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579174; x=1689171174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwQG10OvI6bp5Np0f72lU7cLcijGe7ymruPqF2GZDRs=;
        b=JpCmZrgGbnD0/gw+qdwVRXyOpwtR59MoNMneUFCy3FczoF66ffM5Psp2Bc7Rb63I0a
         UbCL1I+I5HoEGCFcLC/EJxn0FJDEGvkKDbMEs0yGqBP97pRzIfCfJBrRGEEKPfGGY7zR
         O0KtRFFDqWQnOEiAEZcrPlJwPzH43j1KW6h62gSt0cp3ryIphp7xo8RD/c5/Rzw2IXuS
         aQB00DGEzDaz451ciZpPqK/Ygj0CTxdrKd8vGG43oWeIKPlgRQlnInEGUuh+FEdwvnqd
         jI76t5oXepYl/ZvJgQGWCZ/Pbyo4o3ai9XRqSxEDHCiYarYWQjg7vW3nPicZu6NGW88P
         eSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579174; x=1689171174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwQG10OvI6bp5Np0f72lU7cLcijGe7ymruPqF2GZDRs=;
        b=LnVzBMwOwELHeH1BfUrc+klBm6zpaMno1epzKWsEjzFnGrUUH6/52O/LwD9jGoD1Hs
         eXgEMW2zoHehqftQXhfP80Tqo6IUCBVU1UTQtSm3jJpUxpvq8i9vD5/S29KyGifLKzT7
         Q/CN+mKGMjq42LHknoZykgAhKjhAJM3VwxDTdckrjX7JnbZZ8/DDSEjSyhjrt3MPm+7W
         LGWOGH3F2yjs7BMM6OcR6TJ9U60EqaTOcciHN9ocA/MqV4OTNCaynOtc7HyKBjseRRia
         /w8mQeEGeFdzN0xHiwzp9L/rmT9xsMilAP+D+18fAYuEaEkSb0Bbe27XNvtk4/9iAiCV
         zKyg==
X-Gm-Message-State: AC+VfDzyIcV+lTmkfdsGs10OGZ3FGHFBGbKTl0goyXAxjl/Px+J3pacU
        EKEAeglJ0/s9sqfw2frMCqCvtW0gNbHYWx0IkzC0JYpZQr4OjN8h
X-Google-Smtp-Source: ACHHUZ7IfxVmmdzaBuW9CEDKaY7PegOwFcPmL2PZJELzk6uKmhCxAC6L6jKrxcH4wML32Rr1mb49PunadVLIKjgJfGc=
X-Received: by 2002:ad4:5b8a:0:b0:62d:edf6:6dc3 with SMTP id
 10-20020ad45b8a000000b0062dedf66dc3mr2330187qvp.37.1686579174003; Mon, 12 Jun
 2023 07:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com> <20230612122926.107333-8-herve.codina@bootlin.com>
In-Reply-To: <20230612122926.107333-8-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jun 2023 17:12:18 +0300
Message-ID: <CAHp75Ve8BVO50TqhUV9YWkRBvYARNOAapZ21X=FehaBBfcC2jw@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] iio: inkern: Use max_array() to get the maximum
 value from an array
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Mon, Jun 12, 2023 at 3:30=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Use max_array() to get the maximum value from an array instead of a
> custom local loop.

Looks really good, thank you!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/iio/inkern.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index ce537b4ca6ca..ae1a41d3a559 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -8,6 +8,7 @@
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
> +#include <linux/minmax.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/iio-opaque.h>
> @@ -875,11 +876,7 @@ static int iio_channel_read_max(struct iio_channel *=
chan,
>                         return -EINVAL;
>                 switch (*type) {
>                 case IIO_VAL_INT:
> -                       *val =3D vals[--length];
> -                       while (length) {
> -                               if (vals[--length] > *val)
> -                                       *val =3D vals[length];
> -                       }
> +                       *val =3D max_array(vals, length);
>                         break;
>                 default:
>                         /* FIXME: learn about max for other iio values */
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
