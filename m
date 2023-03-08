Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAD6B11A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 20:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCHTD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 14:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCHTDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:03:15 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC06E3B7;
        Wed,  8 Mar 2023 11:02:59 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-176d93cd0daso10380028fac.4;
        Wed, 08 Mar 2023 11:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678302178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FrWOB0uVxHx56X9xrWxuDWJ/kb3JEYgMVQs34PVT2U=;
        b=UJVqrktNNz/61tupoHz969u/W1ZNJoN+IDl5vQL3P3o+eXbU0zYF9XNzCGVPAbMvNV
         +dLYpmzJZq+NGNR9KQcpdJM62BvaLqOfAOm6ACJE3Hp3XL7RWWAJMVwrma5ZofyyTmKm
         C264gfo5sY/9NS4DpvO+opAA7qHXCx2GiZ8x6x9L38wsmrQ587GiqJOPo0GmCVHa1y9Z
         YYpWm3bxXRT4RJqGp91d7GyQtkJM1T1/dK+SbBau+o0ckhekcuDRJwvCEzFY64qXk7yO
         09Py5xJBET5vauW+Lc4KIGK+N5tPqYu+8h5mPVk2BVNaDVaiZ31IjEovhKM+qvynN8aq
         Gw6A==
X-Gm-Message-State: AO0yUKUyNVfPHoWKrnfH4KOgfm7EgY4bJuwi0KpzLkTe5K9JcCWMTM2i
        OknLCw5RY/0lWuXbE0fU4g==
X-Google-Smtp-Source: AK7set+DvjoWc1KWq2h3sKBZx+8CoWicRMFGWsEt1KRrNByZmsCl9/pHwHZRNzh/c5BtXW6lqvK2cw==
X-Received: by 2002:a05:6870:b14d:b0:172:80f9:a545 with SMTP id a13-20020a056870b14d00b0017280f9a545mr13141161oal.25.1678302178217;
        Wed, 08 Mar 2023 11:02:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d199-20020a4a52d0000000b005264a1472adsm1543777oob.15.2023.03.08.11.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:02:57 -0800 (PST)
Received: (nullmailer pid 3604331 invoked by uid 1000);
        Wed, 08 Mar 2023 19:02:57 -0000
Date:   Wed, 8 Mar 2023 13:02:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: Re: [PATCH v4 03/12] dt-bindings: gpu: mali-bifrost: Fix
 power-domain-names validation
Message-ID: <20230308190257.GA3601415-robh@kernel.org>
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com>
 <20230228102704.708150-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228102704.708150-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 11:26:55AM +0100, AngeloGioacchino Del Regno wrote:
> Commit ("dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183")
> incorrectly introduced power domain names for MT8183, causing
> validation issues.
> 
> Add power-domain-names to the base schema, allowing a maximum of
> five elements; since platforms having a single power domain don't
> need any actual domain name, disallow that for each sub-schema.
> 
> Fixes: a7a596cd3115 ("dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index 5b7f1c9d2b30..bf0f7f1f71e0 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -65,6 +65,10 @@ properties:
>      minItems: 1
>      maxItems: 5
>  
> +  power-domain-names:
> +    minItems: 1

If you are disallowing for a single domain, then this could be 2...

Reviewed-by: Rob Herring <robh@kernel.org>

> +    maxItems: 5
> +
>    resets:
>      minItems: 1
>      maxItems: 3
> @@ -112,6 +116,7 @@ allOf:
>        properties:
>          power-domains:
>            maxItems: 1
> +        power-domain-names: false
>        required:
>          - resets
>    - if:
> @@ -136,6 +141,7 @@ allOf:
>              - const: bus_ace
>          power-domains:
>            maxItems: 1
> +        power-domain-names: false
>          resets:
>            minItems: 3
>          reset-names:
> @@ -186,6 +192,7 @@ allOf:
>              - const: bus
>          power-domains:
>            maxItems: 1
> +        power-domain-names: false
>        required:
>          - clock-names
>  
> -- 
> 2.39.2
> 
