Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8131E67B483
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 15:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjAYOch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 09:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAYOcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 09:32:35 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0676C152;
        Wed, 25 Jan 2023 06:32:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r2so17228160wrv.7;
        Wed, 25 Jan 2023 06:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYXw+AOPwLHoksA7Df9XhHVSAEgssnhp/xg1dUt6Rjk=;
        b=GHWgJ+c0TSTRESaqEAwTU+5yoPgI+ytcXnZCX0h+e8p01oUDKdNXbNh2cupxWWKQaM
         cSW6mlKwZPksBJrJ8y8ABz8nd2c/APnXLkjsJ4zYFAALKKtHVCrcbUNOeUgj7gyESWfD
         tk8cpWYegvvNzJVSWWZBV8U1FnBFHkQU8Zoe6fDFfMmI1rj7VisvbLDXA/ngSw3jRrvC
         lhWACWx78W1sGREkjmCSV2b7oBoNrEOddTdpaHABIkJVi2vD2676z62WeV7g1r1R8mOW
         o8sJ83vAJSn/Is5bYmliqlsDNT4vYCicEDpJRcVz0psbTStiOMf5uf8XwgsMVRrol26H
         AGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYXw+AOPwLHoksA7Df9XhHVSAEgssnhp/xg1dUt6Rjk=;
        b=bBrbDvsIeAeysjPfSEngxaIzVr1saoQrbFYzcoPsVxVNrnCDyTWowCiBrrXw0FsqHG
         Vv9xAF4kfXkD+66TJfIEvmUFCcXRa0pI3jOgSU9ZuJZ/AUVJapl29Y9fAQ/XXeJpgnaA
         4xwVEdHSVPFOjwvlr5q6OAmikqo+VGiMsOTC4q4yC4GHZgxlnOP19/PHZdsQAKPWoa1V
         7goAKDUXU062RL/OPVR59q5oPc5UCBMXJ8mZFPfEQK8cglqiOGa6UpVN71w50e1Xk4T3
         ktPjPjGVhywfK++YCYidfMSx43278NRJlEQqA7F0PyCFLfw6Vev3AvUDbb5URBTTWuPc
         krpQ==
X-Gm-Message-State: AFqh2kqpj3KXPGAI7cTPZxw+E1s/jNpaaWeHJHXLec3TjQ9loAl8tUR9
        6v+yNSlYsahzBD0UKPI0GIQ=
X-Google-Smtp-Source: AMrXdXvf88ZGka2HcScPY6lOi/9ubPa5qOr1CJ68XaLkNAIMhzQF5oG/o5Vp75Duyi7BfDhyBItWzQ==
X-Received: by 2002:adf:eacd:0:b0:2bb:f4bf:e763 with SMTP id o13-20020adfeacd000000b002bbf4bfe763mr38736300wrn.51.1674657153146;
        Wed, 25 Jan 2023 06:32:33 -0800 (PST)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o10-20020adfeaca000000b002b57bae7174sm4767577wrn.5.2023.01.25.06.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 06:32:32 -0800 (PST)
Message-ID: <b143d52a-0a03-9576-ac32-61591d347e54@gmail.com>
Date:   Wed, 25 Jan 2023 15:32:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt7622: drop serial clock-names
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230123151634.370011-1-krzysztof.kozlowski@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230123151634.370011-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/01/2023 16:16, Krzysztof Kozlowski wrote:
> The serial node does not use clock-names:
> 
>    mt7622-bananapi-bpi-r64.dtb: serial@1100c000: Unevaluated properties are not allowed ('clock-names' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Both applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 146e18b5b1f4..62487a3c4db1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -526,7 +526,6 @@ btif: serial@1100c000 {
>   		reg = <0 0x1100c000 0 0x1000>;
>   		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
>   		clocks = <&pericfg CLK_PERI_BTIF_PD>;
> -		clock-names = "main";
>   		reg-shift = <2>;
>   		reg-io-width = <4>;
>   		status = "disabled";
