Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F1B64F08C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiLPRoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiLPRoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:44:00 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5198B6F0DC;
        Fri, 16 Dec 2022 09:43:58 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGD9nes005797;
        Fri, 16 Dec 2022 18:43:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=mloTfjScbE+KvHcb3ds6SBjdWfKRWzgGZsYJkOZEgeQ=;
 b=I4mxbjHELI8vdtBU2UVky0/4I+DC+eSOxcBoz7S93WqM5JjJY/XGI3M26xAjBQrc448Q
 Lvtt4zTu7HIvm8qgVrBMhBdYiHC/jSGlXRyw9w6FbousAPkdduVG80+22S426rg5octX
 Gmt4tWOBrs2bfmsWGHlUFBPeQZ8BdqUrW5VqycdPHEjOy/in/Atow09sXEHZ7H9Jm4v6
 xKm7ZHJuBrGQr5yIFb050DPzFzzMT35tmBZSWr2eLCgssLQwQMGS38pEAkj+m9kqo9L5
 AueJg+CsrlOAC8o1bmGKJpLZdtrY49Shi5/hjpF+BaRHJzNgu+L5Y6jeqxE06oCMTaWV XA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mf6uskc17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 18:43:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A9F27100038;
        Fri, 16 Dec 2022 18:43:37 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A3A9F22D19D;
        Fri, 16 Dec 2022 18:43:37 +0100 (CET)
Received: from localhost (10.48.0.157) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Fri, 16 Dec
 2022 18:43:36 +0100
From:   Patrick Delaunay <patrick.delaunay@foss.st.com>
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Fabrice GASNIER <fabrice.gasnier@foss.st.com>,
        Amelie DELAUNAY <amelie.delaunay@foss.st.com>,
        Lionel DEBIEVE <lionel.debieve@foss.st.com>,
        Etienne CARRIERE <etienne.carriere@linaro.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v3 1/3] ARM: dts: stm32mp13: fix compatible for BSEC
Date:   Fri, 16 Dec 2022 18:43:27 +0100
Message-ID: <20221216182621.v3.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216174330.1506454-1-patrick.delaunay@foss.st.com>
References: <20221216174330.1506454-1-patrick.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.0.157]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_12,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct compatible for stm32mp13 support.

The BSEC driver for STM32MP15x is not compatible with STM32MP13x. For
example the proprietary's smc STM32_SMC_BSEC is not supported in
STM32MP13x OP-TEE, it is replaced by SM32MP BSEC Pseudo Trusted
Application in OP-TEE to access to the secured IP BSEC on STM32MP13X SoC.

The correct compatible is already used in U-Boot and in upstream is in
progress for OP-TEE device tree.

As the SoC STM32MP13X is not yet official and it is not available
outside STMicroelectronics, it is the good time to break the DTS
compatibility and to correct the error done in the introduction of
STM32MP131.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---
This patch is already sent separately in:
https://lore.kernel.org/all/20221017134437.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid/
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685815

I create a serie for more efficient review.

Patrick.

(no changes since v1)

Changes in v1:
- update commit message to indicate DTS break reason.

 arch/arm/boot/dts/stm32mp131.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index 2a9b3a5bba83..f034cbe0d5b2 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -522,7 +522,7 @@ rtc: rtc@5c004000 {
 		};
 
 		bsec: efuse@5c005000 {
-			compatible = "st,stm32mp15-bsec";
+			compatible = "st,stm32mp13-bsec";
 			reg = <0x5c005000 0x400>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1

