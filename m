Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5943674168E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjF1Qhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjF1Qhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:37:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD6A10D7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:37:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so1528699e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687970249; x=1690562249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hLHc4J+ADpWt2Xa11myEzpN7gGtfSIaY83Llc3ZVuYY=;
        b=CtpiHpBifLDAU22SDCdg6Bgqhdcvwd2FQ2MllqXHDC80kE5xyDpR0hGVR5HOCX4B69
         ZTXvUzKYd2TU25qPpv50p05AuIXPNfBRxY6oi9JJXgF2mi5HsBvK4l/wtpmJEvMPfu4q
         lDo9gbVGMD0XcQ8Lnm1u/kjW8E2hik69Lx9ypt6rA3priPFLSCPM5aYBscKQaQzScJTL
         KuHAWPhyiJFjEji56eAr3Bdr5xK6KjH4O+mWcO1lRQboHUPOu5QyIA136evuXASt3fAZ
         /vE93xsq04m7hKm47gajKAnZTqfF0A+6xn7adfFpjM0TGEhV1GnkDb1nMg4RDFxLOCE5
         Q2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687970249; x=1690562249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLHc4J+ADpWt2Xa11myEzpN7gGtfSIaY83Llc3ZVuYY=;
        b=c4v1xlLYxxbHSl6jXaqGHVZkf2HJnHoBub6QPRdywJcRtZJ+4MUeN5LQd7iEU2vyy+
         BZHuh1/oLYisxPDgd3IkpCDUkxvsoICfTAdLHaFPItjCeb5Qx4Eeg1fIgagAfeTEcI2N
         YeRc61QSu4BAk1JU+zHFePBk6Hp4G2LO1fOkMpvXngp8OqnaQ5yka1yWqjr3vkUIfoZO
         auGQsFs/6SwjC1jhCNRIvG1nLZjy599s3I0MPYfCrob1Z/MRpfoZXWgpyBE7Ll6njT8m
         y6vU0p0zxsLoj/ZAkejY3627z4K4msh5G4gb1CGGTs9ERgaQH6vzTznL0iCOseiL2vO4
         BvWw==
X-Gm-Message-State: AC+VfDzTr9GYVfYfMZgJ0NIOBxraPM3lenTVSc6nYRdlcdujYe5UpCkD
        +Vov0GG5EA6jC9zrI4WieTQg8yBkRcGFMI+RQec=
X-Google-Smtp-Source: ACHHUZ7zamKZbS1JJTrdfPo6WzNyQZw2Q/ionQs1ttufrvxqW8nIJpDqTbOu+cqEpQB51y6oYObDkA==
X-Received: by 2002:a05:6512:31d4:b0:4f7:6462:e036 with SMTP id j20-20020a05651231d400b004f76462e036mr796240lfe.11.1687970249311;
        Wed, 28 Jun 2023 09:37:29 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id l7-20020a19c207000000b004fb5bbc47cdsm1583424lfc.307.2023.06.28.09.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 09:37:28 -0700 (PDT)
Message-ID: <cae642aa-026b-735a-d614-0e1343b5c30d@linaro.org>
Date:   Wed, 28 Jun 2023 18:37:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v12 04/10] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
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
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
 <20230217-topic-cpr3h-v12-4-1a4d050e1e67@linaro.org>
 <20230628160314.GB542106-robh@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230628160314.GB542106-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.2023 18:03, Rob Herring wrote:
> On Wed, Jun 28, 2023 at 04:00:43PM +0200, Konrad Dybcio wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
>> Add the bindings for the CPR3 driver to the documentation.
> 
> Bindings are for h/w, not drivers.
This shows how ancient this patch is, from before it was
common knowledge ;)

