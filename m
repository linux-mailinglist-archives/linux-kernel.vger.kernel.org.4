Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2D3715E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjE3MEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjE3MED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:04:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED899D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:04:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4q-0000AS-LN; Tue, 30 May 2023 14:03:48 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4p-003rWP-Km; Tue, 30 May 2023 14:03:47 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1q3y4o-00C3uC-Ll; Tue, 30 May 2023 14:03:46 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 00/15] Maintenance updates for Protonic Holland boards
Date:   Tue, 30 May 2023 14:03:30 +0200
Message-Id: <20230530120345.2874900-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset consists of several updates that address issues on
Protonic Holland's supported i.MX6-based devices, with a particular
focus on the USB subsystem configuration, thermal zones, and the naming
of GPIO keys. Some of these changes include the activation of USB over-
current detection on certain ports, the disabling of unused USB PHY
nodes, fixing USB-related warnings, adding trip points to thermal zones
on several devices, and renaming the 'power' key to meet the necessary
conventions.

David Jander (1):
  ARM: dts: imx6dl: prtvt7: Remove touchscreen inversion

Oleksij Rempel (11):
  ARM: dts: imx6dl: lanmcu: Disable unused USB PHY nodes
  ARM: dts: imx6dl: lanmcu: Configure over-current polarity for USB OTG
    node
  ARM: dts: imx6dl: Add trip points to thermal zones on several devices
  ARM: dts: imx6dl: vicut1: Address USB related warnings
  ARM: dts: imx6dl: alti6p: fix different USB related warnings
  ARM: dts: imx6dl: prtmvt: fix different USB related warnings
  ARM: dts: imx6qp: prtwd3: Enable USB over current detection on USB OTG
    port
  ARM: dts: imx6ul: prti6g: fix USB over-current detection on USB OTG
    port
  ARM: dts: imx6dl: plybas: fix USB over-current detection on USB OTG
    port
  ARM: dts: imx6dl: prtrvt, prtvt7, prti6q, prtwd2: fix USB related
    warnings
  ARM: dts: imx6qdl: vicut1: rename power to power-button

Robin van der Gracht (3):
  ARM: dts: imx6qdl: vicut1: The sgtl5000 uses i2s not ac97
  ARM: dts: imx6dl: prtvt7: Adjust default backlight brightness to 65
  ARM: dts: imx6q: prtwd2: Correct iomux configuration for ENET MDIO and
    MDC

 arch/arm/boot/dts/imx6dl-alti6p.dts          | 10 +++++++
 arch/arm/boot/dts/imx6dl-lanmcu.dts          |  9 +++++++
 arch/arm/boot/dts/imx6dl-plybas.dts          |  2 +-
 arch/arm/boot/dts/imx6dl-plym2m.dts          | 24 +++++++++++++++++
 arch/arm/boot/dts/imx6dl-prtmvt.dts          | 11 +++++++-
 arch/arm/boot/dts/imx6dl-prtrvt.dts          |  4 +++
 arch/arm/boot/dts/imx6dl-prtvt7.dts          | 28 +++++++++++++++++---
 arch/arm/boot/dts/imx6dl-victgo.dts          | 24 +++++++++++++++++
 arch/arm/boot/dts/imx6q-prtwd2.dts           |  3 ---
 arch/arm/boot/dts/imx6qdl-prti6q.dtsi        | 11 +++++++-
 arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi |  2 +-
 arch/arm/boot/dts/imx6qdl-vicut1.dtsi        | 19 +++++++++++--
 arch/arm/boot/dts/imx6qp-prtwd3.dts          |  2 +-
 arch/arm/boot/dts/imx6ul-prti6g.dts          |  1 +
 14 files changed, 137 insertions(+), 13 deletions(-)

-- 
2.39.2

