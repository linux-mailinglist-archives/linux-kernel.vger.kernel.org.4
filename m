Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497206E215C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDNK5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNK5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:57:19 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C436C49E7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:57:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q26so10648015lfe.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681469836; x=1684061836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hx+ApbyVhyoF5Fk1VzYu+PCx1Wrur1xu+HZmmrLoA5w=;
        b=gTP9touwaAw8C5Xu8gxRaZ4SqzQ7pf8icA0pzVld3459wVZGI9TuqNP3kKUMlA1WxS
         JIcdFiZ9CODjxEr5e3gT54f4VcgltMiNRPMywE++Za60bfJOuj+MdO2yclXTbpGUZmia
         5iid/p1LDeIg0dDihFLR/394qSnyc3qmBnt5CiprKub+yxkdf6w0T2Mxt/GKdQgsz5vg
         XrqoleOanMVqsqKlBwM6sRiU6MFwJAZ2nWLH3C2RE18Il3QhiuPh57E+ostRlXA4rvcC
         dqymlaugmHk8oD+EpOIProX98DIA9tDJ0A6qJL1I474BsPiO5U0QMq8OJLsSjALx7z4E
         jPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681469836; x=1684061836;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hx+ApbyVhyoF5Fk1VzYu+PCx1Wrur1xu+HZmmrLoA5w=;
        b=Hmw9l+5PhgK4GY4Of27tCMYqLhPT9bzvDBK8NYx8+LjBYyxHXMjAzlzOZXF0DtHRxg
         gphLbx+1vmsBxX1W/6UzCCqkz/OYMg6kNTFRH5ktciwz7JrGkEX6XsCUfC/szWoWYwbj
         W51/hnm7BLEoj8HFs7DqeOSu+3DIK72CckdXO1V2mpbtvgF3GbnGrj7or0KgrBEHsnT7
         nSKjc3cCVFS7KSVSinPISZlmeLR8df2v0Q3GPsrLmTdInLdSI/05Le+9vB1GloIkcqGi
         8h0uucikRSCil6gyNOrXmEWBaCBWmxf3BDuksVVqn2fEDzRubYxgPCyMvQyb8isWL9uT
         sYmw==
X-Gm-Message-State: AAQBX9fxjsK4wPtoqjid2wvbIqBKIgZsudY0vitZVS/6pbzOyT4mtLCE
        DZT/SuIDYG5Eft3KuVoMfr80lg==
X-Google-Smtp-Source: AKy350bjSKHb4pppNHvFNeiuVLmFpt8+I5Om0SfQTuacXFquY1hLIWfh0fzndxo0O+kASuHRwRJRrw==
X-Received: by 2002:a05:6512:6d4:b0:4eb:4157:5704 with SMTP id u20-20020a05651206d400b004eb41575704mr2670218lff.29.1681469835957;
        Fri, 14 Apr 2023 03:57:15 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id x28-20020ac25ddc000000b004d863fa8681sm749227lfq.173.2023.04.14.03.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 03:57:15 -0700 (PDT)
Message-ID: <411c8a57-9c9e-c799-91c4-5338f9d15799@linaro.org>
Date:   Fri, 14 Apr 2023 12:57:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V12 3/4] arm64: dts: qcom: Add support for ipq9574 SoC and
 RDP433 variant
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, geert+renesas@glider.be,
        rafal@milecki.pl, nfraprado@collabora.com, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230410135948.11970-1-quic_devipriy@quicinc.com>
 <20230410135948.11970-4-quic_devipriy@quicinc.com>
 <a599d157-002f-26ef-5f31-a3fb0925dfba@linaro.org>
 <da6051dd-1a29-a356-9d6a-a35f20b23fb9@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <da6051dd-1a29-a356-9d6a-a35f20b23fb9@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.04.2023 12:01, Devi Priya wrote:
