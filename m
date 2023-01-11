Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A216662AD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjAKSU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjAKSU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:20:56 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584B82AD6;
        Wed, 11 Jan 2023 10:20:55 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30BIKmxj115173;
        Wed, 11 Jan 2023 12:20:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673461248;
        bh=ERjyXXS1TgiAxeAhzAc720ajMH2C1PwrFvFdo+xiD7c=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JIJ4q1iZxZlUTJXdFwn/gx8O0DHJ6k83a2gfbR5cPlW9Ae8kO6mHeHxHL3gU2TN+G
         MLWHe3sSPwCQCuGrhX63stdZ6BH1xuOgjkutUbhnp6eLH5WW+kJZzIBmhmEs07FrQE
         SI7MGUfGYSoNEThZXSdD6/FmdW4B3HSfiGvKMQWE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30BIKmSg006563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Jan 2023 12:20:48 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 11
 Jan 2023 12:20:48 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 11 Jan 2023 12:20:47 -0600
Received: from [10.250.233.151] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30BIKhbe060579;
        Wed, 11 Jan 2023 12:20:44 -0600
Message-ID: <078417fd-9e32-18b8-7bf5-d8d0fbe09dcf@ti.com>
Date:   Wed, 11 Jan 2023 23:50:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/3] arm64: dts: ti: k3-am62-main: Add support for USB
Content-Language: en-US
To:     Sjoerd Simons <sjoerd@collabora.com>, Nishanth Menon <nm@ti.com>
CC:     <kernel@collabora.com>, Nitin Yadav <n-yadav@ti.com>,
        <martyn.welch@collabora.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230111132348.553061-1-sjoerd@collabora.com>
 <20230111132348.553061-3-sjoerd@collabora.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20230111132348.553061-3-sjoerd@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/2023 6:53 PM, Sjoerd Simons wrote:
> From: Aswath Govindraju <a-govindraju@ti.com>
> 
> AM62 SoC has two instances of USB on it. Therefore, add support for the
> same.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> [cherry-pick from vendor BSP]]
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Tested-by: Martyn Welch <martyn.welch@collabora.com>
> 
> ---
> 
> Changes in v3:
> - Rebased against current ti-next aka 6.2-rc1
> - Add Martyn's tested-by
> 
> Changes in v2:
> - Rebase against linux-next 20221220
> 
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 44 ++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index 466b94d1cee9..4da15e8c956f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -555,6 +555,50 @@ sdhci2: mmc@fa20000 {
>  		status = "disabled";
>  	};
>  
> +	usbss0: dwc3-usb@f900000 {
> +		compatible = "ti,am62-usb";
> +		reg = <0x00 0x0f900000 0x00 0x800>;
> +		clocks = <&k3_clks 161 3>;
> +		clock-names = "ref";
> +		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4008>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		power-domains = <&k3_pds 178 TI_SCI_PD_EXCLUSIVE>;
> +		ranges;
> +

Following the convention of the file, could you please set status =
"disabled" here and then set it to okay in board dts file (patch 3/3)

> +		usb0: usb@31000000 {
> +			compatible = "snps,dwc3";
> +			reg =<0x00 0x31000000 0x00 0x50000>;
> +			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
> +				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
> +			interrupt-names = "host", "peripheral";
> +			maximum-speed = "high-speed";
> +			dr_mode = "otg";
> +		};
> +	};
> +
> +	usbss1: dwc3-usb@f910000 {
> +		compatible = "ti,am62-usb";
> +		reg = <0x00 0x0f910000 0x00 0x800>;
> +		clocks = <&k3_clks 162 3>;
> +		clock-names = "ref";
> +		ti,syscon-phy-pll-refclk = <&wkup_conf 0x4018>;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
> +		ranges;
> +

Same here...

> +		usb1: usb@31100000 {
> +			compatible = "snps,dwc3";
> +			reg =<0x00 0x31100000 0x00 0x50000>;
> +			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
> +				     <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
> +			interrupt-names = "host", "peripheral";
> +			maximum-speed = "high-speed";
> +			dr_mode = "otg";
> +		};
> +	};
> +
>  	fss: bus@fc00000 {
>  		compatible = "simple-bus";
>  		reg = <0x00 0x0fc00000 0x00 0x70000>;
