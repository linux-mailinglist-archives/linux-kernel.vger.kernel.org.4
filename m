Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A9A7474F5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGDPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjGDPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:08:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245A10CF
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 08:08:17 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98df3dea907so674536866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688483296; x=1691075296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3zDnTtGNuT1E6yZFaZ/zNDj8BnaMTvIa2O34NjwFss=;
        b=Kv1ja5c0LWVZA9c8wPq32wEL3jos+gFSScdXoAJ8syfa3qIlsDMI1rF+DCUrFX7Ndi
         ehWfXIiN4SYjBiIYAQDGmR6fUPoQ8vyjeg2QySK3N10eI08NkNHdQeoicISFkBde53Dz
         oYPPeb0Cwjv5hGpjRlkq4VB9yC0pIWz3VYlS4oizcK/wCRBsJf1bYuE+1p7w2smXmzup
         pQMVy68ZvO9fpZT6d17r/dnSX5LfB/WTqKL888EgsJkJKYM6y8Duk8YAv+ZKuAU6Y0cJ
         PvpWxez3Ge2iRbkrsZNoFdh/u6ZWOFwaHwECkkuByJAwpSYfulPxGwAlvi9/J7acsktW
         g8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483296; x=1691075296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3zDnTtGNuT1E6yZFaZ/zNDj8BnaMTvIa2O34NjwFss=;
        b=K5lu9lxCOpl1AFAsEnm3Y3GvMqiVHcktX2qKO1EqBkhi/GEGDoBIyQkOmULXSM0cAs
         WbpeORx+htq1Epww9fd6LY0ws+OGaxfk4mJRd/n89bjtYRzjjjuF0Ed9uQnzSNvFl2Oy
         exKkhIT8jxqntb8MVnWh/LgB2wue1gHzSAXI8vRmXZLkIjFRNbQNHs/7hQk7KEk4Jeuk
         Am71iTy9R9buKR+sv+29Sqr+lfLnKCQM+W9ld37GBfOkzBFAgIyVilHZsMBHAb06mwDE
         8P72n8/W0PLJLhizQqRL2Vc1SHHdGeSZCfyArjxkGSLwCd/yvjLTdrMTv/rEGV+lwDdt
         pHGw==
X-Gm-Message-State: AC+VfDzqqMgGYnYzlTgP52WLUa+B5PkEP5YVzeR/3zrq//FccksSC3fW
        8UEIosJC4Bn01hOcBlk7qoqgCw==
X-Google-Smtp-Source: APBJJlHpZSK9BA5IIBUMNSzaFQEio+bEpAwvxesVHFjK2O/yvRvXOSNKrpZTmgIe2ijwwdIX5uqdmg==
X-Received: by 2002:a17:906:4e06:b0:992:2c5a:808e with SMTP id z6-20020a1709064e0600b009922c5a808emr10651266eju.7.1688483296390;
        Tue, 04 Jul 2023 08:08:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t21-20020a170906065500b00993928e4d1bsm758893ejb.24.2023.07.04.08.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 08:08:15 -0700 (PDT)
Message-ID: <1341ba38-35c1-1657-aed4-a3c11f584367@linaro.org>
Date:   Tue, 4 Jul 2023 17:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: fix USB OTG
To:     Hugo Villeneuve <hugo@hugovil.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230704150240.2022020-1-hugo@hugovil.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230704150240.2022020-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 17:02, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> USB OTG is currently broken on the Variscite Symphony EVK and imx8mn
> nano SOM.
> 
> Import changes from linux-5.15 branch of varigit repos to fix it.
> 
> Link: https://github.com/varigit/linux-imx.git
> Fixes: 7358e05bddca ("arm64: dts: imx8mn-var-som-symphony: Add Variscite Symphony board with VAR-SOM-MX8MN")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../dts/freescale/imx8mn-var-som-symphony.dts | 37 ++++++++++++++++++-
>  1 file changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> index 406a711486da..aef89198f24c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dts
> @@ -6,6 +6,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/usb/pd.h>
>  #include "imx8mn-var-som.dtsi"
>  
>  / {
> @@ -104,10 +105,29 @@ extcon_usbotg1: typec@3d {
>  		compatible = "nxp,ptn5150";
>  		reg = <0x3d>;
>  		interrupt-parent = <&gpio1>;
> -		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <11 IRQ_TYPE_NONE>;

That's surprising, why?


Best regards,
Krzysztof