> 
> 
> On 4/13/2023 2:16 AM, Konrad Dybcio wrote:
>>
>>
>> On 10.04.2023 15:59, Devi Priya wrote:
>>> Add initial device tree support for Qualcomm IPQ9574 SoC and
>>> Reference Design Platform(RDP) 433 which is based on IPQ9574
>>> family of SoCs
>>>
>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>> ---
>>
>>> +    soc: soc@0 {
>>> +        compatible = "simple-bus";
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>>> +        ranges = <0 0 0 0xffffffff>;
>> this is equal to:
>>
>> ranges;
> 
> Konrad, on updating (ranges = <0 0 0 0xffffffff>; --> ranges;)
> we see the below warnings:
> arch/arm64/boot/dts/qcom/ipq9574.dtsi:103.3-10: Warning (ranges_format):
> /soc@0:ranges: empty "ranges" property but its #address-cells (1)
> differs from / (2)
> arch/arm64/boot/dts/qcom/ipq9574.dtsi:103.3-10: Warning (ranges_format): /soc@0:ranges: empty "ranges" property but its #size-cells (1) differs
> from / (2)
> 
> Looks like, empty ranges property isn't supported if the parent and
> child address spaces are non-identical.
> Would you suggest to retain the ranges as such?
> (ranges = <0 0 0 0xffffffff>;)
> 
> Thanks,
> Devi Priya
Oh right, you have address/size cells = 2 at the top level.
Forget about this change.

Konrad
>>
>> Could you fix that up when applying, Bjorn, should there be
>> no other issues?
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
> Thank you!
>> Konrad
>>
>>> +
>>> +        tlmm: pinctrl@1000000 {
>>> +            compatible = "qcom,ipq9574-tlmm";
>>> +            reg = <0x01000000 0x300000>;
>>> +            interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>>> +            gpio-controller;
>>> +            #gpio-cells = <2>;
>>> +            gpio-ranges = <&tlmm 0 0 65>;
>>> +            interrupt-controller;
>>> +            #interrupt-cells = <2>;
>>> +
>>> +            uart2_pins: uart2-state {
>>> +                pins = "gpio34", "gpio35";
>>> +                function = "blsp2_uart";
>>> +                drive-strength = <8>;
>>> +                bias-disable;
>>> +            };
>>> +        };
>>> +
>>> +        gcc: clock-controller@1800000 {
>>> +            compatible = "qcom,ipq9574-gcc";
>>> +            reg = <0x01800000 0x80000>;
>>> +            clocks = <&xo_board_clk>,
>>> +                 <&sleep_clk>,
>>> +                 <0>,
>>> +                 <0>,
>>> +                 <0>,
>>> +                 <0>,
>>> +                 <0>;
>>> +            #clock-cells = <1>;
>>> +            #reset-cells = <1>;
>>> +            #power-domain-cells = <1>;
>>> +        };
>>> +
>>> +        sdhc_1: mmc@7804000 {
>>> +            compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
>>> +            reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
>>> +            reg-names = "hc", "cqhci";
>>> +
>>> +            interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>>> +                     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>>> +            interrupt-names = "hc_irq", "pwr_irq";
>>> +
>>> +            clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>>> +                 <&gcc GCC_SDCC1_APPS_CLK>,
>>> +                 <&xo_board_clk>;
>>> +            clock-names = "iface", "core", "xo";
>>> +            non-removable;
>>> +            status = "disabled";
>>> +        };
>>> +
>>> +        blsp1_uart2: serial@78b1000 {
>>> +            compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>>> +            reg = <0x078b1000 0x200>;
>>> +            interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>>> +            clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
>>> +                 <&gcc GCC_BLSP1_AHB_CLK>;
>>> +            clock-names = "core", "iface";
>>> +            status = "disabled";
>>> +        };
>>> +
>>> +        intc: interrupt-controller@b000000 {
>>> +            compatible = "qcom,msm-qgic2";
>>> +            reg = <0x0b000000 0x1000>,  /* GICD */
>>> +                  <0x0b002000 0x2000>,  /* GICC */
>>> +                  <0x0b001000 0x1000>,  /* GICH */
>>> +                  <0x0b004000 0x2000>;  /* GICV */
>>> +            #address-cells = <1>;
>>> +            #size-cells = <1>;
>>> +            interrupt-controller;
>>> +            #interrupt-cells = <3>;
>>> +            interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>>> +            ranges = <0 0x0b00c000 0x3000>;
>>> +
>>> +            v2m0: v2m@0 {
>>> +                compatible = "arm,gic-v2m-frame";
>>> +                reg = <0x00000000 0xffd>;
>>> +                msi-controller;
>>> +            };
>>> +
>>> +            v2m1: v2m@1000 {
>>> +                compatible = "arm,gic-v2m-frame";
>>> +                reg = <0x00001000 0xffd>;
>>> +                msi-controller;
>>> +            };
>>> +
>>> +            v2m2: v2m@2000 {
>>> +                compatible = "arm,gic-v2m-frame";
>>> +                reg = <0x00002000 0xffd>;
>>> +                msi-controller;
>>> +            };
>>> +        };
>>> +
>>> +        timer@b120000 {
>>> +            compatible = "arm,armv7-timer-mem";
>>> +            reg = <0x0b120000 0x1000>;
>>> +            #address-cells = <1>;
>>> +            #size-cells = <1>;
>>> +            ranges;
>>> +
>>> +            frame@b120000 {
>>> +                reg = <0x0b121000 0x1000>,
>>> +                      <0x0b122000 0x1000>;
>>> +                frame-number = <0>;
>>> +                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>>> +                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>>> +            };
>>> +
>>> +            frame@b123000 {
>>> +                reg = <0x0b123000 0x1000>;
>>> +                frame-number = <1>;
>>> +                interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>>> +                status = "disabled";
>>> +            };
>>> +
>>> +            frame@b124000 {
>>> +                reg = <0x0b124000 0x1000>;
>>> +                frame-number = <2>;
>>> +                interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>>> +                status = "disabled";
>>> +            };
>>> +
>>> +            frame@b125000 {
>>> +                reg = <0x0b125000 0x1000>;
>>> +                frame-number = <3>;
>>> +                interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>>> +                status = "disabled";
>>> +            };
>>> +
>>> +            frame@b126000 {
>>> +                reg = <0x0b126000 0x1000>;
>>> +                frame-number = <4>;
>>> +                interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>>> +                status = "disabled";
>>> +            };
>>> +
>>> +            frame@b127000 {
>>> +                reg = <0x0b127000 0x1000>;
>>> +                frame-number = <5>;
>>> +                interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>>> +                status = "disabled";
>>> +            };
>>> +
>>> +            frame@b128000 {
>>> +                reg = <0x0b128000 0x1000>;
>>> +                frame-number = <6>;
>>> +                interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>>> +                status = "disabled";
>>> +            };
>>> +        };
>>> +    };
>>> +
>>> +    timer {
>>> +        compatible = "arm,armv8-timer";
>>> +        interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                 <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                 <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>>> +                 <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>>> +    };
>>> +};
