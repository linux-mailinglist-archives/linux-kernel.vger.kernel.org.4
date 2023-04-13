Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1316E1864
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjDMXiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDMXiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:38:18 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C3DF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:38:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bi41so3163968lfb.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681429096; x=1684021096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUCdlfUiRwURIFxaFhqAMXQPtuOvgQFH/dYudjTmBVU=;
        b=RsNxsLu/kE9dlW/GKLSRC3prczX5yxZzz0apbj/rkg7WCoyDXrpRg737jNL6XYkTHj
         HZLZC/wUk/RWLhnyUAdSfcDvdHHdC3/YgtlQwRYlpZ4etgmzMSwc6a/h/RacEipQHPpg
         22elQ81NoTRY4bd1Q/40EwTmGaeslar50EBzIYAYcSmc0wh52OfuJ1EkuzcNyHJJcUhu
         x21CEeiiV2j6TdlQ7NvENdWYC+coGHy1mISo4OKcu2/jAeWn+iJ/mfwRN5Z5Bawol+lJ
         nkM5L/Chb66yeidfijK79fbC8I0GzOhP6iCs22XHGco1At3nvmpyGs5OTTGjlfwOjN5o
         pOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681429096; x=1684021096;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUCdlfUiRwURIFxaFhqAMXQPtuOvgQFH/dYudjTmBVU=;
        b=aTcWfxaoXnsRGHQKd5NPBH8ru86h4DAcrODh9kYMYMm2013+c9lznImO2zhkTZR+zL
         5rMCA6zwsQA3pSwFW6uqe9P2d8XhWW11witWQATft9SUQbPVskOSuj6VIdWDpRbdgN7G
         CLoOwfQmDKO/R3JI0Vgqh2mF1G82fVBB80s411YKM9Nwvhc+sgetML/Ukb4RVlNl4jzU
         o03ALV7vb8BP/6Rbrj57EfRrW7xIJs33go1a/q7BxqL5IhOo+Ue74wOTx3rRYVniWb5W
         0Y7uNjSkAQ6nCFFlnFf3MeupirasnkGCS10QEkzE6zwdfXDwhkotSIguXdy9ZBR95WzE
         +VcQ==
X-Gm-Message-State: AAQBX9dL30tVWbn2lUHZj0jG2dMLeovYW/jp6ySek7MfVw6NzNP7zD3J
        sXNGteCcFuwObiiEOyLHa++u5Q==
X-Google-Smtp-Source: AKy350aacj6+Pq0JDFj13incCZ85D7SkVhckVbLGQoLKWlMWnLjkLMiToZf7YpnRlpr6lzZ6ioi6Hg==
X-Received: by 2002:ac2:5325:0:b0:4ed:a65e:b0c6 with SMTP id f5-20020ac25325000000b004eda65eb0c6mr729981lfh.3.1681429096039;
        Thu, 13 Apr 2023 16:38:16 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id k19-20020ac24573000000b004eb1158ff0esm503421lfm.298.2023.04.13.16.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 16:38:15 -0700 (PDT)
Message-ID: <0abd0356-f33d-c0b6-a310-58e2ff5238cf@linaro.org>
Date:   Fri, 14 Apr 2023 01:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sa8155p-adp: Make compatible the
 first property
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230413194020.1077857-1-ahalaney@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230413194020.1077857-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.04.2023 21:40, Andrew Halaney wrote:
> As stated at the below link in another review, compatible is always the
> first property.
> 
> Follow suit here to avoid copying incorrectly in the future.
> 
> Link: https://lore.kernel.org/netdev/20230331215804.783439-1-ahalaney@redhat.com/T/#ma76b4116bbb9e49ee4bcf699e40935d80965b3f3
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
>     * None
> 
>  arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> index 339fea522509..029b23198b3a 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
> @@ -352,19 +352,18 @@ &ethernet {
>  	max-speed = <1000>;
>  
>  	mdio {
> +		compatible = "snps,dwmac-mdio";
>  		#address-cells = <0x1>;
>  		#size-cells = <0x0>;
>  
> -		compatible = "snps,dwmac-mdio";
> -
>  		/* Micrel KSZ9031RNZ PHY */
>  		rgmii_phy: phy@7 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
>  			reg = <0x7>;
>  
>  			interrupt-parent = <&tlmm>;
>  			interrupts-extended = <&tlmm 124 IRQ_TYPE_EDGE_FALLING>; /* phy intr */
>  			device_type = "ethernet-phy";
> -			compatible = "ethernet-phy-ieee802.3-c22";
>  		};
>  	};
>  };
