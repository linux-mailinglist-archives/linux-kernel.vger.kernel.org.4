Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF572487E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbjFFQHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbjFFQG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:06:57 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFD8E40;
        Tue,  6 Jun 2023 09:06:56 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356G6ilQ041975;
        Tue, 6 Jun 2023 11:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686067604;
        bh=eW/CipUwFu0H9iANgIzTqJvB1pFqL2DvV2cPEY8jHh8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uK8Jiae2SXQJeXC6VUXqBkd/ypSHaRGn8ZPXybNk7OC5RPO1dAXHGNj/CPuoWL2VT
         DzTbFE+5YB6w07UJKDYaWPsCzAqrEbjMRk5tw3Lspe8t0wu3PKBTH5vStLx1/hlpwI
         KaJwvGhNZ7/mcRiavW/4jJPA3NWEPqk8lzsjCOH0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356G6ihF022779
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 11:06:44 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 11:06:44 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 11:06:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356G6iXd014067;
        Tue, 6 Jun 2023 11:06:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, Andrew Davis <afd@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 2/4] arm64: dts: ti: k3-am65-main: Fix mcan node name
Date:   Tue, 6 Jun 2023 11:06:41 -0500
Message-ID: <20230606160643.3618390-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606160643.3618390-1-nm@ti.com>
References: <20230606160643.3618390-1-nm@ti.com>
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

s/mcan/can to stay in sync with bindings conventions.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

No change since V1
V1: https://lore.kernel.org/r/20230424144949.244135-5-nm@ti.com

 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 5dfa31840e9c..c2519d4607a5 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -227,7 +227,7 @@ mcu_udmap: dma-controller@285c0000 {
 		};
 	};
 
-	m_can0: mcan@40528000 {
+	m_can0: can@40528000 {
 		compatible = "bosch,m_can";
 		reg = <0x0 0x40528000 0x0 0x400>,
 		      <0x0 0x40500000 0x0 0x4400>;
@@ -243,7 +243,7 @@ m_can0: mcan@40528000 {
 		status = "disabled";
 	};
 
-	m_can1: mcan@40568000 {
+	m_can1: can@40568000 {
 		compatible = "bosch,m_can";
 		reg = <0x0 0x40568000 0x0 0x400>,
 		      <0x0 0x40540000 0x0 0x4400>;
-- 
2.40.0

