Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A164E517
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 01:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLPAQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 19:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiLPAQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 19:16:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B2349B7D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:16:42 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m29so784462lfo.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kRw9NosyKCoLQzJxnba7zzcyE0l9B5s5iM+v2n7vWEI=;
        b=wpjEBWCy0R6NjVJ+C8PgFTksxRS9zH9OhoKXGLCwK18mr/7o3/tNuMyt7TWbBpADRy
         +bQ/NzBmXUeR8ftCqJcn6ikvHoCXUw1n161TrUEVwgaRZBACpRXDIwMgrDdQ7YLIaNvp
         cMJqPgBzMDohxB8HfHoLhLvd52lMtc396eBRmF08/ofkzD96Y6swb9OR+qXfqDe0JHsv
         0iJoBVQ3+BCHtvdh1KSRXzR4JYxTptC7M50REBAcWT5VZ6dQUH+7iAXfXFKf1RhNJe35
         0k7GGcdeGJgT+ZBhGFrnX4I+Zt5K1NNqWmL6//NM+2E4KyG+iZPgQCR7/OXQ5wwV1lrS
         YEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRw9NosyKCoLQzJxnba7zzcyE0l9B5s5iM+v2n7vWEI=;
        b=ntkXWMRqfoD32VqYFjKm42Y8NrGm9W04SbpR/XCn+4hQ2YUTZ/GDFINEkmb3XyXjPP
         9pPUJ+uzGlUv6WbqN7ImQOiv2XJcU4TpXQQR+7+lS48MKA4AVxn2pxL7VAYy00O3H0Gn
         bwh3GE4RaOPMTZJXwGb12Me+XA2ykWmGFmFT/Deyg+wNccGcHxP5cXn9CPfimpZF5h5A
         QylZggB1blZuCHAWcvo75IPMRoKteA2X57uB0Fu1l0+gQPQA94VA39J5FTD+eWI4heHA
         fR7c1wBnPyzYWD519kSJ+wHuGICOu9Jn0YZYM0HEln+m0J7DRB/Dcq9cx928LSqzB7Tw
         NAsg==
X-Gm-Message-State: ANoB5pkuSKNcLtzssROaexEdSNr85jnXoA2hLbstQ3BAZMXfM5tu9FIX
        Gx9EASkYuQMoWbU2thbkxg7sPw==
X-Google-Smtp-Source: AA0mqf6yQuvPJwr6lilxSPk5K679p5RQghfxCvY9VemYiZmO40/mgLzuvrybWqODEa0kVXYNGmmYoQ==
X-Received: by 2002:a05:6512:3990:b0:4b6:d28a:2558 with SMTP id j16-20020a056512399000b004b6d28a2558mr13048452lfu.49.1671149800890;
        Thu, 15 Dec 2022 16:16:40 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id c2-20020a197602000000b004a764f9d653sm50821lff.242.2022.12.15.16.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 16:16:40 -0800 (PST)
Message-ID: <d3d28673-934b-08aa-6301-ec56e6509010@linaro.org>
Date:   Fri, 16 Dec 2022 01:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 4/6] arm64: dts: qcom: msm8976: Declare and use SDC1 pins
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221214232049.703484-1-marijn.suijten@somainline.org>
 <20221214232049.703484-5-marijn.suijten@somainline.org>
 <60a40ace-d4e9-df74-88f9-4354d80efaac@linaro.org>
 <20221215210010.on44gmoefbnsokvt@SoMainline.org>
 <20221215210246.rcx7f6unbhj52dkb@SoMainline.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221215210246.rcx7f6unbhj52dkb@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
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



On 15.12.2022 22:02, Marijn Suijten wrote:
> On 2022-12-15 22:00:12, Marijn Suijten wrote:
>> On 2022-12-15 14:19:41, Konrad Dybcio wrote:
>>>
>>>
>>> On 15.12.2022 00:20, Marijn Suijten wrote:
>>>> Add the pinctrl states for SDC1 and use them on sdhc_1.
>>>>
>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/msm8976.dtsi | 55 +++++++++++++++++++++++++++
>>>>  1 file changed, 55 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
>>>> index 05dcb30b0779..7d4c7548882c 100644
>>>> --- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
>>>> @@ -508,6 +508,56 @@ tlmm: pinctrl@1000000 {
>>>>  			interrupt-controller;
>>>>  			#interrupt-cells = <2>;
>>>>  
>>>> +			sdc1_off_state: sdc1-off-state {
>>>> +				clk-pins {
>>>> +					pins = "sdc1_clk";
>>>> +					drive-strength = <2>;
>>>> +					bias-disable;
>>>> +				};
>>>> +
>>>> +				cmd-pins {
>>>> +					pins = "sdc1_cmd";
>>>> +					drive-strength = <2>;
>>>> +					bias-pull-up;
>>>> +				};
>>>> +
>>>> +				data-pins {
>>>> +					pins = "sdc1_data";
>>>> +					drive-strength = <2>;
>>>> +					bias-pull-up;
>>>> +				};
>>>> +
>>>> +				rclk-pins {
>>>> +					pins = "sdc1_rclk";
>>>> +					bias-pull-down;
>>>> +				};
>>>> +			};
>>>> +
>>>> +			sdc1_on_state: sdc1-on-state {
>>>> +				clk-pins {
>>>> +					pins = "sdc1_clk";
>>>> +					drive-strength = <16>;
>>>> +					bias-disable;
>>>> +				};
>>>> +
>>>> +				cmd-pins {
>>>> +					pins = "sdc1_cmd";
>>>> +					drive-strength = <10>;
>>>> +					bias-pull-up;
>>>> +				};
>>>> +
>>>> +				data-pins {
>>>> +					pins = "sdc1_data";
>>>> +					drive-strength = <10>;
>>>> +					bias-pull-up;
>>>> +				};
>>>> +
>>>> +				rclk-pins {
>>>> +					pins = "sdc1_rclk";
>>>> +					bias-pull-down;
>>>> +				};
>>>> +			};
>>>> +
>>>>  			spi1_default: spi0-default-state {
>>>>  				spi-pins {
>>>>  					pins = "gpio0", "gpio1", "gpio3";
>>>> @@ -680,6 +730,11 @@ sdhc_1: mmc@7824000 {
>>>>  				 <&gcc GCC_SDCC1_APPS_CLK>,
>>>>  				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>>>>  			clock-names = "iface", "core", "xo";
>>>> +
>>>> +			pinctrl-0 = <&sdc1_on_state>;
>>>> +			pinctrl-1 = <&sdc1_off_state>;
>>>> +			pinctrl-names = "default", "sleep";
>>> pinctrl-names usually goes before pinctrl-N
>>
>> I thought I had seen them _after_ nowadays, same for reg-names,
>> phy-names, interrupt-names and clock-names.  What is it?
>>
>> Regardless, I'd rather keep this consistent across this file (sdc2 also
>> has it after, same for other *-names)
> 
> Excuse me, I was looking at sm6125 DT while writing this, sdc2 for
> msm8976 is introduced _and used by sdhc_2 in a followup patch.
> 
> The other points still stand though, everything has -names last.
Hm, that's a good point, perhaps we should apply it to pinctrl-
too then. I like this.

Konrad
> 
> - Marijn
> 
>> and correct it at once in a
>> separate patch, if someone really cares.
>>
>> But really, we should have a checker/autoformatter for these "rules",
>> instead of all this manual back-and-forth (is this order already set in
>> stone under Documentation/ or something?).
>>
>> - Marijn
