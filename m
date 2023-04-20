Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018866E90BC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbjDTKqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjDTKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:45:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEEE3A8E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:45:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a8b62cfaceso3895381fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987501; x=1684579501;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kY8UIzE5eO4MFqBVBrnPVYrl3XX3IycUCxRpOqgSExA=;
        b=GvmHbUMKn2xG/27HTvNaP3xt321ryp0n5aMIRX6kx2YDk4qFgfAFjj3rSmn3swnJZt
         yVQxT9Fi6OIifOh5dHVLoowlG/nNfQj81CL+bpJj3rxDNGNHDoJYdguCtnxTM17Oe9Bw
         SWqQngbzYhUBiyvdYrilO9zCXu5LacO+1EXSyQhYm49BBgSM69/+tdyysz4u0vRMxFLL
         Gpzd4qJ9rT7szUHUZwWsEpdccNTOkn37lhecUFOnBajgDps6xVziRJ+9sDzVq8Xq1I2H
         sLghiF2T+aTSN7Cv5r8IBEA4KiB8C7nFaEKv8XHcwRW5razPex+mqrbFfEIMFN0T2wtJ
         556w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987501; x=1684579501;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kY8UIzE5eO4MFqBVBrnPVYrl3XX3IycUCxRpOqgSExA=;
        b=BTH2ptk/9yPs5Uaae7heQDoCS+LN/fa+K+QmmCS7MGaUda0IFvIZwU6EeMqLvbpQCG
         zXzFkeaDdsAjB+5gE5q/JJENa5kdh7s5ctp7qkg3rCOCv2vMeFbMhx0vVr246SqbsDnw
         79b2DHMt4/LzZXXhcHTe2m7iRu7ghxSH91TM8MIVGt8mDMPfJEq2T9O2VjVTjt3kRc33
         gxjZ+NRCXW6bI/M7JI2jVIRT/bkmoS4UzVwd49OOO/J4kkAcgXOWTLG3BfxpB2zjg3uX
         F/eVNMOnQjjsudQHfglYEG3QgmibYxcww4xqB/MkpefI+hZ5uLjBx2xzGsmfawYunqXZ
         M2Yg==
X-Gm-Message-State: AAQBX9dUj89/9/VY9MXQzgLKO8wHZw2lZivsVWXb0O0iw20ptcxI8ILI
        P+D/eFAxG1IDZoxJm9pKHNw0oQ==
X-Google-Smtp-Source: AKy350Z/plryjoBMhS7GTpBOJXZ2Oq1kUX0fqAivS+zzzfjN2jyVDEGZtV1n3J6BWhQy2VfW+q4zAg==
X-Received: by 2002:ac2:5286:0:b0:4ec:a19c:32b0 with SMTP id q6-20020ac25286000000b004eca19c32b0mr312072lfm.5.1681987501073;
        Thu, 20 Apr 2023 03:45:01 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id e14-20020ac2546e000000b004eaeb0a984csm177166lfn.88.2023.04.20.03.44.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:45:00 -0700 (PDT)
Message-ID: <8d1dc149-8126-744c-09f0-aae10a49b757@linaro.org>
Date:   Thu, 20 Apr 2023 12:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sdm630: add unit address to soc
 node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
 <20230420063610.11068-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420063610.11068-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 08:36, Krzysztof Kozlowski wrote:
> "soc" node is supposed to have unit address:
> 
>   Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index b31424544b19..a7d475f23bea 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -548,7 +548,7 @@ modem_smp2p_in: slave-kernel {
>  		};
>  	};
>  
> -	soc {
> +	soc@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
