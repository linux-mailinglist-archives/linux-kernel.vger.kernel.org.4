Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA76294BB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238048AbiKOJqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiKOJqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:46:21 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7576E23BC3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:46:20 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l8so16749777ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myaQTYekEEvCf76a4+gISy0XqIGFzl2LwV2cgISui5Q=;
        b=X1IWKQj3w5D972UXgMdWCTaFrnyGHi/VzgHqCFHZRaKPGXuud6oEjzpTNLbEydjTpb
         zyxE+Xz/mdfV8rXm1CRknMStZnl73HBDzMzSTD+6nKbeZG35NzG+rl+fG/huKbN6ESdL
         a9X5OiPLc+ecSaWltKRK4+b/8cwiTtwKwC1/3SRzkzyJI8WNPcVUVE6JoNWyxGQeQufX
         xOiPXLNq1SQDpPaCbFv4pjtCeFhkavS5B8RT3aP3BLlKeMBDFplc3RlgH/4Gsp0zWzuM
         y2g3h6SKJlgFj9eDXHXJQ5hR1UOiG/nY1E9LyDHNkDmb21kXWIBWpkKXMlca9QaXKJjx
         ES0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=myaQTYekEEvCf76a4+gISy0XqIGFzl2LwV2cgISui5Q=;
        b=hSSwu3XmBTC7AdM2q3xfGgQYY2B56se2YRZPlO33T5t9Wa8XzZOcecramtQbVmnnUz
         sb37uRWVokly3EQlzV4QF3+3e6vxoy95knzNIFzHO4383voi72YgjR2waa8hLLD0x9be
         JNKaHspKljz5rqueVBs7kIqONDHGpBiaxGBj0+dC/1Xr3AXTCTtN0e70L6o3cavO3ZiS
         uEyhn6OIt3oivDpru5hL60inZSMTLfStjVDah1DBixIdGjAlN2VEBT8Ond3aVPE8uc3j
         2TnYjDtHZxKuYKZhF12H/ity7vNmEgMv6bXU1ukCs7F6hjoEa+y+4nfxQqvDW6AoNc6Q
         f9ig==
X-Gm-Message-State: ANoB5pmYTP74fE6V1joS2V4VnFl2j+6Qh5xRyDR3N/1x83xdm140UUTk
        d2Y5WqRP/VAobCKn8k/ZjjKcpQ==
X-Google-Smtp-Source: AA0mqf4LhGjamVr1Hys8y0bwuIu6sZlCP5+dinsuwstOAf/Naygjc5ex3Zg7j1wIEjz5EXY0OnuBcw==
X-Received: by 2002:a2e:8892:0:b0:277:9847:286a with SMTP id k18-20020a2e8892000000b002779847286amr5124555lji.309.1668505578768;
        Tue, 15 Nov 2022 01:46:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t10-20020a195f0a000000b0049c86ca95bfsm2143300lfb.52.2022.11.15.01.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:46:18 -0800 (PST)
Message-ID: <13220449-5b86-e79c-54ce-2f8883b7a036@linaro.org>
Date:   Tue, 15 Nov 2022 10:46:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 11/15] dt-bindings: pinctrl: add bindings for Mediatek
 MT8365 SoC
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
References: <20221107211001.257393-1-bero@baylibre.com>
 <20221115025421.59847-1-bero@baylibre.com>
 <20221115025421.59847-12-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115025421.59847-12-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 03:54, Bernhard Rosenkränzer wrote:
> Add devicetree bindings for Mediatek MT8365 pinctrl driver.
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---
>  .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> new file mode 100644
> index 0000000000000..bddff8c2fd382
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/mediatek,mt8365-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT8365 Pin Controller
> +
> +maintainers:
> +  - Bernhard Rosenkränzer <bero@baylibre.com>
> +
> +description: |+

I am not going to review this - please go through comments you received.


Best regards,
Krzysztof

