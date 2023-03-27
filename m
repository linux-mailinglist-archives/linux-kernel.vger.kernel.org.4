Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2705D6CA90F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjC0Pbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjC0PbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:31:24 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297A6420A;
        Mon, 27 Mar 2023 08:31:17 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32RBVw8H016582;
        Mon, 27 Mar 2023 17:30:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=ixnILKsgBi9TvS6HO90ML++Q6G9R7trXLt0wLVy6PdQ=;
 b=GGBTR1sSZEGrHJsv/GE+uBAoBPsLPb36Ui1dbkHxefdLThwIpWQBkVMCzmVgONx1QgbL
 6D/c0dLtpOX2QFFk4u7/k7ULLkLJFNoN/Bn/ATiJhKWAFr2Y53+c7DIhDWHPpxjlk+kS
 WjT7eNFK1Gie94/v5WIOXCX7N1aas5AsNiqkR2jnJC68OzHeNhSv7OzIHwBgwKCh/aL1
 /gEU7Asq06FWBmH6mA+RQAZfJWCqJ7PsTjvq4BeATNMknSNLas/mAvAkAYHfz5ruzlHO
 sDozlbHagYi9FRW+8R7l4Ld2mdgUDdnN8Xi/jbeznaT3cAQBcIwf8kcliiVgFBH1HK09 fQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3phsn2uyhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 17:30:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F1FA0100039;
        Mon, 27 Mar 2023 17:30:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E84F721A206;
        Mon, 27 Mar 2023 17:30:47 +0200 (CEST)
Received: from localhost (10.201.20.168) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Mon, 27 Mar
 2023 17:30:47 +0200
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] ARM: dts: stm32: change USART1 clock to an SCMI clock on stm32mp15 boards
Date:   Mon, 27 Mar 2023 17:29:42 +0200
Message-ID: <20230327152948.274743-2-valentin.caron@foss.st.com>
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

On ST stm32mp15 boards, change clock of USART1 node to SCMI clock
"CK_SCMI_USART1"

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts | 4 ++++
 arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts | 4 ++++
 arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts | 4 ++++
 arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
index e539cc80bef8..5c8164c10e46 100644
--- a/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts
@@ -77,3 +77,7 @@ &rng1 {
 &rtc {
 	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
 };
+
+&usart1 {
+	clocks = <&scmi_clk CK_SCMI_USART1>;
+};
diff --git a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
index 97e4f94b0a24..2c9a207a9d49 100644
--- a/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts
@@ -83,3 +83,7 @@ &rng1 {
 &rtc {
 	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
 };
+
+&usart1 {
+	clocks = <&scmi_clk CK_SCMI_USART1>;
+};
diff --git a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
index 9cf0a44d2f47..21c8169f0e82 100644
--- a/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts
@@ -82,3 +82,7 @@ &rng1 {
 &rtc {
 	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
 };
+
+&usart1 {
+	clocks = <&scmi_clk CK_SCMI_USART1>;
+};
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
index 3b9dd6f4ccc9..0084abbeb60e 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts
@@ -88,3 +88,7 @@ &rng1 {
 &rtc {
 	clocks = <&scmi_clk CK_SCMI_RTCAPB>, <&scmi_clk CK_SCMI_RTC>;
 };
+
+&usart1 {
+	clocks = <&scmi_clk CK_SCMI_USART1>;
+};
-- 
2.25.1

