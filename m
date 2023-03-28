Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6816CC6C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbjC1PkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjC1Pjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:39:51 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057FEC76;
        Tue, 28 Mar 2023 08:38:25 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SE37H0016277;
        Tue, 28 Mar 2023 17:37:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=+2s3HinxEFYlnrVOOc1wZG7xm3r63KTSzXlu+4OWoMY=;
 b=xOrIHT/yJ3WS5CO8Jip6a0ikT5GTWdQlmJUO+ykXn13kh6+Nl8vBnGc84vopsTxep3AM
 Qs/QnNOy7vuOY+hOTtW9Bcr/PlLUB3/FGTUM043Rapt/S1GC28DrbcqzWBCVbUF8k/e3
 V0Mu/NMg7mWI2rxf8npzPL813ObFi7mX6Xs39wMw2CxGGlLzRJcxx7iQU0RUiv4h7agd
 zuiaf1GaguKpyunLhYV5xBNhXV5Wwye8UQAf6MdcPfTlZXLsxqYCm6CfvfF3SZOY8pFb
 H5uO91+n8nPq7way3Mfj3iraOC//wIdlPOqkmAIFezFrHr0mK2jGCilnhs4DWoLKbOZ/ YQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pkwvsaamx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 17:37:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DDDF410002A;
        Tue, 28 Mar 2023 17:37:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D65462194F9;
        Tue, 28 Mar 2023 17:37:37 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 17:37:37 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] ARM: dts: stm32: clean uart aliases on stm32mp15xx-dkx boards
Date:   Tue, 28 Mar 2023 17:37:19 +0200
Message-ID: <20230328153723.498672-3-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328153723.498672-1-valentin.caron@foss.st.com>
References: <20230328153723.498672-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicates and clean uart aliases.
Uart aliases and uart pins should be declared and associated to
uart instance at the same time.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1.dts  | 3 ---
 arch/arm/boot/dts/stm32mp157c-dk2.dts  | 3 ---
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 6 ++++++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1.dts b/arch/arm/boot/dts/stm32mp157a-dk1.dts
index 4c8be9c8eb20..0da3667ab1e0 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1.dts
@@ -17,9 +17,6 @@ / {
 
 	aliases {
 		ethernet0 = &ethernet0;
-		serial0 = &uart4;
-		serial1 = &usart3;
-		serial2 = &uart7;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/stm32mp157c-dk2.dts b/arch/arm/boot/dts/stm32mp157c-dk2.dts
index 2bc92ef3aeb9..ab13e340f4ef 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2.dts
@@ -18,9 +18,6 @@ / {
 
 	aliases {
 		ethernet0 = &ethernet0;
-		serial0 = &uart4;
-		serial1 = &usart3;
-		serial2 = &uart7;
 		serial3 = &usart2;
 	};
 
diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
index 11370ae0d868..ded5ab9a4798 100644
--- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
@@ -8,6 +8,12 @@
 #include <dt-bindings/mfd/st,stpmic1.h>
 
 / {
+	aliases {
+		serial0 = &uart4;
+		serial1 = &usart3;
+		serial2 = &uart7;
+	};
+
 	memory@c0000000 {
 		device_type = "memory";
 		reg = <0xc0000000 0x20000000>;
-- 
2.25.1

