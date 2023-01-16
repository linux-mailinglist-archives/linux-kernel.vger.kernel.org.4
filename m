Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C888D66BAC2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjAPJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjAPJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:43:34 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21AA14E92
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:43:32 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j17so41944784lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q54XghDh6LEV5nDRF1yWYyzk+NPiWIoK4IXLMUOslgk=;
        b=G3V/Th2E7Oqux2H64GI/K6iU/r6ephA2awTM+3I/NBQHnZ0X7j6h6yjCxsfo59zAmo
         cbkju3OYso+FOD5HoY75lC/ZqvydY/b5ZQG+3AD9yEQEZl5EnZFthyTGzQdz0ElwBFPg
         07mA+w+LOEgs5KxBURhum5uINoXNlzWdSh//MFDMkN8Hn+617XqJX4yAWKgCK89A9u0W
         HwlGIXOVQ4tKRIIcsLbZ3hqT46mM3SiuX6gbgU6HiPkvVRRCSkO7r9H+fdV3vde3Vq0E
         A0MstR2gXCMgNFVdbMdKxkYs2JoOmE3tlEpsxIhxN/Bg/TW+dkQzLuTGkdqewdFkhRzB
         DQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q54XghDh6LEV5nDRF1yWYyzk+NPiWIoK4IXLMUOslgk=;
        b=3lyf9ndSypOeQEmYbLid0ebFnUJ5jaFgjGbIhmDM54YcXEqw+BWUPg1tyUwynmHOxx
         fck9YS2ZMxN+dCAmWliJWrFsZdWz0yEgzuAH69at4fgcr48kqe3mOiij9mnWdJugfjyz
         HqaqSf7+iefT4vDrwR6MKfnbctuNnOB11beD68WQr9wjxb+IH+51pVrDJn/R3bRHlJGj
         83/yCbTsNS1ZsE1zt5sFyUJcEB+T4vITUvkz5ebALXVvQbueRXkj1CudFZJGt79vXRu0
         ma7jRNnVkGc0y8fLDIOpCklg2dAhuzR9jstxYPyraQwnXbJ+pi65Atc8hMR3dMnSFiic
         pnlA==
X-Gm-Message-State: AFqh2krzFjeKO9bOHOu+CszTaTmHUbT6YljaOzUsyZZuc6T6s5PT1k6j
        kYzUi/h1ltmL0yedbXf75RDYIg==
X-Google-Smtp-Source: AMrXdXvs8ogM161eKJcroFgKCaaiSWvXX60RURXI54Rt7bSPDvE0rX6+u+OtkGOrs2KXylj6/6Yfuw==
X-Received: by 2002:ac2:43a4:0:b0:4cb:3a60:65cb with SMTP id t4-20020ac243a4000000b004cb3a6065cbmr12819980lfl.6.1673862209583;
        Mon, 16 Jan 2023 01:43:29 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id y19-20020a0565123f1300b00498fc3d4cfdsm4953242lfa.189.2023.01.16.01.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 01:43:29 -0800 (PST)
Message-ID: <c6028860-7fab-f3db-98ac-8192d30e3ceb@linaro.org>
Date:   Mon, 16 Jan 2023 10:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 2/6] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
Content-Language: en-US
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230116093845.72621-1-konrad.dybcio@linaro.org>
 <20230116093845.72621-3-konrad.dybcio@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230116093845.72621-3-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.01.2023 10:38, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Add the bindings for the CPR3 driver to the documentation.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
Eh... forgive me, I said I dropped it in the cover letter,
but forgot to do actually it in the patch after all..

Konrad
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> [Konrad: Make binding check pass; update AGdR's email]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/soc/qcom/qcom,cpr3.yaml          | 314 ++++++++++++++++++
>  1 file changed, 314 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> new file mode 100644
> index 000000000000..eb11af375e54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> @@ -0,0 +1,314 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Core Power Reduction v3/v4/Hardened (CPR3, CPR4, CPRh)
> +
> +description: |
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
> +    else:
> +      items:
> +        - const: "cpr_quotient_offset1"
> +        - const: "cpr_quotient_offset2"
> +        - const: "cpr_quotient_offset3"
> +        - const: "cpr_init_voltage1"
> +        - const: "cpr_init_voltage2"
> +        - const: "cpr_init_voltage3"
> +        - const: "cpr_quotient1"
> +        - const: "cpr_quotient2"
> +        - const: "cpr_quotient3"
> +        - const: "cpr_ring_osc1"
> +        - const: "cpr_ring_osc2"
> +        - const: "cpr_ring_osc3"
> +        - const: "cpr_fuse_revision"
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
