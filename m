Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A046276B6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiKNHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiKNHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:50:56 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0035318B38
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:50:54 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id d3so12096341ljl.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejuyrcblCIc+DA+Y9MJJ0elKPSaTlB2puhNpw1wAFpY=;
        b=uV0kXK7zyhCXc/awUViecK+PWOpiz8TvjrMGJdFZc97waGz1Fwx1wPojyhOYyPhNHb
         AqzKnD9xT4j7dB/5cr0HjbVADQR8hCLA7ulv/bkX3Qc1NEH/tXSE3gQFkMKEYdutSuYa
         uzvZhoUp+VZnt+7Lox4FOhNOjCck/zeh82FRGHD7ZAwkyLgVec2eum2YHk9D67f40/J+
         XXOchsjl7y5Nt20q8xoRNpFBg34Ka0aURIAxQtwWkVW20SoEBzXKFT3K1rlkB+T6ayg2
         SOd5kbDblRMmRd76h7IiP6WEBNGMq1uVZb2aFc1o2oU8bRWGis/ywucfNqt5CrYBV94T
         3e1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejuyrcblCIc+DA+Y9MJJ0elKPSaTlB2puhNpw1wAFpY=;
        b=eNYosfaXvGW7JmpHd7pZcuCPVU9oY6IMJKQG0S/PJQtR/sL2Ma3OKpkRAILnvVwNqr
         OBRtDNW+Sewy5N3lkAvdQgc+1zOjMcwo4hKdvzT4wnAjNAjMTyUw+WV+XO9YHakf2+h8
         UwQzzB1MoyLQ8IDX8ydoz8xFzW563WaIirbooazAzKofp0cfAtCG/c/p6VB5V8XI6BaW
         9zq6fbVSgd+XMskNylXxFB8K+Q4XdFDy3U19kDuJUWFLn0L2kKCgRkwegKk4wOopir6Z
         6tKWowGtt17pP4ZO2jUHrW6tT9V9y4Cy/UvsCn14D/vgnuVCMdGxhDf8TZFIbgq2p7ZK
         CvFg==
X-Gm-Message-State: ANoB5pnteci55k6lk9wuPUmo9r/gP1VzINdf3YjdqrNrcAu2iwFTk6Kw
        9GAit9l/QpWmUfEyZ9gmiqjE9g==
X-Google-Smtp-Source: AA0mqf4o92ZfJ4LcSRVKeS86gOBmeR7ZaUQh9v72f0dNgb7rMY+YAVjMXIo0m5B6nH1mdCGSe2F1Jg==
X-Received: by 2002:a05:651c:904:b0:277:1d64:f21c with SMTP id e4-20020a05651c090400b002771d64f21cmr3909296ljq.373.1668412253385;
        Sun, 13 Nov 2022 23:50:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z13-20020a056512370d00b004994117b0fdsm1711355lfr.281.2022.11.13.23.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 23:50:53 -0800 (PST)
Message-ID: <451069cd-9e8f-055e-5711-fbae9e2799e8@linaro.org>
Date:   Mon, 14 Nov 2022 08:50:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v4 3/3] ARM: dts: exynos: Add new SoC specific compatible
 string for Exynos3250 SoC
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
References: <20221114054655.68090-1-aakarsh.jain@samsung.com>
 <CGME20221114054053epcas5p1f88b41bce65d54f0f26d0b562e88f7d6@epcas5p1.samsung.com>
 <20221114054655.68090-4-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114054655.68090-4-aakarsh.jain@samsung.com>
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

On 14/11/2022 06:46, Aakarsh Jain wrote:
> commit "752d3a23d1f68de87e3c" which adds MFC codec device node

Please run scripts/checkpatch.pl and fix reported warnings.

> for exynos3250 SoC. Since exynos3250.dtsi and exynos5420.dtsi are
> using same compatible string as "samsung,mfc-v7" but their node
> properties are different. As both SoCs have MFC v7 hardware module
> but with different clock hierarchy and complexity.
> Add new compatible string followed by mfc-v7 fallback for Exynos3250
> SoC.
> 
> Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 326b9e0ed8d3..1a29993fca0b 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -485,7 +485,7 @@
>  		};
>  
>  		mfc: codec@13400000 {
> -			compatible = "samsung,mfc-v7";
> +			compatible = "samsung,exynos3250-mfc","samsung,mfc-v7";

Missing space.

Best regards,
Krzysztof

