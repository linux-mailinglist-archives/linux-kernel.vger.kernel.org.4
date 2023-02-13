Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C5069442B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjBMLOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjBMLOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:14:46 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB6193DA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:14:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so10984986wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DC7PNhEXzA2bTr1kLiLOYy2/RflLZLk44uc5OBrkDU=;
        b=NhsfQn9M+LQfHXjtLuyMn+rbwSANp21Nrv2vCtpxpiRP3TAs4Pe5JtiKCKWRdK7Neo
         yh1bEbreLT9t7gqhI2r6PQYkd44lns5uvBPjI9bmzx5SDBz/tW5/fSJoqZJVntoVGYn1
         UahBuQ6sDZQ35tXCa09Z6PXrtwlKFmItyHLZZfb0T+QymWzxnaNrciZgGppzd3YP/MAO
         cgFZ6OsQI9uznZQ14IOZSwvNyuxdNlAP3JcIBbld8vce0FD8ITdODm5tdZAf+MJVtqsM
         wW9PtyM8JWy4Osr9ir16CfjzHDeSIB8vYTktLRYQxLmS23hknl3tkx79wlhXopgijmIX
         Z00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2DC7PNhEXzA2bTr1kLiLOYy2/RflLZLk44uc5OBrkDU=;
        b=FgdDYrWv+0vjqVpIM88fgY6niF8528m3UnHm6AKMaRYi/c5WUDgIzg0WYgBsjV0pDj
         YxvalB0SamSf4DJ5qmd22xHoWi6amgZV9+qpwxAT/fJYFmULWZlhAWlncWK+NrzZWc5C
         N1ODWiGhuNlmSE9XzGmBv0MK4h6BnQ2L8Gw9RUe1nvcEto/I+fGSpXMETYQZhM3HxRB/
         b3PeCBkYk/EowDf6RJRrbmhq6MXhSA/I0ttlG/IlTRchrvXpZynuk8/3p8H03XBMDSsA
         pX5bG1hIPAZ5XSDR1X9pHrM9TxcbcKY37A1fOZ3nqbFDOoYbOEec4kbmwNtSReuZOuyF
         g/jg==
X-Gm-Message-State: AO0yUKXYtGplG2lbT6PXPOXVPk89Ce72IMEtchwVCtTjUspfMhrMUlOY
        FViCmSqG83o2JEKvvZehusjSHQ==
X-Google-Smtp-Source: AK7set8oaYgKuifU2vnMqa/UyN+qhFOxV+HTfzbIYnI0rfevBi+VqDzI0c19eTP++f607dQNSoioXw==
X-Received: by 2002:a05:600c:16c4:b0:3dc:1f90:35b with SMTP id l4-20020a05600c16c400b003dc1f90035bmr22771879wmn.34.1676286837823;
        Mon, 13 Feb 2023 03:13:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm16737485wmm.40.2023.02.13.03.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:13:57 -0800 (PST)
Message-ID: <6e18ab3a-512e-ffe2-1c88-9b57bd1d3960@linaro.org>
Date:   Mon, 13 Feb 2023 12:13:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 07/17] dt-bindings: iommu: apple,sart: Add
 apple,t8112-sart compatible string
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-7-cb5442d1c229@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-7-cb5442d1c229@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 16:41, Janne Grunau wrote:
> "apple,t8112-sart" as found on the Apple M2 SoC appears to be SART3 as
> well. To allow for later discovered incompatibilities use
> '"apple,t8112-sart", "apple,t6000-sart"' as compatible string.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---
> This trivial dt-bindings update should be merged through the asahi-soc
> tree to ensure validation of the Apple M2 (t8112) devicetrees in this
> series.

Same comment as in other cases.

> ---
>  Documentation/devicetree/bindings/iommu/apple,sart.yaml | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> index 1524fa3094ef..07d2d68a87df 100644
> --- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> +++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
> @@ -28,9 +28,14 @@ description:
>  
>  properties:
>    compatible:
> -    enum:
> -      - apple,t6000-sart
> -      - apple,t8103-sart
> +    oneOf:
> +      - items:
> +          - const: apple,t8112-sart
> +          - const: apple,t6000-sart
> +      - items:

Drop items.

> +          enum:
> +            - apple,t6000-sart
> +            - apple,t8103-sart
>  
>    reg:
>      maxItems: 1
> 

Best regards,
Krzysztof

