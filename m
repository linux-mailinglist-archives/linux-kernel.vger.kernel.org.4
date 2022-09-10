Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EAA5B46ED
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiIJOky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIJOkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 10:40:47 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996DD28E34;
        Sat, 10 Sep 2022 07:40:37 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28ACu4iO026809;
        Sat, 10 Sep 2022 16:40:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=I8iLxoJxgLWgVMiLGsUDh1d+t3CJSTgq9exY9ZcW1Ko=;
 b=Dz0aT+U60j7Q2tx83ij/hD8wYKJPxuctH2xPpIZDDPrPg+JZ8CJY4GtITqiuwBTlwiuH
 LEjbS96Lt768u4Qyqt+URiMiiaAk78OPbcmslZ6NjUyeh/bolptjsDsyWeQpK+hxzi16
 YvpMuu8FDv2JYyVLu4wmRtqnjIdGXOYcGECrSbrcqV0+9P867n03GkA2xcgYzDWQGF/V
 KlKI23ig0rpt8ZGEFLtunmoWVrPW0DGE1Xrs4KKw1/0oJdEpzvV/LQhSKlopjZBTsAqb
 Lq35CbMiG395flkarH3d/6NqdI4aMHmC5GaEb9RdxTs/F8+6ADWhXmr9lZRy+BDUCLtV Yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jgjtt1uuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Sep 2022 16:40:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 17474100034;
        Sat, 10 Sep 2022 16:40:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E91922D164;
        Sat, 10 Sep 2022 16:40:20 +0200 (CEST)
Received: from localhost (10.75.127.120) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Sat, 10 Sep
 2022 16:40:19 +0200
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
Subject: [PATCH v1 4/5] ARM: dts: stm32: add dcmipp support to stm32mp135
Date:   Sat, 10 Sep 2022 16:40:09 +0200
Message-ID: <20220910144010.34272-5-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
References: <20220910144010.34272-1-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.120]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_06,2022-09-09_01,2022-06-22_01
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

