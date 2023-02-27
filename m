Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABC36A3DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjB0JMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjB0JMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:12:01 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A9A24105
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:04:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p26so3718679wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 01:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677488645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gX750YyKF9fOSoB2utHNWaKu3poYO79iKZprJUf0Da4=;
        b=GwkPqx0fsmfK/6qn8shnEXviTbjGb2lJZK9ZhfRmikBZOcoKGJTbB7/RtzxnyrW2iR
         CsG7PgZs41n9LquLg34ujnox0pX1C0S7HQ2r6YHA9KBscEhNB5Hv1KT8+o6S8LEtdwBn
         rwaydEgJxvHiF5y6kKK6AaC4Ub74RYMs07wBxNrXOOxqvIiC6YHswguTDkc1u0RzJCW5
         QOx1A8iSx8z247PjZfFhCLtL0l54+Hiuq/cEBz/WQKUwhvBPTPqrgPYo4OQWB4swmpOV
         8a16r8SZh0mAesf78kRlKK2sEr9C1beMB05LrvdpaNl1GnXwBJELIpq+DMBJgKUkHPQS
         7u/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677488645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gX750YyKF9fOSoB2utHNWaKu3poYO79iKZprJUf0Da4=;
        b=efWuZAGwVc9ACDRh1HtLG88qCVNG/Yi6uyd09PqO4d1tHQ6eD+3ISziT6tfY7KNaqu
         NYO1xOCA8d/IwJ8oOA1Rx5KWnon2nPne3BUfM9WcnjCrZtqEuywvbil/ZD0N9J2eAp4b
         lWZVwBOW2+PsOk3iID7lDYi5M36jHpGzNiwapm/zzV3lb6yL2kXwB8mAQNBW9UEOoASp
         mwaxViVeym44O60tHiMnHIGXGze9LKAtqNkfxJb0HRN+p6TAGH7Y0DBexLD/SZU2KsXH
         XMLCGeB4VsN1/ZfSqGSbbkz0bXGjLC64dEAIh7ogIZreWlFAhOHwAdBxBiBrirJPHeAZ
         AA9A==
X-Gm-Message-State: AO0yUKWuVdZLjw+IgZxImjXNoaK/2BrGbZ/TE+KabvLtUUxsN/c+lpIx
        C8Omwqf6VDrFbRcYcVqvxKpGzONLwtpSG/5q
X-Google-Smtp-Source: AK7set+JmXmikFRwtfkzxp1q9NsdTjkTjiHg3qFAunt0fzM1H5J4kGtRQGCH7xOfw6owiru3euspeg==
X-Received: by 2002:a19:ae01:0:b0:4b5:9b8f:cc82 with SMTP id f1-20020a19ae01000000b004b59b8fcc82mr7474938lfc.0.1677487595694;
        Mon, 27 Feb 2023 00:46:35 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id b7-20020ac24107000000b004db297957e8sm833847lfi.305.2023.02.27.00.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:46:35 -0800 (PST)
Message-ID: <2852ca77-81fd-0e39-5030-d9d0f483ea0a@linaro.org>
Date:   Mon, 27 Feb 2023 09:46:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 08/13] ARM: dts: qcom: sdx55: List the property values
 vertically
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
 <20230224105906.16540-9-manivannan.sadhasivam@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230224105906.16540-9-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.02.2023 11:59, Manivannan Sadhasivam wrote:
> To align with the rest of the devicetree files and the relative properties,
> let's list the values of properties such as {reg/clock/interrupt}-names
> vertically.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx55.dtsi | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> index b411c4ae34c3..61fdd601fc26 100644
> --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> @@ -393,7 +393,11 @@ pcie_ep: pcie-ep@1c00000 {
>  			      <0x40001000 0x1000>,
>  			      <0x40200000 0x100000>,
>  			      <0x01c03000 0x3000>;
> -			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "addr_space",
>  				    "mmio";
>  
>  			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
> @@ -405,12 +409,18 @@ pcie_ep: pcie-ep@1c00000 {
>  				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
>  				 <&gcc GCC_PCIE_SLEEP_CLK>,
>  				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
> -			clock-names = "aux", "cfg", "bus_master", "bus_slave",
> -				      "slave_q2a", "sleep", "ref";
> +			clock-names = "aux",
> +				      "cfg",
> +				      "bus_master",
> +				      "bus_slave",
> +				      "slave_q2a",
> +				      "sleep",
> +				      "ref";
>  
>  			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "global", "doorbell";
> +			interrupt-names = "global",
> +					  "doorbell";
>  			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
>  			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
>  			resets = <&gcc GCC_PCIE_BCR>;
> @@ -434,7 +444,10 @@ pcie_phy: phy@1c07000 {
>  				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
>  				 <&gcc GCC_PCIE_0_CLKREF_CLK>,
>  				 <&gcc GCC_PCIE_RCHNG_PHY_CLK>;
> -			clock-names = "aux", "cfg_ahb", "ref", "refgen";
> +			clock-names = "aux",
> +				      "cfg_ahb",
> +				      "ref",
> +				      "refgen";
>  
>  			resets = <&gcc GCC_PCIE_PHY_BCR>;
>  			reset-names = "phy";
