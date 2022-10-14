Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265675FEBA6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJNJ3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiJNJ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:29:13 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6AD1C69C8;
        Fri, 14 Oct 2022 02:29:07 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E8RvOQ008870;
        Fri, 14 Oct 2022 11:28:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=WFGDOZoUQlIydYpRD35dhWAM/wewEIYHMtXwngxlfBI=;
 b=0lXIjq+MDUnvhr6XJG1GMNa1iU/ZR0GdIAKp4mXZpHRdtTlqXvGasbjmg3stoeH3afqn
 i5EiuKXDuOIYODO6/t/IsSNl5ZbHCiyqTT2aMSssVBa6yHnOeV8SZHKn5z7AuyxGXcFh
 C8aGhY2Zuia8l8NM99LVGkENY//RWoYPcWal/lSCmGkWVXPgkTgzvUeoG+Vn9BE/MQvA
 Gh8xpFOas7orHj9r7mombBw9xFFUEWDIwYj4Yw+D6d0UiXrma/dxefY0eiZ1pPGsZAcE
 urZRhgSjg9QONStHBs0+qCvAnx3NgURctaxsq2cGC617G4muhpieR3MNC/T8Tp1p3Y2X Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k6h7v7gsk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 11:28:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7CCE10002A;
        Fri, 14 Oct 2022 11:28:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B2AB521A904;
        Fri, 14 Oct 2022 11:28:52 +0200 (CEST)
Received: from localhost (10.75.127.117) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 11:28:49 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 05/10] ARM: dts: stm32: add fixed regulators to support usb on stm32mp135f-dk
Date:   Fri, 14 Oct 2022 11:26:46 +0200
Message-ID: <20221014092651.25202-6-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
References: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.117]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_05,2022-10-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VDD_USB and 3V3_SW regulators on stm32mp135f-dk. Temporary add them
as fixed regulators, waiting for full SCMI regulators support.

This is a precursor patch to enable USB support on STM32MP13:
- VDD_USB supplies the STM32MP13 USB internals
- 3V3_SW supplies various peripherals, including the onboard HUB.
Note: USB support requires these regulators to be enabled before
entering the kernel.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm/boot/dts/stm32mp135f-dk.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp135f-dk.dts b/arch/arm/boot/dts/stm32mp135f-dk.dts
index de341d17e87d..291f05a958fd 100644
--- a/arch/arm/boot/dts/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/stm32mp135f-dk.dts
@@ -66,6 +66,22 @@ vdd_sd: vdd-sd {
 		regulator-max-microvolt = <2900000>;
 		regulator-always-on;
 	};
+
+	vdd_usb: vdd-usb {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_usb";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	v3v3_sw: v3v3-sw {
+		compatible = "regulator-fixed";
+		regulator-name = "v3v3_sw";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &i2c1 {
-- 
2.25.1

