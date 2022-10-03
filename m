Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE45F28A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 08:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiJCGpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 02:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJCGpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 02:45:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6682649F
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 23:45:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x40so37535ljq.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1mBFr4loQONrn37uXtF2fKnYuhKCJRlfpr3SwpPcroQ=;
        b=V5w9rGmAxR2Ey4jAxTec2VBIBheHfasJMcDSYqK/hg7LavPPVEjRtbPhxZynwaCtu3
         Dy+lpyL7R+pz4yivFhTvaM+BSmEUZLdj5C1plY0D7g40ygn8LtrfqELSSGFn+LtDzINh
         SfqIhuOAvP7mGagz0+ZZ+Le2J/2fcculTYpT28JEvZp2XDm/pnJb+rmAi6AYqkfydgWC
         v++1pV3rLknYV4u7HUPCsRM+fgy9vCkIqybS44oUFJPGu/LcFrquFwKhorrfHFRhlfEV
         J0lZ+lDOD5UoceIYvTlxvb6HRWHaMBsOfl7mPd8ovfYPeVddE/+GBL2R/TMtjWHTBNJe
         LMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1mBFr4loQONrn37uXtF2fKnYuhKCJRlfpr3SwpPcroQ=;
        b=rwP+EEL/hzmZLry3g0+TkOcpWqkRmmFA/UFRdOT7EZrSpFitgEbMKci0Ba6Psrayom
         ftzU+qeHwSHqfBQw5mm5EwFLwOX3g+8HlouCTwddKX3f3M57Z49BnUbSBfWgkoXzlcUo
         AQSXwpUsdf66kPjUrplMQi/gzjGHBfUM+fh+yMPByqH/3mmLZJytVRdsdqU0WhuuAGsq
         Ho77gN3gBXvrShFIWSaxxRvlC/3SpVG2Gf7/Zj3Ae//vxuLCN0o4mQURqC4oLPp3upIL
         EPrI1a2GQqHtFmJc6eEhpm+8BUTksqp3jDJrPwJntfNZZvk4bpasAoRUpzrvTREb/YBc
         VqzQ==
X-Gm-Message-State: ACrzQf1ZGrmLX7ZPIQgJKnWCnvDWfLWZ/t5tdpJsGItdkuCXDfmKf8qw
        BnHatCZDeuiNnhGPIczI/mdOybMnAZmz8g==
X-Google-Smtp-Source: AMsMyM5FznM+2F+3O9qNpHsJyEMCkOif4kmZqal4W4yVaKahqU7EbwYka5SJVnGqQ7xAH8O0DOPHAA==
X-Received: by 2002:a2e:585:0:b0:26d:d39b:19d3 with SMTP id 127-20020a2e0585000000b0026dd39b19d3mr1464562ljf.345.1664779528838;
        Sun, 02 Oct 2022 23:45:28 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g5-20020a2eb5c5000000b0026bf43a4d72sm779947ljn.115.2022.10.02.23.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 23:45:28 -0700 (PDT)
Message-ID: <c00f37b9-d1fc-f9fa-f4ef-1d6f48353d1e@linaro.org>
Date:   Mon, 3 Oct 2022 08:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sagit: add initial device tree
 for sagit
To:     Dzmitry Sankouski <dsankouski@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928103319.621698-1-dsankouski@gmail.com>
 <20220928103319.621698-2-dsankouski@gmail.com>
 <320b2bc3-4330-ec7b-d9fa-5194bdaeec03@linaro.org>
 <CABTCjFBWrgTzjugjuJRPykAGtp65AF7JKY6eemzt=zn42udH1w@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CABTCjFBWrgTzjugjuJRPykAGtp65AF7JKY6eemzt=zn42udH1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2022 20:36, Dzmitry Sankouski wrote:
