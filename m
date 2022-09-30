Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FEC5F0BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiI3Msy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiI3Msp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:48:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B676014E769
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:48:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oeFRI-0007Vz-Aw; Fri, 30 Sep 2022 14:48:24 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oeFRH-003nvU-35; Fri, 30 Sep 2022 14:48:21 +0200
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oeFRE-001tpt-Ns; Fri, 30 Sep 2022 14:48:20 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        jacopo@jmondi.org, hverkuil@xs4all.nl
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-media@vger.kernel.org
Subject: [PATCH v4 0/4] Add support for Toshiba TC358746
Date:   Fri, 30 Sep 2022 14:48:08 +0200
Message-Id: <20220930124812.450332-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
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

Hi,

this small series adds the support for the Toshiba TC358746 MIPI-CSI to
Parallel converter chip. The different versions of this serie can be
found here [1]. Thanks a lot for the review feedback from Laurent and
Sakari, which was very helpful.

[1] https://lore.kernel.org/all/20220922134843.3108267-1-m.felsch@pengutronix.de/
    https://lore.kernel.org/all/20220916134535.128131-1-m.felsch@pengutronix.de/
    https://lore.kernel.org/all/20220818143307.967150-5-m.felsch@pengutronix.de/

Marco Felsch (4):
  phy: dphy: refactor get_default_config
  phy: dphy: add support to calculate the timing based on hs_clk_rate
  media: dt-bindings: add bindings for Toshiba TC358746
  media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver

 .../bindings/media/i2c/toshiba,tc358746.yaml  |  178 ++
 drivers/media/i2c/Kconfig                     |   17 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/tc358746.c                  | 1696 +++++++++++++++++
 drivers/phy/phy-core-mipi-dphy.c              |   31 +-
 include/linux/phy/phy-mipi-dphy.h             |    3 +
 6 files changed, 1922 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
 create mode 100644 drivers/media/i2c/tc358746.c

-- 
2.30.2

