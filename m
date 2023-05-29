Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C1714B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjE2OBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE2OBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:01:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C1E102;
        Mon, 29 May 2023 07:00:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d20548adso1959940f8f.0;
        Mon, 29 May 2023 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368825; x=1687960825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=czUg0GEsA4/pXkVvDlCWQ/xq4KtcNj5P7Uchklz5mQ8=;
        b=j6QlqVGDsb5MBvK6xpO9PmsCQzkb4YXc9jTOoj10YSyM3wKNZ7U9/DJfUoZZ9y7iF3
         aVPBszW4LrX4/yBLrPONK9Hya6xe/RJOQfU9SBS7Ygiz1WYILg69U4iYndjLN8aSXQ9H
         kKTVf8maGXd/Fv/aePNTtlrSxhhPcgTncc/qlCZHwd9tVhJngCXRjGsUg0OukApB0KYC
         PyjA0zfJhv/CumecS1wyWxunseHmCn0rU5IePGNMLoS7MlEcpe94wp+v8yMzWZW2sCQz
         o4o6FMk3v+Q0z0gEuPojqAcUBrJvy8Rvndm1eMod030LPgiCRvW0A32+fS/XG6Qbau6Y
         aELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368825; x=1687960825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czUg0GEsA4/pXkVvDlCWQ/xq4KtcNj5P7Uchklz5mQ8=;
        b=LwZM5CTkec2ODyS4VhdtejZ0uXAfTLb2X8p1EM9RO5LpmVM/uTnXL0oSz/oeuShqqk
         CKVaQyfvFzcR0wg33Xog8VD4nrhWaRnxZffgWTWjLLgEp0EuhNn1q/sViHHEyp1GYNk4
         74mRKVldh/Bi3hiFIe//hR3I9qgxZoWLVnLY0Yjr0iGWDWAZDZk4K/O072tSrVFQmzCa
         dpvXlUjT//vJ8XEahNcrOaykWr3urA7CaRiFU5ObDuAxtohiF2o3EAAsIBvc2pNi7DUB
         wil4LWBkzzN8r4gIz5ULVRZ6pHHSQYdjsEOCSZJDWn8iolG78rTNC01SqM5VrimUn3H/
         ChEg==
X-Gm-Message-State: AC+VfDz04/fGl5J+KIhxSXuunk02tN5+MQ2wlfYq6lqz9XygYfVU3tXK
        kh/6kdsNxSjEoNXMaig8U5M=
X-Google-Smtp-Source: ACHHUZ5YY0F8kf9d0QDQxU1ifflONL13Hhhhoz7ubJbKMoUbd8atPVWeXbHNhdhapWASVn5XN1KjHQ==
X-Received: by 2002:adf:f512:0:b0:307:88ba:c999 with SMTP id q18-20020adff512000000b0030788bac999mr7756125wro.62.1685368825106;
        Mon, 29 May 2023 07:00:25 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b0030631f199f9sm68502wrs.34.2023.05.29.07.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:00:24 -0700 (PDT)
Message-ID: <731fa0b6-5576-94fc-7cf5-0ec768db9c7d@gmail.com>
Date:   Mon, 29 May 2023 16:00:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 24/27] arm64: dts: mediatek: mt6795-xperia-m5: Add MT6331
 Combo PMIC
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-25-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-25-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> This smartphone uses the Helio X10 standard MT6331+MT6332 combo PMICs:
> include the mt6331 devicetree and add the required interrupt.
> 
> Note that despite there being two interrupts, one for MT6331 and one
> for MT6332, in configurations using the companion PMIC, the interrupt
> of the latter fires for both events on MT6331 and for ones on MT6332,
> while the interrupt for the main PMIC fires only for events of the
> main PMIC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> index a0e01a756f03..debe0f2553d9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
> @@ -7,6 +7,7 @@
>   /dts-v1/;
>   #include <dt-bindings/gpio/gpio.h>
>   #include "mt6795.dtsi"
> +#include "mt6331.dtsi"
>   
>   / {
>   	model = "Sony Xperia M5";
> @@ -219,6 +220,15 @@ pins-tx {
>   	};
>   };
>   
> +&pmic {
> +	/*
> +	 * Smartphones, including the Xperia M5, are equipped with a companion
> +	 * MT6332 PMIC: when this is present, the main MT6331 PMIC will fire
> +	 * an interrupt on the companion, so we use the MT6332 IRQ GPIO.
> +	 */
> +	interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
>   &uart0 {
>   	status = "okay";
>   
