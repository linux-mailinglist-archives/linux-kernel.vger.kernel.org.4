Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6110A6F5A49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjECOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjECOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADF64ED2;
        Wed,  3 May 2023 07:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA8FB62E29;
        Wed,  3 May 2023 14:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292FCC433EF;
        Wed,  3 May 2023 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683124811;
        bh=8pMKmLc4xhbl/d8v0jF7pIE0f0XSP8XV5WPvs8RNh94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGe8wc2wdPxW4IWW+RScbyG2F6z8C9e4TAO/38yubQjbLiAcr7sh7MHOqCQiau/85
         OlZ+khbWrTVZxAnPxrJwPbneaWwJAqw2SOGDSePYSWlUan9TJ3rkWUpYCKJDsXJOEc
         tx5z6oS7tSunK+9FjDmBPl0e+cHXC2udTP0EyAIczAGxAnR2ut1n66JsxAElEzm9zE
         S2MYLY9877kzNZefayPoe4qagN+KfzCrbsVjM2QYHcScW50eIyvPawZUePQbqHdca7
         +zm3rs6qFSv+W+TuQkyrOybbwCPnxLJLsLstviXxxuIZF1Flx07ZYO2DSwQEHC9+dP
         1k7DkB8HqrxdQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1puDeS-0007WX-SA; Wed, 03 May 2023 16:40:16 +0200
Date:   Wed, 3 May 2023 16:40:16 +0200
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
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v7 7/9] arm64: dts: qcom: sc8280xp: Add multiport
 controller node for SC8280
Message-ID: <ZFJyUPqED2q9R8v8@hovoldconsulting.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-8-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501143445.3851-8-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 08:04:43PM +0530, Krishna Kurapati wrote:
> Add USB and DWC3 node for tertiary port of SC8280 along with multiport
> IRQ's and phy's. This will be used as a base for SA8295P and SA8295-Ride
> platforms.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 64 ++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 8fa9fbfe5d00..0e4fb286956b 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -3133,6 +3133,70 @@ usb_1_role_switch: endpoint {
>  			};
>  		};
>  
> +		usb_2: usb@a4f8800 {
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
> +						<&pdc 126 IRQ_TYPE_EDGE_RISING>,
> +						<&pdc 16 IRQ_TYPE_LEVEL_HIGH>,
> +						<GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
> +						<GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> +						<GIC_SPI 857 IRQ_TYPE_LEVEL_HIGH>,
> +						<GIC_SPI 856 IRQ_TYPE_LEVEL_HIGH>;

This looks wrong. You're missing the &intc phandle for the last four
entries:

  DTC     arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb
/home/johan/work/linaro/src/linux/arch/arm64/boot/dts/qcom/sc8280xp.dtsi:3372.4-3378.17: Warning (interrupts_extended_property): /soc@0/usb@a4f8800:interrupts-extended: cell 10 is not a phandle reference
/home/johan/work/linaro/src/linux/arch/arm64/boot/dts/qcom/sc8280xp.dtsi:3349.22-3411.5: Warning (interrupts_extended_property): /soc@0/usb@a4f8800: Missing property '#interrupt-cells' in node /soc@0/display-subsystem@ae00000/displayport-controller@aea0000/opp-table or bad phandle (referred from interrupts-extended[10])
  also defined at /home/johan/work/linaro/src/linux/arch/arm64/boot/dts/qcom/sa8540p-ride.dts:312.8-317.3
/home/johan/work/linaro/src/linux/arch/arm64/boot/dts/qcom/sc8280xp.dtsi:3372.4-3378.17: Warning (interrupts_extended_property): /soc@0/usb@a4f8800:interrupts-extended: cell 10 is not a phandle reference
/home/johan/work/linaro/src/linux/arch/arm64/boot/dts/qcom/sc8280xp.dtsi:3349.22-3411.5: Warning (interrupts_extended_property): /soc@0/usb@a4f8800: Missing property '#interrupt-cells' in node /soc@0/display-subsystem@ae00000/displayport-controller@ae9a000/ports/port@0/endpoint or bad phandle (referred from interrupts-extended[10])
  also defined at /home/johan/work/linaro/src/linux/arch/arm64/boot/dts/qcom/sa8295p-adp.dts:587.8-594.3
/home/johan/work/linaro/src/linux/arch/arm64/boot/dts/qcom/sc8280xp.dtsi:3372.4-3378.17: Warning (interrupts_extended_property): /soc@0/usb@a4f8800:interrupts-extended: cell 10 is not a phandle reference
/home/johan/work/linaro/src/linux/arch/arm64/boot/dts/qcom/sc8280xp.dtsi:3349.22-3411.5: Warning (interrupts_extended_property): /soc@0/usb@a4f8800: Missing property '#interrupt-cells' in node /interconnect-mmss-noc or bad phandle (referred from interrupts-extended[10])
/home/johan/work/linaro/src/linux/arch/arm64/boot/dts/qcom/sc8280xp.dtsi:3372.4-3378.17: Warning (interrupts_extended_property): /soc@0/usb@a4f8800:interrupts-extended: cell 10 is not a phandle reference
/home/johan/work/linaro/src/linux/arch/arm64/boot/dts/qcom/sc8280xp.dtsi:3349.22-3411.5: Warning (interrupts_extended_property): /soc@0/usb@a4f8800: Missing property '#interrupt-cells' in node /soc@0/phy@88e7000 or bad phandle (referred from interrupts-extended[10])

> +			interrupt-names = "dp_hs_phy_irq", "dm_hs_phy_irq",
> +						"ss_phy_irq", "pwr_event_1",
> +						"pwr_event_2", "pwr_event_3",
> +						"pwr_event_4";

Also the order does not match the binding where you had the pwr_event
interrupts first.

Johan
