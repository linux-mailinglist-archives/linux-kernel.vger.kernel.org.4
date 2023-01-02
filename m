Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A889465B271
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbjABM4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjABM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:56:23 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A12118D;
        Mon,  2 Jan 2023 04:56:22 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 302CuEf9051535;
        Mon, 2 Jan 2023 06:56:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672664174;
        bh=y83kqw3be0NULM776KaNwK1U3pRA8E0ZjTXXkFzpoj4=;
        h=From:To:CC:Subject:Date;
        b=gJ7KvTPrK+VEAAE2v1i1nLDEkhVf6vIEJZk18FHKhCqccwNyBYAFjJB9XyLUDXc/y
         m2Lwg5o41yPhivTaXFGh+aFDo5JQhngld+LRPoN5RwtD7BiIMTrP/4rvBHIldAlREe
         3nH/q9cjEXR2eGPVyNilw1KIgAChSwVRtlgdiqqs=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 302CuECa066952
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jan 2023 06:56:14 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 2
 Jan 2023 06:56:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 2 Jan 2023 06:56:13 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 302CuCvO027201;
        Mon, 2 Jan 2023 06:56:13 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Dhruva Gole <d-gole@ti.com>, <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] arm64: dts: ti: k3-am62-main: Fix clocks for McSPI
Date:   Mon, 2 Jan 2023 18:25:49 +0530
Message-ID: <20230102125549.1106984-1-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the clock Device ID's in the DT according to the tisci docs clock
identifiers for AM62x

Fixes: c37c58fdeb8a9 ("arm64: dts: ti: k3-am62: Add more peripheral
nodes")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

v2 changes:
Add the "Fixes" commit sha and summary.

link to v1:
https://lore.kernel.org/linux-devicetree/20221227051208.158894-1-d-gole@ti.com/

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 7ad7dd74e079..625e6a004292 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -418,7 +418,7 @@ main_spi0: spi@20100000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 141 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 172 0>;
+		clocks = <&k3_clks 141 0>;
 	};
 
 	main_spi1: spi@20110000 {
@@ -428,7 +428,7 @@ main_spi1: spi@20110000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 142 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 173 0>;
+		clocks = <&k3_clks 142 0>;
 	};
 
 	main_spi2: spi@20120000 {
@@ -438,7 +438,7 @@ main_spi2: spi@20120000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		power-domains = <&k3_pds 143 TI_SCI_PD_EXCLUSIVE>;
-		clocks = <&k3_clks 174 0>;
+		clocks = <&k3_clks 143 0>;
 	};
 
 	main_gpio_intr: interrupt-controller@a00000 {
-- 
2.25.1

