Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C20D629B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiKON6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKON6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:58:22 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48081145;
        Tue, 15 Nov 2022 05:58:20 -0800 (PST)
Received: (Authenticated sender: kory.maincent@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6FB381C001E;
        Tue, 15 Nov 2022 13:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668520699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GbCsgekaHtIeV8Zu1tUsRWhr+2lncTq96b31p1AFJtw=;
        b=H3hzWagYKQhAzCQ1+QMx4o4N6Sv+Ycu5jHgDd4f3KT2AdKbFFxlZMTSXQdKluGJs+uD5hu
        79hn47FY7CuytoE30etuEECf6tg5kHSgMbZLHtWJIbJp6WO3Do1odm7luV+Vyn8277Rzw4
        HmN3q6J1XWFgmoAXi1EVkdfOliXBJAU/YO5uPSTtl+ktuqVrTvb1utNgBUG/Hp7RH2Z9GP
        3KxLHBhBaGTmokq8zpQ4cwNmi7VDK/cc2Vmm+9SmnMU1p8pkruuyiTr8ybVP1a+epn5xLd
        sXY5XqeWf824+JAYcWk1m8U0vT7sBdGF53Gj6mDTmL0udgMEWPMws0kILrOoPg==
From:   =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Kory Maincent <kory.maincent@bootlin.com>,
        thomas.petazzoni@bootlin.com, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org
Subject: [PATCH v3 0/2] Support new features to the SPEAr600
Date:   Tue, 15 Nov 2022 14:58:11 +0100
Message-Id: <20221115135814.214388-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kory Maincent <kory.maincent@bootlin.com>

This patches series adds two features of the SPEAr600 SOC:

- Enable the display controller

- Enable the SPI buses using the SSP controller

Changes in v2:
- Keep the I2C_CONFIG in the spear6xx_defconfig while enabling DRM.
- Send cover letter which was not sent in v1 due to a mistake in my git
  mail config.

The arm patches have been merged thanks to Arnd. Could you deal with the
clock patches to merged them through the clock tree?

Kory Maincent (2):
  clk: spear: Fix CLCD clock definition on SPEAr600
  clk: spear: Fix SSP clock definition on SPEAr600

 drivers/clk/spear/spear6xx_clock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1

