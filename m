Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DD4741501
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjF1PbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:31:01 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:46531 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjF1Pa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:30:57 -0400
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-78363cc070aso1223539f.1;
        Wed, 28 Jun 2023 08:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966256; x=1690558256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0niG6qG4DqT/r1g966+PJqlCiFTcEvd91aBP54ZlXY8=;
        b=b4LnUw2LaBWDCgY3OpBlU1MYfpSC0vinpvaVA+GrzGWqB8gRLL6OtQAHAGGNpOiZvQ
         DAZ95rDOtNy1fzQsvfOUMERqz8xdMmeCoel5KKbDqRqzyQcVcPie8TdAZy1nWXpDDeTk
         9sZp5ycs53blQ1zEy8BPwjnkXG0cecSNc5dRhUudzpjkDmP0Web02jb+t76T+j8v7oJh
         KrXOEEZBO7JYKXeSAa1qVOdlwsaSKruE1ErAXjtj9Iob0rBYKhwczEDRy3gtkPrKvWHT
         PmaZuYQJq0E3mEd8oC4BZPMJ7VBuYyQU2OfZ8RWGpe0y4NkIpWbJXIv5hO86HMGaQmJ/
         KZfw==
X-Gm-Message-State: AC+VfDww2pAx+pMTpeHalosLe4GdHjbaFx0agNrdt+4c0IFJOHmQ0QOr
        FblSpALWOBgxasNcPF7x5w==
X-Google-Smtp-Source: ACHHUZ6LB+/gdmYyZRvgWzuIiTCMmzPhOqUZFcSycE37KQbVQhh90RKEhAkscudg8T/mbyxLPZic4g==
X-Received: by 2002:a6b:7218:0:b0:777:a970:b382 with SMTP id n24-20020a6b7218000000b00777a970b382mr39010929ioc.18.1687966256004;
        Wed, 28 Jun 2023 08:30:56 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id dp1-20020a0566381c8100b0042afa9b038csm220072jab.49.2023.06.28.08.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 08:30:55 -0700 (PDT)
Received: (nullmailer pid 514857 invoked by uid 1000);
        Wed, 28 Jun 2023 15:30:51 -0000
Date:   Wed, 28 Jun 2023 09:30:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 07/15] dt-bindings: display/msm: Add SM6125 MDSS
Message-ID: <20230628153051.GA507988-robh@kernel.org>
References: <20230627-sm6125-dpu-v2-0-03e430a2078c@somainline.org>
 <20230627-sm6125-dpu-v2-7-03e430a2078c@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-sm6125-dpu-v2-7-03e430a2078c@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:14:22PM +0200, Marijn Suijten wrote:
> Document the SM6125 MDSS.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  .../bindings/display/msm/qcom,sm6125-mdss.yaml     | 217 +++++++++++++++++++++
>  1 file changed, 217 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
> new file mode 100644
> index 000000000000..2525482424cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
> @@ -0,0 +1,217 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sm6125-mdss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM6125 Display MDSS
> +
> +maintainers:
> +  - Marijn Suijten <marijn.suijten@somainline.org>
> +
> +description:
> +  SM6125 MSM Mobile Display Subsystem (MDSS), which encapsulates sub-blocks
> +  like DPU display controller, DSI and DP interfaces etc.
> +
> +$ref: /schemas/display/msm/mdss-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,sm6125-mdss
> +
> +  clocks:
> +    items:
> +      - description: Display AHB clock from gcc
> +      - description: Display AHB clock
> +      - description: Display core clock
> +
> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: ahb
> +      - const: core
> +
> +  iommus:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    maxItems: 2
> +
> +patternProperties:
> +  "^display-controller@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        const: qcom,sm6125-dpu
> +
> +  "^dsi@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        items:
> +          - const: qcom,sm6125-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl
> +
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        const: qcom,sm6125-dsi-phy-14nm
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,dispcc-sm6125.h>
> +    #include <dt-bindings/clock/qcom,gcc-sm6125.h>
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    display-subsystem@5e00000 {
> +        compatible = "qcom,sm6125-mdss";
> +        reg = <0x05e00000 0x1000>;
> +        reg-names = "mdss";
> +
> +        interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +
> +        clocks = <&gcc GCC_DISP_AHB_CLK>,
> +                 <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
> +        clock-names = "iface",
> +                      "ahb",
> +                      "core";
> +
> +        power-domains = <&dispcc MDSS_GDSC>;
> +
> +        iommus = <&apps_smmu 0x400 0x0>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges;
> +
> +        status = "disabled";

Examples should not be disabled. Drop.

> +
> +        display-controller@5e01000 {
> +            compatible = "qcom,sm6125-dpu";
> +            reg = <0x05e01000 0x83208>,
> +                  <0x05eb0000 0x2008>;
> +            reg-names = "mdp", "vbif";
> +
> +            interrupt-parent = <&mdss>;
> +            interrupts = <0>;
> +
> +            clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                     <&dispcc DISP_CC_MDSS_ROT_CLK>,
> +                     <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
> +                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
> +                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +            clock-names = "bus",
> +                          "iface",
> +                          "rot",
> +                          "lut",
> +                          "core",
> +                          "vsync";
> +            assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
> +            assigned-clock-rates = <19200000>;
> +
> +            operating-points-v2 = <&mdp_opp_table>;
> +            power-domains = <&rpmpd SM6125_VDDCX>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    dpu_intf1_out: endpoint {
> +                        remote-endpoint = <&mdss_dsi0_in>;
> +                    };
> +                };
> +            };
> +        };
> +
> +        dsi@5e94000 {
> +            compatible = "qcom,sm6125-dsi-ctrl", "qcom,mdss-dsi-ctrl";
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
> +            assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
> +                      <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
> +            assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
> +
> +            operating-points-v2 = <&dsi_opp_table>;
> +            power-domains = <&rpmpd SM6125_VDDCX>;
> +
> +            phys = <&mdss_dsi0_phy>;
> +            phy-names = "dsi";
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            status = "disabled";

Ditto.

> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    mdss_dsi0_in: endpoint {
> +                        remote-endpoint = <&dpu_intf1_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    mdss_dsi0_out: endpoint {
> +                    };
> +                };
> +            };
> +        };
> +
> +        phy@5e94400 {
> +            compatible = "qcom,sm6125-dsi-phy-14nm";
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
> +            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +                     <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +            clock-names = "iface",
> +                          "ref";
> +
> +            required-opps = <&rpmpd_opp_svs>;
> +            power-domains = <&rpmpd SM6125_VDDMX>;
> +
> +            status = "disabled";

Ditto

> +        };
> +    };
> +...
> 
> -- 
> 2.41.0
> 
