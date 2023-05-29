Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3934D714C01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjE2O0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjE2O0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:26:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C10A7;
        Mon, 29 May 2023 07:26:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30adc51b65cso2826357f8f.0;
        Mon, 29 May 2023 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685370359; x=1687962359;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXtZ8jTLGIvEBWYCRTpBhewkMkogoQ9bFzj7hAi4Wtg=;
        b=CtQyVaqVUpQtQQJZ9jec28L6SLkbwl9snhpTaa3zgPPN6JigSwMqEGpZ2L9te1RxEm
         dbddbM1aasXrU1DpFm5I8jDwYs+WuPO4bhDSaHdctK6Edar1OmIwprHqda5sIqtQmA6a
         XPRXAugKnnxK4kOrlLSvQCeTjYtPKjdPls1WCVCiDeqwHmQ9CxXR5gzoXpwWUAwp1MDC
         jXvIrKvjLMdtUkgIlqR01vnB250SUePsItLH6zjLVq4LqNNQGqLwN/jd4M1f63Gixcfu
         nHDKlQBDsjfZ3Sxft8vmsG3H+LOY5VObwvJ98NBO8Yt8FZBGqvFtjSXWTDER4X+YT0yS
         +EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370359; x=1687962359;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXtZ8jTLGIvEBWYCRTpBhewkMkogoQ9bFzj7hAi4Wtg=;
        b=OoofdG5lPDES+R9TAMJxtM+bw/NU1hrQDOyLvVpUvqJHB3B9w3CfU20H69jFb6HX6k
         DxfryQwZZ/sfnjWX0cUL8PSnq75tB7pBLxfQWCMwI7lDJ1lQPsrHuFQoh63jniStfPP/
         755eLs9frxetHgmlJu1yfszCcF5dPO/G8simnfl2juYBOCNpBcQAMlz5azpqR2wi6SF6
         m2mFo6WHfzMbTfukSBGbY5sruAJl4t9Jrm9p/3hftJHBPHJClVsavMDFOGF8rhZgorO3
         WsWYKafMGQZgw/69XQKEo6LU/YeadKeVV7+Fofx0fGFhaP1ERDnG/S2OhSxQwpiVTIi1
         69Cg==
X-Gm-Message-State: AC+VfDw74JOMC/u/8x+fqFaQfBNGvPweDudhiNNfUyt0tRnB0YxpPcib
        qAafL/PzJd1Zfk+d2qBs1pc=
X-Google-Smtp-Source: ACHHUZ75e2K3NjqMzIg1RWmj1krj3NbJ1QjixBfZ2gImSczXxJoYNdhM2rHgT47jRzLvjBUC7KveHA==
X-Received: by 2002:a5d:6291:0:b0:309:e24:57b3 with SMTP id k17-20020a5d6291000000b003090e2457b3mr9982997wru.4.1685370358984;
        Mon, 29 May 2023 07:25:58 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p3-20020a5d4583000000b0030649242b72sm78475wrq.113.2023.05.29.07.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:25:57 -0700 (PDT)
Message-ID: <3aeb528f-4425-4be9-091d-068e8419334e@gmail.com>
Date:   Mon, 29 May 2023 16:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] arm64: dts: mt7622: handle interrupts from MT7531
 switch on BPI-R64
Content-Language: en-US, ca-ES, es-ES
To:     Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <ZEA-DV_OsmFg5egL@makrotopia.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <ZEA-DV_OsmFg5egL@makrotopia.org>
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



On 19/04/2023 21:16, Daniel Golle wrote:
> Since commit ba751e28d442 ("net: dsa: mt7530: add interrupt support")
> the mt7530 driver can act as an interrupt controller. Wire up irq line
> of the MT7531 switch on the BananaPi BPi-R64 board, so the status of
> the PHYs of the five 1000Base-T ports doesn't need to be polled any
> more.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> index d583e816684cf..aabd104b12acf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> @@ -150,6 +150,10 @@ mdio: mdio-bus {
>   		switch@0 {
>   			compatible = "mediatek,mt7531";
>   			reg = <0>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupt-parent = <&pio>;
> +			interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
>   			reset-gpios = <&pio 54 0>;
>   
>   			ports {
