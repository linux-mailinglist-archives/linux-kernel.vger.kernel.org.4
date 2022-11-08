Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F158620F1D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiKHLav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiKHLao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:30:44 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD8B1004C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:30:42 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u2so20665535ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Df/2yQeWb1d9To2ggEgy9JGgAa1dKPEwPJTnp7RFKKI=;
        b=EGFgZfWK7iun8X4qrBI1QRrVUzXrZHgr2HFTDssPuXHld6e8Xff5dU+7CK6LgoZcKj
         VssQGbAgiwR9Gzn3En0qjbNygDiU+SR1mlKF773u8yeQjlcMYsBcBWen7rJGWtLa5Vwe
         GDDdv0ND0P0qgO4+rk5YfUdGa6HupktHiuwh05B3qfqYD9ew/E7bbwSiOsKESe9ZUo/y
         u+gGusZQi8Gp2XOH36SN6AATQzDVT3HlIEfFzGpnCuGaHzS1kitrfKBRiliff+su6GC6
         7csYZ1r6Ksqe/Vvcf96JWHr3OzVSLAaD94108//PzpeM1OOMi1YEGxVGRg8Hh9BgEsIG
         mv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Df/2yQeWb1d9To2ggEgy9JGgAa1dKPEwPJTnp7RFKKI=;
        b=bYtgEOnv+eskerHUyd0MwkcVp7cjgsYiRVFH0IUQ3bkwaD03vjDNLlgaRqKDnf6rZ+
         wptlSZhKfAOUnqP7hNGVHuPx2xRrrGSR1/mxYeyiQZIvJwDOI3Ts9cN16zyYILn+jgE6
         v8czprOsDWeT34DAKddqg4uvqJEVuApq/PxuIN7ooUSiCqnIiAYsw9gsc5nJ3vlKPaF/
         ATk+hgg1Hv0q34KU5Gyka11FIKVE6CAhFnyLVzad/q3zzR8JHvoYKkpDKeaC0ZI2fFYJ
         ApVVMbKf7s9LhCPfYW5ugR1NeM3RFUq9YigP43/xJ23pfxAY9xurkd5Vf4v2E/raA/Gv
         tG2A==
X-Gm-Message-State: ACrzQf019FJLD40MYulCs5P8gy8vwO/CO4BZzhssJYf5T02rlFAhTUN5
        YUDcmaI9VqmLQV8hkEOSrONtJg==
X-Google-Smtp-Source: AMsMyM4e3RprgOpTHPLpEtvIddL3m+QxWSPCTr4lHwgBI3qmC3SEGP42bF556j32ASbvjV3XzlbtRg==
X-Received: by 2002:a2e:550:0:b0:277:e8c:a5a4 with SMTP id 77-20020a2e0550000000b002770e8ca5a4mr7011231ljf.311.1667907040968;
        Tue, 08 Nov 2022 03:30:40 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id n1-20020ac24901000000b004971a83f839sm1744968lfi.39.2022.11.08.03.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 03:30:40 -0800 (PST)
Message-ID: <c199600a-aad9-5639-ea57-a4d59d719ade@linaro.org>
Date:   Tue, 8 Nov 2022 12:30:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for gxp
 gadget
Content-Language: en-US
To:     "Yu, Richard" <richard.yu@hpe.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20221103160625.15574-1-richard.yu@hpe.com>
 <20221103160625.15574-3-richard.yu@hpe.com>
 <b85230d4-8fce-ba49-0d6b-8c4d20132cda@linaro.org>
 <SJ0PR84MB2085E6B922DAF1070DC802EF8D3C9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SJ0PR84MB2085E6B922DAF1070DC802EF8D3C9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 21:16, Yu, Richard wrote:
> Hi Mr. Kozlowski,
> 
>>> +
>>> +  vdevnum:
>>> +    description:
>>> +      virtual device number.
> 
>> That's unusual property... Why numbering devices is part of DT (hardware description)?
> 
> In HPE GXP virtual EHCI controller chipset, it can support up to 8 virtual devices(gadgets). Each device/gadget will be represented by a bit in 8 bits register. For example, the interrupt register bit 0 indicates the interrupt from device 0, bit 1 for device 1 ... so on.  When a user defines a device/gadget, he/she can define the device number as between 0 and 7. Thus, the driver can look up to the bit position. That is why we have numbering devices as part of DT.

Wrap your lines properly, it's impossible to reply in-line to such messages.

Then how do you specify two devices? You allow here only one, right?

Which bit in which register? Your devices have separate address space,
so why they cannot poke the same register, right? Then just always set
it to 0...

I might miss here something but so far it looks to me like some hacky
description matching the driver, not hardware, not existing bindings.

> 
>>> +
>>> +  fepnum:
>>> +    description:
>>> +      number of the flexible end-points this device is needed.
> 
>> Similar question.
> 
> In HPE GXP virtual EHCI Controller chipset, there is a flexible End-Point(EP) pool. Each flexible EP has its own mapping register. The mapping register bit 0 to 3 is for device number (vdevnum) and bit 4 to 7 is for EP number inside the device. The device driver configures the mapping register to assign a flexible EP to a specific device.  Here, "fepnum" is the input letting the driver know how many EPs are needed for this device/gadget.

Nope. So you create here some weird IDs to poke into syscon register.
First, syscon has offset if you need. You could treat it maybe as bits?
I don't know... but even then your design is poor - two devices changing
the same register. Even though it is sunchronized by regmap, it is
conflicting, obfuscated access.

Best regards,
Krzysztof

