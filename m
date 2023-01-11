Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90B666519E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjAKCTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjAKCTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:19:02 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25C3F43
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:19:00 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so21369965lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asDB78Km0hvRZa6y1SBnYkOAU3xVfFOXptoAVBqCrsw=;
        b=fB/cWNr7NflfYD1Gq1iiG92V0UVF8aavF9rQNgsdkvBRl51OyaSneFS+KGoaQMbbEN
         C1nw7pAYhXyANPE1sUsQEuJv2NrrYLrPKEV82wl1mz76XPGqJbg8lGbyFTlK2EGhiR+/
         5pUkX+kyBBklw71pGYtZ9AVQ5g65lI4rnpHx7d466Hk08fTW1nvJ3cJHQBs1LKvqXzD/
         vjYNttbHgxk9WLht6m2XF0QwEZWECMrqXO4Wn2MENZzJicsgjBLGLMOuf9Y1QSwHmjxg
         kQ1ZnsNxLffdRsOr4xCyO52r8YPDJ0mtR9itdk2LFBXMbrXUhrH7sEQcKJEqx9sQfQYL
         cmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asDB78Km0hvRZa6y1SBnYkOAU3xVfFOXptoAVBqCrsw=;
        b=4jXqhgoShGIAq63GgXSbZOu+KhilzyMq1RRANJomzedC8+eC5EN8Za1+/+PJLIuK8f
         YBN+C5Od3PaktqvAV5XI8axmU/mFqdmp3jOFWwp1Ll9NuhUGccV8Mq5eopw/6/ihv1Y2
         DE5P8h5QUNKZPd982BfnWLmy8azTj/xORsGCG9jsdnczKWQ5micMnDX0FkRqjY1I3yz9
         Np5pzI9POT4ED16FZfISVo10I0gL3t0AnvD6V6nYGtoyLfosJ9Pd+rpIo7wH6HkCnM0D
         oJ0mwpxNH7jsWeyTMLSvVrfI8OZBWFZks7s4uxMElDCpxKOpmhHFcUlQBUr/I27QRBxl
         0NzQ==
X-Gm-Message-State: AFqh2krtVPCizIyC1JZhui6FsdtXeh2oAirKdi6weW40evuAcJu7a/zr
        vbOW9tnU4+LPoZliCmcOoCXSPA==
X-Google-Smtp-Source: AMrXdXv0YC4hOCU42sTcSPyG108xeE5jKT4uds+jrunWJVpVcSqE/v852OYleYzWwia1zk2DczT0UA==
X-Received: by 2002:a05:6512:150b:b0:4ca:e66e:43c8 with SMTP id bq11-20020a056512150b00b004cae66e43c8mr20364701lfb.14.1673403539030;
        Tue, 10 Jan 2023 18:18:59 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q17-20020a19a411000000b004cc82b70809sm1466201lfc.150.2023.01.10.18.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 18:18:58 -0800 (PST)
Message-ID: <eebc18be-5be7-4c1f-74dd-b1427d2c101f@linaro.org>
Date:   Wed, 11 Jan 2023 04:18:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v8 1/5] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        angelogioacchino.delregno@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110175605.1240188-1-konrad.dybcio@linaro.org>
 <20230110175605.1240188-2-konrad.dybcio@linaro.org>
 <889c3bce-8b88-3a0d-5aa0-1000d3dd26cd@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <889c3bce-8b88-3a0d-5aa0-1000d3dd26cd@linaro.org>
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

