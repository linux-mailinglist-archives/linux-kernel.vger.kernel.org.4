Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198E363EBB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLAI6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiLAI62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:58:28 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744E72A711
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:58:24 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id bi15so512403vkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAHU+obH6I+iGnv6YAFhQgkeKBQcF4Y1zkbhIvFN4iA=;
        b=mNNU1ZCcD2hOY5+CL69baaLmZlwX4asgqShmaFT8CS1ojh94DP+8nF0yKqn1FZ9V6v
         JT6j54iCOXcxMkAd9SqA02dbEUzu0Mld/ZBLA3CkvhhSplN0s7HDxR4PrkA8Vw0/S9mb
         B9MBGhm1dPImMAwKs4okXFSllMh5XQrV2rE7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAHU+obH6I+iGnv6YAFhQgkeKBQcF4Y1zkbhIvFN4iA=;
        b=hKAL8C7re4MJw7/ANocizPyFVxuWZ5L253WpAI7p4qwPn6LhxtZ7x2Vn520GKhFw0M
         g8BppXUNg+YuPBDJg3DO1esLx7RSITlZ/Flcy/nFldQIAyr0zDO6Rb87eayYUSvvEWLs
         zUVG7vKj7A8LuiOmQAjS7WdN09UIj5pY1ARj7v6sqg4llT/Dg5CDjuyNxaWHeFTKkJul
         wAUu6uzauDMhTJMJ6nNWs1j8ZzWkwL91YZeC23Yhnw2jaoiAxxh4bDsG6FpQerxcxsiZ
         gxEATQ9yRbciD4nU5w/xV71PcFkpGLQI7GqKtXNPYzluZafx8Jsja8LDQuiDE394qJ4X
         RCMw==
X-Gm-Message-State: ANoB5pkImmlxn7Vh36P5j/ypYMBwDvpUEOT77qKumJin3OH//XWvmY3C
        Fyr4t+qPNKEPF0/PXWELYQVA4DyYQ76ro8qxTLvdpQ==
X-Google-Smtp-Source: AA0mqf7DtI9hqZnvt7gRxwSAglieDVbP/0L9cQJYUTA/n0PwNQiSB2HxC2cnMKjnyV+izOosMmuhp9N0atEjVAVT+CQ=
X-Received: by 2002:a05:6122:904:b0:3bc:e1c0:469b with SMTP id
 j4-20020a056122090400b003bce1c0469bmr9896962vka.18.1669885103582; Thu, 01 Dec
 2022 00:58:23 -0800 (PST)
MIME-Version: 1.0
References: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
In-Reply-To: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 1 Dec 2022 16:58:12 +0800
Message-ID: <CAGXv+5HtR-bAJJC2cdqiPAVbiKPT7oGd0Xj9UjbciXt+szE_pg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8192: Add adsp power domain controller
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 3:33 PM Allen-KH Cheng
<allen-kh.cheng@mediatek.com> wrote:
>
> Add adsp power domain controller node for mt8192 SoC.
>
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
> Ref: https://lore.kernel.org/all/2ec80bd8-dfef-d2e6-eb41-6e6088043e33@collabora.com/
>     [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> ---
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 8 ++++++++
>  include/dt-bindings/power/mt8192-power.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 424fc89cc6f7..e71afba871fc 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -514,6 +514,14 @@
>                                                 };
>                                         };
>                                 };
> +
> +                               power-domain@MT8192_POWER_DOMAIN_ADSP {
> +                                       reg = <MT8192_POWER_DOMAIN_ADSP>;
> +                                       clocks = <&topckgen CLK_TOP_ADSP_SEL>;
> +                                       clock-names = "adsp";
> +                                       mediatek,infracfg = <&infracfg>;
> +                                       #power-domain-cells = <0>;
> +                               };
>                         };
>                 };
>

Please also tie the new power domain to the SCP_ADSP clock.

ChenYu

> diff --git a/include/dt-bindings/power/mt8192-power.h b/include/dt-bindings/power/mt8192-power.h
> index 4eaa53d7270a..63e81cd0d06d 100644
> --- a/include/dt-bindings/power/mt8192-power.h
> +++ b/include/dt-bindings/power/mt8192-power.h
> @@ -28,5 +28,6 @@
>  #define MT8192_POWER_DOMAIN_CAM_RAWA   18
>  #define MT8192_POWER_DOMAIN_CAM_RAWB   19
>  #define MT8192_POWER_DOMAIN_CAM_RAWC   20
> +#define MT8192_POWER_DOMAIN_ADSP       21
>
>  #endif /* _DT_BINDINGS_POWER_MT8192_POWER_H */
> --
> 2.18.0
>
