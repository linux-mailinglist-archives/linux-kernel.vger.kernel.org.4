Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED96E6E66
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjDRViL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjDRViA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:38:00 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7984C1B;
        Tue, 18 Apr 2023 14:37:57 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33ILbjGD004171;
        Tue, 18 Apr 2023 16:37:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681853865;
        bh=mirHeRfuw/laREKJBqS7iu34OMLUh22/EW5vFBP5/og=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Q6kGsaK2p56o4/FdATjW62U18MgBY/mIJYTFyioUrrkJFlOwLXGJSsQMUJh2zbVV5
         Kc0JvxHU5drxYvPGOySK/LFrPG28HUuYdANxQ5PpCLql59K+KmL2FXWC3vem9CXkRj
         AMXsHYNr03+h6zgloVVxXZfCFmbnMzRac7DLdPpU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33ILbjCI083340
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Apr 2023 16:37:45 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 18
 Apr 2023 16:37:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 18 Apr 2023 16:37:45 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33ILbjNo035500;
        Tue, 18 Apr 2023 16:37:45 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/4] arm64: dts: ti: k3-am62x-sk-common: Improve documentation of mcasp1_pins
Date:   Tue, 18 Apr 2023 16:37:40 -0500
Message-ID: <20230418213740.153519-5-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418213740.153519-1-nm@ti.com>
References: <20230418213740.153519-1-nm@ti.com>
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

Include documentation of the AMC package pin name as well to keep it
consistent with the rest of the pinctrl documentation.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 68cc0bfc907c..633ad7103e7a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -221,10 +221,10 @@ AM62X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (F18/E16) USB1_DRVVBUS */
 
 	main_mcasp1_pins_default: main-mcasp1-pins-default {
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x090, PIN_INPUT, 2) /* (M24) GPMC0_BE0N_CLE.MCASP1_ACLKX */
-			AM62X_IOPAD(0x098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
-			AM62X_IOPAD(0x08c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEN.MCASP1_AXR0 */
-			AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR2 */
+			AM62X_IOPAD(0x090, PIN_INPUT, 2) /* (M24/K17) GPMC0_BE0N_CLE.MCASP1_ACLKX */
+			AM62X_IOPAD(0x098, PIN_INPUT, 2) /* (U23/P21) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62X_IOPAD(0x08c, PIN_OUTPUT, 2) /* (L25/J17) GPMC0_WEN.MCASP1_AXR0 */
+			AM62X_IOPAD(0x084, PIN_INPUT, 2) /* (L23/K20) GPMC0_ADVN_ALE.MCASP1_AXR2 */
 		>;
 	};
 };
-- 
2.40.0

