Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2837864EA34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiLPLWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiLPLV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:21:56 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2715C5E08E;
        Fri, 16 Dec 2022 03:21:38 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso1546341wmb.0;
        Fri, 16 Dec 2022 03:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVBkOpfAYZxWE0+rYS13/gFKIJDXEDdtWxxYd6rvanE=;
        b=Iot8Bh9+xa3SjKPmbkeHmZKvmaOocwiF58oJi+ZrCINaerAm+qXAfowhA+gQfZAcLE
         EJUdTXEXViVikJzCrBCq4i98uocGEgBbfmrb9q9nBh5Nmblecou6t9oOpW6uRWLK1GBz
         MEetQ2jCbq3XoLDmWIbbd35EDhsQvOmEY/h9HW4YmzUL3F3PFahNQNc5KS4xn0UUux1Q
         5SzTp/lPaTaBRVUpxZNEqAYIuQc9CGKIpdGMwoRcr4tRRifWMNk19vKOKzzLHx5k75Vg
         ymhJgLrxT6Ei1LDPjXDrQNXKzQ2yPhxUrK/B02IWvXoqvYxyoiIOyLiozp/THiJ5nlXf
         3C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVBkOpfAYZxWE0+rYS13/gFKIJDXEDdtWxxYd6rvanE=;
        b=G7u0evbKd1kfnB9KvpJUUOWiwhIokBXzuQpeqJGwzCb1SQYQqucN/MytiUdINBNQRz
         rgLin2JywP2ugWQ2US85M5VO/iR9KCG8yM9uHrSVy1HdJ7UuwMkL7bIQ/WuVYZm/uvOY
         NNQnx6PnD1NvaMQNEUBzQpThj7aXvTyiW147nKngeGq01g9Yo9KWEgvYwwG/uMAE0sYZ
         xSKOs3kRhmajHVb1S+1onZ9IHLPS+Yknv4cQmcGvqNVy+4BZR7wvUrAD/NrfpW9mNUSh
         29lv2DnpSwJiv3Gii0kgqBRr/grU0k+pztZjMq428W0FNS2cuoalzvonM/qFQXTFMaP7
         xJTw==
X-Gm-Message-State: ANoB5plnRJJVKqf2ttLEd4KcBpvRj3W387EQdwMVXvHO46GvRBduV9GU
        uS8TxW6htqgYIYao60L6w6M=
X-Google-Smtp-Source: AA0mqf7GB4tSWpDtLhelhZuynKxnu977KSCTCyRT5cUWJqYeo9WRE8n6Wpjo2J18u5oWUE7FtBHcKQ==
X-Received: by 2002:a05:600c:4fd0:b0:3d1:c0a1:4804 with SMTP id o16-20020a05600c4fd000b003d1c0a14804mr25269065wmq.17.1671189696664;
        Fri, 16 Dec 2022 03:21:36 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c3b8700b003b492753826sm2442120wms.43.2022.12.16.03.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:21:35 -0800 (PST)
Message-ID: <ee793350-f5da-7a63-fe2f-d4d081428021@gmail.com>
Date:   Fri, 16 Dec 2022 12:21:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 6/7] dt-bindings: usb: mediatek,mtk-xhci: add MT8365
 SoC bindings
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
References: <20221213234346.2868828-1-bero@baylibre.com>
 <20221213234346.2868828-7-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221213234346.2868828-7-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2022 00:43, Bernhard Rosenkränzer wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index a3c37944c6305..c119caa9ad168 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -35,6 +35,7 @@ properties:
>             - mediatek,mt8188-xhci
>             - mediatek,mt8192-xhci
>             - mediatek,mt8195-xhci
> +          - mediatek,mt8365-xhci
>         - const: mediatek,mtk-xhci
>   
>     reg:
