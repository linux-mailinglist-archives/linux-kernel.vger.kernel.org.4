Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3583727E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbjFHLJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjFHLJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:09:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD74216
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:06:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f642a24568so587958e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 04:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686222411; x=1688814411;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+caIrEw0n7E+RHuWHb1TL2Rrvag6tUOBdTOavrLMBK4=;
        b=iiCqm8fIcYbtR6/eI7I4VNh8+6lwh2wQwbwMCsfbb0NJ172k9z6wLXuzXPgpuSvqlH
         glJJoaspnDbcsVoph9BTtPMZKXFBEbAeCKhpH8DOjAXgyd7v7sHgeAcdQbsJTLHK4dLX
         LCjloHXOhH4kY0YmAjjweedqNS3F+JSJ7XUMMqU82wcggkbb9OtXjZjr/D/D9nAjj9GZ
         39kV30KZ7LS0SaruyzA8VGLYRsj/BXye7OA4ur2UEeVXT7k/jcRsxJ73N4BADiH+MRYA
         pLOZAXdByHgpISQ86sjAl/CKJ49WWU4e1U+N8huqTZ26C1eqB3z/ZZINDEc+bp24Mjfp
         Bk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686222411; x=1688814411;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+caIrEw0n7E+RHuWHb1TL2Rrvag6tUOBdTOavrLMBK4=;
        b=gjfGd8GAG4vVJQ4G8YwzhrpA9DXnejaEge+nBddaMD+3KGkD9V93j3iIDcQYng8NcR
         fngcwpxjjiOTk+p+6O1GaG892jGmbRFKAwlZ0q3u9/k9XBGvRX3hZAddp2LQipb8qjEY
         Qy15ESeaOx0tGKbdzkqrMFiQ0815UdsCRZEElFie0YbTY7zTYwna0oX9sVqPDuDBLgSC
         GMyE1CXHNEepbcHTA1QH3Z3ObYRfOHrYKPNF7FyVaqnZ99uBaZPSPHAyDrvXDz2WQshk
         3Dy4v//fV2/JDCpupU2Fram+R1IvA6aKqmb8WYFZoUPxS8diU2+oLHX7OPwyE2Fm4NXW
         6t2Q==
X-Gm-Message-State: AC+VfDxflgbLUUR9aKMiTc3KXI1M1GixHKYjZXT3yd0l+sY1NrVio7lW
        rIH+zjnrcQQ6U4vcpMtJ+KThrw==
X-Google-Smtp-Source: ACHHUZ5ILhAtEGWd5FVAaCuMWXlusQ2n+jwbCu1VRWLWyrrXjaIkcb+Br9SQPg5UBNC1aNWJ8hf5dA==
X-Received: by 2002:ac2:44ae:0:b0:4f2:5c4b:e699 with SMTP id c14-20020ac244ae000000b004f25c4be699mr3077490lfm.24.1686222410690;
        Thu, 08 Jun 2023 04:06:50 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id p16-20020a19f010000000b004f4d5844b48sm145753lfc.279.2023.06.08.04.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 04:06:50 -0700 (PDT)
Message-ID: <71960b11-5686-9af5-423b-bfdaec56f3f9@linaro.org>
Date:   Thu, 8 Jun 2023 14:06:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 3/5] arm64: dts: qcom: ipq9574: Add USB related nodes
Content-Language: en-GB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <cover.1686217906.git.quic_varada@quicinc.com>
 <2f91eb879daaf9955dc56135d60a4be5e191a44d.1686217906.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <2f91eb879daaf9955dc56135d60a4be5e191a44d.1686217906.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 08/06/2023 13:03, Varadarajan Narayanan wrote:
