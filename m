Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B253617B26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 11:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKCK42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKCK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:56:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901810FD5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 03:56:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f27so4187605eje.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 03:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHoEFEUHiiMBa/cPnqMwuahiYHL+HcOZn1fqIz2cIPY=;
        b=kfPnWSmd0FTeX/avQZ1E61I0IPizlm1im7utoUJ4EyeHUR18MZPX5soFls0MRAPal5
         g3OETyVycWiVOZIDhFnNt59wv1G3P3BeIn1Tk9faYvMLZgXT3bFHsgSYQml0FHyW//2F
         epUzyDa2UxY6fEkSPXGB/wrbFw34DZYJBIPtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHoEFEUHiiMBa/cPnqMwuahiYHL+HcOZn1fqIz2cIPY=;
        b=KkZ3HLh6Mb4f2d2XcSg/yvCauZLTKPEhQGKT33pJUMmZiPm3r0Otp3w3o1MwLinY+4
         VgrisLR60fbqD/MgPWOUhiHraLGeWYfazynx6vc9NN9hZ/re3Ia+1CHhGW/JGxEa0So+
         xwAUucEnvYpVVcNwxpdPAiBLPNPHyEtwTAKvbl4vARQJGrZ9pvDSwuS4j7CSnZZ7dl56
         bBSLbOtGq2t2GBcAI/D3IYQ3BizStlOuoIvqSMqUrwF2KFau2xVXHfJqeiqaOdjJDY1H
         J2cRysdnGzFCrlt9O441nC8dmyBUdyBH8W0bxv60TSpRYWBMYeS8KLC98R8Wk+BFOfDT
         Nqrw==
X-Gm-Message-State: ACrzQf3DvAMGqvSbe8zy8gDUjSkZhT8w8UVm4wtfJZM3PoQHjEAyukJ9
        reHU9uP9yY3LOYM3RQb1YPiiGQ==
X-Google-Smtp-Source: AMsMyM6gH60Gp0hF7v+cWs5gMtyaaKikxH25CGAGUgJOX5bFKeigen6f+TEUg/6vRtCX7ElEDpUFWw==
X-Received: by 2002:a17:906:4795:b0:794:8b93:2e43 with SMTP id cw21-20020a170906479500b007948b932e43mr28527661ejc.184.1667472978651;
        Thu, 03 Nov 2022 03:56:18 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-54-207.cust.vodafonedsl.it. [188.217.54.207])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906200200b007acbac07f07sm361368ejo.51.2022.11.03.03.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 03:56:18 -0700 (PDT)
Date:   Thu, 3 Nov 2022 11:56:15 +0100
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Aakarsh Jain <aakarsh.jain@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com
Subject: Re: [PATCH 3/3] arm64: dts: exynos: Rename compatible string
 property from version to SOC specific
Message-ID: <20221103105615.GC4937@tom-ThinkPad-T14s-Gen-2i>
References: <20221102130602.48969-1-aakarsh.jain@samsung.com>
 <CGME20221102125816epcas5p23e16fefd6b820e7dd7d9a93f0d48f40d@epcas5p2.samsung.com>
 <20221102130602.48969-3-aakarsh.jain@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102130602.48969-3-aakarsh.jain@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aakarsh,

On Wed, Nov 02, 2022 at 06:36:02PM +0530, Aakarsh Jain wrote:
> commit "752d3a23d1f68de87e3c" which adds MFC codec device node
> for exynos3250 SOC. Since exynos3250.dtsi and exynos5420.dtsi are
> using same compatible string as "samsung,mfc-v7" but their
> node properties are different.As both SoCs have MFC v7 hardware
> module but with different clock hierarchy and complexity.
> So renaming compatible string from version specific to SOC based.
> 
> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
> Fixes: 752d3a23d1f6 ("ARM: dts: add MFC codec device node for exynos3250")
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
>  			reg = <0x13400000 0x10000>;
>  			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "mfc", "sclk_mfc";
> -- 
> 2.17.1
> 

Looks good to me.
Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>


Regards,
Tommaso

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
