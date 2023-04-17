Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DBC6E4E15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDQQO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDQQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:14:28 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063665A0;
        Mon, 17 Apr 2023 09:14:26 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33HERTOx031184;
        Mon, 17 Apr 2023 18:14:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=hpxv9pdFDHR6CIak0LXWZo+m9Ge7QBsOuulrHTrxWbw=;
 b=JtLe6r9hqjLEG/Zl7wmzIk8RwaGMc7jgSVruvi4QcCE3CwObBEACmB+MvapAiTwn+V9l
 rChoRFO1i0S+SWtboRaeF1b/mu6uAsYjXW+4m6owkjwhpVU+O9DKMVJ+i2h+V49Wa2OV
 iYUP1Z5gpH4wX3UssMItQNK1J1ZxWIk78IVV/7KkmCwXIZpxzv+JQDdK3leYVl26LnvA
 V1SdZhWlrtjPkUtb2ZYs2rLBPWbH5gL0pOFFGOzQNWNda8uQUd5JsgNzc8ZJ7uAv2JhZ
 RnDGxRTUYd8RW7UyDudy6wXz7vUuq4REk5yNs+C1X4uG41hhovtn0NulEBYyHj/gYv8u yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q11n0uj9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 18:14:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D98E110002A;
        Mon, 17 Apr 2023 18:14:09 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CE15822F7B1;
        Mon, 17 Apr 2023 18:14:09 +0200 (CEST)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 17 Apr
 2023 18:14:09 +0200
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2] dt-bindings: mfd: stm32: Remove unnecessary blank lines
Date:   Mon, 17 Apr 2023 18:14:06 +0200
Message-ID: <20230417181342.v2.1.I483a676579cc7e3ac07e1db649091553743fecc8@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_10,2023-04-17_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove double blank line.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
- update commit title and commit message to reflect what the change is
  V1="dt-bindings: mfd: stm32: Fix STM32F4 DT include file"

 include/dt-bindings/mfd/stm32f4-rcc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/mfd/stm32f4-rcc.h b/include/dt-bindings/mfd/stm32f4-rcc.h
index 309e8c79f27b..36448a5619a1 100644
--- a/include/dt-bindings/mfd/stm32f4-rcc.h
+++ b/include/dt-bindings/mfd/stm32f4-rcc.h
@@ -34,7 +34,6 @@
 #define STM32F4_AHB1_RESET(bit) (STM32F4_RCC_AHB1_##bit + (0x10 * 8))
 #define STM32F4_AHB1_CLOCK(bit) (STM32F4_RCC_AHB1_##bit)
 
-
 /* AHB2 */
 #define STM32F4_RCC_AHB2_DCMI	0
 #define STM32F4_RCC_AHB2_CRYP	4
-- 
2.25.1

