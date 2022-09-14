Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0045B8A26
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiINOQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiINOPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:15:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8383F3A496;
        Wed, 14 Sep 2022 07:15:51 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t14so25938416wrx.8;
        Wed, 14 Sep 2022 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zOs1QKwbZyIiYcD44wohoU5bGlws2KHw+g3vnQSorCQ=;
        b=Ks2ZZ2IN9vBeYDzJ0s9jZhTQYhtlLUrRLYKvlMVyyF+fOG6cQTXOWPlmH7SnCj0oBN
         0xmRSYhQ7hlpYwFPu3mfH8C7Ausi9Cy8vkEBvWrSbbraws/ubtp/3x12f2bTL7Agaox5
         KVldTUUHDt2FtdfDZ5Zle50v9SNWt6CPMcCnkiQnT49u3x7ZVxVBp59xJkBzlLrnQE4z
         RcfgjOk6uUsHIuOpY+mlpl7LLgkTFyfYG9343COAOqBPxDodKIih9CbroSaqWXSllqWF
         G06iBnCr1pHfkDxMkzBfV5FGHAAtPRKLDyZ6j1V63/XjY/2MOv2HujUttLL0FRVpTOzk
         T+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zOs1QKwbZyIiYcD44wohoU5bGlws2KHw+g3vnQSorCQ=;
        b=U+UjIkKIyV2wWVfbPYyOI9szUPQgbGeITQGhItl4U2WsaUqKpAxB2NpTz/Tt6MrZUP
         Cn5PunTLGlKzudCmqdBt5feqiRpv6+PUiR0m0Du6hrVbzVX/bYq5Y7eQhmH1UqaEqlDz
         K63bMpOXh6ksKS+r46fX6Uo40kpBwJa9UDRyK779zH81eJokWuEcVIhHrRNx1z0N/Ttt
         gkJb97/f5tWGZ3v1PodTAjZZ6B4lV/MKV7HSXt+r6DYDHS1+hmgN2J8uoelonRehtr18
         OIVi+Tg0I1VE0Ra9xQndPuoJS+IH0MD57IWRCKOYBbpAh6ZnKqKJ936m0i8t5srNa2LM
         qX8Q==
X-Gm-Message-State: ACgBeo273NgEzsBUbvbFb5d5zAn6qblGglU61vg2Xnq4MeLXqrGf6F4d
        IoFuqLMZC35MCIGmaVaIOWE=
X-Google-Smtp-Source: AA6agR7Bu+ObYtkfeAMtim+ngA8n2IPmkQsqMg5NlIrP9uzCd4DPRq+COGJZeAVGftuRUF2LCdFdKQ==
X-Received: by 2002:a5d:6f03:0:b0:22a:2de6:9229 with SMTP id ay3-20020a5d6f03000000b0022a2de69229mr18997910wrb.91.1663164949659;
        Wed, 14 Sep 2022 07:15:49 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o16-20020a056000011000b0021e4829d359sm13315939wrx.39.2022.09.14.07.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 07:15:48 -0700 (PDT)
Message-ID: <a8af4c54-12a2-a314-f190-f12859ef4ddd@gmail.com>
Date:   Wed, 14 Sep 2022 16:15:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: remove thermal zones
 without trips.
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220914131339.18348-1-aouledameur@baylibre.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220914131339.18348-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/09/2022 15:13, Amjad Ouled-Ameur wrote:
> Thermal zones without trip point are not registered by thermal core.
> 
> tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
> only but are not supposed to remain on DT.
> 
> Remove the zones above and keep only cpu_thermal.
> 

My understanding is that this thermal zones exist but are not used. DTS should 
describe the HW as it is, so I propose to add
status = "disabled";
to the zones.

Regards,
Matthias

> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 57 ------------------------
>   1 file changed, 57 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 9d32871973a2..f65fae8939de 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1182,63 +1182,6 @@ THERMAL_NO_LIMIT
>   					};
>   				};
>   			};
> -
> -			/* The tzts1 ~ tzts6 don't need to polling */
> -			/* The tzts1 ~ tzts6 don't need to thermal throttle */
> -
> -			tzts1: tzts1 {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 1>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
> -
> -			tzts2: tzts2 {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 2>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
> -
> -			tzts3: tzts3 {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 3>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
> -
> -			tzts4: tzts4 {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 4>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
> -
> -			tzts5: tzts5 {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 5>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
> -
> -			tztsABB: tztsABB {
> -				polling-delay-passive = <0>;
> -				polling-delay = <0>;
> -				thermal-sensors = <&thermal 6>;
> -				sustainable-power = <5000>;
> -				trips {};
> -				cooling-maps {};
> -			};
>   		};
>   
>   		pwm0: pwm@1100e000 {
