Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F719665CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbjAKNdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbjAKNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9182653
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:30:13 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bq39so23557819lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/w5mnfwegvxUifBWo65TwkOen7/0JX0ji0bX3fCp/E=;
        b=NksKZfenUcQpH+A4P7KSNXdz/+x1z2iXGHCuEbgsxinffnTXOrJ4yGE2oo7Y8UWQgB
         2yPSebqFMFFQquZvTX/iwsfLisKQ5HvTKMT+Sirl6EP00T4PYtOV2iBrb8P0iZ6pC37S
         xB3wFQ6pxFC+XlIUS8VHd62BKrFoC/LQwZIqvDa9L5eIheoznSCWXvA/cYVLKRD+YSvp
         8LY/LsEJQi6lCJ9TVUeILrk+eS0gn0zHkPHmykPPzimMGlYrVxsinuYNOYzSTAoVi3Fl
         skH/Vq9+8zFh2noznb2jGjlBFKcMvpLbC+osIajXOcXz/uAJGttmLgQw1W/xpKoUbF9L
         J1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/w5mnfwegvxUifBWo65TwkOen7/0JX0ji0bX3fCp/E=;
        b=4b5HWSY2kXK+Gsy3cJVKnSwl4i+U2E3qabDyGgKJkZGEaSvJ6MDtPhaT3KSfmPgUyt
         dHTCaCO28Vt1U8Ul6Kc1JlEYt4Ippbn579ocigEBdlC560fzjZPF09V/5IarGbRP0UfL
         pJyfcdarue+UGRBDveG7Z9eq6iM61gt8xNeyX+Ppc/4WR6PtcKMaj6w5y7OLj1unsAhU
         rV/LBozsB8HrDHQzzWZDSVlMEzI3crBOuj4qQsXTCxmX7+9tXTVnoVHkj+SmybPAkKPL
         G9XZz3qjZiUu5PkrPaK6TDoYASYluBy+AeD7FP+g9sMC3oVti7DfWYBU6EswjhsqRI5S
         /37g==
X-Gm-Message-State: AFqh2kq2BDD5r4PDMYxvs70ul6eI793OSlgoeiko3zQ0gPqyOOu8+63O
        6rNN1eGZ/mhFfwbMNuQAFdaTiw==
X-Google-Smtp-Source: AMrXdXvQW3sRrURl9JGeOHgZqaxBtgmW1pQkjVmUj4AyQmuxfVXU7weiqBHal4ffyZmIR+3XPyONJQ==
X-Received: by 2002:a05:6512:308f:b0:4cb:1189:2862 with SMTP id z15-20020a056512308f00b004cb11892862mr16874265lfd.13.1673443812279;
        Wed, 11 Jan 2023 05:30:12 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id y19-20020ac24473000000b004946b549a19sm2735059lfl.45.2023.01.11.05.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 05:30:11 -0800 (PST)
Message-ID: <8463810e-a3bf-1303-6ca7-0945a5d6fc0d@linaro.org>
Date:   Wed, 11 Jan 2023 14:30:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v8 1/5] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
 <eebc18be-5be7-4c1f-74dd-b1427d2c101f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <eebc18be-5be7-4c1f-74dd-b1427d2c101f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.2023 03:18, Dmitry Baryshkov wrote:
