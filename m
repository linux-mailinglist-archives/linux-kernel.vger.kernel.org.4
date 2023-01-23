Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5082D678155
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAWQ0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjAWQ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:26:28 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB024124
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:26:27 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw16so31882144ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lab8GS0BsXttrEIIOF5NuoFe5yEpMq3XNGpFEieVFus=;
        b=oF4rD6jd7XwszpEixf28vjQe5BHyTMqbDMbb0myXN7sNdrC+JWF7pbvptfZlr7EEZu
         HCOfmKYSseWmcGQZrMEirBmnWHakJk4wj4YR3gUJPzu6+oTCwtccIThIC1wRNBsyWMXu
         UA1QfgF5DJysHFZOaK/HO8gZU+urYcCCf9sVVohIfO94u8tzqW8/b5tggtzRQWLaG37+
         7XiMVCZk+HTLtDhrNOTeALvlSHaIBTmfV9EKcQWB56KGNvKJU6JAWK9srHD5ActxyIWq
         Wrh53EiA1YID0pZF750/wIkqkgG7oi6bMdLd8VzYTe5cs8JuMpY5jjkdg3M6pTcU/vrY
         3j0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lab8GS0BsXttrEIIOF5NuoFe5yEpMq3XNGpFEieVFus=;
        b=LrN1HW1wcu/uFw2451WI6CaSTUNneRtiayNdg2Fvv9ln+IJPt/Lmxomyeft6NJTYb+
         4nE7YIAhdPf4y03xuK2aDueabO865L9btPazKjjq+8zAS3lH3289mbF3t5zb+V7JIzX8
         m50goiKWYJ2m5WqpaK368Smw9+rMfOmsA6D2j9jnwTA51UwXXU5EQHlXQ9akn3DnzGe/
         lONh7TerM7Vzp005Zp0v31gUIyEUO4BuK9jE3AVLIdCObXQ4WJ2SvRDfyG+MLbITk0GC
         QFlOglieot5Q3Hdv83VMTLKTUd0OU9hWdqVlxSPmbUCmMDzKFNdAY/I2a6H2Ba4UwcGf
         hYVQ==
X-Gm-Message-State: AFqh2kq1vDWzd3Md8dgW7zCQBvmY6leTUrx6DyUP4mFJ+n+eP30PSXyL
        Fa7sm3MTLltnPbjhPopLKP5475x0atMEFkqR
X-Google-Smtp-Source: AMrXdXsLNSc/qQBnWGQwUSUQ/FzBERvIWV6+ygvsH14hClyHcGWFZRhHiJquSdlWNG5cIgsdJW1j7g==
X-Received: by 2002:a17:906:78b:b0:7c1:9b07:32cd with SMTP id l11-20020a170906078b00b007c19b0732cdmr26403478ejc.39.1674491186264;
        Mon, 23 Jan 2023 08:26:26 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090631c600b008779b5c7db6sm5411656ejf.107.2023.01.23.08.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:26:25 -0800 (PST)
Message-ID: <2f0881e3-9f6c-1c77-c6ca-3e291b37bd12@linaro.org>
Date:   Mon, 23 Jan 2023 17:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: sm6350: Use specific qmpphy
 compatible
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
References: <20230120-sm6350-usbphy-v4-0-4d700a90ba16@fairphone.com>
 <20230120-sm6350-usbphy-v4-3-4d700a90ba16@fairphone.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230120-sm6350-usbphy-v4-3-4d700a90ba16@fairphone.com>
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



On 23.01.2023 14:29, Luca Weiss wrote:
> The sc7180 phy compatible works fine for some cases, but it turns out
> sm6350 does need proper phy configuration in the driver, so use the
> newly added sm6350 compatible.
> 
> Because the sm6350 compatible is using the new binding, we need to
> change the node quite a bit to match it.
> 
> This fixes qmpphy init when no USB cable is plugged in during bootloader
> stage.
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 54 +++++++++++-------------------------
>  1 file changed, 16 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index 8224adb99948..128dbbe23ef5 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/interconnect/qcom,sm6350.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  
> @@ -1314,49 +1315,26 @@ usb_1_hsphy: phy@88e3000 {
>  			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>  		};
>  
> -		usb_1_qmpphy: phy@88e9000 {
> -			compatible = "qcom,sc7180-qmp-usb3-dp-phy";
> -			reg = <0 0x088e9000 0 0x200>,
> -			      <0 0x088e8000 0 0x40>,
> -			      <0 0x088ea000 0 0x200>;
> -			status = "disabled";
> -			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +		usb_1_qmpphy: phy@88e8000 {
> +			compatible = "qcom,sm6350-qmp-usb3-dp-phy";
> +			reg = <0 0x088e8000 0 0x3000>;
>  
>  			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> -				 <&xo_board>,
> -				 <&rpmhcc RPMH_QLINK_CLK>,
> -				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> -			clock-names = "aux", "cfg_ahb", "ref", "com_aux";
> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "aux", "ref", "com_aux", "usb3_pipe";
> +
> +			power-domains = <&gcc USB30_PRIM_GDSC>;
>  
> -			resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,
> -				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +			resets = <&gcc GCC_USB3_PHY_PRIM_BCR>,
> +				 <&gcc GCC_USB3_DP_PHY_PRIM_BCR>;
>  			reset-names = "phy", "common";
>  
> -			usb_1_ssphy: usb3-phy@88e9200 {
> -				reg = <0 0x088e9200 0 0x200>,
> -				      <0 0x088e9400 0 0x200>,
> -				      <0 0x088e9c00 0 0x400>,
> -				      <0 0x088e9600 0 0x200>,
> -				      <0 0x088e9800 0 0x200>,
> -				      <0 0x088e9a00 0 0x100>;
> -				#clock-cells = <0>;
> -				#phy-cells = <0>;
> -				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> -				clock-names = "pipe0";
> -				clock-output-names = "usb3_phy_pipe_clk_src";
> -			};
> +			#clock-cells = <1>;
> +			#phy-cells = <1>;
>  
> -			dp_phy: dp-phy@88ea200 {
> -				reg = <0 0x088ea200 0 0x200>,
> -				      <0 0x088ea400 0 0x200>,
> -				      <0 0x088eaa00 0 0x200>,
> -				      <0 0x088ea600 0 0x200>,
> -				      <0 0x088ea800 0 0x200>;
> -				#phy-cells = <0>;
> -				#clock-cells = <1>;
> -			};
> +			status = "disabled";
>  		};
>  
>  		dc_noc: interconnect@9160000 {
> @@ -1430,7 +1408,7 @@ usb_1_dwc3: usb@a600000 {
>  				snps,dis_enblslpm_quirk;
>  				snps,has-lpm-erratum;
>  				snps,hird-threshold = /bits/ 8 <0x10>;
> -				phys = <&usb_1_hsphy>, <&usb_1_ssphy>;
> +				phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
>  				phy-names = "usb2-phy", "usb3-phy";
>  			};
>  		};
> 
