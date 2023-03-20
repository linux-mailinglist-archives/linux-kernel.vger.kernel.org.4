Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD046C1A66
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjCTPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjCTPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:52:38 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D33B223;
        Mon, 20 Mar 2023 08:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B6633CE0FED;
        Mon, 20 Mar 2023 15:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E70C43445;
        Mon, 20 Mar 2023 15:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679326999;
        bh=FIjnrYSWVKmptYqtz4MXE6AXIlftyuKBvggfQwc5SL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jO5a6xzoJmW97z9XHGqKlXqXZok4c9E9QTKGAlKVf3PAblwh5pN2WbIzE+G2Yy/7K
         fEaxM7dspAzsVJRsG+3w+VoJmkEcF3Pfpbb/WeRCOfklwJGG6r6XRlevg5c7zJex2N
         /BhUoutdS6uCwg0j7M4r+T0r3ezZk5BUqlmytlMWpm0Nvk3xuN+wEmlk7OMP4BtG9T
         ZLPf2xhY0fGIU8bcHT9awfSKMAp9JdarE6RShXzbGZYY47L5voepgtii3A9HDcg2RJ
         O7sppwttHEgt+F81GDpsg86pYnwUAnmti2/ra4gI4WaqQmnrq46PccJMVi+W+hOxZM
         1hkqMhReC9vMg==
Received: by mail-lf1-f50.google.com with SMTP id k37so2508372lfv.0;
        Mon, 20 Mar 2023 08:43:18 -0700 (PDT)
X-Gm-Message-State: AO0yUKUgGRVHzLau6UTrhgP5O8qfmVWG03lGGRO30uyLqYJvrQ5s+aZh
        xwMJREyGZW9y5HPgNpYymhTeqvYU+vNyFRzF9g==
X-Google-Smtp-Source: AK7set+MDLKR8o/t4l80t3bMr4ropPcBwrPYqJRuxiSQpX/80/msVu0P431Z5gqBVM/Y3vT76Hdi0XD7VwHuWdpeaJk=
X-Received: by 2002:a05:6512:3887:b0:4d5:ca42:e43e with SMTP id
 n7-20020a056512388700b004d5ca42e43emr129798lft.7.1679326996315; Mon, 20 Mar
 2023 08:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230317233626.3968358-1-robh@kernel.org>
In-Reply-To: <20230317233626.3968358-1-robh@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 20 Mar 2023 23:43:04 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9a0DutFu6cMRjB5aShwU0iFrOjro94ZB+62HAoakfs-g@mail.gmail.com>
Message-ID: <CAAOTY_9a0DutFu6cMRjB5aShwU0iFrOjro94ZB+62HAoakfs-g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: Drop unneeded quotes
To:     Rob Herring <robh@kernel.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob:

Rob Herring <robh@kernel.org> =E6=96=BC 2023=E5=B9=B43=E6=9C=8818=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=887:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.

