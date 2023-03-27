Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA16CA949
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjC0Pkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjC0Pke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:40:34 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A848B213A;
        Mon, 27 Mar 2023 08:40:33 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RC7kVt014184;
        Mon, 27 Mar 2023 17:40:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=FKaGslI7jPasSK/fcfNSrjsxE74p6Mh867fEXA6JvJs=;
 b=ZCKR+/olToF3RZTglWb6vobrQQFvinWW/3N0H48STl92MAM/Dy3e5TNQQnEdwSAY7P4q
 WNcCdxOVYB3oirpGcUN55Rmd5zEqz+ysGS5B8I8urXkZISfsrqHHk2vIiI0+A4j03vI8
 avCX1cvSIIoqMpYGhYMCeg0dZ924nCJeEr3HSPQrkzXlFP3ngyfRBnX3iVDJOQ+GR4yu
 SMSNSYGrfXtKT5he2DRFWBvGWObVxgEY5lmNxTrCP6ioHw0zPRKYgn7Etn4LhGikbRZj
 pkziYATZbRgIf55nmuRUATZ4ooaMYeldyZ0m8alhgJHs8zWnH4/UD3K6rM+KHxhJlv2T Yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3phsn2v1ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 17:40:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D092A10002A;
        Mon, 27 Mar 2023 17:40:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CA3ED2194ED;
        Mon, 27 Mar 2023 17:40:24 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 27 Mar
 2023 17:40:24 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] ARM: dts: stm32: clean uart aliases on stm32mp15xx-exx boards
Date:   Mon, 27 Mar 2023 17:39:40 +0200
Message-ID: <20230327153943.275124-3-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327152948.274743-1-valentin.caron@foss.st.com>
References: <20230327152948.274743-1-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.168]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
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

Put also aliases node above chosen node as same as stm32mp157c-dk2.dts.

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm/boot/dts/stm32mp157c-ed1.dts | 8 ++++----
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 9 ++++-----
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157c-ed1.dts b/arch/arm/boot/dts/stm32mp157c-ed1.dts
index b1eb688a278a..2dfde6292668 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1.dts
@@ -16,6 +16,10 @@ / {
 	model = "STMicroelectronics STM32MP157C eval daughter";
 	compatible = "st,stm32mp157c-ed1", "st,stm32mp157";
 
+	aliases {
+		serial0 = &uart4;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -72,10 +76,6 @@ gpu_reserved: gpu@e8000000 {
 		};
 	};
 
-	aliases {
-		serial0 = &uart4;
-	};
-
 	sd_switch: regulator-sd_switch {
 		compatible = "regulator-gpio";
 		regulator-name = "sd_switch";
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 542226cfcfdf..ba8e9d9a42fa 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -14,16 +14,15 @@ / {
 	model = "STMicroelectronics STM32MP157C eval daughter on eval mother";
 	compatible = "st,stm32mp157c-ev1", "st,stm32mp157c-ed1", "st,stm32mp157";
 
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
 	aliases {
-		serial0 = &uart4;
 		serial1 = &usart3;
 		ethernet0 = &ethernet0;
 	};
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	clocks {
 		clk_ext_camera: clk-ext-camera {
 			#clock-cells = <0>;
-- 
2.25.1

