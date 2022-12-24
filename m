Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0AF655A36
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 14:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiLXNNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 08:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiLXNNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 08:13:06 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1AFDF78
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 05:13:03 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id e13so5110892ljn.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 05:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKooxm9xL5ScTSLAkqGgl8XoM29nVfbKpvwZn93/+/E=;
        b=ER0D0mgudmmoxY65pvs0+g60xHKjYJxJL6AsTSOXHitngVaXr2n2aiA9ATcm8E2hTD
         24MtS8S1xYWjCZrV4O9mlkVR1mtL+4so04j+uBKQLzHQTKoF5RKicNV/7FG9UVFbNvv7
         77CpJq5ypBZl4R9xE7NiJjzoK2AoQ0SY92vqcLvXg/h6BOdb830DGE66WPuMkxy04YYW
         NNaETJScrvH4XF/gAGHScKGTrnurfmFYjsFOjxaIa1ccx8zw/cbAHwaGsD/iBDsrCVQt
         V5r4r3FdNX82c9RlcM+VJc6H1aKfMWv1Gt52NV+vVPeMb6AsZOAuTP3ffGQ436mCXLbn
         sGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKooxm9xL5ScTSLAkqGgl8XoM29nVfbKpvwZn93/+/E=;
        b=WF50fCl2Ydc6NMeYa5fczweWM6svUqT9Y2cvsFLk7wblPMlNoJ49VBSk7sPDbg9Gnh
         ZPLYLxCgzGaf7pRFbTPyJbq0CWT9HxbZ+p4q+gyD8KrnzKALXiOY+8KPjTlfNTaiOqGT
         zlUPSERO7CF+ZUqxf4zFOsiAZ/MA/5WJ1/ksrspqsWaynL+WK2gpQvNOHHlhbeg/cslZ
         R2Lc+clufIrF8R3ELZvAa6CsT/rieNr2jClVDjybUgp9m6hImCOyXuwzT6WvyBD8juk5
         BnPb5jZIVT3LncljX2yeIBf4Y/dEZerPMyQSHDsIIELSstj+ArYpiuecOh/yoAbQU3cJ
         ouHQ==
X-Gm-Message-State: AFqh2kqEPeEg9i+3rc/doPVFOpjG2Smep7olqjJkfbAyEgKLJc3SGmox
        cRUqUHqtOv+HmTnscDIjJRjr+Q==
X-Google-Smtp-Source: AMrXdXv4wJOqvXuk4jlsUaRGiCmgix1povzrzFh6Fq2qkhg4zUzx2nNeLPIO9bUZ0hWlNgmRyFtgoA==
X-Received: by 2002:a2e:b177:0:b0:27d:3c1e:42de with SMTP id a23-20020a2eb177000000b0027d3c1e42demr3383154ljm.27.1671887581289;
        Sat, 24 Dec 2022 05:13:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bj40-20020a2eaaa8000000b0027fb76a4b44sm289495ljb.97.2022.12.24.05.13.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Dec 2022 05:13:00 -0800 (PST)
Message-ID: <6a9506a5-caf0-0977-af75-0a4e4c0e3a0f@linaro.org>
Date:   Sat, 24 Dec 2022 14:12:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/4] ARM: dts: qcom: sdx65: add specific compatible for
 USB HS PHY
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d6fcecda-2f78-bd75-579b-672f6db779a2@linaro.org>
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

On 23/12/2022 17:20, Konrad Dybcio wrote:
> 
> 
> On 23.12.2022 17:18, Krzysztof Kozlowski wrote:
>> Add SoC-specific compatible to the USB HS PHY to match other devices and
>> bindings.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm/boot/dts/qcom-sdx65.dtsi | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
>> index b073e0c63df4..d3c661d7650d 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
>> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
>> @@ -219,7 +219,8 @@ blsp1_uart3: serial@831000 {
>>  		};
>>  
>>  		usb_hsphy: phy@ff4000 {
>> -			compatible = "qcom,usb-snps-hs-7nm-phy";
>> +			compatible = "qcom,sdx65-usb-hs-phy",
>> +				     "qcom,usb-snps-hs-7nm-phy";
> Not sure if the newline is necessary, but still:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

It is over 80 - up to 90 - and we still keep 80-limit in coding style.

Best regards,
Krzysztof

