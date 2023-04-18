Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9176E6A33
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjDRQwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjDRQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:52:37 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26AA5E7E;
        Tue, 18 Apr 2023 09:52:33 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33IGqEAS091671;
        Tue, 18 Apr 2023 11:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681836734;
        bh=Z8ezcCgcZ4u82Fn4sN/wIifJyqSb2h8hCeRmgO9EfB4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Jf5g+oNQbZ2oFpkyZ9zTRs3aGX4rsUG0soQsiGOI6Ke1pKQ9qpXLi53JKKl2i5oW/
         X7vrggHmPgBNB35R/9Sw3BuccNnP37deNGlZRdtxkdtP2ydolJxVVKAyt8ko2byRMd
         nR9vriimskjpG5CLbhZKU2ajRER0TsWg21e6n+MQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33IGqEUn036074
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Apr 2023 11:52:14 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 18
 Apr 2023 11:52:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 18 Apr 2023 11:52:14 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33IGqEea128610;
        Tue, 18 Apr 2023 11:52:14 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/5] arm64: dts: ti: k3-am65*: Drop bootargs
Date:   Tue, 18 Apr 2023 11:52:09 -0500
Message-ID: <20230418165212.1456415-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418165212.1456415-1-nm@ti.com>
References: <20230418165212.1456415-1-nm@ti.com>
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

Drop bootargs from the dts

Cc: Jan Kiszka <jan.kiszka@siemens.com>
Link: https://lore.kernel.org/linux-arm-kernel/81134eb9-2b7d-05bc-3035-a47f020861a8@linaro.org/
Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 1 -
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 96ac2b476b11..7d256a1638ff 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -21,7 +21,6 @@ aliases {
 
 	chosen {
 		stdout-path = "serial3:115200n8";
-		bootargs = "earlycon=ns16550a,mmio32,0x02810000";
 	};
 
 	reserved-memory {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 592ab2b54cb3..0d6fc89eba7a 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -15,7 +15,6 @@ / {
 
 	chosen {
 		stdout-path = "serial2:115200n8";
-		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
 	};
 
 	memory@80000000 {
-- 
2.40.0

