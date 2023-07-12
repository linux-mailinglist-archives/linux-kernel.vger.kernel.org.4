Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497E27502B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjGLJSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjGLJR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:17:57 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EFCFB;
        Wed, 12 Jul 2023 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
        In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=0KG+9/Us+bQr0mX8moldHf2l/y7AhroiqVYntd3LSiE=;
        b=lE4TE/gmRdZIbwdU8PKbM2Jp8KQ0th2Wdtmpqw7CS5Ap1osRPv/EvHnOgU1QUINDpHpClPhKJux
        hqFNzYBKCxPIAiVIcdwxn0pbuQ31FaWPb9fPx350yMtC0YGz5xt+ICjvbFslRDc8XwegO1mgngvQ3
        UekS9SrDLbgHFoaeVMyP9tnpV+WXXp2Bdz+ETrTOqDv9M/ojRBCbpwKQQwAynsyePre5kw6W9ziUk
        nwleGtFOlrdysbpihXE92PVQoy7RaWYr7BEy9L/FoB4p5mL2u4LXrXrbPW5+/KIcfxv4FUD8F+cTy
        wOgUcpLOGWcpFEJ0u9WcnibfwbQzprFmwUoA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qJVys-000Fjb-1k; Wed, 12 Jul 2023 11:17:54 +0200
Received: from [2a06:4004:10df:0:6cc7:3173:9f32:f330] (helo=smtpclient.apple)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qJVyr-000PhP-AB; Wed, 12 Jul 2023 11:17:53 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v3 8/8] ARM: dts: stm32: Add Octavo OSD32MP1-RED board
From:   Sean Nyekjaer <sean@geanix.com>
In-Reply-To: <219612e4-f306-9ce3-c75c-33195f1167f2@linaro.org>
Date:   Wed, 12 Jul 2023 11:17:42 +0200
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, dantuguf14105@gmail.com,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AE6040B-5F3F-4CBE-9D2E-ABBD1B5605F6@geanix.com>
References: <20230712062954.2194505-1-sean@geanix.com>
 <20230712062954.2194505-8-sean@geanix.com>
 <219612e4-f306-9ce3-c75c-33195f1167f2@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/26967/Wed Jul 12 09:28:32 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 12 Jul 2023, at 10.34, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 12/07/2023 08:29, Sean Nyekjaer wrote:
>> Add support for the Octavo OSD32MP1-RED development board.
>>=20
>> General features:
>> - STM32MP157C
>> - 512MB DDR3
>> - CAN-FD
>> - HDMI
>> - USB-C OTG
>> - UART
>>=20
>=20
> ...
>=20
>> +
>> +&i2c1 {
>> + pinctrl-names =3D "default", "sleep";
>> + pinctrl-0 =3D <&i2c1_pins_a>;
>> + pinctrl-1 =3D <&i2c1_sleep_pins_a>;
>> + status =3D "okay";
>> + i2c-scl-rising-time-ns =3D <100>;
>> + i2c-scl-falling-time-ns =3D <7>;
>> + /delete-property/dmas;
>> + /delete-property/dma-names;
>=20
> You should explain it with comment, unless it is quite common for all
> STM32 boards to disable DMA for I2C...

Quite common for all STM32 boards, but I will add a comment anyway :)

