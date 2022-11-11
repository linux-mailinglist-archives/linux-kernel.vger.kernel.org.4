Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA126254E3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbiKKIHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiKKIHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:07:02 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8A8748E8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:07:01 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id c25so3682537ljr.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mkzKjBuFZVxWFYVZhmqUgcCDnGk48wQCYb/s+p35qY=;
        b=Tz5FxPyQ0APcNSPQO8m2UshMmrkw8YyG6iSDyP5DPQ3fV+Cx0uSxjLzZXgRXi2C1BP
         uosjby10Q5I5irZ19ktKzGBjvdAvgSpPGBKpyRnIyAo2ZVJUUhMQ5zGJ0TTd0Oi2AM0c
         r8wt9R0OlCDPwkDKIkKDEvFrun+yAOKRpyJXfNPf7Znj5Qg3JcavNQs6cy4XtSMvQOYP
         nIel5cdzzounNakIs1TykzouFPCL66FgGamKu/oFdoaWOXBDoCmOLhSI/3aS7mM+eP9C
         vrEM7SpX3H5+QsIjNV13IPRbW2DzJHQ89pYqV0671FLmYZ34O2gAUKqIPZ/NFWOYI0Tn
         y8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mkzKjBuFZVxWFYVZhmqUgcCDnGk48wQCYb/s+p35qY=;
        b=rqWQJ6tNAEDhEg8iCrKxRNp8ZEv/jJlCWeRsfomNmjycRPCx1D3C6X5CiuVXk8mhdk
         gt2dja2K7SWlwI3EtWpj49ik1kNjyIFbZ4r9kak75v/ZTcjJAO1b4pq8NBKoiI6odoz6
         2MMK2shz5C562qE7fpT/QydUMEaMGs1JA0Tc3d6qWH2rCG3iZ9lgnfhDgArXTLP1jt0G
         i7UcaL8bNnUltBesbw2EzDsepTaTaohSfxkFp+jmw+U4qMTC2qN7d9bByJpH20+SPsrd
         YU8jgeSSzrXYnsJzpkl3qzueUmgWar3k5VfE/w2i8ftsbBXymRfMryFfs/Z8q/0sgnR5
         zDJw==
X-Gm-Message-State: ANoB5pl+dXg84SgT6r+pItzt8x3P4jRpGfGrN1e0IA6U4kIVHXrj3+80
        GoMmoAZnRuz63nLwJK50j/spww==
X-Google-Smtp-Source: AA0mqf63SqS7ZqAUKWocEvIHorXccj0gv44etPdKlJ5a+yrR9ajMorvmQBvpA5YbabRYlRqL9FeQXg==
X-Received: by 2002:a2e:be23:0:b0:277:6fea:ac19 with SMTP id z35-20020a2ebe23000000b002776feaac19mr293000ljq.83.1668154019845;
        Fri, 11 Nov 2022 00:06:59 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id b27-20020a19671b000000b004b40c1f1c70sm204666lfc.212.2022.11.11.00.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:06:59 -0800 (PST)
Message-ID: <f94e97ee-ac0d-4be6-38c8-88f325d99192@linaro.org>
Date:   Fri, 11 Nov 2022 09:06:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v3 1/3] media: dt-bindings: s5p-mfc: Add new compatible
 string for Exynos3250 SoC.
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
References: <20221111032337.79219-1-aakarsh.jain@samsung.com>
 <CGME20221111031711epcas5p45191dacb108498b920e5cf876f9d0c16@epcas5p4.samsung.com>
 <20221111032337.79219-2-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111032337.79219-2-aakarsh.jain@samsung.com>
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

On 11/11/2022 04:23, Aakarsh Jain wrote:
> Since,MFC v7 support was added for Exynos5420 and Exynos
> 3250 SoC with same compatible string "samsung,mfc-v7".As
> both SoCs having different hardware properties and having
> same compatible string for both SoCs doesn't seems to be correct.
> New compatible is added for Exynos3250 SOC which will
> differentiate the node properties for both SoCs which
> support MFC v7.

Subject: Drop full stop from subject.

Commit: This is not correct formatting, nor wrapping. In English after
every comma  or full stop there is a space.
Please wrap commit message according to Linux coding style / submission
process:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

Not "is added" but just "Add new compatible"
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

But what is more important:

> 
> Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  Documentation/devicetree/bindings/media/s5p-mfc.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> We are already in process of converting this txt file to yaml.
> https://patchwork.kernel.org/project/linux-media/patch/20221011122516.32135-2-aakarsh.jain@samsung.com/
> Modifying this txt binding for completeness.
> 
> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> index aa54c8159d9f..cb166654fa81 100644
> --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> @@ -10,10 +10,11 @@ Required properties:
>    - compatible : value should be either one among the following
>  	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
>  	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
> -	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
> -	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
> -	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
> -	(f) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
> +	(c) "samsung,exynos3250-mfc" for MFC v7 present in Exynos3250 SoC
> +	(d) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
> +	(e) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
> +	(f) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
> +	(g) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC

I don't see here any improvements about which I commented since v1.

Best regards,
Krzysztof

