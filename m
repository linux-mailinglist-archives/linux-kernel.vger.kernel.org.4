Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA9C6EAF2C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjDUQcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjDUQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:32:07 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ADD14F50;
        Fri, 21 Apr 2023 09:31:58 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-541b5cfa9d8so1381745eaf.0;
        Fri, 21 Apr 2023 09:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682094718; x=1684686718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5OSoY157VoltSJbisqWs6GH2lNaxMJCjZwAmyir7xc=;
        b=gcF4i1SkapY8J5OFCLcd3kIPEWM9qijjSFGgphEIbczO7OVYVMzReASpAN+6147duJ
         IZUKmhMW7HLAb2WnQ/LKVOHW6/3wwNsB7LH/9i28QjlvIRtmrqo3JSw88RzTfmBy7l/m
         rNb32aGcl33AnKfCQkvumsrKuh4cbbHPvPfJmgUCYweclsPLBuz8U9pE46APf/gZhlKM
         G184xFewJAf6k7gIyxb7LVBtX5EgH8dhTbZu6oqRd44fm9Y+dOkrUU/AtGgA91cPNhT0
         RjxRM9YKdHQZDp439M3OfWZtKhAYAw3wLY5Nzhawx+JII7TuyGQ8/0JGTvMZLesu1qZH
         sRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094718; x=1684686718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5OSoY157VoltSJbisqWs6GH2lNaxMJCjZwAmyir7xc=;
        b=f0Enfxz8fHMX7FpY5akNVSutM9VA1YZ67FT1LK7V6ySEmHLgJR+QuhNB/ZLFnu5qbd
         TFgPYDjHndB32XVhgX1dGYBo+yyqdJjQWw82jIHqFY31ViHlZM9PwLuFqBop9EjqUR46
         fYbZl7t5QrYOMUw17rnf+sNTO4t+7zitS+2j9xfi3Lrox/NkH1rWVz/mpxWj4Gk1iGYh
         ejtBV76nzeQet36mGfHbWuLGfTpGn9CE7dcBO02ugKR8hpiRumdvOIzShoDtw3q0yQUs
         SmLGkf1OQxpf3g5B/GpiflharJdUEvnfvF5Y0nmGv+15Cg8+smg+wwZtgtFFknnOibBJ
         TWRA==
X-Gm-Message-State: AAQBX9dMxfd54GFyhN83jtJGYPcS/4ZuPGOyIlQrLCo1oxKmu6Ehn5pp
        NYZ+h+ypMBZYxIZJAl41Z+vgD8cx5CylRcAQ94Y=
X-Google-Smtp-Source: AKy350a7czDy+mtezgyExBFoS3kP4dgM9ZIjJNn5ByJZm7g4A8o/5zOhXIGqL+Bj6fiUG0oM2tWEtzgdGpeV350F9VM=
X-Received: by 2002:a05:6870:560e:b0:177:9993:ef49 with SMTP id
 m14-20020a056870560e00b001779993ef49mr4628253oao.47.1682094717686; Fri, 21
 Apr 2023 09:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230419095051.3269777-1-danishanwar@ti.com>
In-Reply-To: <20230419095051.3269777-1-danishanwar@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 21 Apr 2023 18:31:46 +0200
Message-ID: <CAH9NwWczpqsV2LfSdu6_D4ZC7KwKdVBrqh5jNqi=acmUTva5NQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable PRUSS as module
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     rafal@milecki.pl, Mark Brown <broonie@kernel.org>,
        nfraprado@collabora.com, Thierry Reding <treding@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, nm@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Enables PRUSS as kernel module for TI SoCs.
>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a24609e14d50..2a362a902526 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1277,6 +1277,7 @@ CONFIG_ARCH_TEGRA_186_SOC=y
>  CONFIG_ARCH_TEGRA_194_SOC=y
>  CONFIG_ARCH_TEGRA_234_SOC=y
>  CONFIG_TI_SCI_PM_DOMAINS=y
> +CONFIG_TI_PRUSS=m
>  CONFIG_ARM_IMX_BUS_DEVFREQ=y
>  CONFIG_ARM_IMX8M_DDRC_DEVFREQ=m
>  CONFIG_ARM_MEDIATEK_CCI_DEVFREQ=m
> --
> 2.34.1
>


-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
