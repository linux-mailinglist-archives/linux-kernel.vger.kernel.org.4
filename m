Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656AD6D7B21
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbjDELV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbjDELVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:21:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1235BB3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:21:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1pk1Ce-0004S3-05; Wed, 05 Apr 2023 13:21:24 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1pk1Cc-0098SM-52; Wed, 05 Apr 2023 13:21:22 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1pk1Cb-005Gtk-9W; Wed, 05 Apr 2023 13:21:21 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jun.li@nxp.com,
        haibo.chen@nxp.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     j.zink@pengutronix.de
Subject: [PATCH 0/2] Add phy tuning support for imx8mq-usb
Date:   Wed,  5 Apr 2023 13:21:16 +0200
Message-Id: <20230405112118.1256151-1-j.zink@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jzi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

 .../bindings/phy/fsl,imx8mq-usb-phy.yaml      |  40 ++++++
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c    | 124 ++++++++++++++++++
 2 files changed, 164 insertions(+)

-- 
2.39.2

