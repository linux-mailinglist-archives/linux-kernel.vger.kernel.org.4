Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B456E6F54D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjECJdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjECJdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:33:32 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FC7420B;
        Wed,  3 May 2023 02:33:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3439XNMW002901;
        Wed, 3 May 2023 04:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683106403;
        bh=1GIZKi464DswWpYYI8PkLUvrxRe5Lbt01DrvEsUrNoA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b6Bh8NxZcHtK5fMovChjB5qzxVOtKo3H1vY5HpGqRSlCaocbBfInSaNJyXp29l9kX
         LQ0XhDObLUkVxE5BagxCSUnovSPlHZV0b4Y5K88bpLCHKHGHlNqTRNtScKwvE87rc+
         3WjrPl56opXJHAL693nfD3k6KZTqAhVTuDbkIwGQ=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3439XNlx094634
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 04:33:23 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 04:33:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 04:33:22 -0500
Received: from ula0497641.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3439XAIo084380;
        Wed, 3 May 2023 04:33:20 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <n-francis@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v4 3/3] arm64: dts: ti: k3-j7200: Add ESM support
Date:   Wed, 3 May 2023 15:03:10 +0530
Message-ID: <20230503093310.85779-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503093310.85779-1-n-francis@ti.com>
References: <20230503093310.85779-1-n-francis@ti.com>
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

Add address entry mapping ESM on J7200.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 6 ++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi      | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index ef352e32f19d..89f816f5e53d 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -1010,4 +1010,10 @@ main_r5fss0_core1: r5f@5d00000 {
 			ti,loczrama = <1>;
 		};
 	};
+
+	main_esm: esm@700000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x0 0x700000 0x0 0x1000>;
+		ti,esm-pins = <656>, <657>;
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200.dtsi b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
index bbe380c72a7e..4998eb4fbe75 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200.dtsi
@@ -128,6 +128,7 @@ cbass_main: bus@100000 {
 		#size-cells = <2>;
 		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
 			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
+			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
 			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* timesync router */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
-- 
2.34.1

