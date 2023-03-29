Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577F66CD7D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjC2KlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjC2KlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:41:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3BB3C2B;
        Wed, 29 Mar 2023 03:41:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q7-20020a05600c46c700b003ef6e809574so5987743wmo.4;
        Wed, 29 Mar 2023 03:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680086471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SgpY1YthWT3xIQhWwfucwfDtAT6rdZEh8Ao3ZU56Ods=;
        b=i/2YE1oqVWapZMKkxbz+mbhQ2V5yDDdXydRYWyJXBCK7x1R43vgwgZ5KYHZkF1ByA7
         QU0ivFZ6NdMog8ERoltE4D7fkriQupBkzPBMlUFC0vWzWYZP4mr5qP/cTjAOCdjzDVEm
         A5JknFQYA9O6X92dh5xfe9Cn1OkU4WJU8jYjWzrPzwV8E272luJ8CAah6NlSAKULrP28
         d6UYwY2iOg8NXsdKLiNstV2Fg4ro97GO/oLIpCNrKvdZ0BaWsdWtAKpacFuYmSOCDkmu
         kts09u1BcAo9J7s2PdqS9WckayVIqcc1EY3z9so+K7zcfGW+ERwKv0zlFKlDHXw8QVIH
         gs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680086471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgpY1YthWT3xIQhWwfucwfDtAT6rdZEh8Ao3ZU56Ods=;
        b=WQe+vxyldPHeFGVeT13sWUvyDSmjy2fvQ+ehtosAqzXUUBjuBMqI+Hu8Ifq9TQEE9O
         +Of++EzaXcrk5n0oH0vPX0vZ+ZIQsJ0noXRrbmgoygz8mYFGH+2MSAqwQyIlOtTHu7H2
         5Cr5dC8HaCh/E2samYMi3EzCI9kncjyF/SDF8/CKjRGpWZvXtvIg6QvoiCexKSiiskif
         OXKXEB9IqA81xUNlZSLFkjIAjVhg4/ta6abdqbiLsmlD+gLt3H+/aMSo6YM5H/tF+Ox1
         FsJwXqg+woPBtzxTP38nh6YVN6iiFNHJNNkEekiqkIPc0WLua61q0TKnyoKKKzsX4HED
         WZmQ==
X-Gm-Message-State: AO0yUKU36L803VN9o4vj76JPq0MlJbQfcjkvfK7/x9CMdlrzzhkTgzt9
        BficCSPd86Xzi7Er89KRCFM=
X-Google-Smtp-Source: AK7set/gT5l6g7eCFe8SN97XIH3TnyaG+4JmZEjJXvbkpsWqRF5Cq3gw8GYvkBpmrWMxkXKOvEgfsw==
X-Received: by 2002:a7b:cc82:0:b0:3eb:42fc:fb30 with SMTP id p2-20020a7bcc82000000b003eb42fcfb30mr14934639wma.32.1680086470913;
        Wed, 29 Mar 2023 03:41:10 -0700 (PDT)
Received: from [192.168.42.225] ([81.95.8.244])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bcbd3000000b003ef684c5e32sm1732903wmi.48.2023.03.29.03.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 03:41:10 -0700 (PDT)
Message-ID: <d1dc242d-c381-3307-b939-7bc35c6ce55b@gmail.com>
Date:   Wed, 29 Mar 2023 12:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND 1/6] dt-bindings: memory-controllers:
 mediatek,smi-common: add mt8365
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230207-iommu-support-v1-0-4a902f9aa412@baylibre.com>
 <20230207-iommu-support-v1-1-4a902f9aa412@baylibre.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230207-iommu-support-v1-1-4a902f9aa412@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/23 11:52, Alexandre Mergnat wrote:
> Add binding description for mediatek,mt8365-smi-common
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/memory-controllers/mediatek,smi-common.yaml   | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> index a8fda30cccbb..d599a190952f 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
> @@ -49,6 +49,10 @@ properties:
>             - const: mediatek,mt7623-smi-common
>             - const: mediatek,mt2701-smi-common
>   
> +      - items:
> +          - const: mediatek,mt8365-smi-common
> +          - const: mediatek,mt8186-smi-common
> +
>     reg:
>       maxItems: 1
>   
> 
