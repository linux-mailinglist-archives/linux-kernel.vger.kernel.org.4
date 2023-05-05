Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB8D6F8388
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjEENKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjEENKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:10:31 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898BB1A4AD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1683292226; x=1685884226;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x6IoQdSk68OagkSqYCelek7WK0R9jkKB7LPMBihpytA=;
        b=L+hSQgF8Gd+Bzu9Ub0dNrOHtJlznWy88g7KOQJ9DCwABmNMiEPIAgbjw27XzV71v
        8S+BT5HHUgPjWxorZU8fOeJQEE4R9ru+KItStcvYBKen0s18X98NLSaczUvPLR0e
        PWWHKF5lXwSax36nuuWVIReXpDrJW6lTkwx71lshOIs=;
X-AuditID: ac14000a-923ff70000007ecb-44-645500427ee3
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 12.C8.32459.24005546; Fri,  5 May 2023 15:10:26 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 5 May
 2023 15:10:42 +0200
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <nm@ti.com>,
        <upstream@lists.phytec.de>
Subject: [PATCH] arm64: dts: ti: Add LED controller to phyBOARD-Electra
Date:   Fri, 5 May 2023 15:10:12 +0200
Message-ID: <20230505131012.2027309-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWyRpKBR9eJITTFYOc+Y4v5R86xWiz/PJvd
        ou/FQ2aLTY+vsVpc3jWHzeLNj7NMFq17j7BbdL9Tt/h/9gO7A6fHplWdbB53ru1h89i8pN6j
        v7uF1eP4je1MHp83yQWwRXHZpKTmZJalFunbJXBltN56w1TwmKvi5urJrA2MXzi6GDk5JARM
        JNYtbWPvYuTiEBJYwiRx/c1fVgjnMaNEz9oGZpAqNgF1iTsbvrGC2CICWRLvm+eCFTELTGKU
        OHW9lx0kISzgLnF9RzMTiM0ioCLR2dPPBmLzClhKXJ01nwlinbzEzEvf2SHighInZz5hAbGZ
        geLNW2czQ9gSEgdfvACzhYDiLy4tZ4HpnXbuNTOEHSpxZNNqpgmMArOQjJqFZNQsJKMWMDKv
        YhTKzUzOTi3KzNYryKgsSU3WS0ndxAgKfhEGrh2MfXM8DjEycTAeYpTgYFYS4f1Q6JcixJuS
        WFmVWpQfX1Sak1p8iFGag0VJnPd+D1OikEB6YklqdmpqQWoRTJaJg1OqgbH/6Tqhl7drK4Jd
        D8nPkFZgXqcU25GUGaTivUNr2a9LxzW9PynZbPR9bed9oXqSffL1V2nfxTfdFf1WzX3ucd6f
        mJ12P4qcVZoWCfuaPd99ZVGh/3ad5oVzz2vHV1Sk9M7j41ITnsBsqma8rPb83cMZASr7X+Ye
        MWuVKbqkzONx6G738v2TE5VYijMSDbWYi4oTAUlhN71sAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 9f6ffd0da650 ("dt-bindings: leds: Convert PCA9532 to dtschema"),
we can now add the LED controller without introducing new dtbs_check warnings.
Add missing I2C LED controller.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 8d3114d14a8b..8199ac06c09a 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -15,6 +15,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
+#include <dt-bindings/leds/leds-pca9532.h>
 #include <dt-bindings/mux/ti-serdes.h>
 #include <dt-bindings/phy/phy.h>
 #include "k3-am642.dtsi"
@@ -210,6 +211,26 @@ eeprom@51 {
 		pagesize = <16>;
 		reg = <0x51>;
 	};
+
+	led-controller@62 {
+		compatible = "nxp,pca9533";
+		reg = <0x62>;
+
+		led-3 {
+			label = "red:user";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led-4 {
+			label = "green:user";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led-5 {
+			label = "blue:user";
+			type = <PCA9532_TYPE_LED>;
+		};
+	};
 };
 
 &main_mcan0 {
-- 
2.25.1

