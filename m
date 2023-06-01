Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387B2719D10
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjFANNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjFANNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:13:44 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0100124;
        Thu,  1 Jun 2023 06:13:41 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 7A6CD2143A;
        Thu,  1 Jun 2023 15:13:37 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add Toradex Verdin AM62
Date:   Thu,  1 Jun 2023 15:13:27 +0200
Message-Id: <20230601131332.26877-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

This series adds support for the Toradex Verdin AM62 SoM which can be used on
different carrier boards (Verdin Development Board, Dahlia and Yavia).

The module consists of an TI AM62 family SoC (either AM623 or AM625), a
TPS65219 PMIC, a Gigabit Ethernet PHY, 512MB to 2GB of LPDDR4 RAM, an eMMC, a
TLA2024 ADC, an I2C EEPROM, an RX8130 RTC, and optional Parallel RGB to MIPI
DSI bridge plus an optional Bluetooth/Wi-Fi module.

Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62

v2: 
 - removed spurious new lines
 - removed TODO comment
 - fixed pinctrl format
 - added link to products in dts/dtsi
 - removed useless rs485-rts-active-high property

Francesco Dolcini (5):
  dt-bindings: arm: ti: add toradex,verdin-am62 et al.
  arm64: defconfig: enable drivers for Verdin AM62
  arm64: dts: ti: add verdin am62
  arm64: dts: ti: add verdin am62 dahlia
  arm64: dts: ti: add verdin am62 yavia

 .../devicetree/bindings/arm/ti/k3.yaml        |   20 +
 arch/arm64/boot/dts/ti/Makefile               |    6 +
 .../boot/dts/ti/k3-am62-verdin-dahlia.dtsi    |  219 +++
 .../arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi |  240 +++
 .../boot/dts/ti/k3-am62-verdin-nonwifi.dtsi   |   20 +
 .../boot/dts/ti/k3-am62-verdin-wifi.dtsi      |   39 +
 .../boot/dts/ti/k3-am62-verdin-yavia.dtsi     |  207 +++
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    | 1401 +++++++++++++++++
 .../dts/ti/k3-am625-verdin-nonwifi-dahlia.dts |   22 +
 .../dts/ti/k3-am625-verdin-nonwifi-dev.dts    |   22 +
 .../dts/ti/k3-am625-verdin-nonwifi-yavia.dts  |   22 +
 .../dts/ti/k3-am625-verdin-wifi-dahlia.dts    |   22 +
 .../boot/dts/ti/k3-am625-verdin-wifi-dev.dts  |   22 +
 .../dts/ti/k3-am625-verdin-wifi-yavia.dts     |   22 +
 arch/arm64/configs/defconfig                  |    3 +
 15 files changed, 2287 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-nonwifi.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dahlia.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-dev.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dahlia.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-dev.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-yavia.dts

-- 
2.25.1

