Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A5F6798BB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjAXM5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbjAXM5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:57:49 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853112702
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:57:44 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id d10so11202976pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eYX5Gg0RYuLG3JWchgxDCU1ebgB/14/YoON4GiSl/iA=;
        b=PBtZ/OEhvk538N+lOX2wJyG+OlE3jKAeHBd9slCm8zE+Rrv+K+iyk0CgwYae7IKr1p
         kJGbINshhNnkBYL8G6B0qaq5IdYfWMuJXs0ALZcSBc7ZKaOP6vh/yHc6bcnUXFS+YrUV
         aKmx1HfpEC9IkcmNxZ7kwviOY0B7H5LpIvEADoDSn+uhc74A0IXCUHT3BWuQSfr6jtL+
         5gf3yTpj5fWPBr6DgdGbji7xEtNy/30e7JPH/gURnQyngKWHiL33LdTgtkhy0pJwxn7y
         /1GL4uKMuThPHgaSzsdM345M39CIH1ozmht1dRtAuA2i7fzfiwblXAaH19hFR+/tDzOI
         sN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYX5Gg0RYuLG3JWchgxDCU1ebgB/14/YoON4GiSl/iA=;
        b=jr9Uae8WTAQ3HUYLqRetM7Ke+GqehDxWiWewSzW2RCMS0lCrCg1XDTKu0FfN/tDNKe
         Zt6gDz/6xkS04y/5QMHqqS2mJan9ifC7inif9OxrNPzmQPoVdOGhvwGMKEviDu0UfwkP
         2MzYynmGTlYeCZlA4WTsGatkEdqkuAEJAy5XWWh4gUE+scQ8sTz7hwJGxSyBjDstCUDF
         e2GyH7g/YxhkS6lG2/+smxESY59YS4ByTTrIQigQ6PxAYC7QTKflu//6KuBYdn50D7He
         PhmpxoyorohhBaQhOfphEU9Ybp3lFHsVQSmonkJuKHoF2qBN4VLk0ZppHrDQZDYngQfb
         GDKA==
X-Gm-Message-State: AFqh2kowSl7Na8UiBwntlPXH/SIpKNsxMcq0vGq/aAgmTI0gD9yZKewI
        cGnuYC7JUwNAXvhHuG5vknLddA5E5lnZ7+5bXHLrnw==
X-Google-Smtp-Source: AMrXdXt2zZBkvHkbM9lG5zhAYQuJR/ZMU49wpI1wJV+FA16RCEZ9c6l6lco8jLx6XLIlmnz3ybQI4CYvCEVzptOJmyo=
X-Received: by 2002:aa7:90d8:0:b0:577:3e5e:7a4 with SMTP id
 k24-20020aa790d8000000b005773e5e07a4mr3365099pfk.57.1674565063179; Tue, 24
 Jan 2023 04:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120085722.171965-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Jan 2023 13:57:05 +0100
