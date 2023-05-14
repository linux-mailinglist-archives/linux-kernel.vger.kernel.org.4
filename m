Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A44701C94
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjENJX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 05:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjENJXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 05:23:17 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B021F1FFD;
        Sun, 14 May 2023 02:23:14 -0700 (PDT)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 34CCC20B13;
        Sun, 14 May 2023 11:23:10 +0200 (CEST)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v2 0/4] arm64: dts: colibri-imx8x: misc fixes
Date:   Sun, 14 May 2023 11:22:42 +0200
Message-Id: <20230514092246.9741-1-francesco@dolcini.it>
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

This series fixes a few small issues on the just introduced Colibri iMX8X:

* Remove duplicate GPIO3_IO01 pin configuration
* Remove GPIO3_IO01 pin configuration from SoM level
* Delete non-existing i.MX8X peripherals adc1 and dsp

In addition to that a small cleanup patch is added
* Move iomuxc pinctrl from SoM to carrier board level

v2:
 - remove stray newline after Fixes: tag
 - fixed from patch From:

Andrejs Cainikovs (1):
  arm64: dts: colibri-imx8x: delete adc1 and dsp

Emanuele Ghidoli (3):
  arm64: dts: colibri-imx8x: fix eval board pin configuration
  arm64: dts: colibri-imx8x: move pinctrl property from SoM to eval
    board
  arm64: dts: colibri-imx8x: fix iris pinctrl configuration

 .../boot/dts/freescale/imx8x-colibri-eval-v3.dtsi  |  6 ++++++
 .../boot/dts/freescale/imx8x-colibri-iris.dtsi     |  3 +--
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi   | 14 ++++++++------
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.25.1