>=20
>> +
>> + hdmi-transmitter@39 {
>> + compatible =3D "sil,sii9022";
>> + reg =3D <0x39>;
>> + reset-gpios =3D <&gpiog 0 GPIO_ACTIVE_LOW>;
>> + interrupts =3D <1 IRQ_TYPE_EDGE_FALLING>;
>> + interrupt-parent =3D <&gpiog>;
>> + pinctrl-names =3D "default", "sleep";
>> + pinctrl-0 =3D <&ltdc_pins_e>;
>> + pinctrl-1 =3D <&ltdc_sleep_pins_e>;
>> + status =3D "okay";
>=20
> Did anything disable this node?

No will remove.

>=20
>> +
>> + ports {
>> + #address-cells =3D <1>;
>> + #size-cells =3D <0>;
>> +
>> + port@0 {
>> + reg =3D <0>;
>> + sii9022_in: endpoint {
>> + remote-endpoint =3D <&ltdc_ep0_out>;
>> + };
>> + };
>> +
>> + port@1 {
>> + reg =3D <1>;
>> + sii9022_tx_endpoint: endpoint {
>> + remote-endpoint =3D <&i2s2_endpoint>;
>> + };
>> + };
>> + };
>> + };
>> +};
>> +
>> +&i2s2 {
>> + clocks =3D <&rcc SPI2>, <&rcc SPI2_K>, <&rcc CK_PER>, <&rcc =
PLL3_R>;
>> + clock-names =3D "pclk", "i2sclk", "x8k", "x11k";
>> + pinctrl-names =3D "default", "sleep";
>> + pinctrl-0 =3D <&i2s2_pins_b>;
>> + pinctrl-1 =3D <&i2s2_sleep_pins_b>;
>> + status =3D "okay";
>> +
>> + i2s2_port: port {
>> + i2s2_endpoint: endpoint {
>> + remote-endpoint =3D <&sii9022_tx_endpoint>;
>> + format =3D "i2s";
>> + mclk-fs =3D <256>;
>> + };
>> + };
>> +};
>> +
>> +&ltdc {
>> + status =3D "okay";
>> +
>> + port {
>> + ltdc_ep0_out: endpoint@0 {
>> + reg =3D <0>;
>> + remote-endpoint =3D <&sii9022_in>;
>> + };
>> + };
>> +};
>> +
>> +&m_can1 {
>> + pinctrl-names =3D "default", "sleep";
>> + pinctrl-0 =3D <&m_can1_pins_d>;
>> + pinctrl-1 =3D <&m_can1_sleep_pins_d>;
>> + status =3D "okay";
>> +};
>> +
>> +&pwr_regulators {
>> + vdd-supply =3D <&vdd>;
>> + vdd_3v3_usbfs-supply =3D <&vdd_usb>;
>> +};
>> +
>> +&rtc {
>> + status =3D "okay";
>> +};
>> +
>> +&sdmmc1 {
>> + pinctrl-names =3D "default", "opendrain", "sleep";
>> + pinctrl-0 =3D <&sdmmc1_b4_pins_a>;
>> + pinctrl-1 =3D <&sdmmc1_b4_od_pins_a>;
>> + pinctrl-2 =3D <&sdmmc1_b4_sleep_pins_a>;
>> + cd-gpios =3D <&gpioe 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>> + disable-wp;
>> + st,neg-edge;
>> + bus-width =3D <4>;
>> + vmmc-supply =3D <&v3v3>;
>> + status =3D "okay";
>> +};
>> +
>> +&sdmmc2 {
>> + pinctrl-names =3D "default", "opendrain", "sleep";
>> + pinctrl-0 =3D <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_d>;
>> + pinctrl-1 =3D <&sdmmc2_b4_od_pins_a>;
>> + pinctrl-2 =3D <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_d>;
>> + non-removable;
>> + no-sd;
>> + no-sdio;
>> + st,neg-edge;
>> + bus-width =3D <8>;
>> + vmmc-supply =3D <&v3v3>;
>> + vqmmc-supply =3D <&vdd>;
>> + mmc-ddr-3_3v;
>> + status =3D "okay";
>> +};
>> +
>> +&uart4 {
>> + pinctrl-names =3D "default", "sleep", "idle";
>> + pinctrl-0 =3D <&uart4_pins_a>;
>> + pinctrl-1 =3D <&uart4_sleep_pins_a>;
>> + pinctrl-2 =3D <&uart4_idle_pins_a>;
>> + /delete-property/dmas;
>> + /delete-property/dma-names;
>=20
> Same concerns.

Thanks for the review Krzysztof.

/Sean

>=20
> Best regards,
> Krzysztof
>=20


