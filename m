Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF105B3D9A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiIIRCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiIIRBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:01:48 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A8BE5833;
        Fri,  9 Sep 2022 10:01:44 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289FX4mB031613;
        Fri, 9 Sep 2022 19:00:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=I8iLxoJxgLWgVMiLGsUDh1d+t3CJSTgq9exY9ZcW1Ko=;
 b=g0G2pUsFISSeME7AjZvEKIytT07JaZZZD4qxwj5FZWBX710l9EiYgWD413XkVkwIVsHI
 QGYp085xohxUC4WNDW0HVM1BmDzy0vOl0K6bt1hWsJqscEtxQzrMucS2HFkGRBXLCaak
 gf0T1Jsz8qxjqfP4Oe4b9PNhYe8aRM55PNk87UJclaGhhpEi4lgR02UuGqoXoqNI39EQ
 rVGpV9dexlitfSKemb6shov6KRxUinrBpXJGxOoQgYL2ic7GFc5QkwJ6eDFYkPU+dX5f
 w1SgWdLWpHKODjoy5oCojpwE0e47oUjYgCBcL+Gpj1K7POIYWtfN4xdgpyHPXVVoAtE3 Wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jergbjcu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 19:00:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BE6A9100034;
        Fri,  9 Sep 2022 19:00:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B900B24551C;
        Fri,  9 Sep 2022 19:00:52 +0200 (CEST)
Received: from localhost (10.75.127.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.7; Fri, 9 Sep 2022
 19:00:52 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>
Subject: [PATCH 4/5] ARM: dts: stm32: add dcmipp support to stm32mp135
Date:   Fri, 9 Sep 2022 18:59:58 +0200
Message-ID: <20220909165959.5899-5-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909165959.5899-1-hugues.fruchet@foss.st.com>
References: <20220909165959.5899-1-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.120]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_08,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dcmipp support to STM32MP135.

Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
---
 arch/arm/boot/dts/stm32mp135.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp135.dtsi b/arch/arm/boot/dts/stm32mp135.dtsi
index abf2acd37b4e..fcf0592c01fd 100644
--- a/arch/arm/boot/dts/stm32mp135.dtsi
+++ b/arch/arm/boot/dts/stm32mp135.dtsi
@@ -8,5 +8,14 @@
 
 / {
 	soc {
+		dcmipp: dcmipp@5a000000 {
+			compatible = "st,stm32mp13-dcmipp";
+			reg = <0x5a000000 0x400>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rcc DCMIPP_R>;
+			clocks = <&rcc DCMIPP_K>;
+			clock-names = "kclk";
+			status = "disabled";
+		};
 	};
 };
-- 
2.25.1

