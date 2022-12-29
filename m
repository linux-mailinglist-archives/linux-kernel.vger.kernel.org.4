Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87968658C06
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 12:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiL2LEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 06:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2LEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 06:04:05 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71761EE03
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 03:04:04 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id bn6so9182870ljb.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 03:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4orIij54b32bTygGsy7TQPVOf9T+noiueAxZVYdlJC0=;
        b=B3tLmuPOdSmT5k2SZgLAyQistJWfRi7gVCJH2qK9X2v0nSZAUTh4DZJP0IP1QNK58g
         ZgfsfsFfjssX+uisBFlCQQUmIHGTFU3iZJH0Tmdg7jyDm2DUPc5/0eCuP9yRk5vqIT9S
         GW6Yu5YD3AJzRqJ08+XcvBg+lGaTv5p4wqecIoN4Mf6a5V/wPBc2+w5x6Pv/8nZY4Xxr
         qBtLykB1HCfnRTE61ReJNqljX6PXcXuMuwthA0zvvU41iTAAwPB3+tnjFqfnK73icckD
         CSAsm3Ho3Ofwxs+SWKdXtctC791n+5oPELatrGCG9TU5mf1fRZf2cnpjckefu+zSUBkm
         4qZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4orIij54b32bTygGsy7TQPVOf9T+noiueAxZVYdlJC0=;
        b=QNdy9o606fmXeBwwAh076qX5i5R+/98SvGDujAY7IxuctuwMIARcQWQfmHSB2JCu/J
         TEfAkTy1xXunpzj2SgOHRfmlLrfCdTNwUffl7x21RU0H0ERKKa8B3z4NVxxrDD3Pruiy
         qjEoKe7TOf5pOX/Mq027nw9qAo3/0QIOLZRTaTUuQ+63xnx9y/h+sOaMZ84q0bC6T6RC
         nufjCRUU183Mvg1ehpR6AqZFv1sRi5zqzfBEyGkduztZsS6ikJpDWzFfcBrIDW41sOzU
         LuHZs74XaHt0kF3YTCrFrqX7vEvmFd+N9HFlOxbb2vSaHjGeD495/3M5BbZE7DN0igzT
         ioRQ==
X-Gm-Message-State: AFqh2kqWP2ldm9i/LGlbo9vUScFxHRUaq7VkAP0/DJ4WTT3MRoYgAWhb
        WrQ0w/z9MjFE93hzqA/9fxGG6A==
X-Google-Smtp-Source: AMrXdXuUlZ0ljhkbzSLQE2OIcq6dcAVrg/6nfkd0cPOSDxl5n9X/bAeuw26RG1o0XhHvtsU9XpJ2eA==
X-Received: by 2002:a05:651c:1992:b0:27f:ae36:83ad with SMTP id bx18-20020a05651c199200b0027fae3683admr8265080ljb.5.1672311842685;
        Thu, 29 Dec 2022 03:04:02 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e8e74000000b00279c10ae746sm2216901ljk.140.2022.12.29.03.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 03:04:02 -0800 (PST)
Message-ID: <c4cc7365-df3e-f591-58b8-b844d5bf1737@linaro.org>
Date:   Thu, 29 Dec 2022 12:04:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/7] arm64: dts: qcom: sm8450: add spmi node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221229103212.984324-1-konrad.dybcio@linaro.org>
 <7b32e414-96a9-7265-efee-f872badb32b2@linaro.org>
 <71d7a162-569d-1443-9e53-3ba374d06ccd@linaro.org>
 <ee24809b-cf9b-c555-9c30-956949be25a4@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ee24809b-cf9b-c555-9c30-956949be25a4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.12.2022 11:57, Krzysztof Kozlowski wrote:
> On 29/12/2022 11:45, Konrad Dybcio wrote:
>>
>>
>> On 29.12.2022 11:42, Krzysztof Kozlowski wrote:
>>> On 29/12/2022 11:32, Konrad Dybcio wrote:
>>>> From: Vinod Koul <vkoul@kernel.org>
>>>>
>>>> Add the spmi bus as found in the SM8450 SoC
>>>>
>>>> Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>>>> [Konrad: 0x0 -> 0, move #cells down, make reg-names a vertical list]
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>> v1 -> v2:
>>>> No changes
>>>>
>>>>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 22 ++++++++++++++++++++++
>>>>  1 file changed, 22 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> index 570475040d95..b9b59c5223eb 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> @@ -2715,6 +2715,28 @@ aoss_qmp: power-controller@c300000 {
>>>>  			#clock-cells = <0>;
>>>>  		};
>>>>  
>>>> +		spmi_bus: spmi@c42d000 {
>>>
>>> Hmm looks different than reg.
>>>
>>>> +			compatible = "qcom,spmi-pmic-arb";
>>>> +			reg = <0 0x0c400000 0 0x00003000>,
>>>> +			      <0 0x0c500000 0 0x00400000>,
>>>> +			      <0 0x0c440000 0 0x00080000>,
>>>> +			      <0 0x0c4c0000 0 0x00010000>,
>>>> +			      <0 0x0c42d000 0 0x00010000>;
>>> x
>> Hm, my guess would be that Vinod chose to put the "cnfg" reg
>> instead of "core" in the unit address, as 8450 has 2 SPMI bus
>> hosts and they both share the core reg, so it would have been
>> impossible to have two spmi@core nodes..
> 
> Eh? SM8450 has 2 SPMI hosts both using 0x0c400000? How does that work?
> Usually address can be mapped only once.
No idea either!

> 
> Where is the second SPMI? I cannot find it in linux-next.
It's only there on downstream and I'm not sure how useful it is
really, only some debug subdevice is attached to it.. Perhaps
we could ignore its existence for now and I could use the core
reg in unit address for spmi0?

Konrad
> 
> 
> Best regards,
> Krzysztof
> 
