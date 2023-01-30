Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF29D681DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjA3WEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjA3WDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:03:55 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BD13D0B1;
        Mon, 30 Jan 2023 14:03:40 -0800 (PST)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UKmOvg012191;
        Mon, 30 Jan 2023 22:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=+Dkted+K+t3Q4FXtgzvI6mElOa1fT1XFa7VU08pte4w=;
 b=FZy/tOp/giz1hk6XJpBWx5oxttj0ArByUZMo4xBXQnuelOn6y2Y4afbmw5z1+uX9dAFK
 5wdqysQW2qHC1vDbFMoAP0bMsc1kne8QC1f1lCrkSjZkx+VHMG6wd7HTAyJQCtKHtZyw
 yRu+CV4QlWgZH7ImUGH81haxzqzQiSnu7ukX81F6shdJ9GCBsCmckp1AbrAfWfQb9elY
 4k0Z/Tnk0WikKHe52cafc+C5o6TfUkPp5hGIx/F7Z+bAJFM34etMH1I1275RhElMTs46
 SNRnh3lrzzUnxV0G03206QGst1Vh1RHQWrryyX7Fnw2EP1V9CBijm7bv02QVKlUvsMPZ sw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nefv6vm2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 22:03:19 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 59F8B809101;
        Mon, 30 Jan 2023 22:03:18 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id F19CE808E84;
        Mon, 30 Jan 2023 22:03:17 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     soc@kernel.org, arnd@arndb.de, verdun@hpe.com,
        nick.hawkins@hpe.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/1] ARM: dts: hpe: Correct GXP register ranges
Date:   Mon, 30 Jan 2023 16:00:56 -0600
Message-Id: <20230130220056.14349-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230130220056.14349-1-nick.hawkins@hpe.com>
References: <20230130220056.14349-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: HplMZvtTvFAkQindG2l_9790x9hLiQpu
X-Proofpoint-GUID: HplMZvtTvFAkQindG2l_9790x9hLiQpu
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxlogscore=835 clxscore=1015 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300202
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Correct memory ranges on GXP to include host registers. This corrects a
issue where the host interrupt controller is not available. Additionally
there is a large gap of reserved registers that will not be used. To avoid
this area two ranges are used.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 arch/arm/boot/dts/hpe-gxp.dtsi | 41 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe-gxp.dtsi
index cf735b3c4f35..30ed921f83ac 100644
--- a/arch/arm/boot/dts/hpe-gxp.dtsi
+++ b/arch/arm/boot/dts/hpe-gxp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree file for HPE GXP
+ * Device Tree for HPE
  */
 
 /dts-v1/;
@@ -43,7 +43,6 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-		dma-ranges;
 
 		L2: cache-controller@b0040000 {
 			compatible = "arm,pl310-cache";
@@ -52,73 +51,73 @@
 			cache-level = <2>;
 		};
 
-		ahb@c0000000 {
+		ahb@80000000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0xc0000000 0x30000000>;
-			dma-ranges;
+			ranges = <0x0 0x80000000 0x20000000>,
+			<0x40000000 0xc0000000 0x3fff0000>;
 
-			vic0: interrupt-controller@eff0000 {
+			vic0: interrupt-controller@4eff0000 {
 				compatible = "arm,pl192-vic";
-				reg = <0xeff0000 0x1000>;
+				reg = <0x4eff0000 0x1000>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
 
-			vic1: interrupt-controller@80f00000 {
+			vic1: interrupt-controller@f00000 {
 				compatible = "arm,pl192-vic";
-				reg = <0x80f00000 0x1000>;
+				reg = <0xf00000 0x1000>;
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
 
-			uarta: serial@e0 {
+			uarta: serial@400000e0 {
 				compatible = "ns16550a";
-				reg = <0xe0 0x8>;
+				reg = <0x400000e0 0x8>;
 				interrupts = <17>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			uartb: serial@e8 {
+			uartb: serial@400000e8 {
 				compatible = "ns16550a";
-				reg = <0xe8 0x8>;
+				reg = <0x400000e8 0x8>;
 				interrupts = <18>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			uartc: serial@f0 {
+			uartc: serial@400000f0 {
 				compatible = "ns16550a";
-				reg = <0xf0 0x8>;
+				reg = <0x400000f0 0x8>;
 				interrupts = <19>;
 				interrupt-parent = <&vic0>;
 				clock-frequency = <1846153>;
 				reg-shift = <0>;
 			};
 
-			usb0: usb@efe0000 {
+			usb0: usb@4efe0000 {
 				compatible = "hpe,gxp-ehci", "generic-ehci";
-				reg = <0xefe0000 0x100>;
+				reg = <0x4efe0000 0x100>;
 				interrupts = <7>;
 				interrupt-parent = <&vic0>;
 			};
 
-			st: timer@80 {
+			st: timer@40000080 {
 				compatible = "hpe,gxp-timer";
-				reg = <0x80 0x16>;
+				reg = <0x40000080 0x16>;
 				interrupts = <0>;
 				interrupt-parent = <&vic0>;
 				clocks = <&iopclk>;
 				clock-names = "iop";
 			};
 
-			usb1: usb@efe0100 {
+			usb1: usb@4efe0100 {
 				compatible = "hpe,gxp-ohci", "generic-ohci";
-				reg = <0xefe0100 0x110>;
+				reg = <0x4efe0100 0x110>;
 				interrupts = <6>;
 				interrupt-parent = <&vic0>;
 			};
-- 
2.17.1

