Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7C96569C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiL0LOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiL0LOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:14:37 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA087DB7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:14:34 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id p36so19161325lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q91h+qmG72Eyypqxw89XsMvqCu6zqsw6i6tKexOSIMk=;
        b=CVtxK3hRsKFd4mXM4EZaHOPtc6hX8rz5lFXti/X8zL4Sx6eSIoVJFcyaf1xO6/vLKY
         s+EyL5EjUvacFnVzeR5B/Jzu0IoIiS/jaGXF7DFgxXSN04QufLb/20o8s+b+LotQ9iSC
         0ksqfnDiMMEPmWy4qxA2PubG7Gbb+YriR9dQebLbZ/mQPu5DohcPuy7fKXaNHwkKvp9u
         Gya8hQaKEn4oUnU8Z7FdyAI9BJWXf/64KOrzrDjCCb1yRGvIVoDmt+IK0skrceKHbx+R
         tSI8qyoD3h7OX+9lqB2YJu+2aZbAEqqpFS72Gx47lncuz7P8HH5gi68FcwWuJChZgKjt
         6eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q91h+qmG72Eyypqxw89XsMvqCu6zqsw6i6tKexOSIMk=;
        b=YReHQp5LhuAhNm0eai0R7yQfrLCysoumAh5wCB2vvgK83VI4dgqgk6n24koPRD53E1
         SaDt9AhDuM9jFmrIlMGrSOkkUlEOX0rEQHcNU7cfIrJzUAWnNQ5A8j++BMMxsKfrNe4+
         ZM9N4NliMdN++tZuReCPwGnjdYsffneh5CROzt76yC0s945MoP3Vkadyz0nOy0loiTNv
         UObqxQS2mV4GUlZBrifr/1nexSipIt4W+HdlGIQ5qTz5XyunT8EqwE8e2KIOBpQJ/ZGC
         iGW9KaR+c19jWReGfbFDbDyVp/iJcq2RGSqKdQKvtCP5EqZqxn9OKQLNK9Eh3BGs0NLq
         Y5rA==
X-Gm-Message-State: AFqh2kp/V6+HEyLeKhOnupXSDYQML4LASjpDdjdaWMgL/WgiH6pndtIa
        Myf2xbzPy/wWx7O3WBGh9np3HA==
X-Google-Smtp-Source: AMrXdXtBNHz+BrTIliM1MB0RostvYMij6h6w+EmNqEFxkV0c0vDc0zls+MdTHE+2Hp+BApv8F4WUFg==
X-Received: by 2002:ac2:5dce:0:b0:4b5:b988:b409 with SMTP id x14-20020ac25dce000000b004b5b988b409mr6117596lfq.21.1672139672953;
        Tue, 27 Dec 2022 03:14:32 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id k2-20020a05651239c200b004ab2cb8deb5sm2197371lfu.18.2022.12.27.03.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 03:14:32 -0800 (PST)
Message-ID: <542a4f6f-931a-3e0a-bd5d-1344339651ea@linaro.org>
Date:   Tue, 27 Dec 2022 12:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/4] ARM: dts: qcom: sdx65: add specific compatible for
 USB HS PHY
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
 <20221223161835.112079-3-krzysztof.kozlowski@linaro.org>
 <d6fcecda-2f78-bd75-579b-672f6db779a2@linaro.org>
 <6a9506a5-caf0-0977-af75-0a4e4c0e3a0f@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <6a9506a5-caf0-0977-af75-0a4e4c0e3a0f@linaro.org>
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



On 24.12.2022 14:12, Krzysztof Kozlowski wrote:
> On 23/12/2022 17:20, Konrad Dybcio wrote:
>>
>>
>> On 23.12.2022 17:18, Krzysztof Kozlowski wrote:
>>> Add SoC-specific compatible to the USB HS PHY to match other devices and
>>> bindings.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  arch/arm/boot/dts/qcom-sdx65.dtsi | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
>>> index b073e0c63df4..d3c661d7650d 100644
>>> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
>>> @@ -219,7 +219,8 @@ blsp1_uart3: serial@831000 {
>>>  		};
>>>  
>>>  		usb_hsphy: phy@ff4000 {
>>> -			compatible = "qcom,usb-snps-hs-7nm-phy";
>>> +			compatible = "qcom,sdx65-usb-hs-phy",
>>> +				     "qcom,usb-snps-hs-7nm-phy";
>> Not sure if the newline is necessary, but still:
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> It is over 80 - up to 90 - and we still keep 80-limit in coding style.
Torvalds said 100 is fine a year a go or so.

Konrad
> 
> Best regards,
> Krzysztof
> 
