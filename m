Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E60748AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbjGERp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjGERpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:45:19 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6B1199D;
        Wed,  5 Jul 2023 10:45:13 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365EwgO5010376;
        Wed, 5 Jul 2023 19:45:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=7joXDmQdoUHq1t1Rk3B57rM7FLGMUsyE4+cudEdqeEA=;
 b=DXa+reieRdm8TWRO+XddByZ8WOREoSs11J5yutgLxEz/BuBWHl7ytkzs96U2+LLmO64W
 PYqdf/j82ZkvcXJ/OkhQRNRD5QuFzMoSobgyWllFJ9TOkP5caL1pjalbhLfkaYK21o3e
 wClxcLaR5JOoqFt1uXHKmSoiPnAJWroEiBGpBkKqKKTzA52jrNtyIMPcRgdkHo7ob6Ys
 znDtWh+5pjsRmH0Ac/7gg5ghOOLW8nNwEKHpAb4kvNashoS5rRoHpMaUnGGQhIqACZhW
 iwIsS2nAwL6kWfZ0+iD0KVp0bu/jT/RrgBiGydPxKzpeKIlSTTFI4wzIAenbOs9LF5mU vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rn7wp2by3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 19:45:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57EFF100060;
        Wed,  5 Jul 2023 19:45:07 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 511A3252252;
        Wed,  5 Jul 2023 19:45:07 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 5 Jul
 2023 19:45:06 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Christophe Guibout <christophe.guibout@foss.st.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        <linux-rtc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 7/7] rtc: stm32: fix unnecessary parentheses
Date:   Wed, 5 Jul 2023 19:43:57 +0200
Message-ID: <20230705174357.353616-8-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230705174357.353616-1-valentin.caron@foss.st.com>
References: <20230705174357.353616-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_09,2023-07-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few style issues reported by checkpatch.pl:
- Unnecessary parentheses
- Lines should not end with a '('

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 drivers/rtc/rtc-stm32.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 836d39a124dd..85689192fa7a 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -163,10 +163,9 @@ static int stm32_rtc_enter_init_mode(struct stm32_rtc *rtc)
 		 * slowest rtc_ck frequency may be 32kHz and highest should be
 		 * 1MHz, we poll every 10 us with a timeout of 100ms.
 		 */
-		return readl_relaxed_poll_timeout_atomic(
-					rtc->base + regs->isr,
-					isr, (isr & STM32_RTC_ISR_INITF),
-					10, 100000);
+		return readl_relaxed_poll_timeout_atomic(rtc->base + regs->isr, isr,
+							 (isr & STM32_RTC_ISR_INITF),
+							 10, 100000);
 	}
 
 	return 0;
@@ -671,7 +670,7 @@ static int stm32_rtc_init(struct platform_device *pdev,
 	 * Can't find a 1Hz, so give priority to RTC power consumption
 	 * by choosing the higher possible value for prediv_a
 	 */
-	if ((pred_s > pred_s_max) || (pred_a > pred_a_max)) {
+	if (pred_s > pred_s_max || pred_a > pred_a_max) {
 		pred_a = pred_a_max;
 		pred_s = (rate / (pred_a + 1)) - 1;
 
-- 
2.25.1

