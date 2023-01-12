Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBE1667D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjALSAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjALR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:59:12 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7736B7DE0F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:18:55 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CF7JfC026944;
        Thu, 12 Jan 2023 11:18:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ArMJfZCoI2url2AxwRVVnsg3n7HD+bPZiz0UQ2O5vhM=;
 b=PMDedzQ7GhAN1V3l4MbJ68QtpXVrHpvAwO8EZNOYn8GD/rnitx7uz71+vpAWN7SXh8Cp
 DrhcDlhO6W6LsoBC0cWUi+tztUCICKTEzJqtEAjzWVr7gTfPMVXVLU3qK/ZanRjXAI3c
 2zTpIrtPufQ95XNG6lsQwQ3GzcjPUx4MMDqpiOag59HiTMhrTz8/ENXCJsXkRQjVPzrT
 N/+fdlZLKWghTpqDHUl56fmxpeos9LJLZX16QHpPtYCYAJ/X2Ye+5PIgu4gLTCeVbCPd
 YBmL+8SX97CgKbkE/CwIZJGFBTumRYFKG161B5UWfymDNanuqYaoP6+I2/VIh2nMP/9W VQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n1k582d2g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 11:18:42 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Thu, 12 Jan
 2023 11:18:40 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via Frontend
 Transport; Thu, 12 Jan 2023 11:18:40 -0600
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7709111CC;
        Thu, 12 Jan 2023 17:18:40 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/2] regmap: sdw: Update misleading comment
Date:   Thu, 12 Jan 2023 17:18:39 +0000
Message-ID: <20230112171840.2098463-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1uheCPGz_yVZ139-j_NluDOlGgJvUuW6
X-Proofpoint-GUID: 1uheCPGz_yVZ139-j_NluDOlGgJvUuW6
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the regmap config reg_bits represents the number of address bits not
the number of value bits. Correct the misleading comment which looks a
lot like it suggests the register value itself is 32-bits wide.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap-sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
index 81b0327f719d8..95801fd411b26 100644
--- a/drivers/base/regmap/regmap-sdw.c
+++ b/drivers/base/regmap/regmap-sdw.c
@@ -43,7 +43,7 @@ static int regmap_sdw_config_check(const struct regmap_config *config)
 	if (config->val_bits != 8)
 		return -ENOTSUPP;
 
-	/* Registers are 32 bits wide */
+	/* Register addresses are 32 bits wide */
 	if (config->reg_bits != 32)
 		return -ENOTSUPP;
 
-- 
2.30.2

