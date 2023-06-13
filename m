Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837CB72EB82
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFMTE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbjFMTEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:04:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D871721
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:04:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f6170b1486so7183376e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686683053; x=1689275053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woeYYFEiU1y3NclAr5wdCFdPFOi62sLbxPfwISR5Xn8=;
        b=q2bbZiF2Xy2JxkCX8e3y4fFp2cP9iFKv42xyhROdmk2mpDr7LXZfz3AWcU7AxuHxKc
         IBySptwOhOAewBK0W7T3JZWk1l4Kj0ib1b7kfAkZPI6Mp/FlSBZj1SdO4XPDtu53cxh+
         wzJOoSDF5OtB4VFwZt0q+PodkxVuxE0QGoEdHp9BvSX7JmMHiBIIFACiOq9QEDZ5HZeI
         xXZqzZxo83ru7G7QauolFOyXqjc0HfXZRUJgtbKj7CmSdqc+ucEjOfsDf8AdyWXweCr2
         C+2eCONnBG/Stb3+zfI0K/svhD1H7VcMrPRWr7lntdBMeOj9IO7/m0BH9YMeFk5YzD5H
         pxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683053; x=1689275053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woeYYFEiU1y3NclAr5wdCFdPFOi62sLbxPfwISR5Xn8=;
        b=jSF6Qk0nzy23wxjrh3vPuAxkNJcMRNfxoszh0/06T0LcBv0K+A9hvRaEqdBmbsxn10
         uR4Wsl1qab10QCSigCJ1wNheV+oJczZhBxcFj+LhLSogiJnu5lw4PSqfpZ1n9DfwZKgC
         HMfwA3P+dNZbLg1IXLj8NJFZATxkynpxqMqqLe5pwqXXeu1a4ubUYIm7dvDHUD3gmBoi
         vKgXpUnD3PAO1INC8UY2e1RaS0YqtcJtPe0Ye6o3zvmsh8OeZazbs0q0A1XANr6zEbu9
         AbSOTvHdozn+ZUsVpbFN9qecb8ezsCdueE07YLX3tShQtnDZN310uEz422O/K2491qAa
         FS4w==
X-Gm-Message-State: AC+VfDw3pH+lmniqAO/LKgSnHKiWVAS7AMZKznng5k+bNyYHQLdXwhPl
        qoYMcjJ95Fnwh96KZ3FVaIyj/Q==
X-Google-Smtp-Source: ACHHUZ64q3nAkmQiyy1A3DAZ+hVneYytXEVoRe5yh0a8KBFRcAQJiZjhKQQHeFFMapSCKaxVrNlEzA==
X-Received: by 2002:a19:5e11:0:b0:4ac:b7bf:697a with SMTP id s17-20020a195e11000000b004acb7bf697amr4518741lfb.4.1686683053205;
        Tue, 13 Jun 2023 12:04:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u7-20020ac243c7000000b004f42718cbb1sm1856560lfl.292.2023.06.13.12.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 12:04:12 -0700 (PDT)
Message-ID: <7b511c41-4bf5-f7ff-8ae9-5f1bffac50d9@linaro.org>
Date:   Tue, 13 Jun 2023 21:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 25/26] arm64: dts: qcom: sa8775p-ride: add pin functions
 for ethernet0
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-26-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230612092355.87937-26-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.06.2023 11:23, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the MDC and MDIO pin functions for ethernet0 on sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 7754788ea775..dbd9553aa5c7 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -370,6 +370,22 @@ &spi16 {
>  };
>  
>  &tlmm {
> +	ethernet0_default: ethernet0-default-state {
> +		ethernet0_mdc: ethernet0-mdc-pins {
> +			pins = "gpio8";
> +			function = "emac0_mdc";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		ethernet0_mdio: ethernet0-mdio-pins {
> +			pins = "gpio9";
> +			function = "emac0_mdio";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	qup_uart10_default: qup-uart10-state {
>  		pins = "gpio46", "gpio47";
>  		function = "qup1_se3";
