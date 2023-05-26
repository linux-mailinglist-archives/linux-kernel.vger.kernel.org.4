Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0CF71268C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbjEZMY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243436AbjEZMYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:24:55 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A17125
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:24:52 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-437e7088b64so417590137.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685103892; x=1687695892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kac9+1tgw97t/ZhT9HBMA1F6hwQ8HyeJeKG9Y95z0Z8=;
        b=Rj2m49t9Gu6u5Dvb9guyp/NpRtEiMTVCA2ZOzuAVxziARXF8Vw8Jr85chjYO45vZbN
         JHdF3s2zIHuAP3InBuqFoZqVXw3LfEYtLC6UfDhE6CM0SWJImVFE8PrWee5xZFpHoXXM
         lxMVnHCM9shP17BIMJP6vCbsdBzJ56r4p03YePD2GaMgpAAPFLuSvaEZXUsz4LIyn4OQ
         j2wTN4EtmoivZMurhUJQ6V5eshnwSkJ5xPCvX99Pjf5plfInPBDIQ4by/TPVSjTCk5Ui
         xGePMvjUiiWrShWgM+8Grb7OP9xCxWhMEOzxML4QOu/2IMpOabk32EYDv2MdLxIUiVwp
         K9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685103892; x=1687695892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kac9+1tgw97t/ZhT9HBMA1F6hwQ8HyeJeKG9Y95z0Z8=;
        b=l1O1yij4gVp+PzzedyNC+EDSLjICDTRKZO5NRPhUMz7hgSZB2P3SUIylERUdda+fWd
         SZJNgmAWjtbFapxQS3vsfuqUjKnHT7jKn40BGQnyY/8W3egPKi2aqAJktQWcVcz/MwB9
         kO+8tu8+w4p6JiyRtSiko9XDpox5r4+DjXN0PeEOT0jpWidemNSf3QktwaQg47cmvjMT
         5pH1wjinrx46khiEG8wFOQBTcCSrzkvMqm6fX/ArbTSHksBecPgUUF1G8qDa4fyFr17y
         PsF+HE+OY8/B/enYom4lyaOfUFH25u2qJUR8J9q8NUlXUU+ISTgRMuSqxprzG8Fxwsgz
         7A6w==
X-Gm-Message-State: AC+VfDz+AFC5ry6J+1e8mBMD2OiofDzhSM5+X3Y/nvV7uMqsT1iO19lX
        8h+ZLgRsJsc46elo7gyCCun/U9LKslOQc92Xrct7KQ==
X-Google-Smtp-Source: ACHHUZ4Vo4ypf1Yrzp9viUHOSDtXH4maYpbjQ0xLEQ39qLDEPhBaR9Ehjieq+52sv0yXRrHFogqdGN2e5yQGMg9FBKQ=
X-Received: by 2002:a67:ea84:0:b0:439:4c9c:1f00 with SMTP id
 f4-20020a67ea84000000b004394c9c1f00mr456422vso.30.1685103891955; Fri, 26 May
 2023 05:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683719613.git.noodles@earth.li> <cover.1684258957.git.noodles@earth.li>
 <7691a35155cf644c2efb02c282c5ef007a6570fa.1684258957.git.noodles@earth.li>
In-Reply-To: <7691a35155cf644c2efb02c282c5ef007a6570fa.1684258957.git.noodles@earth.li>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 26 May 2023 14:24:41 +0200
Message-ID: <CAMRc=MeJHKRYStTSwTCirdQo=f2okN2ys5=V7-ppzCaGYwDkvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: gpio: Add GPIO3 for AXP209 GPIO
 binding schema
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 7:47=E2=80=AFPM Jonathan McDowell <noodles@earth.li=
> wrote:
>
> The AXP209 has a 4th GPIO, so add it in preparation for support in the
> driver.
>
> Signed-off-by: Jonathan McDowell <noodles@earth.li>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.=
yaml b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
> index 31906c253940..1638cfe90f1c 100644
> --- a/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/x-powers,axp209-gpio.yaml
> @@ -44,6 +44,7 @@ patternProperties:
>              - GPIO0
>              - GPIO1
>              - GPIO2
> +            - GPIO3
>
>        function:
>          enum:
> --
> 2.39.2
>

Applied, thanks!

Bart
