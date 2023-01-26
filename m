Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5B467CADA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjAZMYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbjAZMYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:24:24 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2991D4859C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:24:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id m7so1583038wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5pNGXCwTz1ENoQLou7f9bsrBU5EaiVdGvV9v2obRuBo=;
        b=XQqTEu19UhkD7aJwyXWepofFMTYNPVg5MUjoQokJAc8MOKKTiuCcp39R9LNPyoqYj1
         WVwVZNAZdxxSuiI/Ww/SML0loU3PMCNrsTAt1/A8HWQbhabfxjm7+XQVrxg/vsrz0emZ
         eN9S5+yCHXLWLrv1NPHwLNPqyKBslxQx4i/sMkS0fgNymEDE0z+7b6ROaQQ+iOhpLE8A
         gEfTmPlvoV7tR6RmurHTfQ+lPiURsaDE5cz03UsF7qTMl6vT7Epv9DaTtsOV/4hWq4cG
         bQhHRUo5cHLUtAqRd2E5pHE1nJw47vv5toB5jOT5J2fHIve82YptqGjqkgwv07LxVvSY
         /cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5pNGXCwTz1ENoQLou7f9bsrBU5EaiVdGvV9v2obRuBo=;
        b=QH8/gQGZsoQgiule++PFb3R/z3ircJVCELRUwgoUKuYtAnzeF7jhxIKP1kHHNDuDoO
         JeoUw1ukLth6U7J5fA98DyZsNPtPl+AWJiKixDEX47JBsbXPAdah6e43nXuJbI4QpTV8
         ASryZFPPZjSjFaJ1MGnhp5JwtLbvD/PaEEUdE8T+CQ3PImZ/ag1hxZKX7RVwLgPE3Dau
         Yo/+7i5ySArTUBqLFBoZYTEOJ2F+8PY8qlLERAoW08YVX4jwCxqh+T3P4uDiaDPj0Nlr
         AEslN3zcK06+UK0T5/N0tIuKYwlbg29DXdRnwdcO5e5hitETpoZc2Uiz/+Z1p0dY+rjB
         i4EQ==
X-Gm-Message-State: AFqh2kobF1AqrysqJ//RNMketnm5GeiRoHi3LOTVx1C8Hdyp4tg/5g8u
        0SDq8if4+XUYByeQPqKVf7N74w==
X-Google-Smtp-Source: AMrXdXv1mD7Bd2DEJwqeRZUx/xVG3lQxh5SAaI5vzwvRWUvpWrdrSRZeYzUrSTRNk3c/aSYWOuwUDA==
X-Received: by 2002:a5d:4eca:0:b0:2be:47d7:b56a with SMTP id s10-20020a5d4eca000000b002be47d7b56amr23147789wrv.11.1674735861676;
        Thu, 26 Jan 2023 04:24:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600002ac00b0029100e8dedasm1367125wry.28.2023.01.26.04.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 04:24:21 -0800 (PST)
Message-ID: <bfbff227-7a97-a45e-40b7-ed73085f9be3@linaro.org>
Date:   Thu, 26 Jan 2023 13:24:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/6] ARM: dts: exynos: add mmc aliases for Exynos4412
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230126103828.481441-1-henrik@grimler.se>
 <20230126103828.481441-4-henrik@grimler.se>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126103828.481441-4-henrik@grimler.se>
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

On 26/01/2023 11:38, Henrik Grimler wrote:
> So that mmcblk numbering is fixed for the eMMC and sdcard, no matter
> if a storage device is attached or not.  Also remove old, no longer
> used, mshc alias while we are at it.
> 
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 7b4e2c442888..9625e9fe63b1 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -28,7 +28,10 @@ aliases {
>  		pinctrl3 = &pinctrl_3;
>  		fimc-lite0 = &fimc_lite_0;
>  		fimc-lite1 = &fimc_lite_1;
> -		mshc0 = &mshc_0;
> +		mmc0 = &mshc_0; /* eMMC */
> +		mmc1 = &sdhci_1;
> +		mmc2 = &sdhci_2; /* uSD */
> +		mmc3 = &sdhci_3;

This is definitely not correct. Several boards do not have mmc1 or mmc2
exposed at all.

Best regards,
Krzysztof

