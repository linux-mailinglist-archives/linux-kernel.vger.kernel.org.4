Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C112F72BD18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjFLJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjFLJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:51:11 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72530276F1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:35:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so4912370e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686562555; x=1689154555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EVRsoBw2mYIKseG/0Qd8GC6oHBJlAAcz7DAhIfqh+7s=;
        b=Rwr9kl19lrfXZO0AeqyotRMwrSFgHnX2AoP9H6w4oq+N6tErLHtVV+lzHKFYdeULvb
         0pmtApmxu/AUW/D4E+4XdehvlfPdV8hcOHKPHv6o37u4RTUzH7lrEQO6A6RrJA4LYSTe
         cuerQiT4YbiV5uOghU2r35CX6IQAn0XlgVO84KYd+2mU1hLnzNIEtKPudu4D2NKk9DOC
         tXKGnDD35U+C60x+tSU/qUHuRH9UI3YphmR8XP8r0xRKbFH1o2Fo+8syvQtxj8Tqp66k
         vW8fcMPyDnIddHxQ8A7AVPkk+qmP55MTnznHaLlLWG7lpCu53xpBBjSugjQFeU9dB4jH
         7Apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562555; x=1689154555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVRsoBw2mYIKseG/0Qd8GC6oHBJlAAcz7DAhIfqh+7s=;
        b=eh8EFO3eelQyKL/hSNqYAotw17EzRpNhHGSHUtflN4wNWKINTU3wkKgK7lJ7m4EET1
         LWBh2hnpuzmshWcp0YtJ+YBakaKT9XlMeOBO2L2gcGT2Q3e5/QgOegYnXBgUwWZcgPii
         WZ3EymuwT3DFgix/f0h7UUDfBdHT/inme7c6Xo0DFCyrx4dxOUVCjA06Fj2HJRRDXDRX
         tlz97jdJPeCfzFFxJF97gjgyhPO6QKwwZIwrAUPFvpUrminKbuLbBPnWP0GYg+3z5CM1
         UDT7/N9iKjiUamwBKLSDjCYqFmAGLkFj8U7jUeWfsEwAm5yC/EkIK6XXUK7AAJ12UZdN
         iNPg==
X-Gm-Message-State: AC+VfDz3wAOOTS4GkMCq1UbQwF8aiZuxNUyVZjYxE/O9MsEa3BhOaV7S
        8J4krG7bJ39d5g/SG4Zsu36FbA==
X-Google-Smtp-Source: ACHHUZ4XIHc31aI7Yz7vxkZ7gA16gu5nwoiLxWZswPLz9iLHvgp3AlnZy1KH+hfVh/JFNYj+qnFqdw==
X-Received: by 2002:a05:6512:1ce:b0:4f6:1154:deba with SMTP id f14-20020a05651201ce00b004f61154debamr4261756lfp.65.1686562554980;
        Mon, 12 Jun 2023 02:35:54 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id i9-20020ac25229000000b004f2b6a203aasm1386474lfl.224.2023.06.12.02.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:35:54 -0700 (PDT)
Message-ID: <9562db04-ef2e-b32e-9fd6-1396798f28e5@linaro.org>
Date:   Mon, 12 Jun 2023 11:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 22/26] arm64: dts: qcom: sa8775p-ride: add the SGMII PHY
 node
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
 <20230612092355.87937-23-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230612092355.87937-23-brgl@bgdev.pl>
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



On 12.06.2023 11:23, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the internal SGMII/SerDes PHY node for sa8775p platforms.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index b130136acffe..0e59000a0c82 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -1837,6 +1837,15 @@ adreno_smmu: iommu@3da0000 {
>  				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		serdes_phy: phy@8901000 {
> +			compatible = "qcom,sa8775p-dwmac-sgmii-phy";
> +			reg = <0 0x08901000 0 0xe10>;
The usage of 0 is inconsistent with 0x0 everywhere else

Konrad
> +			clocks = <&gcc GCC_SGMI_CLKREF_EN>;
> +			clock-names = "sgmi_ref";
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
>  			reg = <0x0 0x0b220000 0x0 0x30000>,
