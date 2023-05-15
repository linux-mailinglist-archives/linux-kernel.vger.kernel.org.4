Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5339F702FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbjEOO1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbjEOO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F3F135;
        Mon, 15 May 2023 07:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBF8961E81;
        Mon, 15 May 2023 14:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D68C433EF;
        Mon, 15 May 2023 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684160816;
        bh=4klK1qNnVxB9VfQGKW5xcLuUT3JrqtA3WFCXNlPR5e8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y8YKV4IgdgV4lOeVqUT5MbcKSF2/d+kFXL7BLrJXBxqcCm+40pTxVruHXP0OHxxRW
         3dIyFDUnm5Hm2qwawyPPQwGed1/NLtySpC9Vbz86T3KeUZbVULTB1k7fWLn3iG17CF
         yh/6gzcDXUBtO4R2ljTfPuP3C3zf8TtdJ0veNFVnrHk/aTKUO7faG3lOiuZmknjNp7
         nHuyNNVHyhvLkCAbZr08qMT4xL3mymeQByZehe0Lv3zU1PZQDCLevdLoHCx3ijgcue
         4ATlI1OMmjBLivdmEaxYLxdH+A7Vde8VD+Tnjqkth6N35rUadBPbKNV2sBvKrW/huy
         +g4LZZUlyTobw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pyZA5-0002JU-BO; Mon, 15 May 2023 16:26:53 +0200
Date:   Mon, 15 May 2023 16:26:53 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v8 7/9] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <ZGJBLUsPcbsxj989@hovoldconsulting.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-8-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514054917.21318-8-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 11:19:15AM +0530, Krishna Kurapati wrote:
> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
> platforms.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 66 ++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 8fa9fbfe5d00..50f6a8424537 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3133,6 +3133,72 @@ usb_1_role_switch: endpoint {
>  			};
>  		};
>  
> +		usb_2: usb@a4f8800 {

As I believe someone already pointed out, this node is not in sort order
(i.e. it should go before usb@a6f8800).

> +			compatible = "qcom,sc8280xp-dwc3-mp", "qcom,dwc3";
> +			reg = <0 0x0a4f8800 0 0x400>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
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
> +
> +			assigned-clocks = <&gcc GCC_USB30_MP_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB30_MP_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <200000000>;
> +
> +			interrupts-extended = <&pdc 127 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 126 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "dp_hs_phy_irq",
> +					  "dm_hs_phy_irq",
> +					  "ss_phy_irq",
> +					  "pwr_event_1",
> +					  "pwr_event_2",
> +					  "pwr_event_3",
> +					  "pwr_event_4";
> +
> +			power-domains = <&gcc USB30_MP_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +
> +			resets = <&gcc GCC_USB30_MP_BCR>;
> +
> +			interconnects = <&aggre1_noc MASTER_USB3_1 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_1 0>;

This is not the correct interconnect master and slave; it should be
MASTER_USB3_MP and SLAVE_USB3_MP.

> +			interconnect-names = "usb-ddr", "apps-usb";

Looks like 'wakeup-source' is missing here too.

> +
> +			status = "disabled";
> +
> +			usb_2_dwc3: usb@a400000 {
> +				compatible = "snps,dwc3";
> +				reg = <0 0x0a400000 0 0xcd00>;
> +				interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0x800 0x0>;
> +				phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>,
> +					<&usb_2_hsphy1>, <&usb_2_qmpphy1>,
> +					<&usb_2_hsphy2>,
> +					<&usb_2_hsphy3>;
> +				phy-names = "usb2-port0", "usb3-port0",
> +						"usb2-port1", "usb3-port1",
> +						"usb2-port2",
> +						"usb2-port3";

The phys and phy-names continuation lines above are still not aligned.

> +			};
> +		};
> +
>  		mdss0: display-subsystem@ae00000 {
>  			compatible = "qcom,sc8280xp-mdss";
>  			reg = <0 0x0ae00000 0 0x1000>;

Johan
