Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AF0707D11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjERJjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjERJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:39:35 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160A61724;
        Thu, 18 May 2023 02:39:33 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I8e9i7027959;
        Thu, 18 May 2023 04:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=F7NauNQpnxgJIyXYg1XkY4ZZR9nJ22jLMij/kvvUTj0=;
 b=fG/NkZKqu5BdX68PmyFI2c/sT5SQF/JVkxFw+NIGFdBYRAxs7fUnw12GSSnVtY14gXh/
 TjNGtgbY7JqEc8y1dLA/jei6+aEgVUilsrixg+uu1utcX2l4p8hh/s2ifKNr/Xai3ngd
 +1WHb3CJbeeGu/GF/ZemA5CBD2FVEAV05wxRF/0/tenR2+i/LbaL5Fk/hIsSItN7hkiE
 wF9rMZDQbRSkHxd+nqBwYEOnVhhZd3qIN3xa9WJJWd3Qxu74yJPjr54+/8f9UM6g/R9+
 v/r6CfyyAoNhK+iqPykNYgl26m8KPxGaYTH/yYmPoYlWbQencWAEDcuEJElm3/YpDjZX 9Q== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qngq1g26h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 04:39:28 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 18 May
 2023 04:39:27 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 May 2023 04:39:27 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3487815A2;
        Thu, 18 May 2023 09:39:27 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <srinivas.goud@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/2] spi: spi-cadence: Add missing kernel doc for clk_rate in cdns_spi
Date:   Thu, 18 May 2023 10:39:27 +0100
Message-ID: <20230518093927.711358-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
References: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UPrWn0n1H9OQBsUZyranobeSutYovUni
X-Proofpoint-ORIG-GUID: UPrWn0n1H9OQBsUZyranobeSutYovUni
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing kernel documentation to silence the build warning.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

New since v1 of the series, but might as well fix this build warning
too.

Thanks,
Charles

 drivers/spi/spi-cadence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 26e6633693196..de8fe3c5becbb 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -102,6 +102,7 @@
  * @regs:		Virtual address of the SPI controller registers
  * @ref_clk:		Pointer to the peripheral clock
  * @pclk:		Pointer to the APB clock
+ * @clk_rate:		Reference clock frequency, taken from @ref_clk
  * @speed_hz:		Current SPI bus clock speed in Hz
  * @txbuf:		Pointer	to the TX buffer
  * @rxbuf:		Pointer to the RX buffer
-- 
2.30.2