>>> +
>>> +     bluetooth {
>>> +             compatible = "qcom,wcn3990-bt";
>>> +
>>> +             vddio-supply = <&vreg_s4a_1p8>;
>>> +             vddxo-supply = <&vreg_l7a_1p8>;
>>> +             vddrf-supply = <&vreg_l17a_1p3>;
>>> +             vddch0-supply = <&vreg_l25a_3p3>;
>>> +             max-speed = <3200000>;
>>> +     };
>>> +};
>>> +
>>> +&blsp1_uart3_on {
>>> +     rx {
>>
>> Missing suffix pins
>>
> 'rx' pin should be renamed with the corresponding pin in msm8998.dtsi file,
> since we're overriding the pin here, and rename 'rx' pins in other
> msm8998-based dts. Is that what you mean?
> What are the possible suffix names? AFAIU, it can be either 'active' or
> 'suspend', right?

Trim the replies. It takes time to scroll through unrelated context.

If you override node form msm8998.dtsi, then it is fine.

Otherwise it would be suffix "pins", as I wrote.


> 
>>
>>> +             /delete-property/ bias-disable;
>>> +             /*
>>> +              * Configure a pull-up on 46 (RX). This is needed to
>>> +              * avoid garbage data when the TX pin of the Bluetooth
>>> +              * module is in tri-state (module powered off or not
>>> +              * driving the signal yet).
>>> +              */
>>> +             bias-pull-up;
>>> +     };
>>> +
>>> +     cts {
>>
>> Missing suffix pins

This also can be skipped, since it is override.

>>
>>> +             /delete-property/ bias-disable;
>>> +             /*
>>> +              * Configure a pull-down on 47 (CTS) to match the pull
>>> +              * of the Bluetooth module.
>>> +              */
>>> +             bias-pull-down;
>>> +     };
>>> +};
>>> +
>>> +&blsp2_uart1 {
>>> +     status = "okay";
>>> +};
>>> +
>>> +&pm8005_lsid1 {
>>> +     pm8005-regulators {
>>
>> This is just "regulators", right?
>>
>>> +             compatible = "qcom,pm8005-regulators";
>>> +
>>> +             vdd_s1-supply = <&vph_pwr>;
>>> +
>>> +             pm8005_s1: s1 { /* VDD_GFX supply */
>>> +                     regulator-min-microvolt = <524000>;
>>> +                     regulator-max-microvolt = <1100000>;
>>> +                     regulator-enable-ramp-delay = <500>;
>>> +
>>> +                     /* hack until we rig up the gpu consumer */
>>> +                     regulator-always-on;
>>> +             };
>>> +     };
>>> +};
>>> +
>>> +&pm8998_gpio {
>>> +     vol_up_key_default: vol-up-key-default-state {
>>> +             pins = "gpio6";
>>> +             function = "normal";
>>> +             bias-pull-up;
>>> +             input-enable;
>>> +             qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
>>> +     };
>>> +
>>> +     audio_mclk_pin: audio-mclk-pin-active-state {
>>> +             pins = "gpio13";
>>> +             function = "func2";
>>> +             power-source = <0>;
>>> +     };
>>> +};
>>> +
>>> +&qusb2phy {
>>> +     status = "okay";
>>> +
>>> +     vdda-pll-supply = <&vreg_l12a_1p8>;
>>> +     vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
>>> +};
>>> +
>>> +&rpm_requests {
>>> +     pm8998-regulators {
>>
>> This is for sure now regulators (and since you have two: regulators-0).
>>
> There's no 'regulators-0' occurrences in 6.0.0-rc6 kernel, i.e. it's a new
> convention. Why do we need this new convention? I mean, other msm8998
> boards regulators  are named by driver name, and changing that seems like
> rename refactoring.

Do you see "pm8998-regulators" supported? If not, then how it is "rename
refactoring"?

https://lore.kernel.org/all/20220901093243.134288-1-krzysztof.kozlowski@linaro.org/

> 
>>
>>> +             compatible = "qcom,rpm-pm8998-regulators";
>>> +
>>> +             vdd_s1-supply = <&vph_pwr>;
>>> +             vdd_s2-supply = <&vph_pwr>;
>>> +             vdd_s3-supply = <&vph_pwr>;
>>> +             vdd_s4-supply = <&vph_pwr>;
>>> +             vdd_s5-supply = <&vph_pwr>;
>>> +             vdd_s6-supply = <&vph_pwr>;
>>> +             vdd_s7-supply = <&vph_pwr>;
>>> +             vdd_s8-supply = <&vph_pwr>;
>>> +             vdd_s9-supply = <&vph_pwr>;
>>> +             vdd_s10-supply = <&vph_pwr>;
>>> +             vdd_s11-supply = <&vph_pwr>;
>>> +             vdd_s12-supply = <&vph_pwr>;
>>> +             vdd_s13-supply = <&vph_pwr>;
>>> +             vdd_l1_l27-supply = <&vreg_s7a_1p025>;
>>> +             vdd_l2_l8_l17-supply = <&vreg_s3a_1p35>;
>>> +             vdd_l3_l11-supply = <&vreg_s7a_1p025>;
>>> +             vdd_l4_l5-supply = <&vreg_s7a_1p025>;
>>> +             vdd_l6-supply = <&vreg_s5a_2p04>;
>>> +             vdd_l7_l12_l14_l15-supply = <&vreg_s5a_2p04>;
>>> +             vdd_l9-supply = <&vreg_bob>;
>>> +             vdd_l10_l23_l25-supply = <&vreg_bob>;
>>> +             vdd_l13_l19_l21-supply = <&vreg_bob>;
>>> +             vdd_l16_l28-supply = <&vreg_bob>;
>>> +             vdd_l18_l22-supply = <&vreg_bob>;
>>> +             vdd_l20_l24-supply = <&vreg_bob>;
>>> +             vdd_l26-supply = <&vreg_s3a_1p35>;
>>> +             vdd_lvs1_lvs2-supply = <&vreg_s4a_1p8>;
>>> +
>>> +             vreg_s3a_1p35: s3 {
>>> +                     regulator-min-microvolt = <1352000>;
>>> +                     regulator-max-microvolt = <1352000>;
>>> +             };
>>> +
>>> +             vreg_s4a_1p8: s4 {
>>> +                     regulator-min-microvolt = <1800000>;
>>> +                     regulator-max-microvolt = <1800000>;
>>> +                     regulator-allow-set-load;
>>> +             };
>>> +
>>> +             vreg_s5a_2p04: s5 {
>>> +                     regulator-min-microvolt = <1904000>;
>>> +                     regulator-max-microvolt = <2040000>;
>>> +             };
>>> +
>>> +             vreg_s7a_1p025: s7 {
>>> +                     regulator-min-microvolt = <900000>;
>>> +                     regulator-max-microvolt = <1028000>;
>>> +             };
>>> +
>>> +             vreg_l1a_0p875: l1 {
>>> +                     regulator-min-microvolt = <880000>;
>>> +                     regulator-max-microvolt = <880000>;
>>> +             };
>>> +
>>> +             vreg_l2a_1p2: l2 {
>>> +                     regulator-min-microvolt = <1200000>;
>>> +                     regulator-max-microvolt = <1200000>;
>>> +             };
>>> +
>>> +             vreg_l3a_1p0: l3 {
>>> +                     regulator-min-microvolt = <1000000>;
>>> +                     regulator-max-microvolt = <1000000>;
>>> +             };
>>> +
>>> +             vreg_l5a_0p8: l5 {
>>> +                     regulator-min-microvolt = <800000>;
>>> +                     regulator-max-microvolt = <800000>;
>>> +             };
>>> +
>>> +             vreg_l6a_1p8: l6 {
>>> +                     regulator-min-microvolt = <1800000>;
>>> +                     regulator-max-microvolt = <1800000>;
>>> +             };
>>> +
>>> +             vreg_l7a_1p8: l7 {
>>> +                     regulator-min-microvolt = <1800000>;
>>> +                     regulator-max-microvolt = <1800000>;
>>> +             };
>>> +
>>> +             vreg_l8a_1p2: l8 {
>>> +                     regulator-min-microvolt = <1200000>;
>>> +                     regulator-max-microvolt = <1200000>;
>>> +             };
>>> +
>>> +             vreg_l9a_1p8: l9 {
>>> +                     regulator-min-microvolt = <1808000>;
>>> +                     regulator-max-microvolt = <2960000>;
>>> +             };
>>> +
>>> +             vreg_l10a_1p8: l10 {
>>> +                     regulator-min-microvolt = <1808000>;
>>> +                     regulator-max-microvolt = <2960000>;
>>> +             };
>>> +
>>> +             vreg_l11a_1p0: l11 {
>>> +                     regulator-min-microvolt = <1000000>;
>>> +                     regulator-max-microvolt = <1000000>;
>>> +             };
>>> +
>>> +             vreg_l12a_1p8: l12 {
>>> +                     regulator-min-microvolt = <1800000>;
>>> +                     regulator-max-microvolt = <1800000>;
>>> +             };
>>> +
>>> +             vreg_l13a_2p95: l13 {
>>> +                     regulator-min-microvolt = <1808000>;
>>> +                     regulator-max-microvolt = <2960000>;
>>> +             };
>>> +
>>> +             vreg_l14a_1p8: l14 {
>>> +                     regulator-min-microvolt = <1800000>;
>>> +                     regulator-max-microvolt = <1800000>;
>>> +             };
>>> +
>>> +             vreg_l15a_1p8: l15 {
>>> +                     regulator-min-microvolt = <1800000>;
>>> +                     regulator-max-microvolt = <1800000>;
>>> +             };
>>> +
>>> +             vreg_l16a_2p7: l16 {
>>> +                     regulator-min-microvolt = <2704000>;
>>> +                     regulator-max-microvolt = <2704000>;
>>> +             };
>>> +
>>> +             vreg_l17a_1p3: l17 {
>>> +                     regulator-min-microvolt = <1304000>;
>>> +                     regulator-max-microvolt = <1304000>;
>>> +             };
>>> +
>>> +             vreg_l18a_2p7: l18 {
>>> +                     regulator-min-microvolt = <2704000>;
>>> +                     regulator-max-microvolt = <2704000>;
>>> +             };
>>> +
>>> +             vreg_l19a_3p0: l19 {
>>> +                     regulator-min-microvolt = <3008000>;
>>> +                     regulator-max-microvolt = <3008000>;
>>> +             };
>>> +
>>> +             vreg_l20a_2p95: l20 {
>>> +                     regulator-min-microvolt = <2960000>;
>>> +                     regulator-max-microvolt = <2960000>;
>>> +                     regulator-allow-set-load;
>>> +             };
>>> +
>>> +             vreg_l21a_2p95: l21 {
>>> +                     regulator-min-microvolt = <2960000>;
>>> +                     regulator-max-microvolt = <2960000>;
>>> +                     regulator-system-load = <800000>;
>>> +                     regulator-allow-set-load;
>>> +             };
>>> +
>>> +             vreg_l22a_2p85: l22 {
>>> +                     regulator-min-microvolt = <2864000>;
>>> +                     regulator-max-microvolt = <2864000>;
>>> +             };
>>> +
>>> +             vreg_l23a_3p3: l23 {
>>> +                     regulator-min-microvolt = <3312000>;
>>> +                     regulator-max-microvolt = <3312000>;
>>> +             };
>>> +
>>> +             vreg_l24a_3p075: l24 {
>>> +                     regulator-min-microvolt = <3088000>;
>>> +                     regulator-max-microvolt = <3088000>;
>>> +             };
>>> +
>>> +             vreg_l25a_3p3: l25 {
>>> +                     regulator-min-microvolt = <3104000>;
>>> +                     regulator-max-microvolt = <3312000>;
>>> +             };
>>> +
>>> +             vreg_l26a_1p2: l26 {
>>> +                     regulator-min-microvolt = <1200000>;
>>> +                     regulator-max-microvolt = <1200000>;
>>> +                     regulator-allow-set-load;
>>> +             };
>>> +
>>> +             vreg_l28_3p0: l28 {
>>> +                     regulator-min-microvolt = <3008000>;
>>> +                     regulator-max-microvolt = <3008000>;
>>> +             };
>>> +
>>> +             vreg_lvs1a_1p8: lvs1 { };
>>> +
>>> +             vreg_lvs2a_1p8: lvs2 { };
>>> +     };
>>> +
>>> +     pmi8998-regulators {
>>
>> regulators-1
>>
>>> +             compatible = "qcom,rpm-pmi8998-regulators";
>>> +
>>> +             vdd_bob-supply = <&vph_pwr>;
>>> +
>>> +             vreg_bob: bob {
>>> +                     regulator-min-microvolt = <3312000>;
>>> +                     regulator-max-microvolt = <3600000>;
>>> +             };
>>> +     };
>>> +};
>>> +
>>> +&tlmm {
>>> +     gpio-reserved-ranges = <0 4>, <81 4>;
>>> +
>>> +     cci1_default: cci1-default {
>>
>> Missing suffix state. The same in all other places.
>>
>>> +             pins = "gpio18", "gpio19";
>>> +             function = "cci_i2c";
>>> +             bias-disable;
>>> +             drive-strength = <2>;
>>> +     };
>>> +
>>
>> (...)
>>
>>> +
>>> +&wifi {
>>> +     status = "okay";
>>> +     vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
>>> +     vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
>>> +     vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
>>> +     vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
>>> +};
>>> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi
>> b/arch/arm64/boot/dts/qcom/pm8998.dtsi
>>> index d09f2954b6f9..4551af463081 100644
>>> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
>>> @@ -52,6 +52,12 @@ pm8998_pwrkey: pwrkey {
>>>                               bias-pull-up;
>>>                               linux,code = <KEY_POWER>;
>>>                       };
>>> +
>>> +                     pm8998_resin: resin {
>>
>> Missing suffix state

This comment is probably wrong - it's resin, not pin control.

>>
>>> +                             compatible = "qcom,pm8941-resin";
>>> +                             bias-pull-up;
>>> +                             interrupts = <GIC_SPI 0x8 1
>> IRQ_TYPE_EDGE_BOTH>;


Best regards,
Krzysztof

