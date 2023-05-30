Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9F716CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjE3Sx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjE3Sxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:53:53 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81A3A7;
        Tue, 30 May 2023 11:53:45 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UIrbDn019545;
        Tue, 30 May 2023 13:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685472817;
        bh=ZYqNGrHJU5U8N1DBVsQbVGmUaAADNEe/oaXR+apsFI0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=w7Urx0wNu5SXrUjaBDpddtG/wz8QF4wPB8XeAOwSeyBgOwdMeRYY+2jrp92/LE7ZH
         /ItA3MIuuTTWp2gDVwJZN1XLITdgVkyu2/qthhq71+ReeoA1lMMaIr7341Bpop1sjm
         lIImtxfpZJyuZDAge2bMtblZ1CIOFlsC1RWv6QUs=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UIrbsY057180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 13:53:37 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 13:53:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 13:53:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UIrasw015316;
        Tue, 30 May 2023 13:53:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Nitin Yadav <n-yadav@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 2/2] arm64: dts: ti: k3-am64: Add ESM support
Date:   Tue, 30 May 2023 13:53:35 -0500
Message-ID: <20230530185335.79942-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230530185335.79942-1-nm@ti.com>
References: <20230530185335.79942-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Error Signaling Module (ESM) instances in MCU and MAIN domains.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Depends on https://lore.kernel.org/all/20230504080526.133149-1-n-francis@ti.com/
(to be merged via SoC tree)

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 6 ++++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5e8036f32d79..0742af804378 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -228,6 +228,12 @@ epwm_tbclk: clock@4140 {
 		};
 	};
 
+	main_esm: esm@420000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x420000 0x00 0x1000>;
+		ti,esm-pins = <160>, <161>;
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 38ddf0b3b8a0..825793767d41 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -109,4 +109,10 @@ mcu_pmx0: pinctrl@4084000 {
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
+
+	mcu_esm: esm@4100000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x4100000 0x00 0x1000>;
+		ti,esm-pins = <0>, <1>;
+	};
 };
-- 
2.40.0

