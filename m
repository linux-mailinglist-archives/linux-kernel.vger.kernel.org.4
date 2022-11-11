Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9652F625739
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiKKJsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiKKJsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:48:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935162A3;
        Fri, 11 Nov 2022 01:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DEC261F2E;
        Fri, 11 Nov 2022 09:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFC7C433D6;
        Fri, 11 Nov 2022 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668160077;
        bh=sHcrZjyD+JKPHYpCaB3NT+zMVU6VwkQS6kFBMLp1NZ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K1w2QIluPgNeqJDrivt/bqZr1+V48gXgZI+F4ykU9y3kuwA/jjREPKUn/7w6oQ7Xs
         Ni9KCTF2TV65gcmYq/lq5soTc70rUrpsG+Lyj+v/csenAA6VJFwQN9Gkuo19NkCgOj
         ULAlE/M5orZNDN93AbffEmyWSnYzxcD1hs9Oqeew7HVv39erJgwBbyJ848wvuJBdxn
         Esqg9lRwCPQDf5dZNrlC40JXXHYXRhFSGWNYNhXGXBqj/PBHNadt/ujhxCt9IU6Bej
         95AKTa8X92zqXJSfdM3t3u374iaT1poJSpVZdtJrmfkEvSYh02Avl2feDE1QQFaD9r
         7iGXuVw/wDfSA==
Message-ID: <e5451506-586d-9724-5455-59dafabae7ec@kernel.org>
Date:   Fri, 11 Nov 2022 10:47:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v3 3/3] ARM: dts: exynos: Rename compatible string
 property from version to SoC specific
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        'Krzysztof Kozlowski' <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com
References: <20221111032337.79219-1-aakarsh.jain@samsung.com>
 <CGME20221111031718epcas5p3df130145b4bb99424fd5aa4addf77ba5@epcas5p3.samsung.com>
 <20221111032337.79219-4-aakarsh.jain@samsung.com>
 <b766bd0b-aecc-3b9d-27df-2615d648d9bd@linaro.org>
 <010e01d8f5af$340c1a80$9c244f80$@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <010e01d8f5af$340c1a80$9c244f80$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 10:22, Aakarsh Jain wrote:
> Hi Krzysztof,
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 11 November 2022 13:41
>> To: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-arm-
>> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
>> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
>> benjamin.gaignard@collabora.com; krzysztof.kozlowski+dt@linaro.org;
>> stanimir.varbanov@linaro.org; dillon.minfei@gmail.com;
>> david.plowman@raspberrypi.com; mark.rutland@arm.com;
>> robh+dt@kernel.org; krzk+dt@kernel.org; andi@etezian.org;
>> alim.akhtar@samsung.com; aswani.reddy@samsung.com;
>> pankaj.dubey@samsung.com; smitha.t@samsung.com
>> Subject: Re: [Patch v3 3/3] ARM: dts: exynos: Rename compatible string
>> property from version to SoC specific
>>
>> On 11/11/2022 04:23, Aakarsh Jain wrote:
>>> commit "752d3a23d1f68de87e3c" which adds MFC codec device node for
>>> exynos3250 SoC. Since exynos3250.dtsi and exynos5420.dtsi are using
>>> same compatible string as "samsung,mfc-v7" but their node properties
>>> are different.As both SoCs have MFC v7 hardware module but with
>>> different clock hierarchy and complexity.
>>> So renaming compatible string from version specific to SoC based.
>>>
>>> Reviewed-by: Tommaso Merciai
>> <tommaso.merciai@amarulasolutions.com>
>>> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi
>>> b/arch/arm/boot/dts/exynos3250.dtsi
>>> index 326b9e0ed8d3..98105c64f7d9 100644
>>> --- a/arch/arm/boot/dts/exynos3250.dtsi
>>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>>> @@ -485,7 +485,7 @@
>>>  		};
>>>
>>>  		mfc: codec@13400000 {
>>> -			compatible = "samsung,mfc-v7";
>>> +			compatible = "samsung,exynos3250-mfc";
>>
>> No improvements. Changeset is non-bisectable. I said it in v1, then in v2. So
>> now third time... Don't send a new version if you are not going to fix it or
>> resolve discussion.
>>
> My bad, misunderstood, now I understood your concerns around bisectability.
> 
> I hope you mean the below:
> ------
> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> index cb166654fa81..734e53445eb5 100644
> --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> @@ -10,7 +10,8 @@ Required properties:
>    - compatible : value should be either one among the following
>         (a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
>         (b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
> -       (c) "samsung,exynos3250-mfc" for MFC v7 present in Exynos3250 SoC
> +       (c) "samsung,exynos3250-mfc","samsung,mfc-v7" for MFC v7
> +            variant present in Exynos3250 SoC.
>         (d) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
>         (e) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
>         (f) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 98105c64f7d9..a2d6ee7fff08 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -485,7 +485,7 @@
>                 };
> 
>                 mfc: codec@13400000 {
> -                       compatible = "samsung,exynos3250-mfc";
> +                       compatible = "samsung,exynos3250-mfc", "samsung,mfc-v7";
>                         reg = <0x13400000 0x10000>;
>                         interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
>                         clock-names = "mfc", "sclk_mfc";
> -----
> 
> Where mfc-v7 will be used as fallback for the older kernel which might use new dtb.
> 
> Let me know if this is not what you meant or am I still missing something?

Yes, this is what I meant. Thanks.

Best regards,
Krzysztof

