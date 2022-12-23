Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F26552B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 17:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiLWQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 11:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiLWQVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 11:21:17 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6EEB7D7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:21:14 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x11so5508288ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 08:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYVyisN/1CFHnXWJIqkehSm2uoYfT/wTJfVZDQ/+DVE=;
        b=NCOEh9D/bNqWA5XTFZ60lySOYnIpQa+96P6SqznFbOeL6v6OdCLC7XCYtqlnMoIi7y
         p+mUe0YMEX/F1jPKxOheyI2cpWhhAoqTNwRYeZnGI9j6nYPRiOpQSzh7kjeH2aDkkNg/
         Womedpb8jyh5fPGBgM0iwtj2CEaZe+wSgNW/vL4wduVUJHSn+M8f9Z+ICd2WKCGG096p
         O/xeCICYDdG7fHty21hER+ZOVrIej/d3HbPxQPr0qNFO2vCtmgB+GbWI4I+6Sw8v9/uS
         trqcfaWyJZ2eeUcWPZeeY9Twit6PSGqyCaXcGKwSnG4CwVIGRH8NQOaBcfYFdruuASBF
         vNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYVyisN/1CFHnXWJIqkehSm2uoYfT/wTJfVZDQ/+DVE=;
        b=p7y50ayG0HcS+C0gsauoeRFroG5v9rnAyq2jNAmg01Kufw5fFkNMPHbly8cOHk1r2Y
         nOkzTcS9TlF+Dmf5kfgLTw9R2fLFT//igNShYHNBK6V0pUIa1dnTvxrjtV0zxMKC6lxC
         Sr+SxQGABWF5/vc0BaLd2whj9I6C2Do7TxTJESPafS73Z2v0K2EU0lNuL1LWmiOHSn05
         V2aQs8w3oT+c7sN9xjiT1i8kuo9+8PIVmwFj+3pbgUhNllHfgJXzKWFA/G0891lkKOrG
         lz6WD8Q2bzJaNV7PTMVZJ9kSLqxJmMzPoVqp0ICZnGq5gPkWgSOHHu0kjLwpm57RsXI9
         4G4Q==
X-Gm-Message-State: AFqh2kqg9OaRgIOs4G3G8uoGMluGQCVmvsjLax3uZEqyt/19bH7amFGw
        2AW1AP2HENLJKo8Acbq2eSLacw==
X-Google-Smtp-Source: AMrXdXtG77fus5WAw6rqU/rd5XFEMTUvaZTbdeki21w593nLJmL2dJyYLncYNytMYA5uw6KKXaKdrg==
X-Received: by 2002:a2e:bf25:0:b0:27f:ac86:8db7 with SMTP id c37-20020a2ebf25000000b0027fac868db7mr1814787ljr.44.1671812473343;
        Fri, 23 Dec 2022 08:21:13 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id x10-20020a2e880a000000b002771057e0e5sm497638ljh.76.2022.12.23.08.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 08:21:12 -0800 (PST)
Message-ID: <35a193b5-8c78-d24c-45bd-8092c7852260@linaro.org>
Date:   Fri, 23 Dec 2022 17:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/4] ARM: dts: qcom: sdx55: add specific compatible for
 USB HS PHY
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221223161835.112079-1-krzysztof.kozlowski@linaro.org>
 <20221223161835.112079-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221223161835.112079-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.12.2022 17:18, Krzysztof Kozlowski wrote:
> Add SoC-specific compatible to the USB HS PHY to match other devices and
> bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-sdx55.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> index f1c0dab40992..5408ff715fbf 100644
> --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> @@ -214,7 +214,8 @@ blsp1_uart3: serial@831000 {
>  		};
>  
>  		usb_hsphy: phy@ff4000 {
> -			compatible = "qcom,usb-snps-hs-7nm-phy";
> +			compatible = "qcom,sdx55-usb-hs-phy",
> +				     "qcom,usb-snps-hs-7nm-phy";
same as in 3/4
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  			reg = <0x00ff4000 0x114>;
>  			status = "disabled";
>  			#phy-cells = <0>;
