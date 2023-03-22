Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDE86C5133
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCVQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjCVQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:50:10 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE7552929
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:50:09 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MFxWd0007640;
        Wed, 22 Mar 2023 11:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=xU77L1DhmwOBMrIJK1CMd8sTafQKeSs0GDkVlRY+tSA=;
 b=QT3qIW7bdl5pgA1a/1V+pRuZNBKN5j5NjM9szi9BpongkQUebBKjYMPrXpmICbTLXSgh
 aqldc7+Bzs9gQTBUdOJMfqjzP4BfjbU0bShfA2RpQBCLWWC7jvUkkyI83Jo5FB6SAkHL
 uKchwkgvRYWgdgs4IoZCX2+c/tWYKAzo7bW/V68LdJvscsnIbx3LwEtr5iPwGlPo6P1l
 zP6+8gJp2rY1LL+uvwYn6WH0iGAfmt5oGcwLAclYN8A5Nkd6HEH3VENmRzra8kzQB7mS
 NvvhF+Ca/9159YAr9tdh1FNZPq6apUZU+nTzLrFBHFFJR7UcryykfesXf5XFlstGG3Mp YA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pdaq35kar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 11:49:50 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Wed, 22 Mar
 2023 11:49:48 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Wed, 22 Mar 2023 11:49:48 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8CD3211AD;
        Wed, 22 Mar 2023 16:49:48 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/3] soundwire: bus: Remove now outdated comments on no_pm IO
Date:   Wed, 22 Mar 2023 16:49:46 +0000
Message-ID: <20230322164948.566962-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gc9VZvqwApyLX6zgr3M4Hfdy5AD5emev
X-Proofpoint-GUID: gc9VZvqwApyLX6zgr3M4Hfdy5AD5emev
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

No change since v1.

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

