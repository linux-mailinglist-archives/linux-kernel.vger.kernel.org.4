Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3E86313EC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 13:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKTMmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 07:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKTMme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 07:42:34 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E849A10AC;
        Sun, 20 Nov 2022 04:42:29 -0800 (PST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id EC6895FCEB;
        Sun, 20 Nov 2022 13:42:27 +0100 (CET)
From:   Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Edmund Berenson <edmund.berenson@emlix.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: adc: ad7923: Add ad7927
Date:   Sun, 20 Nov 2022 13:42:04 +0100
Message-Id: <20221120124205.14462-1-edmund.berenson@emlix.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221116191056.59f901da@jic23-huawei>
References: <20221116191056.59f901da@jic23-huawei>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ID for ad7927 which is compatible with existing ad7928 driver.

Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
---
 drivers/iio/adc/ad7923.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 9d6bf6d0927a..df72e97dc331 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7928 SPI ADC driver
+ * AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7927/AD7928 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
  * Copyright 2012 CS Systemes d'Information
@@ -367,6 +367,7 @@ static const struct spi_device_id ad7923_id[] = {
 	{"ad7924", AD7924},
 	{"ad7908", AD7908},
 	{"ad7918", AD7918},
+	{"ad7927", AD7928},
 	{"ad7928", AD7928},
 	{}
 };
@@ -379,6 +380,7 @@ static const struct of_device_id ad7923_of_match[] = {
 	{ .compatible = "adi,ad7924", },
 	{ .compatible = "adi,ad7908", },
 	{ .compatible = "adi,ad7918", },
+	{ .compatible = "adi,ad7927", },
 	{ .compatible = "adi,ad7928", },
 	{ },
 };
-- 
2.37.4

