Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23008733006
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbjFPLjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFPLjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:39:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F17B2D47
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:39:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-982c996a193so79785366b.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686915581; x=1689507581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqBe1Ld+4yX8XBJIVvbQoAD/S8ybcl184LNQsljKFsA=;
        b=A7U3VltIT686Wpl3bdGE/23F9FQo8ptkUXR3cOqDHMT3q2KVnuexPS6Kbo2y5KMOSF
         xwcWA9N6GslFuYaB6sYUxjc6YulcqNnggw1xQr0af8PPR20w1mRMK0bFLbfinMvdVTFx
         rx14YG3npkm+PKE0AY6l5APxfN+gMxQo0o8azP1Kuniv7BhPly98uBOYg6VlDEBQmdjd
         n+KgBQjDaFWPOOqBELCsSTqRfIjacjBDHkd/YkR+q9ksoD/jAXnvAVIGzhwzrvFpvYvX
         nH+d0FVIu5Ah/QCME8RtJhEvWKJChzFHCVCHITaZMXyTmTK2AkZMFOKBBVtcQ0D4hDug
         IcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686915581; x=1689507581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqBe1Ld+4yX8XBJIVvbQoAD/S8ybcl184LNQsljKFsA=;
        b=N7MFUjAiGhgNm0xyLMY+XZ1XTsxBEjLmAJvNBn4UXXIru3D4lu+nI8nDGi7yQB4H5s
         ZsrftuWyAVurll3By9Q8FCdlpfQAcsUZx/Aa7D/4n3MVKsX3rpQglu3EZidL/utC0hIS
         igRqa/fIie4nSDAQ6WyLS10h7yVjUXDef0uAFHw+tYLXVSxpQ1hMyZ00UsPYFSG00NIA
         tfwtZhU0/CaVEP8alpilVH3FeUMWz9cs1riYoP0qYSPb6lmfdi59s1MNamFdVXARCVop
         JFgrvBRtpbHt1pnWkJ1asT6gd8f1e/jEMOp5nmxkRNycKCe2AMGOKxpBovQ5tglMXqbz
         qWTw==
X-Gm-Message-State: AC+VfDxDVMjhTO7R4TPnQy7MZjAG99VWn8A+3+bKiGvf6i95U018Tc7p
        crJU2D9YYPEme8/ZItYl8jDsCA==
X-Google-Smtp-Source: ACHHUZ4Ytjnsly62llDfkxacpRktKqwfSAt3dv08j/wlwMsJ6HyQinXjlHec9+jtqJ9mTP68qWBR+g==
X-Received: by 2002:a17:907:7e90:b0:974:6335:4239 with SMTP id qb16-20020a1709077e9000b0097463354239mr1636560ejc.34.1686915580716;
        Fri, 16 Jun 2023 04:39:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lx15-20020a170906af0f00b009837806ae2fsm1137144ejb.78.2023.06.16.04.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 04:39:40 -0700 (PDT)
Message-ID: <c25630ca-c791-287f-36a4-ebc0559d6541@linaro.org>
Date:   Fri, 16 Jun 2023 13:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] arm64: dts: freescale: Add support for LX2162 SoM &
 Clearfog Board
Content-Language: en-US
To:     Josua Mayer <josua@solid-run.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
References: <20230616110610.32173-1-josua@solid-run.com>
 <20230616110610.32173-4-josua@solid-run.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230616110610.32173-4-josua@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 13:06, Josua Mayer wrote:
> Add support for the SolidRun LX2162A System on Module (SoM), and the
> Clearfog evaluation board.
> 
> The SoM has few software-controllable features:
> - AR8035 Ethernet PHY
> - eMMC
> - SPI Flash
> - fan controller
> - various eeproms
> 

Thank you for your patch. There is something to discuss/improve.

> +
> +&i2c2 {
> +	/* retimer: ds250df410@18 */
> +
> +	i2c-switch@70 {
> +		compatible = "nxp,pca9546";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x70>;

reg is usually just after compatible.

...

> +
> +&emdio1 {
> +	/*
> +	 * SoM has a phy at address 1 connected to SoC Ethernet Controller 1.
> +	 * It competes for WRIOP MAC17, and no connector has been wired.
> +	 */
> +	/delete-node/ ethernet-phy@1;
> +
> +	ethernet_phy0: mv88e2580@8 {

Node names should be generic. See also explanation and list of examples
in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		reg = <8>;
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy1: mv88e2580@9 {
> +		reg = <9>;
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy2: mv88e2580@a {
> +		reg = <10>;
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy3: mv88e2580@b {
> +		reg = <11>;
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy4: mv88e2580@c {
> +		reg = <12>;
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy5: mv88e2580@d {
> +		reg = <13>;
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy6: mv88e2580@e {
> +		reg = <14>;
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		max-speed = <1000>;
> +	};
> +
> +	ethernet_phy7: mv88e2580@f {
> +		reg = <15>;
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		max-speed = <1000>;
> +	};
> +};
> +
> +&esdhc0 {
> +	status = "okay";
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +};
> +
> +&pcie3 {
> +	status = "disabled";
> +};
> +
> +&pcie4 {
> +	status = "disabled";
> +};
> +
> +&pcs_mdio3 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio4 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio5 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio6 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio11 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio12 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio13 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio14 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio15 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio16 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio17 {
> +	status = "okay";
> +};
> +
> +&pcs_mdio18 {
> +	status = "okay";
> +};
> +
> +&serdes_1 {
> +	status = "okay";
> +};
> +
> +&serdes_2 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
> new file mode 100644
> index 000000000000..49e03b6600d6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2162A-SOM
> +//
> +// Copyright 2021 Rabeeh Khoury <rabeeh@solid-run.com>
> +// Copyright 2023 Josua Mayer <josua@solid-run.com>
> +
> +&crypto {
> +	status = "okay";
> +};
> +
> +&dpmac17 {
> +	phy-handle = <&ethernet_phy0>;
> +	phy-connection-type = "rgmii-id";
> +};
> +
> +&emdio1 {
> +	status = "okay";
> +
> +	ethernet_phy0: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&esdhc1 {
> +	status = "okay";
> +	bus-width = <8>;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +};
> +
> +&fspi {
> +	status = "okay";
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "m25p80", "jedec,spi-nor";
> +		m25p,fast-read;
> +		spi-max-frequency = <50000000>;
> +		reg = <0>;

Fix the order of properties. compatible is always first, then the reg.

> +		/* The following setting enables 1-1-8 (CMD-ADDR-DATA) mode */
> +		spi-rx-bus-width = <8>;
> +		// spi-tx-bus-width = <8>;

Don't add dead code without appropriate comment why it is dead.

> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	fan-controller@18 {
> +		compatible = "ti,amc6821";
> +		reg = <0x18>;
> +		cooling-min-state = <0>;
> +		cooling-max-state = <9>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	ddr_spd: eeprom@51 {
> +		reg = <0x57>;
> +		compatible = "st,24c02", "atmel,24c02";

Ditto

> +		read-only;
> +	};
> +
> +	config_eeprom: eeprom@57 {
> +		reg = <0x57>;
> +		compatible = "st,24c02", "atmel,24c02";

Ditto

> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	variable_eeprom: eeprom@54 {
> +		reg = <0x54>;
> +		compatible = "st,24c2048", "atmel,24c2048";

ditto

> +	};
> +};

Best regards,
Krzysztof

