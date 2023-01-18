Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC267201B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjAROtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAROsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:48:31 -0500
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBAE46D50
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:41:07 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4NxpNF0zXgzMq4SK;
        Wed, 18 Jan 2023 15:41:01 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4NxpNC4kZnzFYS;
        Wed, 18 Jan 2023 15:40:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1674052861;
        bh=D3/v6IyvwMtBeEzhlKdhLBUfk5fPTY0u64kzIpDz1J0=;
        h=From:To:Cc:Subject:Date:From;
        b=GoM8tBfwYpZGJnIK5sm0DgOhMtp6Irc9vghCPnv4SJFQUf+qd/DbS9KQmKmmk0t/y
         f2uESyOG7LA4JwqTNNb/EZU+nHDgLIsCwtSd56lj080v14Tt93M+mF+ZmV+eUuXpb+
         amYwI0l9Xzf1wjBgMzmbgMAbei76fQGg81CxWWhk=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
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
Subject: [PATCH 0/3] arm64: dts: imx8m(m|p): Add yavia carrier board
Date:   Wed, 18 Jan 2023 15:40:39 +0100
Message-Id: <20230118144042.7705-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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


Philippe Schenker (3):
  dt-bindings: arm: fsl: Add verdin yavia carrier-board
  arm64: dts: imx8mm-verdin: Add yavia carrier board
  arm64: dts: imx8mp-verdin: Add yavia carrier board

 .../devicetree/bindings/arm/fsl.yaml          |   4 +
 arch/arm64/boot/dts/freescale/Makefile        |   4 +
 .../freescale/imx8mm-verdin-nonwifi-yavia.dts |  18 ++
 .../freescale/imx8mm-verdin-wifi-yavia.dts    |  18 ++
 .../dts/freescale/imx8mm-verdin-yavia.dtsi    | 155 ++++++++++++++
 .../freescale/imx8mp-verdin-nonwifi-yavia.dts |  18 ++
 .../freescale/imx8mp-verdin-wifi-yavia.dts    |  18 ++
 .../dts/freescale/imx8mp-verdin-yavia.dtsi    | 199 ++++++++++++++++++
 8 files changed, 434 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-nonwifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-wifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-verdin-yavia.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-yavia.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-yavia.dtsi

-- 
2.39.0

