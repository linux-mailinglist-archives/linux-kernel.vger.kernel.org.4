Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CA4704C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjEPLNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjEPLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:12:45 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2668065B6
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:11:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3078c092056so7495246f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 04:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1684235439; x=1686827439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioKORldIiYtB2SsGKnyxrBw0xwGmK5RidmBBlL5Ztds=;
        b=40g2ESP3KvxEEYuVtdIXFyMVaWbC1e7CZd1xVEqbSAkTCEUtoem9DC0tYoJW4uRXQQ
         48Qixe8+UYVFllhjeqX3m45D+820Ig2NvrNRGs8DfDLYZ9vA0+x6IXrTjuaHU0kWXZ9A
         bABF4AKGh1gBzJXTQ+FNckD3xPvPwQ1bLpwxOO1db1fVd4JD+X/dezTBXDH5FjB2CfKv
         bnXBsmhqLKIU3MTz1z/sPbI/ycX0KrIn7uB4K5GitA6vUtVrqju8pKahtdpWmOFZnCxM
         n2339rx66eyunXwUWDFq1Q00DEJjnwPDFSHWTFs6CZBLHP44V80PV+YU1gUpBdvnpcmU
         OaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684235439; x=1686827439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ioKORldIiYtB2SsGKnyxrBw0xwGmK5RidmBBlL5Ztds=;
        b=JwJqS0UWrbkMls/jyKAk+HuB7ewKcGpR0Tm5b14kZcCoZr4FhmpxU6FDYcNH4MUOFn
         f6XoERXa7cuDccD61jwucQnfJSnJ6BJDY6Gp/nd9X7wjCEMKd9+i9G+/wLyHSO6hMdQP
         et62uGNiZJIuUOv2JDnvXzoA0I5kVcw30X4k+6hhXCchX9oNQ8TpvdVBoBJB63aJhdwd
         4kLjA6NgAIfn9isCbIGcfrkD7a8SXsHyYDUb8oHiA4MURPfMc9dVYEr7MWbnf4ShkHao
         hDbk81/BEZtEcrjsN3fEinPU/SR+BAQ+ZFzRUEXpbCfuoCcnVgze8diG+n8idWPRscSm
         RHvQ==
X-Gm-Message-State: AC+VfDyXX1PgjExSDs1juOqRo2+Gtne4ejpCPHs9tA37KN2IR2hh6n86
        i816PDMbSYX5xAMvQ6HDueQCqg==
X-Google-Smtp-Source: ACHHUZ5R6+MuvE6h14q57HcZGLB0AA9F4N+zYdvtEsrXQsbxZuCoO7tuvAUaio+gGs0oh0bRHN7INA==
X-Received: by 2002:adf:f344:0:b0:308:d687:c1f9 with SMTP id e4-20020adff344000000b00308d687c1f9mr10930163wrp.63.1684235439550;
        Tue, 16 May 2023 04:10:39 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d63c5000000b003090cb7a9e6sm2262351wrw.31.2023.05.16.04.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 04:10:38 -0700 (PDT)
Message-ID: <ceda3aab-067a-caf3-2f95-5724ef1b18d0@monstr.eu>
Date:   Tue, 16 May 2023 13:10:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 23/23] arm64: zynqmp: Add phase tags marking
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <cover.1683034376.git.michal.simek@amd.com>
 <48b554aef75d11e6ad2ef7d21f22accb35432112.1683034376.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <48b554aef75d11e6ad2ef7d21f22accb35432112.1683034376.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/23 15:35, Michal Simek wrote:
