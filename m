Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C1A6D0CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjC3Res (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjC3Req (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:34:46 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE25FD9;
        Thu, 30 Mar 2023 10:34:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h17so19874022wrt.8;
        Thu, 30 Mar 2023 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680197684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKcsS9RzCGec1E//KXDqFuO125uv1xUjBzG3GmeKye8=;
        b=dNK04s5t55ImmI318ms5Q5vMBO6oGsmgyndXUx2HwP0KcT03d4xUijqy9mx9MidUla
         oqnhQbfNk27Gv4tSdtc9YCZqR9JnL83ry2Ph5XWSSkjhQXQzOFZkN48wR8eRDOMVqh65
         /zGwapoRE4auJbHsNTt+aaVjCyO+2Y6MvnMKQaTJ1ueAUS8b98TgPaTj3h6ntiSP9O9E
         wp8IWnm1g7WKdojuXFP1+q7hApx+SmDNfWbnF7oeTOG3QljXLNb7fa35PK6kbTpwxdfT
         JP53oDnNjI+IOjOMCylwS/S+SqPzybQh93EOpgRw1RW+NaIf/eupOZWphDnVZijch8Tt
         3Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680197684;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKcsS9RzCGec1E//KXDqFuO125uv1xUjBzG3GmeKye8=;
        b=uZmkMh9lrozd/lEgN4DnsYzN8oMnGBnKXcaN+Lgic1ZbJZsW10uGsMIxEVJ0TA5yce
         TPFEJU3tUDh9QNb/LVAO5+ZWG25NLr5yobBkEdJ0wufcB/QlcHapfzK0H59XtcRuWhem
         zI/A/DNsrVlDOySa9/K0EWFwtPXk2cHYW52sQyE1QtuHsqMsB69+to8A2Iwy1zTJMiST
         wT46BQZVo4Pm8Tq0Sr6t2HNWglp8RpPcz3lhylyJt4j/3AMg64PZXjkw24gZMyCHORCp
         rbLQkTj4I+F362JJHNfSYiK3xHak1Zfwo5IAMKHVxqzLI14/v9C1OCgUSSv5WQpSp0Qv
         YRUA==
X-Gm-Message-State: AAQBX9d47/1iDPjNPHb6YdeoM+S5vb1k3v5z44oG9B2Aass22H0KqfiO
        jwEZqfEeYVVXONlO+acGnR8=
X-Google-Smtp-Source: AKy350aqPaeaRaIzLq93xnKLSwV1qqKksBHcvZw5qKcC1QEWi7p3c+y9jOvEB5VB6d4m4y575WhvRQ==
X-Received: by 2002:a05:6000:ca:b0:2d6:5afe:7b91 with SMTP id q10-20020a05600000ca00b002d65afe7b91mr4918787wrx.30.1680197684064;
        Thu, 30 Mar 2023 10:34:44 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d67cd000000b002e40d124460sm4189268wrw.97.2023.03.30.10.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:34:43 -0700 (PDT)
Message-ID: <8c917be2-e15a-921f-aaa9-b8753d2463de@gmail.com>
Date:   Thu, 30 Mar 2023 19:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 16/17] arm64: dts: mediatek: fix systimer properties
Content-Language: en-US
To:     amergnat@baylibre.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-16-0003e80e0095@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230203-evk-board-support-v3-16-0003e80e0095@baylibre.com>
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



On 29/03/2023 10:54, amergnat@baylibre.com wrote:
> From: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> 
> MT8365 has a SYST timer (System Timer), therefore the compatible node
> should be "mediatek,mt6765-timer" instead of "mediatek,mt6795-systimer"
> (which corresponds to ARM/ARM64 System Timer).
> 
> Plus, register range should be 0x100 instead of 0x10.
> 
> Finally, interrupt polarity of systimer is LEVEL_HIGH.
> 
> Fix the above properties accordingly.
> 
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Patch looks good but does not apply cleanly because of previous patches that I 
didn't take and need rework. Please resend the patches I didn't queue with the 
comments addressed.

Regards,
Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> index c3ea3cc97a47..959d8533c24c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
> @@ -575,9 +575,9 @@ system_clk: dummy13m {
>   	};
>   
>   	systimer: timer@10017000 {
> -		compatible = "mediatek,mt8365-systimer", "mediatek,mt6795-systimer";
> -		reg = <0 0x10017000 0 0x10>;
> -		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_LOW>;
> +		compatible = "mediatek,mt8365-systimer", "mediatek,mt6765-timer";
> +		reg = <0 0x10017000 0 0x100>;
> +		interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
>   		clocks = <&system_clk>;
>   		clock-names = "clk13m";
>   	};
> 
