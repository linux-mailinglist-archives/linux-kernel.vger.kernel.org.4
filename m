Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7366A0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjAMRpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAMRor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:44:47 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE2288A0B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:32:22 -0800 (PST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1pGNua-0002gm-DE; Fri, 13 Jan 2023 18:32:16 +0100
From:   Bastian Krause <bst@pengutronix.de>
Subject: [PATCH 0/2] Support Child MFD Cells for the i.MX6QDL Reset Controller
Date:   Fri, 13 Jan 2023 18:32:09 +0100
Message-Id: <20230113-syscon-child-mfd-v1-0-0dd31b7de373@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmVwWMC/13NQQoCMQyF4asMWRuctgrqVcRFk6Y2oB1pRJRh7
 m7Hpcsf3sebwaSpGJyGGZq81HSqPdxmAC6xXgU19QY/+jA6F9A+xlNFLnpLeM8J03Gfg9/xgShD
 ZxRNkFqsXFZI9tz+m3X2aJL1/Xs+X5blCwDxAaSJAAAA
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Bastian Krause <bst@pengutronix.de>
X-Mailer: b4 0.11.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow passing the reboot mode from the OS to the bootloader via the
syscon-reboot-mode binding. Add a "simple-mfd" to support probing such a
child node. The actual reboot mode node could then be defined in a board
device-tree or fixed up by the bootloader.

To: Philipp Zabel <p.zabel@pengutronix.de>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Bastian Krause <bst@pengutronix.de>

---
Bastian Krause (2):
      dt-bindings: reset: imx-src: add syscon and simple-mfd compatibles
      ARM: dts: imx6qdl: support child mfd cells for the reset controller

 Documentation/devicetree/bindings/reset/fsl,imx-src.yaml | 2 ++
 arch/arm/boot/dts/imx6qdl.dtsi                           | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230113-syscon-child-mfd-d95f324c8bbf

Best regards,
-- 
Bastian Krause <bst@pengutronix.de>
