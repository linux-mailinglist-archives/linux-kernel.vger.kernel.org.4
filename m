Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA41A697A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjBOK6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjBOK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:58:28 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84A8366B5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 02:58:25 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F5IwDJ010319;
        Wed, 15 Feb 2023 04:58:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=VBvQDeOV5YaSl7jvF5C3bzhYnNbHoE0OvozmqhW3pKA=;
 b=DFg+Ydf4hXRmyF4WCPn3cjY3NRkhF4d0d0vHNvNR7hS1fyKozwP8YsaPqjiki43+T8Lu
 qk8ctTerDD9F7LVoETfY8bU6FM2JXKAew5mRT7dKDD5JinbVfrBCGthoNEcHLFB9e2gn
 Gr4OfxmNYkk3TD3kuF3j2dQyeeOjSSU+8lyJchxoZrip8f+JPsSGjfURf5v0xP95XeoJ
 ZBXtn2QqCxaL/2TptvzPDwCuG/HSwlY8uoQz/EP4Sy2vjo4msPuPtGqqcdEg46PDF3rG
 gt43IT4St9vD9PEd8V//xGn/J7ul5NLJPendVtIje0qI4R/zDHsNwcT1mxzO0Q095cjw KQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3nrm8wgkmm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 04:58:20 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Wed, 15 Feb
 2023 04:58:18 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.21 via Frontend Transport; Wed, 15 Feb 2023 04:58:18 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E51A011A8;
        Wed, 15 Feb 2023 10:58:17 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: cs35l45: Remove separate namespace for tables
Date:   Wed, 15 Feb 2023 10:58:18 +0000
Message-ID: <20230215105818.3315925-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230215105818.3315925-1-ckeepax@opensource.cirrus.com>
References: <20230215105818.3315925-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Eyh-4LVRfZWAn6TMMzV3XEZEjAYZ_9eN
X-Proofpoint-ORIG-GUID: Eyh-4LVRfZWAn6TMMzV3XEZEjAYZ_9eN
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now tables isn't a separate module, definitely no need to have a
separate namespace for it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45-i2c.c    | 1 -
 sound/soc/codecs/cs35l45-spi.c    | 1 -
 sound/soc/codecs/cs35l45-tables.c | 8 ++++----
 sound/soc/codecs/cs35l45.c        | 1 -
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs35l45-i2c.c b/sound/soc/codecs/cs35l45-i2c.c
index 39d28641429e4..1117df4b2f118 100644
--- a/sound/soc/codecs/cs35l45-i2c.c
+++ b/sound/soc/codecs/cs35l45-i2c.c
@@ -71,4 +71,3 @@ MODULE_DESCRIPTION("I2C CS35L45 driver");
 MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_IMPORT_NS(SND_SOC_CS35L45);
-MODULE_IMPORT_NS(SND_SOC_CS35L45_TABLES);
diff --git a/sound/soc/codecs/cs35l45-spi.c b/sound/soc/codecs/cs35l45-spi.c
index baaf6e0f4fb9d..ffaca07fb2679 100644
--- a/sound/soc/codecs/cs35l45-spi.c
+++ b/sound/soc/codecs/cs35l45-spi.c
@@ -71,4 +71,3 @@ MODULE_DESCRIPTION("SPI CS35L45 driver");
 MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_IMPORT_NS(SND_SOC_CS35L45);
-MODULE_IMPORT_NS(SND_SOC_CS35L45_TABLES);
diff --git a/sound/soc/codecs/cs35l45-tables.c b/sound/soc/codecs/cs35l45-tables.c
index 5a2f47ca57716..4b1320a2e6e97 100644
--- a/sound/soc/codecs/cs35l45-tables.c
+++ b/sound/soc/codecs/cs35l45-tables.c
@@ -38,7 +38,7 @@ int cs35l45_apply_patch(struct cs35l45_private *cs35l45)
 	return regmap_register_patch(cs35l45->regmap, cs35l45_patch,
 				     ARRAY_SIZE(cs35l45_patch));
 }
-EXPORT_SYMBOL_NS_GPL(cs35l45_apply_patch, SND_SOC_CS35L45_TABLES);
+EXPORT_SYMBOL_NS_GPL(cs35l45_apply_patch, SND_SOC_CS35L45);
 
 static const struct reg_default cs35l45_defaults[] = {
 	{ CS35L45_BLOCK_ENABLES,		0x00003323 },
@@ -126,7 +126,7 @@ const struct regmap_config cs35l45_i2c_regmap = {
 	.readable_reg = cs35l45_readable_reg,
 	.cache_type = REGCACHE_RBTREE,
 };
-EXPORT_SYMBOL_NS_GPL(cs35l45_i2c_regmap, SND_SOC_CS35L45_TABLES);
+EXPORT_SYMBOL_NS_GPL(cs35l45_i2c_regmap, SND_SOC_CS35L45);
 
 const struct regmap_config cs35l45_spi_regmap = {
 	.reg_bits = 32,
@@ -142,7 +142,7 @@ const struct regmap_config cs35l45_spi_regmap = {
 	.readable_reg = cs35l45_readable_reg,
 	.cache_type = REGCACHE_RBTREE,
 };
-EXPORT_SYMBOL_NS_GPL(cs35l45_spi_regmap, SND_SOC_CS35L45_TABLES);
+EXPORT_SYMBOL_NS_GPL(cs35l45_spi_regmap, SND_SOC_CS35L45);
 
 static const struct {
 	u8 cfg_id;
@@ -195,4 +195,4 @@ unsigned int cs35l45_get_clk_freq_id(unsigned int freq)
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL_NS_GPL(cs35l45_get_clk_freq_id, SND_SOC_CS35L45_TABLES);
+EXPORT_SYMBOL_NS_GPL(cs35l45_get_clk_freq_id, SND_SOC_CS35L45);
diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index d15b3b77c7eb0..855d9f13e6ff1 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -687,4 +687,3 @@ MODULE_DESCRIPTION("ASoC CS35L45 driver");
 MODULE_AUTHOR("James Schulman, Cirrus Logic Inc, <james.schulman@cirrus.com>");
 MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_IMPORT_NS(SND_SOC_CS35L45_TABLES);
-- 
2.30.2

