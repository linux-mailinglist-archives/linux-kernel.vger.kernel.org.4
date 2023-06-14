Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE572F87C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbjFNI6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjFNI6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:58:49 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D510E9;
        Wed, 14 Jun 2023 01:58:48 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62df2192d13so15143456d6.1;
        Wed, 14 Jun 2023 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686733128; x=1689325128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lgodkIswJohX+x8mkZUQSVnPLlX7YVIZMkuNAfb1yk=;
        b=Ot/DCOySikas+7rkq9f+ucVQGP5RLs4JvwNAN08bzMSgmzNOZWwtiOlpyll/CPZoP4
         r06VlOMyHPX0o61/vy8vD7gFFh5VYMd4FYbBpPPrBhe8qWHQ74gfmO++A5er7aflsSml
         +4mj+GezQNZwn/LQFSRzqvP3AYPgJgLpFFjFA8wJCyfNsAfzg5jQ23hZDToLuE0HR2ei
         le5oHs4kTxcLbU6i0tYdEjevnhdOOxH60q6QAm79lzsuJuS6vYoibzvp7WHJn5jBlPJy
         68VVNWpAUgtM+njfqX8lZhBaZPGCihw5zHtMKSD0l3RSlJvNSPJOaFoq54L6bvMRxadg
         Yotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686733128; x=1689325128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lgodkIswJohX+x8mkZUQSVnPLlX7YVIZMkuNAfb1yk=;
        b=BbaZsW9HA1nmmrnX4ZS3SvyZE+w+9QLbvb9LFPPwa5Q5gn/dhc4Q7w3w7ayHfqj2iP
         QMYRGYigpd9pDxCjk4SaCzbccHSJGFFZlyfkLY5yUFRFTTB0SLaVfWfTN0ht6AhKb28D
         QPz0zQ8lHuuI5dAkAjxWucZEp1qPEUDfrsBpmDVxKHlaoAAvbwevAVVpzc49XT4kBSDw
         Ys92d2HS2iAkalfPvodihf1qi2k6CggpFkdu1OHFjCbUGNXsd1pFWqAT+xKzlgBTqXhq
         aWaDDKQqpxup8Htv69lYRpPGzEIElxaYu9tdTy3yFdCpyXGqGEDOwdSakkFxz4r629bw
         FTbg==
X-Gm-Message-State: AC+VfDy1VEoCEuKWgl6Obtp6m0WLcMfQh/FBa9S9+8TWoxiKmO91C6BW
        T+e0yfY0IxAXtgHO4rlKaMVNNid/XKz8SE+U8Sg=
X-Google-Smtp-Source: ACHHUZ4ZorPUczsp9ix2/keVyiyoZtFgcXOfaVRuLOYDEDZVZmZGMU/Xk+uzbP2wXmnsIw2NKXwjUng/0RLfK066E+8=
X-Received: by 2002:ad4:5aeb:0:b0:62b:4590:78d6 with SMTP id
 c11-20020ad45aeb000000b0062b459078d6mr17824250qvh.25.1686733127774; Wed, 14
 Jun 2023 01:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230614074904.29085-1-herve.codina@bootlin.com> <20230614074904.29085-7-herve.codina@bootlin.com>
In-Reply-To: <20230614074904.29085-7-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Jun 2023 11:58:10 +0300
Message-ID: <CAHp75VcF09xKQuCjW3HTRauG+geRE0fdd+y8t7LrCYRRYN1WSg@mail.gmail.com>
Subject: Re: [PATCH v4 06/13] iio: inkern: Fix headers inclusion order
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

On Wed, Jun 14, 2023 at 10:49=E2=80=AFAM Herve Codina <herve.codina@bootlin=
.com> wrote:
>
> Sort headers inclusion in alphabetic order.

More precisely fix mutex.h inclusion order as it seems to be the only
one misplaced.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/inkern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index ce537b4ca6ca..71d0424383b6 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -5,9 +5,9 @@
>   */
>  #include <linux/err.h>
>  #include <linux/export.h>
> +#include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> -#include <linux/mutex.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/iio-opaque.h>
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
