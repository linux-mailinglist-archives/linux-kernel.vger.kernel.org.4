Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C086FEE57
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbjEKJHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjEKJHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:07:11 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A12FB8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:07:10 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-77d46c7dd10so40232131241.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1683796029; x=1686388029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEfw4Qx9TBb+Xym8/yWxMfm9EvZtkYky+JAp0mlxaNU=;
        b=T3iWV+G1QgkhmVX6yE31LlE8VgASkxdkxYzfk5TzOCAzSCl/DxvKZoxtKBrOcCIO/s
         8QHX/ENgHLdKDLIwkgHnrkK9D4QB9mrWNNGAzPWsSGQGtjFb2qtFuZKexfgVdDRvQ0+i
         PllDmoPt898Z9RkCFKYx/xmsDkcoYgG5+ia1tGinhTSfmGKFeoDiLP9GVcZDHNbPJCXb
         h5WM2ZfqQsw5jnL4loe43AdoqOc76fv0Le7xa9pjnYIt0U+c2cTNo1VppV0sShLH3XjP
         GX9/pfRwBVgY7XoXDZjEmStjmw2fOu8FwPHU/zpjL3TKfyRssQ9GyTCP4d2I/rY4oPvx
         EN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683796029; x=1686388029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEfw4Qx9TBb+Xym8/yWxMfm9EvZtkYky+JAp0mlxaNU=;
        b=YY7Yil4peT5wZBqxW1N9DQ037ycQyMudjOPiPo3d3kOVeBkUg9XrKn7cHImE2Za++8
         zlYbJVic5yJbs9xn/NvfQgTWpI3xvJtxBoM/ZZ12rH6AWei04VdIoQcOZlhn5PGoXKcP
         rIeT2UeYeUUtrOuRjTw4YTnTa9UqLKYProNsIuNw+GwY3k9kOuesZlkUCYCFCyGmjAi7
         QvWAx80p0j+CLO2+wqJ2gRaRNgns/uXiSx6FJ/ACnDhgeSCZm3XZIC+gwSsvzwrWrTXK
         j+oMEKjxKJqoXPXm19tijoxBMuXUBCNO9OP32nRtwhCM0YHnTCwGnOTX0mAUsuIzXYHP
         d+9Q==
X-Gm-Message-State: AC+VfDwOQC6sGuOsNJHO84UxMzHGoQVO2CPAlFeIf1usm5IFrRvgBBb1
        cxkltjrtAAzOAAPrvQXVi7CWMg2/b7aAudqGGmQ7UQ==
X-Google-Smtp-Source: ACHHUZ5Da05sUu9dadgewXsUAOLk5vrNul1VLbsZG/m7cKfojYydbGBtnXuFi9srGr9ZsLJtnohTxipHHwuwfX0Q9Q0=
X-Received: by 2002:a67:b345:0:b0:42c:6b1b:ed1a with SMTP id
 b5-20020a67b345000000b0042c6b1bed1amr6762299vsm.15.1683796029786; Thu, 11 May
 2023 02:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230507144807.193009-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230507144807.193009-1-krzysztof.kozlowski@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 11 May 2023 11:06:58 +0200
Message-ID: <CAMRc=Me8HQwNNau08h_Bg77W=Dt7gRVMMwtZwg_tHYVUTb=i0A@mail.gmail.com>
Subject: Re: [PATCH] gpio: davinci: correct non-kerneldoc comment
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 7, 2023 at 4:48=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Drop kerneldoc annotation from regular comment to fix:
>
>   gpio-davinci.c:716: warning: This comment starts with '/**', but isn't =
a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpio/gpio-davinci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index aaaf61dc2632..3063e57a4174 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -712,7 +712,7 @@ static struct platform_driver davinci_gpio_driver =3D=
 {
>         },
>  };
>
> -/**
> +/*
>   * GPIO driver registration needs to be done before machine_init functio=
ns
>   * access GPIO. Hence davinci_gpio_drv_reg() is a postcore_initcall.
>   */
> --
> 2.34.1
>

Applied, thanks!

Bart
