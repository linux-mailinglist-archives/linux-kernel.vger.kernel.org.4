Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433E8739C99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjFVJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjFVJVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:21:41 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9916D65B0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:12:11 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-47151ee3fe6so2231778e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687425130; x=1690017130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LAUOQODzdCeUTcrDvoPMBORZt9+ufR2Q6MlQ8V9HqcA=;
        b=mXPKXfCQ5AqfGGN7eLis7zio/LUO4dolZMn9tGoBWo9lQ/0YSYOantIpV+5Aknn1uh
         3J4AAW5FwrtrCjPqExngKvRZGdsEMMnXiWLjxSlxcZ4Z4hrIKAqnf3JGXGjDgW9P3bL1
         pFNgcMjEIcXauA2TF31JXquLUpbL+xqhM2fQ9hmTnukCcFG1Mle2eakMHU8X4YmkO6LO
         bAhMo5m/gWYLFCsmeuIdoTLd4aVKzBQXkX6znVpbHzzsNtQEyUyVQaAV7jfwZ4Hpde4C
         pcPlmHg9x/K3XVnBI0Byou5ihxHLvg+InoKTxxb2YQ/iI8WDHTP84M7mjcSJauXDobPV
         PPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687425130; x=1690017130;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LAUOQODzdCeUTcrDvoPMBORZt9+ufR2Q6MlQ8V9HqcA=;
        b=c8eoih54TktImkGBS6thMv71acJE/UHrkwt0jA6NFBLWjPeFX/ZNVdq0v8t5RMS4tJ
         ShTf2gg8REGiFPlBl/2+hb6l7gfpvKs/QUOEhsryc0T63JCcVWXKzp9K2uZKrZVfsTzt
         FOPX4GHvnrcFPX690He4djOgBaHH/J4y7KW26blO9TfHeg4JxeIMrJPyNrH1HhHVzaFB
         Vy6M4EzOtcqQeAzDp+TrB+7BA1MKj9caUMGaU2VijWD4E2TBEql5PCutAffN6FMlyKVV
         k+p3u8CicX9xu2z8yz89eslo8+5/yH7ZJqn4w8+yTO8bx+cXNwHRZw28cosAexXOd0JY
         8sRA==
X-Gm-Message-State: AC+VfDxYl1oERxu/FRVtAtxIZ5Wy7OS1Q26VFS1XuksCNJI6WNTaeznT
        7VrxXapRPfDehR5eDuvfLtKvvXjY2DK4smVApL0qHw==
X-Google-Smtp-Source: ACHHUZ7Jjoae1j3de5QaDkn+NVntLKV6op75KhbpCaUpXW852Raha07Xg8nXWZ9iLhTkIRdAW16BPNsvDSHUyHVrFYM=
X-Received: by 2002:a1f:4801:0:b0:471:cfa1:5065 with SMTP id
 v1-20020a1f4801000000b00471cfa15065mr4808788vka.3.1687425130628; Thu, 22 Jun
 2023 02:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230621093245.78130-1-o.rempel@pengutronix.de> <20230621093245.78130-2-o.rempel@pengutronix.de>
In-Reply-To: <20230621093245.78130-2-o.rempel@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Jun 2023 11:11:33 +0200
Message-ID: <CAPDyKFqYfuQNCTPiEM56jrzUBe2jevY+MuTOj6K-7OkpO0_daA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: mmc: fsl-imx-esdhc: Add imx6ul support
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel@pengutronix.de, Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Mark Brown <broonie@kernel.org>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marek Vasut <marex@denx.de>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 at 11:32, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Add the 'fsl,imx6ul-usdhc' value to the compatible properties list in
> the fsl-imx-esdhc.yaml file. This is required to match the compatible
> strings present in the 'mmc@2190000' node of 'imx6ul-prti6g.dtb'. This
> commit addresses the following dtbs_check warning:
> imx6ul-prti6g.dtb:0:0: /soc/bus@2100000/mmc@2190000: failed to match any schema with compatible: ['fsl,imx6ul-usdhc', 'fsl,imx6sx-usdhc']
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index fbfd822b92707..82eb7a24c8578 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -42,6 +42,7 @@ properties:
>            - enum:
>                - fsl,imx6sll-usdhc
>                - fsl,imx6ull-usdhc
> +              - fsl,imx6ul-usdhc
>            - const: fsl,imx6sx-usdhc
>        - items:
>            - const: fsl,imx7d-usdhc
> --
> 2.39.2
>
