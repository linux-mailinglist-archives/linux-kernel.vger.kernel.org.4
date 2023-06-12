Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D172C6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjFLOGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjFLOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:06:04 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAD41AC;
        Mon, 12 Jun 2023 07:06:03 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9baa69682so35928441cf.3;
        Mon, 12 Jun 2023 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686578763; x=1689170763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzGHAlJH/0YXEKipZ+Ms41o/6AaOdNH3x2SChySThcc=;
        b=DQABeuTLfLAmeKt8tVvq/jaKPBv/urqBjnHEkh0ByKqGpXluH6Z+1GGormG4y5x5MI
         KX28oZl7VIRbr4QsdcCoXwZK3jITjhKI20HgS1aYLLxTW94IMrnaN7K86FP/ZMcV5tT1
         6yv77z1MQ5qlj65i7yMqt7u4CWMmhf4ZPXpJbjo4bmUq+2APmCbgzX2659P6JNVD0inK
         Tm83araMfqQkMvX9nmBOgOGLzJwR8GFXwFHgXXsD4/nxFc8mPKXhPhpUmyHzKhsl8Yhq
         guJQhgKvFTo6CGRpwRm0P+VJXxRusBFE2MfjQlF9DvAn3MGBA/YWfU/oi1iGsnFpvs38
         87cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686578763; x=1689170763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzGHAlJH/0YXEKipZ+Ms41o/6AaOdNH3x2SChySThcc=;
        b=Ybkdbs/SCb/Sr0BikqTD5/Awcnb4C4PbNNOf+7MUdjtFDnDoU8224QD89g4yanU9rs
         GI3zKQ1LtW9L0aHaBlq/SvzNt6HEs25diawQc351xDL/u6rWSFt+pvMGTeGlrYEw+Jld
         EQ5BgS87ex2QXZw2MTFFtwnZeuj0+u9l21UH/nVmbeJcp0aMsZ+IuozTFsGDGDmyviTj
         ToGJSYjXmhH4JdQOpMSGmyjz+FkXpl2NCdQinQeUQjpCPt5pe2ffCC4gIOWRzHhTwM54
         YaCAt9lXzbLGswp+Luc2vgq+I9FA3kz6UhFKuiebUw566TorrvpBL3lVMMTYDh7z9wek
         eubg==
X-Gm-Message-State: AC+VfDwyMJWgn5bhYah5IM6rfN+UKp5UoS22dr5egAXk6bb/UWzaQg80
        dBFlspe8BcJ9KiiizQVdncC3SPt7dH241euQzF8=
X-Google-Smtp-Source: ACHHUZ5uI20fWf+pWNjdO28+l44cjNEfQFnUdIimfKXlh/dtHGKpDu8ztgzTIX1zOzglSjftG5zT/WzO0W8ilN/xRm0=
X-Received: by 2002:a05:6214:5298:b0:61b:5e9b:a15d with SMTP id
 kj24-20020a056214529800b0061b5e9ba15dmr10948726qvb.36.1686578762963; Mon, 12
 Jun 2023 07:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com> <20230612122926.107333-6-herve.codina@bootlin.com>
In-Reply-To: <20230612122926.107333-6-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jun 2023 17:05:27 +0300
Message-ID: <CAHp75Vc+Y7yOu1faosisPeL5N5x13DSTi142HuAwFgGmBiKsrA@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] iio: inkern: Remove the 'unused' variable usage
 in iio_channel_read_max()
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
> The code uses a local variable to initialize a null pointer in order to
> avoid accessing this null pointer later on.
>
> Simply removed the 'unused' variable and check for the null pointer just
> before accessing it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/iio/inkern.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index f738db9a0c04..ce537b4ca6ca 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -849,14 +849,10 @@ static int iio_channel_read_max(struct iio_channel =
*chan,
>                                 int *val, int *val2, int *type,
>                                 enum iio_chan_info_enum info)
>  {
> -       int unused;
>         const int *vals;
>         int length;
>         int ret;
>
> -       if (!val2)
> -               val2 =3D &unused;
> -
>         ret =3D iio_channel_read_avail(chan, &vals, type, &length, info);
>         if (ret < 0)
>                 return ret;
> @@ -869,7 +865,8 @@ static int iio_channel_read_max(struct iio_channel *c=
han,
>                         break;
>                 default:
>                         *val =3D vals[4];
> -                       *val2 =3D vals[5];
> +                       if (val2)
> +                               *val2 =3D vals[5];
>                 }
>                 return 0;
>
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
