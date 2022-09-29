Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B425EFF48
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 23:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiI2V2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 17:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI2V2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:28:48 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6060D14597A;
        Thu, 29 Sep 2022 14:28:47 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-131c8ccae75so3346670fac.3;
        Thu, 29 Sep 2022 14:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3bn05vns/+BJdL+cVZ+KI4bs4xLeU8Ssku17kR1tQdw=;
        b=lTT5GsfMqqMk/elObirqUp2uovfb4V1YMI71NX/XgFoMrA6EN0PNeJZKa+olT6pbSG
         tpUEhUddh2Gumvy8c4GsOFLcT6bTlHjS3p8FjYDa6qMeH4Hue7t45Dh5oaLv8hqVRmvQ
         AAd1dKdELY2OksaDeA/p3Zusu7yRaN/X7vR8haTo+K3hYbEwQqDtbRG9SRy9cypr4uZw
         k2eHxZ7end6Ony4csk9wp5o3ph20jzVbk94bwtAtZXKKU7S6J2+2ErghxMt0BAjGPodU
         f/l0g+x8XrZB2gkBKqB63ERggHPegwpljBfWbA2A1X+ZfF2ULSL31Pbw4XENIqVZbO7H
         HIIQ==
X-Gm-Message-State: ACrzQf1JxuSQsxFXvNoEzBAn2rpKzu5Pj0VNd4731VLEtPJnaNWAKMPJ
        aqsYF68OhpX/bVRMM2tGJA==
X-Google-Smtp-Source: AMsMyM6VIaKSo/VfUni9X7fBpo31lixw5SSw48UWYpbP8bGmWl5kpjEyhqfCPPFogPV8NsqUBYVGZg==
X-Received: by 2002:a05:6870:4184:b0:131:55a3:2fef with SMTP id y4-20020a056870418400b0013155a32fefmr9707128oac.223.1664486926657;
        Thu, 29 Sep 2022 14:28:46 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k28-20020a05680808dc00b00342df642fd3sm99651oij.48.2022.09.29.14.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 14:28:46 -0700 (PDT)
Received: (nullmailer pid 2744344 invoked by uid 1000);
        Thu, 29 Sep 2022 21:28:45 -0000
Date:   Thu, 29 Sep 2022 16:28:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: samsung: soc: match preferred naming in
 entire compatible
Message-ID: <20220929212845.GA2725627-robh@kernel.org>
References: <20220926124757.475471-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926124757.475471-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 02:47:57PM +0200, Krzysztof Kozlowski wrote:
> Compatible is a string-array, therefore the "select" should look for
> anything containing Samsung SoC part.  This allows to validate cases
> like:
>  - "samsung,exynos5250-gsc", "samsung,exynos5-gsc"
>  - "samsung,exynos5250-pmu", "syscon"
>  - "tesla,fsd-mct", "samsung,exynos4210-mct"
> 
> Since Tesla FSD builts on top of Exynos blocks, add an adidtional
> pattern for it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/arm/samsung/samsung-soc.yaml     | 26 +++++++++++++++----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
> index 653f85997643..bb1fdc205b44 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
> @@ -18,17 +18,33 @@ description: |
>      samsung,exynos5433-cmu-isp
>  
>  select:
> -  properties:
> -    compatible:
> -      pattern: "^samsung,.*(s3c|s5pv|exynos)[0-9a-z]+.*$"
> +  allOf:
> +    - properties:
> +        $nodename:
> +          pattern: '^[a-z]'

Why do you need this?

> +    - properties:
> +        compatible:
> +          contains:
> +            pattern: "^samsung,.*(s3c|s5pv|exynos)[0-9a-z]+.*$"
>    required:
>      - compatible
>  
>  properties:
>    compatible:
>      oneOf:
> -      - description: Preferred naming style for compatibles of SoC components
> -        pattern: "^samsung,(s3c|s5pv|exynos|exynosautov)[0-9]+-.*$"
> +      - description: Preferred naming style for compatibles of S3C/S5P/Exynos SoC components
> +        minItems: 1
> +        items:
> +          - pattern: "^samsung,(s3c|s5pv|exynos|exynosautov)[0-9]+-.*$"
> +          - {}
> +          - {}

Wouldn't just contains be fine here too:

contains:
  pattern: "^samsung,(s3c|s5pv|exynos|exynosautov)[0-9]+-.*$"

> +
> +      - description: Preferred naming style for compatibles of Tesla FSD SoC components
> +        minItems: 1
> +        items:
> +          - pattern: "^tesla,fsd-.*$"
> +          - {}
> +          - {}
>  
>        # Legacy compatibles with wild-cards - list cannot grow with new bindings:
>        - enum:
> -- 
> 2.34.1
> 
> 
