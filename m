Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61A66D0CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjC3R3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjC3R27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:28:59 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084B6DBD1;
        Thu, 30 Mar 2023 10:28:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so8547780wmq.3;
        Thu, 30 Mar 2023 10:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680197336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Y2DqD4b0TEjJPvYx6jYpEw4YYcOZf2U/uI5AHnyKKE=;
        b=WFMeZNzYNRmA4eopOnR7jiHne/7tIemjxw8rqSTQ8QSkYJm5WXH6WM/c8bQ5cx/8/q
         TPvVjODX1ArBalsWhxli6d0h32H5lIa5OcwgRQri6KepMhN8aRC7jYlFFQA4YlNVcJtr
         BbCKcij4XvZm96F1e3spFuhovODz9yIoSRH5dL9ckR+9wi4Qln2yppZp4ccggPnOmdLA
         Rv7C7qjTwQmmJu9TO4NJkzI00doWzskFpMFu/d3mQZqTRk1nuIFS/7AskxbOa1SXhZrK
         bVLTzKaTrM1xqYip2iVtpXxXpcOD3Ak6LvLLLC0+9McOowfX/cVnwFCh5W16YhyDVIP2
         gDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680197336;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y2DqD4b0TEjJPvYx6jYpEw4YYcOZf2U/uI5AHnyKKE=;
        b=GDDniWyENuDj4ng0Q/cSex+XmEqS7KfSe8Bh3qi3+MRXtxFdShseZ1x7JEWnB5kA3f
         XSWlZ3XLLjUp1wGu7zKo5pvHzt3yP45FWbDrc+DcshFJkUsOzCJPqCIxMjWH6OVvet8C
         NtxaNtHeZEdMxlNtT46xUvHzRpgm8+nnWURfCpuejeT7d7DQPc7vRz2poyI5ZJFEqLum
         pQ0rAGX3Thd1lO+/mueYk5HbFEoI/tqBcKxb0s9ZWjQImidvLzTkIxqA5qK0ZorlK63M
         zA4CFIztfGn1X47c8jBU2kBkCJDX/jEXk7vHlnYkydAk+fx5w0YOMaCnBzPhy6FHgJWQ
         sL4g==
X-Gm-Message-State: AO0yUKUh0aLebCjBIWcCHX56goFLdQPU4nQqXC/ha72WO2YkBgATrsGe
        A5DN7jf5XiSTZ2394fzQFKo=
X-Google-Smtp-Source: AK7set9MIenmW0wOxrwzuKWQ9Susz0ahiNwcPlAjmAJVYRoVF2Kv7qkJghXMUIEjEKEN6BgtEX0Mfg==
X-Received: by 2002:a05:600c:d5:b0:3ed:bc83:3745 with SMTP id u21-20020a05600c00d500b003edbc833745mr17495399wmm.25.1680197336468;
        Thu, 30 Mar 2023 10:28:56 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y5-20020a1c4b05000000b003e91b9a92c9sm6507980wma.24.2023.03.30.10.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:28:55 -0700 (PDT)
Message-ID: <c575ac46-28bf-254f-a3c1-e30885ba7933@gmail.com>
Date:   Thu, 30 Mar 2023 19:28:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 08/17] arm64: dts: mediatek: add mmc support for mt8365
 SoC
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-8-0003e80e0095@baylibre.com>
 <c785d80f-e443-cae4-1e17-b79eb2dc385c@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <c785d80f-e443-cae4-1e17-b79eb2dc385c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/2023 15:21, AngeloGioacchino Del Regno wrote:
> Il 29/03/23 10:54, Alexandre Mergnat ha scritto:
>> There are three ports of MSDC (MMC and SD Controller), which are:
>> - MSDC0: EMMC5.1
>> - MSDC1: SD3.0/SDIO3.0
>> - MSDC2: SDIO3.0+
>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8365.dtsi | 39 ++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
>> index 687011353f69..a67eeca28da5 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
>> @@ -399,6 +399,45 @@ usb_host: usb@11200000 {
>>               };
>>           };
>> +        mmc0: mmc@11230000 {
>> +            compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
>> +            reg = <0 0x11230000 0 0x1000>,
>> +                  <0 0x11cd0000 0 0x1000>;
>> +            interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_LOW>;
>> +            clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
>> +                 <&infracfg CLK_IFR_MSDC0_HCLK>,
>> +                 <&infracfg CLK_IFR_MSDC0_SRC>;
>> +            clock-names = "source", "hclk", "source_cg";
>> +            status = "disabled";
>> +        };
>> +
>> +        mmc1: mmc@11240000 {
>> +            compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
>> +            reg = <0 0x11240000 0 0x1000>,
>> +                  <0 0x11c90000 0 0x1000>;
>> +            interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_LOW>;
>> +            clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
>> +                 <&infracfg CLK_IFR_MSDC1_HCLK>,
>> +                 <&infracfg CLK_IFR_MSDC1_SRC>;
>> +            clock-names = "source", "hclk", "source_cg";
>> +            status = "disabled";
>> +        };
>> +
>> +        mmc2: mmc@11250000 {
>> +            compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
>> +            reg = <0 0x11250000 0 0x1000>,
>> +                  <0 0x11c60000 0 0x1000>;
>> +            interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>;
>> +            clocks = <&topckgen CLK_TOP_MSDC50_2_SEL>,
>> +                 <&infracfg CLK_IFR_MSDC2_HCLK>,
>> +                 <&infracfg CLK_IFR_MSDC2_SRC>,
>> +                 <&infracfg CLK_IFR_MSDC2_BK>,
>> +                 <&infracfg CLK_IFR_AP_MSDC0>;
>> +            clock-names = "source", "hclk", "source_cg",
>> +                      "bus_clk", "sys_cg";
> 
> clock-names for this do fit in one 90 columns line.
> 
> After compressing it,
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

I applied the patch and dropped you Reviewed-by tag. I think it depends on the 
taste of everybody how you prefer to structure this. I've also seen that on 
boards you care (mt8183 in that case) there a clocks that don't adhere to the 
criteria you mention here ;-)

Anyway many thanks for reviewing this and all the great work in general. 
Honestly I feel I didn't made justice by dropping your tag, but as you stated so 
explicitly... :)

Regards,
Matthias
