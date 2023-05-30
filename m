Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8BD715E94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjE3MLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjE3MLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:11:09 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2EA90;
        Tue, 30 May 2023 05:11:06 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UCAiqM035104;
        Tue, 30 May 2023 07:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685448644;
        bh=3Wjej0LyT5Fh0GI+iBtjlzAn6+Ozz/czgZi2sHh7gn4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GbAAIkZy2kKT8iGefaeW15cnQQ0EEREBemLruY8lOnDjmdMeD8AaomxCrrdPc3cAz
         6gk+5zo0yREL0txskgln29YNSa0A9rEPWolVyijRAP3YZBLhmf8Uz16JbnSqZsxmPV
         QpE9hsnsf08MQ5Dt8SYatkJy2Gp3qnPorFzeOa5c=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UCAink049402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 07:10:44 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 07:10:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 07:10:44 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UCAipR020110;
        Tue, 30 May 2023 07:10:44 -0500
Date:   Tue, 30 May 2023 07:10:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] arm64: dts: ti: add verdin am62
Message-ID: <20230530121044.sjhv452b4hs4lyiy@flyer>
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-4-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230524143631.42471-4-francesco@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:36-20230524, Francesco Dolcini wrote:
[...]
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
> new file mode 100644
> index 000000000000..e138b1c8ed14
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2023 Toradex

Please also add appropriate product links to dts/dtsi

> + */
> +
> +/ {
> +	sound_card: sound-card {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,bitclock-master = <&dailink_master>;
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&dailink_master>;
> +		simple-audio-card,name = "verdin-nau8822";
> +		simple-audio-card,routing =
> +			"Headphones", "LHP",
> +			"Headphones", "RHP",
> +			"Speaker", "LSPK",
> +			"Speaker", "RSPK",
> +			"Line Out", "AUXOUT1",
> +			"Line Out", "AUXOUT2",
> +			"LAUX", "Line In",
> +			"RAUX", "Line In",
> +			"LMICP", "Mic In",
> +			"RMICP", "Mic In";
> +		simple-audio-card,widgets =
> +			"Headphones", "Headphones",
> +			"Line Out", "Line Out",
> +			"Speaker", "Speaker",
> +			"Microphone", "Mic In",
> +			"Line", "Line In";
> +
> +		dailink_master: simple-audio-card,codec {
> +			clocks = <&k3_clks 157 10>;
> +			sound-dai = <&nau8822_1a>;
> +		};
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&mcasp0>;
> +		};
> +	};
> +};
> +
> +/* Verdin ETHs */
> +&cpsw3g {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1 &pinctrl_rgmii2>;

here and elsewhere:
pinctrl-0 = <&pinctrl_rgmii1>, <&pinctrl_rgmii2>;


> +	status = "okay";
> +};
[...]
> +	/* EEPROM */
> +	eeprom@57 {
> +		compatible = "st,24c02", "atmel,24c02";

checkpatch warns: DT compatible string "st,24c02" appears un-documented

> +		reg = <0x57>;
> +		pagesize = <16>;
> +	};
> +};
> +
> +/* Verdin I2C_2_DSI */
> +&main_i2c2 {
> +	status = "okay";

Here and few other dtsis:
you should set status along with pinmux.

[...]
> +
> +/* Verdin UART_2 */
> +&wkup_uart0 {
> +	/* FIXME: WKUP UART0 is used by DM firmware */
> +	status = "reserved";

If you do configure this in R5 SPL, you'd want to add the pinmux as
well.

> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
> new file mode 100644
> index 000000000000..289db1666fc0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright 2023 Toradex
> + */
> +
> +/ {
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wifi_en>;
> +		reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +

Drop extra EoLs.

[...]

> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> new file mode 100644
> index 000000000000..2e7cb607df45
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> @@ -0,0 +1,1400 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT

Assuming you really intent this instead of purely GPL-2.0

[...]

> +/* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
> +&cpsw3g_mdio {
> +	assigned-clocks = <&k3_clks 157 20>;
> +	assigned-clock-parents = <&k3_clks 157 22>;
> +	assigned-clock-rates = <25000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_eth_clock &pinctrl_mdio>;
> +	status = "disabled";
> +
> +	cpsw3g_phy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-id2000.a231";

Check binding - we don't include any compatibles that dont have yaml
conversion done (pinctrl is the only exception).

[...]

> +/* TODO: Verdin DSI_1 / TIDSS */
Drop the TODO.

[...]

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
