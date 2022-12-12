Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744F96498CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiLLGCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLLGB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:01:56 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF755F53
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:01:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jn7so10979784plb.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CtZbo9Uwr6mAiSS4K9joB67mf1cSBtb5VzmSLOnn2BA=;
        b=feGDuEqDfW7doSqcTAYoSzv+D7I72/VtlAP9SODJ0tmxCS82qjFyPUpdAUHMt6tMy8
         kmKjYZcnuQw23DqrQxUbYDreyr0qKhDF30tJKb/H0zThXZXWmOdMNQqL+8vtCjTVrzpf
         /+fDjiuHjCPjmd6qXQyQvxaqXqIOtoqrw4lF9nR1hBuCJcFBdaGPTCUEYir4n35JnuUg
         ZQvXxBiVf73Zyj8nGG3yzL5mwNzSVlGHCNuTbiQTxO2sltAjyFdzQbXSKyV3taP/Ohy7
         z4aauu+sNzrZJWy9nZaH7UonI8WKyvnnfrr55oqzhZQek7MK5UZvLx4HHDaSlSUS8Djw
         ahWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtZbo9Uwr6mAiSS4K9joB67mf1cSBtb5VzmSLOnn2BA=;
        b=1VeUrA192xExsJwiTmTJMFR/aaAef50qeJGTsd6XyUfO5Rj8iM13YQu3DsixuKoPrW
         gxq25M2v3aZRKubyWOEZKiPbE3fmSYsNz1xKPeZ5B2e4TTCHeiRh1KTzFxzBYQ0KSriI
         ul9CNsXuoRP5zZN5pn/RFs8vX27KMt4J9YWmULY2QCrlyf0c5tvmaSyUGZiT3FlDjRt2
         /d7T5O4kgLU0fhtKh7sYI/NcUAEct5OEQzNcmPSY0eb8XojCuqmPGKDr2wslozYqcdiD
         ckllpaPlWr6IExcG/8cwz2gxn8y8ziTyzXhoonHIqpmLSc0I1v6Yl7Kr0p6W5G4CIeIY
         dYHg==
X-Gm-Message-State: ANoB5plmvVDQYwQjaQZdIonFfyOXuDixfZ5dVNfO+98tmfjxyG3v0J+w
        UeYVL8jJp0ilBmEFNL7WXaUw4w==
X-Google-Smtp-Source: AA0mqf5+eaVtJ2ibhZx/7OHXPEfud2Yg6uvPqQP6gHqOu8YKIq3xFBm7jDraoJAlecduL321ZZVFxw==
X-Received: by 2002:a17:902:e311:b0:189:dc9e:cef3 with SMTP id q17-20020a170902e31100b00189dc9ecef3mr13725691plc.16.1670824915071;
        Sun, 11 Dec 2022 22:01:55 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090301ce00b0017fe9b038fdsm5344579plh.14.2022.12.11.22.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 22:01:54 -0800 (PST)
Date:   Mon, 12 Dec 2022 11:31:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: spear: drop 0x from unit address
Message-ID: <20221212060151.p7ziztnxny42pi4n@vireshk-i7>
References: <20221210113347.63939-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221210113347.63939-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-22, 12:33, Krzysztof Kozlowski wrote:
> By coding style, unit address should not start with 0x.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/spear300.dtsi | 2 +-
>  arch/arm/boot/dts/spear310.dtsi | 2 +-
>  arch/arm/boot/dts/spear320.dtsi | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
> index b39bd5a22627..f1135e887f7b 100644
> --- a/arch/arm/boot/dts/spear300.dtsi
> +++ b/arch/arm/boot/dts/spear300.dtsi
> @@ -46,7 +46,7 @@ sdhci@70000000 {
>  			status = "disabled";
>  		};
>  
> -		shirq: interrupt-controller@0x50000000 {
> +		shirq: interrupt-controller@50000000 {
>  			compatible = "st,spear300-shirq";
>  			reg = <0x50000000 0x1000>;
>  			interrupts = <28>;
> diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
> index 77570833d46b..ce08d8820940 100644
> --- a/arch/arm/boot/dts/spear310.dtsi
> +++ b/arch/arm/boot/dts/spear310.dtsi
> @@ -34,7 +34,7 @@ fsmc: flash@44000000 {
>  			status = "disabled";
>  		};
>  
> -		shirq: interrupt-controller@0xb4000000 {
> +		shirq: interrupt-controller@b4000000 {
>  			compatible = "st,spear310-shirq";
>  			reg = <0xb4000000 0x1000>;
>  			interrupts = <28 29 30 1>;
> diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
> index b12474446a48..56f141297ea3 100644
> --- a/arch/arm/boot/dts/spear320.dtsi
> +++ b/arch/arm/boot/dts/spear320.dtsi
> @@ -49,7 +49,7 @@ sdhci@70000000 {
>  			status = "disabled";
>  		};
>  
> -		shirq: interrupt-controller@0xb3000000 {
> +		shirq: interrupt-controller@b3000000 {
>  			compatible = "st,spear320-shirq";
>  			reg = <0xb3000000 0x1000>;
>  			interrupts = <30 28 29 1>;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
