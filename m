Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8267415FC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjF1QDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:03:22 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:60598 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjF1QDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:03:18 -0400
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-783546553ddso3140439f.0;
        Wed, 28 Jun 2023 09:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687968198; x=1690560198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJLUn95bN50MLrjeQ6DO828FU9z5sEFCH/xfkgQbYuA=;
        b=PIhj+1OspXLxzcUs8nJdf57JVgYDKMNKGwtNIHE1cVd/wpJLeFsYfTj6nNTref0zLC
         DXepP5Qv/yXIuimTTCvxNgrlSRqu+vlulVbBzzkyMODqipjrLFZhp2v5XIBrakSnSGVM
         wVolM/4SMFQQf0M9DkcWh9jBpZqRI3IXDxn2TsyXg6NWx1MPDtG0a0nVR83v9STf0g9b
         V0NF6OeIe0FjzY3pmtK90UHyk529MNAGsKoPMUpuv+i3S0RipcU9l2E1QoQNO6ZZHgaO
         RFnbGNZDIj+bWlyu/5AJPr3lNOvaQ0OXnZ/CZRtrNlZoEz4xQCmaRLX3f8qo82slN/Sp
         gmEw==
X-Gm-Message-State: AC+VfDylv6UJEBboCwBaBF6FiP2geTh5p73+UvnSNLEiRrxW5jl3+g+1
        lw1DoaHCfBbPGrVA48j/pQ==
X-Google-Smtp-Source: ACHHUZ6vF8sM1dJa0P6obie4OfmrkmvRN/fLsN9zJuvW23NtjX0y+Mx398XLT2XoDTkIb/GX8K6mMw==
X-Received: by 2002:a05:6e02:4cb:b0:345:ba42:239d with SMTP id f11-20020a056e0204cb00b00345ba42239dmr5270270ils.9.1687968197659;
        Wed, 28 Jun 2023 09:03:17 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l29-20020a02cd9d000000b0040f91082a4fsm3197303jap.75.2023.06.28.09.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:03:16 -0700 (PDT)
Received: (nullmailer pid 553215 invoked by uid 1000);
        Wed, 28 Jun 2023 16:03:14 -0000
Date:   Wed, 28 Jun 2023 10:03:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v12 04/10] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
Message-ID: <20230628160314.GB542106-robh@kernel.org>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
 <20230217-topic-cpr3h-v12-4-1a4d050e1e67@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217-topic-cpr3h-v12-4-1a4d050e1e67@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 04:00:43PM +0200, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Add the bindings for the CPR3 driver to the documentation.

Bindings are for h/w, not drivers.

> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Konrad: Make binding check pass; update AGdR's email]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 289 +++++++++++++++++++++
>  1 file changed, 289 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> new file mode 100644
> index 000000000000..46b94dffaf85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> @@ -0,0 +1,289 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes

> +
> +title: Qualcomm Core Power Reduction v3/v4/Hardened (CPR3, CPR4, CPRh)
> +
> +description:
> +  CPR (Core Power Reduction) is a technology to reduce core power of a CPU
> +  (or another device). Each OPP of a device corresponds to a "corner" that
> +  has a range of valid voltages for a particular frequency.
> +  The CPR monitors dynamic factors such as temperature, etc. and suggests
> +  or (in the CPR-hardened case) applies voltage adjustments to save power
> +  and meet silicon characteristic requirements for a given chip unit.
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: CPRv3 controller
> +        items:
> +          - const: qcom,cpr3
> +      - description: CPRv4 controller
> +        items:
> +          - const: qcom,cpr4
> +      - description: CPRv4-Hardened controller
> +        items:
> +          - enum:
> +              - qcom,msm8998-cprh
> +              - qcom,sdm630-cprh
> +          - const: qcom,cprh
> +
> +  reg:
> +    description: Base address and size of the CPR controller(s)
> +    maxItems: 2

What is each entry?

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: CPR reference clock
> +
> +  vdd-supply:
> +    description: Autonomous Phase Control (APC) or other power supply
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  qcom,acc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to syscon for writing ACC settings
> +
> +  nvmem-cells:
> +    description: Cells containing the fuse corners and revision data
> +    maxItems: 32
> +
> +  nvmem-cell-names:
> +    maxItems: 32
> +
> +  operating-points-v2: true
> +
> +  power-domains: true

