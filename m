Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF56ED0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 16:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbjDXOuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 10:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjDXOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 10:50:36 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6AD9006;
        Mon, 24 Apr 2023 07:50:23 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33OEnqPf086635;
        Mon, 24 Apr 2023 09:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682347792;
        bh=IUVlJRzjyr8hSGIwSPL8pp9y9788lUCe4GIdVFOwXYY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oODrzL+YASEs1WyZ7O1QJ4vYyEET27syuZj8njmD0jUip3taJ5ZtihBl6TdnkiRV+
         H/OkXnFtG3rfPY3Y5/thVCIQCMAgT3y6WXKca9exp1KMemqBVdslDNivN1OTZXpkbl
         eXOBNrhbpr6Y3Er5L5iyQBEZfhqp2t52Vgrseb24=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33OEnqBk128761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Apr 2023 09:49:52 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 24
 Apr 2023 09:49:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 24 Apr 2023 09:49:52 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33OEnq1B077027;
        Mon, 24 Apr 2023 09:49:52 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/7] arm64: dts: ti: k3-am65-main: Fix mcan node name
Date:   Mon, 24 Apr 2023 09:49:46 -0500
Message-ID: <20230424144949.244135-5-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424144949.244135-1-nm@ti.com>
References: <20230424144949.244135-1-nm@ti.com>
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

s/mcan/can to stay in sync with bindings conventions.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 566dc584d3f3..e8bb82d8267e 100644
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

