Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DAE7016A6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 14:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbjEMMdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 08:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238608AbjEMMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 08:33:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F94688;
        Sat, 13 May 2023 05:33:29 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34DCXGBf088654;
        Sat, 13 May 2023 07:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683981196;
        bh=mDm3c09lBNDa/40qFmsQx7WYm45FR+XMQsaFrQIrMCw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pXR508HiDUcEpHEf+n2EpTcSoREGsouJtVUikB+iGN4oSS20Hk3CGeDEYJ+TYlfsS
         7oXmcwS0689s68pHYfsyCPKq2rgiD+7kMDzLDlVgxbkNsLy1q0df2KeZUGSPbE4LbT
         bXyi+laBU/rFpc0jK3PgRGPu6obXglZJPpNeNYi8=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34DCXGVt113090
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 13 May 2023 07:33:16 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 13
 May 2023 07:33:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 13 May 2023 07:33:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34DCXFiX096927;
        Sat, 13 May 2023 07:33:16 -0500
From:   Vaishnav Achath <vaishnav.a@ti.com>
To:     <vigneshr@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <conor+dt@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <vaishnav.a@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
Subject: [PATCH v2 1/4] arm64: dts: ti: k3-j721e-mcu-wakeup: Add HyperBus node
Date:   Sat, 13 May 2023 18:03:10 +0530
Message-ID: <20230513123313.11462-2-vaishnav.a@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230513123313.11462-1-vaishnav.a@ti.com>
References: <20230513123313.11462-1-vaishnav.a@ti.com>
MIME-Version: 1.0
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

J721E has a Flash SubSystem that has one OSPI and one HyperBus with
muxed datapath and another independent OSPI. Add DT nodes for HyperBus
controller and keep it disabled and model the data path selection mux as a
reg-mux.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
---

V1->V2:
 * Drop register region size update as the memory maps mentions
 256 Bytes for these regions.
 * Drop FSS node rename as the fix is already present in next.

Depends on :
https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 6237e1f3a477..526886e0c4f4 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -181,6 +181,27 @@
 		#size-cells = <2>;
 		ranges;
 
+		hbmc_mux: mux-controller@47000004 {
+			compatible = "reg-mux";
+			reg = <0x00 0x47000004 0x00 0x2>;
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4 0x2>; /* HBMC select */
+		};
+
+		hbmc: hyperbus@47034000 {
+			compatible = "ti,am654-hbmc";
+			reg = <0x00 0x47034000 0x00 0x100>,
+				<0x05 0x00000000 0x01 0x0000000>;
+			power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
+			clocks = <&k3_clks 102 0>;
+			assigned-clocks = <&k3_clks 102 5>;
+			assigned-clock-rates = <333333333>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			mux-controls = <&hbmc_mux 0>;
+			status = "disabled";
+		};
+
 		ospi0: spi@47040000 {
 			compatible = "ti,am654-ospi", "cdns,qspi-nor";
 			reg = <0x0 0x47040000 0x0 0x100>,
-- 
2.17.1

