Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802646E9003
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjDTKWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbjDTKVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:21:40 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D2D12D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:21:01 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K6k6i2003201;
        Thu, 20 Apr 2023 05:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=nJJCPXtIl/C6W952avjlhhnaG4LWw3Zy1vAZkrF7DVE=;
 b=posfeQSJ45pfCwFvSdJO495aeRAHsRvhhONuUrgs56ra9NjF+/SC7KpdF2MDCQCIfZhq
 N5pPTsvthNpeUFJMT1s/SVo9e6wcPIofB2rcDLyMWjLH5ScfQnGdbovx/bIKbZEl34vJ
 IPQvj5RxNneMEjqDo7ppC1WlZvbwArUcpG8W5TAYHvzWHwpO3KtcfU/qk+5QNwIa1hUe
 ph2Sb071UaArcF6/optPj7jIEE9xy8NpAJiut5zYULC+6B33fFhCu2ums9ILDhQRiqPH
 abGdt+nnHQyCTvlPmFOiiSTD0CB7ytrJteKDGbpJ2rfBRl+AdBHfZ+pC/QpyBPja4L6z hA== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pysb50sp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 05:20:45 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 20 Apr
 2023 05:20:43 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 20 Apr 2023 05:20:43 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 79A3BB06;
        Thu, 20 Apr 2023 10:20:43 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs35l56: Remove duplicate mbox log messages
Date:   Thu, 20 Apr 2023 11:20:43 +0100
Message-ID: <20230420102043.1151830-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6pTqnTm8T_0HTfbl5ajo1im30LO2lRZF
X-Proofpoint-GUID: 6pTqnTm8T_0HTfbl5ajo1im30LO2lRZF
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

cs35l56_mbox_send() logs a warning when sending a mbox command fails so
the callers can be simplified.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index c0a857cfb8cb..46762f7f1449 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -859,10 +859,8 @@ static void cs35l56_dsp_work(struct work_struct *work)
 	}
 
 	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_SHUTDOWN);
-	if (ret) {
-		dev_dbg(cs35l56->dev, "%s: CS35L56_MBOX_CMD_SHUTDOWN ret %d\n", __func__, ret);
+	if (ret)
 		goto err;
-	}
 
 	if (cs35l56->rev < CS35L56_REVID_B0)
 		reg = CS35L56_DSP1_PM_CUR_STATE_A1;
@@ -1033,9 +1031,7 @@ int cs35l56_runtime_suspend(struct device *dev)
 	 * Enable auto-hibernate. If it is woken by some other wake source
 	 * it will automatically return to hibernate.
 	 */
-	ret = cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE);
-	if (ret)
-		dev_warn(cs35l56->dev, "ALLOW_HIBERNATE failed: %d\n", ret);
+	cs35l56_mbox_send(cs35l56, CS35L56_MBOX_CMD_ALLOW_AUTO_HIBERNATE);
 
 	/*
 	 * Must enter cache-only first so there can't be any more register
-- 
2.30.2

