Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0026F68B9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjEDJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjEDJxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:53:48 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF34220
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:53:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f14468ef54so312855e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683194025; x=1685786025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhz3O9BzWKakpJoLNASXwlnplTMxOKAb7/tbotrDYZA=;
        b=n9bfzA293hypbCgNkm5RhVK68ZEqXzMn5XlurLUe9KNExGlTMb5sVYBxtF6HuoxZZY
         fo0bfZBQd3Y+XOY2Mb/G3ujYS9rTs8sqvrnFCPOucvvMhp+/jVe6n0eHevJymQ+MJkol
         pQqToh4BzFTlQ+LeRnW66EiEpKOx63L7hSWxrArrSUk3QSnPj2mdN3UpsUMj8kQfjaQ2
         prB6SgAPphBE+3Jm6hRcRUnw5ocNi7EET2ZDI6P2cwM83nqM//vbxHKktxXzYWayfjq2
         1Ll2bj5LtnsQodBPa2Zb0qHT2Q9SgMeCZwcbz0MTxo0QV+qZhStTz2ABHpJTitYqlzY5
         8CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683194025; x=1685786025;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhz3O9BzWKakpJoLNASXwlnplTMxOKAb7/tbotrDYZA=;
        b=FGOhg4SV7TGoVdbq0aoV4iB/RA6tuNb7LDOtVn6nYMZAuTaGFuq7S+Pa7pCzXF59tU
         y5lzBpwCq1BBgt3WV8TFDEhXNe9NA9jIOOMcKj4Ju53jmOr2ZzuiLOWvYSAwoYRaC66I
         jxn0OUVUe4T/JCoun6a4hThTfV+IGW0OPq7x0fUQVRHvSoVHfaNprB0xv/EKxNd/sJaS
         bcgPuN3oZfwL75eATA+to23YWrtnXfgRdpNovabWxN5GvY/C8sJw5rYuzeY/pp0eetRU
         3l82iur9n14ZTXaP3wFrYlHd7QQpvvhKsg6Q9s7YvpsbYxXhkkjmSvfiMog+H7TVn3pc
         hyKA==
X-Gm-Message-State: AC+VfDxhl4PE1Jh4BiJfqZV6ZjVlXBY4acsjRvq75qc8Y/wSXDSag4gk
        VpMubQvBU7ZkbaNxt/dcsny2OQ==
X-Google-Smtp-Source: ACHHUZ4qUP3oJDTPyYnMqjUWG5RqMudfjwAWrR9EbIYc2Ic9y0gIf0WyKkeeIobgBRA/aDyXDKz4PA==
X-Received: by 2002:a05:6512:505:b0:4ef:d4ee:1a6a with SMTP id o5-20020a056512050500b004efd4ee1a6amr1478525lfb.44.1683194025045;
        Thu, 04 May 2023 02:53:45 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id u5-20020a056512040500b004efd2b04f7fsm901483lfk.87.2023.05.04.02.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 02:53:44 -0700 (PDT)
Message-ID: <99686fdf-73eb-30e0-8ad2-64af1b6b3508@linaro.org>
Date:   Thu, 4 May 2023 11:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 4/5] arm64: dts: qcom: sm6115: Add EUD dt node and dwc3
 connector
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
References: <20230504082644.1461582-1-bhupesh.sharma@linaro.org>
 <20230504082644.1461582-5-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230504082644.1461582-5-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.05.2023 10:26, Bhupesh Sharma wrote:
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
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 48 ++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index f67863561f3f..6865342fc42f 100644
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
> @@ -647,6 +659,35 @@ gcc: clock-controller@1400000 {
>  			#power-domain-cells = <1>;
>  		};
>  
> +		eud: eud@1610000 {
> +			compatible = "qcom,sm6115-eud", "qcom,eud";
> +			reg = <0x0 0x01610000 0x0 0x2000>,
> +			      <0x0 0x01612000 0x0 0x1000>,
> +			      <0x0 0x003c0000 0x0 0x40000>;
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
Please insert a newline before each child node.

Konrad
> +					eud_ep: endpoint {
> +						remote-endpoint = <&usb2_role_switch>;
> +					};
> +				};
> +
> +				port@1 {
> +					reg = <1>;
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
> @@ -1144,6 +1185,13 @@ usb_dwc3: usb@4e00000 {
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
