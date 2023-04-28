Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A116F18CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbjD1NG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjD1NG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:06:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87071BE7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:06:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so85341575e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 06:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682687184; x=1685279184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3cwHpswGJR12HDg9y2vo9O8mOmWfLPFabeOj9DNgGAg=;
        b=MPH4jaAlfdO4o9ovvo6tXiTAsHWdtJ5AK7audvq/ab4uTJNvQ2elejAjeOrBS7zVLi
         voi8akZXJYC7DWfECQio7+PDFFUgTvOlouGjVKc+qzaJ6TRhenvdd30b6BJvQawjqEao
         Hmzg1vwjXGXi389jpNc6uUuV2dHntko4TMrxxohYCHGomR5jOV1frxLIY/bfhg6Cznh2
         VtMplhccASZ8cLwIBhcbT4XYUaFSxmFBBfcQ1UHBNnm+TR7wk6gIjymDMsXkPh9klHuk
         S7IPYrR8DuC/BVe5L7k1tCVXnZMRVLIgAnd0NNbm7UlSXmE/pHhe26qXvwaO/LMmdSOo
         90Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682687184; x=1685279184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3cwHpswGJR12HDg9y2vo9O8mOmWfLPFabeOj9DNgGAg=;
        b=ip46S0Kq6Uf0H1Z7kFqJ4hhMWUcfVwly/y9olcaImm+kuJnp1y5x6mMU44D8gqpdO+
         rwu1jc8/AwKJJjEqF6R0SYlUI70WgCAu3tAxzjhR1safY6kZnoPIEn1RFz2CfpCrfKrl
         Dutox/3fg72wGlCg460fM7v2n4BAoadGw07BpNYkRqLspPVV2eg0z/IDPSon6wIzcc8F
         UrvWPPWkTWSD1Ca4FT5pNk4c4iw18AyU6zNaBX3TlLvuqxRGH1L6udMgnye8m+WQnkWl
         7FqAcW8Ll5+jXQUeOcGhosS51dvPkVuE6JLGo6hHfV+wG9v8Ap9CJPgvmy/lptY+1WlV
         fHTA==
X-Gm-Message-State: AC+VfDyY8SYRKLnRKHdNsx82kTRENn67ZlZ/AtXIAsYUpzWUl+xfQWnG
        Rq/izUJUwFuj9jg1IujL41GV3A==
X-Google-Smtp-Source: ACHHUZ51Nbau2eLwoflvEMTw3GWYfix8SJSummBcI1rFXhuEzr2Sn7NxGpYz71j8XpzNcFrrh7sxTQ==
X-Received: by 2002:a7b:c447:0:b0:3ee:3e07:5d26 with SMTP id l7-20020a7bc447000000b003ee3e075d26mr4275011wmi.24.1682687184416;
        Fri, 28 Apr 2023 06:06:24 -0700 (PDT)
Received: from [172.23.2.142] ([31.221.30.162])
        by smtp.gmail.com with ESMTPSA id ip29-20020a05600ca69d00b003f1712b1402sm27686051wmb.30.2023.04.28.06.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 06:06:23 -0700 (PDT)
Message-ID: <88a7cf9e-89a5-7860-2219-337aee04e75e@linaro.org>
Date:   Fri, 28 Apr 2023 15:06:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] imx8mn-var-som: dts: add SOM EEPROM
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230427195639.2718734-1-hugo@hugovil.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230427195639.2718734-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 21:56, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Thank you for your patch. There is something to discuss/improve.

> 
> The 4Kbit EEPROM located on the SOM contains hardware configuration
> options, manufacturing infos and ethernet MAC address.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
> index 9052b0d4b5b4..3ed396f41e46 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som.dtsi
> @@ -30,6 +30,10 @@ reg_eth_phy: regulator-eth-phy {
>  		gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	aliases {

Keep nodes ordered.

> +		eeprom_som = &eeprom_som;

That's no valid alias. Which upstream kernel driver makes use of this?

> +	};
>  };
>  

Best regards,
Krzysztof

