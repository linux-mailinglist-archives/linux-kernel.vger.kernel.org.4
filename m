Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BCE74B32D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjGGOmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjGGOmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:42:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8D71FD8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:42:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso24936725e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688740953; x=1691332953;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z4lWoBqUTsmtDgqpIXQd4kMN9P4iNoBN46guAJ4J0UY=;
        b=PY8Trs51ttpj0rQ77raRmZRLf1dKh8mRaBthfH/Z69kQfenZfIgqssui+V1ic649Mu
         y83Av13S3K2KL2ROegnSN6y/mrKgyyrxz8l9iu5L4EsrDokiMpcsTbwtVwV15nZu9OCY
         3Sa0LitqLGs5/ED0l7IjmKZuu89vfFGj+OT8FwOoSoZUUuBMy7tuuZ6w1EsUyFjAnews
         GLcS5IWrlr5KyMocqgNAwAR8R8os91F1mbaF2dldsrhAxHlRgLZJWYNKAg81F5U6IjMQ
         ArhQACobVp3SBs5CsONrv4Rqmb/GDRbU3vi4J8HXCUj79yyZlp3AflM1oqLHpljJ8x1q
         AZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688740953; x=1691332953;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4lWoBqUTsmtDgqpIXQd4kMN9P4iNoBN46guAJ4J0UY=;
        b=W0Y4yel7vstYNgUopP3CM7FSssx201aEAZl/zgtNRCWkG62Be/9/7pG4EvRPl3XoL6
         QoGDTel3FUjTJsTltyoAI/plJS8/2MoiL8HDGwWYUp3HhrTGbmVZK9VUZ22RGr9RhP6j
         kNrSHfza3a+bXdz9skvU+DrOBp3Wslwb4jsrVM2ziJjColV/CXMS1JSOw0JSELThW88w
         FGTfX1UbVtAgoCR1vMmvBDrLOJs8o+c562iQyjlCIpwOHgNXQgKLUayN/uX/YohRhj1M
         olD23YW14TyjR34hvwZA4aCJL1/opH+ZoanAqCpQFCdPIvQHuGOLXTPBY0Hb1adaZpak
         0N0A==
X-Gm-Message-State: ABy/qLZfO8qlMGPqsv0hom5VFcj2lFOHffBl7H1ZKsIWi/bwgV9oZ/SZ
        6hR7ueuhsFyGk4NyZGOETQqonw==
X-Google-Smtp-Source: APBJJlHBP9G/LqJXiH8qNwypAEFyU81HIVpOXYc4p9njD0acJ2CEliu5SxfbBxyOn5IJb2gB5tdV5w==
X-Received: by 2002:adf:ee0c:0:b0:314:3997:530d with SMTP id y12-20020adfee0c000000b003143997530dmr6132017wrn.31.1688740953164;
        Fri, 07 Jul 2023 07:42:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ac80:753:1ffc:791b? ([2a01:e0a:982:cbb0:ac80:753:1ffc:791b])
        by smtp.gmail.com with ESMTPSA id h16-20020adff4d0000000b0031134bcdacdsm4631399wrp.42.2023.07.07.07.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 07:42:32 -0700 (PDT)
Message-ID: <0c8938a9-7a26-bf97-51ee-0c271901ec21@linaro.org>
Date:   Fri, 7 Jul 2023 16:42:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 03/18] soc: amlogic: Move power-domain drivers to the
 genpd dir
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
References: <20230707140434.723349-1-ulf.hansson@linaro.org>
 <20230707140434.723349-4-ulf.hansson@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230707140434.723349-4-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/07/2023 16:04, Ulf Hansson wrote:
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: <linux-amlogic@lists.infradead.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   MAINTAINERS                                        | 1 +
>   drivers/genpd/Makefile                             | 1 +
>   drivers/genpd/amlogic/Makefile                     | 4 ++++
>   drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c     | 0
>   drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c | 0
>   drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c | 0
>   drivers/soc/Makefile                               | 1 -
>   drivers/soc/amlogic/Makefile                       | 3 ---
>   8 files changed, 6 insertions(+), 4 deletions(-)
>   create mode 100644 drivers/genpd/amlogic/Makefile
>   rename drivers/{soc => genpd}/amlogic/meson-ee-pwrc.c (100%)
>   rename drivers/{soc => genpd}/amlogic/meson-gx-pwrc-vpu.c (100%)
>   rename drivers/{soc => genpd}/amlogic/meson-secure-pwrc.c (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 588769fab516..9b8c9ae2375d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1843,6 +1843,7 @@ F:	Documentation/devicetree/bindings/phy/amlogic*
>   F:	arch/arm/boot/dts/amlogic/
>   F:	arch/arm/mach-meson/
>   F:	arch/arm64/boot/dts/amlogic/
> +F:	drivers/genpd/amlogic/
>   F:	drivers/mmc/host/meson*
>   F:	drivers/phy/amlogic/
>   F:	drivers/pinctrl/meson/
> diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
> index a2d5b2095915..cdba3b9f0c75 100644
> --- a/drivers/genpd/Makefile
> +++ b/drivers/genpd/Makefile
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-y					+= actions/
> +obj-y					+= amlogic/
> diff --git a/drivers/genpd/amlogic/Makefile b/drivers/genpd/amlogic/Makefile
> new file mode 100644
> index 000000000000..3d58abd574f9
> --- /dev/null
> +++ b/drivers/genpd/amlogic/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
> +obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
> +obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o
> diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/genpd/amlogic/meson-ee-pwrc.c
> similarity index 100%
> rename from drivers/soc/amlogic/meson-ee-pwrc.c
> rename to drivers/genpd/amlogic/meson-ee-pwrc.c
> diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
> similarity index 100%
> rename from drivers/soc/amlogic/meson-gx-pwrc-vpu.c
> rename to drivers/genpd/amlogic/meson-gx-pwrc-vpu.c
> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/genpd/amlogic/meson-secure-pwrc.c
> similarity index 100%
> rename from drivers/soc/amlogic/meson-secure-pwrc.c
> rename to drivers/genpd/amlogic/meson-secure-pwrc.c
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 3b0f9fb3b5c8..dc93e1762ca7 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -23,7 +23,6 @@ obj-y				+= mediatek/
>   obj-y				+= microchip/
>   obj-y				+= nuvoton/
>   obj-y				+= pxa/
> -obj-y				+= amlogic/
>   obj-y				+= qcom/
>   obj-y				+= renesas/
>   obj-y				+= rockchip/
> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> index 7b8c5d323f5c..c25f835e6a26 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -2,7 +2,4 @@
>   obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
>   obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
>   obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
> -obj-$(CONFIG_MESON_GX_PM_DOMAINS) += meson-gx-pwrc-vpu.o
>   obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> -obj-$(CONFIG_MESON_EE_PM_DOMAINS) += meson-ee-pwrc.o
> -obj-$(CONFIG_MESON_SECURE_PM_DOMAINS) += meson-secure-pwrc.o

I've a few changes for v6.6, how shall we handle that ?

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks !
Neil
