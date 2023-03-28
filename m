Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0096CBB98
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjC1J6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjC1J6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:58:31 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE12155B8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:30 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S815xv016265;
        Tue, 28 Mar 2023 04:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=0f29YZuHBtOS/sG+Zd9YapVHz5G8a79jjm4w1xfzFX8=;
 b=qVC4X0sYZUfG00H1epgic5cptRVOxGQ/RyrlZNF87gLA831sKKdvvdEGX0SiNsbqD8MO
 q1kksJiBZDARr1fSV49xHdAasksu0H9HniActAg0P7QdxJSX6MMsWEKjZ4oydXXsiLvr
 YiKkL1Z4b0F1rK+5jWF/kT8jJjzpP9w24JvmOhPdiw87rR1bKNE/TlyPBa6JBmRxFI4j
 WeEt40lMXTZFGoD00sKjNHy93f0GjtAJHvJTwOR+45uy6mK/COpR89WoTIiEYm/pF2Gx
 kRHL/Y7eqIogqq4AcQoeTv0ckcc3GNJ70MtnaecGNW2F4E5Svc4x219+JRoA4bKTf8e8 5A== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3phxc2kfw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 04:58:21 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Tue, 28 Mar
 2023 04:58:19 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Tue, 28 Mar 2023 04:58:19 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2ADA511D3;
        Tue, 28 Mar 2023 09:58:19 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <clamor95@gmail.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: wm8903: Remove outdated DMIC comment
Date:   Tue, 28 Mar 2023 10:58:19 +0100
Message-ID: <20230328095819.1632802-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6j9RyS3MjjFqx6Rv2RpSPxkU3JyD5rrW
X-Proofpoint-ORIG-GUID: 6j9RyS3MjjFqx6Rv2RpSPxkU3JyD5rrW
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for DMICs was added in commit 97945c46a23d ("ASoC: WM8903:
Implement DMIC support"). Remove them from the TODO list at the top of
the driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm8903.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 41346e5ec5ad4..1dc8e20bdace6 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -9,7 +9,6 @@
  *
  * TODO:
  *  - TDM mode configuration.
- *  - Digital microphone support.
  */
 
 #include <linux/module.h>
-- 
2.30.2

