Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7651B7042CE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjEPBX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjEPBXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:23:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298DD1BF6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:23:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac80da3443so146081231fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684200201; x=1686792201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdcz+tlufyCWWmwwRYaeolzxPDHo6Vkg33VyiauA0pw=;
        b=Mw4KMu+EFSlqV0wV1eo6KCnJr+WVbPdA+8FJT5c6eJSfhILo4i/sBevX12Ios/Gpks
         +WMapNODRme/GSwdhzReXInQ8cDG/dHggw0J/Xjh3QWbROlooH/tCguFmLSiMfq+FI7y
         L3YqPyQuaoyKgH+wH+RdImfNTsfmzyuxnGeeGGCZnVB8NQjCpmxalkvLWJjBSjkrbCih
         GC2FcrAYj73k0gSa/t0aYpmhB+liFlguMT76n3afTkrj6exGxm+BU4dSO2ZxVdS2KbUY
         Q/M8DGghjm7/0kGKGn+klieK2eNZBrj5a3TyBq8eeS22YF36Mbgi2/Ydti9Z/6VSy1gl
         Qhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200201; x=1686792201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdcz+tlufyCWWmwwRYaeolzxPDHo6Vkg33VyiauA0pw=;
        b=SI62FnrKkbfC/HWcqADfTNu0JJRcc6W/M9/YvPA2AXTu7Dg8Lbrd4o8fr0iIE+UnYU
         pbWEM1Iv/OoNdKqBTGzE4URsIhgXr5lwUGN4IbtdjuXpqeXDXoAMh5+Nbx2Er+TAd0i3
         592aNPtm8c4TqePhlzqqj6ptSzDXtUVkTCWHfzrhUvXtw23Ksis4zu7OQqohnW0yEh5I
         XyYr9VdaIUlW7bfXAytYfrYoQFBIVcY3//asrUzQGP7Wd9nOCkzX7RRJHR+lL/Z+5cBn
         8aVga9xlMcuSieh2h91td85AyGmMDXwKsKzUiRJgRCdksJ6nEuNW/XP3b6jLr+nE6P1q
         jJYw==
X-Gm-Message-State: AC+VfDzsG2EIrYCFRV20ZwVnHEhTJROaK/OvR4m5Jjltd6dg3PFUKo3T
        u/eJs5ACWv0Lc2A8te1zokwChg==
X-Google-Smtp-Source: ACHHUZ6r9pzz9/eTWV8LflnTd0wsAp9+78FKTyrZ2P1/zI1IumkTrCsCMttylpIlB6cmdAu09tGo7w==
X-Received: by 2002:a2e:87cc:0:b0:2a7:b168:9e87 with SMTP id v12-20020a2e87cc000000b002a7b1689e87mr7341738ljj.18.1684200201468;
        Mon, 15 May 2023 18:23:21 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id p21-20020a2e8055000000b002ad8cbb7349sm3464568ljg.98.2023.05.15.18.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:23:21 -0700 (PDT)
Message-ID: <bfc92e7b-e5c0-b038-9719-151995396a8c@linaro.org>
Date:   Tue, 16 May 2023 03:23:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 4/5] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3
 connector
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org
References: <20230505064039.1630025-1-bhupesh.sharma@linaro.org>
 <20230505064039.1630025-5-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230505064039.1630025-5-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.05.2023 08:40, Bhupesh Sharma wrote:
> Add the Embedded USB Debugger(EUD) device tree node for
> SM6115 / SM4250 SoC.
> 
> The node contains EUD base register region, EUD mode manager
> register region and TCSR Base register region along with the
> interrupt entry.
> 
> Also add the typec connector node for EUD which is attached to
> EUD node via port. EUD is also attached to DWC3 node via port.
> 
> To enable the role switch, we need to set dr_mode = "otg" property
> for 'usb_dwc3' sub-node in the board dts file.
> 
> Also the EUD device can be enabled on a board once linux is boot'ed
> by setting:
>  $ echo 1 > /sys/bus/platform/drivers/qcom_eud/../enable
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 51 ++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index f67863561f3f..61a0af33ca43 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -180,6 +180,18 @@ core3 {
>  		};
>  	};
>  
> +	eud_typec: connector {
> +		compatible = "usb-c-connector";
> +
> +		ports {
> +			port@0 {
> +				con_eud: endpoint {
> +					remote-endpoint = <&eud_con>;
> +				};
> +			};
> +		};
> +	};
> +
>  	firmware {
>  		scm: scm {
>  			compatible = "qcom,scm-sm6115", "qcom,scm";
> @@ -647,6 +659,38 @@ gcc: clock-controller@1400000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		eud: eud@1610000 {
> +			compatible = "qcom,sm6115-eud", "qcom,eud";
> +			reg = <0x0 0x01610000 0x0 0x2000>,
> +			      <0x0 0x01612000 0x0 0x1000>,
> +			      <0x0 0x003c0000 0x0 0x40000>;
> +			reg-names = "eud-base", "eud-mode-mgr", "tcsr-base";
> +			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
> +			qcom,secure-mode-enable;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port@0 {
> +					reg = <0>;
> +
> +					eud_ep: endpoint {
> +						remote-endpoint = <&usb2_role_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
> +
> +					eud_con: endpoint {
> +						remote-endpoint = <&con_eud>;
> +					};
> +				};
> +			};
> +		};
> +
>  		usb_hsphy: phy@1613000 {
>  			compatible = "qcom,sm6115-qusb2-phy";
>  			reg = <0x0 0x01613000 0x0 0x180>;
> @@ -1144,6 +1188,13 @@ usb_dwc3: usb@4e00000 {
>  				snps,has-lpm-erratum;
>  				snps,hird-threshold = /bits/ 8 <0x10>;
>  				snps,usb3_lpm_capable;
> +				usb-role-switch;
> +
> +				port {
> +					usb2_role_switch: endpoint {
> +						remote-endpoint = <&eud_ep>;
> +					};
> +				};
>  			};
>  		};
>  
