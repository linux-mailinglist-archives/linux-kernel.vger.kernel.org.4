Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7630627773
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbiKNIWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiKNIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:22:30 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383C51AF29
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:22:29 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so18053019lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eh60MayT68uXb/vYDSnEvRU+vPH3Dd6tdfW4oAvniM4=;
        b=U87SGviyAxzWYAFu1aifc5W68sLVeQMWvk4ysqqMB+D9NB/NUmTa9Qgt8ZGM0ALqEz
         lBl4Hr+KzFK8ZWv3toENPa2rFyn9UCc+H25tq8RugjGcnB60eaNPK9ED5AUAOZIO1euF
         fzN01XmDX3nGNU13XWWWS/nd7i4lhYaPVqksTzxYsfVpaB61Utg0HoAXdf0jaYNbj9zK
         7RbJnIf+wQnE7t29kaQtnTnEqoi4l7I8viYWmIY4PQrWL/ROZVD+Q9JYThmzNSsb71n0
         repVjfw+M3Qg/zYMDs+mS9DIdcPI4T4CzOajUz6vTFoA0dMtKur9Rr+yRBKECDm1aalv
         HTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eh60MayT68uXb/vYDSnEvRU+vPH3Dd6tdfW4oAvniM4=;
        b=QpCRz114e/ydAqohZxoUN9ZVapOO3Q0y/jQWwzSfOnotX2VEd9+Yk9fpWmWeeU0lf6
         yEv6JXv8JqNcxRud0pLvui9ifoYlb2lcnIX/7utW0nHGabb/rhSzFNWd6PmAv8kyAJKh
         U0n2Hv0JQc26Y7S+TVq35u1Ft3uObPhhNVxPk1/2FHJsP0C+SjGX8J9WRjoTODXY5Gut
         hkRwYJIMsmTQUGeofazzQ620Msj249RKerf97MhrTHSCCRZeoK2qG0vZB+ivQPRGjN5u
         ot8HVvwvzISZiotefSPunmehmmN/V3XZDiGye0JbC7NHqh2Z2X3oR/4C3FiutTvWhpgD
         +dKw==
X-Gm-Message-State: ANoB5pkSw0By6aEgyuApvprmRi3rRw8qO/OKNB0/R/IaeNXdMpWZnskc
        1mRXwojrZnYJLpqegex6W6+yWg==
X-Google-Smtp-Source: AA0mqf67oAA3DSJeOHq5gNAC8fIpIUnEk+d3CewqvFf05f5iE1tja9L6ycoWhSiCcYq9Mm6TrbaYvA==
X-Received: by 2002:a05:6512:3b06:b0:4af:e82f:6013 with SMTP id f6-20020a0565123b0600b004afe82f6013mr4326063lfv.36.1668414147602;
        Mon, 14 Nov 2022 00:22:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d6-20020a056512368600b0049b8c0571e5sm1735657lfs.113.2022.11.14.00.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:22:27 -0800 (PST)
Message-ID: <92a75ab2-ffb9-9acd-4a98-a91589ad7e14@linaro.org>
Date:   Mon, 14 Nov 2022 09:22:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 8/8] dt-bindings: iommu: qcom,iommu: Document MSM8976
 compatible
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221111145919.221159-1-angelogioacchino.delregno@collabora.com>
 <20221111145919.221159-9-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111145919.221159-9-angelogioacchino.delregno@collabora.com>
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

On 11/11/2022 15:59, AngeloGioacchino Del Regno wrote:
> Add "qcom,msm8976-iommu" to support IOMMUs on this SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> index b762772f80e7..b7a5822ac00d 100644
> --- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
> @@ -9,7 +9,8 @@ to non-secure vs secure interrupt line.
>  
>  - compatible       : Should be one of:
>  
> -                        "qcom,msm8916-iommu"
> +                        - "qcom,msm8916-iommu"
> +                        - "qcom,msm8976-iommu"

Shouldn't the new compatible be followed by IOMMU v2, not v1?

Best regards,
Krzysztof

