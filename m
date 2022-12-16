Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7569264ED0A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiLPOig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiLPOiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:38:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B25EDF8;
        Fri, 16 Dec 2022 06:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671201455; x=1702737455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f1429pE37vPzm/QaDn2aIzqyLLPfeKnNy8zqX601ltg=;
  b=c7FDHg+F1Ld0JsRmH0Ts16w8V1Mk4pTb8XKpeI/qRW/Lun2dMHnWlWDO
   oaRxZbZ9dcaeSJRdUPRpG/g4JEcG7mBp6AlIkRM0v2sULI+mmaJ8mUD4Z
   JqlKpYDm4KWAG24ZLYiHmWYB+aA6nfvXfvcPYTX7f3bel+hdm/XTn2tFe
   QzsSYNm5/VMzUDhK3A70rDoLsdE43AZwICJ5qxzZN3rjVqf7VmxyAGYK2
   Yw8PKPO+a4d76TuLaDTtftxa5rlxfZiS2cSye7ORdPEWR6pI15Fzbfubp
   n2P0yxVzzNinWsZREXdQPElJJNfFt+gICzQ0jOOMen4QcfzQV4Wijawu/
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="128506515"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2022 07:37:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 07:37:28 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 07:37:26 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <luis.oliveira@synopsys.com>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>
Subject: [PATCH v5 2/4] dt-bindings: phy: Document the Synopsys MIPI DPHY Rx bindings
Date:   Fri, 16 Dec 2022 16:37:15 +0200
Message-ID: <20221216143717.1002015-3-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216143717.1002015-1-eugen.hristev@microchip.com>
References: <20221216143717.1002015-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Oliveira <Luis.Oliveira@synopsys.com>

Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
RX mode.

Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
---
 .../bindings/phy/snps,dw-dphy-rx.txt          | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt

diff --git a/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt b/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt
new file mode 100644
index 000000000000..ffb64fe5cbd1
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt
@@ -0,0 +1,29 @@
+Synopsys DesignWare MIPI Rx D-PHY block details
+
+Description
+-----------
+
+The Synopsys MIPI D-PHY controller supports MIPI-DPHY in receiver mode.
+Please refer to phy-bindings.txt for more information.
+
+Required properties:
+- compatible		: Shall be "snps,dw-dphy-rx".
+- #phy-cells		: Must be 1.
+- bus-width		: Size of the test interface data bus (8 bits->8 or
+			  12bits->12).
+- snps,dphy-frequency	: Frequency at which D-PHY should start, configurable.
+			  Check Synopsys databook. (-kHz)
+- reg			: Test interface register. This correspondes to the
+			  physical base address of the controller and size of
+			  the device memory mapped registers; Check Synopsys
+			  databook.
+
+Example:
+
+	mipi_dphy_rx1: dphy@d00003040 {
+		compatible = "snps,dw-dphy-rx";
+		#phy-cells = <1>;
+		bus-width = <12>;
+		snps,dphy-frequency = <300000>;
+		reg = <0xd0003040 0x20>;
+	};
-- 
2.25.1

