Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5602B5B7F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiINDhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiINDhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:37:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42860535;
        Tue, 13 Sep 2022 20:37:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7553261752;
        Wed, 14 Sep 2022 03:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CB1C433C1;
        Wed, 14 Sep 2022 03:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663126624;
        bh=yJ3yDkdxZx2loVLO2JY++ISjZACeSPCcR5N0J+v4ZhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XtFNTOyBknX7XIRuYJO94jZcsiZ1/eGlG3OwH2AoPcA81I8+GvIwKP08681duWcSA
         xf3IpqzoEUggrIX52fEUXZHv8CzPsB3Jy7x1VcTg5XLixid60/7oJ1X+DqL7IY8Q1H
         hZwnQzs9y7nExrR9fbrTadGCwpcaXK3Eaw9sk/FJYrRSFRaxEb9Lb+blF5XOS9uqw4
         yIcKGph3qSowbCaY87K2SZVNwWY6GWZ8rWi5REMLMXIE/ebKIIwWj34osu8xqNwcH+
         Pjb2SuaVf7jcgqHOJ6K2iNt6ZYNb/iVbN4F4L0rGOrz5CcrHVKIjJiPYC982O+9mXa
         aMQjCKZPoUIcg==
Date:   Tue, 13 Sep 2022 22:37:02 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: qcom: ipq8064: reorganize node order and
 sort them
Message-ID: <20220914033702.6qa7z22r6xn26upx@builder.lan>
References: <20220718153815.29414-1-ansuelsmth@gmail.com>
 <62f16c3b.5d0a0220.d6df3.ca92@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62f16c3b.5d0a0220.d6df3.ca92@mx.google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 04:07:42PM +0200, Christian Marangi wrote:
> On Mon, Jul 18, 2022 at 05:38:14PM +0200, Christian Marangi wrote:
> > Reorganize node order and sort them by address.
> >
> 
> So how to proceed with this? Should I send v2 with the changes pointed
> (stuff with no reg outside soc) or it's a NACK for the unnecessary
> changes?
> 
> I feel a bit stuck.
> 

Afaict the pieces pointed out existed before the shuffle as well, so
I've merged the two patches. Please submit additional cleanups on top.

Thank you,
Bjorn

> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > 
> > This was picked from for-next qcom branch [1]. Reorganize dtsi as requested.
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/?h=for-next
> > 
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 766 ++++++++++++++--------------
> >  1 file changed, 383 insertions(+), 383 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index da90f7c08d75..cf41d330c920 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -332,19 +332,59 @@ soc: soc {
> >  		ranges;
> >  		compatible = "simple-bus";
> >  
> > -		lpass@28100000 {
> > -			compatible = "qcom,lpass-cpu";
> > -			status = "disabled";
> > -			clocks = <&lcc AHBIX_CLK>,
> > -					<&lcc MI2S_OSR_CLK>,
> > -					<&lcc MI2S_BIT_CLK>;
> > -			clock-names = "ahbix-clk",
> > -					"mi2s-osr-clk",
> > -					"mi2s-bit-clk";
> > -			interrupts = <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>;
> > -			interrupt-names = "lpass-irq-lpaif";
> > -			reg = <0x28100000 0x10000>;
> > -			reg-names = "lpass-lpaif";
> > +		stmmac_axi_setup: stmmac-axi-config {
> > +			snps,wr_osr_lmt = <7>;
> > +			snps,rd_osr_lmt = <7>;
> > +			snps,blen = <16 0 0 0 0 0 0>;
> > +		};
> > +
> > +		vsdcc_fixed: vsdcc-regulator {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "SDCC Power";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			regulator-always-on;
> > +		};
> > +
> > +		rpm: rpm@108000 {
> > +			compatible = "qcom,rpm-ipq8064";
> > +			reg = <0x108000 0x1000>;
> > +			qcom,ipc = <&l2cc 0x8 2>;
> > +
> > +			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> > +					<GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-names = "ack", "err", "wakeup";
> > +
> > +			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
> > +			clock-names = "ram";
> > +
> > +			rpmcc: clock-controller {
> > +				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
> > +				#clock-cells = <1>;
> > +			};
> > +		};
> > +
> > +		qcom,ssbi@500000 {
> > +			compatible = "qcom,ssbi";
> > +			reg = <0x00500000 0x1000>;
> > +			qcom,controller-type = "pmic-arbiter";
> > +		};
> > +
> > +		qfprom: qfprom@700000 {
> > +			compatible = "qcom,ipq8064-qfprom", "qcom,qfprom";
> > +			reg = <0x00700000 0x1000>;
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			speedbin_efuse: speedbin@c0 {
> > +				reg = <0xc0 0x4>;
> > +			};
> > +			tsens_calib: calib@400 {
> > +				reg = <0x400 0xb>;
> > +			};
> > +			tsens_calib_backup: calib_backup@410 {
> > +				reg = <0x410 0xb>;
> > +			};
> >  		};
> >  
> >  		qcom_pinmux: pinmux@800000 {
> > @@ -471,6 +511,35 @@ mux {
> >  			};
> >  		};
> >  
> > +		gcc: clock-controller@900000 {
> > +			compatible = "qcom,gcc-ipq8064", "syscon";
> > +			clocks = <&pxo_board>, <&cxo_board>;
> > +			clock-names = "pxo", "cxo";
> > +			reg = <0x00900000 0x4000>;
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +			#power-domain-cells = <1>;
> > +
> > +			tsens: thermal-sensor@900000 {
> > +				compatible = "qcom,ipq8064-tsens";
> > +
> > +				nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
> > +				nvmem-cell-names = "calib", "calib_backup";
> > +				interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> > +				interrupt-names = "uplow";
> > +
> > +				#qcom,sensors = <11>;
> > +				#thermal-sensor-cells = <1>;
> > +			};
> > +		};
> > +
> > +		sfpb_mutex: hwlock@1200600 {
> > +			compatible = "qcom,sfpb-mutex";
> > +			reg = <0x01200600 0x100>;
> > +
> > +			#hwlock-cells = <1>;
> > +		};
> > +
> >  		intc: interrupt-controller@2000000 {
> >  			compatible = "qcom,msm-qgic2";
> >  			interrupt-controller;
> > @@ -500,46 +569,198 @@ IRQ_TYPE_EDGE_RISING)>,
> >  			cpu-offset = <0x80000>;
> >  		};
> >  
> > +		l2cc: clock-controller@2011000 {
> > +			compatible = "qcom,kpss-gcc", "syscon";
> > +			reg = <0x2011000 0x1000>;
> > +			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> > +			clock-names = "pll8_vote", "pxo";
> > +			clock-output-names = "acpu_l2_aux";
> > +		};
> > +
> >  		acc0: clock-controller@2088000 {
> >  			compatible = "qcom,kpss-acc-v1";
> >  			reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> >  		};
> >  
> > +		saw0: regulator@2089000 {
> > +			compatible = "qcom,saw2";
> > +			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
> > +			regulator;
> > +		};
> > +
> >  		acc1: clock-controller@2098000 {
> >  			compatible = "qcom,kpss-acc-v1";
> >  			reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
> >  		};
> >  
> > -		adm_dma: dma-controller@18300000 {
> > -			compatible = "qcom,adm";
> > -			reg = <0x18300000 0x100000>;
> > -			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> > -			#dma-cells = <1>;
> > +		saw1: regulator@2099000 {
> > +			compatible = "qcom,saw2";
> > +			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
> > +			regulator;
> > +		};
> >  
> > -			clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
> > -			clock-names = "core", "iface";
> > +		nss_common: syscon@03000000 {
> > +			compatible = "syscon";
> > +			reg = <0x03000000 0x0000FFFF>;
> > +		};
> >  
> > -			resets = <&gcc ADM0_RESET>,
> > -				 <&gcc ADM0_PBUS_RESET>,
> > -				 <&gcc ADM0_C0_RESET>,
> > -				 <&gcc ADM0_C1_RESET>,
> > -				 <&gcc ADM0_C2_RESET>;
> > -			reset-names = "clk", "pbus", "c0", "c1", "c2";
> > -			qcom,ee = <0>;
> > +		usb3_0: usb3@100f8800 {
> > +			compatible = "qcom,ipq8064-dwc3", "qcom,dwc3";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			reg = <0x100f8800 0x8000>;
> > +			clocks = <&gcc USB30_0_MASTER_CLK>;
> > +			clock-names = "core";
> > +
> > +			ranges;
> > +
> > +			resets = <&gcc USB30_0_MASTER_RESET>;
> > +			reset-names = "master";
> >  
> >  			status = "disabled";
> > +
> > +			dwc3_0: dwc3@10000000 {
> > +				compatible = "snps,dwc3";
> > +				reg = <0x10000000 0xcd00>;
> > +				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
> > +				phys = <&hs_phy_0>, <&ss_phy_0>;
> > +				phy-names = "usb2-phy", "usb3-phy";
> > +				dr_mode = "host";
> > +				snps,dis_u3_susphy_quirk;
> > +			};
> >  		};
> >  
> > -		saw0: regulator@2089000 {
> > -			compatible = "qcom,saw2";
> > -			reg = <0x02089000 0x1000>, <0x02009000 0x1000>;
> > -			regulator;
> > +		hs_phy_0: phy@100f8800 {
> > +			compatible = "qcom,ipq806x-usb-phy-hs";
> > +			reg = <0x100f8800 0x30>;
> > +			clocks = <&gcc USB30_0_UTMI_CLK>;
> > +			clock-names = "ref";
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> >  		};
> >  
> > -		saw1: regulator@2099000 {
> > -			compatible = "qcom,saw2";
> > -			reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
> > -			regulator;
> > +		ss_phy_0: phy@100f8830 {
> > +			compatible = "qcom,ipq806x-usb-phy-ss";
> > +			reg = <0x100f8830 0x30>;
> > +			clocks = <&gcc USB30_0_MASTER_CLK>;
> > +			clock-names = "ref";
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		usb3_1: usb3@110f8800 {
> > +			compatible = "qcom,ipq8064-dwc3", "qcom,dwc3";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			reg = <0x110f8800 0x8000>;
> > +			clocks = <&gcc USB30_1_MASTER_CLK>;
> > +			clock-names = "core";
> > +
> > +			ranges;
> > +
> > +			resets = <&gcc USB30_1_MASTER_RESET>;
> > +			reset-names = "master";
> > +
> > +			status = "disabled";
> > +
> > +			dwc3_1: dwc3@11000000 {
> > +				compatible = "snps,dwc3";
> > +				reg = <0x11000000 0xcd00>;
> > +				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> > +				phys = <&hs_phy_1>, <&ss_phy_1>;
> > +				phy-names = "usb2-phy", "usb3-phy";
> > +				dr_mode = "host";
> > +				snps,dis_u3_susphy_quirk;
> > +			};
> > +		};
> > +
> > +		hs_phy_1: phy@110f8800 {
> > +			compatible = "qcom,ipq806x-usb-phy-hs";
> > +			reg = <0x110f8800 0x30>;
> > +			clocks = <&gcc USB30_1_UTMI_CLK>;
> > +			clock-names = "ref";
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		ss_phy_1: phy@110f8830 {
> > +			compatible = "qcom,ipq806x-usb-phy-ss";
> > +			reg = <0x110f8830 0x30>;
> > +			clocks = <&gcc USB30_1_MASTER_CLK>;
> > +			clock-names = "ref";
> > +			#phy-cells = <0>;
> > +
> > +			status = "disabled";
> > +		};
> > +
> > +		sdcc3bam: dma-controller@12182000 {
> > +			compatible = "qcom,bam-v1.3.0";
> > +			reg = <0x12182000 0x8000>;
> > +			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&gcc SDC3_H_CLK>;
> > +			clock-names = "bam_clk";
> > +			#dma-cells = <1>;
> > +			qcom,ee = <0>;
> > +		};
> > +
> > +		sdcc1bam: dma-controller@12402000 {
> > +			compatible = "qcom,bam-v1.3.0";
> > +			reg = <0x12402000 0x8000>;
> > +			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&gcc SDC1_H_CLK>;
> > +			clock-names = "bam_clk";
> > +			#dma-cells = <1>;
> > +			qcom,ee = <0>;
> > +		};
> > +
> > +		amba: amba {
> > +			compatible = "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges;
> > +
> > +			sdcc3: mmc@12180000 {
> > +				compatible = "arm,pl18x", "arm,primecell";
> > +				arm,primecell-periphid = <0x00051180>;
> > +				status = "disabled";
> > +				reg = <0x12180000 0x2000>;
> > +				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> > +				interrupt-names = "cmd_irq";
> > +				clocks = <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
> > +				clock-names = "mclk", "apb_pclk";
> > +				bus-width = <8>;
> > +				cap-sd-highspeed;
> > +				cap-mmc-highspeed;
> > +				max-frequency = <192000000>;
> > +				sd-uhs-sdr104;
> > +				sd-uhs-ddr50;
> > +				vqmmc-supply = <&vsdcc_fixed>;
> > +				dmas = <&sdcc3bam 2>, <&sdcc3bam 1>;
> > +				dma-names = "tx", "rx";
> > +			};
> > +
> > +			sdcc1: mmc@12400000 {
> > +				status = "disabled";
> > +				compatible = "arm,pl18x", "arm,primecell";
> > +				arm,primecell-periphid = <0x00051180>;
> > +				reg = <0x12400000 0x2000>;
> > +				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> > +				interrupt-names = "cmd_irq";
> > +				clocks = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
> > +				clock-names = "mclk", "apb_pclk";
> > +				bus-width = <8>;
> > +				max-frequency = <96000000>;
> > +				non-removable;
> > +				cap-sd-highspeed;
> > +				cap-mmc-highspeed;
> > +				mmc-ddr-1_8v;
> > +				vmmc-supply = <&vsdcc_fixed>;
> > +				dmas = <&sdcc1bam 2>, <&sdcc1bam 1>;
> > +				dma-names = "tx", "rx";
> > +			};
> >  		};
> >  
> >  		gsbi1: gsbi@12440000 {
> > @@ -654,56 +875,6 @@ i2c@16380000 {
> >  			};
> >  		};
> >  
> > -		gsbi5: gsbi@1a200000 {
> > -			compatible = "qcom,gsbi-v1.0.0";
> > -			cell-index = <5>;
> > -			reg = <0x1a200000 0x100>;
> > -			clocks = <&gcc GSBI5_H_CLK>;
> > -			clock-names = "iface";
> > -			#address-cells = <1>;
> > -			#size-cells = <1>;
> > -			ranges;
> > -			status = "disabled";
> > -
> > -			syscon-tcsr = <&tcsr>;
> > -
> > -			gsbi5_serial: serial@1a240000 {
> > -				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
> > -				reg = <0x1a240000 0x1000>,
> > -				      <0x1a200000 0x1000>;
> > -				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> > -				clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
> > -				clock-names = "core", "iface";
> > -				status = "disabled";
> > -			};
> > -
> > -			i2c@1a280000 {
> > -				compatible = "qcom,i2c-qup-v1.1.1";
> > -				reg = <0x1a280000 0x1000>;
> > -				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> > -
> > -				clocks = <&gcc GSBI5_QUP_CLK>, <&gcc GSBI5_H_CLK>;
> > -				clock-names = "core", "iface";
> > -				status = "disabled";
> > -
> > -				#address-cells = <1>;
> > -				#size-cells = <0>;
> > -			};
> > -
> > -			spi@1a280000 {
> > -				compatible = "qcom,spi-qup-v1.1.1";
> > -				reg = <0x1a280000 0x1000>;
> > -				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> > -
> > -				clocks = <&gcc GSBI5_QUP_CLK>, <&gcc GSBI5_H_CLK>;
> > -				clock-names = "core", "iface";
> > -				status = "disabled";
> > -
> > -				#address-cells = <1>;
> > -				#size-cells = <0>;
> > -			};
> > -		};
> > -
> >  		gsbi6: gsbi@16500000 {
> >  			compatible = "qcom,gsbi-v1.0.0";
> >  			reg = <0x16500000 0x100>;
> > @@ -784,149 +955,119 @@ gsbi7_i2c: i2c@16680000 {
> >  			};
> >  		};
> >  
> > -		rng@1a500000 {
> > -			compatible = "qcom,prng";
> > -			reg = <0x1a500000 0x200>;
> > -			clocks = <&gcc PRNG_CLK>;
> > -			clock-names = "core";
> > -		};
> > +		adm_dma: dma-controller@18300000 {
> > +			compatible = "qcom,adm";
> > +			reg = <0x18300000 0x100000>;
> > +			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> > +			#dma-cells = <1>;
> >  
> > -		sata_phy: sata-phy@1b400000 {
> > -			compatible = "qcom,ipq806x-sata-phy";
> > -			reg = <0x1b400000 0x200>;
> > +			clocks = <&gcc ADM0_CLK>, <&gcc ADM0_PBUS_CLK>;
> > +			clock-names = "core", "iface";
> >  
> > -			clocks = <&gcc SATA_PHY_CFG_CLK>;
> > -			clock-names = "cfg";
> > +			resets = <&gcc ADM0_RESET>,
> > +				 <&gcc ADM0_PBUS_RESET>,
> > +				 <&gcc ADM0_C0_RESET>,
> > +				 <&gcc ADM0_C1_RESET>,
> > +				 <&gcc ADM0_C2_RESET>;
> > +			reset-names = "clk", "pbus", "c0", "c1", "c2";
> > +			qcom,ee = <0>;
> >  
> > -			#phy-cells = <0>;
> >  			status = "disabled";
> >  		};
> >  
> > -		nand: nand-controller@1ac00000 {
> > -			compatible = "qcom,ipq806x-nand";
> > -			reg = <0x1ac00000 0x800>;
> > -
> > -			pinctrl-0 = <&nand_pins>;
> > -			pinctrl-names = "default";
> > -
> > -			clocks = <&gcc EBI2_CLK>,
> > -				 <&gcc EBI2_AON_CLK>;
> > -			clock-names = "core", "aon";
> > -
> > -			dmas = <&adm_dma 3>;
> > -			dma-names = "rxtx";
> > -			qcom,cmd-crci = <15>;
> > -			qcom,data-crci = <3>;
> > -
> > +		gsbi5: gsbi@1a200000 {
> > +			compatible = "qcom,gsbi-v1.0.0";
> > +			cell-index = <5>;
> > +			reg = <0x1a200000 0x100>;
> > +			clocks = <&gcc GSBI5_H_CLK>;
> > +			clock-names = "iface";
> >  			#address-cells = <1>;
> > -			#size-cells = <0>;
> > -
> > +			#size-cells = <1>;
> > +			ranges;
> >  			status = "disabled";
> > -		};
> >  
> > -		sata: sata@29000000 {
> > -			compatible = "qcom,ipq806x-ahci", "generic-ahci";
> > -			reg = <0x29000000 0x180>;
> > +			syscon-tcsr = <&tcsr>;
> >  
> > -			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> > +			gsbi5_serial: serial@1a240000 {
> > +				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
> > +				reg = <0x1a240000 0x1000>,
> > +				      <0x1a200000 0x1000>;
> > +				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> > +				clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
> > +				clock-names = "core", "iface";
> > +				status = "disabled";
> > +			};
> >  
> > -			clocks = <&gcc SFAB_SATA_S_H_CLK>,
> > -				 <&gcc SATA_H_CLK>,
> > -				 <&gcc SATA_A_CLK>,
> > -				 <&gcc SATA_RXOOB_CLK>,
> > -				 <&gcc SATA_PMALIVE_CLK>;
> > -			clock-names = "slave_face", "iface", "core",
> > -					"rxoob", "pmalive";
> > +			i2c@1a280000 {
> > +				compatible = "qcom,i2c-qup-v1.1.1";
> > +				reg = <0x1a280000 0x1000>;
> > +				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> >  
> > -			assigned-clocks = <&gcc SATA_RXOOB_CLK>, <&gcc SATA_PMALIVE_CLK>;
> > -			assigned-clock-rates = <100000000>, <100000000>;
> > +				clocks = <&gcc GSBI5_QUP_CLK>, <&gcc GSBI5_H_CLK>;
> > +				clock-names = "core", "iface";
> > +				status = "disabled";
> >  
> > -			phys = <&sata_phy>;
> > -			phy-names = "sata-phy";
> > -			status = "disabled";
> > -		};
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +			};
> >  
> > -		qcom,ssbi@500000 {
> > -			compatible = "qcom,ssbi";
> > -			reg = <0x00500000 0x1000>;
> > -			qcom,controller-type = "pmic-arbiter";
> > -		};
> > +			spi@1a280000 {
> > +				compatible = "qcom,spi-qup-v1.1.1";
> > +				reg = <0x1a280000 0x1000>;
> > +				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> >  
> > -		qfprom: qfprom@700000 {
> > -			compatible = "qcom,ipq8064-qfprom", "qcom,qfprom";
> > -			reg = <0x00700000 0x1000>;
> > -			#address-cells = <1>;
> > -			#size-cells = <1>;
> > -			speedbin_efuse: speedbin@c0 {
> > -				reg = <0xc0 0x4>;
> > -			};
> > -			tsens_calib: calib@400 {
> > -				reg = <0x400 0xb>;
> > -			};
> > -			tsens_calib_backup: calib_backup@410 {
> > -				reg = <0x410 0xb>;
> > +				clocks = <&gcc GSBI5_QUP_CLK>, <&gcc GSBI5_H_CLK>;
> > +				clock-names = "core", "iface";
> > +				status = "disabled";
> > +
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> >  			};
> >  		};
> >  
> > -		gcc: clock-controller@900000 {
> > -			compatible = "qcom,gcc-ipq8064", "syscon";
> > -			clocks = <&pxo_board>, <&cxo_board>;
> > -			clock-names = "pxo", "cxo";
> > -			reg = <0x00900000 0x4000>;
> > -			#clock-cells = <1>;
> > -			#reset-cells = <1>;
> > -			#power-domain-cells = <1>;
> > -
> > -			tsens: thermal-sensor@900000 {
> > -				compatible = "qcom,ipq8064-tsens";
> > -
> > -				nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
> > -				nvmem-cell-names = "calib", "calib_backup";
> > -				interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> > -				interrupt-names = "uplow";
> > +		tcsr: syscon@1a400000 {
> > +			compatible = "qcom,tcsr-ipq8064", "syscon";
> > +			reg = <0x1a400000 0x100>;
> > +		};
> >  
> > -				#qcom,sensors = <11>;
> > -				#thermal-sensor-cells = <1>;
> > -			};
> > +		rng@1a500000 {
> > +			compatible = "qcom,prng";
> > +			reg = <0x1a500000 0x200>;
> > +			clocks = <&gcc PRNG_CLK>;
> > +			clock-names = "core";
> >  		};
> >  
> > -		rpm: rpm@108000 {
> > -			compatible = "qcom,rpm-ipq8064";
> > -			reg = <0x108000 0x1000>;
> > -			qcom,ipc = <&l2cc 0x8 2>;
> > +		nand: nand-controller@1ac00000 {
> > +			compatible = "qcom,ipq806x-nand";
> > +			reg = <0x1ac00000 0x800>;
> >  
> > -			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> > -					<GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> > -					<GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> > -			interrupt-names = "ack", "err", "wakeup";
> > +			pinctrl-0 = <&nand_pins>;
> > +			pinctrl-names = "default";
> >  
> > -			clocks = <&gcc RPM_MSG_RAM_H_CLK>;
> > -			clock-names = "ram";
> > +			clocks = <&gcc EBI2_CLK>,
> > +				 <&gcc EBI2_AON_CLK>;
> > +			clock-names = "core", "aon";
> > +
> > +			dmas = <&adm_dma 3>;
> > +			dma-names = "rxtx";
> > +			qcom,cmd-crci = <15>;
> > +			qcom,data-crci = <3>;
> >  
> > -			rpmcc: clock-controller {
> > -				compatible = "qcom,rpmcc-ipq806x", "qcom,rpmcc";
> > -				#clock-cells = <1>;
> > -			};
> > -		};
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> >  
> > -		tcsr: syscon@1a400000 {
> > -			compatible = "qcom,tcsr-ipq8064", "syscon";
> > -			reg = <0x1a400000 0x100>;
> > +			status = "disabled";
> >  		};
> >  
> > -		l2cc: clock-controller@2011000 {
> > -			compatible = "qcom,kpss-gcc", "syscon";
> > -			reg = <0x2011000 0x1000>;
> > -			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> > -			clock-names = "pll8_vote", "pxo";
> > -			clock-output-names = "acpu_l2_aux";
> > -		};
> > +		sata_phy: sata-phy@1b400000 {
> > +			compatible = "qcom,ipq806x-sata-phy";
> > +			reg = <0x1b400000 0x200>;
> >  
> > -		lcc: clock-controller@28000000 {
> > -			compatible = "qcom,lcc-ipq8064";
> > -			reg = <0x28000000 0x1000>;
> > -			#clock-cells = <1>;
> > -			#reset-cells = <1>;
> > +			clocks = <&gcc SATA_PHY_CFG_CLK>;
> > +			clock-names = "cfg";
> > +
> > +			#phy-cells = <0>;
> > +			status = "disabled";
> >  		};
> >  
> >  		pcie0: pci@1b500000 {
> > @@ -1082,20 +1223,53 @@ pcie2: pci@1b900000 {
> >  			perst-gpio = <&qcom_pinmux 63 GPIO_ACTIVE_LOW>;
> >  		};
> >  
> > -		nss_common: syscon@03000000 {
> > -			compatible = "syscon";
> > -			reg = <0x03000000 0x0000FFFF>;
> > -		};
> > -
> >  		qsgmii_csr: syscon@1bb00000 {
> >  			compatible = "syscon";
> >  			reg = <0x1bb00000 0x000001FF>;
> >  		};
> >  
> > -		stmmac_axi_setup: stmmac-axi-config {
> > -			snps,wr_osr_lmt = <7>;
> > -			snps,rd_osr_lmt = <7>;
> > -			snps,blen = <16 0 0 0 0 0 0>;
> > +		lcc: clock-controller@28000000 {
> > +			compatible = "qcom,lcc-ipq8064";
> > +			reg = <0x28000000 0x1000>;
> > +			#clock-cells = <1>;
> > +			#reset-cells = <1>;
> > +		};
> > +
> > +		lpass@28100000 {
> > +			compatible = "qcom,lpass-cpu";
> > +			status = "disabled";
> > +			clocks = <&lcc AHBIX_CLK>,
> > +					<&lcc MI2S_OSR_CLK>,
> > +					<&lcc MI2S_BIT_CLK>;
> > +			clock-names = "ahbix-clk",
> > +					"mi2s-osr-clk",
> > +					"mi2s-bit-clk";
> > +			interrupts = <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>;
> > +			interrupt-names = "lpass-irq-lpaif";
> > +			reg = <0x28100000 0x10000>;
> > +			reg-names = "lpass-lpaif";
> > +		};
> > +
> > +		sata: sata@29000000 {
> > +			compatible = "qcom,ipq806x-ahci", "generic-ahci";
> > +			reg = <0x29000000 0x180>;
> > +
> > +			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +			clocks = <&gcc SFAB_SATA_S_H_CLK>,
> > +				 <&gcc SATA_H_CLK>,
> > +				 <&gcc SATA_A_CLK>,
> > +				 <&gcc SATA_RXOOB_CLK>,
> > +				 <&gcc SATA_PMALIVE_CLK>;
> > +			clock-names = "slave_face", "iface", "core",
> > +					"rxoob", "pmalive";
> > +
> > +			assigned-clocks = <&gcc SATA_RXOOB_CLK>, <&gcc SATA_PMALIVE_CLK>;
> > +			assigned-clock-rates = <100000000>, <100000000>;
> > +
> > +			phys = <&sata_phy>;
> > +			phy-names = "sata-phy";
> > +			status = "disabled";
> >  		};
> >  
> >  		gmac0: ethernet@37000000 {
> > @@ -1193,179 +1367,5 @@ gmac3: ethernet@37600000 {
> >  
> >  			status = "disabled";
> >  		};
> > -
> > -		hs_phy_0: phy@100f8800 {
> > -			compatible = "qcom,ipq806x-usb-phy-hs";
> > -			reg = <0x100f8800 0x30>;
> > -			clocks = <&gcc USB30_0_UTMI_CLK>;
> > -			clock-names = "ref";
> > -			#phy-cells = <0>;
> > -
> > -			status = "disabled";
> > -		};
> > -
> > -		ss_phy_0: phy@100f8830 {
> > -			compatible = "qcom,ipq806x-usb-phy-ss";
> > -			reg = <0x100f8830 0x30>;
> > -			clocks = <&gcc USB30_0_MASTER_CLK>;
> > -			clock-names = "ref";
> > -			#phy-cells = <0>;
> > -
> > -			status = "disabled";
> > -		};
> > -
> > -		usb3_0: usb3@100f8800 {
> > -			compatible = "qcom,ipq8064-dwc3", "qcom,dwc3";
> > -			#address-cells = <1>;
> > -			#size-cells = <1>;
> > -			reg = <0x100f8800 0x8000>;
> > -			clocks = <&gcc USB30_0_MASTER_CLK>;
> > -			clock-names = "core";
> > -
> > -			ranges;
> > -
> > -			resets = <&gcc USB30_0_MASTER_RESET>;
> > -			reset-names = "master";
> > -
> > -			status = "disabled";
> > -
> > -			dwc3_0: dwc3@10000000 {
> > -				compatible = "snps,dwc3";
> > -				reg = <0x10000000 0xcd00>;
> > -				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
> > -				phys = <&hs_phy_0>, <&ss_phy_0>;
> > -				phy-names = "usb2-phy", "usb3-phy";
> > -				dr_mode = "host";
> > -				snps,dis_u3_susphy_quirk;
> > -			};
> > -		};
> > -
> > -		hs_phy_1: phy@110f8800 {
> > -			compatible = "qcom,ipq806x-usb-phy-hs";
> > -			reg = <0x110f8800 0x30>;
> > -			clocks = <&gcc USB30_1_UTMI_CLK>;
> > -			clock-names = "ref";
> > -			#phy-cells = <0>;
> > -
> > -			status = "disabled";
> > -		};
> > -
> > -		ss_phy_1: phy@110f8830 {
> > -			compatible = "qcom,ipq806x-usb-phy-ss";
> > -			reg = <0x110f8830 0x30>;
> > -			clocks = <&gcc USB30_1_MASTER_CLK>;
> > -			clock-names = "ref";
> > -			#phy-cells = <0>;
> > -
> > -			status = "disabled";
> > -		};
> > -
> > -		usb3_1: usb3@110f8800 {
> > -			compatible = "qcom,ipq8064-dwc3", "qcom,dwc3";
> > -			#address-cells = <1>;
> > -			#size-cells = <1>;
> > -			reg = <0x110f8800 0x8000>;
> > -			clocks = <&gcc USB30_1_MASTER_CLK>;
> > -			clock-names = "core";
> > -
> > -			ranges;
> > -
> > -			resets = <&gcc USB30_1_MASTER_RESET>;
> > -			reset-names = "master";
> > -
> > -			status = "disabled";
> > -
> > -			dwc3_1: dwc3@11000000 {
> > -				compatible = "snps,dwc3";
> > -				reg = <0x11000000 0xcd00>;
> > -				interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> > -				phys = <&hs_phy_1>, <&ss_phy_1>;
> > -				phy-names = "usb2-phy", "usb3-phy";
> > -				dr_mode = "host";
> > -				snps,dis_u3_susphy_quirk;
> > -			};
> > -		};
> > -
> > -		vsdcc_fixed: vsdcc-regulator {
> > -			compatible = "regulator-fixed";
> > -			regulator-name = "SDCC Power";
> > -			regulator-min-microvolt = <3300000>;
> > -			regulator-max-microvolt = <3300000>;
> > -			regulator-always-on;
> > -		};
> > -
> > -		sdcc1bam: dma-controller@12402000 {
> > -			compatible = "qcom,bam-v1.3.0";
> > -			reg = <0x12402000 0x8000>;
> > -			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks = <&gcc SDC1_H_CLK>;
> > -			clock-names = "bam_clk";
> > -			#dma-cells = <1>;
> > -			qcom,ee = <0>;
> > -		};
> > -
> > -		sdcc3bam: dma-controller@12182000 {
> > -			compatible = "qcom,bam-v1.3.0";
> > -			reg = <0x12182000 0x8000>;
> > -			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> > -			clocks = <&gcc SDC3_H_CLK>;
> > -			clock-names = "bam_clk";
> > -			#dma-cells = <1>;
> > -			qcom,ee = <0>;
> > -		};
> > -
> > -		amba: amba {
> > -			compatible = "simple-bus";
> > -			#address-cells = <1>;
> > -			#size-cells = <1>;
> > -			ranges;
> > -
> > -			sdcc1: mmc@12400000 {
> > -				status = "disabled";
> > -				compatible = "arm,pl18x", "arm,primecell";
> > -				arm,primecell-periphid = <0x00051180>;
> > -				reg = <0x12400000 0x2000>;
> > -				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> > -				interrupt-names = "cmd_irq";
> > -				clocks = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
> > -				clock-names = "mclk", "apb_pclk";
> > -				bus-width = <8>;
> > -				max-frequency = <96000000>;
> > -				non-removable;
> > -				cap-sd-highspeed;
> > -				cap-mmc-highspeed;
> > -				mmc-ddr-1_8v;
> > -				vmmc-supply = <&vsdcc_fixed>;
> > -				dmas = <&sdcc1bam 2>, <&sdcc1bam 1>;
> > -				dma-names = "tx", "rx";
> > -			};
> > -
> > -			sdcc3: mmc@12180000 {
> > -				compatible = "arm,pl18x", "arm,primecell";
> > -				arm,primecell-periphid = <0x00051180>;
> > -				status = "disabled";
> > -				reg = <0x12180000 0x2000>;
> > -				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> > -				interrupt-names = "cmd_irq";
> > -				clocks = <&gcc SDC3_CLK>, <&gcc SDC3_H_CLK>;
> > -				clock-names = "mclk", "apb_pclk";
> > -				bus-width = <8>;
> > -				cap-sd-highspeed;
> > -				cap-mmc-highspeed;
> > -				max-frequency = <192000000>;
> > -				sd-uhs-sdr104;
> > -				sd-uhs-ddr50;
> > -				vqmmc-supply = <&vsdcc_fixed>;
> > -				dmas = <&sdcc3bam 2>, <&sdcc3bam 1>;
> > -				dma-names = "tx", "rx";
> > -			};
> > -		};
> > -
> > -		sfpb_mutex: hwlock@1200600 {
> > -			compatible = "qcom,sfpb-mutex";
> > -			reg = <0x01200600 0x100>;
> > -
> > -			#hwlock-cells = <1>;
> > -		};
> >  	};
> >  };
> > -- 
> > 2.36.1
> > 
> 
> -- 
> 	Ansuel
