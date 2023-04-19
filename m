Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D556E7B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjDSNnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjDSNnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:43:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B6C10254
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:43:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id eo4-20020a05600c82c400b003f05a99a841so1459593wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681911794; x=1684503794;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HZA8xnxtLCau3xeUJDwqvV4qTTmMB91klxm30umz0uQ=;
        b=jJFoqGz86rmujeiO5U607w6Dnd7J3apqwykbvvt5bUCY4kIj8Cif0WANeAuVPGTEuS
         iHZ1aErIZdKRy5GmyLTblFUROizMYYFqlWXffD2cJ4QC7vUItyQOs7Hk/4ZE3i5POF+J
         5njpxQXk9ilntHb+pwHWX+kCqEIuATFOQ+0pIZ9McbSkyDDZp5mgiJ2RaGOYgU6b3Y85
         qAltwKEMXjzU9EIfegNRao6eTkOl/1cJpDHIikjk2whhPiEwe91wSFuGuSKeXtwneJkU
         ATvFEk/sATbg86Kw6v8vq+eTzH8flAlz+GVFG+/4iNyy5YNOg0ADFl+MtNUVojkrN/KC
         yptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681911794; x=1684503794;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZA8xnxtLCau3xeUJDwqvV4qTTmMB91klxm30umz0uQ=;
        b=jGEZP3RvHLKc9bowwAEBAPHCF5A1KTUefT18tFHEoWXNiqEuBp9LAVIywplBOxaKDe
         H52aUNL8iRYeCG0Zg0OA2SVGConFn+od+GcL+cAxydvz/cvGI3MaSKSmcx2you/QYUrT
         BOQFb0Vw3zHW60ZGUlarp89d/JP6EGerSZGGXuTlIAbed2sidDOR9uwUb8/qQ19/62W/
         qJpwAUkcGLX0nB/d8t1aTX/C5xy134ugCAGohYDZWAXYJ8QHSzxDN2Htm2A8jzNWegv3
         3Q8rkx1Wl7slSTahiIf6NrtdiFuYkVNlLsb0uW5O+H/zt6rg5YimsJUYAC+oXezWxdY3
         JoCw==
X-Gm-Message-State: AAQBX9e9X/R784AvUcllkJlcnUECUL+vNcDQ6ypnaDA72bAr+EsMilwS
        2jjqeOMMvSo8TiXIjwN/74XuC1HqtUxzESUM9uLQcQ==
X-Google-Smtp-Source: AKy350aCnVr5xUdDLfvotskDQKq4zjir2EkydStBZxfN4WDOoGflyfK+hy5eON1v5GoQ798VpeVv9Q==
X-Received: by 2002:a05:600c:20e:b0:3f1:76d0:8bb0 with SMTP id 14-20020a05600c020e00b003f176d08bb0mr6744673wmi.36.1681911794106;
        Wed, 19 Apr 2023 06:43:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:1360:9fbb:dfd6:2db4? ([2a01:e0a:982:cbb0:1360:9fbb:dfd6:2db4])
        by smtp.gmail.com with ESMTPSA id q1-20020adfcd81000000b002ff77b033b1sm808990wrj.33.2023.04.19.06.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 06:43:13 -0700 (PDT)
Message-ID: <661cea17-a4dd-75d1-6a7e-16efa5aea52b@linaro.org>
Date:   Wed, 19 Apr 2023 15:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH 1/2] arm64: amlogic: add new ARCH_AMLIPC for IPC SoC
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        =Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
 <20230419073834.972273-2-xianwei.zhao@amlogic.com>
 <20230419131416.cns3xvkbzjeyrnux@CAB-WSD-L081021>
Organization: Linaro Developer Services
In-Reply-To: <20230419131416.cns3xvkbzjeyrnux@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 15:14, Dmitry Rokosov wrote:
> On Wed, Apr 19, 2023 at 03:38:33PM +0800, =Xianwei Zhao wrote:
>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>
>> The C series SoCs are designed for smart IP camera
>> applications, which does not belong to Meson series.
>> So, Add ARCH_AMLIPC for the new series.
>>
>> There are now multiple amlogic SoC seies supported, so group them under
>> their own menu. we can easily add new platforms there in the future.
>> Introduce ARCH_AMLOGIC to cover all Amlogic SoC series.
>>
>> No functional changes introduced.
>>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   arch/arm64/Kconfig.platforms | 12 ++++++++++++
>>   arch/arm64/configs/defconfig |  2 ++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 89a0b13b058d..bfbc817eef8f 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -162,12 +162,24 @@ config ARCH_MEDIATEK
>>   	  This enables support for MediaTek MT27xx, MT65xx, MT76xx
>>   	  & MT81xx ARMv8 SoCs
>>   
>> +menuconfig ARCH_AMLOGIC
>> +	bool "NXP SoC support"
> 
> NXP? Did you mean "Amlogic"?
> 
>> +
>> +if ARCH_AMLOGIC
>> +
>>   config ARCH_MESON
>>   	bool "Amlogic Platforms"
>>   	help
>>   	  This enables support for the arm64 based Amlogic SoCs
>>   	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
>>   
>> +config ARCH_AMLIPC
> 
> Do we really need a different ARCH for Amlogic IPC?
> I can imagine that it's not the Meson architecture at all.
> But maybe a better solution is just to rename ARCH_MESON to ARCH_AMLOGIC?

It should be changed treewide, and is it worth it ?

Neil

> 
>> +	bool "Amlogic IPC Platforms"
>> +	help
>> +	  This enables support for the arm64 based Amlogic IPC SoCs
>> +	  such as the C302X, C308L
>> +endif
>> +
>>   config ARCH_MVEBU
>>   	bool "Marvell EBU SoC Family"
>>   	select ARMADA_AP806_SYSCON
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 7790ee42c68a..f231bd1723fd 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -46,7 +46,9 @@ CONFIG_ARCH_LG1K=y
>>   CONFIG_ARCH_HISI=y
>>   CONFIG_ARCH_KEEMBAY=y
>>   CONFIG_ARCH_MEDIATEK=y
>> +CONFIG_ARCH_AMLOGIC=y
>>   CONFIG_ARCH_MESON=y
>> +CONFIG_ARCH_AMLIPC=y
>>   CONFIG_ARCH_MVEBU=y
>>   CONFIG_ARCH_NXP=y
>>   CONFIG_ARCH_LAYERSCAPE=y
>> -- 
>> 2.37.1
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