For MediaTek part,

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/auxdisplay/holtek,ht16k33.yaml    |  2 +-
>  .../bindings/display/bridge/nxp,ptn3460.yaml   |  2 +-
>  .../display/bridge/toshiba,tc358767.yaml       |  2 +-
>  .../bindings/display/dp-aux-bus.yaml           |  2 +-
>  .../display/mediatek/mediatek,hdmi.yaml        |  2 +-
>  .../display/msm/dsi-controller-main.yaml       |  8 ++++----
>  .../bindings/display/msm/dsi-phy-10nm.yaml     |  2 +-
>  .../bindings/display/panel/ronbo,rb070d30.yaml |  2 +-
>  .../bindings/display/renesas,du.yaml           |  4 ++--
>  .../display/tegra/nvidia,tegra114-mipi.yaml    |  2 +-
>  .../display/tegra/nvidia,tegra124-sor.yaml     | 12 ++++++------
>  .../display/tegra/nvidia,tegra186-dc.yaml      |  4 ++--
>  .../tegra/nvidia,tegra186-dsi-padctl.yaml      |  2 +-
>  .../display/tegra/nvidia,tegra20-dsi.yaml      | 12 ++++++------
>  .../display/tegra/nvidia,tegra20-hdmi.yaml     |  6 +++---
>  .../bindings/display/ti/ti,am65x-dss.yaml      |  2 +-
>  .../display/xylon,logicvc-display.yaml         | 18 +++++++++---------
>  17 files changed, 42 insertions(+), 42 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.=
yaml b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
> index fc4873deb76f..4f6ffb8182a9 100644
> --- a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
> +++ b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
> @@ -10,7 +10,7 @@ maintainers:
>    - Robin van der Gracht <robin@protonic.nl>
>
>  allOf:
> -  - $ref: "/schemas/input/matrix-keymap.yaml#"
> +  - $ref: /schemas/input/matrix-keymap.yaml#
>
>  properties:
>    compatible:
> diff --git a/Documentation/devicetree/bindings/display/bridge/nxp,ptn3460=
.yaml b/Documentation/devicetree/bindings/display/bridge/nxp,ptn3460.yaml
> index 107dd138e6c6..cdeb67bc05f0 100644
> --- a/Documentation/devicetree/bindings/display/bridge/nxp,ptn3460.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/nxp,ptn3460.yaml
> @@ -18,7 +18,7 @@ properties:
>      maxItems: 1
>
>    edid-emulation:
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        The EDID emulation entry to use
>        Value  Resolution  Description
> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc3=
58767.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358=
767.yaml
> index 140927884418..e1494b5007cb 100644
> --- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.y=
aml
> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.y=
aml
> @@ -23,7 +23,7 @@ properties:
>          i2c address of the bridge, 0x68 or 0x0f, depending on bootstrap =
pins
>
>    clock-names:
> -    const: "ref"
> +    const: ref
>
>    clocks:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/dp-aux-bus.yaml b/=
Documentation/devicetree/bindings/display/dp-aux-bus.yaml
> index 5e4afe9f98fb..0ece7b01790b 100644
> --- a/Documentation/devicetree/bindings/display/dp-aux-bus.yaml
> +++ b/Documentation/devicetree/bindings/display/dp-aux-bus.yaml
> @@ -26,7 +26,7 @@ description:
>
>  properties:
>    $nodename:
> -    const: "aux-bus"
> +    const: aux-bus
>
>    panel:
>      $ref: panel/panel-common.yaml#
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdm=
i.yaml
> index 8afdd67d6780..b90b6d18a828 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.ya=
ml
> @@ -50,7 +50,7 @@ properties:
>        - const: hdmi
>
>    mediatek,syscon-hdmi:
> -    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        - items:
>            - description: phandle to system configuration registers
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller=
-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-m=
ain.yaml
> index e75a3efe4dac..2188d7c9b0bb 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.y=
aml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.y=
aml
> @@ -74,7 +74,7 @@ properties:
>
>    syscon-sfpb:
>      description: A phandle to mmss_sfpb syscon node (only for DSIv2).
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>    qcom,dual-dsi-mode:
>      type: boolean
> @@ -105,14 +105,14 @@ properties:
>      type: object
>
>    ports:
> -    $ref: "/schemas/graph.yaml#/properties/ports"
> +    $ref: /schemas/graph.yaml#/properties/ports
>      description: |
>        Contains DSI controller input and output ports as children, each
>        containing one endpoint subnode.
>
>      properties:
>        port@0:
> -        $ref: "/schemas/graph.yaml#/$defs/port-base"
> +        $ref: /schemas/graph.yaml#/$defs/port-base
>          unevaluatedProperties: false
>          description: |
>            Input endpoints of the controller.
> @@ -128,7 +128,7 @@ properties:
>                    enum: [ 0, 1, 2, 3 ]
>
>        port@1:
> -        $ref: "/schemas/graph.yaml#/$defs/port-base"
> +        $ref: /schemas/graph.yaml#/$defs/port-base
>          unevaluatedProperties: false
>          description: |
>            Output endpoints of the controller.
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.y=
aml b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
> index 3ec466c3ab38..e6b00d7387ce 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
> @@ -58,7 +58,7 @@ properties:
>        maximum: 31
>
>    qcom,phy-drive-ldo-level:
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      description:
>        The PHY LDO has an amplitude tuning feature to adjust the LDO outp=
ut
>        for the HSTX drive. Use supported levels (mV) to offset the drive =
level
> diff --git a/Documentation/devicetree/bindings/display/panel/ronbo,rb070d=
30.yaml b/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.ya=
ml
> index d67617f6f74a..95ce22c6787a 100644
> --- a/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
> @@ -37,7 +37,7 @@ properties:
>
>    backlight:
>      description: Backlight used by the panel
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/display/renesas,du.yaml b/=
Documentation/devicetree/bindings/display/renesas,du.yaml
> index d4830f52c512..c5b9e6812bce 100644
> --- a/Documentation/devicetree/bindings/display/renesas,du.yaml
> +++ b/Documentation/devicetree/bindings/display/renesas,du.yaml
> @@ -76,7 +76,7 @@ properties:
>      unevaluatedProperties: false
>
>    renesas,cmms:
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        maxItems: 1
>      description:
> @@ -84,7 +84,7 @@ properties:
>        available DU channel.
>
>    renesas,vsps:
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
>        items:
>          - description: phandle to VSP instance that serves the DU channe=
l
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
114-mipi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegr=
a114-mipi.yaml
> index d5ca8cf86e8e..f448624dd779 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mip=
i.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mip=
i.yaml
> @@ -38,7 +38,7 @@ properties:
>      description: The number of cells in a MIPI calibration specifier.
>        Should be 1. The single cell specifies a bitmask of the pads that
>        need to be calibrated for a given device.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      const: 1
>
>  additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
124-sor.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
124-sor.yaml
> index 907fb0baccae..70f0e45c71d6 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor=
.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor=
.yaml
> @@ -69,12 +69,12 @@ properties:
>    # Tegra186 and later
>    nvidia,interface:
>      description: index of the SOR interface
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>    nvidia,ddc-i2c-bus:
>      description: phandle of an I2C controller used for DDC EDID
>        probing
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>    nvidia,hpd-gpio:
>      description: specifies a GPIO used for hotplug detection
> @@ -82,23 +82,23 @@ properties:
>
>    nvidia,edid:
>      description: supplies a binary EDID blob
> -    $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>
>    nvidia,panel:
>      description: phandle of a display panel, required for eDP
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>    nvidia,xbar-cfg:
>      description: 5 cells containing the crossbar configuration.
>        Each lane of the SOR, identified by the cell's index, is
>        mapped via the crossbar to the pad specified by the cell's
>        value.
> -    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>
>    # optional when driving an eDP output
>    nvidia,dpaux:
>      description: phandle to a DispayPort AUX interface
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>  allOf:
>    - if:
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
186-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra1=
86-dc.yaml
> index 265a60d79d89..ce4589466a18 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.=
yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.=
yaml
> @@ -60,13 +60,13 @@ properties:
>    nvidia,outputs:
>      description: A list of phandles of outputs that this display
>        controller can drive.
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>
>    nvidia,head:
>      description: The number of the display controller head. This
>        is used to setup the various types of output to receive
>        video data from the given head.
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>
>  additionalProperties: false
>
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
186-dsi-padctl.yaml b/Documentation/devicetree/bindings/display/tegra/nvidi=
a,tegra186-dsi-padctl.yaml
> index e5a6145c8c53..da75b71e8ece 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dsi=
-padctl.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dsi=
-padctl.yaml
> @@ -29,7 +29,7 @@ properties:
>        - const: dsi
>
>  allOf:
> -  - $ref: "/schemas/reset/reset.yaml"
> +  - $ref: /schemas/reset/reset.yaml
>
>  additionalProperties: false
>
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
20-dsi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra2=
0-dsi.yaml
> index 511cbe74e729..59e1dc0813e7 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.=
yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.=
yaml
> @@ -59,12 +59,12 @@ properties:
>      description: Should contain a phandle and a specifier specifying
>        which pads are used by this DSI output and need to be
>        calibrated. See nvidia,tegra114-mipi.yaml for details.
> -    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>
>    nvidia,ddc-i2c-bus:
>      description: phandle of an I2C controller used for DDC EDID
>        probing
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>    nvidia,hpd-gpio:
>      description: specifies a GPIO used for hotplug detection
> @@ -72,19 +72,19 @@ properties:
>
>    nvidia,edid:
>      description: supplies a binary EDID blob
> -    $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>
>    nvidia,panel:
>      description: phandle of a display panel
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>    nvidia,ganged-mode:
>      description: contains a phandle to a second DSI controller to
>        gang up with in order to support up to 8 data lanes
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>  allOf:
> -  - $ref: "../dsi-controller.yaml#"
> +  - $ref: ../dsi-controller.yaml#
>    - if:
>        properties:
>          compatible:
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
20-hdmi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra=
20-hdmi.yaml
> index f65e59cfffa7..f77197e4869f 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi=
.yaml
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi=
.yaml
> @@ -68,7 +68,7 @@ properties:
>    nvidia,ddc-i2c-bus:
>      description: phandle of an I2C controller used for DDC EDID
>        probing
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>    nvidia,hpd-gpio:
>      description: specifies a GPIO used for hotplug detection
> @@ -76,11 +76,11 @@ properties:
>
>    nvidia,edid:
>      description: supplies a binary EDID blob
> -    $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
>
>    nvidia,panel:
>      description: phandle of a display panel
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>
>    "#sound-dai-cells":
>      const: 0
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.ya=
ml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> index 5c7d2cbc4aac..4247280d6c3c 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> @@ -88,7 +88,7 @@ properties:
>            The DSS DPI output port node from video port 2
>
>    ti,am65x-oldi-io-ctrl:
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        phandle to syscon device node mapping OLDI IO_CTRL registers.
>        The mapped range should point to OLDI_DAT0_IO_CTRL, map it and
> diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc-disp=
lay.yaml b/Documentation/devicetree/bindings/display/xylon,logicvc-display.=
yaml
> index fc02c5d50ce4..87404d72ea37 100644
> --- a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yam=
l
> +++ b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yam=
l
> @@ -89,25 +89,25 @@ properties:
>      description: Display output colorspace (C_DISPLAY_COLOR_SPACE).
>
>    xylon,display-depth:
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      description: Display output depth (C_PIXEL_DATA_WIDTH).
>
>    xylon,row-stride:
> -    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    $ref: /schemas/types.yaml#/definitions/uint32
>      description: Fixed number of pixels in a framebuffer row (C_ROW_STRI=
DE).
>
>    xylon,dithering:
> -    $ref: "/schemas/types.yaml#/definitions/flag"
> +    $ref: /schemas/types.yaml#/definitions/flag
>      description: Dithering module is enabled (C_XCOLOR)
>
>    xylon,background-layer:
> -    $ref: "/schemas/types.yaml#/definitions/flag"
> +    $ref: /schemas/types.yaml#/definitions/flag
>      description: |
>        The last layer is used to display a black background (C_USE_BACKGR=
OUND).
>        The layer must still be registered.
>
>    xylon,layers-configurable:
> -    $ref: "/schemas/types.yaml#/definitions/flag"
> +    $ref: /schemas/types.yaml#/definitions/flag
>      description: |
>        Configuration of layers' size, position and offset is enabled
>        (C_USE_SIZE_POSITION).
> @@ -131,7 +131,7 @@ properties:
>              maxItems: 1
>
>            xylon,layer-depth:
> -            $ref: "/schemas/types.yaml#/definitions/uint32"
> +            $ref: /schemas/types.yaml#/definitions/uint32
>              description: Layer depth (C_LAYER_X_DATA_WIDTH).
>
>            xylon,layer-colorspace:
> @@ -151,19 +151,19 @@ properties:
>              description: Alpha mode for the layer (C_LAYER_X_ALPHA_MODE)=
.
>
>            xylon,layer-base-offset:
> -            $ref: "/schemas/types.yaml#/definitions/uint32"
> +            $ref: /schemas/types.yaml#/definitions/uint32
>              description: |
>                Offset in number of lines (C_LAYER_X_OFFSET) starting from=
 the
>                video RAM base (C_VMEM_BASEADDR), only for version 3.
>
>            xylon,layer-buffer-offset:
> -            $ref: "/schemas/types.yaml#/definitions/uint32"
> +            $ref: /schemas/types.yaml#/definitions/uint32
>              description: |
>                Offset in number of lines (C_BUFFER_*_OFFSET) starting fro=
m the
>                layer base offset for the second buffer used in double-buf=
fering.
>
>            xylon,layer-primary:
> -            $ref: "/schemas/types.yaml#/definitions/flag"
> +            $ref: /schemas/types.yaml#/definitions/flag
>              description: |
>                Layer should be registered as a primary plane (exactly one=
 is
>                required).
> --
> 2.39.2
>
