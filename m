Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADFB735CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 19:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjFSRP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 13:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjFSRPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 13:15:25 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995CE186
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:15:23 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b46f5d236dso24992221fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687194922; x=1689786922;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4piptKyUoRwukoX6DDI9D7lqdP3wM0DejgG7WSpaPbo=;
        b=fWcW04ISHTqeHdt/epnCqiDi8Oo0VCUvTA4fxANKG78bDajAK4n31R6SoWiTj80rXI
         SyEWsndyPiI4uXzVjXwXjxJp7+YYltnYscxckGjTYaDJXmUqgnt4qBcr7NQDjsK0OV51
         f6H8bardb0VzCoUJmpmAgn6LOybyn72HyLSIneb4TLz2EmQJT4tufJTLoxClJ0+dIjJ8
         Afjh7yntBNiU2ErjKN+0cZYW6JKopMPmfh0naoUSTWH4hFG9bgDsxIyliPWtqP9jFwtI
         kwv+eeXVpoN+8R+2B97bdY/+5g99r16aQE9Tmi44Wu3VhqP9TNGv+HJZP5mZsG+kAKzh
         nocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194922; x=1689786922;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4piptKyUoRwukoX6DDI9D7lqdP3wM0DejgG7WSpaPbo=;
        b=JVIrqf6YEDCxk49g6nuHnxvW7oRoXsw+yLMpXKBlYaY9njDGWVRgZbc0gBP5mjgi2g
         jacrBTcU5dh78rv1sOr/Gsq0vBbTl+T2zCOMzexZd2BhDmiqBSN2FcZsd3S0HNS6z3B8
         eJNhRVULOsfBpOcjS0I1qT8eTPTmb7YABedt4lCBDZno9iNDSFmMSLaWchB4A+0hpxiL
         WURgK2QMP9iwdOGmF9w+upmaSOr9Sw9q3K4JVrEXbDfmJ0H/NTTdVsL4n8Wwe8sigbOs
         1ig/KeQxTP7YiPLr4vFHTFxbf+v+tHbiCoz4Kg8qwiEKPP168fp3OxSpQpIu2OkfVSXC
         TNjg==
X-Gm-Message-State: AC+VfDyk06ewLCpz+IkR3IoLwCFi26ykQ2GevDt5tDDTJUxX5rqSfn4c
        kyTWcHX78LC0pkh4RjHihoesjg==
X-Google-Smtp-Source: ACHHUZ6rtfvIDQDqUT5GcIrYtOOT3h+2qyj++fScdODItL+lHHqKK56PwK7cwKm3AGKB2KFQsTZLDg==
X-Received: by 2002:a2e:80c4:0:b0:2b1:d91b:51c3 with SMTP id r4-20020a2e80c4000000b002b1d91b51c3mr5660407ljg.30.1687194921793;
        Mon, 19 Jun 2023 10:15:21 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id l19-20020a2e3e13000000b002b1edfe817fsm5242032lja.88.2023.06.19.10.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 10:15:21 -0700 (PDT)
Message-ID: <38d3d28f-fa64-8c7b-cfdc-36e3ab6dc475@linaro.org>
Date:   Mon, 19 Jun 2023 19:15:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] ARM: dts: qcom: ipq4019: use generic node names for
 USB
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230619170151.65505-1-krzysztof.kozlowski@linaro.org>
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

On 19.06.2023 19:01, Krzysztof Kozlowski wrote:
> Device node names should be generic which is also expected by USB
> bindings:
> 
>   qcom-ipq4018-jalapeno.dtb: dwc3@6000000: $nodename:0: 'dwc3@6000000' does not match '^usb(@.*)?'
> 
> Override also the DWC3 node in qcom-ipq4018-ap120c-ac.dtsi by
> label/phandle, not via node path, because it is less error-prone and
> makes the overriding node-name independent.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi |  7 ++++---
>  arch/arm/boot/dts/qcom-ipq4019.dtsi           | 14 +++++++-------
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> index d90b4f4c63af..da67d55fa557 100644
> --- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
> @@ -262,10 +262,11 @@ &usb3_hs_phy {
>  &usb3 {
>  	status = "okay";
>  
> -	dwc3@8a00000 {
> -		phys = <&usb3_hs_phy>;
> -		phy-names = "usb2-phy";
>  	};
> +
> +&usb3_dwc {
> +	phys = <&usb3_hs_phy>;
> +	phy-names = "usb2-phy";
>  };
>  
>  &usb2_hs_phy {
> diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> index f0ef86fadc9d..13388e5c1b4b 100644
> --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> @@ -621,7 +621,7 @@ ethphy4: ethernet-phy@4 {
>  			};
>  		};
>  
> -		usb3_ss_phy: ssphy@9a000 {
> +		usb3_ss_phy: usb-phy@9a000 {
>  			compatible = "qcom,usb-ss-ipq4019-phy";
>  			#phy-cells = <0>;
>  			reg = <0x9a000 0x800>;
> @@ -631,7 +631,7 @@ usb3_ss_phy: ssphy@9a000 {
>  			status = "disabled";
>  		};
>  
> -		usb3_hs_phy: hsphy@a6000 {
> +		usb3_hs_phy: usb-phy@a6000 {
>  			compatible = "qcom,usb-hs-ipq4019-phy";
>  			#phy-cells = <0>;
>  			reg = <0xa6000 0x40>;
> @@ -641,7 +641,7 @@ usb3_hs_phy: hsphy@a6000 {
>  			status = "disabled";
>  		};
>  
> -		usb3: usb3@8af8800 {
> +		usb3: usb@8af8800 {
>  			compatible = "qcom,ipq4019-dwc3", "qcom,dwc3";
>  			reg = <0x8af8800 0x100>;
>  			#address-cells = <1>;
> @@ -653,7 +653,7 @@ usb3: usb3@8af8800 {
>  			ranges;
>  			status = "disabled";
>  
> -			dwc3@8a00000 {
> +			usb3_dwc: usb@8a00000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x8a00000 0xf8000>;
>  				interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
> @@ -663,7 +663,7 @@ dwc3@8a00000 {
>  			};
>  		};
>  
> -		usb2_hs_phy: hsphy@a8000 {
> +		usb2_hs_phy: usb-phy@a8000 {
>  			compatible = "qcom,usb-hs-ipq4019-phy";
>  			#phy-cells = <0>;
>  			reg = <0xa8000 0x40>;
> @@ -673,7 +673,7 @@ usb2_hs_phy: hsphy@a8000 {
>  			status = "disabled";
>  		};
>  
> -		usb2: usb2@60f8800 {
> +		usb2: usb@60f8800 {
>  			compatible = "qcom,ipq4019-dwc3", "qcom,dwc3";
>  			reg = <0x60f8800 0x100>;
>  			#address-cells = <1>;
> @@ -685,7 +685,7 @@ usb2: usb2@60f8800 {
>  			ranges;
>  			status = "disabled";
>  
> -			dwc3@6000000 {
> +			usb@6000000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x6000000 0xf8000>;
>  				interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
