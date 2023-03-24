Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928656C7D30
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjCXL3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCXL3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:29:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F581ABCF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:29:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ek18so6653680edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679657369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBYZAHJ4oF06kqEyxwlGgNiRWjRifAoB3O7aBMX2ZGQ=;
        b=lfpCU7UXubnZ6VCwtJq39UmJ/DpJcQAIzhTHuxxWf+LeDLHMq6sDOUOKW2kyZ2B2Qy
         QyWbPBs86cM0ZIraepVH+TRXpMh6p9DKhjM3qej/Cjoh8kaNOYC8kPdZl2NCSYyTebAV
         djGswrREiaH/F2uUbRa0T0YpeFJhVMeXij0BbQpAkHoUbzfGfXLvIi2akG9yCD3PGuaD
         NynZeaomh7rzdSsEWYqvPQ7sMwrqKW1OKsXITdOJzrF2f2cltDRWmOkwPFAluLYF2xtI
         rlnCmWqC76XzKZadNwoPOB11v1lmK9/X1N5FH9x8lkWnEgeW15EQbYyY0bcLD4sDv46a
         Oscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679657369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBYZAHJ4oF06kqEyxwlGgNiRWjRifAoB3O7aBMX2ZGQ=;
        b=1oaQbJSq9nicigpO5JbDqM/TiZ1kMafqjHxIQBkRsVJ/momwV+QxoJG4xwMJ6NmzvJ
         +pbg2DwNCQDxfHnuN8jOKCofzn6Tcch5omP7s8pDcfW+XmHREKZzY2wuA0e27d3EdMQH
         OAPS3BtgyR9fvYppjabtACYBkg1mTSoeKLFkXKhN3Djfb1FWSYuSpw5eOtyGBbDm/nmT
         AvBedQxASjz0L/adS5eDFxVMo4uy5bRKU2WQYz6Tt1ejVh2iaK9u5e7UPKsTjqagKnRj
         hVswq/AlTv3quk4CSx+xgqGg3zL2G63AwnhohhcF84RjVGPMylTfT9VxFvc3dJ8mwz2S
         NFIw==
X-Gm-Message-State: AAQBX9dZmiX1dHDAvBkKzDw5idyhBrSHA3MEx6RlQvFq8SsBRnCFY6Ck
        8F1UOTT7IcXKohEt1nJ6WzYaiQ==
X-Google-Smtp-Source: AKy350ap/qXI7A1sMp8C4oUtWf50SlQntYwZedDuCHwbGnlHGF5tBBAtbSvocbO5enonMQHKR7kEDA==
X-Received: by 2002:a17:906:40c7:b0:930:7324:2766 with SMTP id a7-20020a17090640c700b0093073242766mr2059087ejk.35.1679657369098;
        Fri, 24 Mar 2023 04:29:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3027:fb0b:ae08:588? ([2a02:810d:15c0:828:3027:fb0b:ae08:588])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906b10700b0092f38a6d082sm10094107ejy.209.2023.03.24.04.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 04:29:28 -0700 (PDT)
Message-ID: <4e3e6d50-c6ba-985d-82e6-df52ef17d174@linaro.org>
Date:   Fri, 24 Mar 2023 12:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 2/2] ARM: dts: exynos: add mmc aliases
To:     Henrik Grimler <henrik@grimler.se>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, virag.david003@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Valentine Iourine <iourine@iourine.msk.su>
References: <20230316211558.8526-1-henrik@grimler.se>
 <20230316211558.8526-3-henrik@grimler.se>
 <216262b8-fe48-6696-17a4-eaa82e776db7@linaro.org> <ZBds5NFv1Lr8k0jk@L14.lan>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZBds5NFv1Lr8k0jk@L14.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2023 21:13, Henrik Grimler wrote:
>>>  
>>> +	aliases {
>>> +		mmc0 = &sdhci_0;
>>> +		mmc2 = &sdhci_2;
>>
>>
>> Why this is 2? Aliases are continues and match the board. For example
>> Universal calls this mmc1 and the next mmc2, not 3.
> 
> Not sure I follow, Universal calls sdhci_2 mmc1 in schematics? (I have tried searching for
> schematics but cannot really find anything about this board)

Yes. The alias numbers are the numbering exposed on the board. This
might or might not match original numbering. If you have a development
board with a SoM, pretty often not all interfaces, let's say UARTs, are
exposed. SoM might have 10 UARTs, but board has only 4 and numbers them
UART0-3. Aliases should be 0-3, not 0, 5, 7, 9.

> 
>> I bet it is the same on Trats and all other boards.
> 
> Sure, I can change to mmc0, mmc1 for all 4210 devices.

Yes, please.

> 
>>> +		mmc3 = &sdhci_3;
>>> +	};
>>> +
>>>  	chosen {
>>>  		bootargs = "root=/dev/mmcblk0p5 rw rootwait earlyprintk panic=5 maxcpus=1";
>>>  		stdout-path = "serial2:115200n8";
>>> diff --git a/arch/arm/boot/dts/exynos4412-itop-elite.dts b/arch/arm/boot/dts/exynos4412-itop-elite.dts
>>> index 6260da187e92..0e5419c0eaff 100644
>>> --- a/arch/arm/boot/dts/exynos4412-itop-elite.dts
>>> +++ b/arch/arm/boot/dts/exynos4412-itop-elite.dts
>>> @@ -20,6 +20,10 @@ / {
>>>  	model = "TOPEET iTop 4412 Elite board based on Exynos4412";
>>>  	compatible = "topeet,itop4412-elite", "samsung,exynos4412", "samsung,exynos4";
>>>  
>>> +	aliases {
>>> +		mmc2 = &sdhci_2;
>>
>> mmc1
> 
> Ok, will change.
> 
>>> +	};
>>> +
>>>  	chosen {
>>>  		bootargs = "root=/dev/mmcblk0p2 rw rootfstype=ext4 rootdelay=1 rootwait";
>>>  		stdout-path = "serial2:115200n8";
>>> diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
>>> index ca8d42b2ce3b..7bc6968af9c3 100644
>>> --- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
>>> @@ -23,6 +23,10 @@ memory@40000000 {
>>>  		reg = <0x40000000 0x40000000>;
>>>  	};
>>>  
>>> +	aliases {
>>> +		mmc0 = &mshc_0;
>>> +	};
>>> +
>>>  	firmware@203f000 {
>>>  		compatible = "samsung,secure-firmware";
>>>  		reg = <0x0203f000 0x1000>;
>>> diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
>>> index 82aed59cba7c..e6b949c1a00f 100644
>>> --- a/arch/arm/boot/dts/exynos4412-midas.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
>>> @@ -25,6 +25,9 @@ / {
>>>  	aliases {
>>>  		i2c11 = &i2c_max77693;
>>>  		i2c12 = &i2c_max77693_fuel;
>>> +		mmc0 = &mshc_0;
>>> +		mmc2 = &sdhci_2;
>>> +		mmc3 = &sdhci_3;
>>
>> This is actually correct.
>>
>>>  	};
>>>  
>>>  	chosen {
>>> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> index 25e082fda955..45ef7b7ba7e0 100644
>>> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
>>> @@ -13,6 +13,11 @@
>>>  #include "exynos-mfc-reserved-memory.dtsi"
>>>  
>>>  / {
>>> +	aliases {
>>> +		mmc0 = &mshc_0;
>>> +		mmc2 = &sdhci_2;
>>
>> This is also correct.
>>
>>> +	};
>>
>> For all other cases, where schematics are missing, just make them linear.
> 
> Alright, will do in next version, thanks for the feedback!
> 


Best regards,
Krzysztof

