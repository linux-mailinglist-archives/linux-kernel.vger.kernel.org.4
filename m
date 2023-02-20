Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CF269D615
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 23:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjBTWBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 17:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjBTWBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 17:01:32 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD56115;
        Mon, 20 Feb 2023 14:01:29 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id w7-20020a056830280700b0068dbf908574so489384otu.8;
        Mon, 20 Feb 2023 14:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYEMrB66hD4BzXsOvteWpNCRzSSm60RnJUw/8QW1s/M=;
        b=lOVA4xuKFDE/nA4+XxLRDmD4R7BGwlxyZF8lMZ76MKKWzhF3bMGqTcNORmgIUqo6t5
         SO+yEQwr7azyAVR3luqI0N9SqKLWKf3H3yt4NkoCHp9y9NUNqNR8VjEv5GTRD7McKuoy
         v+MbpOnb4REVCDOXV3YXuOWnYNjbu6isFrk5ghj8Wa2UIIJgpPw3kzND/dai3It5Wf+k
         4aSwydamOKTdF9MZT2ciPlHEPmTMbNxur2IxWN1OK3IuopXNe5MNpVfI/JR7/MF8pES7
         5Krc+zITWmhFrtVBhyQCa7djWQq/Sl0iq+SX0YlT12vfqkVkR8EfhWrFl9ZaTPYXW4ws
         8Aqg==
X-Gm-Message-State: AO0yUKVCybMLh4R8nNP9tUuWtmezfyU1zCOL9rtl1huOAdj0dF+tbOQu
        byWRMnja9dRdJfSpvlKsdA==
X-Google-Smtp-Source: AK7set/idW04u+zyWIwDW99FjHPbai96y+ek+DXhbKWo3yv9Wjjaa3uxqP3vboL2f1adNmTsxiAZdg==
X-Received: by 2002:a9d:3f3:0:b0:68b:caa8:6ef1 with SMTP id f106-20020a9d03f3000000b0068bcaa86ef1mr1288539otf.12.1676930488868;
        Mon, 20 Feb 2023 14:01:28 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dg7-20020a056830480700b00684a10970adsm5384093otb.16.2023.02.20.14.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:01:28 -0800 (PST)
Received: (nullmailer pid 405998 invoked by uid 1000);
        Mon, 20 Feb 2023 22:01:27 -0000
Date:   Mon, 20 Feb 2023 16:01:27 -0600
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
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v10 3/6] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
Message-ID: <20230220220127.GA398518-robh@kernel.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
 <20230217-topic-cpr3h-v10-3-67aed8fdfa61@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217-topic-cpr3h-v10-3-67aed8fdfa61@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 12:08:26PM +0100, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Add the bindings for the CPR3 driver to the documentation.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Konrad: Make binding check pass; update AGdR's email]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 299 +++++++++++++++++++++
>  1 file changed, 299 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> new file mode 100644
> index 000000000000..18366c1e58b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> @@ -0,0 +1,299 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Core Power Reduction v3/v4/Hardened (CPR3, CPR4, CPRh)
> +
> +description: |

Don't need '|'

> +  CPR (Core Power Reduction) is a technology to reduce core power on a CPU
> +  or other device. Each OPP of a device corresponds to a "corner" that has
> +  a range of valid voltages for a particular frequency. While the device is
> +  running at a particular frequency, CPR monitors dynamic factors such as
> +  temperature, etc. and suggests or, in the CPR-Hardened case performs,
> +  adjustments to the voltage to save power and meet silicon characteristic
> +  requirements.
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
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: "ref"

Drop quotes. Or perhaps the whole property as you don't need -names when 
there is only 1.

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
> +  acc-syscon:

qcom,acc

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to syscon for writing ACC settings
> +
> +  nvmem-cells:
> +    description: Cells containing the fuse corners and revision data
> +    minItems: 10
> +    maxItems: 32
> +
> +  nvmem-cell-names:
> +    minItems: 10
> +    maxItems: 32
> +
> +  operating-points-v2: true
> +
> +  power-domains: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
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
> +            - const: "cpr_speed_bin"
> +            - const: "cpr_fuse_revision"
> +            - const: "cpr0_quotient1"
> +            - const: "cpr0_quotient2"
> +            - const: "cpr0_quotient3"
> +            - const: "cpr0_quotient4"
> +            - const: "cpr0_quotient_offset2"
> +            - const: "cpr0_quotient_offset3"
> +            - const: "cpr0_quotient_offset4"
> +            - const: "cpr0_init_voltage1"
> +            - const: "cpr0_init_voltage2"
> +            - const: "cpr0_init_voltage3"
> +            - const: "cpr0_init_voltage4"
> +            - const: "cpr0_ring_osc1"
> +            - const: "cpr0_ring_osc2"
> +            - const: "cpr0_ring_osc3"
> +            - const: "cpr0_ring_osc4"
> +            - const: "cpr1_quotient1"
> +            - const: "cpr1_quotient2"
> +            - const: "cpr1_quotient3"
> +            - const: "cpr1_quotient4"
> +            - const: "cpr1_quotient_offset2"
> +            - const: "cpr1_quotient_offset3"
> +            - const: "cpr1_quotient_offset4"
> +            - const: "cpr1_init_voltage1"
> +            - const: "cpr1_init_voltage2"
> +            - const: "cpr1_init_voltage3"
> +            - const: "cpr1_init_voltage4"
> +            - const: "cpr1_ring_osc1"
> +            - const: "cpr1_ring_osc2"
> +            - const: "cpr1_ring_osc3"
> +            - const: "cpr1_ring_osc4"

Drop quotes.

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
> +            operating-points-v2 = <&cpu_gold_opp_table>;
> +            power-domains = <&apc_cprh 0>;
> +            power-domain-names = "cprh";
> +        };
> +
> +        cpu@100 {
> +            compatible = "qcom,kryo280";
> +            device_type = "cpu";
> +            reg = <0x0 0x100>;
> +            operating-points-v2 = <&cpu_silver_opp_table>;
> +            power-domains = <&apc_cprh 1>;
> +            power-domain-names = "cprh";
> +        };
> +    };
> +
> +    cpu0_opp_table: opp-table-cpu0 {

This label and what cpu@0 point to don't match.

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
> +        clock-names = "ref";
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
> 2.39.1
> 
