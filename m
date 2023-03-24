Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78056C81D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjCXPwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCXPww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:52:52 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8786610A96
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:52:49 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OFkx41016287;
        Fri, 24 Mar 2023 16:52:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=lPzs3gk0GyXmQ2Aftj9Ob2Edm9JcZ5gvy9kTYjlmsyw=;
 b=vb3QJElMqA4/yraJ9RhyUE5Y7R/ndem/jA7ohUskL51s5NCgj7A9a+UHDRsXkOMd0WUk
 4tobmyuBWrA+5YBR1nmNp0EAPD6v9I4/3zmb0CjnEI4R5CAQUGOaN+TFQQn7m1O3wkMf
 nbdWUBo0kKQwTZ/lUllecWyBhEIBqtTLNsR5eVmRzGHh015hRWdIEFXJkULNlqRVQq9i
 0c3+eUlLwqqeaFD3Ek6LOE8esHzWeVvdVCTifQHp09dqC4+2HtI4iZ67QHV1kthnIJx8
 ClbqWMcVgBOAKFGc2m9AhymbAjDs7ZHDExJoYDjk4KplOH/jQ/TC89TssU0lyIXMgp+l qg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pgxjedkxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 16:52:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 19D86100038;
        Fri, 24 Mar 2023 16:52:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ACC11218627;
        Fri, 24 Mar 2023 16:51:42 +0100 (CET)
Received: from localhost (10.48.0.175) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 24 Mar
 2023 16:51:42 +0100
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <krzysztof.kozlowski@linaro.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Subject: [PATCH 1/2] memory: stm32-fmc2-ebi: depends on ARCH_STM32 instead of MACH_STM32MP157
Date:   Fri, 24 Mar 2023 16:51:04 +0100
Message-ID: <20230324155105.826063-2-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324155105.826063-1-christophe.kerello@foss.st.com>
References: <20230324155105.826063-1-christophe.kerello@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.175]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_10,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to compile the driver on all STM32MP SOCs, we move the
"depends on" on ARCH_STM32.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/memory/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index fac290e48e0b..91774e6ee624 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -228,7 +228,7 @@ config RENESAS_RPCIF
 
 config STM32_FMC2_EBI
 	tristate "Support for FMC2 External Bus Interface on STM32MP SoCs"
-	depends on MACH_STM32MP157 || COMPILE_TEST
+	depends on ARCH_STM32 || COMPILE_TEST
 	select MFD_SYSCON
 	help
 	  Select this option to enable the STM32 FMC2 External Bus Interface
-- 
2.25.1

