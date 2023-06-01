Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B50719A23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjFAKuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjFAKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:50:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C474F2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:50:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f3b9e54338so809324e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685616617; x=1688208617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6+t0uy+ketxaAQlCOq5q5RS6euSThxMjwTvlYKC7DQ=;
        b=Xk6DJfF3St/zpKIBsqM2fp+ED1i18fmPgE1IEu1CNaFqg1wtqx5VONv3nKVJuZeGyA
         3iHwpo9jEl/7TtIaGUWQHA5lQD3cS52Fs0kaJyU4cgr34PbmWKyazQh09Ok3Ug1MnevE
         q48eddQtPyNmla6efGBVzbqqTqgOdd5DzIQFfdY66NV+t5OEWwBmCBW4D3UDf90EfoYJ
         SNHw5GJfGOfNlNkCmbiZVyj1YowKb5TzlwwP6EJ7y8eBMeKKFz6EghqLRzl8RSzyTPo+
         zAHzUL1ik1Tur69dtDJx3zMGm2sJ2se6dzFd0u5Ccr2GPrINPhlvPDRf3slX5OprKS99
         k+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685616617; x=1688208617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6+t0uy+ketxaAQlCOq5q5RS6euSThxMjwTvlYKC7DQ=;
        b=FbkEY3p531Yxr3Q8aa80WEUDeMg2+dBGrk86IcgDdQZtCChKuQpfzHE1U2gXqSfB/j
         4ixSJkQjF+FFL9zNtCILgT4g+xpNAoTO69jroBxOgSVFI5nfYglb6hy4gb+j0ZPC6tVP
         lic+k0c0yY8lX8AEBObC7okJZ16OSEfC8ewnXXiPC0lE9c6yEvKbRCl8HUp8cTkrqjZR
         AGX1jrtu05WtxI6IJF21hmJN/Oe+8Tak/lXvGu0FUakKf3kk0qqHx3Bb2HpoMMpO9ogL
         eBa0Bt8W12GvBjCj09pKcsiij93Av2Kf3rJuk4XuhXOAfPJ10ix0ed2hAbsMzc3mi6Bx
         Vdtw==
X-Gm-Message-State: AC+VfDw3QbBz/bfEs5LBKijn0wDtOwp1/YnEKejGI26a4aUWR1g6ff9G
        1L+a3i6YTfyCtCj2HEd21zj1HQ==
X-Google-Smtp-Source: ACHHUZ6qJU54CrXN5+nToeFKN/q0UGyTUCBzFZunDM946Pa2xvHWK6L7HbM/y56Ojhx0IZ+uW0gL0g==
X-Received: by 2002:ac2:5505:0:b0:4f3:b221:558c with SMTP id j5-20020ac25505000000b004f3b221558cmr1084547lfk.43.1685616616811;
        Thu, 01 Jun 2023 03:50:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004f2ce4b0f2esm1040575lfh.168.2023.06.01.03.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:50:16 -0700 (PDT)
Message-ID: <bede29c5-d4e0-7925-dcdc-c724b98d25ca@linaro.org>
Date:   Thu, 1 Jun 2023 12:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Add missing interconnect path
 to USB HC
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230601103817.4066446-1-abel.vesa@linaro.org>
 <34cd6db8-9f05-23cc-cd41-7fd48ec1a286@linaro.org>
 <ZHh3pyQprqKDn+TS@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZHh3pyQprqKDn+TS@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 12:49, Abel Vesa wrote:
> On 23-06-01 12:42:22, Konrad Dybcio wrote:
>>
>>
>> On 1.06.2023 12:38, Abel Vesa wrote:
>>> The USB HC node is missing the interconnect paths, so add them.
>>>
>>> Fixes: 7f7e5c1b037f ("arm64: dts: qcom: sm8550: Add USB PHYs and controller nodes")
>> For context, it's a fix in the context of "we should prooobably have
>> this if we want to fix the icc driver to include sync state".
> 
> Fair enough...
> 
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>>
>>
>> sidenote:
>>
>> on recent SoCs there's also an USB-IPA path:
>>
>> aggre1_noc MASTER_USB3_0 <-> &config_noc SLAVE_IPA_CFG
> 
> AFAIK, support for IPA on SM8550 is not added yet.
> 
> We can worry about this 3rd path when IPA support for this platform is
> upstreamed.
Right, that's what I'm saying. I'm not even sure we have tethering
acceleration upstream (where IPA pushes data quickly for sharing mobile
data via USB).

Konrad
> 
>>
>> I don't think we really make use of that upstream today or whether it
>> would make enabling IPA necessary (to enable the clocks and reach the
>> IPA hardware), but it's something to think about.
>>
>> Konrad
>>>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>>> index 75cd374943eb..4991b2e962d1 100644
>>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>>> @@ -2793,6 +2793,10 @@ usb_1: usb@a6f8800 {
>>>  
>>>  			resets = <&gcc GCC_USB30_PRIM_BCR>;
>>>  
>>> +			interconnects = <&aggre1_noc MASTER_USB3_0 0 &mc_virt SLAVE_EBI1 0>,
>>> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
>>> +			interconnect-names = "usb-ddr", "apps-usb";
>>> +
>>>  			status = "disabled";
>>>  
>>>  			usb_1_dwc3: usb@a600000 {
