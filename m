Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE476C45D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjCVJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCVJKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:10:55 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC39149AA;
        Wed, 22 Mar 2023 02:10:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A9D3A58;
        Wed, 22 Mar 2023 10:10:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1679476224;
        bh=DD935MD/BKRZjwkvRQBNtvyFKEmkrhSS70T5kLp/5yA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUNseNHtNeMMwljbsEsQOdFjoG2afkgie8I70MQ+meRrtJlo5xWt95CcJLvYAuLfk
         0y9KoH2fVy94YSruGWcRYDJn+R406orOWF1NiKEP/iACa7yVwKDoROPa+Oj/UIY9VT
         674mCvZMw0FHTcAawIT16LU+KFnAkFgdbPfM7Ln0=
Date:   Wed, 22 Mar 2023 11:10:30 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Joe Tessler <jrt@google.com>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Benoit Parrot <bparrot@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] media: dt-bindings: Drop unneeded quotes
Message-ID: <20230322091030.GK20234@pendragon.ideasonboard.com>
References: <20230320233944.2920964-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230320233944.2920964-1-robh@kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Mon, Mar 20, 2023 at 06:39:42PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  .../devicetree/bindings/media/allwinner,sun4i-a10-ir.yaml | 2 +-
>  .../bindings/media/allwinner,sun50i-h6-vpu-g2.yaml        | 4 ++--
>  .../devicetree/bindings/media/amlogic,axg-ge2d.yaml       | 4 ++--
>  .../devicetree/bindings/media/amlogic,gx-vdec.yaml        | 4 ++--
>  .../devicetree/bindings/media/amlogic,meson-ir-tx.yaml    | 4 ++--
>  .../devicetree/bindings/media/i2c/chrontel,ch7322.yaml    | 4 ++--
>  .../devicetree/bindings/media/i2c/dongwoon,dw9768.yaml    | 6 +++---
>  .../devicetree/bindings/media/i2c/maxim,max9286.yaml      | 2 +-
>  .../devicetree/bindings/media/i2c/ovti,ov02a10.yaml       | 2 +-
>  .../devicetree/bindings/media/mediatek,mdp3-rdma.yaml     | 2 +-
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml    | 4 ++--
>  .../devicetree/bindings/media/microchip,sama5d4-vdec.yaml | 4 ++--
>  .../devicetree/bindings/media/nxp,imx8mq-vpu.yaml         | 4 ++--
>  .../devicetree/bindings/media/qcom,msm8916-camss.yaml     | 4 ++--
>  .../devicetree/bindings/media/qcom,msm8916-venus.yaml     | 8 ++++----
>  .../devicetree/bindings/media/qcom,msm8996-camss.yaml     | 4 ++--
>  .../devicetree/bindings/media/qcom,msm8996-venus.yaml     | 4 ++--
>  .../devicetree/bindings/media/qcom,sc7180-venus.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sc7280-venus.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sdm660-camss.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sdm660-venus.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sdm845-camss.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sdm845-venus-v2.yaml   | 4 ++--
>  .../devicetree/bindings/media/qcom,sdm845-venus.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sm8250-camss.yaml      | 4 ++--
>  .../devicetree/bindings/media/qcom,sm8250-venus.yaml      | 4 ++--
>  Documentation/devicetree/bindings/media/rc.yaml           | 2 +-
>  .../devicetree/bindings/media/rockchip,rk3568-vepu.yaml   | 4 ++--
>  Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 4 ++--
>  Documentation/devicetree/bindings/media/ti,cal.yaml       | 2 +-
>  30 files changed, 57 insertions(+), 57 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-ir.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-ir.yaml
> index 53945c61325c..42dfe22ad5f1 100644
> --- a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-ir.yaml
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-ir.yaml
> @@ -11,7 +11,7 @@ maintainers:
>    - Maxime Ripard <mripard@kernel.org>
>  
>  allOf:
> -  - $ref: "rc.yaml#"
> +  - $ref: rc.yaml#
>  
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml b/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
> index 9d44236f2deb..a4f06bbdfe49 100644
> --- a/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun50i-h6-vpu-g2.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/allwinner,sun50i-h6-vpu-g2.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/allwinner,sun50i-h6-vpu-g2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Hantro G2 VPU codec implemented on Allwinner H6 SoC
>  
> diff --git a/Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml b/Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
> index e551be5e680e..f23fa6d06ad0 100644
> --- a/Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
> +++ b/Documentation/devicetree/bindings/media/amlogic,axg-ge2d.yaml
> @@ -2,8 +2,8 @@
>  # Copyright 2020 BayLibre, SAS
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/amlogic,axg-ge2d.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/amlogic,axg-ge2d.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Amlogic GE2D Acceleration Unit
>  
> diff --git a/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml b/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
> index b827edabcafa..55930f6107c9 100644
> --- a/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
> +++ b/Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
> @@ -2,8 +2,8 @@
>  # Copyright 2019 BayLibre, SAS
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/amlogic,gx-vdec.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/amlogic,gx-vdec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Amlogic Video Decoder
>  
> diff --git a/Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml b/Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml
> index 4432fea32650..377acce93423 100644
> --- a/Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml
> +++ b/Documentation/devicetree/bindings/media/amlogic,meson-ir-tx.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/amlogic,meson-ir-tx.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/amlogic,meson-ir-tx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Amlogic Meson IR transmitter
>  
> diff --git a/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml b/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
> index af8ada55b3f2..4e69b6a7ffcc 100644
> --- a/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/chrontel,ch7322.yaml
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/i2c/chrontel,ch7322.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/i2c/chrontel,ch7322.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Chrontel HDMI-CEC Controller
>  
> diff --git a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.yaml b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.yaml
> index 82d3d18c16a1..a0855d3b7577 100644
> --- a/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/dongwoon,dw9768.yaml
> @@ -38,7 +38,7 @@ properties:
>    dongwoon,aac-mode:
>      description:
>        Indication of AAC mode select.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      enum:
>        - 1    #  AAC2 mode(operation time# 0.48 x Tvib)
>        - 2    #  AAC3 mode(operation time# 0.70 x Tvib)
> @@ -50,7 +50,7 @@ properties:
>      description:
>        Number of AAC Timing count that controlled by one 6-bit period of
>        vibration register AACT[5:0], the unit of which is 100 us.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      default: 0x20
>      minimum: 0x00
>      maximum: 0x3f
> @@ -59,7 +59,7 @@ properties:
>      description:
>        Indication of VCM internal clock dividing rate select, as one multiple
>        factor to calculate VCM ring periodic time Tvib.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      enum:
>        - 0    #  Dividing Rate -  2
>        - 1    #  Dividing Rate -  1
> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
> index 0c4213adbf6a..8df859136047 100644
> --- a/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max9286.yaml
> @@ -86,7 +86,7 @@ properties:
>        is 100000 micro volts
>  
>    maxim,gpio-poc:
> -    $ref: '/schemas/types.yaml#/definitions/uint32-array'
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>      minItems: 2
>      maxItems: 2
>      description: |
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml
> index 54df9d73dc86..763cebe03dc2 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov02a10.yaml
> @@ -88,7 +88,7 @@ properties:
>          properties:
>            link-frequencies: true
>            ovti,mipi-clock-voltage:
> -            $ref: "/schemas/types.yaml#/definitions/uint32"
> +            $ref: /schemas/types.yaml#/definitions/uint32
>              description:
>                Definition of MIPI clock voltage unit. This entry corresponds to
>                the link speed defined by the 'link-frequencies' property.
> diff --git a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> index 9cfc0c7d23e0..7032c7e15039 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml
> @@ -27,7 +27,7 @@ properties:
>      maxItems: 1
>  
>    mediatek,gce-client-reg:
> -    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        items:
>          - description: phandle of GCE
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index c4f20acdc1f8..20675f9ba3cd 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/mediatek,vcodec-subdev-decoder.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/mediatek,vcodec-subdev-decoder.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Mediatek Video Decode Accelerator With Multi Hardware
>  
> diff --git a/Documentation/devicetree/bindings/media/microchip,sama5d4-vdec.yaml b/Documentation/devicetree/bindings/media/microchip,sama5d4-vdec.yaml
> index 4b77103ca913..59b805ca47c5 100644
> --- a/Documentation/devicetree/bindings/media/microchip,sama5d4-vdec.yaml
> +++ b/Documentation/devicetree/bindings/media/microchip,sama5d4-vdec.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/microchip,sama5d4-vdec.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/microchip,sama5d4-vdec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Hantro G1 VPU codec implemented on Microchip SAMA5D4 SoCs
>  
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> index 7dc13a4b1805..3d58f02b0c5d 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/nxp,imx8mq-vpu.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/nxp,imx8mq-vpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Hantro G1/G2 VPU codecs implemented on i.MX8M SoCs
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> index 12ec3e1ea869..eb1499912c58 100644
> --- a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,msm8916-camss.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,msm8916-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm CAMSS ISP
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
> index 2abb7d21c0d1..4ad42b8f19e6 100644
> --- a/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8916-venus.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,msm8916-venus.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,msm8916-venus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm Venus video encode and decode accelerators
>  
> @@ -47,7 +47,7 @@ properties:
>  
>      properties:
>        compatible:
> -        const: "venus-decoder"
> +        const: venus-decoder
>  
>      required:
>        - compatible
> @@ -59,7 +59,7 @@ properties:
>  
>      properties:
>        compatible:
> -        const: "venus-encoder"
> +        const: venus-encoder
>  
>      required:
>        - compatible
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> index 6aeb3d6d02d5..8a10aa1cafc5 100644
> --- a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,msm8996-camss.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,msm8996-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm CAMSS ISP
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml b/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
> index 29d0cb6c6ebe..213247a43ef2 100644
> --- a/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8996-venus.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,msm8996-venus.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,msm8996-venus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm Venus video encode and decode accelerators
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> index 42ee3f06c6be..5128a254fd25 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sc7180-venus.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,sc7180-venus.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,sc7180-venus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm Venus video encode and decode accelerators
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> index cf361dd9de08..eb9ce438dbe0 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sc7280-venus.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,sc7280-venus.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,sc7280-venus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm Venus video encode and decode accelerators
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
> index b28c8e17f158..0a109e126064 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sdm660-camss.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,sdm660-camss.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,sdm660-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm CAMSS ISP
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
> index 45e3f58f52bd..4a0a9ca33cad 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sdm660-venus.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,sdm660-venus.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,sdm660-venus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm Venus video encode and decode accelerators
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
> index f9a003882f84..1530ad0d80bd 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sdm845-camss.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,sdm845-camss.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,sdm845-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm CAMSS ISP
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
> index 8edc8a2f43a5..d81c3ee53ed6 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,sdm845-venus-v2.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,sdm845-venus-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm Venus video encode and decode accelerators
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
> index 57d503373efe..1bf043c4c8fb 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sdm845-venus.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,sdm845-venus.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,sdm845-venus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm Venus video encode and decode accelerators
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-camss.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-camss.yaml
> index 07a2af12f37d..fa5073c0fd1e 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sm8250-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8250-camss.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,sm8250-camss.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,sm8250-camss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm CAMSS ISP
>  
> diff --git a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
> index 4b7a12523dcf..8c8141723524 100644
> --- a/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,sm8250-venus.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/qcom,sm8250-venus.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/qcom,sm8250-venus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Qualcomm Venus video encode and decode accelerators
>  
> diff --git a/Documentation/devicetree/bindings/media/rc.yaml b/Documentation/devicetree/bindings/media/rc.yaml
> index e732b7f3a635..6cecd7d941ca 100644
> --- a/Documentation/devicetree/bindings/media/rc.yaml
> +++ b/Documentation/devicetree/bindings/media/rc.yaml
> @@ -18,7 +18,7 @@ properties:
>      description:
>        Specifies the scancode/key mapping table defined in-kernel for
>        the remote controller.
> -    $ref: '/schemas/types.yaml#/definitions/string'
> +    $ref: /schemas/types.yaml#/definitions/string
>      enum:
>        - rc-adstech-dvb-t-pci
>        - rc-alink-dtu-m
> diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> index 81b26eb4cd35..9d90d8d0565a 100644
> --- a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/rockchip,rk3568-vepu.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/rockchip,rk3568-vepu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Hantro G1 VPU encoders implemented on Rockchip SoCs
>  
> diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> index 6cc4d3e5a61d..ee622a8ee1cc 100644
> --- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> @@ -2,8 +2,8 @@
>  
>  %YAML 1.2
>  ---
> -$id: "http://devicetree.org/schemas/media/rockchip-vpu.yaml#"
> -$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +$id: http://devicetree.org/schemas/media/rockchip-vpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Hantro G1 VPU codecs implemented on Rockchip SoCs
>  
> diff --git a/Documentation/devicetree/bindings/media/ti,cal.yaml b/Documentation/devicetree/bindings/media/ti,cal.yaml
> index 26b3fedef355..f1a940a110d2 100644
> --- a/Documentation/devicetree/bindings/media/ti,cal.yaml
> +++ b/Documentation/devicetree/bindings/media/ti,cal.yaml
> @@ -47,7 +47,7 @@ properties:
>      maxItems: 1
>  
>    ti,camerrx-control:
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        - items:
>            - description: phandle to device control module

-- 
Regards,

Laurent Pinchart
