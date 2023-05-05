Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626966F8265
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjEEL71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjEEL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:59:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD031A606;
        Fri,  5 May 2023 04:59:13 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 345Bx2Q7010613;
        Fri, 5 May 2023 06:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683287942;
        bh=8vwqq5HolW7eoX/s76y8c6QTPmY82vHIUIqDWjSm7EM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Zy7mD+TYsTrEwq5DmMO7/fcKJo1kx1e0HL0lKs6G2bRO2tdMmgB89FQVb+oy+P8W+
         Vke08nMefqN2c6X5Sx+QLG3JxLOzr4f87GZ+z36UTeQSRXP2N0XsH8gwyF17K0eAYx
         ZXRcbLYhQSFV3mrdB+eMSPtvxTSp50BJPC936+fY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 345Bx2ea049505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 May 2023 06:59:02 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 May 2023 06:59:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 May 2023 06:59:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 345Bx0km078976;
        Fri, 5 May 2023 06:59:01 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <vaishnav.a@ti.com>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-j7200-mcu-wakeup: Remove 0x unit address prefix from nodename
Date:   Fri, 5 May 2023 17:28:56 +0530
Message-ID: <20230505115858.7391-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230505115858.7391-1-vaishnav.a@ti.com>
References: <20230505115858.7391-1-vaishnav.a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Menon <nm@ti.com>

unit-address should not use a 0x prefix.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2 : No changes.

 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 331b4e482e41..674e695ef844 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -62,7 +62,7 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	wkup_pmx1: pinctrl@0x4301c038 {
+	wkup_pmx1: pinctrl@4301c038 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c038 0x00 0x8>;
@@ -71,7 +71,7 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	wkup_pmx2: pinctrl@0x4301c068 {
+	wkup_pmx2: pinctrl@4301c068 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c068 0x00 0xec>;
@@ -80,7 +80,7 @@
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	wkup_pmx3: pinctrl@0x4301c174 {
+	wkup_pmx3: pinctrl@4301c174 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c174 0x00 0x20>;
-- 
2.17.1

