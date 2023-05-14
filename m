Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479A5701CCC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbjENJzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjENJzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:55:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABAAC0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:55:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94f4b911570so1853961966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684058144; x=1686650144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmnCd9zBSpzSRwFsU5TtJIOG/MCBXv4toD2D925k+2k=;
        b=AWNmy5FBccEuQgwM1II/lH3TjYuI1CWhObctyu4ktSINIKc1QgcniKjKgFNcNakdKm
         ZE+dHukU5YKKrCfW0AHAmhCxQwHu9NsH+M9YfTgrmdkwblST1Y2w8hXWM2CaMr4W9RHr
         d7o09e3odUGHjZ5EJDXocOHtyXS0gO9d0PnZM17ZU1xvffirHLPmBvvP8EZgCnRJ5lZh
         eVMlW+d/Qqdjr/G+MKZjx745hKuSKVgPyRF7ogv5HWhEl6SqK0Jr7FbPz6d1/IvotPOV
         Jm8WSxsLIS6jJdgINxct2xfQshwY5jy6Ljxfy/fZSNSMfg/Iq/GdOy1uhyDvk1YZbJGk
         koeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684058144; x=1686650144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmnCd9zBSpzSRwFsU5TtJIOG/MCBXv4toD2D925k+2k=;
        b=Ly2kr2H25Iwr6mlqm3ZcXV7yZZeFzhDOLRfShadJETxJd4EGdyaCBrnNMB7Czu4y68
         ovZ7PIopzofQN2bpObiOiW1NSwdjJgzhJBgq+Zr8zZWeITJhe3o+twDvDlnqSvb3qDJ4
         5qyHuIGTr3LXcmIeOFYY67/8JxveV6RSTIg/1gDCBt3uZCK1aBIfqTxoeycjy94HpspH
         W2jDWbnDKnKTuN6o8JJPygV17nsnDVNwZJKRTeq32v4VXZMebu3+LSBEQvdIESdab7qG
         P36afCXjN4kN7xLrEnfPha1atGTvZEzhTW3BI/ExzhpY9GuPzMLfwLMprYbjebC6Xx45
         zgtQ==
X-Gm-Message-State: AC+VfDykKj0mHKzA6Ui3BdHxyN5IsqK9oQAv5af5HDAfIHzCpA5JVuRC
        jEcIuR5w67+m0siMOEHT3RGDYQ==
X-Google-Smtp-Source: ACHHUZ7hRkuoxb1+sQp7/C83yF5sWrBdHlBQlIGqSszE7wlv1cUtZW6L2gB9QqiiPEPzG8C+ePthow==
X-Received: by 2002:a17:907:9810:b0:96a:861:a2ac with SMTP id ji16-20020a170907981000b0096a0861a2acmr16240193ejc.0.1684058144158;
        Sun, 14 May 2023 02:55:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:715f:ddce:f2ba:123b? ([2a02:810d:15c0:828:715f:ddce:f2ba:123b])
        by smtp.gmail.com with ESMTPSA id r9-20020aa7cb89000000b005021d210899sm5667044edt.23.2023.05.14.02.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 02:55:43 -0700 (PDT)
Message-ID: <51dbd824-7d90-8a69-902b-d643347abdf3@linaro.org>
Date:   Sun, 14 May 2023 11:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: h6: tanix-tx6: Add compatible
 bluetooth
Content-Language: en-US
To:     Rudi Heitbaum <rudi@heitbaum.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, anarsoul@gmail.com, alistair@alistair23.me
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-bluetooth@vger.kernel.org
References: <20230514074731.70614-1-rudi@heitbaum.com>
 <20230514074731.70614-4-rudi@heitbaum.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230514074731.70614-4-rudi@heitbaum.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2023 09:47, Rudi Heitbaum wrote:
> Tanix TX6 comes either with RTL8822BS or RTL8822CS wifi+bt combo module.
> Add compatible for RTL8822BS as it uses different firmware.
> 
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> ---

Thank you for your patch. There is something to discuss/improve.

>  arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> index 9a38ff9b3fc7..9460ccbc247d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> @@ -21,7 +21,7 @@ &uart1 {
>  	status = "okay";
>  
>  	bluetooth {
> -		compatible = "realtek,rtl8822cs-bt";
> +		compatible = "realtek,rtl8822bs-bt", "realtek,rtl8822cs-bt";

This neither matches bindings nor your commit msg. If device has
different chips, then you should not stuff all of compatibles together.
Please analyze the case. Maybe you need different boards for different
revisions?

Best regards,
Krzysztof

