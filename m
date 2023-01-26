Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAAC67C951
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbjAZK76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbjAZK7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:59:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7EE6D342
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:59:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h12so1338550wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XGNWex4aZN5UnK5VI5imptsnGrCfs7V+r6MZ8tVGZ/Y=;
        b=LottchB5TxsgpB2icKKUb0uQvPmmooqPUnNLmFanJPZ6UI6Mf4I57CctxPo91SuO36
         k0KBNcTJDROO4xdaMAayMBLctuyRRTLZ6/+pm/dJXv4l36tYu1pypCuN8rIPFbUFmHTS
         9r+za/3N3agXVpY4/yoOnN9gvA/O2JKvnm2t48IuD4vOJpWnHhbKrd8Q+chuItyScfy6
         y7B2wNE+M3R3vP5+HBu96uavIjwrNP98vXL/8QgDSgKeGXKepW7mynyutZyMzhfExCIv
         wbDQZxi9GryEVOsaMR/lAMUNAq4WdyB6b2Mf+TkibwVTFtdM1dCXaJ2wOEUhHdvxgh9I
         z81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGNWex4aZN5UnK5VI5imptsnGrCfs7V+r6MZ8tVGZ/Y=;
        b=fNg3ymi0KYTu049s45bx2IhrIsMOG5ttNgmAvusk0P3Srd70MXGPoFOQ+XJBMGi7QT
         /9FsIWr7kr2oSgb57oqeFCzesNfqTgiggR2M/bRo2h7t46T2B6t5xmDZdMQCEtCp5/IC
         A1FzgRTIHzzGhArhu16/ofr0FMzna/Y6W2Tf9W75aJZEIgb65jbDMPytypBAUdQO+LHM
         hNp3QXlU0ukVDbVmOJPaNdenQf1F41wMcXQVHzrBwPMV3QE2bRXEvfZHO9UEXvK5Qb04
         OXgFJI6wqRbwVOWaWyJ28RBNPOGSnJEqi/ND+kLBY4ocNskQjsP+r32PgSWaWmKZRYC/
         8p8g==
X-Gm-Message-State: AO0yUKWDE2avk426b0er2v2TjEqO5oCBxA15R3qhRclM+yMqtkp2IhPm
        a+AjCIGrDMrCjnf3uaGAbixPCg==
X-Google-Smtp-Source: AK7set/IByWURjBOmBXELn9EmHeTvWxS4Hd9iEsMvqCqp8M/Q+k2MH5dLTurrxVoafBryTbY/LggbQ==
X-Received: by 2002:adf:ea01:0:b0:2bf:b35d:2797 with SMTP id q1-20020adfea01000000b002bfb35d2797mr7800062wrm.11.1674730764134;
        Thu, 26 Jan 2023 02:59:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e7-20020adfe387000000b002be15ee1377sm986687wrm.22.2023.01.26.02.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 02:59:23 -0800 (PST)
Message-ID: <d8f5fa57-da3a-09f9-e297-197068264d26@linaro.org>
Date:   Thu, 26 Jan 2023 11:59:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/9] ARM: dts: exynos: move exynos-bus nodes out of soc in
 Exynos5420
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?Q?Martin_J=c3=bccker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230125094513.155063-1-krzysztof.kozlowski@linaro.org>
 <CGME20230125094529eucas1p29b5f25af2c658abef13a93c49eca975f@eucas1p2.samsung.com>
 <20230125094513.155063-2-krzysztof.kozlowski@linaro.org>
 <cd42b8c9-a79a-068c-a967-810c05e818bd@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cd42b8c9-a79a-068c-a967-810c05e818bd@samsung.com>
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

On 26/01/2023 10:47, Marek Szyprowski wrote:
> Hi Krzysztof,
> 
> On 25.01.2023 10:45, Krzysztof Kozlowski wrote:
>> The soc node is supposed to have only device nodes with MMIO addresses,
>> as reported by dtc W=1:
>>
>>    arch/arm/boot/dts/exynos5420.dtsi:1070.24-1075.5:
>>      Warning (simple_bus_reg): /soc/bus-wcore: missing or empty reg/ranges property
>>
>> and dtbs_check:
>>
>>    exynos5420-arndale-octa.dtb: soc: bus-wcore:
>>      {'compatible': ['samsung,exynos-bus'], 'clocks': [[2, 769]], 'clock-names': ['bus'], 'status': ['disabled']} should not be valid under {'type': 'object'}
>>
>> Move the bus nodes and their OPP tables out of SoC to fix this.
>> Re-order them alphabetically while moving and put some of the OPP tables
>> in device nodes (if they are not shared).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Frankly speaking I'm not very keen on moving those bus nodes out of 
> /soc. Technically speaking this is definitely a part of soc and doesn't 
> make much sense outside of it. IMHO they describe SoC hardware details 
> and they might be moved somehow under clock controller device(s), 
> although this would require some changes in the bindings and drivers.

That's the only way to fix it without change of drivers any ABI
compatibility issue. The same we do for Qualcomm interconnects, e.g.
arch/arm64/boot/dts/qcom/sm8450.dtsi where some interconnects have some
do not have MMIO space.

I want to achieve finally clean dtbs_check run for all Exynos sources.
The in-tree bindings already pass, so now I am fixing the ones coming
from dtschema (simple-bus.yaml in particular).

If you have any other idea how to seamlessly clean it up, I am happy to
hear. But I guess the main problem is that no one is being paid for
doing anything for Samsung Exynos, so for free not many put much effort
into working on it.

Best regards,
Krzysztof

