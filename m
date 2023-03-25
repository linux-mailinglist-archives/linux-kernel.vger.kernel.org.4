Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92966C8DE6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjCYMMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjCYMMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:12:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87511422D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:12:39 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f16so4264862ljq.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679746358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOKj8v+JeWrMhJcyWb6hLuGQlmRfk5jovd4JgoLoghk=;
        b=xnFpoHV+sryGfPdc6MZcPJzVMgscfCdoloDUpJKGACZmjzACWiBY/YeetCYrHJoDqr
         CQOgHrIkg7Dk6njY/PsAZ4qkxxAAWUZT5aSaZ92T2CfQ+NzG8q1SQVVPnIhq8N7uiHo/
         DirAk4lMSMnUYWCK6ZZ4PLNFBZCq1rZs5nXAAi2laA/Xrxf5XH8sEX9PpB3UQLYQ+jjx
         QH0HUMm1xCZwReVX9ICgjC0hQwQrNl/ZFOR5Vndo7DVIkei2xMDcelo2vyNKZNKWW6XJ
         WKSzs3DsviIREqTCGl2ietgk/oQD/cKur0ZWTebVxTCKM6Bby2YjhxhJ9Pzt8ycyGYBm
         ol0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679746358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOKj8v+JeWrMhJcyWb6hLuGQlmRfk5jovd4JgoLoghk=;
        b=A4daH8KosWECnq2Iz3/f1nmUWSJIcZrgcJCKpTjBQ5BE8isUUKxnQKhL7HPWHBWBgZ
         Wr+zMPW5+SYeHNOYnmDeSVsKS/HwDzXmfT0mccbgRd+1G1DYSMEfI7DjBp8Qnlw2nc45
         T0sXNfDVUraNOP6FNq/DgzD5JqfYE3V2OalDCedd6tQovMfAnVR56ORxSwTxpjSNqNGz
         yW34AfgUHJjNUHTnhCIvv6fzWU/UOpV69dMngbA7ikrhdsGaS3VmTSL1yVEPgxCj0Oci
         dV3uGKdIyGtcw9vkqkNEoz6ROQ6Dg4YcyUEQd90MDFtyembO3zvz2JM9V3IAe4uncdC4
         Kh7Q==
X-Gm-Message-State: AAQBX9cDXHj9E1KNuyp4aZqmpmEdwmkQJ6P8zuILOacxacEJitRj3fVa
        zexU/t/SV0XNIFn//YdaoPTV2Q==
X-Google-Smtp-Source: AKy350YJOtcGJnKqfsNpN8iVYHLZ9AlcyJIO1TgrZiWY+EQcdbbQGOW+NvSYskIOIHmQ2qK0/ScIrQ==
X-Received: by 2002:a2e:9997:0:b0:299:ac58:1c4 with SMTP id w23-20020a2e9997000000b00299ac5801c4mr1862550lji.1.1679746357933;
        Sat, 25 Mar 2023 05:12:37 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id j3-20020a19f503000000b004d6ebbad989sm3802380lfb.1.2023.03.25.05.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:12:37 -0700 (PDT)
Message-ID: <e90454f3-78d4-ba78-6f60-248b550a9fa3@linaro.org>
Date:   Sat, 25 Mar 2023 13:12:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] ARM: dts: qcom-sdx65: move status properties to end
 of nodes
Content-Language: en-US
To:     Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        agross@kernel.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230324201528.2540564-1-elder@linaro.org>
 <20230324201528.2540564-3-elder@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230324201528.2540564-3-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.03.2023 21:15, Alex Elder wrote:
> Move a few device tree "status" properties so that they are the last
> specified property, in "qcom-sdx65-mtp.dts" and "qcom-sdx65.dtsi".
> Note that properties must always be specified before sub-nodes.
> 
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-sdx65-mtp.dts | 6 +++---
>  arch/arm/boot/dts/qcom-sdx65.dtsi    | 8 +++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> index 72e25de0db5fc..57bc3b03d3aac 100644
> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
> @@ -270,8 +270,8 @@ nand@0 {
>  };
>  
>  &remoteproc_mpss {
> -	status = "okay";
>  	memory-region = <&mpss_adsp_mem>;
> +	status = "okay";
>  };
>  
>  &usb {
> @@ -283,14 +283,14 @@ &usb_dwc3 {
>  };
>  
>  &usb_hsphy {
> -	status = "okay";
>  	vdda-pll-supply = <&vreg_l4b_0p88>;
>  	vdda33-supply = <&vreg_l10b_3p08>;
>  	vdda18-supply = <&vreg_l5b_1p8>;
> +	status = "okay";
>  };
>  
>  &usb_qmpphy {
> -	status = "okay";
>  	vdda-phy-supply = <&vreg_l4b_0p88>;
>  	vdda-pll-supply = <&vreg_l1b_1p2>;
> +	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
> index 360d6dc144811..a7adf28a395a8 100644
> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
> @@ -224,16 +224,15 @@ usb_hsphy: phy@ff4000 {
>  				     "qcom,usb-snps-hs-7nm-phy";
>  			reg = <0xff4000 0x120>;
>  			#phy-cells = <0>;
> -			status = "disabled";
>  			clocks = <&rpmhcc RPMH_CXO_CLK>;
>  			clock-names = "ref";
>  			resets = <&gcc GCC_QUSB2PHY_BCR>;
> +			status = "disabled";
>  		};
>  
>  		usb_qmpphy: phy@ff6000 {
>  			compatible = "qcom,sdx65-qmp-usb3-uni-phy";
>  			reg = <0x00ff6000 0x1c8>;
> -			status = "disabled";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -247,6 +246,8 @@ usb_qmpphy: phy@ff6000 {
>  				 <&gcc GCC_USB3_PHY_BCR>;
>  			reset-names = "phy", "common";
>  
> +			status = "disabled";
> +
>  			usb_ssphy: phy@ff6200 {
>  				reg = <0x00ff6e00 0x160>,
>  				      <0x00ff7000 0x1ec>,
> @@ -393,7 +394,6 @@ mem_noc: interconnect@9680000 {
>  		usb: usb@a6f8800 {
>  			compatible = "qcom,sdx65-dwc3", "qcom,dwc3";
>  			reg = <0x0a6f8800 0x400>;
> -			status = "disabled";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -423,6 +423,8 @@ usb: usb@a6f8800 {
>  
>  			resets = <&gcc GCC_USB30_BCR>;
>  
> +			status = "disabled";
> +
>  			usb_dwc3: usb@a600000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x0a600000 0xcd00>;
