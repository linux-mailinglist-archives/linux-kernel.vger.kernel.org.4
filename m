Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CBD6ADD34
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCGLX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjCGLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:23:55 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34FF2F78E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:23:47 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:b745:671d:a946:57fa])
        by xavier.telenet-ops.be with bizsmtp
        id VPPk290024LuvSS01PPkuL; Tue, 07 Mar 2023 12:23:44 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZVPT-00B9xy-0H;
        Tue, 07 Mar 2023 12:23:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pZVPz-007DjK-Qz;
        Tue, 07 Mar 2023 12:23:43 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] regulator: rt5739: Spelling s/Rcihtek/Richtek/
Date:   Tue,  7 Mar 2023 12:23:42 +0100
Message-Id: <05f26d8e1e527f8b3fd2828f75ce2174e19c69e7.1678188171.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "Richtek".

Fixes: 4536f3b93a3373ca ("regulator: Add support for Richtek RT5739 voltage regulator")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index f76d47c9bd2e4e59..2d95a071f2004710 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1128,7 +1128,7 @@ config REGULATOR_RT5190A
 	  I2C control interface.
 
 config REGULATOR_RT5739
-	tristate "Rcihtek RT5739 Regulator"
+	tristate "Richtek RT5739 Regulator"
 	depends on I2C
 	select REGMAP_I2C
 	help
-- 
2.34.1

