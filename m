Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1448965674B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 06:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiL0FMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 00:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiL0FMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 00:12:42 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A76025F6;
        Mon, 26 Dec 2022 21:12:37 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BR5CL1j110604;
        Mon, 26 Dec 2022 23:12:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672117941;
        bh=CgmGw+dFUCEc9kNHgk9+wDsEsqV5Z4l7nEelOZRhQkM=;
        h=From:To:CC:Subject:Date;
        b=HblTwrzR4ERHxsMkRkSCW18TavOuHzASRELSNCm7WL+EEZDtSN1RaS1LtcNUSahq1
         gcus9i3vCLgmB4hKbnJODklAnEm3vdf3b3qLVajRkAiWWgWlCx9U6O27uLj2QhTRa0
         YvL3LRQLJRUsCMMAZVBo/bClTDS2CJwwNzjwdOS4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BR5CLWi072300
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Dec 2022 23:12:21 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 26
 Dec 2022 23:12:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 26 Dec 2022 23:12:20 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BR5CJHM124680;
        Mon, 26 Dec 2022 23:12:20 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Dhruva Gole <d-gole@ti.com>, <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am62-main: Fix clocks for McSPI
Date:   Tue, 27 Dec 2022 10:42:08 +0530
Message-ID: <20221227051208.158894-1-d-gole@ti.com>
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

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

For reference, TISCI Docs: clock id's for AM62
https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/am62x/clocks.html

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

