Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3A26E6753
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjDROnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDROnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:43:22 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623D293F9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:43:20 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I523hv019087;
        Tue, 18 Apr 2023 09:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=poQt733VgDpa+DABEm8TM7onc2muLJKkyj5gMLuS0QU=;
 b=G+9nT64nssv5Flyyshw8y/xQUVvp8YZowW2IlTY+eaY+WddoiMTdvbs0l05trDxRqofS
 AO8HmSo2lJaU3XEH/rd1uQMt7oC32bHUn9/oOm7BNefzKhsRjOmnaXUnGPUQf9jKYFJQ
 izLQqy7M3b7xRF1Wi53ls8qFVoQsuuLfN4lHrkuvsxHj6Kjwv1tKEcuvMXigxlrEEVj5
 9MKwkWRtG9ngF3Z4sDT078P87jhG7K3l7YmBApbSJjObNqv/SCMt7gyQHmjO7hS+2RMP
 DEMB/vZTO3lh/AO3ofH5RYOOjCAux1q1rdtXNexXXvWyYHNSqFr9g4kr6HCKtEwFbcnm tw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pyrbpxftd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 09:43:11 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 18 Apr
 2023 09:43:10 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Apr 2023 09:43:10 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.127])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id EEDE311DC;
        Tue, 18 Apr 2023 14:43:09 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/4] ASoC: cs35l56: Update comment on masking of EINT20 interrupts
Date:   Tue, 18 Apr 2023 15:43:06 +0100
Message-ID: <20230418144309.1100721-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418144309.1100721-1-rf@opensource.cirrus.com>
References: <20230418144309.1100721-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IyCQfYhAggD8HspKoxcMxnuSBZjfqaeu
X-Proofpoint-ORIG-GUID: IyCQfYhAggD8HspKoxcMxnuSBZjfqaeu
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

EINT20 contains wake-source interrupts and also interface-blocked
interrupts, which all default to unmasked after reset or wake.

The comment in cs35l56_init() only mentioned the wake interrupts.
Update the comment so it's clear that it's intentional to also
mask the *_BLOCKED interrupts.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 0f4a94b02ef8..1b80cae5026e 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1537,7 +1537,7 @@ int cs35l56_init(struct cs35l56_private *cs35l56)
 
 	cs35l56_patch(cs35l56->dev, cs35l56->regmap, cs35l56->rev);
 
-	/* Wake source interrupts default to unmasked, so mask them */
+	/* Wake source and *_BLOCKED interrupts default to unmasked, so mask them */
 	regmap_write(cs35l56->regmap, CS35L56_IRQ1_MASK_20, 0xffffffff);
 	regmap_update_bits(cs35l56->regmap, CS35L56_IRQ1_MASK_1,
 			   CS35L56_AMP_SHORT_ERR_EINT1_MASK,
-- 
2.30.2

