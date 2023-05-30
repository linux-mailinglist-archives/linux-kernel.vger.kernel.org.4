Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB37161F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjE3Nc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjE3NcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:32:24 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64225A1;
        Tue, 30 May 2023 06:32:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UDW1CU010504;
        Tue, 30 May 2023 08:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685453521;
        bh=TVuo4D7cz4/tEVfuFzYLxXwg0NBeCVTRyOotng1WRcs=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=SaIiBja+wsle1bsWMjGbHRz9yQalDYwsCqXj/8iXi4GH26M13G6np3C79uhB1z7fH
         8aKOJoZxnNtpJDtnqFE6X2Yh6VYvIXFc0Q0TItAVyAsfAthDA+mcVT1VoqULm+vpWk
         11Bl7CsVkx129Z3NkzeaOrW8BAe2bzXoysczXnig=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UDW17I063353
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 08:32:01 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 08:32:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 08:32:01 -0500
Received: from [10.249.142.56] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UDVvu7012242;
        Tue, 30 May 2023 08:31:58 -0500
Message-ID: <ae30ee49-6cd2-c80f-28fb-9538e8932010@ti.com>
Date:   Tue, 30 May 2023 19:01:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 3/5] arm64: dts: ti: add verdin am62
To:     Nishanth Menon <nm@ti.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-4-francesco@dolcini.it>
 <20230530121044.sjhv452b4hs4lyiy@flyer>
Content-Language: en-US
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20230530121044.sjhv452b4hs4lyiy@flyer>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 5/30/2023 5:40 PM, Nishanth Menon wrote:
> On 16:36-20230524, Francesco Dolcini wrote:
> [...]
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
>> new file mode 100644
>> index 000000000000..e138b1c8ed14
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
>> @@ -0,0 +1,233 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>> +/*
>> + * Copyright 2023 Toradex
> 
> Please also add appropriate product links to dts/dtsi
> 
>> + */
>> +
>> +/ {
>> +	sound_card: sound-card {
>> +		compatible = "simple-audio-card";
>> +		simple-audio-card,bitclock-master = <&dailink_master>;
>> +		simple-audio-card,format = "i2s";
>> +		simple-audio-card,frame-master = <&dailink_master>;
>> +		simple-audio-card,name = "verdin-nau8822";
>> +		simple-audio-card,routing =
>> +			"Headphones", "LHP",
>> +			"Headphones", "RHP",
>> +			"Speaker", "LSPK",
>> +			"Speaker", "RSPK",
>> +			"Line Out", "AUXOUT1",
>> +			"Line Out", "AUXOUT2",
>> +			"LAUX", "Line In",
>> +			"RAUX", "Line In",
>> +			"LMICP", "Mic In",
>> +			"RMICP", "Mic In";
>> +		simple-audio-card,widgets =
>> +			"Headphones", "Headphones",
>> +			"Line Out", "Line Out",
>> +			"Speaker", "Speaker",
>> +			"Microphone", "Mic In",
>> +			"Line", "Line In";
>> +
>> +		dailink_master: simple-audio-card,codec {
>> +			clocks = <&k3_clks 157 10>;
>> +			sound-dai = <&nau8822_1a>;
>> +		};
>> +
>> +		simple-audio-card,cpu {
>> +			sound-dai = <&mcasp0>;
>> +		};
>> +	};
>> +};
>> +
>> +/* Verdin ETHs */
>> +&cpsw3g {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_rgmii1 &pinctrl_rgmii2>;
> 
> here and elsewhere:
> pinctrl-0 = <&pinctrl_rgmii1>, <&pinctrl_rgmii2>;
> 
> 
>> +	status = "okay";
>> +};
> [...]
>> +	/* EEPROM */
>> +	eeprom@57 {
>> +		compatible = "st,24c02", "atmel,24c02";
> 
> checkpatch warns: DT compatible string "st,24c02" appears un-documented
> 

Checkpatch now seems outdated in favor of dtbs_check. DT schemas use
regex for compatibles and thus simple grep in
Doucmentation/devicetree-bindings/ doesn't help. Eg: In this case:

Documentation/devicetree/bindings/eeprom/at24.yaml has the regex to
cover the compatibles

>> +		reg = <0x57>;
>> +		pagesize = <16>;
>> +	};
>> +};
>> +
>> +/* Verdin I2C_2_DSI */
>> +&main_i2c2 {
>> +	status = "okay";
> 
> Here and few other dtsis:
> you should set status along with pinmux.
> 
> [...]
>> +
>> +/* Verdin UART_2 */
>> +&wkup_uart0 {
>> +	/* FIXME: WKUP UART0 is used by DM firmware */
>> +	status = "reserved";
> 
> If you do configure this in R5 SPL, you'd want to add the pinmux as
> well.
> 
>> +};
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
>> new file mode 100644
>> index 000000000000..289db1666fc0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
>> @@ -0,0 +1,36 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>> +/*
>> + * Copyright 2023 Toradex
>> + */
>> +
>> +/ {
>> +	wifi_pwrseq: wifi-pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_wifi_en>;
>> +		reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_LOW>;
>> +	};
>> +};
>> +
>> +
> 
> Drop extra EoLs.
> 
> [...]
> 
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>> new file mode 100644
>> index 000000000000..2e7cb607df45
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>> @@ -0,0 +1,1400 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> 
> Assuming you really intent this instead of purely GPL-2.0
> 
> [...]
> 
>> +/* MDIO, shared by Verdin ETH_1 (On-module PHY) and Verdin ETH_2_RGMII */
>> +&cpsw3g_mdio {
>> +	assigned-clocks = <&k3_clks 157 20>;
>> +	assigned-clock-parents = <&k3_clks 157 22>;
>> +	assigned-clock-rates = <25000000>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_eth_clock &pinctrl_mdio>;
>> +	status = "disabled";
>> +
>> +	cpsw3g_phy0: ethernet-phy@0 {
>> +		compatible = "ethernet-phy-id2000.a231";
> 
> Check binding - we don't include any compatibles that dont have yaml
> conversion done (pinctrl is the only exception).

Same here ;)
Documentation/devicetree/bindings/net/ethernet-phy.yaml covers it

> 
> [...]
> 
>> +/* TODO: Verdin DSI_1 / TIDSS */
> Drop the TODO.
> 
> [...]
> 
