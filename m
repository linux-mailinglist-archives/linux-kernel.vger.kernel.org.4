Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E2C617C9D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiKCMeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiKCMeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:34:01 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A53CE16
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:34:01 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c15so1064985qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9I5y8XG5Lzzo9JNEAsXYJPQ1gGgL0X0jO8Cdwi3LOzw=;
        b=v8MwxfmIzWn1eH+KFIoW3InBFOtvk8fX28/1rriqq1bjbWlMFSu+ykh5oBXtruv52u
         nabmU3A+pjy25qRm93hX9QnIK2VtbhpMKCfpK+dz6wLLYY1tC1EvcNnphNF8xUURm6FE
         jjd2OFM3F7fpBj5tC979eQE34I73e+KG2dkg3oUsiyeSkcc/VNU815O/zmEyzkHRoiLI
         WfS7YUYKJBw0CwhPJrWFqnDBNSiWY7BQfaByEh0ygCInNHbwV9llZO6yYLZ/osutUNYn
         EOrfn0QdP9se4DFA6sx6xD0SGGhUAD75oN7AEwQJ3amZJzHuUOHD+l61wRirsupPKAW6
         oBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9I5y8XG5Lzzo9JNEAsXYJPQ1gGgL0X0jO8Cdwi3LOzw=;
        b=pf9wYZdsUQ4dRDz+7S9YYadeFNxbBsLRLR+elkjX2KljGSgaiw86Rwr9CoRYoNu6SW
         MTuFtydn+9iDw2sZQnECyF+RSrvpYDBwqHEQFzIqzpoEHkv4AuIpNcUM7OQYIYkS53rP
         1shy6kYY/bwXx3HIVHX/t+4e6Jyf/9ziDNB9TxwqsGezd5gJ/PACRN3AjhKaj3b4Zrh0
         ozQnkE6SlfK9O89V3VgBaG0ZG1eWmXoYiNca3yu+S/2pF32GGvgmBUobxmTmlOpksX0h
         Xon3lloGQMS4dkl4lolm2I07Pjf59Win3VsNeYcYAJ+uF8LupHeXsgZ4ByZamAVdhimz
         8QUg==
X-Gm-Message-State: ACrzQf0/jfjQEMdD/+7uRYPCr1hqz90Ixozf1qphyR6/0SP3XN1TYqTl
        x9Bx4q/gJpGLgoaKYIFkCteQSDiXPPEd8w==
X-Google-Smtp-Source: AMsMyM6L7ER32z+7Wwl3dzVJlPbwHGiRjuDj4pSa8q9v0F9hXqUeeu8liI/Ok+ZlIdD3Dn/SMMHc1Q==
X-Received: by 2002:ac8:6a12:0:b0:3a5:27f2:4586 with SMTP id t18-20020ac86a12000000b003a527f24586mr16470769qtr.244.1667478840200;
        Thu, 03 Nov 2022 05:34:00 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a268500b006fa4b111c76sm684680qkp.36.2022.11.03.05.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 05:33:59 -0700 (PDT)
Message-ID: <352e31de-cb79-f08e-b817-2712d97b84f1@linaro.org>
Date:   Thu, 3 Nov 2022 08:33:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/3] arm64: dts: exynos: Rename compatible string property
 from version to SOC specific
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
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
References: <20221102130602.48969-1-aakarsh.jain@samsung.com>
 <CGME20221102125816epcas5p23e16fefd6b820e7dd7d9a93f0d48f40d@epcas5p2.samsung.com>
 <20221102130602.48969-3-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102130602.48969-3-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 09:06, Aakarsh Jain wrote:
> commit "752d3a23d1f68de87e3c" which adds MFC codec device node
> for exynos3250 SOC. Since exynos3250.dtsi and exynos5420.dtsi are
> using same compatible string as "samsung,mfc-v7" but their
> node properties are different.As both SoCs have MFC v7 hardware
> module but with different clock hierarchy and complexity.
> So renaming compatible string from version specific to SOC based.
> 
> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
> Fixes: 752d3a23d1f6 ("ARM: dts: add MFC codec device node for exynos3250")

There is no bug to fix and backporting is forbidden as it breaks the
usage of DTS in older kernel.

> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 326b9e0ed8d3..98105c64f7d9 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -485,7 +485,7 @@
>  		};
>  
>  		mfc: codec@13400000 {
> -			compatible = "samsung,mfc-v7";
> +			compatible = "samsung,exynos3250-mfc";

The change is non-bisectable and breaks using DTS in older kernel.

Best regards,
Krzysztof

