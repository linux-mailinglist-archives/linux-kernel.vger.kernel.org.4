Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE3716CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjE3SyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjE3Sxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:53:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9F711C;
        Tue, 30 May 2023 11:53:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UIrbxZ103091;
        Tue, 30 May 2023 13:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685472817;
        bh=8MQJKd5tltnlPOML3VfiDZl1C1GQ9KeotjeqacAFZ14=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hOVq7Y6KEf4uGKLQ6VgtiOjMEb/swSuaUW5AopLaXjjnuY9J/hAds+JWj+6aX+cSe
         AqVu6wTe23LcWSBqVn9CY1ZZCW/QoblimaAYzxuO3kb8+Kq7vwPW/J7133w0gufWI7
         yKTOkXG/gRtajP9X/Fv9zsZHWn4KVUZszHzkrSVI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UIrbhL003513
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 13:53:37 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 13:53:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 13:53:36 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UIra8F080453;
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
Subject: [PATCH 1/2] arm64: dts: ti: k3-am62: Add ESM support
Date:   Tue, 30 May 2023 13:53:34 -0500
Message-ID: <20230530185335.79942-2-nm@ti.com>
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

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 6 ++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi  | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index bf3e054c72ce..2488e3a537fe 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -207,6 +207,12 @@ main_pmx0: pinctrl@f4000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	main_esm: esm@420000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x420000 0x00 0x1000>;
+		ti,esm-pins = <160>, <161>, <162>, <163>, <177>, <178>;
+	};
+
 	main_timer0: timer@2400000 {
 		compatible = "ti,am654-timer";
 		reg = <0x00 0x2400000 0x00 0x400>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index 076601a41e84..19fc38157d94 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -14,6 +14,12 @@ mcu_pmx0: pinctrl@4084000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	mcu_esm: esm@4100000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x4100000 0x00 0x1000>;
+		ti,esm-pins = <0>, <1>, <2>, <85>;
+	};
+
 	/*
 	 * The MCU domain timer interrupts are routed only to the ESM module,
 	 * and not currently available for Linux. The MCU domain timers are
-- 
2.40.0

