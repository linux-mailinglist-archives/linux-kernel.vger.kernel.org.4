Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D00B64E9D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLPK6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiLPK6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:58:16 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC831342
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:58:15 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id y4so1733434ljc.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygFXuh/XT7kReqZaDd5fpLgDWX3W0sTsYYW23Ba0Cco=;
        b=Q9/nnJTh5ZlCNrSi1xSAw8/IPnsDKRTheZD++k9Wj4N9M7ZGZeQauuT6+xvtw6k+DA
         hc8KW1GiTnMItg4pqjy2PjZUmtnytIlxyudgZAkT3770ZWVx8/fbi5DmY3kguXxw8lZ/
         lk24S0ixs+tzgFHDwKE6WiiSK4jFUDw6XGFXkiXEzyhtdREou4zhYr2fCXWMNg0AsS9S
         BzySpLZfusUEu0uvB2gXebRGd8DenMoxzE0gyS11eGdDhM37ZswUn6d08i9P/wydy4Em
         qctoPpfi6FylQSUUSubiSndesj4tXEj1tVSHkIxJeWGxw3rGBcG/D7pXguuXitG5Md/t
         Tz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygFXuh/XT7kReqZaDd5fpLgDWX3W0sTsYYW23Ba0Cco=;
        b=QiAt0Uq76B4GmjdxVjiVra2iYXJZkLDgntxx54grW+MmxVetjAIsZ1J4TqMRFOqmQQ
         V0JExZ2UAeFH7KG4wOCKc/jpyQVEN4nb78ftyW4j0dk/LmY4JdPjw/Jkv68FRMl4Qvn6
         sf3++ygpyj0dUKiBJBvmDjOIvG9Olk+ToN6k0dFDm87o3LHxBUOB5z5Fq23yP4gXxVoC
         vHo6x+cMf1gkV+Vxt1h/IknmxSyDzc2uze0DIuGGvJdo0CUQGCxOSfEHb4rSYe9S4ud4
         VMwM+dxB227UZREmNWzVppyygTyU6AohlMwywcpiNjcWMzDIhYq8InBrJTbYiNZTHOi0
         VIXA==
X-Gm-Message-State: ANoB5pnomB4v69PtA3ulVR7VoxnjXczvwVK9v6iLQb0A5S0x/tjZ4JE1
        kdOWhewVswDUs54qykYLEUi4Yw==
X-Google-Smtp-Source: AA0mqf6cwxbcwO1KvynhxssOA5xVEOIxgjpbbo+ezdAW5K3rEPQME1P5bGFXc4B4HPpHq4q0GpuECg==
X-Received: by 2002:a2e:9184:0:b0:27a:129f:770e with SMTP id f4-20020a2e9184000000b0027a129f770emr7627543ljg.5.1671188293806;
        Fri, 16 Dec 2022 02:58:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004b55cebdbd7sm187519lfe.120.2022.12.16.02.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 02:58:13 -0800 (PST)
Message-ID: <3bad1a29-6457-8958-64c2-a0002c7959a1@linaro.org>
Date:   Fri, 16 Dec 2022 11:58:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/4] dt-bindings: arm: mediatek: Add missing power-domains
 property
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20221215120016.26611-1-allen-kh.cheng@mediatek.com>
 <20221215120016.26611-4-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221215120016.26611-4-allen-kh.cheng@mediatek.com>
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

On 15/12/2022 13:00, Allen-KH Cheng wrote:
> The "mediatek,mt8192-scp_adsp" binding requires a power domain to be
> specified.
> 
> Fixes: 4a803990aeb1 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mt8192-clock.yaml     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> index b57cc2e69efb..cbedef114103 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> @@ -40,6 +40,9 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  power-domains:
> +    maxItems: 1
> +
>    '#clock-cells':
>      const: 1
>  
> @@ -49,11 +52,25 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:

allOf goes just before additionalProperties.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8192-scp_adsp

For the future: please don't use underscores in compatibles.

> +    then:
> +      required:
> +        - power-domains
> +
>  examples:
>    - |
> +    #include <dt-bindings/power/mt8192-power.h>
> +
>      scp_adsp: clock-controller@10720000 {
>          compatible = "mediatek,mt8192-scp_adsp";
>          reg = <0x10720000 0x1000>;
> +        power-domains = <&spm MT8192_POWER_DOMAIN_ADSP>;
>          #clock-cells = <1>;
>      };
>  

Best regards,
Krzysztof

