Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49CE625DDA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234798AbiKKPH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiKKPGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:06:18 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77C63B97
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:02:59 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b3so8710363lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8IDbrEeNh/TbThuT4XpNap8e1dUDmVMx+XMzxzqnSSA=;
        b=hygw+8iLwbB0q+6Nm2nUVjSzmZb2IJlCMC7CYDRHle/pNSKT9xH/abjiNy2w1FzrKM
         d3Mt0WJllhrLlRpRjVmmVSrW0ZiZF39Flfbfo74TGwnqBm05Tp3ErxlMC4fmIm046CWU
         X5ZxdhVjIMwM6ZvSYurHX01uSF4d5LfN3xfO4GxnWQiklasehkYx23cSVhsSf8FjiNGL
         SXcZDSvEITKbOzKQ8ukLkA8KI+6L7PEE0FUXy1gonxzHV3/WO4i+LUaqUPTv2ckqCUTt
         sH7OyzyscHngt8YssbfUngJYdReVfCVyFNT0Y5cDyrAYjYB/xziMj5Z112OteA/RYSxt
         SmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IDbrEeNh/TbThuT4XpNap8e1dUDmVMx+XMzxzqnSSA=;
        b=0nsyHsiz99OdhohcQMWsAsNqsxEqM418d02dMjLgwlG/0f7Rs5ukR9788GuXafLfC2
         oaxnv8qFPvQFF8GbvnONny2h2mgvLdf1Xt9wF7TC/52XCx6uG33xfZZsb+GjhaCTOs9g
         wazsu2/9WdlMABH74lZigYV3LaBQfMZSdWE2MYvzzsqx258BAK0v1yskJuquCTSqS7DY
         7MRk4DxtLwmiT3a08yYTgEvI7XckF474Z850MKzpD/d3o3sQpXYmS0LD5KIS2QDjlKMS
         Kpa0gq3n66JdLIwhVANWVVYZcNSBPaZHlmqD4FmcOZIuSwMS3/OVUM1UXOvWese9jLw1
         YXYA==
X-Gm-Message-State: ANoB5pnyx3IMtAXv6paKSHhXZdsquT8Xm8+QIvGMpUsUZvmXG4Jqr5Dm
        39XGjs4edXpdNLCSyHDyx6LF9Q==
X-Google-Smtp-Source: AA0mqf42b4kvDiZpLvHSgqYN73z75vsx9adgnee/kAeEHRiXzrEycGZlXDDvd3Zni04Nw4TmGX1fYw==
X-Received: by 2002:a05:6512:131c:b0:4b4:1177:a64c with SMTP id x28-20020a056512131c00b004b41177a64cmr957999lfu.647.1668178975951;
        Fri, 11 Nov 2022 07:02:55 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id y1-20020ac24201000000b004a44ffb1023sm371686lfh.57.2022.11.11.07.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 07:02:54 -0800 (PST)
Message-ID: <bd2e3b45-850c-1d95-b62c-06024b85a473@linaro.org>
Date:   Fri, 11 Nov 2022 16:02:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 01/10] dt-bindings: arm-smmu: Allow up to 3 power-domains
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
 <20221109111236.46003-2-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109111236.46003-2-konrad.dybcio@linaro.org>
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

On 09/11/2022 12:12, Konrad Dybcio wrote:
> Some SMMUs require that a vote is held on as much as 3 separate PDs
> (hello Qualcomm). Allow it in bindings.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> index 9066e6df1ba1..1897d0d4d820 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> @@ -159,7 +159,7 @@ properties:
>            through the TCU's programming interface.
>  
>    power-domains:
> -    maxItems: 1
> +    maxItems: 3

This is not correct - you now require 3 power domains everywhere. If you
test the DTS you will notice it.

You need min and max items, plus provably allOf:if:then restricting it
per some variants (if it makes sense... depends which SMMUs need it).

Best regards,
Krzysztof

