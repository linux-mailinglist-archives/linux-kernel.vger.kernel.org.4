Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976716C69B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjCWNlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCWNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:41:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F3B25E3A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:41:43 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NDPCGx014111;
        Thu, 23 Mar 2023 08:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=JlYzuzf3smpHHEx5583JSCrSZZLYGTCZLpAkAm8m6r8=;
 b=hWxvb43MwLijKUiD7Zp0qwDmAsboIA2cbxbG7iY0FI7Nv0clktxvvH6Q5ggNjyQg2ZGS
 2nP4krTKMwcxyaYsRumIOFRiIhI1M+GfUJWP/PMX8/y4yOqFxtFQSDqjfRkQCj1YX/qG
 Oo7wSA0N3+17PzOxkt/Fw117tz7oloxxWtNZeF7iw6bBWh6WHr+9fZElWJyYJF1gI5TV
 JfcvZ/gwZbfEywdqPW/g4hXvAzQTq/peYUbvRX9MwiAN4JWYasD1DQCEx9kmi9sbmaji
 zY/u1CbfL7CnDjNEPZmfA0w5mCuQuc82G2l+fOunFuYkhEvHyzZQ2wvSvSGYpBQSVSoe Cw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3pdaq36uxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 08:41:40 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 23 Mar
 2023 08:41:38 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 23 Mar 2023 08:41:38 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CC00B45;
        Thu, 23 Mar 2023 13:41:38 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mfd: arizona-spi: Add missing MODULE_DEVICE_TABLE
Date:   Thu, 23 Mar 2023 13:41:38 +0000
Message-ID: <20230323134138.834369-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: x1XMeva1wr4UEmh4wATIkngZP-gYrxTM
X-Proofpoint-GUID: x1XMeva1wr4UEmh4wATIkngZP-gYrxTM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition
which generates correct modalias for automatic loading
of this driver when it is built as a module.

Fixes: 3f65555c417c ("mfd: arizona: Split of_match table into I2C and SPI versions")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/arizona-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index da05b966d48c6..02cf4f3e91d76 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -277,6 +277,7 @@ static const struct of_device_id arizona_spi_of_match[] = {
 	{ .compatible = "cirrus,cs47l24", .data = (void *)CS47L24 },
 	{},
 };
+MODULE_DEVICE_TABLE(of, arizona_spi_of_match);
 #endif
 
 static struct spi_driver arizona_spi_driver = {
-- 
2.30.2

