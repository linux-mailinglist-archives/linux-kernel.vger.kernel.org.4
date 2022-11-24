Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B620B6377B1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiKXLbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKXLav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:30:51 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768D77EC83
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:30:47 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id d3so1689919ljl.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fyb8cWovIHqjfoKBUsRkxLqfHtzttGTVJMM1/mMniBc=;
        b=QZk3tIfbzK4rNT+vIGPYUeXn4gNgs+gW6dkAXRxipvRcU4xuaMIl3agnzv/tg6k1s4
         LKxEj/JapkraxMo0L3Y9KUV69bri62FuZyfBMDZ7Grj59z5hpR6L4Sxg6fh+E14Ll2Qw
         kwbdatuLICRroPArSIXGB3rUucBLjcZITeEizV/yp5Mge5dWj3Cy75qb6k7pYAu5etFQ
         O1N2dks6mhny2t+RRF/bvCEyJ+Jre9HzBZSIhsXvuWZ5/Ijw/W2ILeYfZYpeA/X3pwvP
         nomzsP11aNAY4hKRCJOE7t/rWNKRoMmCh+DYBwAkmzvrT/9DGP6OXAl6o5EdTwPHsJv0
         P6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fyb8cWovIHqjfoKBUsRkxLqfHtzttGTVJMM1/mMniBc=;
        b=U8Xd76JpINkHVD1+HkMDAs3ayrtMcVo0ZhuPZIN4AlE7oikKpOSkEBxnVpcxJe11OA
         6wpFqj1w7LBxfqJo6v33/vrM9aIufOOsi8VcvMoz5qGtj788VATlfPqqF+igUMR4FWir
         GcK5HGjmmH6MsBZAScx3+d4/xh4FNWco/Kl7LMi5yppTcIDkRF3yqObcLRxYkxwvP/D1
         +BomillAn0wJ4VR44oHYaUM/5gwNcGkDUqWkVB5eYcjBjU5jVXTu82eqJR+p6dc5b/1S
         B3TQayV/CCwQ+vI659C8TnpPufnqNBXa2Xgl6BX1s8TrDflAV91dA6XZHpky6JqhjDom
         Ml7Q==
X-Gm-Message-State: ANoB5pmhR0ENejXFa0cbDZCIhL6iR+CWFYHd/ypYG+hsxQOR0rOEkdbd
        DWAM1U8/+Mn93GdDozr7io+f4A==
X-Google-Smtp-Source: AA0mqf7BKwwl8DQ9FRp+pIXisHGgV5Q1UBV/4F4DMWyHmsPYWp4b2sHCx8CXTm7yLTzau1VK7KZLWw==
X-Received: by 2002:a2e:824e:0:b0:26f:be8e:5298 with SMTP id j14-20020a2e824e000000b0026fbe8e5298mr5653251ljh.418.1669289445821;
        Thu, 24 Nov 2022 03:30:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p19-20020ac24ed3000000b004b4f1ea713csm95584lfr.73.2022.11.24.03.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:30:45 -0800 (PST)
Message-ID: <e5e87795-12d7-699e-1539-2e60b8b51957@linaro.org>
Date:   Thu, 24 Nov 2022 12:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH RESEND v2] dt-bindings: pwm: mediatek: Add compatible for
 MT7986
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.or,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Zhi Mao <zhi.mao@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
References: <Y39PjU1BqBB8tZ98@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y39PjU1BqBB8tZ98@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 12:03, Daniel Golle wrote:
> Add new compatible string for MT7986 PWM and list compatible units for
> existing entries. Also make sure the number of pwm1-X clocks is listed
> for all supported units.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> Changes since v1: list compatibles, fix pwm1-n clocks for all SoCs
> 
> Rebased on linux-next and re-run scripts/get_maintainers.pl on patch to
> makes sure dt maintainers are included. This has been requested by
> Krzysztof Kozlowski.
> 
>  .../devicetree/bindings/pwm/pwm-mediatek.txt  | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index 554c96b6d0c3..952a338e06e7 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -2,14 +2,15 @@ MediaTek PWM controller
>  
>  Required properties:
>   - compatible: should be "mediatek,<name>-pwm":
> -   - "mediatek,mt2712-pwm": found on mt2712 SoC.
> +   - "mediatek,mt2712-pwm", "mediatek,mt6795-pwm": found on mt2712 SoC.
>     - "mediatek,mt6795-pwm": found on mt6795 SoC.
> -   - "mediatek,mt7622-pwm": found on mt7622 SoC.
> -   - "mediatek,mt7623-pwm": found on mt7623 SoC.
> +   - "mediatek,mt7622-pwm", "mediatek,mt8195-pwm", "mediatek,mt8183-pwm", "mediatek,mt7986-pwm": found on mt7622 SoC.

This does not look right. What you are saying is mt7622 is compatible
with mt8195, which is compatible with mt8183, which is compatible with
mt7986. It could be true, but I feel you wanted to say something else -
mt7622 is compatible with one SoC which is generic and common to all
other implementations.

> +   - "mediatek,mt7623-pwm", "mediatek,mt7628-pwm": found on mt7623 SoC.
>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
>     - "mediatek,mt7629-pwm": found on mt7629 SoC.
> -   - "mediatek,mt8183-pwm": found on mt8183 SoC.
> -   - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm": found on mt8195 SoC.
> +   - "mediatek,mt7986-pwm": found on mt7986 SoC.
> +   - "mediatek,mt8183-pwm", "mediatek,mt7986-pwm": found on mt8183 SoC.
> +   - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm", "mediatek,mt7986-pwm": found on mt8195 SoC.

This as well looks excessive.

Best regards,
Krzysztof

