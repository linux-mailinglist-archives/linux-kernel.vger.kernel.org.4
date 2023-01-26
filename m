Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D8767CCE8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjAZNzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjAZNzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:55:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBE0B2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:54:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so1166581wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VOWkcYiJEYSOZi2GcxiIbR4PFJ+2cQXy9po2yEM4hSM=;
        b=v+tL5e3nxmEUzfro8VIEgJVROZBG/otDR6RgziVLGb1KhQvonKbWDXNabkBdEg+1j+
         V7HhfOUmaH0V+x3uEOh2veT8ApPyz3pb36i/Odqc/4A/9qL7mLG6Ojgi8q0fuSB9LyE1
         vQajVyyKyQhiNkPmdWA9O10seinP48xPKvVNSe6abihWUJ9dEY/lWBE6Jyyea2E6m8I1
         GAUgnXQ+Hcwi8jN97KXk2ct8IYHo6exAgXyP9YQrRhqiy5zbRKXQhOwLwPnCDOD835ar
         iLJeuWT9s7g/T0PaAtNUHYV11R2AN7bIT994oWYyQGHqBEL/7cWJiY3iwez7C5b3LG7i
         RVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOWkcYiJEYSOZi2GcxiIbR4PFJ+2cQXy9po2yEM4hSM=;
        b=U8HEwehjVIRE1E2V5derb65q3JQq5H8+JzLm5JvWRm656ooS3GsI/CFs9kf3BfGlWs
         LI1Y4s7JV2qgsaRsH+dEIwtRYqkW1GL9Q2nfDb5Jtl22lNnMEVjTTHl/dTEdn+puUn4z
         9EyBwbtc8UN/XwgXQzFqCSqXNR1uQfye6HJg+beHl9GNLTx7e8Rfa7etVkf40YjcLXvP
         4i1LelNQdW+11ucuSi6/DBP+JvBW/FEm5NwBmVmuONHBNuwo4F33yijec4CLI2GOYA9p
         41P+0GRlhQTMM8C5ODc4zwImCAEiYATY6BA9YmzX9OPITh8F19j+f38YnX9Hov2waS6y
         /ogg==
X-Gm-Message-State: AFqh2krcanLtH7+S57c8gScoPafnMtT+2uQV+ShVUmfoYUR6ebFYdeNW
        UoiIWMNQmD1RijaX2e0WIXQfTw==
X-Google-Smtp-Source: AMrXdXteF0iTaHq1hlDgy7GniH4hSyHqI8kOZKBVywiptyRXydiRVvCim8tyKFLJ6pKOUYCzJZ9mhw==
X-Received: by 2002:a05:600c:6011:b0:3cf:85f7:bbc4 with SMTP id az17-20020a05600c601100b003cf85f7bbc4mr35059143wmb.2.1674741287361;
        Thu, 26 Jan 2023 05:54:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b32-20020a05600c4aa000b003db0cab0844sm1426678wmp.40.2023.01.26.05.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 05:54:46 -0800 (PST)
Message-ID: <29f1ddef-6165-951c-946c-661adf620442@linaro.org>
Date:   Thu, 26 Jan 2023 14:54:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] dt-bindings: usb: samsung,exynos-dwc3: allow unit address
 in DTS
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230125175943.675823-1-krzysztof.kozlowski@linaro.org>
 <20230125211329.GA2899932-robh@kernel.org>
 <afce38b0-be90-a3b5-f181-a88ad3025bd9@linaro.org>
 <CAL_JsqKpibaWgWXwhNFQ4U_tT0cdvUMO4attSsYqoSFmbq4RZQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqKpibaWgWXwhNFQ4U_tT0cdvUMO4attSsYqoSFmbq4RZQ@mail.gmail.com>
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

On 26/01/2023 14:41, Rob Herring wrote:
> On Thu, Jan 26, 2023 at 4:48 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 25/01/2023 22:13, Rob Herring wrote:
>>> On Wed, Jan 25, 2023 at 06:59:43PM +0100, Krzysztof Kozlowski wrote:
>>>> The Samsung Exynos SoC USB 3.0 DWC3 Controller is a simple wrapper of
>>>> actual DWC3 Controller device node.  It handles necessary Samsung
>>>> Exynos-specific resources (regulators, clocks), but does not have its
>>>> own MMIO address space.
>>>>
>>>> However neither simple-bus bindings nor dtc W=1 accept device nodes in
>>>> soc@ node which do not have unit address.  Therefore allow using
>>>> the address space of child device (actual DWC3 Controller) as the
>>>> wrapper's address.
>>>
>>> The correct fix is 'ranges' should have a value. Though the whole
>>> wrapper thing when there are no registers I dislike...
>>
>> You mean something like this (diff against this patchset):
>> ----------
>> diff --git a/arch/arm/boot/dts/exynos54xx.dtsi
>> b/arch/arm/boot/dts/exynos54xx.dtsi
>> index 08786fd9c6ea..75b6f9678672 100644
>> --- a/arch/arm/boot/dts/exynos54xx.dtsi
>> +++ b/arch/arm/boot/dts/exynos54xx.dtsi
>> @@ -142,16 +142,15 @@ hsi2c_7: i2c@12cd0000 {
>>                         status = "disabled";
>>                 };
>>
>> -               usbdrd3_0: usb-wrapper@12000000 {
>> +               usbdrd3_0: usb-wrapper {
> 
> Why did you drop the unit-address? Unit-address is valid with 'reg' or 'ranges'.

I misunderstood your comment then. To which problem did you refer with
"The correct fix is ranges ...."? To my understanding this only changes
the unit address, so I won't have to change the node name
usb->usb-wrapper. Except this, my patches having empty ranges are
equivalent.


> 
>>                         compatible = "samsung,exynos5250-dwusb3";
>> -                       reg = <0x12000000 0x10000>;
>>                         #address-cells = <1>;
>>                         #size-cells = <1>;
>> -                       ranges;
>> +                       ranges = <0x0 0x12000000 0x10000>;
>>


Best regards,
Krzysztof

