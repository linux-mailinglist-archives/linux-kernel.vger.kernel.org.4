Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2AF70538D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjEPQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjEPQVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:21:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC37AA265
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:20:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1pyxPd-0002nq-A6; Tue, 16 May 2023 18:20:33 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1pyxPc-000eDt-Gp; Tue, 16 May 2023 18:20:32 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1pyxPb-00DODy-NQ; Tue, 16 May 2023 18:20:31 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH v2 0/2] Add phy tuning support for imx8mq-usb
Date:   Tue, 16 May 2023 18:20:18 +0200
Message-Id: <20230516-lustige-usb-phy-dinge-v2-0-3383a0de34ac@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOtY2QC/x2NQQoCMQxFrzJkbWHsUBGvIi6aNLWBUofGijLM3
 Y0u3+M//gbKXVjhMm3Q+SUqj2bgDxNQie3OTpIx+NkvczieXB36FNND0a3l45L8RvmcMhEuASm
 AtRiVHfbYqFjdRq0m185Z3v+z623fvywF6SR8AAAA
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Li Jun <jun.li@nxp.com>
Cc:     patchwork-jzi@pengutronix.de, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johannes Zink <j.zink@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.12.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for USB phy tuning parameters, which are
required for meeting USB certification and EMI qualification.

Patch 1/2 adds the required properties to the fsl,imx8mq-usb-phy
devicetree binding.

Patch 2/2 adds the phy tuning parameters to the phy-fsl-imx8mp driver.
This patch is ported and cleaned up from the downstream Freescale vendor
tree.

Best regards,
Johannes

Johannes Zink (1):
  dt-bindings: phy: imx8mq-usb: add phy tuning properties

Li Jun (1):
  phy: fsl-imx8mp-usb: add support for phy tuning

---

Changelog:

  v1 -> v2: worked in review from Krzysztof and Rob, thanks for your
  review:
   - extract more useful descriptions of the properties from the
     datasheet
   - use unit postfixes for the device tree properties to facilitate
     porting in the future
   - add more information about some of the properties (thanks to Li Jun
     for clarification)
   - adjust parsing of the devicetree properties in the driver to scale
     to the proper register values

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

---
Johannes Zink (1):
      dt-bindings: phy: imx8mq-usb: add phy tuning properties

Li Jun (1):
      phy: fsl-imx8mp-usb: add support for phy tuning

 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |  47 +++++
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c         | 218 +++++++++++++++++++++
 2 files changed, 265 insertions(+)
---
base-commit: 7a503071e06db4409b7066b8ecca9f3da03dd3b1
change-id: 20230516-lustige-usb-phy-dinge-f8dfccb35bc5

Best regards,
-- 
Johannes Zink <j.zink@pengutronix.de>

