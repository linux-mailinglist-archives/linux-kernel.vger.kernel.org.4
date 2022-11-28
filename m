Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B5E63A413
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiK1JFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiK1JFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:05:02 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD171789F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:05:01 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g7so16311944lfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A55aTUx9um1awxaJwrSFbAQ2B0+UBrA3NMiv8IfADq0=;
        b=S72uyT2NmmapvIzFBlVuuVu0Rj7I4DWGK7uN5lPNwFlu0h/1xHqfc0w1ekc4I5t3Uc
         EN1EyLvMqacGCEyoAVBLE2K5WwWW7b3QhzeHSt96fjPRHdsIcBipIoipMdiiwv2KLMKF
         4jRN/hMdKFY1tCOyS2B1azQZzCvJ4VqiGQ1gKE4FLqK3KOY/tB4uwWsoppviePTHGj0I
         xVFArXGbIddcVz/WKsB70I0stTDLANjS0MD/cELNNmuhiNaxpmNVJ0t77XYWD8eX6Ptt
         DPn9UqhkeYxwgnaF/NCocPrBYXR5aGK3rgOKaYtBrYcmlo9DtCVRy2H/GR/W6qgBGkuG
         2Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A55aTUx9um1awxaJwrSFbAQ2B0+UBrA3NMiv8IfADq0=;
        b=56q+nvhv2rEdNwQ4YGmKsvP8H+ovSZc2joo7pZtg3XNbGnDjHqvBaOUSzjcqjugmkF
         4oTq80J+w/IQySaugPCexdSbaY7dNezPotqgjqyJQHNcYMw3zCI7R9pI1YpDNL1web59
         Ih7cQCs7E37e79e9X6KAVlCwDO381PGcWSMlT0+xEssSCYlyuUA50c4uFGdM39rppc1K
         /LODPvCgpgBBikyvVP6EJlVCgydGCZzbs+OwEwzeptFXbIVnDH1pKx5b6aAJulng86HO
         mVu8HswJg0D/Z7ajXinpSoNgz0Rq05ey2zi7RejIeBAyXZccZtryFJGXv/tXJfZzSdYN
         skBg==
X-Gm-Message-State: ANoB5plE5/raCOIbVS50cwI/XUQ2fY4FO+88MzxOkHTA1WAJUV7lk5Cb
        38jTxCq6/Z+MeT1kjvQ1239lpjifCdMh46/5
X-Google-Smtp-Source: AA0mqf690hCzqZNxg+ZuHnfgQ+jA8Im/PCMuhGme2XTYv6jky84sgnUWOjjTeaDuaJus+Yq5DlEr3A==
X-Received: by 2002:a05:6512:2987:b0:4b1:61a6:fc45 with SMTP id du7-20020a056512298700b004b161a6fc45mr11308428lfb.224.1669626299613;
        Mon, 28 Nov 2022 01:04:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r30-20020ac25c1e000000b004ac088fdfd2sm1645536lfp.85.2022.11.28.01.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:04:59 -0800 (PST)
Message-ID: <9985d44e-977e-d7ea-0932-4879a3ccd14d@linaro.org>
Date:   Mon, 28 Nov 2022 10:04:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 7/9] dt-bindings: spi: mtk-snfi: add two timing delay
 property
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221128020613.14821-1-xiangsheng.hou@mediatek.com>
 <20221128020613.14821-8-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221128020613.14821-8-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 03:06, Xiangsheng Hou wrote:
> add rx-sample-delay and rx-latch-latency property.

Start sentences with capital letter.

Here and in commit subject: property->properties

> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>
> ---
>  .../bindings/spi/mediatek,spi-mtk-snfi.yaml      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> index ee20075cd0e7..367862688e92 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-snfi.yaml
> @@ -55,6 +55,22 @@ properties:
>      description: device-tree node of the accompanying ECC engine.
>      $ref: /schemas/types.yaml#/definitions/phandle
>  
> +  rx-sample-delay:

No, use existing property, don't invent your own stuff - missing unit
suffix. See spi-peripheral-props.yaml.

> +    description: Rx delay to sample data with this value, the valid
> +                 values are from 0 to 47. The delay is smaller than
> +                 the rx-latch-latency.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Drop $ref.

> +    minItems: 0
> +    maxItems: 47
> +    default: 0
> +
> +  rx-latch-latency:

Same problems. Did you check spi-peripheral-props.yaml or other SPI
controller schemas for such property?

> +    description: Rx delay to sample data with this value, the value
> +                 unit is clock cycle.

I think the unit should be rather time (e.g. us).

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 0
> +
>  required:
>    - compatible
>    - reg

Best regards,
Krzysztof

