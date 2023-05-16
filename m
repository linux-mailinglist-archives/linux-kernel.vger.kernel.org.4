Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D170455D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 08:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEPGgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 02:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjEPGe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 02:34:57 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F52D5E;
        Mon, 15 May 2023 23:34:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34G6MFXK039720;
        Tue, 16 May 2023 01:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684218135;
        bh=i7fEb4N6KWiGRKO+nezi8I99sx9V79zEmtA2DmI4a00=;
        h=From:To:CC:Subject:Date;
        b=dedb1BX2M1d6lPcgQsqImJpnqrIPVfdqeMn5y/mwJ9W7w3u1hn+bN07oTH4CuL+Rx
         65f/m+ampwW44D9lCAEHmYCf200VQh9qQKkNsifCqS7g2LJta4Lp1IoWyZkLbUuZVZ
         zei3M0edmrkEJvSdj/9EYvokJCquWBA0iGmafNiw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34G6MFxO020034
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 01:22:15 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 01:22:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 01:22:13 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34G6MC0v039783;
        Tue, 16 May 2023 01:22:13 -0500
From:   Achal Verma <a-verma1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Achal Verma <a-verma1@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j7200: correct num-lanes requested for PCIe
Date:   Tue, 16 May 2023 11:52:12 +0530
Message-ID: <20230516062212.2635948-1-a-verma1@ti.com>
X-Mailer: git-send-email 2.25.1
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

From: Matt Ranostay <mranostay@ti.com>

J7200 has a limited 2x support for PCIe, and the properties should be
updated as such.

Signed-off-by: Matt Ranostay <mranostay@ti.com>
Signed-off-by: Achal Verma <a-verma1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index ef352e32f19d..5e62b431d6e8 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -729,7 +729,7 @@ pcie1_rc: pcie@2910000 {
 		device_type = "pci";
 		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
 		max-link-speed = <3>;
-		num-lanes = <4>;
+		num-lanes = <2>;
 		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 240 6>;
 		clock-names = "fck";
@@ -757,7 +757,7 @@ pcie1_ep: pcie-ep@2910000 {
 		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
 		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
 		max-link-speed = <3>;
-		num-lanes = <4>;
+		num-lanes = <2>;
 		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 240 6>;
 		clock-names = "fck";
-- 
2.25.1

