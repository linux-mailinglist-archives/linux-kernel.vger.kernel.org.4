Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB8745868
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjGCJbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:31:47 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD96E64
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:31:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so6707993e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688376699; x=1690968699;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AR104y3QqVYoIsuWZKIFJDaoFQxgMiulPpMGyuuJOjk=;
        b=bme98N5Vmp31XIElKS8TaxwTe/CKr4qVCQRxAdRX458xkkcKxJ7qXtMrLePMO7poLz
         AfKpiKq7P6F6ZbJOgtjcZrHES0I7CyiYljPbYPadbVJcSSZoZeMm87WvBjBffTW5I9a9
         vsFItCg9sL2YYHvfUbNhCofgXsghkGh/KhmtcjadnM94sz6+BLZ9dlpbKaGzAAG1sgXu
         dsrIq585+bN8C/slDlC81sC7L7Ca0NjDxeZI4c7w5LkobaNGHogEMc+nC/81GKBqThio
         qEQD/L4eK9pM6oP6H9EO+24RACTULw4xT8q2wNsXrPHNN4HLI9a+8LSP6zhkKqYAd7JQ
         ZJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376699; x=1690968699;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AR104y3QqVYoIsuWZKIFJDaoFQxgMiulPpMGyuuJOjk=;
        b=NHkO4dMtsBxj69oWhwgZuD6RKq13vXnP3v9qpPBdmxGEKvgVSvYt3K5GQupkR2PxSj
         40Vq11tRKCYtfeH74iliJ6ppKSVOFgerT6jvU137D7BGvDK5pAH3m0/LC9U+T7K0JkRj
         rtwRObwfG5fmatCXamqJ5Ti643re2VVHvRSYaxy7l703C8r+aKHmCXiaryGQDqhW9fE6
         +o8FFRziT8KDgTNnkBomheKsHYhx8F94sWPO8PcL8ACAh26IQByVzxUJHYyJjYuyB2VG
         FtYuImQzCHkNH2lJLhZmC7DrZV8h9UYEP+GSiuT6Kxk8pKeFTdyG+MnFBBlSnb+WUIIB
         Oelg==
X-Gm-Message-State: ABy/qLa9nUJFwoHuttZHdpkGoVJX1kXIbX3Emb5zb3YBDplmecokThDV
        fQnf+ZArt1idb4WWR/8rAHolTw==
X-Google-Smtp-Source: APBJJlH25sIIkUUGwnfY/ZU/BW85gfrB7xSkhcNCsyt3Zida7bUL2+SIVAiNtUZSqri7Zl2MGYiS6w==
X-Received: by 2002:a05:6512:485b:b0:4fb:8fde:f60d with SMTP id ep27-20020a056512485b00b004fb8fdef60dmr5995656lfb.22.1688376698605;
        Mon, 03 Jul 2023 02:31:38 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id c23-20020ac244b7000000b004fb761ed781sm3698625lfm.109.2023.07.03.02.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 02:31:38 -0700 (PDT)
Message-ID: <2587c8d6-52d5-bc3b-a053-9502dd4239e7@linaro.org>
Date:   Mon, 3 Jul 2023 11:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] ARM: dts: qcom: minor whitespace cleanup around '='
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230702185051.43867-1-krzysztof.kozlowski@linaro.org>
 <20230702185051.43867-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230702185051.43867-2-krzysztof.kozlowski@linaro.org>
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

On 2.07.2023 20:50, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi      | 20 +++++++++----------
>  .../qcom/qcom-msm8974pro-fairphone-fp2.dts    |  2 +-
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
> index f0ef86fadc9d..5f0ff61017d1 100644
> --- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
> @@ -416,10 +416,10 @@ restart@4ab000 {
>  
>  		pcie0: pci@40000000 {
>  			compatible = "qcom,pcie-ipq4019";
> -			reg =  <0x40000000 0xf1d
> -				0x40000f20 0xa8
> -				0x80000 0x2000
> -				0x40100000 0x1000>;
> +			reg = <0x40000000 0xf1d>,
> +			      <0x40000f20 0xa8>,
> +			      <0x80000 0x2000>,
> +			      <0x40100000 0x1000>;
>  			reg-names = "dbi", "elbi", "parf", "config";
>  			device_type = "pci";
>  			linux,pci-domain = <0>;
> @@ -543,9 +543,9 @@ wifi0: wifi@a000000 {
>  				     <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>,
>  				     <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>,
>  				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names =  "msi0",  "msi1",  "msi2",  "msi3",
> -					   "msi4",  "msi5",  "msi6",  "msi7",
> -					   "msi8",  "msi9", "msi10", "msi11",
> +			interrupt-names = "msi0",  "msi1",  "msi2",  "msi3",
> +					  "msi4",  "msi5",  "msi6",  "msi7",
> +					  "msi8",  "msi9", "msi10", "msi11",
>  					  "msi12", "msi13", "msi14", "msi15",
>  					  "legacy";
>  			status = "disabled";
> @@ -585,9 +585,9 @@ wifi1: wifi@a800000 {
>  				     <GIC_SPI 62 IRQ_TYPE_EDGE_RISING>,
>  				     <GIC_SPI 63 IRQ_TYPE_EDGE_RISING>,
>  				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names =  "msi0",  "msi1",  "msi2",  "msi3",
> -					   "msi4",  "msi5",  "msi6",  "msi7",
> -					   "msi8",  "msi9", "msi10", "msi11",
> +			interrupt-names = "msi0",  "msi1",  "msi2",  "msi3",
> +					  "msi4",  "msi5",  "msi6",  "msi7",
> +					  "msi8",  "msi9", "msi10", "msi11",
>  					  "msi12", "msi13", "msi14", "msi15",
>  					  "legacy";
>  			status = "disabled";
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
> index f531d2679f6c..42d253b75dad 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts
> @@ -414,7 +414,7 @@ cmd-data-pins {
>  
>  	wcnss_pin_a: wcnss-pin-active-state {
>  		wlan-pins {
> -			pins =  "gpio36", "gpio37", "gpio38", "gpio39", "gpio40";
> +			pins = "gpio36", "gpio37", "gpio38", "gpio39", "gpio40";
>  			function = "wlan";
>  
>  			drive-strength = <6>;