On 10/01/2023 20:54, Konrad Dybcio wrote:
> 
> 
> On 10.01.2023 18:56, Konrad Dybcio wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
>> Add the bindings for the CPR3 driver to the documentation.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> [Konrad: Add type reference to acc-syscon; update AGdR's email]
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> Need to add
> 
> qcom,opp-oloop-vadj
> qcom,opp-cloop-vadj

And note that at least for CPR3 they are different between fusing 
revisions. I see that for CPRh (esp. for 8998v2) they are the same, but 
this is not the case for 8996 (CPR3).

> 
> in next revision.
> 
> Konrad
>>   .../bindings/soc/qcom/qcom,cpr3.yaml          | 242 ++++++++++++++++++
>>   1 file changed, 242 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
>> new file mode 100644
>> index 000000000000..52e87061a04b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
>> @@ -0,0 +1,242 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>> +
>> +title: Qualcomm Core Power Reduction v3/v4/Hardened (CPR3, CPR4, CPRh)
>> +
>> +description: |
>> +  CPR (Core Power Reduction) is a technology to reduce core power on a CPU
>> +  or other device. Each OPP of a device corresponds to a "corner" that has
>> +  a range of valid voltages for a particular frequency. While the device is
>> +  running at a particular frequency, CPR monitors dynamic factors such as
>> +  temperature, etc. and suggests or, in the CPR-Hardened case performs,
>> +  adjustments to the voltage to save power and meet silicon characteristic
>> +  requirements.
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - description: CPRv3 controller
>> +        items:
>> +          - const: qcom,cpr3
>> +      - description: CPRv4 controller
>> +        items:
>> +          - const: qcom,cpr4
>> +      - description: CPRv4-Hardened controller
>> +        items:
>> +          - enum:
>> +              - qcom,msm8998-cprh
>> +              - qcom,sdm630-cprh
>> +          - const: qcom,cprh
>> +
>> +  reg:
>> +    description: Base address and size of the CPR controller(s)
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: "ref"
>> +
>> +  clocks:
>> +    items:
>> +      - description: CPR reference clock
>> +
>> +  vdd-supply:
>> +    description: Autonomous Phase Control (APC) or other power supply
>> +
>> +  '#power-domain-cells':
>> +    const: 1
>> +
>> +  acc-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: phandle to syscon for writing ACC settings
>> +
>> +  nvmem-cells:
>> +    description: Cells containing the fuse corners and revision data
>> +    minItems: 10
>> +    maxItems: 32
>> +
>> +  nvmem-cell-names:
>> +    minItems: 10
>> +    maxItems: 32
>> +
>> +  operating-points-v2: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clock-names
>> +  - clocks
>> +  - "#power-domain-cells"
>> +  - nvmem-cells
>> +  - nvmem-cell-names
>> +  - operating-points-v2
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    cpus {
>> +        #address-cells = <2>;
>> +        #size-cells = <0>;
>> +
>> +        cpu@0 {
>> +            compatible = "qcom,kryo280";
>> +            device_type = "cpu";
>> +            reg = <0x0 0x0>;
>> +            operating-points-v2 = <&cpu_gold_opp_table>;
>> +            power-domains = <&apc_cprh 0>;
>> +            power-domain-names = "cprh";
>> +        };
>> +
>> +        cpu@100 {
>> +            compatible = "qcom,kryo280";
>> +            device_type = "cpu";
>> +            reg = <0x0 0x0>;
>> +            operating-points-v2 = <&cpu_silver_opp_table>;
>> +            power-domains = <&apc_cprh 1>;
>> +            power-domain-names = "cprh";
>> +        };
>> +    };
>> +
>> +    cpu_gold_opp_table: opp-table-gold {
>> +        compatible = "operating-points-v2";
>> +        opp-shared;
>> +
>> +        opp-2208000000 {
>> +            opp-hz = /bits/ 64 <2208000000>;
>> +            required-opps = <&cprh_opp3>;
>> +        };
>> +        opp-1113600000 {
>> +            opp-hz = /bits/ 64 <1113600000>;
>> +            required-opps = <&cprh_opp2>;
>> +        };
>> +        opp-300000000 {
>> +            opp-hz = /bits/ 64 <300000000>;
>> +            required-opps = <&cprh_opp1>;
>> +        };
>> +    };
>> +
>> +    cpu_silver_opp_table: opp-table-silver {
>> +        compatible = "operating-points-v2";
>> +        opp-shared;
>> +
>> +        opp-1843200000 {
>> +            opp-hz = /bits/ 64 <1843200000>;
>> +            required-opps = <&cprh_opp3>;
>> +        };
>> +        opp-1094400000 {
>> +            opp-hz = /bits/ 64 <1094400000>;
>> +            required-opps = <&cprh_opp2>;
>> +        };
>> +        opp-300000000 {
>> +            opp-hz = /bits/ 64 <300000000>;
>> +            required-opps = <&cprh_opp1>;
>> +        };
>> +    };
>> +
>> +    cprh_opp_table: opp-table-cprh {
>> +        compatible = "operating-points-v2-qcom-level";
>> +
>> +        cprh_opp1: opp1 {
>> +            opp-level = <1>;
>> +            qcom,opp-fuse-level = <1>;
>> +        };
>> +        cprh_opp2: opp2 {
>> +            opp-level = <2>;
>> +            qcom,opp-fuse-level = <2>;
>> +        };
>> +        cprh_opp3: opp3 {
>> +            opp-level = <3>;
>> +            qcom,opp-fuse-level = <2 3>;
>> +        };
>> +    };
>> +
>> +    apc_cprh: power-controller@179c8000 {
>> +        compatible = "qcom,msm8998-cprh", "qcom,cprh";
>> +        reg = <0x0179c8000 0x4000>, <0x0179c4000 0x4000>;
>> +        clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
>> +        clock-names = "ref";
>> +
>> +        #power-domain-cells = <1>;
>> +        operating-points-v2 = <&cprh_opp_table>;
>> +
>> +        nvmem-cells = <&cpr_efuse_speedbin>,
>> +                      <&cpr_fuse_revision>,
>> +                      <&cpr_quot0_pwrcl>,
>> +                      <&cpr_quot1_pwrcl>,
>> +                      <&cpr_quot2_pwrcl>,
>> +                      <&cpr_quot3_pwrcl>,
>> +                      <&cpr_quot_offset1_pwrcl>,
>> +                      <&cpr_quot_offset2_pwrcl>,
>> +                      <&cpr_quot_offset3_pwrcl>,
>> +                      <&cpr_init_voltage0_pwrcl>,
>> +                      <&cpr_init_voltage1_pwrcl>,
>> +                      <&cpr_init_voltage2_pwrcl>,
>> +                      <&cpr_init_voltage3_pwrcl>,
>> +                      <&cpr_ro_sel0_pwrcl>,
>> +                      <&cpr_ro_sel1_pwrcl>,
>> +                      <&cpr_ro_sel2_pwrcl>,
>> +                      <&cpr_ro_sel3_pwrcl>,
>> +                      <&cpr_quot0_perfcl>,
>> +                      <&cpr_quot1_perfcl>,
>> +                      <&cpr_quot2_perfcl>,
>> +                      <&cpr_quot3_perfcl>,
>> +                      <&cpr_quot_offset1_perfcl>,
>> +                      <&cpr_quot_offset2_perfcl>,
>> +                      <&cpr_quot_offset3_perfcl>,
>> +                      <&cpr_init_voltage0_perfcl>,
>> +                      <&cpr_init_voltage1_perfcl>,
>> +                      <&cpr_init_voltage2_perfcl>,
>> +                      <&cpr_init_voltage3_perfcl>,
>> +                      <&cpr_ro_sel0_perfcl>,
>> +                      <&cpr_ro_sel1_perfcl>,
>> +                      <&cpr_ro_sel2_perfcl>,
>> +                      <&cpr_ro_sel3_perfcl>;
>> +
>> +        nvmem-cell-names = "cpr_speed_bin",
>> +                           "cpr_fuse_revision",
>> +                           "cpr0_quotient1",
>> +                           "cpr0_quotient2",
>> +                           "cpr0_quotient3",
>> +                           "cpr0_quotient4",
>> +                           "cpr0_quotient_offset2",
>> +                           "cpr0_quotient_offset3",
>> +                           "cpr0_quotient_offset4",
>> +                           "cpr0_init_voltage1",
>> +                           "cpr0_init_voltage2",
>> +                           "cpr0_init_voltage3",
>> +                           "cpr0_init_voltage4",
>> +                           "cpr0_ring_osc1",
>> +                           "cpr0_ring_osc2",
>> +                           "cpr0_ring_osc3",
>> +                           "cpr0_ring_osc4",
>> +                           "cpr1_quotient1",
>> +                           "cpr1_quotient2",
>> +                           "cpr1_quotient3",
>> +                           "cpr1_quotient4",
>> +                           "cpr1_quotient_offset2",
>> +                           "cpr1_quotient_offset3",
>> +                           "cpr1_quotient_offset4",
>> +                           "cpr1_init_voltage1",
>> +                           "cpr1_init_voltage2",
>> +                           "cpr1_init_voltage3",
>> +                           "cpr1_init_voltage4",
>> +                           "cpr1_ring_osc1",
>> +                           "cpr1_ring_osc2",
>> +                           "cpr1_ring_osc3",
>> +                           "cpr1_ring_osc4";
>> +    };
>> +...

-- 
With best wishes
Dmitry