> 
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> [Konrad: Make binding check pass; update AGdR's email]
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 289 +++++++++++++++++++++
>>  1 file changed, 289 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
>> new file mode 100644
>> index 000000000000..46b94dffaf85
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
>> @@ -0,0 +1,289 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#"
>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> 
> Drop quotes
Ack

> 
>> +
>> +title: Qualcomm Core Power Reduction v3/v4/Hardened (CPR3, CPR4, CPRh)
>> +
>> +description:
>> +  CPR (Core Power Reduction) is a technology to reduce core power of a CPU
>> +  (or another device). Each OPP of a device corresponds to a "corner" that
>> +  has a range of valid voltages for a particular frequency.
>> +  The CPR monitors dynamic factors such as temperature, etc. and suggests
>> +  or (in the CPR-hardened case) applies voltage adjustments to save power
>> +  and meet silicon characteristic requirements for a given chip unit.
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
>> +    maxItems: 2
> 
> What is each entry?
I thought the description was clear enough, but I'll add items:.

> 
>> +
>> +  interrupts:
>> +    maxItems: 1
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
>> +  qcom,acc:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: phandle to syscon for writing ACC settings
>> +
>> +  nvmem-cells:
>> +    description: Cells containing the fuse corners and revision data
>> +    maxItems: 32
>> +
>> +  nvmem-cell-names:
>> +    maxItems: 32
>> +
>> +  operating-points-v2: true
>> +
>> +  power-domains: true
> 
> Need to define how many.
Ack

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - operating-points-v2
>> +  - "#power-domain-cells"
>> +  - nvmem-cells
>> +  - nvmem-cell-names
>> +
>> +additionalProperties: false
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,msm8998-cprh
>> +    then:
>> +      properties:
>> +        nvmem-cell-names:
>> +          items:
>> +            - const: cpr_speed_bin
>> +            - const: cpr_fuse_revision
>> +            - const: cpr0_quotient1
>> +            - const: cpr0_quotient2
>> +            - const: cpr0_quotient3
>> +            - const: cpr0_quotient4
>> +            - const: cpr0_quotient_offset2
>> +            - const: cpr0_quotient_offset3
>> +            - const: cpr0_quotient_offset4
>> +            - const: cpr0_init_voltage1
>> +            - const: cpr0_init_voltage2
>> +            - const: cpr0_init_voltage3
>> +            - const: cpr0_init_voltage4
>> +            - const: cpr0_ring_osc1
>> +            - const: cpr0_ring_osc2
>> +            - const: cpr0_ring_osc3
>> +            - const: cpr0_ring_osc4
>> +            - const: cpr1_quotient1
>> +            - const: cpr1_quotient2
>> +            - const: cpr1_quotient3
>> +            - const: cpr1_quotient4
>> +            - const: cpr1_quotient_offset2
>> +            - const: cpr1_quotient_offset3
>> +            - const: cpr1_quotient_offset4
>> +            - const: cpr1_init_voltage1
>> +            - const: cpr1_init_voltage2
>> +            - const: cpr1_init_voltage3
>> +            - const: cpr1_init_voltage4
>> +            - const: cpr1_ring_osc1
>> +            - const: cpr1_ring_osc2
>> +            - const: cpr1_ring_osc3
>> +            - const: cpr1_ring_osc4
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
>> +            operating-points-v2 = <&cpu0_opp_table>;
>> +            power-domains = <&apc_cprh 0>;
>> +            power-domain-names = "cprh";
> 
> The name should be local to the device, not based on the provider.
> 
> Do you really need a name here with only 1? 
Yes, cpufreq drivers need to dance around the genpd and OPP frameworks,
which requires a name.

Konrad
> 
>> +        };
>> +
>> +        cpu@100 {
>> +            compatible = "qcom,kryo280";
>> +            device_type = "cpu";
>> +            reg = <0x0 0x100>;
>> +            operating-points-v2 = <&cpu4_opp_table>;
>> +            power-domains = <&apc_cprh 1>;
>> +            power-domain-names = "cprh";
>> +        };
>> +    };
>> +
>> +    cpu0_opp_table: opp-table-cpu0 {
>> +        compatible = "operating-points-v2";
>> +        opp-shared;
>> +
>> +        opp-1843200000 {
>> +            opp-hz = /bits/ 64 <1843200000>;
>> +            required-opps = <&cprh_opp3>;
>> +        };
>> +
>> +        opp-1094400000 {
>> +            opp-hz = /bits/ 64 <1094400000>;
>> +            required-opps = <&cprh_opp2>;
>> +        };
>> +
>> +        opp-300000000 {
>> +            opp-hz = /bits/ 64 <300000000>;
>> +            required-opps = <&cprh_opp1>;
>> +        };
>> +    };
>> +
>> +    cpu4_opp_table: opp-table-cpu4 {
>> +        compatible = "operating-points-v2";
>> +        opp-shared;
>> +
>> +        opp-2208000000 {
>> +            opp-hz = /bits/ 64 <2208000000>;
>> +            required-opps = <&cprh_opp3>;
>> +        };
>> +
>> +        opp-1113600000 {
>> +            opp-hz = /bits/ 64 <1113600000>;
>> +            required-opps = <&cprh_opp2>;
>> +        };
>> +
>> +        opp-300000000 {
>> +            opp-hz = /bits/ 64 <300000000>;
>> +            required-opps = <&cprh_opp1>;
>> +        };
>> +    };
>> +
>> +    cprh_opp_table: opp-table-cprh {
>> +        compatible = "operating-points-v2-qcom-level";
>> +
>> +        cprh_opp1: opp-1 {
>> +            opp-level = <1>;
>> +            qcom,opp-fuse-level = <1>;
>> +            qcom,opp-cloop-vadj = <0>;
>> +            qcom,opp-oloop-vadj = <0>;
>> +        };
>> +
>> +        cprh_opp2: opp-2 {
>> +            opp-level = <2>;
>> +            qcom,opp-fuse-level = <2>;
>> +            qcom,opp-cloop-vadj = <0>;
>> +            qcom,opp-oloop-vadj = <0>;
>> +        };
>> +
>> +        cprh_opp3: opp-3 {
>> +            opp-level = <3>;
>> +            qcom,opp-fuse-level = <2 3>;
>> +            qcom,opp-cloop-vadj = <0>;
>> +            qcom,opp-oloop-vadj = <0>;
>> +        };
>> +    };
>> +
>> +    apc_cprh: power-controller@179c8000 {
>> +        compatible = "qcom,msm8998-cprh", "qcom,cprh";
>> +        reg = <0x0179c8000 0x4000>, <0x0179c4000 0x4000>;
>> +        clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
>> +
>> +        operating-points-v2 = <&cprh_opp_table>;
>> +        #power-domain-cells = <1>;
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
>>
>> -- 
>> 2.41.0
>>