Need to define how many.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - operating-points-v2
> +  - "#power-domain-cells"
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,msm8998-cprh
> +    then:
> +      properties:
> +        nvmem-cell-names:
> +          items:
> +            - const: cpr_speed_bin
> +            - const: cpr_fuse_revision
> +            - const: cpr0_quotient1
> +            - const: cpr0_quotient2
> +            - const: cpr0_quotient3
> +            - const: cpr0_quotient4
> +            - const: cpr0_quotient_offset2
> +            - const: cpr0_quotient_offset3
> +            - const: cpr0_quotient_offset4
> +            - const: cpr0_init_voltage1
> +            - const: cpr0_init_voltage2
> +            - const: cpr0_init_voltage3
> +            - const: cpr0_init_voltage4
> +            - const: cpr0_ring_osc1
> +            - const: cpr0_ring_osc2
> +            - const: cpr0_ring_osc3
> +            - const: cpr0_ring_osc4
> +            - const: cpr1_quotient1
> +            - const: cpr1_quotient2
> +            - const: cpr1_quotient3
> +            - const: cpr1_quotient4
> +            - const: cpr1_quotient_offset2
> +            - const: cpr1_quotient_offset3
> +            - const: cpr1_quotient_offset4
> +            - const: cpr1_init_voltage1
> +            - const: cpr1_init_voltage2
> +            - const: cpr1_init_voltage3
> +            - const: cpr1_init_voltage4
> +            - const: cpr1_ring_osc1
> +            - const: cpr1_ring_osc2
> +            - const: cpr1_ring_osc3
> +            - const: cpr1_ring_osc4
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    cpus {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +
> +        cpu@0 {
> +            compatible = "qcom,kryo280";
> +            device_type = "cpu";
> +            reg = <0x0 0x0>;
> +            operating-points-v2 = <&cpu0_opp_table>;
> +            power-domains = <&apc_cprh 0>;
> +            power-domain-names = "cprh";

The name should be local to the device, not based on the provider.

Do you really need a name here with only 1? 

> +        };
> +
> +        cpu@100 {
> +            compatible = "qcom,kryo280";
> +            device_type = "cpu";
> +            reg = <0x0 0x100>;
> +            operating-points-v2 = <&cpu4_opp_table>;
> +            power-domains = <&apc_cprh 1>;
> +            power-domain-names = "cprh";
> +        };
> +    };
> +
> +    cpu0_opp_table: opp-table-cpu0 {
> +        compatible = "operating-points-v2";
> +        opp-shared;
> +
> +        opp-1843200000 {
> +            opp-hz = /bits/ 64 <1843200000>;
> +            required-opps = <&cprh_opp3>;
> +        };
> +
> +        opp-1094400000 {
> +            opp-hz = /bits/ 64 <1094400000>;
> +            required-opps = <&cprh_opp2>;
> +        };
> +
> +        opp-300000000 {
> +            opp-hz = /bits/ 64 <300000000>;
> +            required-opps = <&cprh_opp1>;
> +        };
> +    };
> +
> +    cpu4_opp_table: opp-table-cpu4 {
> +        compatible = "operating-points-v2";
> +        opp-shared;
> +
> +        opp-2208000000 {
> +            opp-hz = /bits/ 64 <2208000000>;
> +            required-opps = <&cprh_opp3>;
> +        };
> +
> +        opp-1113600000 {
> +            opp-hz = /bits/ 64 <1113600000>;
> +            required-opps = <&cprh_opp2>;
> +        };
> +
> +        opp-300000000 {
> +            opp-hz = /bits/ 64 <300000000>;
> +            required-opps = <&cprh_opp1>;
> +        };
> +    };
> +
> +    cprh_opp_table: opp-table-cprh {
> +        compatible = "operating-points-v2-qcom-level";
> +
> +        cprh_opp1: opp-1 {
> +            opp-level = <1>;
> +            qcom,opp-fuse-level = <1>;
> +            qcom,opp-cloop-vadj = <0>;
> +            qcom,opp-oloop-vadj = <0>;
> +        };
> +
> +        cprh_opp2: opp-2 {
> +            opp-level = <2>;
> +            qcom,opp-fuse-level = <2>;
> +            qcom,opp-cloop-vadj = <0>;
> +            qcom,opp-oloop-vadj = <0>;
> +        };
> +
> +        cprh_opp3: opp-3 {
> +            opp-level = <3>;
> +            qcom,opp-fuse-level = <2 3>;
> +            qcom,opp-cloop-vadj = <0>;
> +            qcom,opp-oloop-vadj = <0>;
> +        };
> +    };
> +
> +    apc_cprh: power-controller@179c8000 {
> +        compatible = "qcom,msm8998-cprh", "qcom,cprh";
> +        reg = <0x0179c8000 0x4000>, <0x0179c4000 0x4000>;
> +        clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
> +
> +        operating-points-v2 = <&cprh_opp_table>;
> +        #power-domain-cells = <1>;
> +
> +        nvmem-cells = <&cpr_efuse_speedbin>,
> +                      <&cpr_fuse_revision>,
> +                      <&cpr_quot0_pwrcl>,
> +                      <&cpr_quot1_pwrcl>,
> +                      <&cpr_quot2_pwrcl>,
> +                      <&cpr_quot3_pwrcl>,
> +                      <&cpr_quot_offset1_pwrcl>,
> +                      <&cpr_quot_offset2_pwrcl>,
> +                      <&cpr_quot_offset3_pwrcl>,
> +                      <&cpr_init_voltage0_pwrcl>,
> +                      <&cpr_init_voltage1_pwrcl>,
> +                      <&cpr_init_voltage2_pwrcl>,
> +                      <&cpr_init_voltage3_pwrcl>,
> +                      <&cpr_ro_sel0_pwrcl>,
> +                      <&cpr_ro_sel1_pwrcl>,
> +                      <&cpr_ro_sel2_pwrcl>,
> +                      <&cpr_ro_sel3_pwrcl>,
> +                      <&cpr_quot0_perfcl>,
> +                      <&cpr_quot1_perfcl>,
> +                      <&cpr_quot2_perfcl>,
> +                      <&cpr_quot3_perfcl>,
> +                      <&cpr_quot_offset1_perfcl>,
> +                      <&cpr_quot_offset2_perfcl>,
> +                      <&cpr_quot_offset3_perfcl>,
> +                      <&cpr_init_voltage0_perfcl>,
> +                      <&cpr_init_voltage1_perfcl>,
> +                      <&cpr_init_voltage2_perfcl>,
> +                      <&cpr_init_voltage3_perfcl>,
> +                      <&cpr_ro_sel0_perfcl>,
> +                      <&cpr_ro_sel1_perfcl>,
> +                      <&cpr_ro_sel2_perfcl>,
> +                      <&cpr_ro_sel3_perfcl>;
> +        nvmem-cell-names = "cpr_speed_bin",
> +                           "cpr_fuse_revision",
> +                           "cpr0_quotient1",
> +                           "cpr0_quotient2",
> +                           "cpr0_quotient3",
> +                           "cpr0_quotient4",
> +                           "cpr0_quotient_offset2",
> +                           "cpr0_quotient_offset3",
> +                           "cpr0_quotient_offset4",
> +                           "cpr0_init_voltage1",
> +                           "cpr0_init_voltage2",
> +                           "cpr0_init_voltage3",
> +                           "cpr0_init_voltage4",
> +                           "cpr0_ring_osc1",
> +                           "cpr0_ring_osc2",
> +                           "cpr0_ring_osc3",
> +                           "cpr0_ring_osc4",
> +                           "cpr1_quotient1",
> +                           "cpr1_quotient2",
> +                           "cpr1_quotient3",
> +                           "cpr1_quotient4",
> +                           "cpr1_quotient_offset2",
> +                           "cpr1_quotient_offset3",
> +                           "cpr1_quotient_offset4",
> +                           "cpr1_init_voltage1",
> +                           "cpr1_init_voltage2",
> +                           "cpr1_init_voltage3",
> +                           "cpr1_init_voltage4",
> +                           "cpr1_ring_osc1",
> +                           "cpr1_ring_osc2",
> +                           "cpr1_ring_osc3",
> +                           "cpr1_ring_osc4";
> +    };
> +...
> 
> -- 
> 2.41.0
> 
