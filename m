Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EFE6BD479
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjCPP5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjCPP5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:57:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08DC848FC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:57:49 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GFplkA021731;
        Thu, 16 Mar 2023 10:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=DBXtww78yw07xf9T00m7b4gxjriMUFYYNxflYL9yAX0=;
 b=P++aAizvRUKMh9a5zG+BIjh0ItErYLQgnujmolCAIUFOMPaWEzWDjYtHjUHB4JNZ9v2t
 SLe6KSjzzjZZHbHEN12GIT/bX2bOwhdueB94hojxZ2BH52e07TBZ9/TLAGfsEK68NfXg
 nCc2Iqa6Xnh+7Y1/CHPAilo2vIA6v1EczhY177L6ZsnoWZp7ijqhjmCcm6xiJWOJbwY1
 VpFhelTZiGSlKHApblgedBKic9jmzCp7A9sXUY6S3Upi8lLAp6w8abAR/BilYruZSOtK
 cgLANeNU1WElyDwqIvXQ/ffG/8qb2yOhfeiQlLnDXT4wpITY9416WXVOoSMtdKjab0p5 dA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pbs3b8qyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 10:57:36 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 16 Mar
 2023 10:57:34 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 16 Mar 2023 10:57:34 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 105C811AD;
        Thu, 16 Mar 2023 15:57:34 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 1/2] soundwire: bus: Remove now outdated comments on no_pm IO
Date:   Thu, 16 Mar 2023 15:57:33 +0000
Message-ID: <20230316155734.3191577-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4al91LoX_baKzo5Y6d5dK3uo_Ah7pDJI
X-Proofpoint-ORIG-GUID: 4al91LoX_baKzo5Y6d5dK3uo_Ah7pDJI
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things have moved more towards end drivers using the no_pm versions of
the IO functions. See commits:

commit 167790abb90f ("soundwire: export sdw_write/read_no_pm functions")
commit 62dc9f3f2fd0 ("soundwire: bus: export sdw_nwrite_no_pm and
                      sdw_nread_no_pm functions")

As such this comment is now misleading, so remove it.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/soundwire/bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index b6aca59c31300..3c67266f94834 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -384,9 +384,6 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 
 /*
  * Read/Write IO functions.
- * no_pm versions can only be called by the bus, e.g. while enumerating or
- * handling suspend-resume sequences.
- * all clients need to use the pm versions
  */
 
 int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
-- 
2.30.2

