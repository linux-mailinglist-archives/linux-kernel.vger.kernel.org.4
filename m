Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969C55B81DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiINHNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiINHNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:13:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E07A61B2E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:13:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oYMa4-00055e-Tg; Wed, 14 Sep 2022 09:13:08 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oYMa5-000eMq-9o; Wed, 14 Sep 2022 09:13:07 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1oYMa3-00Duhq-3h; Wed, 14 Sep 2022 09:13:07 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 0/2] gpio: Add gpio-latch driver
Date:   Wed, 14 Sep 2022 09:13:04 +0200
Message-Id: <20220914071306.3254881-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
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

Third round of the gpio-latch driver. The review comments I received
from v2 are integrated, for a changelog see the individual patches.

This time there's also devicetree@vger.kernel.org on Cc which I forgot
to add the last two rounds.

Sascha

Sascha Hauer (2):
  gpio: Add gpio latch driver
  dt-bindings: gpio: Add gpio-latch binding document

 .../devicetree/bindings/gpio/gpio-latch.yaml  |  85 ++++++++
 drivers/gpio/Kconfig                          |   6 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-latch.c                     | 192 ++++++++++++++++++
 4 files changed, 284 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-latch.yaml
 create mode 100644 drivers/gpio/gpio-latch.c

-- 
2.30.2

