Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409F46DE5EE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjDKUpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDKUpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:45:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EF744A3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:44:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t14so11890567lft.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681245878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/r8RSaZVplOUSRPmmqycB8MoeVAm3DX+TnPmm8LhSK0=;
        b=O7KHuL9hb2HYAuY35y43dMkO4BSQVs3rMHCeepWDbdU3fsfBUUHO9JZmRmZJJQy65T
         CTDWkaYPNe1AQUqvGjpA3OL8AVTMmAtR2CtjLbtW7tL8BKA2bRBJ6qOKjEGf+n66XLuY
         b6R5MVqPgTBGYCkvRD0mMm5oiJZdVjZl0NhxDUFaovFwt3P/Havx1JGg1Uiu7Qa11msZ
         Q4K5hGaWo157+H3SCxaOA2JGmKw3mAYuSjGe86dGsvU8suYPDhCOp7u5xqFHajdxFm0p
         Dzhm7EIh1Du4NCiMbiZ5P4EFcMEwxAa9uGHiZ6obXABHSIWMgYwNT8N728daT6b53e9r
         zmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681245878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/r8RSaZVplOUSRPmmqycB8MoeVAm3DX+TnPmm8LhSK0=;
        b=2UGuvjOpCoYpg0+JPbqnheg19vH+ztrIXpijywHI8Yi78ePyrf+qx74twJ0gpGxihL
         /A3Ux2VKqoYn7weQZQiiIX7NMXafHlniFirpqwRZ+81PXtl50/vipdSt7zZcUxIsMIHS
         286PiGbnUbHDD8QiauaXFeHLMOsSA8prjSw8QwRCpE0fuYRfNc3D9R1IpLiCsKzxsZuI
         hk8LntKR/NtMV8fj6p+JpVxqOCRsW4W8h54bMxFKY2lO9klSqyfwm29qfLnQ9RNcaWfx
         aO3roTqfUDPpP6+JPduzVJfXXxQ+ls2OxSccuvMxsMHdQxZmHBfiaZeNdkdM/7aMm52a
         39gg==
X-Gm-Message-State: AAQBX9c7u4bN/+R+vTxOsoi02qf6XhI1pQqAIq20gzfzk6SvGvpihqbS
        DzL0UjvZJOea7gGjhrrdLEK9ug==
X-Google-Smtp-Source: AKy350aFpGN8kKde2RFh/bYhkZ0EbYszZ+4Skv/fWQ1DD41eEus9V9bAGiPkZ9Vryaz7R5r5wj/wig==
X-Received: by 2002:a05:6512:65:b0:4eb:df5:7418 with SMTP id i5-20020a056512006500b004eb0df57418mr4552873lfo.36.1681245877934;
        Tue, 11 Apr 2023 13:44:37 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id p12-20020a19f00c000000b004eaf8613bc3sm2672435lfc.284.2023.04.11.13.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 13:44:37 -0700 (PDT)
Message-ID: <88d41729-86be-95cb-2fda-1b809f07ed6b@linaro.org>
Date:   Tue, 11 Apr 2023 22:44:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] arm64: dts: qcom: sa8155p-adp: Make compatible the first
 property
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230411203144.471192-1-ahalaney@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411203144.471192-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.04.2023 22:31, Andrew Halaney wrote:
> As stated at the below link in another review, compatible is always the
> first property.
> 
> Follow suit here to avoid copying incorrectly in the future.
> 
> Link: https://lore.kernel.org/netdev/20230331215804.783439-1-ahalaney@redhat.com/T/#ma76b4116bbb9e49ee4bcf699e40935d80965b3f3
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
Thanks for this patch!
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 459384ec8f23..8c773b856eb1 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -351,19 +351,18 @@ &ethernet {
>  	max-speed = <1000>;
>  
>  	mdio {
> +		compatible = "snps,dwmac-mdio";
>  		#address-cells = <0x1>;
>  		#size-cells = <0x0>;
Since you're already touching this file, can you make the
-cells values decimal..
>  
> -		compatible = "snps,dwmac-mdio";
> -
>  		/* Micrel KSZ9031RNZ PHY */
>  		rgmii_phy: phy@7 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
>  			reg = <0x7>;
>  
>  			interrupt-parent = <&tlmm>;
..remove the useless interrupt-parent..

>  			interrupts-extended = <&tlmm 124 IRQ_TYPE_EDGE_FALLING>; /* phy intr */
...and the similarly not very useful comment here?

Konrad

>  			device_type = "ethernet-phy";
> -			compatible = "ethernet-phy-ieee802.3-c22";
>  		};
>  	};
>  };
