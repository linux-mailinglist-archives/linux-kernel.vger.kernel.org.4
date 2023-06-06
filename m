Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F16B724B39
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbjFFSXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjFFSWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:22:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D2F1717;
        Tue,  6 Jun 2023 11:22:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356IMOC3044671;
        Tue, 6 Jun 2023 13:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686075744;
        bh=gGrbyt8jHmoAAvL8xxlbapNNF6I9JwF2SlrUyt0FqtQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cXWVmQpX/CIiKAH86C+uLrhTT0o/wlukoqdkFBcDgcjzDBq8Iwe4t2yxgU8LzvEw1
         lrvkNqJOzFoUUsmVpx60yMrfMsXB2s6lIWOmZPrBVDghJcZ2oozlGoSa4qPiF4tnVl
         OtEDQdpu7HjtK2HDzhQGIsuD2P/bolqojGKBY250=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356IMNxm089043
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 13:22:23 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 13:22:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 13:22:23 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356IMNRC024148;
        Tue, 6 Jun 2023 13:22:23 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 14/14] arm64: dts: ti: k3-am68-sk-base-board: Fixup reference to phandles array
Date:   Tue, 6 Jun 2023 13:22:20 -0500
Message-ID: <20230606182220.3661956-15-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606182220.3661956-1-nm@ti.com>
References: <20230606182220.3661956-1-nm@ti.com>
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

When referring to array of phandles, using <> to separate the array
entries is better notation as it makes potential errors with phandle and
cell arguments easier to catch. Fix the outliers to be consistent with
the rest of the usage.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
No Changes since V1
V1: https://lore.kernel.org/r/20230601152636.858553-13-nm@ti.com
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
index 27a43a8ecffd..ae9116655a83 100644
--- a/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts
@@ -287,7 +287,7 @@ &main_sdhci1 {
 
 &mcu_cpsw {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mcu_cpsw_pins_default &mcu_mdio_pins_default>;
+	pinctrl-0 = <&mcu_cpsw_pins_default>, <&mcu_mdio_pins_default>;
 };
 
 &davinci_mdio {
-- 
2.40.0

