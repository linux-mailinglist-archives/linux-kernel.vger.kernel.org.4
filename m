Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ACB6DB2AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjDGSRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjDGSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C1D6A53;
        Fri,  7 Apr 2023 11:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E2E561185;
        Fri,  7 Apr 2023 18:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5E2C433D2;
        Fri,  7 Apr 2023 18:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680891418;
        bh=nlGs0z60ePPeH9ynWhO9z3Rb6vbWuERkglpKDbMvf+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Son3MB9M+oY3QMchIgnPKi2xqLCX2gUY4KncD/Q6Z1OhuQrUYt8/OosXyAinfKq+S
         +dOjChSqfTgDxckIm4nIhGAHTb5iuAkeCEQKEWbfbQ5e7n42jQm2YXKaIdX4rpwVGC
         uOf3uVK4f5Wn1GJADEDgUzjtfBnCwLEE0AdonX9D+RZwCsLFhMhVtlimP2Hau5Ko9t
         Jot0Kwib3/r0oZ0V/pWoWwlTB+IZcR676tx0IyKmoOqSWFaVm9h39hHBOF2XzD3j+7
         KCuk7wznRxjtGktcUI+Kkpd9b4WpJnlI6kZbTjBMXOQKVYVa8Y8oWY80ML3IGPW/1J
         6SzJ8/O8AuOCA==
Date:   Fri, 7 Apr 2023 11:19:48 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, kishon@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
Message-ID: <20230407181948.4oetuqojeylpnaij@ripper>
References: <20230407061122.2036838-1-bhupesh.sharma@linaro.org>
 <20230407061122.2036838-3-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407061122.2036838-3-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 11:41:22AM +0530, Bhupesh Sharma wrote:
> Add USB superspeed qmp phy node to dtsi.
> 
> Make sure that the various board dts files (which include sm4250.dtsi file)
> continue to work as intended.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  |  3 ++
>  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 36 +++++++++++++++++--
>  .../boot/dts/qcom/sm6115p-lenovo-j606f.dts    |  3 ++
>  3 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> index a1f0622db5a0..75951fd439df 100644
> --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -242,6 +242,9 @@ &usb {
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
> index 2505c815c65a..f42065a0a71d 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -651,6 +651,38 @@ usb_hsphy: phy@1613000 {
>  			status = "disabled";
>  		};
>  
> +		usb_qmpphy: phy@1615000 {
> +			compatible = "qcom,sm6115-qmp-usb3-phy";
> +			reg = <0x0 0x01615000 0x0 0x200>;
> +			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
> +				 <&gcc GCC_USB3_PRIM_CLKREF_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +			clock-names = "cfg_ahb",
> +				      "ref",
> +				      "com_aux";
> +			resets = <&gcc GCC_USB3_PHY_PRIM_SP0_BCR>,
> +				 <&gcc GCC_USB3PHY_PHY_PRIM_SP0_BCR>;
> +			reset-names = "phy", "phy_phy";
> +			status = "disabled";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			usb_ssphy: phy@1615200 {

Please don't introduce the old-style QMP binding in new platforms.

Thanks,
Bjorn

> +				reg = <0x0 0x01615200 0x0 0x200>,
> +				      <0x0 0x01615400 0x0 0x200>,
> +				      <0x0 0x01615c00 0x0 0x400>,
> +				      <0x0 0x01615600 0x0 0x200>,
> +				      <0x0 0x01615800 0x0 0x200>,
> +				      <0x0 0x01615a00 0x0 0x100>;
> +				#clock-cells = <0>;
> +				#phy-cells = <0>;
> +				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "usb3_phy_pipe_clk_src";
> +			};
> +		};
> +
>  		qfprom@1b40000 {
>  			compatible = "qcom,sm6115-qfprom", "qcom,qfprom";
>  			reg = <0x0 0x01b40000 0x0 0x7000>;
> @@ -1101,8 +1133,8 @@ usb_dwc3: usb@4e00000 {
>  				compatible = "snps,dwc3";
>  				reg = <0x0 0x04e00000 0x0 0xcd00>;
>  				interrupts = <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> -				phys = <&usb_hsphy>;
> -				phy-names = "usb2-phy";
> +				phys = <&usb_hsphy>, <&usb_ssphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
>  				iommus = <&apps_smmu 0x120 0x0>;
>  				snps,dis_u2_susphy_quirk;
>  				snps,dis_enblslpm_quirk;
> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> index 10c9d338446c..d60cc024749b 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> @@ -280,6 +280,9 @@ &usb {
>  &usb_dwc3 {
>  	maximum-speed = "high-speed";
>  	dr_mode = "peripheral";
> +
> +	phys = <&usb_hsphy>;
> +	phy-names = "usb2-phy";
>  };
>  
>  &usb_hsphy {
> -- 
> 2.38.1
> 
