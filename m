Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B075FF007
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJNOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiJNOPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:15:48 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9F2EAC81;
        Fri, 14 Oct 2022 07:15:46 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EAT6Cr022413;
        Fri, 14 Oct 2022 16:15:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=mxweXw2S/nLFWXs2A+TfYBTOBTxk5wmtjeTIX6nQSWc=;
 b=w+89oKzJmuhc/iibXr4Kasp97Pl1r6jOrOfNHt5wvQ01ZqZqNsrX07XexAOhZ59zTEWB
 gA0cieLJjKVVzPEtpCgoYvGcf0l5u8Se5KRK4Jab4KVpDN3Qz7VRNG3MkWysxHv5lAXk
 NI/KTB/yBW3Nk6sex1MS6cp98Z0WzGdFp7ePDlsWunxB3/kETsIgR6ZZlIc8q0l7t/U0
 P4fLr4CfC6wpE2fsUuXaMicnztj+5BYdlMS89/Qe2SW/ieCRifOg+TXQhjs381vwkuZS
 JX22UFg7b4lDHohlQucdWmWYqvnAyEW8A/ym4M/IIj6cuP2WWAlCYD35TBBFxwBuRTWZ bA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k64m7x0eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 16:15:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 51748100039;
        Fri, 14 Oct 2022 16:15:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C853231500;
        Fri, 14 Oct 2022 16:15:34 +0200 (CEST)
Received: from localhost (10.75.127.116) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 16:15:31 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 03/10] ARM: dts: stm32: add UBSH EHCI and OHCI support on stm32mp131
Date:   Fri, 14 Oct 2022 16:15:02 +0200
Message-ID: <20221014141509.211149-4-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014141509.211149-1-fabrice.gasnier@foss.st.com>
References: <20221014141509.211149-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.116]
X-ClientProxiedBy: GPXDAG2NODE6.st.com (10.75.127.70) To SHFDAG1NODE2.st.com
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

This patch adds USB Host EHCI and OHCI support on stm32mp131.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2: adopt "usb" generic node names
---
 arch/arm/boot/dts/stm32mp131.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
index cd31fdd47536..e6129e11660b 100644
--- a/arch/arm/boot/dts/stm32mp131.dtsi
+++ b/arch/arm/boot/dts/stm32mp131.dtsi
@@ -401,6 +401,25 @@ sdmmc2: mmc@58007000 {
 			status = "disabled";
 		};
 
+		usbh_ohci: usb@5800c000 {
+			compatible = "generic-ohci";
+			reg = <0x5800c000 0x1000>;
+			clocks = <&usbphyc>, <&rcc USBH>;
+			resets = <&rcc USBH_R>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		usbh_ehci: usb@5800d000 {
+			compatible = "generic-ehci";
+			reg = <0x5800d000 0x1000>;
+			clocks = <&usbphyc>, <&rcc USBH>;
+			resets = <&rcc USBH_R>;
+			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			companion = <&usbh_ohci>;
+			status = "disabled";
+		};
+
 		iwdg2: watchdog@5a002000 {
 			compatible = "st,stm32mp1-iwdg";
 			reg = <0x5a002000 0x400>;
-- 
2.25.1

