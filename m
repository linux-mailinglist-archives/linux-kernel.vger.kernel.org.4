Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872FC5FF005
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJNOQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiJNOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:15:46 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83C0CBFC5;
        Fri, 14 Oct 2022 07:15:45 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EAN8AR021777;
        Fri, 14 Oct 2022 16:15:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=yYGKU/sL0116cBPXYl1vTRYtoBoXWu/qm/iLLtCJlS0=;
 b=5wd2fFrDJRUqmO65a1KVPYs4UF/9Q+gcAm1U6pwuMbncbOR4uiNZC7ni7wIZ5dz+8Yon
 Qox/XfqeQGqeIgv8MrUw61BFciWmoLVQ0LfF6hnctcNLDTqXbm8GVfTfzKpxGhRvDm1O
 /KUsJ11CLaMT/NAr+8EPQ7yQvd/PB10wdauHNZiZ6M2i04yldKpl9fMYN9SVi4Zv0Av3
 kzvFlbIqeun4heAXMwK8s0sQcHqw4vHFnW2YEDBXTid4R9r/CQ+hxbZCmrn5N+wHqKpH
 WQi+pzWdBNA20bOPvbny1W+VAJRXQ4P5Sxtxk25g9Fw0iyjJ+suY647RaVlCbR5pgwGZ DQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k64m7x0ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 16:15:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53A63100038;
        Fri, 14 Oct 2022 16:15:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4E6A5231500;
        Fri, 14 Oct 2022 16:15:33 +0200 (CEST)
Received: from localhost (10.75.127.118) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 16:15:32 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 04/10] ARM: dts: stm32: add USB OTG HS support on stm32mp131
Date:   Fri, 14 Oct 2022 16:15:03 +0200
Message-ID: <20221014141509.211149-5-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014141509.211149-1-fabrice.gasnier@foss.st.com>
References: <20221014141509.211149-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.118]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_08,2022-10-14_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

This patch adds USB OTG HS support on stm32mp131.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2: adopt "usb" generic node name
---
 arch/arm/boot/dts/stm32mp131.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index e6129e11660b..6cf930d7721a 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -253,6 +253,23 @@ dmamux1: dma-router@48002000 {
 			dma-channels = <16>;
 		};
 
+		usbotg_hs: usb@49000000 {
+			compatible = "st,stm32mp15-hsotg", "snps,dwc2";
+			reg = <0x49000000 0x40000>;
+			clocks = <&rcc USBO_K>;
+			clock-names = "otg";
+			resets = <&rcc USBO_R>;
+			reset-names = "dwc2";
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			g-rx-fifo-size = <512>;
+			g-np-tx-fifo-size = <32>;
+			g-tx-fifo-size = <256 16 16 16 16 16 16 16>;
+			dr_mode = "otg";
+			otg-rev = <0x200>;
+			usb33d-supply = <&usb33>;
+			status = "disabled";
+		};
+
 		spi4: spi@4c002000 {
 			compatible = "st,stm32h7-spi";
 			reg = <0x4c002000 0x400>;
-- 
2.25.1

