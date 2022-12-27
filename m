Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E462D6569F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 12:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiL0LaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 06:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiL0LaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 06:30:05 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978096569
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:30:03 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bq39so11434997lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 03:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aN3V6trDzvXSYtL26lx3FV7PuCk2Xl5LGxwnUm2VEh4=;
        b=D6oARKb10jppciRnCilQ32Dej7uYF6DSTuvY/IP+oORmU/pLbrptAk5OvgLB7b/LGz
         oV7OFaGBSJvYCcJ3rAVE0CPVtzVzFcW2cR8kTME64K70KdZ/lptsknSNE/p30R/f21LA
         3lM1SXOztnLyMbdSVbrcivQ2061TJzTVnxqf7On/F8qq0kRkjnkZa18PgdDC9Hv+ignV
         W7vIpGaICcqC0D2lGZKXk+fsw5IaD7DBbJ086Nzn4G0d7mVLzFf87cZ9EIvcFel5+6gU
         NvZHoLsyoB/h+VSobCXAqiX1fM8XhxpwhGTqkRsnQVH1lmhvjuujtsXH4pA3l/sDDVQo
         wYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aN3V6trDzvXSYtL26lx3FV7PuCk2Xl5LGxwnUm2VEh4=;
        b=M4dfkU45YDFwlyVX2bsYjaTX6G4A0QKHXUnjQoAEeEvXCsf5DTAIph+sBjLmtWcuBV
         vz6yXiK3HfS2C3Yt5oYl1JfP+6gulxXmTOlGrkxQPdyrxwafbuH0EW0IIumRKZ2hW9pf
         3offnuGktvRC0NKJzoJ88hQ1gLgOtWwIm8IbTK5TwYBckhQ2y41iZzd/qpZwJEtSHWV8
         G7i9R7gBZvVF7y/Fh2p0eHcFliD018NhGbFoCP/h6RergMP27NuwUhYhHbYYRj2okkNK
         CtUcqK8Gwm/obu36Gi71hEfjT9n7VB7X+rSvlf3voVgJdu2sU1yR0K/Kod3s8+Ee+4Lj
         GEYQ==
X-Gm-Message-State: AFqh2krgjawJOl4oiwsPK5lsH8tqx2Xy79KJbjDb+rf58aiGuK1SXa86
        ibK7HD/gdQuzWgmJCW0iM/NClA==
X-Google-Smtp-Source: AMrXdXuQCFF6EAuPGhKVlnd9xb+jRbrMxibY4uYGpnnSUw158af9QxPKYTxPgBMtBgUBq5JAQ+Szdg==
X-Received: by 2002:a05:6512:6cb:b0:4a4:68b7:e71a with SMTP id u11-20020a05651206cb00b004a468b7e71amr6566622lff.4.1672140601477;
        Tue, 27 Dec 2022 03:30:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k2-20020ac24562000000b004b4ea0f4e7fsm2192712lfm.299.2022.12.27.03.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 03:30:01 -0800 (PST)
Message-ID: <e1725365-2751-ea09-7699-012f4ee3cd1b@linaro.org>
Date:   Tue, 27 Dec 2022 12:29:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] ARM: dts: qcom: sdx65: add specific compatible for
 USB HS PHY
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
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
 <542a4f6f-931a-3e0a-bd5d-1344339651ea@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <542a4f6f-931a-3e0a-bd5d-1344339651ea@linaro.org>
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

On 27/12/2022 12:14, Konrad Dybcio wrote:
> 
> 
> On 24.12.2022 14:12, Krzysztof Kozlowski wrote:
>> On 23/12/2022 17:20, Konrad Dybcio wrote:
>>>
>>>
>>> On 23.12.2022 17:18, Krzysztof Kozlowski wrote:
>>>> Add SoC-specific compatible to the USB HS PHY to match other devices and
>>>> bindings.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>  arch/arm/boot/dts/qcom-sdx65.dtsi | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
>>>> index b073e0c63df4..d3c661d7650d 100644
>>>> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
>>>> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
>>>> @@ -219,7 +219,8 @@ blsp1_uart3: serial@831000 {
>>>>  		};
>>>>  
>>>>  		usb_hsphy: phy@ff4000 {
>>>> -			compatible = "qcom,usb-snps-hs-7nm-phy";
>>>> +			compatible = "qcom,sdx65-usb-hs-phy",
>>>> +				     "qcom,usb-snps-hs-7nm-phy";
>>> Not sure if the newline is necessary, but still:
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> It is over 80 - up to 90 - and we still keep 80-limit in coding style.
> Torvalds said 100 is fine a year a go or so.

Yes - when it increases the readability. When it does not, the limit by
coding style is still 80. Otherwise the coding style would be updated,
which did not happen:

https://lore.kernel.org/all/20220119160642.140e84c6@gandalf.local.home/




Best regards,
Krzysztof

