Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D606D6F412B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjEBKVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjEBKVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:21:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA985270
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 03:20:57 -0700 (PDT)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ptn7v-0003h8-Jv; Tue, 02 May 2023 12:20:55 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] reset: starfive: select AUXILIARY_BUS
Date:   Tue,  2 May 2023 12:20:50 +0200
Message-Id: <20230502102050.1418417-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
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

CONFIG_AUXILIARY_BUS is not a user-visible symbol, replace 'depends on'
with 'select'.

Cc: Emil Renner Berthing <kernel@esmil.dk>
Cc: Hal Feng <hal.feng@starfivetech.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/starfive/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
index 1fa706a2c3dc..d832339f61bc 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -13,7 +13,8 @@ config RESET_STARFIVE_JH7100
 
 config RESET_STARFIVE_JH7110
 	bool "StarFive JH7110 Reset Driver"
-	depends on AUXILIARY_BUS && CLK_STARFIVE_JH7110_SYS
+	depends on CLK_STARFIVE_JH7110_SYS
+	select AUXILIARY_BUS
 	select RESET_STARFIVE_JH71X0
 	default ARCH_STARFIVE
 	help
-- 
2.39.2