> Add USB phy and controller related nodes
> 
> SS PHY need two supplies and HS PHY needs three supplies. 0.925V
> and 3.3V are from fixed regulators and 1.8V is generated from
> PMIC's LDO
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   Changes in v13:
> 	- Move fixed regulator definitions from SoC dtsi to board dts
> 	- Remove 'dr_mode' from SoC dtsi
> 	- Move 'status' property to the end
>   Changes in v12:
> 	- Rebase
>   Changes in v11:
> 	- Rename dwc_0 -> usb_0_dwc3
>   Changes in v10:
> 	- Fix regulator definitions
>   Changes in v8:
> 	- Change clocks order to match the bindings
>   Changes in v7:
> 	- Change com_aux -> cfg_ahb
>   Changes in v6:
> 	- Introduce fixed regulators for the phy
> 	- Resolved all 'make dtbs_check' messages
> 
>   Changes in v5:
> 	- Fix additional comments
> 	- Edit nodes to match with qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> 	- 'make dtbs_check' giving the following messages since
> 	  ipq9574 doesn't have power domains. Hope this is ok
> 
> 		/local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: phy@7d000: 'power-domains' is a required property
>          	From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
> 		/local/mnt/workspace/varada/varda-linux/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dtb: usb@8a00000: 'power-domains' is a required property
>          	From schema: /local/mnt/workspace/varada/varda-linux/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> 
>   Changes in v4:
> 	- Use newer bindings without subnodes
> 	- Fix coding style issues
> 
>   Changes in v3:
> 	- Insert the nodes at proper location
> 
>   Changes in v2:
> 	- Fixed issues flagged by Krzysztof
> 	- Fix issues reported by make dtbs_check
> 	- Remove NOC related clocks (to be added with proper
> 	  interconnect support)
> ---
>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 18 ++++++
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 85 +++++++++++++++++++++++++++++
>   2 files changed, 103 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> index 2b3ed8d..8261a2b 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
> @@ -21,6 +21,24 @@
>   	chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
> +
> +	regulator_fixed_3p3: s3300 {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-name = "fixed_3p3";
> +	};
> +
> +	regulator_fixed_0p925: s0925 {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <925000>;
> +		regulator-max-microvolt = <925000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-name = "fixed_0p925";
> +	};
>   };

Let me repeat from v13, so that it is not lost (please excuse me for the 
spam):

Nit: these two regulators are not references from SoC dtsi. So they 
don't have to be a part of this commit and can be moved to one of the 
next commits (I'd prefer the last one).

>   
>   &blsp1_uart2 {
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 0baeb10..feabc19 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -465,6 +465,91 @@
>   			status = "disabled";
>   		};
>   
> +		usb_0_qusbphy: phy@7b000 {
> +			compatible = "qcom,ipq9574-qusb2-phy";
> +			reg = <0x0007b000 0x180>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +				 <&xo_board_clk>;
> +			clock-names = "cfg_ahb",
> +				      "ref";
> +
> +			resets = <&gcc GCC_QUSB2_0_PHY_BCR>;
> +			status = "disabled";
> +		};
> +
> +		usb_0_qmpphy: phy@7d000 {
> +			compatible = "qcom,ipq9574-qmp-usb3-phy";
> +			reg = <0x0007d000 0xa00>;
> +			#phy-cells = <0>;
> +
> +			clocks = <&gcc GCC_USB0_AUX_CLK>,
> +				 <&xo_board_clk>,
> +				 <&gcc GCC_USB0_PHY_CFG_AHB_CLK>,
> +				 <&gcc GCC_USB0_PIPE_CLK>;
> +			clock-names = "aux",
> +				      "ref",
> +				      "cfg_ahb",
> +				      "pipe";
> +
> +			resets = <&gcc GCC_USB0_PHY_BCR>,
> +				 <&gcc GCC_USB3PHY_0_PHY_BCR>;
> +			reset-names = "phy",
> +				      "phy_phy";
> +
> +			#clock-cells = <0>;
> +			clock-output-names = "usb0_pipe_clk";
> +
> +			status = "disabled";
> +		};
> +
> +		usb3: usb@8af8800 {
> +			compatible = "qcom,ipq9574-dwc3", "qcom,dwc3";
> +			reg = <0x08af8800 0x400>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_SNOC_USB_CLK>,
> +				 <&gcc GCC_USB0_MASTER_CLK>,
> +				 <&gcc GCC_ANOC_USB_AXI_CLK>,
> +				 <&gcc GCC_USB0_SLEEP_CLK>,
> +				 <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +
> +			clock-names = "cfg_noc",
> +				      "core",
> +				      "iface",
> +				      "sleep",
> +				      "mock_utmi";
> +
> +			assigned-clocks = <&gcc GCC_USB0_MASTER_CLK>,
> +					  <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +			assigned-clock-rates = <200000000>,
> +					       <24000000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "pwr_event";
> +
> +			resets = <&gcc GCC_USB_BCR>;
> +			status = "disabled";
> +
> +			usb_0_dwc3: usb@8a00000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x8a00000 0xcd00>;
> +				clocks = <&gcc GCC_USB0_MOCK_UTMI_CLK>;
> +				clock-names = "ref";
> +				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +				phys = <&usb_0_qusbphy>, <&usb_0_qmpphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +				tx-fifo-resize;
> +				snps,is-utmi-l1-suspend;
> +				snps,hird-threshold = /bits/ 8 <0x0>;
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_u3_susphy_quirk;
> +			};
> +		};
> +
>   		intc: interrupt-controller@b000000 {
>   			compatible = "qcom,msm-qgic2";
>   			reg = <0x0b000000 0x1000>,  /* GICD */

-- 
With best wishes
Dmitry

