Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1CD6CC13F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjC1NnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjC1Nmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:42:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3825FBDDC;
        Tue, 28 Mar 2023 06:42:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 755956603152;
        Tue, 28 Mar 2023 14:42:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680010968;
        bh=qsVPM3z/5gvfqY0OJHUnJjWl2dyu6dw5XnunJEzfZJU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gJRtMbN8bhOpMo9aGLczdnRGpiM9202XYqLjcbrrxp9dntyv/7Mn45lQpYNtyHWcM
         O/sUv4uKMTb9xLveJADK6yFkUcUfnPSsuuKHxpxVAlDUhGPnPMGPra0kfXUjUyoAUS
         OqqPNamE1+8wujXki+tMjPXUjr2s6R8ww1fq57vWZdKOhD0ybk6GGZ0IQAKEoTSMFp
         iBci9Gb49fW4be44BOH1eG7IxJNM6Ti8XC2+cxwjo44Esg1mJP63/w8swMgZo0idA5
         TU1aGsa8KEbTEIU6tznM2zaGj60NZZdf4xka/a8juo22DrNQFVMoGtlw+a3hlNEYKu
         dxLNdhMvzAmhQ==
Message-ID: <9a9837ce-f800-f960-a82a-55ef6e71e95d@collabora.com>
Date:   Tue, 28 Mar 2023 15:42:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: mediatek: deprecate custom bias
 pull properties for mt8365
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com>
 <20230327-cleanup-pinctrl-binding-v1-2-b695e32e4f2e@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230327-cleanup-pinctrl-binding-v1-2-b695e32e4f2e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/03/23 15:06, Alexandre Mergnat ha scritto:
> In order to be more generic, "mediatek,pull-up-adv" and
> "mediatek,pull-down-adv" should be deprecated. Use "bias-pull-up" and
> "bias-pull-down" instead.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  | 32 +++++++++++++++++++---
>   1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> index 347f533776ba..4ebc7f1caf55 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> @@ -72,12 +72,32 @@ patternProperties:
>             bias-disable: true
>   
>             bias-pull-up:
> +            oneOf:
> +              - type: boolean
> +              - enum: [0, 1, 2, 3]
> +                description: Pull up R1/R0 type define value.
>               description: |
> -              Besides generic pinconfig options, it can be used as the pull up
> -              settings for 2 pull resistors, R0 and R1. User can configure those
> -              special pins.
> +              For pull up type is normal, it don't need add R1/R0 define.
> +              For pull up type is R1/R0 type, it can add value to set different
> +              resistance. Valid arguments are described as below:
> +              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
> +              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
> +              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
> +              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
>   
> -          bias-pull-down: true
> +          bias-pull-down:
> +            oneOf:
> +              - type: boolean
> +              - enum: [0, 1, 2, 3]
> +                description: Pull down R1/R0 type define value.
> +            description: |
> +              For pull down type is normal, it don't need add R1/R0 define.
> +              For pull down type is R1/R0 type, it can add value to set
> +              different resistance. Valid arguments are described as below:
> +              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
> +              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
> +              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
> +              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
>   
>             input-enable: true
>   
> @@ -123,7 +143,9 @@ patternProperties:
>               enum: [0, 1, 2, 3, 4, 5, 6, 7]
>   
>             mediatek,pull-up-adv:
> +            deprecated: true

Same for this one, removing it shouldn't be a ABI breakage.... but please wait
for Krzysztof or Rob to confirm that before pushing a v2.


