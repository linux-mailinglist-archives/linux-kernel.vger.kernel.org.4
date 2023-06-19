Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6EAB735CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjFSRQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSRQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:16:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1921186
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:16:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f7deee339dso4459312e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687194968; x=1689786968;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2FcjPKCgbA6FW2FWS/o1DzGvlA6sM5LXsqFHbYxl0k=;
        b=y5VRgkWag5kk6OyxAbcRd6LI7uQQX6lhtCTJu2m+I9VwYCLFeqt31j/Rtum0mEFltG
         ZBQcrWGMSjJNNG4QiSoFTq2tLXA+/mMVvh1I3Z3BQK8yJIZsvgS2xo9iGfp71yPGhbSx
         BF7qajLaJ+mw0Pze5/yWBXWSb6OjvHY6UtU9cJOqm4ZlKgt5oqB8n7kINYQ4fGCHacqb
         mWgF6IIS4Rd3qzmBkey3QV5zZnmEoh5GJaquW6u46Ph217wj2ZPVYEl45TIa03ykO2e2
         6fwMf3I1a3by+myvS/n9djAqxYcEDGDB81OarVXAp9q5F3MGo3XiLp0+eaWbmOXME0i4
         AeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194968; x=1689786968;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2FcjPKCgbA6FW2FWS/o1DzGvlA6sM5LXsqFHbYxl0k=;
        b=FxYXyGoZVfHS9+lSJK3D2vX8arjD3iXiGyw/zc5qNAMjqVys/h17x6wgVIDxy5GN9L
         0l2EcsGeiWjS9GA5NDLLxrn3+sznqOUQeuycK5eSS0Z1/UeebPdb3xULzrJHLXeI7LhC
         so31I/Qj7Y/KwUcB8HRq8iwABEjevpA7vVa4YpFWY/bcdWLoMLKtL6TjWKisUfY3qdt5
         EhSOgPC89AlX3jyunNqjdSeTiKL68GrF4tN6cCvluBxhVTJEzfMmlrmQRbKg2cXKAvev
         X/CEatxROGtLk67N8tWUPB2vuinulA47+rxXuZtf6FJwQpRKxda46Q4euh7rAQ1kqARW
         Fgqw==
X-Gm-Message-State: AC+VfDzzoLUt6lg/jIME3DiktUXREvRRDu5PAGrL5ufa1eVNwlyN2yqx
        VxzZT7WdNupwJyQItuOiKpI7Pw==
X-Google-Smtp-Source: ACHHUZ7T8wisZqG9VbGvGIRQJ/2+tzyUbNYkisc0gFT4RNkXV7f32ZQR/bewP+3cIRceTtP0/7JVTA==
X-Received: by 2002:ac2:5d28:0:b0:4f8:4255:16ca with SMTP id i8-20020ac25d28000000b004f8425516camr5346744lfb.38.1687194968698;
        Mon, 19 Jun 2023 10:16:08 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a056512050400b004f85f908f91sm17084lfb.19.2023.06.19.10.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 10:16:08 -0700 (PDT)
Message-ID: <c542a678-fbbb-35ca-d286-34fc3926cbcb@linaro.org>
Date:   Mon, 19 Jun 2023 19:16:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] ARM: dts: qcom: ipq8064: drop spi-max-frequency from
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
 <20230619170151.65505-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230619170151.65505-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.2023 19:01, Krzysztof Kozlowski wrote:
> spi-max-frequency is a property of SPI device, not SPI controller.  Drop
> it from the controller nodes.  No functional impact expected because
> child SPI device already defines spi-max-frequency.  This fixes
> dtbs_check warnings like:
> 
>   qcom-ipq8064-ap148.dtb: spi@1a280000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 1 -
>  arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi  | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> index 104eb729c2d6..1796ded31d17 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> +++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
> @@ -282,7 +282,6 @@ gsbi5: gsbi@1a200000 {
>  
>  			spi4: spi@1a280000 {
>  				status = "okay";
> -				spi-max-frequency = <50000000>;
>  
>  				pinctrl-0 = <&spi_pins>;
>  				pinctrl-names = "default";
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
> index c5abe7151f14..17f65e140e02 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
> @@ -30,7 +30,6 @@ gsbi5: gsbi@1a200000 {
>  
>  			spi4: spi@1a280000 {
>  				status = "okay";
> -				spi-max-frequency = <50000000>;
>  
>  				pinctrl-0 = <&spi_pins>;
>  				pinctrl-names = "default";
