Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED76E622EC3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiKIPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKIPIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:08:06 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFE31A3B8;
        Wed,  9 Nov 2022 07:08:05 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A98eJGf011839;
        Wed, 9 Nov 2022 07:07:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=rTco5HjmGFlE4iOYeQIwq1HV8zdBI7akldkUPr6egrA=;
 b=WZz3vCQKG1KMOuf0xJy5wjnT/6TnO3tswLFKEZHxCRbtPwszuG423eYT4xM/pv0e7Vlv
 h2MMwHHmcx50b0ntgwgTFT+LuvBvTLU6fhzYebx0UlEKZqJZ2JkWj0oYxsA5KzW1aOzh
 g3UJkegMLQWsppG0ZO06oXhe6hUQmRS1eCwmSUUKVLiU1nr117j2VnhM8zFF4oio2tzH
 ojT1H7kqbIAClzqZs0afOUxml2NeDxfDsCCh7O0NXHvHnKJx2eKzia+TXS/OyL6cnsWW
 jhjUDeWPIIqbOl5UKBPB4DZYgMI7GDIt9f4dm/6jEq31dZ4W18tUVIaPbGx+w8V1et6N Kw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3kr8wbs8b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 07:07:51 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Nov
 2022 07:07:49 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 9 Nov 2022 07:07:49 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 855B13F7074;
        Wed,  9 Nov 2022 07:07:46 -0800 (PST)
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
Subject: [PATCH] arm64: dts: marvell: add optee FW definitions
Date:   Wed, 9 Nov 2022 17:07:43 +0200
Message-ID: <20221109150743.1444103-1-kostap@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <[PATCH] arch/arm64/boot/dts/marvell: add optee FW definitions>
References: <[PATCH] arch/arm64/boot/dts/marvell: add optee FW definitions>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: t8Mrwa5BaYiou4ZoVpA53mYEy7u-6PIX
X-Proofpoint-ORIG-GUID: t8Mrwa5BaYiou4ZoVpA53mYEy7u-6PIX
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
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  | 5 +++++
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index df152c72276b..e300145ad1a6 100644
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
diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index a06a0a889c43..4e6d29ad32eb 100644
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
-- 
2.25.1