> On 10/01/2023 20:54, Konrad Dybcio wrote:
>>
>>
>> On 10.01.2023 18:56, Konrad Dybcio wrote:
>>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>>
>>> Add the bindings for the CPR3 driver to the documentation.
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>> [Konrad: Add type reference to acc-syscon; update AGdR's email]
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>> Need to add
>>
>> qcom,opp-oloop-vadj
>> qcom,opp-cloop-vadj
> 
> And note that at least for CPR3 they are different between fusing revisions. I see that for CPRh (esp. for 8998v2) they are the same, but this is not the case for 8996 (CPR3).
If we both mean the "speed bin"-dependent values, the driver
reads the fuse value but currently does nothing. My guess would
be that Angelo omitted it, as - just like you pointed out - MSM8998
(and SDM660 for that matter) don't really use it. I suppose I could
take care of that in bindings by making this an array and handle it
separately in a different patchset, as the per-revision values
aren't *that much* different, and again aren't really of concern for
the first round of supported SoCs.

Konrad
> 
>>
>> in next revision.
>>
>> Konrad
>>>   .../bindings/soc/qcom/qcom,cpr3.yaml          | 242 ++++++++++++++++++
>>>   1 file changed, 242 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
>>> new file mode 100644
>>> index 000000000000..52e87061a04b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
>>> @@ -0,0 +1,242 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#"
>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>> +
>>> +title: Qualcomm Core Power Reduction v3/v4/Hardened (CPR3, CPR4, CPRh)
>>> +
>>> +description: |
>>> +  CPR (Core Power Reduction) is a technology to reduce core power on a CPU
>>> +  or other device. Each OPP of a device corresponds to a "corner" that has
>>> +  a range of valid voltages for a particular frequency. While the device is
>>> +  running at a particular frequency, CPR monitors dynamic factors such as
>>> +  temperature, etc. and suggests or, in the CPR-Hardened case performs,
>>> +  adjustments to the voltage to save power and meet silicon characteristic
>>> +  requirements.
>>> +
>>> +maintainers:
>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - description: CPRv3 controller
>>> +        items:
>>> +          - const: qcom,cpr3
>>> +      - description: CPRv4 controller
>>> +        items:
>>> +          - const: qcom,cpr4
>>> +      - description: CPRv4-Hardened controller
>>> +        items:
>>> +          - enum:
>>> +              - qcom,msm8998-cprh
>>> +              - qcom,sdm630-cprh
>>> +          - const: qcom,cprh
>>> +
>>> +  reg:
>>> +    description: Base address and size of the CPR controller(s)
>>> +    minItems: 1
>>> +    maxItems: 2
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: "ref"
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: CPR reference clock
>>> +
>>> +  vdd-supply:
>>> +    description: Autonomous Phase Control (APC) or other power supply
>>> +
>>> +  '#power-domain-cells':
>>> +    const: 1
>>> +
>>> +  acc-syscon:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: phandle to syscon for writing ACC settings
>>> +
>>> +  nvmem-cells:
>>> +    description: Cells containing the fuse corners and revision data
>>> +    minItems: 10
>>> +    maxItems: 32
>>> +
>>> +  nvmem-cell-names:
>>> +    minItems: 10
>>> +    maxItems: 32
>>> +
>>> +  operating-points-v2: true
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clock-names
>>> +  - clocks
>>> +  - "#power-domain-cells"
>>> +  - nvmem-cells
>>> +  - nvmem-cell-names
>>> +  - operating-points-v2
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    cpus {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <0>;
>>> +
>>> +        cpu@0 {
>>> +            compatible = "qcom,kryo280";
>>> +            device_type = "cpu";
>>> +            reg = <0x0 0x0>;
>>> +            operating-points-v2 = <&cpu_gold_opp_table>;
>>> +            power-domains = <&apc_cprh 0>;
>>> +            power-domain-names = "cprh";
>>> +        };
>>> +
>>> +        cpu@100 {
>>> +            compatible = "qcom,kryo280";
>>> +            device_type = "cpu";
>>> +            reg = <0x0 0x0>;
>>> +            operating-points-v2 = <&cpu_silver_opp_table>;
>>> +            power-domains = <&apc_cprh 1>;
>>> +            power-domain-names = "cprh";
>>> +        };
>>> +    };
>>> +
>>> +    cpu_gold_opp_table: opp-table-gold {
>>> +        compatible = "operating-points-v2";
>>> +        opp-shared;
>>> +
>>> +        opp-2208000000 {
>>> +            opp-hz = /bits/ 64 <2208000000>;
>>> +            required-opps = <&cprh_opp3>;
>>> +        };
>>> +        opp-1113600000 {
>>> +            opp-hz = /bits/ 64 <1113600000>;
>>> +            required-opps = <&cprh_opp2>;
>>> +        };
>>> +        opp-300000000 {
>>> +            opp-hz = /bits/ 64 <300000000>;
>>> +            required-opps = <&cprh_opp1>;
>>> +        };
>>> +    };
>>> +
>>> +    cpu_silver_opp_table: opp-table-silver {
>>> +        compatible = "operating-points-v2";
>>> +        opp-shared;
>>> +
>>> +        opp-1843200000 {
>>> +            opp-hz = /bits/ 64 <1843200000>;
>>> +            required-opps = <&cprh_opp3>;
>>> +        };
>>> +        opp-1094400000 {
>>> +            opp-hz = /bits/ 64 <1094400000>;
>>> +            required-opps = <&cprh_opp2>;
>>> +        };
>>> +        opp-300000000 {
>>> +            opp-hz = /bits/ 64 <300000000>;
>>> +            required-opps = <&cprh_opp1>;
>>> +        };
>>> +    };
>>> +
>>> +    cprh_opp_table: opp-table-cprh {
>>> +        compatible = "operating-points-v2-qcom-level";
>>> +
>>> +        cprh_opp1: opp1 {
>>> +            opp-level = <1>;
>>> +            qcom,opp-fuse-level = <1>;
>>> +        };
>>> +        cprh_opp2: opp2 {
>>> +            opp-level = <2>;
>>> +            qcom,opp-fuse-level = <2>;
>>> +        };
>>> +        cprh_opp3: opp3 {
>>> +            opp-level = <3>;
>>> +            qcom,opp-fuse-level = <2 3>;
>>> +        };
>>> +    };
>>> +
>>> +    apc_cprh: power-controller@179c8000 {
>>> +        compatible = "qcom,msm8998-cprh", "qcom,cprh";
>>> +        reg = <0x0179c8000 0x4000>, <0x0179c4000 0x4000>;
>>> +        clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
>>> +        clock-names = "ref";
>>> +
>>> +        #power-domain-cells = <1>;
>>> +        operating-points-v2 = <&cprh_opp_table>;
>>> +
>>> +        nvmem-cells = <&cpr_efuse_speedbin>,
>>> +                      <&cpr_fuse_revision>,
>>> +                      <&cpr_quot0_pwrcl>,
>>> +                      <&cpr_quot1_pwrcl>,
>>> +                      <&cpr_quot2_pwrcl>,
>>> +                      <&cpr_quot3_pwrcl>,
>>> +                      <&cpr_quot_offset1_pwrcl>,
>>> +                      <&cpr_quot_offset2_pwrcl>,
>>> +                      <&cpr_quot_offset3_pwrcl>,
>>> +                      <&cpr_init_voltage0_pwrcl>,
>>> +                      <&cpr_init_voltage1_pwrcl>,
>>> +                      <&cpr_init_voltage2_pwrcl>,
>>> +                      <&cpr_init_voltage3_pwrcl>,
>>> +                      <&cpr_ro_sel0_pwrcl>,
>>> +                      <&cpr_ro_sel1_pwrcl>,
>>> +                      <&cpr_ro_sel2_pwrcl>,
>>> +                      <&cpr_ro_sel3_pwrcl>,
>>> +                      <&cpr_quot0_perfcl>,
>>> +                      <&cpr_quot1_perfcl>,
>>> +                      <&cpr_quot2_perfcl>,
>>> +                      <&cpr_quot3_perfcl>,
>>> +                      <&cpr_quot_offset1_perfcl>,
>>> +                      <&cpr_quot_offset2_perfcl>,
>>> +                      <&cpr_quot_offset3_perfcl>,
>>> +                      <&cpr_init_voltage0_perfcl>,
>>> +                      <&cpr_init_voltage1_perfcl>,
>>> +                      <&cpr_init_voltage2_perfcl>,
>>> +                      <&cpr_init_voltage3_perfcl>,
>>> +                      <&cpr_ro_sel0_perfcl>,
>>> +                      <&cpr_ro_sel1_perfcl>,
>>> +                      <&cpr_ro_sel2_perfcl>,
>>> +                      <&cpr_ro_sel3_perfcl>;
>>> +
>>> +        nvmem-cell-names = "cpr_speed_bin",
>>> +                           "cpr_fuse_revision",
>>> +                           "cpr0_quotient1",
>>> +                           "cpr0_quotient2",
>>> +                           "cpr0_quotient3",
>>> +                           "cpr0_quotient4",
>>> +                           "cpr0_quotient_offset2",
>>> +                           "cpr0_quotient_offset3",
>>> +                           "cpr0_quotient_offset4",
>>> +                           "cpr0_init_voltage1",
>>> +                           "cpr0_init_voltage2",
>>> +                           "cpr0_init_voltage3",
>>> +                           "cpr0_init_voltage4",
>>> +                           "cpr0_ring_osc1",
>>> +                           "cpr0_ring_osc2",
>>> +                           "cpr0_ring_osc3",
>>> +                           "cpr0_ring_osc4",
>>> +                           "cpr1_quotient1",
>>> +                           "cpr1_quotient2",
>>> +                           "cpr1_quotient3",
>>> +                           "cpr1_quotient4",
>>> +                           "cpr1_quotient_offset2",
>>> +                           "cpr1_quotient_offset3",
>>> +                           "cpr1_quotient_offset4",
>>> +                           "cpr1_init_voltage1",
>>> +                           "cpr1_init_voltage2",
>>> +                           "cpr1_init_voltage3",
>>> +                           "cpr1_init_voltage4",
>>> +                           "cpr1_ring_osc1",
>>> +                           "cpr1_ring_osc2",
>>> +                           "cpr1_ring_osc3",
>>> +                           "cpr1_ring_osc4";
>>> +    };
>>> +...
> 
