Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC606E1D44
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjDNHeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjDNHdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:33:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE60F4EF3;
        Fri, 14 Apr 2023 00:33:53 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XZDd112604;
        Fri, 14 Apr 2023 02:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681457615;
        bh=Zpr6vCV3LxfyUs+9swYtgQVSm2TNztUqk2/DsLuzvTk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=R1GRkEgK8n0pTxCq4K9w4WBUhDZzxnvsbwDVICirBmIMQEW+Q966cN93ofjD6D6P6
         D/T9giY9pF7eCHH00PjxVveYHX/Fl+xU3czT+El/JLYtbTJ83jEJHAs5eT1KoEE6pa
         jD9wXkejw0oQ+j00z6awyZJhzLGU7SaJ0MpJNbys=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33E7XZ1m091062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 02:33:35 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 02:33:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 02:33:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XY1f003019;
        Fri, 14 Apr 2023 02:33:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/10] arm64: dts: ti: k3-am642-sk: Rename regulator node name
Date:   Fri, 14 Apr 2023 02:33:23 -0500
Message-ID: <20230414073328.381336-6-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414073328.381336-1-nm@ti.com>
References: <20230414073328.381336-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the regulator node names to the standard regulator-0.. numbers.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am642-sk.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index da4121b2e2c6..5bd69a8e8063 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -94,7 +94,7 @@ rtos_ipc_memory_region: ipc-memories@a5000000 {
 		};
 	};
 
-	vusb_main: fixed-regulator-vusb-main5v0 {
+	vusb_main: regulator-0 {
 		/* USB MAIN INPUT 5V DC */
 		compatible = "regulator-fixed";
 		regulator-name = "vusb_main5v0";
@@ -104,7 +104,7 @@ vusb_main: fixed-regulator-vusb-main5v0 {
 		regulator-boot-on;
 	};
 
-	vcc_3v3_sys: fixedregulator-vcc-3v3-sys {
+	vcc_3v3_sys: regulator-1 {
 		/* output of LP8733xx */
 		compatible = "regulator-fixed";
 		regulator-name = "vcc_3v3_sys";
@@ -115,7 +115,7 @@ vcc_3v3_sys: fixedregulator-vcc-3v3-sys {
 		regulator-boot-on;
 	};
 
-	vdd_mmc1: fixed-regulator-sd {
+	vdd_mmc1: regulator-2 {
 		/* TPS2051BD */
 		compatible = "regulator-fixed";
 		regulator-name = "vdd_mmc1";
@@ -127,7 +127,7 @@ vdd_mmc1: fixed-regulator-sd {
 		gpio = <&exp1 3 GPIO_ACTIVE_HIGH>;
 	};
 
-	com8_ls_en: regulator-1 {
+	com8_ls_en: regulator-3 {
 		compatible = "regulator-fixed";
 		regulator-name = "com8_ls_en";
 		regulator-min-microvolt = <3300000>;
@@ -139,7 +139,7 @@ com8_ls_en: regulator-1 {
 		gpio = <&main_gpio0 62 GPIO_ACTIVE_LOW>;
 	};
 
-	wlan_en: regulator-2 {
+	wlan_en: regulator-4 {
 		/* output of SN74AVC4T245RSVR */
 		compatible = "regulator-fixed";
 		regulator-name = "wlan_en";
-- 
2.40.0

