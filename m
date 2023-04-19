Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 239956E8597
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 01:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjDSXAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 19:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbjDSXA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 19:00:29 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759044692;
        Wed, 19 Apr 2023 16:00:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33JMxExG122553;
        Wed, 19 Apr 2023 17:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681945154;
        bh=wJnUXZwwWLVUVOcKM6zhDwYXuhQdZx9PP4y7mpc00gU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SJzNFdEwkBYqRCyG2RrkDBUJopybVm1knJeFiaE5j7p/q3E4WCRPIlfF3KgYXu5TU
         MGqHcdG7UQM9ViVIVT+K6HfTSB4eRif3ePrhzyS/FJrVI3XFeGwmwDmLDQl3OQhSVL
         C6o1L9BzGB3QROAkgaJxUKIgQiD35+Yr+8DMVzWU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33JMxE6v119678
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Apr 2023 17:59:14 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 19
 Apr 2023 17:59:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 19 Apr 2023 17:59:14 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33JMxECX015542;
        Wed, 19 Apr 2023 17:59:14 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/7] arm64: dts: ti: k3-am654-base-board: Add missing PMIC
Date:   Wed, 19 Apr 2023 17:59:10 -0500
Message-ID: <20230419225913.663448-5-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230419225913.663448-1-nm@ti.com>
References: <20230419225913.663448-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing vdd_mpu PMIC.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 83467adc017d..640910e2280f 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -337,6 +337,19 @@ &wkup_i2c0 {
 	pinctrl-0 = <&wkup_i2c0_pins_default>;
 	clock-frequency = <400000>;
 
+	vdd_mpu: regulator@60 {
+		compatible = "ti,tps62363";
+		reg = <0x60>;
+		regulator-name = "VDD_MPU";
+		regulator-min-microvolt = <500000>;
+		regulator-max-microvolt = <1770000>;
+		regulator-always-on;
+		regulator-boot-on;
+		ti,vsel0-state-high;
+		ti,vsel1-state-high;
+		ti,enable-vout-discharge;
+	};
+
 	pca9554: gpio@39 {
 		compatible = "nxp,pca9554";
 		reg = <0x39>;
-- 
2.40.0

