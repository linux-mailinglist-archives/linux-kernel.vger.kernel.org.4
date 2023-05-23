Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22DD70D84E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbjEWJBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbjEWJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:01:38 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00A2FE;
        Tue, 23 May 2023 02:01:36 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N4xakw013915;
        Tue, 23 May 2023 04:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=YktBqmQZtM7nktCdMFTj23dyhlDTH14HCoDW43SGwt0=;
 b=Ov1Kw+XX8dI/lVars0SOP8Cas+nay5g1jWc7YiieY9nttR6KwUHbMYaJ+qI4XGnogpC6
 /Th+3TB2aIfX7YDhUvEixLs2CMlETucemd6kr2vH+yOzS8M92OK+NAO3FfUa+EwGj2nm
 RA2nrolj6eKBwZRTuVXuKVijgEypo7Lb6W+0O2hQC00y4t0Dk9SoghNwuCUJLWQy2rgV
 MCVA9LdXltsVY1b26L0N0kggQTRyGVOTfRaCJCIKX1g7OrLF+O/8jlxL1056R511w3ck
 LsUtUeI1aOUTPx4fhGyGcu89dSQ+EMcpwzDboFczhuW6GTdhPZpriYHbhw/iLHUngiBb Wg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm3bqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 04:01:26 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Tue, 23 May
 2023 04:01:24 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 23 May 2023 04:01:24 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8FADD11D4;
        Tue, 23 May 2023 09:01:24 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <srinivas.goud@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH v3] spi: spi-cadence: Add missing kernel doc for clk_rate in cdns_spi
Date:   Tue, 23 May 2023 10:01:24 +0100
Message-ID: <20230523090124.3132-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FVd5FCaL-vt9Z9Ek2Ign4BDia0Tzqhop
X-Proofpoint-GUID: FVd5FCaL-vt9Z9Ek2Ign4BDia0Tzqhop
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

Add the missing kernel documentation to silence the build warning.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Just splitting the patch out to fix my omitting v2 in the title.

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

