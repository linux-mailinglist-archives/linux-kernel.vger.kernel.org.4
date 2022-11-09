Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A6622DF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKIObk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiKIObi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:31:38 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC22C140C9;
        Wed,  9 Nov 2022 06:31:35 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A96ighl013794;
        Wed, 9 Nov 2022 06:31:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=SQpWMPuyoJmCA2odgqyGhbMBjo2hofOrSCRTeGJifmA=;
 b=N4ui0+0IV1BgsToHBAeWa5EGQ5OQY8BFrCaLrVpNqy+I/CzUPIeEXKf0j2dO8OkdaZlG
 EWgESfHlBixGIZzMfYWHkOCb8dUYwQkOwGUOWVQht2MpOHgtAjSslQMG2wMNMyk7bbCk
 R0EGSMGI9byd+EsAd6CH1EZYxWoh+mmVaC8AdV87L9S4JF0Oaw95iHkdqLZ3B9QQk3qB
 /XXLCPzhlmRsWYNkcm7Ok2yW5LjHg/oE9DauyHaCJyQo16aPsJj5Rh2v0ui2vPYyTWdK
 LizsBd2fex6VFssJJJAYQA8QGtISvx078qS3F41X3fJAnA7f10nLKrfn0qbehGiPFL/i jg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3kr774sfgn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 06:31:17 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Nov
 2022 06:31:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Nov 2022 06:31:15 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 05DD33F70CE;
        Wed,  9 Nov 2022 06:31:12 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Chulski <stefanc@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>
Subject: [PATCH] arch/arm64/boot/dts/marvell: add optee FW definitions
Date:   Wed, 9 Nov 2022 16:30:54 +0200
Message-ID: <20221109143054.1440158-1-kostap@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Dli1SD4aglueT4euVEDmnEyM8vIU-nKu
X-Proofpoint-ORIG-GUID: Dli1SD4aglueT4euVEDmnEyM8vIU-nKu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

Add reserved memory and ARM firmware definitions for optee
memory region in Marvell Armada SoCs to avoid protected memory
access.

Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  | 11 +++++++++++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index df152c72276b..c7a5a25826ea 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -35,6 +35,11 @@ psci-area@4000000 {
 			reg = <0 0x4000000 0 0x200000>;
 			no-map;
 		};
+
+		tee@4400000 {
+			reg = <0 0x4400000 0 0x1000000>;
+			no-map;
+		};
 	};
 
 	cpus {
@@ -531,5 +536,11 @@ armada-3700-rwtm {
 			mboxes = <&rwtm 0>;
 			status = "okay";
 		};
+
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+			status = "okay";
+		 };
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index a06a0a889c43..abf373b39463 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -41,6 +41,11 @@ psci-area@4000000 {
 			reg = <0x0 0x4000000 0x0 0x200000>;
 			no-map;
 		};
+
+		tee@4400000 {
+			reg = <0 0x4400000 0 0x1000000>;
+			no-map;
+		};
 	};
 
 	AP_NAME {
@@ -461,4 +466,12 @@ map3_emerg: map3-emerg {
 			};
 		};
 	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+			status = "okay";
+		 };
+	};
 };
-- 
2.25.1

