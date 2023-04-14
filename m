Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CAA6E2461
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDNNiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDNNiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:38:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A77393D1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:38:11 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EDVEAR030487;
        Fri, 14 Apr 2023 08:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ZKLDYdqiwNsuno7oSYA6GXFb/H2zvvzG87rB48aUcGs=;
 b=piHmnytf3PPnrmyapz9AMndVHcNqy0u746yyJNFhzqUDIspeAS3EFi8wiYRMpUarocFH
 lndzPYKlbDmGm7ShK+gCfqJ5/8ShlKao/TQ4kc2OQCTEOb96ytVyDQj6hRuT180CqZb0
 bbH+YmqahErdYwArvNDZt3LBRr3G27j2OzIDu3nKREx7vEw96RCzukFXyCzRiK1DeQpX
 GA+Ans7hmP/8rVTxVrvNgksyVZPT3712F++iIsVonQMG8q/A3fcjEp1fOnDMUjKqj0mb
 wB29UcKQJpkuDusAiZ+s1tB1XxFJkjUPx5JHA+TAkvo94gzMGEwjyskv0TpoHohesyaD rQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pu5p3sexy-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 08:37:59 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 14 Apr
 2023 08:37:54 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 14 Apr 2023 08:37:54 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3981C3561;
        Fri, 14 Apr 2023 13:37:54 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 5/5] ASoC: cs35l56: Don't return a value from cs35l56_remove()
Date:   Fri, 14 Apr 2023 14:37:53 +0100
Message-ID: <20230414133753.653139-6-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230414133753.653139-1-rf@opensource.cirrus.com>
References: <20230414133753.653139-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Fr5d0BIXTGBfRA4nFc6Mgfb4nMqCehG2
X-Proofpoint-GUID: Fr5d0BIXTGBfRA4nFc6Mgfb4nMqCehG2
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

cs35l56_remove() always returns 0. Two of the functions that call
it are void and the other one should only return 0. So there's no
point returning anything from cs35l56_remove().

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-sdw.c | 4 +++-
 sound/soc/codecs/cs35l56.c     | 4 +---
 sound/soc/codecs/cs35l56.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index e759347423cf..2cde78605ba9 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -527,7 +527,9 @@ static int cs35l56_sdw_remove(struct sdw_slave *peripheral)
 	sdw_read_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1);
 	sdw_write_no_pm(peripheral, CS35L56_SDW_GEN_INT_STAT_1, 0xFF);
 
-	return cs35l56_remove(cs35l56);
+	cs35l56_remove(cs35l56);
+
+	return 0;
 }
 
 static const struct dev_pm_ops cs35l56_sdw_pm = {
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 5f66a8e20b2d..0f4a94b02ef8 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1590,7 +1590,7 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_init, SND_SOC_CS35L56_CORE);
 
-int cs35l56_remove(struct cs35l56_private *cs35l56)
+void cs35l56_remove(struct cs35l56_private *cs35l56)
 {
 	cs35l56->init_done = false;
 
@@ -1613,8 +1613,6 @@ int cs35l56_remove(struct cs35l56_private *cs35l56)
 
 	gpiod_set_value_cansleep(cs35l56->reset_gpio, 0);
 	regulator_bulk_disable(ARRAY_SIZE(cs35l56->supplies), cs35l56->supplies);
-
-	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_remove, SND_SOC_CS35L56_CORE);
 
diff --git a/sound/soc/codecs/cs35l56.h b/sound/soc/codecs/cs35l56.h
index 09762e70ce81..1f7894662fcb 100644
--- a/sound/soc/codecs/cs35l56.h
+++ b/sound/soc/codecs/cs35l56.h
@@ -76,6 +76,6 @@ irqreturn_t cs35l56_irq(int irq, void *data);
 int cs35l56_irq_request(struct cs35l56_private *cs35l56, int irq);
 int cs35l56_common_probe(struct cs35l56_private *cs35l56);
 int cs35l56_init(struct cs35l56_private *cs35l56);
-int cs35l56_remove(struct cs35l56_private *cs35l56);
+void cs35l56_remove(struct cs35l56_private *cs35l56);
 
 #endif /* ifndef CS35L56_H */
-- 
2.30.2

