Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CA5675133
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjATJcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjATJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:32:32 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A6A7327
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:32:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so5385033wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kwcNWOJu++BSeRCaBZOYmzH+VNI6xbZXZZDxdGPdiVw=;
        b=ZddLHJ21L6LvL+VLyEVw2qy8taGHe0iy5tPJiiKRZ6ceveVeMciYO1lkRYca8zUfIo
         pQDIbKbCkEWsezy5rY/WocrhWzECr6gQ7tow9OPVuQqlbBmX9kq4YdCYZTt1TOvGf2fQ
         9dFelVP29QGMMjT+jAKE2VR0bimyBY8J1sFTLdqMAWH2GYzl6KGwMVglH6JfqCf/TLoC
         ANiolyMquW/5EUvTgFaKQnvQjnlrh9D4+gqX3aBoDgJCcgSSPa259laF5iaDZBk9TULD
         cfrKp7gPIA2r24+1q/p/1zubwJlaZ7AmXNbP/0l4B471FzNmngl/mlU6AMtOFRvd1aTK
         Ulkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwcNWOJu++BSeRCaBZOYmzH+VNI6xbZXZZDxdGPdiVw=;
        b=3kbJrH9mSQR8Hb55n6It75WfxzHR4bFebX4hxm750BAmf4m95Rg5E5b7ahSUw/P46J
         9xOAR4Bg2hRKEjuPHu5wlz7B7C8owZOba2d4LESMpFG1Ng7P/hr3aZGo7/WX62ZIERtD
         WW7A34pGYplmTihElWJR713RqiCTx7msgebBhlPc00vY3nui6NMc4bzHrPqMlzOnK1Jl
         Pc2kbaSWKi16Y2cVmaCo7i3A7usl9jAYMaL5ucosNiJxBoyt7B8B7l9eTNOY5/J2HwjI
         SkSra0ZhHsRd+5laGSKj13P7MioLs99PNavS9vI6acRA/UgMB0n5KBf8rMYZkC6P1/qa
         C4CA==
X-Gm-Message-State: AFqh2kqE2Muox1qh2QAAK+E12PYCPzQlc8w4OeGTdjT5zNfd6kjs62KO
        AFAvK2NpMopGHiF8i04GrlrzLA==
X-Google-Smtp-Source: AMrXdXskA1O2lr97eO1VtkYEVuAeFE+zfo7K+thpsW39zCg4BoBdphV/Sl932BgLu6aezuBUgbBlXg==
X-Received: by 2002:a05:600c:684:b0:3cf:5d41:b748 with SMTP id a4-20020a05600c068400b003cf5d41b748mr21784793wmn.36.1674207121229;
        Fri, 20 Jan 2023 01:32:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:39d8:cbee:30fb:cdaa? ([2a01:e0a:982:cbb0:39d8:cbee:30fb:cdaa])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003c6bbe910fdsm2259681wmo.9.2023.01.20.01.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 01:32:00 -0800 (PST)
Message-ID: <770fb64a-b844-79ae-8cd7-bb80cf49b408@linaro.org>
Date:   Fri, 20 Jan 2023 10:31:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] dt-bindings: mmc: drop unneeded quotes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Markus Pargmann <mpa@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 09:57, Krzysztof Kozlowski wrote:
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |  2 +-
>   .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   |  2 +-

For Amlogic part:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

>   .../devicetree/bindings/mmc/arasan,sdhci.yaml |  6 ++--
>   .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 22 ++++++------
>   .../bindings/mmc/fsl-imx-esdhc.yaml           |  4 +--
>   .../devicetree/bindings/mmc/fsl-imx-mmc.yaml  |  2 +-
>   .../mmc/microchip,dw-sparx5-sdhci.yaml        |  4 +--
>   .../devicetree/bindings/mmc/mmc-spi-slot.yaml |  2 +-
>   .../devicetree/bindings/mmc/mxs-mmc.yaml      |  2 +-
>   .../bindings/mmc/nvidia,tegra20-sdhci.yaml    | 36 +++++++++----------
>   .../devicetree/bindings/mmc/owl-mmc.yaml      |  2 +-
>   .../bindings/mmc/renesas,mmcif.yaml           |  2 +-
>   .../devicetree/bindings/mmc/renesas,sdhi.yaml |  6 ++--
>   .../bindings/mmc/rockchip-dw-mshc.yaml        |  2 +-
>   .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |  2 +-
>   .../devicetree/bindings/mmc/sunplus,mmc.yaml  |  2 +-
>   .../bindings/mmc/synopsys-dw-mshc-common.yaml |  2 +-
>   17 files changed, 50 insertions(+), 50 deletions(-)
> 

<snip>

> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
> index 1c391bec43dc..1a6cda82f296 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>   title: Amlogic Meson SDHC controller
>   
>   allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>   
>   maintainers:
>     - Martin Blumenstingl <martin.blumenstingl@googlemail.com>

<snip>

