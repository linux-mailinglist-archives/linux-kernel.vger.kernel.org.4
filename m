Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EDA677F74
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjAWPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjAWPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:19:29 -0500
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612C72B093
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:18:51 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4P0tyG4P1JzMqhd5;
        Mon, 23 Jan 2023 16:17:42 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4P0tyF1sNpzMqXP1;
        Mon, 23 Jan 2023 16:17:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1674487062;
        bh=J7PFdAc9DcVIIoTv0/IDfFvR4Ej9gElZizbV7mhjWEE=;
        h=From:To:Cc:Subject:Date:From;
        b=lJpaIXkTuhSehSuuHJls4UkfQ9BnYYVz0abbV+fvcaU/8+qhxhY7BKbkBtim+Zgif
         2LD8Qb/FmjMRSVj58VlR/w9P05R43RsKCiBeWypfOMMObaoukOmE3ES3E+a8siEn5K
         44Z5VBTBcHiBVVelDYB56gQppt0m0rQgGTylP0hM=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: dts: imx8m(m|p): Add yavia carrier board
Date:   Mon, 23 Jan 2023 16:17:31 +0100
Message-Id: <20230123151734.44184-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>


This series adds the new Yavia Carrier Board for the Verdin family.
Specifically for Verdin iMX8M Mini and Verdin iMX8M Plus.

Yavia is a compact carrier board providing easy access to the most
common features of the Verdin family. The intended use of the carrier
board is application software development. The board is compatible with
all current and future Verdin SoMs.

https://www.toradex.com/products/carrier-board/yavia

Changes in v2:
- Added Krzysztof's Acked-by
- Switch deprecated label in led node with color, function and
  function-enumerator

Philippe Schenker (3):
  dt-bindings: arm: fsl: Add verdin yavia carrier-board
  arm64: dts: imx8mm-verdin: Add yavia carrier board
  arm64: dts: imx8mp-verdin: Add yavia carrier board

 .../devicetree/bindings/arm/fsl.yaml          |   4 +
 arch/arm64/boot/dts/freescale/Makefile        |   4 +
 .../freescale/imx8mm-verdin-nonwifi-yavia.dts |  18 ++
 .../freescale/imx8mm-verdin-wifi-yavia.dts    |  18 ++
 .../dts/freescale/imx8mm-verdin-yavia.dtsi    | 169 ++++++++++++++
 .../freescale/imx8mp-verdin-nonwifi-yavia.dts |  18 ++
 .../freescale/imx8mp-verdin-wifi-yavia.dts    |  18 ++
 .../dts/freescale/imx8mp-verdin-yavia.dtsi    | 213 ++++++++++++++++++
 8 files changed, 462 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-yavia.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi

-- 
2.39.0

