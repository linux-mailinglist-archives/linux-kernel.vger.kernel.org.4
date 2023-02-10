Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B936921E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjBJPTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjBJPTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:19:39 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26F775361
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:19:30 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id m2so16719832ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CeTwCO+icltfJqt/V1wp7H1s0GdXfbjSqmnrKM/ncho=;
        b=ljQLZBHg6ysVbJKex7rMTlVKX3wqnDtggqUJ45ZD3a8nemRTgn6uYbb7GvXU4dW0Uj
         MxOpxTqHxBm4YpYptO5mcKdN1wHVrIUWqKryywiDO+JAncShNJbgokI/csyi25EakSyb
         ErNgRBJlYn2yoC0LaXHt41wX8hLlGvSXkJgaurfn7ChnwNJ0QUGEvblQkaF55reRRqD/
         zFv8VVpHgHxvTRsOjjAilIS726fSPi047OS1K9EtiQ/S7dtTBmuqQPzjRNWOE1j7073V
         j3PRgEd4xMcYMFJ7d6g5zwHolNV58GnFedMbWT62YzWUic4IBYta7h4JrrSTem/df5Lh
         643w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeTwCO+icltfJqt/V1wp7H1s0GdXfbjSqmnrKM/ncho=;
        b=z8nOmQ0QE0iRBN/hIDYInNK2BNW5Fbe6bllMA++SyhrX4X+/z83g2n99rb8oFci1pW
         FvwOKFlcY0WZ8fgKpmq7oZDQx76SraCDt1p8yT9gAbYVpfeyYs8VsBVlH5hUGP+XwXAf
         JcJKiNp/JNNTrSW7zalzJpChCpZJ6ao/cV84phuBQTpCXZuAJA4m3o1qpVzBJuOKCVX/
         P6thyEXcxbwUf6x5BDwunz6BzLdsz5jYwYIJwhMjBE8uH4tLxLp+N8wpQpxjrV6KL3zV
         PwUauo7wN79zGbo/dQPzQAWmU6SpJfN6Wo0IYXJzsPPYY84syy9hQ2hcHwsxBvnDWQia
         7zfQ==
X-Gm-Message-State: AO0yUKU2pbHDj6lRTPdQG6+beMlT98FcUkFCfkJY2orQyiJQpJevlF/A
        cbmaFXhdjoAqsBNTpKqAtGo/eQ==
X-Google-Smtp-Source: AK7set+Pkg87K1qOT9b4NSjjYPaBtaGlplEjGfUBr1Ft/IhOCdSDgKMonFy+cXyrtkYq3NLhzWwSlw==
X-Received: by 2002:a17:906:b30a:b0:87d:9447:f7fb with SMTP id n10-20020a170906b30a00b0087d9447f7fbmr17147788ejz.38.1676042369466;
        Fri, 10 Feb 2023 07:19:29 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id lu19-20020a170906fad300b007a9c3831409sm2483441ejb.137.2023.02.10.07.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 07:19:29 -0800 (PST)
Message-ID: <a0dce9eb-8153-3505-e0f0-40921e69b97b@linaro.org>
Date:   Fri, 10 Feb 2023 16:19:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 06/11] arm64: dts: qcom: sm8450: add port subnodes in
 dwc3 node
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v2-6-71fea256474f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-6-71fea256474f@linaro.org>
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



On 10.02.2023 16:02, Neil Armstrong wrote:
> Add ports subnodes in dwc3 node to avoid repeating the
> same description in each board DT.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 1a744a33bcf4..ccda73426ee2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -4155,6 +4155,25 @@ usb_1_dwc3: usb@a600000 {
>  				snps,dis_enblslpm_quirk;
>  				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
>  				phy-names = "usb2-phy", "usb3-phy";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						usb_1_dwc3_hs: endpoint {
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						usb_1_dwc3_ss: endpoint {
> +						};
> +					};
> +				};
>  			};
>  		};
>  
> 
