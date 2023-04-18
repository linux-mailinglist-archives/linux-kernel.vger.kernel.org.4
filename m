Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7597F6E6758
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjDROng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjDROn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:43:27 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E6512CB4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:43:25 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IDaWqh031292;
        Tue, 18 Apr 2023 09:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=FhxnCwEMIKRj+m8KW5BRkRVM+8FCcfQ+ParKlZcL1zY=;
 b=lgDxZGWrUFpCQM8lwaDTZpJ0uUOtkxoFvI+0kA1om3uKKo5tdkCdhk8NUThU0pZx84j+
 CRCA/1NzzSrt93cMZeNRaXLcTY7iqBX4+0uT9HISugwXpx2ZacgPHFM3cTSfWzdPzEPH
 iWrJeSIJ0bGMpARl0LG+HTLqF/MeVnDzp7S266RYFAdlk7WLTZCPNykMEdDLcFUtcnTM
 Ow9aH+X1WBxMv1lrackxUlHc0S4MZUz3Hq+Qj6s5/vjCQewBhhSPk0tsqvQv+KqxOQtK
 dWOFPcTC5X337sITP8q1aPotYDb66VZAxMbcBEnYIEyFAAxHTpkc+8W4pXcFgPOuLQ2B sg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pysb4wm9n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:43:13 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 18 Apr
 2023 09:43:10 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Tue, 18 Apr 2023 09:43:10 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1990515B6;
        Tue, 18 Apr 2023 14:43:10 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/4] ASoC: cs35l56: Remove SDW2RX1 mixer source
Date:   Tue, 18 Apr 2023 15:43:08 +0100
Message-ID: <20230418144309.1100721-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418144309.1100721-1-rf@opensource.cirrus.com>
References: <20230418144309.1100721-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hQfokdPFYCiZM-2wKp0Eg-GdgKkNqlJP
X-Proofpoint-GUID: hQfokdPFYCiZM-2wKp0Eg-GdgKkNqlJP
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mixer source index value for SDW2RX1 is different between
A1 and B0 silicon. As the driver doesn't provide a DAI for SDW2
just remove it as a mixer source option.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 include/sound/cs35l56.h           | 3 +--
 sound/soc/codecs/cs35l56-shared.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index dd7503464651..0b2f7cfc6a4a 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -181,10 +181,9 @@
 #define CS35L56_INPUT_SRC_INTERPOLATOR			0x40
 #define CS35L56_INPUT_SRC_SWIRE_RX1			0x44
 #define CS35L56_INPUT_SRC_SWIRE_RX2			0x45
-#define CS35L56_INPUT_SRC_SWIRE_RX3			0x46
 #define CS35L56_INPUT_MASK				0x7F
 
-#define CS35L56_NUM_INPUT_SRC				22
+#define CS35L56_NUM_INPUT_SRC				21
 
 /* ASP formats */
 #define CS35L56_ASP_FMT_DSP_A				0
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index f5fa6bb04d38..93a1b056660b 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -278,7 +278,7 @@ const char * const cs35l56_tx_input_texts[] = {
 	"None", "ASP1RX1", "ASP1RX2", "VMON", "IMON", "ERRVOL", "CLASSH",
 	"VDDBMON", "VBSTMON", "DSP1TX1", "DSP1TX2", "DSP1TX3", "DSP1TX4",
 	"DSP1TX5", "DSP1TX6", "DSP1TX7", "DSP1TX8", "TEMPMON",
-	"INTERPOLATOR", "SDW1RX1", "SDW1RX2", "SDW2RX1",
+	"INTERPOLATOR", "SDW1RX1", "SDW1RX2",
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_tx_input_texts, SND_SOC_CS35L56_SHARED);
 
@@ -304,7 +304,6 @@ const unsigned int cs35l56_tx_input_values[] = {
 	CS35L56_INPUT_SRC_INTERPOLATOR,
 	CS35L56_INPUT_SRC_SWIRE_RX1,
 	CS35L56_INPUT_SRC_SWIRE_RX2,
-	CS35L56_INPUT_SRC_SWIRE_RX3,
 };
 EXPORT_SYMBOL_NS_GPL(cs35l56_tx_input_values, SND_SOC_CS35L56_SHARED);
 
-- 
2.30.2

