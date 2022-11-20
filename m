Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBA66314FB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiKTPlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKTPlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:41:10 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8718613E1F;
        Sun, 20 Nov 2022 07:41:09 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13bd2aea61bso11299935fac.0;
        Sun, 20 Nov 2022 07:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z98zIiP0XDelHv1JIf2EEK8sreW5/hVd5nm6SS85PHU=;
        b=6jdU8CsPcLIkjjeA8AuwTWVPgT+Q2BDH0iPBgmXepXL3i90THCt+gZazrbJhEJSQrg
         UXnVYF7nQeN9TMNDh/jD92PKeEkyg+oJEhKJlOjoI1clOqjyOQi+ypTFGpqY7damD7Ke
         TA6UJ7ODgWx2c29R8l1WWk/R11behyN9DX6ESxGdIelgDMJbCgeZ9QJ316iVYbknJJ4V
         wTeI0QkuY2C0fuPcw0MKroEAI2CVhVQsJ2PF9OxVp8FeJlRucVeYtpW71PRfjEf/XpbK
         7cZ6Y0sNillSN/F2V1Li/VwxcP/Shb26idJ27qz2E2UjXgJBsXKXgM8YdXmVCNmv9aHE
         rq4g==
X-Gm-Message-State: ANoB5pkbDWaQEWwamy3pooXoJWlgsvksaBPTpkglb3Y1gk/MqJyUy9qZ
        P5ZMYV7+IlIXfKclaNm/ZA==
X-Google-Smtp-Source: AA0mqf7OrdBl8Mlxc2qixX2M/45/9DvJs3ecMsJTSK7aaPrwd7Hc+YbMMymxtJabWv1n+UmKCSrGNA==
X-Received: by 2002:a05:6871:82a:b0:142:d7cf:b291 with SMTP id q42-20020a056871082a00b00142d7cfb291mr1248699oap.78.1668958868739;
        Sun, 20 Nov 2022 07:41:08 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f6:1a48:29f6:113d:266f:a78e])
        by smtp.gmail.com with ESMTPSA id e1-20020a4aaac1000000b0049fb2dafac3sm3376248oon.2.2022.11.20.07.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 07:41:08 -0800 (PST)
Received: (nullmailer pid 3107010 invoked by uid 1000);
        Sun, 20 Nov 2022 15:41:07 -0000
Date:   Sun, 20 Nov 2022 09:41:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Adam Skladowski <a_skl39@protonmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Jason Wang <wangborong@cdjrlc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: add support for the display
Message-ID: <20221120154107.GA3103648-robh@kernel.org>
References: <20221120133744.24808-1-a39.skl@gmail.com>
 <20221120133744.24808-2-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120133744.24808-2-a39.skl@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 02:37:36PM +0100, Adam Skladowski wrote:
> Add DPU and MDSS schemas to describe MDSS and DPU blocks on the Qualcomm
> SM6115 platform.
> Configuration for DSI/PHY is shared with QCM2290 so compatibles are reused.
> Lack of dsi phy supply in example is intended
> due to fact on qcm2290, sm6115 and sm6125
> this phy is supplied via power domain, not regulator.

The subject needs 'sm6115' somewhere.

> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  .../bindings/display/msm/qcom,sm6115-dpu.yaml |  87 ++++++++
>  .../display/msm/qcom,sm6115-mdss.yaml         | 187 ++++++++++++++++++
>  2 files changed, 274 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
> new file mode 100644
> index 000000000000..cc77675ec4f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6115-dpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display DPU dt properties for SM6115 target
> +
> +maintainers:
> +  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> +
> +$ref: /schemas/display/msm/dpu-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,sm6115-dpu
> +
> +  reg:
> +    items:
> +      - description: Address offset and size for mdp register set
> +      - description: Address offset and size for vbif register set

Drop 'Address offset and size for'.

s/mdp/MDP/ ?
s/vbif/VBIF/ ?

> +
> +  reg-names:
> +    items:
> +      - const: mdp
> +      - const: vbif
> +
> +  clocks:
> +    items:
> +      - description: Display AXI clock from gcc
> +      - description: Display AHB clock from dispcc
> +      - description: Display core clock from dispcc
> +      - description: Display lut clock from dispcc
> +      - description: Display rotator clock from dispcc
> +      - description: Display vsync clock from dispcc

Source of the clock is outside the scope of the binding.

> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: iface
> +      - const: core
> +      - const: lut
> +      - const: rot
> +      - const: vsync
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,sm6115-dispcc.h>
> +    #include <dt-bindings/clock/qcom,gcc-sm6115.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    display-controller@5e01000 {
> +        compatible = "qcom,sm6115-dpu";
> +        reg = <0x05e01000 0x8f000>,
> +              <0x05eb0000 0x2008>;
> +        reg-names = "mdp", "vbif";
> +
> +        clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +                 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                 <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +                 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +                 <&dispcc DISP_CC_MDSS_ROT_CLK>,
> +                 <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +        clock-names = "bus", "iface", "core", "lut", "rot", "vsync";
> +
> +        operating-points-v2 = <&mdp_opp_table>;
> +        power-domains = <&rpmpd SM6115_VDDCX>;
> +
> +        interrupt-parent = <&mdss>;
> +        interrupts = <0>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                endpoint {
> +                    remote-endpoint = <&dsi0_in>;
> +                };
> +            };
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
> new file mode 100644
> index 000000000000..af721aa05b22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
> @@ -0,0 +1,187 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6115-mdss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM6115 Display MDSS
> +
> +maintainers:
> +  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> +
> +description:
> +  Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
> +  sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
> +  are mentioned for SM6115 target.
> +
> +$ref: /schemas/display/msm/mdss-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,sm6115-mdss
> +
> +  clocks:
> +    items:
> +      - description: Display AHB clock from gcc
> +      - description: Display AXI clock
> +      - description: Display core clock
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: bus
> +      - const: core
> +
> +  iommus:
> +    maxItems: 2
> +
> +patternProperties:
> +  "^display-controller@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        const: qcom,sm6115-dpu
> +
> +  "^dsi@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        const: qcom,dsi-ctrl-6g-qcm2290
> +
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        const: qcom,dsi-phy-14nm-2290
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,sm6115-dispcc.h>
> +    #include <dt-bindings/clock/qcom,gcc-sm6115.h>
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    mdss@5e00000 {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        compatible = "qcom,sm6115-mdss";
> +        reg = <0x05e00000 0x1000>;
> +        reg-names = "mdss";
> +        power-domains = <&dispcc MDSS_GDSC>;
> +        clocks = <&gcc GCC_DISP_AHB_CLK>,
> +                 <&gcc GCC_DISP_HF_AXI_CLK>,
> +                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +        clock-names = "iface", "bus", "core";
> +
> +        interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +
> +        iommus = <&apps_smmu 0x420 0x2>,
> +                 <&apps_smmu 0x421 0x0>;
> +        ranges;
> +
> +        display-controller@5e01000 {
> +            compatible = "qcom,sm6115-dpu";
> +            reg = <0x05e01000 0x8f000>,
> +                  <0x05eb0000 0x2008>;
> +            reg-names = "mdp", "vbif";
> +
> +            clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +                     <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +                     <&dispcc DISP_CC_MDSS_ROT_CLK>,
> +                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +            clock-names = "bus", "iface", "core", "lut", "rot", "vsync";
> +
> +            operating-points-v2 = <&mdp_opp_table>;
> +            power-domains = <&rpmpd SM6115_VDDCX>;
> +
> +            interrupt-parent = <&mdss>;
> +            interrupts = <0>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    dpu_intf1_out: endpoint {
> +                        remote-endpoint = <&dsi0_in>;
> +                    };
> +                };
> +            };
> +        };
> +
> +        dsi@5e94000 {
> +            compatible = "qcom,dsi-ctrl-6g-qcm2290";
> +            reg = <0x05e94000 0x400>;
> +            reg-names = "dsi_ctrl";
> +
> +            interrupt-parent = <&mdss>;
> +            interrupts = <4>;
> +
> +            clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
> +                     <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
> +                     <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
> +                     <&dispcc DISP_CC_MDSS_ESC0_CLK>,
> +                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                     <&gcc GCC_DISP_HF_AXI_CLK>;
> +            clock-names = "byte",
> +                          "byte_intf",
> +                          "pixel",
> +                          "core",
> +                          "iface",
> +                          "bus";
> +            assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
> +            assigned-clock-parents = <&dsi0_phy 0>, <&dsi0_phy 1>;
> +
> +            operating-points-v2 = <&dsi_opp_table>;
> +            power-domains = <&rpmpd SM6115_VDDCX>;
> +            phys = <&dsi0_phy>;
> +            phy-names = "dsi";
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    dsi0_in: endpoint {
> +                        remote-endpoint = <&dpu_intf1_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    dsi0_out: endpoint {
> +                    };
> +                };
> +            };
> +        };
> +
> +        dsi0_phy: phy@5e94400 {
> +            compatible = "qcom,dsi-phy-14nm-2290";
> +            reg = <0x05e94400 0x100>,
> +                  <0x05e94500 0x300>,
> +                  <0x05e94800 0x188>;
> +            reg-names = "dsi_phy",
> +                        "dsi_phy_lane",
> +                        "dsi_pll";
> +
> +            #clock-cells = <1>;
> +            #phy-cells = <0>;
> +
> +            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +            clock-names = "iface", "ref";
> +        };
> +    };
> +...
> -- 
> 2.25.1
> 
> 
