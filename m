Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83B6B07C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjCHNB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjCHNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:00:34 -0500
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8E2746D6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:56 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsg61R8QzMrSk2;
        Wed,  8 Mar 2023 13:53:06 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsg50dkvzMsl22;
        Wed,  8 Mar 2023 13:53:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279986;
        bh=te5TMz4DoFHZhASGAdG8ocer26P4Wf1i1+Oxh4ASymE=;
        h=From:To:Cc:Subject:Date:From;
        b=LkpvJcUWT3LaDVQKv33YvqLJHUAMld1xeLAOr/2j1Jf9YoZbZCAk4tjHHs0gb9EZX
         0KzB5iyrikYRvmVptiIdvPi3ohbXuRbAmmc3qjE00nQ9ABHZkS4mvL2cSc5+LsEa+I
         2D8zQn+LDpf1KBIWEgMjiOm/aEhizbGCkyHDHn9U=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/25] Update Colibri iMX8X Devicetrees
Date:   Wed,  8 Mar 2023 13:52:34 +0100
Message-Id: <20230308125300.58244-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This patch series does update the device-trees for Colibri iMX8X to the
latest state of development.

Adds the Carrier Board device-trees for:

- Aster
- Iris
- Iris v2

It as well changes ordering to be alphabetically and changes the
pinmuxing bracket format together with some minor fixes.


Philippe Schenker (25):
  arm64: dts: colibri-imx8x: Prepare for qxp and dx variants
  arm64: dts: colibri-imx8x: Update spdx license
  arm64: dts: colibri-imx8x: Sort properties
  arm64: dts: colibri-imx8x: Use new bracket format
  arm64: dts: colibri-imx8x: Add atmel pinctrl groups
  arm64: dts: colibri-imx8x: Add pinctrl group for csi_mclk
  arm64: dts: colibri-imx8x: Split pinctrl_hog1
  arm64: dts: colibri-imx8x: Correct pull on lcdif
  arm64: dts: colibri-imx8x: Add separate pinctrl group for cs2
  arm64: dts: colibri-imx8x: Add pinctrl group for hdmi hpd
  arm64: dts: colibri-imx8x: Sort fec1 node alphabetically
  arm64: dts: colibri-imx8x: Add SPI
  arm64: dts: colibri-imx8x: Add gpio-line-names
  arm64: dts: colibri-imx8x: Disable touchscreen by default
  arm64: dts: colibri-imx8x: Add jpegenc/dec
  arm64: dts: colibri-imx8x: Add colibri pwm b, c, d
  arm64: dts: colibri-imx8x: eval: Add spi-to-can
  arm64: dts: colibri-imx8x: Add no-1-8-v to sd-card
  arm64: dts: colibri-imx8x: Set thermal thresholds
  arm64: dts: colibri-imx8x: Move gpio-keys to som level
  arm64: dts: colibri-imx8x: Add todo comments
  dt-bindings: arm: fsl: Add colibri-imx8x carrier boards
  arm64: dts: colibri-imx8x: Add aster carrier board
  arm64: dts: colibri-imx8x: Add iris carrier board
  arm64: dts: colibri-imx8x: Add iris v2 carrier board

 .../devicetree/bindings/arm/fsl.yaml          |   5 +-
 arch/arm64/boot/dts/freescale/Makefile        |   3 +
 .../dts/freescale/imx8qxp-colibri-aster.dts   |  16 +
 .../dts/freescale/imx8qxp-colibri-eval-v3.dts |   6 +-
 .../freescale/imx8qxp-colibri-eval-v3.dtsi    |  62 --
 .../dts/freescale/imx8qxp-colibri-iris-v2.dts |  16 +
 .../dts/freescale/imx8qxp-colibri-iris.dts    |  16 +
 .../boot/dts/freescale/imx8qxp-colibri.dtsi   | 592 +------------
 .../dts/freescale/imx8x-colibri-aster.dtsi    |  44 +
 .../dts/freescale/imx8x-colibri-eval-v3.dtsi  |  91 ++
 .../dts/freescale/imx8x-colibri-iris-v2.dtsi  |  45 +
 .../dts/freescale/imx8x-colibri-iris.dtsi     | 115 +++
 .../boot/dts/freescale/imx8x-colibri.dtsi     | 776 ++++++++++++++++++
 13 files changed, 1132 insertions(+), 655 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-aster.dts
 delete mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris-v2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-iris.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8x-colibri-aster.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8x-colibri-iris-v2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8x-colibri-iris.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi

-- 
2.39.2

