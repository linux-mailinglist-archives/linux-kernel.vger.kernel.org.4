Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D2B70428A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbjEPA4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245528AbjEPA4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:56:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6372CBC
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:56:34 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4effb818c37so15639413e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684198592; x=1686790592;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WT9hsmSO0pZsnG/e980nY69hE65DamquvOXVGt9GVmQ=;
        b=mJp12RknH8ETXfz3QzTb5ZQftdm+rQ+etHX/vXIli/YIYEYhufTPkGaQYnkZ6XHzEG
         Lg00cQt7kIOa6Jp3ottGRpddFUf8wXb9I5hT16RGRP1+eZbHhLfggJiWNqIWnKQ5HUg6
         3u+ov1tt49aam7nWiCNvMvDv2Jz1rtXljl5JVT+0Zm7bt3nUFBVP5meZBye2u9CnoLCQ
         FDdUhQogeDGES2NWPRgmZnykY6YAJD52SCsCrQOBuhaqCC/h6TDBzW0OqQ4ZMunLiJyl
         rQoDt4nY/ZcSr0tSvXdmfJiA7OA2DV1GbIlwhvPVim9b7vpltGFKuqSuq61j8aFw7qWo
         sALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684198592; x=1686790592;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WT9hsmSO0pZsnG/e980nY69hE65DamquvOXVGt9GVmQ=;
        b=P3iruwAQRvNNNVOvdF0Gtv7JMDWFmdu/my6PjPadlZn3nHJ5APWwIiv3LThCajHBdw
         Ea3NyJGtz4pQUhsRoGItiOlekQRgdehBKREslNzIlJzv9ww7qDpVNwkwpFUzL0Ri2HP8
         kRthkrDj3vzABIrJ7fi8buLKwKvj/GYkt/cfg5X2peKMXhm/fAxopCEs/CnUoGdkxYeW
         t8sksPjbHxY9f5Nn3yrnHrCZPD8pooYsP3Ewp2pE5MOTivfwS9pv6zMZy2cr+mGKU7iO
         n99RgL7rOw4BqllmmsjnI2jUTRfBQ4wErryIUBEkVgDTPTzy0lGH8CiwYGUBO4/Zilb4
         dZjA==
X-Gm-Message-State: AC+VfDyHK83vsCE+qGStAD6/ufGyMH4LRXnb0PAqmLfK6M6qXy/EO50z
        AfkMVHwRxwaWmkrbzMS3603Ryg==
X-Google-Smtp-Source: ACHHUZ6sr3HAF6KlZeY09rD2a4zzS22+wGEhqi2VE2TcwAcBQRdvAFbM2G1nJ1oInqt7vKp0ztyWNw==
X-Received: by 2002:ac2:41c5:0:b0:4dd:9a38:fcc with SMTP id d5-20020ac241c5000000b004dd9a380fccmr6413110lfi.63.1684198592679;
        Mon, 15 May 2023 17:56:32 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id x13-20020a19f60d000000b004f11eb32f20sm2800994lfe.13.2023.05.15.17.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 17:56:32 -0700 (PDT)
Message-ID: <985aa43c-74d3-c66f-a404-c50fe840788e@linaro.org>
Date:   Tue, 16 May 2023 02:56:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] arm64: dts: qcom: ipq5332: define UART1
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230412164920.21862-1-quic_kathirav@quicinc.com>
 <20230412164920.21862-3-quic_kathirav@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230412164920.21862-3-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.04.2023 18:49, Kathiravan T wrote:
> Add the definition for the UART1 found on IPQ5332 SoC.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 12e0e179e139..c32217530b41 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -218,6 +218,16 @@
>  			status = "disabled";
>  		};
>  
> +		blsp1_uart1: serial@78b0000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078b0000 0x200>;
> +			interrupts = <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART2_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
>  		blsp1_spi0: spi@78b5000 {
>  			compatible = "qcom,spi-qup-v2.2.1";
>  			reg = <0x078b5000 0x600>;
