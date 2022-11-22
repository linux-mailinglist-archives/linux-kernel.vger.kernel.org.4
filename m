Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03207634B50
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbiKVXoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiKVXoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:44:14 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3CCC72C6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:44:12 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p8so25794874lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kh8Ee2itXlT1W2A9GPivBdVAR6dBJYKfAjyordieSas=;
        b=tUnDceBneI/xb6U6ZgifgmFPCbzdTXEzVGzuZx+4EC6gfwGS7n4q6wcsqioozllw8n
         hlZ13cZzQ3gR76HOdyyuOnyxKqYtq4qrs/5TKtrVQQDTDycCjzcojAxfqP9di1Yjt1gO
         Bhc/KkTu1TA3CW5QHzq5mclTJfOFzXn9wHo3ioAsqhfrtZLCTl5oaJ/9DwNNybU+qvE5
         aDRI+ztBpyAwGEMWEh/8UHf6atPhcZxEjZYp+Zt6wFFf7o99K6uZ1U7IOU7HMMOfN76J
         C3mkFbXMx22CtqSioUcT27lWxQlYbMDKPCRTRpjozJjV1Ueu0Hlj5Y9xjx2nCgF+IHHm
         oAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kh8Ee2itXlT1W2A9GPivBdVAR6dBJYKfAjyordieSas=;
        b=PGbxIZ0wotjeUOgkCW3S23LokR0rbCuwEKuUWvsuq5U2r1vHL+YtsVjJ48TSpoKlAp
         INAE+FI/5moBBx+fd7h8BucEil5uDx846+xoySkDQLxMm1SxjpAhwqmgxjW0o8Kw/JNd
         ApptLmYg7EM0K07+9ObAVBMqVnXVJETqt9F/flximTYJgt62rgDKnLWipZv+TW7wHypt
         /DigYt44KYD5xyAfquXXtbHJSP9c7uPey1LYcrzEePFYmNFbv/CDYcAvlsZKBkxtRsat
         mHI3lONLj4y1BDFVAhY5SIlRNqUaXV5bfHoRO7NJqgSkJHiFO6XptkXzoSWLvoUTA8NZ
         JY4Q==
X-Gm-Message-State: ANoB5pn5MlX1OsVGEyHjehu/m1BgqA7PtxEwueD3GEJhBSGZTnFvWLy3
        mh4w9Q4CRfdCyVEqHN5Hu1BK+g==
X-Google-Smtp-Source: AA0mqf7KeM67mfMhxnKbiHYPFesXCdeJFMp6RXRQ1IjKk15muxSFfoiJJfAVbp/Q2Sv4C0u+nPG82g==
X-Received: by 2002:ac2:51b6:0:b0:4ae:8510:646f with SMTP id f22-20020ac251b6000000b004ae8510646fmr8965170lfk.432.1669160650397;
        Tue, 22 Nov 2022 15:44:10 -0800 (PST)
Received: from ?IPV6:2001:14ba:a302:8a1a::1? (dzpbkzhtyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:a302:8a1a::1])
        by smtp.gmail.com with ESMTPSA id z27-20020a2ebe1b000000b0027760138c53sm2002063ljq.72.2022.11.22.15.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 15:44:09 -0800 (PST)
Message-ID: <425eb237-ac31-2c32-3ad4-542048eee344@linaro.org>
Date:   Wed, 23 Nov 2022 01:44:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: add support for the display
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
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
References: <20221120133744.24808-1-a39.skl@gmail.com>
 <20221120133744.24808-2-a39.skl@gmail.com>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221120133744.24808-2-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2022 15:37, Adam Skladowski wrote:
> Add DPU and MDSS schemas to describe MDSS and DPU blocks on the Qualcomm
> SM6115 platform.
> Configuration for DSI/PHY is shared with QCM2290 so compatibles are reused.
> Lack of dsi phy supply in example is intended
> due to fact on qcm2290, sm6115 and sm6125
> this phy is supplied via power domain, not regulator.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>   .../bindings/display/msm/qcom,sm6115-dpu.yaml |  87 ++++++++
>   .../display/msm/qcom,sm6115-mdss.yaml         | 187 ++++++++++++++++++
>   2 files changed, 274 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
>   create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml
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
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +      - const: iface
> +      - const: core
> +      - const: lut
> +      - const: rot
> +      - const: vsync

Please add:

required:
   - compatible
   - reg
   - reg-names
   - clocks
   - clock-names

Per Krzysztof's request these requirements are migrating from dpu-common 
to individual dpu schemas

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

required:
   compatible

The same story

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

phy-names are being phased out, please drop this line.

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

-- 
With best wishes
Dmitry

