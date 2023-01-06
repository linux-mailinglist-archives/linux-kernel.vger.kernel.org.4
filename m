Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FD16605E2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbjAFRqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjAFRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:46:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7927F76EC7;
        Fri,  6 Jan 2023 09:46:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FF69B810A7;
        Fri,  6 Jan 2023 17:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBC0C433D2;
        Fri,  6 Jan 2023 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673027202;
        bh=zAgWER85TJxXLY2e0JUrVqfqSbbG8QDcAAUmSt21j+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GdavBENoM1AU/cSFJTsZ1n14zPEudSFwCpVOCtL9iEK5TSm9nm8LzU0Sz90l1sU6H
         1ygDcWiLWBX44Qh4pAIwuuQE7m/N8FNNno0+oSAhnWTwsDrBX3ezd42junjgiLrrBC
         GpUvbbRI38vCg3W+QtFWYVObEv7Rg1B4wtprkLgwwIe3P/FYTIVxRPdokqfOve09Er
         mddhBngqbIoc/5LOL3l03Q/SOYZo66ruIKMfe7GkHsMlkxjXo6qYxy7NYJErryg1c/
         w2du50eLFIB/5kh9Wk21mxNkiBUVPpOVM+gFLMlSiQ4XgO8iEP4H59gE/M0WO2TFsn
         ILhGulNqmt2mQ==
Date:   Fri, 6 Jan 2023 11:46:40 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Message-ID: <20230106174640.ndis3zm5heoa5wpb@builder.lan>
References: <20221215094532.589291-1-bhupesh.sharma@linaro.org>
 <20221215094532.589291-4-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215094532.589291-4-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 03:15:32PM +0530, Bhupesh Sharma wrote:
> Add USB superspeed qmp phy node to dtsi.
> Make sure that the oneplus board dts (which includes the
> sm4250.dtsi) continues to work as intended.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
>  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 37 ++++++++++++++++++-
>  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> index 3f39f25e0721e..4f0d65574448b 100644
> --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -232,6 +232,9 @@ &usb {
>  &usb_dwc3 {
>  	maximum-speed = "high-speed";
>  	dr_mode = "peripheral";
> +
> +	phys = <&usb_hsphy>;
> +	phy-names = "usb2-phy";
>  };
>  
>  &usb_hsphy {
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index e4ce135264f3d..030763187cc3f 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -579,6 +579,39 @@ usb_hsphy: phy@1613000 {
>  			status = "disabled";
>  		};
>  
> +		usb_qmpphy: phy@1615000 {
> +			compatible = "qcom,sm6115-qmp-usb3-phy";
> +			reg = <0x01615000 0x200>;
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +				 <&gcc GCC_AHB2PHY_USB_CLK>;
> +			clock-names = "com_aux",
> +				      "ref",
> +				      "cfg_ahb";
> +			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
> +				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
> +			reset-names = "phy", "phy_phy";
> +			status = "disabled";
> +			#clock-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			usb_ssphy: phy@1615200 {

These patches looks good, but before introducing any
qcom,sm6115-qmp-usb3-phy in any DT, could we please update the binding
and driver to the new flattened format - to avoid having to revisit this
when we try to introduce DP (which I'm guessing this instance has?)

Regards,
Bjorn

> +				reg = <0x01615200 0x200>,
> +				      <0x01615400 0x200>,
> +				      <0x01615c00 0x400>,
> +				      <0x01615600 0x200>,
> +				      <0x01615800 0x200>,
> +				      <0x01615a00 0x100>;
> +				#phy-cells = <0>;
> +				#clock-cells = <1>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};
> +		};
> +
>  		qfprom@1b40000 {
>  			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
>  			reg = <0x01b40000 0x7000>;
> @@ -1023,8 +1056,8 @@ usb_dwc3: usb@4e00000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x04e00000 0xcd00>;
>  				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> -				phys = <&usb_hsphy>;
> -				phy-names = "usb2-phy";
> +				phys = <&usb_hsphy>, <&usb_ssphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
>  				iommus = <&apps_smmu 0x120 0x0>;
>  				snps,dis_u2_susphy_quirk;
>  				snps,dis_enblslpm_quirk;
> -- 
> 2.38.1
> 
