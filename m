Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB83773C430
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjFWWjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjFWWjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:39:44 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE08186
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:39:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b46cfde592so19222621fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 15:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687559979; x=1690151979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QMQGlIRe2vdR7Of+NYba5B20bPRAZmFxIYcydbS5390=;
        b=WWXDK7NhiQbnTqksdAM+GhIWvNjlbEWF2Jm+YNFiyfJau/2pS0RgGzarl60g2ad7lD
         +APL+ctO1bb/nzVFINtwx7JWH4CPiEVHt/9ZF5gIYFethaF63pJyfKHZMMJ74wefzXqr
         9cOKkNC/PNI0xeVQkh91aMlkMaTOO8AaGsX82I+yI3r1wVQQCDwVTjm6NnsUXw3Bx50t
         jtj8m4Qsrc7pQh02CYePsjeXrmJE5CeLdNsMe6eViXsuKV9xTbMPYUujTNjcIrQq0RL8
         FkcTvMxHc+XRDm1B7q6T6EsDu7fZbUQyFWQP871e71Mq9RNUt+SLabw4e8o0IPmGCpiT
         EbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687559979; x=1690151979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QMQGlIRe2vdR7Of+NYba5B20bPRAZmFxIYcydbS5390=;
        b=mAE8cSYPto5D33m8c29PAIyYkP8X+KqhFTjjToa6lWM8YVbZdVQwMHFmPuRwF90AFn
         ddM/vaDEih+tWe2+g/Mm4HqhLRqsXN2nWp7YgPj+ZEwAtg2rGnuPfSdKH0a4bMuqonpa
         9UpW6ybkSv8k5Xllxm1H2U8F3OQckpjHjPC4kx03IHtHv+mJ/aa3R9efQKjnrPv/mpW3
         IKvfM7FHU5T08vC6XlvkNm29/0EyLJSxHlzJo6k4M5hcYnYx1ZXCM45VKz37waYD4Ro1
         EQum/+03EjrywK7YYhTIYES6z0ACwS9KahvsMQCPf5gP3FLqlFur1HxqYGKAPWPQMC1M
         HS/w==
X-Gm-Message-State: AC+VfDxBefE6ZSMk8+LH1gJUkO8AR4W21GLKqrzsr923IB4Eqm/Usc3e
        Kiyo2g/U7JibdhdHVTpPB1VYOA==
X-Google-Smtp-Source: ACHHUZ7NOMcegf/kVg5wepRkY9BvsOQqW4O7Zc0MiLmWC5tNd0vsa1LDls1VVurP4oBK2BC5HG7Xgw==
X-Received: by 2002:a2e:a0d8:0:b0:2b5:7f93:b3ad with SMTP id f24-20020a2ea0d8000000b002b57f93b3admr8181871ljm.16.1687559978955;
        Fri, 23 Jun 2023 15:39:38 -0700 (PDT)
Received: from [192.168.1.101] (abyk30.neoplus.adsl.tpnet.pl. [83.9.30.30])
        by smtp.gmail.com with ESMTPSA id n15-20020a2eb78f000000b002b32fde1ee6sm2380ljo.95.2023.06.23.15.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 15:39:38 -0700 (PDT)
Message-ID: <2eab503f-fa0d-990e-bed2-2445c5496798@linaro.org>
Date:   Sat, 24 Jun 2023 00:39:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 08/10] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-9-quic_kriskura@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230621043628.21485-9-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.2023 06:36, Krishna Kurapati wrote:
> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
> platforms.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 77 ++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 8fa9fbfe5d00..0dfa350ea3b3 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3013,6 +3013,83 @@ system-cache-controller@9200000 {
>  			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> +		usb_2: usb@a4f8800 {
> +			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
> +			reg = <0 0x0a4f8800 0 0x400>;

> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
These three properties, please stick just before status

> +
> +			clocks = <&gcc GCC_CFG_NOC_USB3_MP_AXI_CLK>,
> +				 <&gcc GCC_USB30_MP_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB3_MP_AXI_CLK>,
> +				 <&gcc GCC_USB30_MP_SLEEP_CLK>,
> +				 <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
> +				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
> +				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
> +			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi",
> +				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";
Please make it one per line

> +
> +			assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_MP_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
And here

> +
> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 129 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 128 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 131 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 130 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 133 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 132 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 17 IRQ_TYPE_LEVEL_HIGH>,
Not a comment to the patch, but very nice that Qcom ensured every
endpoint is wakeup-capable, this used not to be the case before :D

> +					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
> +
Remove this newline

> +			interrupt-names = "dp1_hs_phy_irq", "dm1_hs_phy_irq",
> +					  "dp2_hs_phy_irq", "dm2_hs_phy_irq",
> +					  "dp3_hs_phy_irq", "dm3_hs_phy_irq",
> +					  "dp4_hs_phy_irq", "dm4_hs_phy_irq",
> +					  "ss1_phy_irq", "ss2_phy_irq",
> +					  "pwr_event_1",
> +					  "pwr_event_2",
> +					  "pwr_event_3",
> +					  "pwr_event_4";
Please make it one per line

> +
> +			power-domains = <&gcc USB30_MP_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +
> +			resets = <&gcc GCC_USB30_MP_BCR>;
> +
> +			interconnects = <&aggre1_noc MASTER_USB3_MP 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_MP 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
> +			wakeup-source;
> +
> +			status = "disabled";
> +
> +			usb_2_dwc3: usb@a400000 {
> +				compatible = "snps,dwc3";
> +				reg = <0 0x0a400000 0 0xcd00>;
> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0x800 0x0>;
> +				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
> +				       <&usb_2_hsphy1>, <&usb_2_qmpphy1>,
> +				       <&usb_2_hsphy2>,
> +				       <&usb_2_hsphy3>;
And here
> +				phy-names = "usb2-port0", "usb3-port0",
> +					    "usb2-port1", "usb3-port1",
> +					    "usb2-port2",
> +					    "usb2-port3";
And here

Thanks for working on this!

Konrad
> +			};
> +		};
> +
>  		usb_0: usb@a6f8800 {
>  			compatible = "qcom,sc8280xp-dwc3", "qcom,dwc3";
>  			reg = <0 0x0a6f8800 0 0x400>;
