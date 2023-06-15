Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B497312BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbjFOIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245380AbjFOIvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:51:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FBC297F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:51:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f764e92931so2774114e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 01:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686819092; x=1689411092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jVja41/1k/ct/J3rnto5ByFGnWpi0ILkB3E5zOeFBKU=;
        b=iAWk4RQm/nxvDzdZ6BD1eYHh5RQ8zwCHUi68UWG/naj28Crt/P7s58xDdOASbWXTPZ
         cVP5W/iUktOPovnVxR5ddwuvimo5hIu4AMBjNwCRCF374U1Iu+EOysMuBYLE7woajviv
         VN9j1TPCrKFrU5i9AXczIZodH0FlvNiIAPPgU4pIRFHOXSPwsa11zx7s8NHo6Sfzc1wo
         hQccz3XUBitZEbvnTVVlyOQsTlH6EFLIMRswpg8/EKm2HonYQm2F9P2fhsZR+6vI8aPF
         a1Eihgi7WFzDxZq9nzR7b4raJ3m6hFTCdDhc4xsrVhpSKp6DY3d0W68x4VsRWiab+yhp
         fy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686819092; x=1689411092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVja41/1k/ct/J3rnto5ByFGnWpi0ILkB3E5zOeFBKU=;
        b=D+40DIwkqGmQzs8GbnD7580KgZOTMvxKy2QPsOlHbCyJmcFI6iuvjl9rbqEGeOE57k
         ObmjTZecBVNdep0AzfeNbzU4YfH63qQGVQzybAnYCQsCF/Xx0KuJ9UjSdDsAx7wAodMj
         phD9ELlluWam4SiAbpXhZA1b9R6VfyKIaWaLcDi6QjX/YT4jo0u5pCVQq3pOnXlcgxEd
         IBkuZ2yTQSCLBLN8AKx4HVJ7k+YjHJsC0nM8KIbH8feIfpQGALbgG9lqlfoAy0J/JdB6
         V5IqhVkEnlMH31s9twXSNgvEXWDLenNpgwwqEk0N2lrUTZlXEC9LKz7ru4UOryBpxzWP
         6Uzg==
X-Gm-Message-State: AC+VfDzbRzER9CXaPTUaU1ULed2/AaYfD9vmTLGpT+yyUHHgukOhOHQI
        dKtKEcqoLMZso88la8qXI61tMg==
X-Google-Smtp-Source: ACHHUZ7VHe2WrV++iaUJtNovs1B4ZmW49QMq+JKj0mOzn5qWPGwqx0f19GlyA24CPao4Vcyy3UWVhA==
X-Received: by 2002:a05:6512:619:b0:4f7:6b5f:e43b with SMTP id b25-20020a056512061900b004f76b5fe43bmr1890198lfe.18.1686819092039;
        Thu, 15 Jun 2023 01:51:32 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id m14-20020a19520e000000b004eb12329053sm2480580lfb.256.2023.06.15.01.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 01:51:31 -0700 (PDT)
Message-ID: <1ab63d4b-6358-ce08-818a-b5751f88cdde@linaro.org>
Date:   Thu, 15 Jun 2023 10:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: ipq9574: Use assigned-clock-rates for
 QUP I2C core clks
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com
References: <20230615084841.12375-1-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230615084841.12375-1-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.2023 10:48, Devi Priya wrote:
> Use assigned-clock-rates property for configuring the QUP I2C core clocks
> to operate at nominal frequency.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
There's probably some logic behind this, and it almost sounds like
it'd be fitting to introduce an OPP table for I2C hosts, especially
given the voltage requirements.

Konrad
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 0baeb10bbdae..78bf7f9c455a 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -361,6 +361,8 @@
>  			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
>  				 <&gcc GCC_BLSP1_AHB_CLK>;
>  			clock-names = "core", "iface";
> +			assigned-clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
> +			assigned-clock-rates = <50000000>;
>  			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
>  			dma-names = "tx", "rx";
>  			status = "disabled";
> @@ -389,6 +391,8 @@
>  			clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>,
>  				 <&gcc GCC_BLSP1_AHB_CLK>;
>  			clock-names = "core", "iface";
> +			assigned-clocks = <&gcc GCC_BLSP1_QUP3_I2C_APPS_CLK>;
> +			assigned-clock-rates = <50000000>;
>  			dmas = <&blsp_dma 16>, <&blsp_dma 17>;
>  			dma-names = "tx", "rx";
>  			status = "disabled";
> @@ -417,6 +421,8 @@
>  			clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>,
>  				 <&gcc GCC_BLSP1_AHB_CLK>;
>  			clock-names = "core", "iface";
> +			assigned-clocks = <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
> +			assigned-clock-rates = <50000000>;
>  			dmas = <&blsp_dma 18>, <&blsp_dma 19>;
>  			dma-names = "tx", "rx";
>  			status = "disabled";
> @@ -446,6 +452,8 @@
>  			clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>,
>  				 <&gcc GCC_BLSP1_AHB_CLK>;
>  			clock-names = "core", "iface";
> +			assigned-clocks = <&gcc GCC_BLSP1_QUP5_I2C_APPS_CLK>;
> +			assigned-clock-rates = <50000000>;
>  			dmas = <&blsp_dma 20>, <&blsp_dma 21>;
>  			dma-names = "tx", "rx";
>  			status = "disabled";