> bootph-all as phase tag was added to dt-schema
> (dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
> That's why add it also to Linux to be aligned with bootloader requirement.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi    |  6 ++++++
>   arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts |  3 +++
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi            | 12 ++++++++++++
>   3 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> index 581221fdadf1..719ea5d5ae88 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> @@ -11,30 +11,35 @@
>   #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>   / {
>   	pss_ref_clk: pss_ref_clk {
> +		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <33333333>;
>   	};
>   
>   	video_clk: video_clk {
> +		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
>   	};
>   
>   	pss_alt_ref_clk: pss_alt_ref_clk {
> +		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <0>;
>   	};
>   
>   	gt_crx_ref_clk: gt_crx_ref_clk {
> +		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <108000000>;
>   	};
>   
>   	aux_ref_clk: aux_ref_clk {
> +		bootph-all;
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
>   		clock-frequency = <27000000>;
> @@ -43,6 +48,7 @@ aux_ref_clk: aux_ref_clk {
>   
>   &zynqmp_firmware {
>   	zynqmp_clk: clock-controller {
> +		bootph-all;
>   		#clock-cells = <1>;
>   		compatible = "xlnx,zynqmp-clk";
>   		clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>,
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> index 78ff6a9b3144..8afdf4408a78 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
> @@ -243,17 +243,20 @@ tpm@0 { /* slm9670 - U144 */
>   
>   &i2c1 {
>   	status = "okay";
> +	bootph-all;
>   	clock-frequency = <400000>;
>   	scl-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
>   	sda-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
>   
>   	eeprom: eeprom@50 { /* u46 - also at address 0x58 */
> +		bootph-all;
>   		compatible = "st,24c64", "atmel,24c64"; /* st m24c64 */
>   		reg = <0x50>;
>   		/* WP pin EE_WP_EN connected to slg7x644092@68 */
>   	};
>   
>   	eeprom_cc: eeprom@51 { /* required by spec - also at address 0x59 */
> +		bootph-all;
>   		compatible = "st,24c64", "atmel,24c64"; /* st m24c64 */
>   		reg = <0x51>;
>   	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index d01d4334c95f..51b8349dcacd 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -127,6 +127,7 @@ rproc_1_fw_image: memory@3ef00000 {
>   	};
>   
>   	zynqmp_ipi: zynqmp_ipi {
> +		bootph-all;
>   		compatible = "xlnx,zynqmp-ipi-mailbox";
>   		interrupt-parent = <&gic>;
>   		interrupts = <0 35 4>;
> @@ -136,6 +137,7 @@ zynqmp_ipi: zynqmp_ipi {
>   		ranges;
>   
>   		ipi_mailbox_pmu1: mailbox@ff9905c0 {
> +			bootph-all;
>   			reg = <0x0 0xff9905c0 0x0 0x20>,
>   			      <0x0 0xff9905e0 0x0 0x20>,
>   			      <0x0 0xff990e80 0x0 0x20>,
> @@ -152,6 +154,7 @@ ipi_mailbox_pmu1: mailbox@ff9905c0 {
>   	dcc: dcc {
>   		compatible = "arm,dcc";
>   		status = "disabled";
> +		bootph-all;
>   	};
>   
>   	pmu {
> @@ -177,8 +180,10 @@ zynqmp_firmware: zynqmp-firmware {
>   			compatible = "xlnx,zynqmp-firmware";
>   			#power-domain-cells = <1>;
>   			method = "smc";
> +			bootph-all;
>   
>   			zynqmp_power: zynqmp-power {
> +				bootph-all;
>   				compatible = "xlnx,zynqmp-power";
>   				interrupt-parent = <&gic>;
>   				interrupts = <0 35 4>;
> @@ -258,6 +263,7 @@ r5f-1 {
>   
>   	amba: axi {
>   		compatible = "simple-bus";
> +		bootph-all;
>   		#address-cells = <2>;
>   		#size-cells = <2>;
>   		ranges;
> @@ -699,6 +705,7 @@ pcie_intc: legacy-interrupt-controller {
>   		};
>   
>   		qspi: spi@ff0f0000 {
> +			bootph-all;
>   			compatible = "xlnx,zynqmp-qspi-1.0";
>   			status = "disabled";
>   			clock-names = "ref_clk", "pclk";
> @@ -745,6 +752,7 @@ sata: ahci@fd0c0000 {
>   		};
>   
>   		sdhci0: mmc@ff160000 {
> +			bootph-all;
>   			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> @@ -759,6 +767,7 @@ sdhci0: mmc@ff160000 {
>   		};
>   
>   		sdhci1: mmc@ff170000 {
> +			bootph-all;
>   			compatible = "xlnx,zynqmp-8.9a", "arasan,sdhci-8.9a";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> @@ -851,6 +860,7 @@ ttc3: timer@ff140000 {
>   		};
>   
>   		uart0: serial@ff000000 {
> +			bootph-all;
>   			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> @@ -861,6 +871,7 @@ uart0: serial@ff000000 {
>   		};
>   
>   		uart1: serial@ff010000 {
> +			bootph-all;
>   			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
>   			status = "disabled";
>   			interrupt-parent = <&gic>;
> @@ -982,6 +993,7 @@ zynqmp_dpdma: dma-controller@fd4c0000 {
>   		};
>   
>   		zynqmp_dpsub: display@fd4a0000 {
> +			bootph-all;
>   			compatible = "xlnx,zynqmp-dpsub-1.7";
>   			status = "disabled";
>   			reg = <0x0 0xfd4a0000 0x0 0x1000>,

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs

