Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3FB6ED3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjDXRh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjDXRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:37:14 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA68A78;
        Mon, 24 Apr 2023 10:36:55 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OHaQ3I040628;
        Mon, 24 Apr 2023 12:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682357786;
        bh=9ayeJIRtQb//JI+YWiHxPFkJ9qx1xULCoJlBON7T0L8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ynJWQ7qlbdzvwrf7QklCsQjEruqS5smRmUWxk2WC7UydBAJb9GYBNXnkcDMBuaUPP
         iyBr+qnone9Rae/DJoRJ+EdeP1bjFhxm4CkjyU1xadK4PFYL7FRC5qITPGB5bbfnYX
         Rm5BxeDWAZNfguxYefnbJIFP437bUH830BJIrHSA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OHaQVv027229
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 12:36:26 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 12:36:26 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 12:36:26 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OHaQok008838;
        Mon, 24 Apr 2023 12:36:26 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        <vaishnav.a@ti.com>, <afd@ti.com>, <u-kumar1@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-j7200-mcu-wakeup: Remove 0x unit address prefix from nodename
Date:   Mon, 24 Apr 2023 12:36:21 -0500
Message-ID: <20230424173623.477577-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424173623.477577-1-nm@ti.com>
References: <20230424173623.477577-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

unit-address should not use a 0x prefix.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 331b4e482e41..674e695ef844 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -62,7 +62,7 @@ wkup_pmx0: pinctrl@4301c000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	wkup_pmx1: pinctrl@0x4301c038 {
+	wkup_pmx1: pinctrl@4301c038 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c038 0x00 0x8>;
@@ -71,7 +71,7 @@ wkup_pmx1: pinctrl@0x4301c038 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	wkup_pmx2: pinctrl@0x4301c068 {
+	wkup_pmx2: pinctrl@4301c068 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c068 0x00 0xec>;
@@ -80,7 +80,7 @@ wkup_pmx2: pinctrl@0x4301c068 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
-	wkup_pmx3: pinctrl@0x4301c174 {
+	wkup_pmx3: pinctrl@4301c174 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
 		reg = <0x00 0x4301c174 0x00 0x20>;
-- 
2.40.0

