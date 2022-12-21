Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11898652EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbiLUJvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiLUJuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:50:06 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDEF22B37
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:48:10 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 1so22682131lfz.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okq6sy0T7fU71tA3WrKAH0MDghE0qvD1udHSmisw4vU=;
        b=rSFedQ6ephSqoSOM1xNTjzp4TxR/NrCK8xF040bSJAnk8UZxh6y12xYDiKsgIO0d+I
         333TAG1ukoMrXJolIfe7YWtp6xonwwsmDdvorEsTUXNX6LBAqwQ2x4r97uTOJEbEEplN
         p/XOAaeKuItfaHA9VRPsRt0YRx/yUG/m78JcBOgJ9bpYIS2sLE95bh+q+nlRllXjPHTs
         ym8Hee5bRIISzpSysLbBiYMOMxAMjj1ZG/3YmnJcojHbV8GlY7TNKFqJPx8I0q6y73im
         ORuDVOVTVAJ4FN/HzIn4LkJkL45qBa0Oghji2Ja73jaUnV1cpEM55gUxn9/L/BjSc5lU
         oYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okq6sy0T7fU71tA3WrKAH0MDghE0qvD1udHSmisw4vU=;
        b=tlcGmay+BwMJYUx5I7Kkv1IDt4CYUFh0ff0iBVoBHTjLaG+SBaVN4VIlx2vR62Ar8Y
         7D5OnzH9iBHBakcrqagCShzuPAABCYohJGfppnNLC5Jl04XOysDOaASshHUV0u8yz2xx
         YGIgFQwQgp938/131zxZ3HBsDWkgJsjcglwuXjQFP5YTOJas/7K6bn3BJAeWVEd78O+y
         2X1tDR8TYcU65Ydx0dg/8Ei+2fgbTC+58ot6aStzZUGjKe0SUoSAsSfBeexF9l9FonEG
         mOYqaKYbDDs4pwKFUDy/K/QDGARF5TFuamTMIwqhdm5sw3fZdJ21J7IlrQwhk2CDkYKL
         m7LA==
X-Gm-Message-State: AFqh2kpFNogQuglGsr63RIIZ/VFZt7+i1kxTceHU9yeK+qMxZe0jyimI
        ZtMFX0sL9eHw7EGDieX5i04fgw==
X-Google-Smtp-Source: AMrXdXsc8QdIyYsJU8wWEIAz1v8DKIhBnjIQ1raMREsIM1Hxn1edvHmFheZfIYI+kgkglBCsKcsOvQ==
X-Received: by 2002:a05:6512:4005:b0:4b5:9183:5ad0 with SMTP id br5-20020a056512400500b004b591835ad0mr1845395lfb.63.1671616088853;
        Wed, 21 Dec 2022 01:48:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25f07000000b004b49025f96dsm1782191lfq.187.2022.12.21.01.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 01:48:08 -0800 (PST)
Message-ID: <cbbf719b-a027-f91b-bd2c-6e6b43447b97@linaro.org>
Date:   Wed, 21 Dec 2022 10:48:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/3] riscv: dts: starfive: Add TRNG node for VisionFive 2
Content-Language: en-US
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221221090819.1259443-1-jiajie.ho@starfivetech.com>
 <20221221090819.1259443-4-jiajie.ho@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221221090819.1259443-4-jiajie.ho@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 10:08, Jia Jie Ho wrote:
> Adding StarFive TRNG controller node to VisionFive 2 SoC.
> 
> Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> index 4ac159d79d66..dd3ad19772a5 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> @@ -455,5 +455,16 @@ uart5: serial@12020000 {
>  			reg-shift = <2>;
>  			status = "disabled";
>  		};
> +
> +		rng: rng@1600c000 {
> +			compatible = "starfive,jh7110-trng";
> +			reg = <0x0 0x1600C000 0x0 0x4000>;
> +			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
> +				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
> +			clock-names = "hclk", "ahb";
> +			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
> +			interrupts = <30>;
> +			status = "okay";

Drop. It's by default.

Best regards,
Krzysztof

