Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BB465704E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 23:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiL0WuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 17:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiL0WuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 17:50:02 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B3F2644
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 14:49:59 -0800 (PST)
Received: (Authenticated sender: aniol@aniolmarti.cat)
        by mail.gandi.net (Postfix) with ESMTPSA id CB27520003;
        Tue, 27 Dec 2022 22:49:53 +0000 (UTC)
From:   =?UTF-8?q?Aniol=20Mart=C3=AD?= <aniol@aniolmarti.cat>
To:     linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        broonie@kernel.org
Cc:     =?UTF-8?q?Aniol=20Mart=C3=AD?= <aniol@aniolmarti.cat>
Subject: [PATCH] ASoC: amd: yc: Add ASUS M5402RA into DMI table
Date:   Tue, 27 Dec 2022 23:49:32 +0100
Message-Id: <20221227224932.9771-1-aniol@aniolmarti.cat>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS VivoBook 13 OLED (M5402RA) needs this quirk to get the built-in microphone working properly.

Signed-off-by: Aniol Martí <aniol@aniolmarti.cat>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1f0b5527c..1d4b1fa21 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -206,6 +206,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "UM5302TA"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M5402RA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.0