Message-ID: <CAPDyKFrPOAv3n275cRstYiLAMWVgL57z+D34xNSPAh8Vf0uyYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: drop unneeded quotes
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jan 2023 at 09:57, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Cleanup by removing unneeded quotes from refs and redundant blank lines.
> No functional impact except adjusting to preferred coding style.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |  2 +-
>  .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   |  2 +-
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml |  6 ++--
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 22 ++++++------
>  .../bindings/mmc/fsl-imx-esdhc.yaml           |  4 +--
>  .../devicetree/bindings/mmc/fsl-imx-mmc.yaml  |  2 +-
>  .../mmc/microchip,dw-sparx5-sdhci.yaml        |  4 +--
>  .../devicetree/bindings/mmc/mmc-spi-slot.yaml |  2 +-
>  .../devicetree/bindings/mmc/mxs-mmc.yaml      |  2 +-
>  .../bindings/mmc/nvidia,tegra20-sdhci.yaml    | 36 +++++++++----------
>  .../devicetree/bindings/mmc/owl-mmc.yaml      |  2 +-
>  .../bindings/mmc/renesas,mmcif.yaml           |  2 +-
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml |  6 ++--
>  .../bindings/mmc/rockchip-dw-mshc.yaml        |  2 +-
>  .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |  2 +-
>  .../devicetree/bindings/mmc/sunplus,mmc.yaml  |  2 +-
>  .../bindings/mmc/synopsys-dw-mshc-common.yaml |  2 +-
>  17 files changed, 50 insertions(+), 50 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 02ecc93417ef..0ccd632d5620 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Allwinner A10 MMC Controller
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>
>  maintainers:
>    - Chen-Yu Tsai <wens@csie.org>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
> index 1c391bec43dc..1a6cda82f296 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Amlogic Meson SDHC controller
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>
>  maintainers:
>    - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 4053de758db6..8296c34cfa00 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/mmc/arasan,sdhci.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/mmc/arasan,sdhci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: Arasan SDHCI Controller
>
> @@ -10,7 +10,7 @@ maintainers:
>    - Adrian Hunter <adrian.hunter@intel.com>
>
>  allOf:
> -  - $ref: "mmc-controller.yaml#"
> +  - $ref: mmc-controller.yaml#
>    - if:
>        properties:
>          compatible:
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 8b1a0fdcb5e3..d3dce4d6c168 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -36,43 +36,43 @@ properties:
>
>    cdns,phy-input-delay-sd-highspeed:
>      description: Value of the delay in the input path for SD high-speed timing
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x1f
>
>    cdns,phy-input-delay-legacy:
>      description: Value of the delay in the input path for legacy timing
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x1f
>
>    cdns,phy-input-delay-sd-uhs-sdr12:
>      description: Value of the delay in the input path for SD UHS SDR12 timing
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x1f
>
>    cdns,phy-input-delay-sd-uhs-sdr25:
>      description: Value of the delay in the input path for SD UHS SDR25 timing
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x1f
>
>    cdns,phy-input-delay-sd-uhs-sdr50:
>      description: Value of the delay in the input path for SD UHS SDR50 timing
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x1f
>
>    cdns,phy-input-delay-sd-uhs-ddr50:
>      description: Value of the delay in the input path for SD UHS DDR50 timing
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x1f
>
>    cdns,phy-input-delay-mmc-highspeed:
>      description: Value of the delay in the input path for MMC high-speed timing
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x1f
>
> @@ -83,7 +83,7 @@ properties:
>    # Each delay property represents the fraction of the clock period.
>    # The approximate delay value will be
>    # (<delay property value>/128)*sdmclk_clock_period.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x1f
>
> @@ -91,7 +91,7 @@ properties:
>      description: |
>        Value of the delay introduced on the sdclk output for all modes except
>        HS200, HS400 and HS400_ES.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x7f
>
> @@ -99,7 +99,7 @@ properties:
>      description: |
>        Value of the delay introduced on the sdclk output for HS200, HS400 and
>        HS400_ES speed modes.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x7f
>
> @@ -107,7 +107,7 @@ properties:
>      description: |
>        Value of the delay introduced on the dat_strobe input used in
>        HS400 / HS400_ES speed modes.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 0x7f
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index b3289593d5f1..269e0f421407 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Shawn Guo <shawnguo@kernel.org>
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>
>  description: |
>    The Enhanced Secure Digital Host Controller on Freescale i.MX family
> @@ -112,7 +112,7 @@ properties:
>      default: 0
>
>    voltage-ranges:
> -    $ref: '/schemas/types.yaml#/definitions/uint32-matrix'
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>      description: |
>        Specify the voltage range in case there are software transparent level
>        shifters on the outputs of the controller. Two cells are required, first
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
> index ffa162722b8e..221f5bc047bd 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Markus Pargmann <mpa@pengutronix.de>
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> index fa6cfe092fc9..1f63faf17743 100644
> --- a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Microchip Sparx5 Mobile Storage Host Controller
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>
>  maintainers:
>    - Lars Povlsen <lars.povlsen@microchip.com>
> @@ -35,7 +35,7 @@ properties:
>    microchip,clock-delay:
>      description: Delay clock to card to meet setup time requirements.
>        Each step increase by 1.25ns.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 1
>      maximum: 15
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> index c0662ce9946d..36acc40c7d18 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Ulf Hansson <ulf.hansson@linaro.org>
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>    - $ref: /schemas/spi/spi-peripheral-props.yaml
>
>  description: |
> diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
> index bec8f8c71ff2..32e512a68ed6 100644
> --- a/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
> @@ -17,7 +17,7 @@ description: |
>    and the properties used by the mxsmmc driver.
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
> index fe0270207622..285057523ead 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.yaml
> @@ -83,7 +83,7 @@ properties:
>      maxItems: 1
>
>    operating-points-v2:
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>    power-domains:
>      items:
> @@ -100,53 +100,53 @@ properties:
>
>        The DQS trim values are only used on controllers which support HS400
>        timing. Only SDMMC4 on Tegra210 and Tegra186 supports HS400.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,default-trim:
>      description: Specify the default outbound clock trimmer value.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,dqs-trim:
>      description: Specify DQS trim value for HS400 timing.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-down-offset-1v8:
>      description: Specify drive strength calibration offsets for 1.8 V
>        signaling modes.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-down-offset-1v8-timeout:
>      description: Specify drive strength used as a fallback in case the
>        automatic calibration times out on a 1.8 V signaling mode.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-down-offset-3v3:
>      description: Specify drive strength calibration offsets for 3.3 V
>        signaling modes.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-down-offset-3v3-timeout:
>      description: Specify drive strength used as a fallback in case the
>        automatic calibration times out on a 3.3 V signaling mode.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-down-offset-sdr104:
>      description: Specify drive strength calibration offsets for SDR104 mode.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-down-offset-hs400:
>      description: Specify drive strength calibration offsets for HS400 mode.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-up-offset-1v8:
>      description: Specify drive strength calibration offsets for 1.8 V
>        signaling modes.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-up-offset-1v8-timeout:
>      description: Specify drive strength used as a fallback in case the
>        automatic calibration times out on a 1.8 V signaling mode.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-up-offset-3v3:
>      description: Specify drive strength calibration offsets for 3.3 V
> @@ -158,25 +158,25 @@ properties:
>        refer to the reference manual of the SoC for correct values. The SDR104
>        and HS400 timing specific values are used in corresponding modes if
>        specified.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-up-offset-3v3-timeout:
>      description: Specify drive strength used as a fallback in case the
>        automatic calibration times out on a 3.3 V signaling mode.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-up-offset-sdr104:
>      description: Specify drive strength calibration offsets for SDR104 mode.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,pad-autocal-pull-up-offset-hs400:
>      description: Specify drive strength calibration offsets for HS400 mode.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,only-1-8v:
>      description: The presence of this property indicates that the controller
>        operates at a 1.8 V fixed I/O voltage.
> -    $ref: "/schemas/types.yaml#/definitions/flag"
> +    $ref: /schemas/types.yaml#/definitions/flag
>
>  required:
>    - compatible
> @@ -187,7 +187,7 @@ required:
>    - reset-names
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>    - if:
>        properties:
>          compatible:
> diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> index b0d81ebe0f6e..1b7d88ed3799 100644
> --- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Actions Semi Owl SoCs SD/MMC/SDIO controller
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>
>  maintainers:
>    - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.yaml b/Documentation/devicetree/bindings/mmc/renesas,mmcif.yaml
> index c36ba561c387..024313b79ec9 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Wolfram Sang <wsa+renesas@sang-engineering.com>
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index fa089cbb155b..7756a8687eaf 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/mmc/renesas,sdhi.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/mmc/renesas,sdhi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: Renesas SDHI SD/MMC controller
>
> @@ -112,7 +112,7 @@ properties:
>    max-frequency: true
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>
>    - if:
>        properties:
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index c7e14b7dba9e..67d7223f74da 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -14,7 +14,7 @@ description:
>    file and the Rockchip specific extensions.
>
>  allOf:
> -  - $ref: "synopsys-dw-mshc-common.yaml#"
> +  - $ref: synopsys-dw-mshc-common.yaml#
>
>  maintainers:
>    - Heiko Stuebner <heiko@sntech.de>
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> index fdaa18481aa0..6ee78a38bd74 100644
> --- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> @@ -112,7 +112,7 @@ required:
>    - samsung,dw-mshc-sdr-timing
>
>  allOf:
> -  - $ref: "synopsys-dw-mshc-common.yaml#"
> +  - $ref: synopsys-dw-mshc-common.yaml#
>    - if:
>        properties:
>          compatible:
> diff --git a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> index 23aa8e6b2d70..611687166735 100644
> --- a/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sunplus,mmc.yaml
> @@ -12,7 +12,7 @@ maintainers:
>    - Li-hao Kuo <lhjeff911@gmail.com>
>
>  allOf:
> -  - $ref: "mmc-controller.yaml"
> +  - $ref: mmc-controller.yaml
>
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> index 8dfad89c78a7..6f11b2adf103 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Synopsys Designware Mobile Storage Host Controller Common Properties
>
>  allOf:
> -  - $ref: "mmc-controller.yaml#"
> +  - $ref: mmc-controller.yaml#
>
>  maintainers:
>    - Ulf Hansson <ulf.hansson@linaro.org>
> --
> 2.34.1
>
