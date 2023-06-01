Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A135D71F1F5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjFAScZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjFAScH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:32:07 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917C319F;
        Thu,  1 Jun 2023 11:32:05 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351IVshI091649;
        Thu, 1 Jun 2023 13:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685644314;
        bh=ZOkhynB1EGFmE6jr3YpCwfdJRd5OuBYOeE/Tgvc1wHY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qvJUu3f5d9fm8/tawVP7R6mnyY16n+ckOVgUaqH6N79c2+ojMGedayJCjkmPxUjiG
         6ngUbin37Vfeh014HgdmKcYpIxW8dCCht3j0P3YaIpsF90koI44b8/W1ECdT5n+dgO
         LfpwwS809NFMFg3bFpRyvEpoH+CtkeS8dpH0RFz0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351IVsDw104517
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 13:31:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 13:31:54 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 13:31:53 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351IVsl1097122;
        Thu, 1 Jun 2023 13:31:54 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH 8/9] arm64: dts: ti: k3-j721e-common-proc-board: Define aliases at board level
Date:   Thu, 1 Jun 2023 13:31:50 -0500
Message-ID: <20230601183151.1000157-9-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230601183151.1000157-1-nm@ti.com>
References: <20230601183151.1000157-1-nm@ti.com>
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

Define the aliases at the board level instead of using generic aliases
at SoC level.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 25111c86511f..b524a65ab43f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -17,6 +17,18 @@ / {
 	compatible = "ti,j721e-evm", "ti,j721e";
 	model = "Texas Instruments J721e EVM";
 
+	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		serial4 = &main_uart2;
+		serial6 = &main_uart4;
+		ethernet0 = &cpsw_port1;
+		mmc0 = &main_sdhci0;
+		mmc1 = &main_sdhci1;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
-- 
2.40.0

