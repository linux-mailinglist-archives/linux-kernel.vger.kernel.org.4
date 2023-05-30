Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9CC715B53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjE3KSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjE3KSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:18:37 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E348102;
        Tue, 30 May 2023 03:18:34 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 11C01201E9;
        Tue, 30 May 2023 12:18:33 +0200 (CEST)
Date:   Tue, 30 May 2023 12:18:28 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] arm64: dts: ti: add verdin am62
Message-ID: <ZHXNdJGWqqgd0muZ@francesco-nb.int.toradex.com>
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-4-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524143631.42471-4-francesco@dolcini.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 04:36:29PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This patch adds the device tree to support Toradex Verdin AM62 a
> computer on module which can be used on different carrier boards
> and the Toradex Verdin Development Board carrier board.
> 
> The module consists of an TI AM62 family SoC (either AM623 or AM625), a
> TPS65219 PMIC, a Gigabit Ethernet PHY, 512MB to 2GB of LPDDR4 RAM, an
> eMMC, a TLA2024 ADC, an I2C EEPROM, an RX8130 RTC, and optional Parallel
> RGB to MIPI DSI bridge plus an optional Bluetooth/Wi-Fi module.
> 
> Anything that is not self-contained on the module is disabled by
> default.
> 
> So far there is no display nor USB role switch supported, apart of that
> all the other functionalities are fine.
> 
> Link: https://developer.toradex.com/hardware/verdin-som-family/modules/verdin-am62/
> Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
> Link: https://www.toradex.com/products/carrier-board/verdin-development-board-kit
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |    2 +
>  .../arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi |  233 +++
>  .../boot/dts/ti/k3-am62-verdin-nonwifi.dtsi   |   16 +
>  .../boot/dts/ti/k3-am62-verdin-wifi.dtsi      |   36 +
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    | 1400 +++++++++++++++++
>  .../dts/ti/k3-am625-verdin-nonwifi-dev.dts    |   19 +
>  .../boot/dts/ti/k3-am625-verdin-wifi-dev.dts  |   19 +
>  7 files changed, 1725 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-nonwifi.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dts
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dev.dts
> 

<snip>

> +/* Verdin UART_1, connector X50 through RS485 transceiver. */
> +&main_uart1 {
> +	linux,rs485-enabled-at-boot-time;
> +	/*
> +	 * The 8250 OMAP driver interprets rs485-rts-active-high and its
> +	 * ioctl equivalent as driving RTS low on send.
> +	 */
> +	rs485-rts-active-high;

After some additional investigation this (rs485-rts-active-high) can be
removed, I'll send a v2 before the end of the week with just this change
unless I get some more feedback in the meantime.

Francesco
