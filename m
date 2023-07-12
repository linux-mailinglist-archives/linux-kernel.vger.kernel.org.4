Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8F37501BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjGLIhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjGLIgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:36:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD072D62
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:34:17 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so1085623a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689150856; x=1691742856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gw27ptvuG8lMdIU4QvHj9aUx5djZyyv5FcntfKmvWEc=;
        b=GMGWxEaDJN6EB6DlvlQUWdbIVLki4hjMs6tHczqzLqR+ppGupUv1OD1p5BKUBRm6xb
         wEHNEupA0AttmOfvZbsKMiV+a6n2ge7ta6q8STIYTssNN5bHiNChjuwgv+eEoIKXsO0R
         aL+GK2U23/O9LsNwPnyvsK1CBtU+BK4xQg+E02OXxi+NpX5hteTpMT23RpxjQba0t125
         Q6+O5LgOtJIT5yBy0d9biNHXNrmpCJ2ljIhymG/7jitmFIklv5tNRep7WEa+EhUi0jV2
         XVFaO0KdQ56BMSEiftipPRaVG69z+ckvCxlDXovwT58X6Nbq8uDYfCzY/5yfVCLtQomD
         og0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689150856; x=1691742856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw27ptvuG8lMdIU4QvHj9aUx5djZyyv5FcntfKmvWEc=;
        b=axdAbGwc1eLoYVfAVwT7aDxKTY3smQkN3NN4abtCQVejqjYOLVreqpxbKgsO6WnIB6
         TCIYYHrjd+qtmKUcQNrKuWF8SSIPHRe7X6Y4c8yZOelrikSlh4i6JEGstoqqpC01Y2Gm
         mZxIe2YZZavXPGiyAWVVQc4pWkpl1aDm+YLyCODIDHuuBp9HJ5xM6Wlvk49MduGcrQGM
         pDyVUMi+O6I6ia09Qe1QxieOXk6g2rEcFu1bjAWmxLH8F3gYjFO2S7YPL0MHRQl4UQfz
         F0M37/9nZBVbSgHwNYgJ1b1drw2E2ortcb6m0jMx30hvt0hldF1LqMXu95TbC9B+yH0W
         8VsQ==
X-Gm-Message-State: ABy/qLbKP6bD/d2mBJXH6Xz2Rme6qejoZSac6psT9khrZYg8qVKQv7AJ
        EQHKFxU1D+nCTfpFcRpDHenESw==
X-Google-Smtp-Source: APBJJlGjlwAMSGUpe3P1If/RhiTdHwxpWCorgsmh3ZIGmV4Y4Iek+OEt2O/yoetDsECExurTk7dugQ==
X-Received: by 2002:a17:906:778a:b0:989:450:e565 with SMTP id s10-20020a170906778a00b009890450e565mr1518907ejm.23.1689150856412;
        Wed, 12 Jul 2023 01:34:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id dc21-20020a170906c7d500b00988b86d6c7csm2207376ejb.132.2023.07.12.01.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 01:34:15 -0700 (PDT)
Message-ID: <219612e4-f306-9ce3-c75c-33195f1167f2@linaro.org>
Date:   Wed, 12 Jul 2023 10:34:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 8/8] ARM: dts: stm32: Add Octavo OSD32MP1-RED board
Content-Language: en-US
To:     Sean Nyekjaer <sean@geanix.com>, a.fatoum@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org
Cc:     dantuguf14105@gmail.com,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230712062954.2194505-1-sean@geanix.com>
 <20230712062954.2194505-8-sean@geanix.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712062954.2194505-8-sean@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2023 08:29, Sean Nyekjaer wrote:
> Add support for the Octavo OSD32MP1-RED development board.
> 
> General features:
>  - STM32MP157C
>  - 512MB DDR3
>  - CAN-FD
>  - HDMI
>  - USB-C OTG
>  - UART
> 

...

> +
> +&i2c1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c1_pins_a>;
> +	pinctrl-1 = <&i2c1_sleep_pins_a>;
> +	status = "okay";
> +	i2c-scl-rising-time-ns = <100>;
> +	i2c-scl-falling-time-ns = <7>;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;

You should explain it with comment, unless it is quite common for all
STM32 boards to disable DMA for I2C...

> +
> +	hdmi-transmitter@39 {
> +		compatible = "sil,sii9022";
> +		reg = <0x39>;
> +		reset-gpios = <&gpiog 0 GPIO_ACTIVE_LOW>;
> +		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-parent = <&gpiog>;
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&ltdc_pins_e>;
> +		pinctrl-1 = <&ltdc_sleep_pins_e>;
> +		status = "okay";

Did anything disable this node?

> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				sii9022_in: endpoint {
> +					remote-endpoint = <&ltdc_ep0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				sii9022_tx_endpoint: endpoint {
> +					remote-endpoint = <&i2s2_endpoint>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2s2 {
> +	clocks = <&rcc SPI2>, <&rcc SPI2_K>, <&rcc CK_PER>, <&rcc PLL3_R>;
> +	clock-names = "pclk", "i2sclk", "x8k", "x11k";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2s2_pins_b>;
> +	pinctrl-1 = <&i2s2_sleep_pins_b>;
> +	status = "okay";
> +
> +	i2s2_port: port {
> +		i2s2_endpoint: endpoint {
> +			remote-endpoint = <&sii9022_tx_endpoint>;
> +			format = "i2s";
> +			mclk-fs = <256>;
> +		};
> +	};
> +};
> +
> +&ltdc {
> +	status = "okay";
> +
> +	port {
> +		ltdc_ep0_out: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&sii9022_in>;
> +		};
> +	};
> +};
> +
> +&m_can1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&m_can1_pins_d>;
> +	pinctrl-1 = <&m_can1_sleep_pins_d>;
> +	status = "okay";
> +};
> +
> +&pwr_regulators {
> +	vdd-supply = <&vdd>;
> +	vdd_3v3_usbfs-supply = <&vdd_usb>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&sdmmc1 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc1_b4_pins_a>;
> +	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> +	cd-gpios = <&gpioe 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +	disable-wp;
> +	st,neg-edge;
> +	bus-width = <4>;
> +	vmmc-supply = <&v3v3>;
> +	status = "okay";
> +};
> +
> +&sdmmc2 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_d>;
> +	pinctrl-1 = <&sdmmc2_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_d>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	st,neg-edge;
> +	bus-width = <8>;
> +	vmmc-supply = <&v3v3>;
> +	vqmmc-supply = <&vdd>;
> +	mmc-ddr-3_3v;
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default", "sleep", "idle";
> +	pinctrl-0 = <&uart4_pins_a>;
> +	pinctrl-1 = <&uart4_sleep_pins_a>;
> +	pinctrl-2 = <&uart4_idle_pins_a>;
> +	/delete-property/dmas;
> +	/delete-property/dma-names;

Same concerns.

Best regards,
Krzysztof

