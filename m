Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58307648F32
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 15:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiLJOZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 09:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLJOZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 09:25:15 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB4A1A3AF
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 06:25:13 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x28so11400397lfn.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 06:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8agtrCqEykAcmFlo/cEntor3G0kQRJHu7WxxefGUlQ=;
        b=hjtLOZXj9dsefoVKt8/L1pyOR+8qga4swUnDyduwYDYKCMZBPhIz18jQbo1nLFcItg
         SNKrFY2uC8ujQ5jgsZHyoFzIg6SkEihwWrfOULhVttIFoK7Ia+iWQnuRuPX8+7XI/yLf
         4F7OOoqXqk02T6P27tUUlWP3S4oXeLghCsLRiJ/jlEZD4YAtGm6gRc1HQpC0dy2ZMXkL
         8adc6w0kDUJ++ANEB6o7txXiGuXNye23v3KTeKMzEVQdMUtu3fAH6UcAJMGqwXrFkL+c
         85sF/1ODdXRS07sJMWobDDFNzxYdmcnM/fsmxO+yIfe5AYrBG8yGB+o3WbjM1KeDAk3f
         ZhVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8agtrCqEykAcmFlo/cEntor3G0kQRJHu7WxxefGUlQ=;
        b=zKaMHhLgm3UzoTaBfm+Jarcq4d7ahDL5/RseNDzMEexYxQo1jhB8DWEO2xAYnUrwkM
         9aigcURRPaciPMcg0Lm+8C3/pSlNs1KWBQPAbuTdinrYkq8q86piT6GbLgpEuQEe60BD
         4pJm+6q0W2zzmR6NNBVCRwQp9YxpyBn+w9xGpIsxIDt9tM3CuHG4B85R42XXh2HN9hvv
         XUeJMv3jppUuXfmFc8qRCa1FePhecDBjRuJGiVKwNPG9W7xfHJF/E3qac1kPXjFS2c7Y
         w13gZsYGB7MhcEXX0f0/klrJTMcyY5WQd+VlVv+qbxmSdu1BwELCfpUFNbhh5oOFAflw
         uoOQ==
X-Gm-Message-State: ANoB5pm5hBZECG1jd0/I1DPrDZkHZ8V6kHfvKcXz5aF1ebbZj31T3tn/
        H7ajbpS/XTkWFyMhslwB634Dqw==
X-Google-Smtp-Source: AA0mqf4vHKTyhpnMP+Q9OIAYTFeC5sHj/OnLmOVhrYDvrG1t3X9YGv5wDi2pQDFTy45xDKtf3XNmaw==
X-Received: by 2002:a05:6512:e99:b0:4b5:adae:b6be with SMTP id bi25-20020a0565120e9900b004b5adaeb6bemr3949619lfb.42.1670682311618;
        Sat, 10 Dec 2022 06:25:11 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id t6-20020a056512208600b004b55e16931fsm737629lfr.259.2022.12.10.06.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 06:25:11 -0800 (PST)
Message-ID: <9b57549f-b74a-25f5-e645-f2602199f35b@linaro.org>
Date:   Sat, 10 Dec 2022 15:25:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH] arm64: dts: qcom: Use plural _gpios node label for
 PMIC gpios
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209220450.1793421-1-marijn.suijten@somainline.org>
 <714ac62a-7bab-e16e-e3b6-bdd86e422699@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <714ac62a-7bab-e16e-e3b6-bdd86e422699@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.12.2022 11:50, Krzysztof Kozlowski wrote:
> On 09/12/2022 23:04, Marijn Suijten wrote:
>> The gpio node in PMIC dts'es define access to multiple GPIOs.  Most Qcom
>> PMICs were already using the plural _gpios label to point to this node,
>> but a few PMICs were left behind including the recently-pulled
>> pm(i)8950.
>>
>> Rename it from *_gpio to *_gpios for pm6125, pm6150(l), pm8005,
>> pm(i)8950, and pm(i)8998.
>>
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>
>> ---
>>
>> This was brought up for discussion in [1] but hasn't seen any relevant
>> reply, unfortunately.
> 
> This is just a label, it does not matter. Why changing all exisitng
> files? I don't think it was a part of previous discussions...
> 
> To me it is unneeded churn.
IMHO it's beneficial, as when working on different platforms I have to
waste time checking or being told by the compiler that &pm8xxx_gpios
doesn't exist and then I have to think why and realize it's just not
named consistently..

Konrad
> 
>>
>> [1]: https://lore.kernel.org/linux-arm-msm/20221104234435.xwjpwfxs73puvfca@SoMainline.org/
>> ---
>>  arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts  |  8 ++++----
>>  .../dts/qcom/msm8998-oneplus-cheeseburger.dts    |  4 ++--
>>  .../boot/dts/qcom/msm8998-oneplus-common.dtsi    |  6 +++---
>>  .../qcom/msm8998-sony-xperia-yoshino-maple.dts   |  4 ++--
>>  .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi    | 16 ++++++++--------
>>  .../arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts |  4 ++--
>>  arch/arm64/boot/dts/qcom/pm6125.dtsi             |  4 ++--
>>  arch/arm64/boot/dts/qcom/pm6150.dtsi             |  4 ++--
>>  arch/arm64/boot/dts/qcom/pm6150l.dtsi            |  4 ++--
>>  arch/arm64/boot/dts/qcom/pm8005.dtsi             |  4 ++--
>>  arch/arm64/boot/dts/qcom/pm8950.dtsi             |  4 ++--
>>  arch/arm64/boot/dts/qcom/pm8998.dtsi             |  4 ++--
>>  arch/arm64/boot/dts/qcom/pmi8950.dtsi            |  4 ++--
>>  arch/arm64/boot/dts/qcom/pmi8998.dtsi            |  4 ++--
>>  arch/arm64/boot/dts/qcom/sc7180-idp.dts          |  4 ++--
>>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi     |  4 ++--
>>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi       |  4 ++--
>>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts       | 16 ++++++++--------
>>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi   |  4 ++--
>>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi     |  6 +++---
>>  .../arm64/boot/dts/qcom/sdm845-shift-axolotl.dts |  4 ++--
>>  .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi   |  2 +-
>>  .../dts/qcom/sdm845-xiaomi-beryllium-common.dtsi |  4 ++--
>>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts      |  4 ++--
>>  .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts |  2 +-
>>  25 files changed, 64 insertions(+), 64 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
>> index 310f7a2df1e8..0e273938b59d 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
>> +++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
>> @@ -113,7 +113,7 @@ gpio-keys {
>>  			    <&cam_snapshot_pin_a>;
>>  		button-vol-up {
>>  			label = "Volume Up";
>> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
>> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>>  			linux,input-type = <EV_KEY>;
>>  			linux,code = <KEY_VOLUMEUP>;
> 
> Best regards,
> Krzysztof
> 
