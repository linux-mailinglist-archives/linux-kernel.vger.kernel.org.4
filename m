Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2D175013B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjGLIUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjGLITe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:19:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBDE26B8;
        Wed, 12 Jul 2023 01:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689149802; x=1720685802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eeJoNzKNu6qUVnwz+5GZhUrJMC3KM11Xsjrz/i3wt6I=;
  b=bORo2nyuRMXkxuqqcETLxbxwuiJm5b6Ilf9kAJg6GwDe2mpDSF8x7Ls2
   VTVwmhJSJLaAqHumMcmdkD2kPlutV16JT4cK1TC8Y7dwYu77zPwW4mHzD
   PF4NCcQOOGSrHqzOhLF2H+2MCMyPv4EI9dRqbUoTJpkmVa9Kd337AIaVY
   9VOCxiPSUcubbrnk4idBojz1iKNp9WoaR4lTa/EK0tL2cY3hclD5DTJmY
   6h6+/TO6D1viSBp6PltN6lbBpvrJ3lYagNtL3MRsLRvJUCifu0ITAMbBw
   sxwObKSodkhO3u/uuHnJ1b/yLgFzzcECNHKLmySLWDIAaOb64+rLKesW2
   w==;
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="235030971"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jul 2023 01:15:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Jul 2023 01:15:40 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Jul 2023 01:15:38 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <geert+renesas@glider.be>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] riscv: dts: renesas: clean up dtbs_check W=1 warning due to empty phy node
Date:   Wed, 12 Jul 2023 09:14:44 +0100
Message-ID: <20230712-squealer-walmart-9587342ddec1@wendy>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=eeJoNzKNu6qUVnwz+5GZhUrJMC3KM11Xsjrz/i3wt6I=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCnrEj6ZJprzlM1qf2eXt+dhTsY7CwupUy7/hFckhnO8Voic /GpzRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACYi48/wP69ijZVUyPadHeuPb8oVc5 Ccwev1cfWPpzxix3MT5EIlhRgZ7t1t/yL6i43ZpMW0utjItHHiNqeb8rKb7ZIvuF/UdnzBCgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtbs_check w/ W=1 complains:
Warning (unit_address_vs_reg): /soc/ethernet@11c20000/ethernet-phy@7: node has a unit name, but no reg or ranges property
Warning (avoid_unnecessary_addr_size): /soc/ethernet@11c20000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

The ethernet@11c20000 node is guarded by an `#if (!SW_ET0_EN_N)` in
rzg2ul-smarc-som.dtsi, where the phy child node is added. In
rzfive-smarc-som.dtsi, the ethernet node is marked disabled & the
interrupt properties are deleted from the phy child node. As a result,
the produced dts looks like:
	ethernet@11c20000 {
		compatible = "renesas,r9a07g043-gbeth\0renesas,rzg2l-gbeth";
		/* snip */
		#address-cells = <0x01>;
		#size-cells = <0x00>;
		status = "disabled";

		ethernet-phy@7 {
		};
	};

Adding a corresponding `#if (!SW_ET0_EN_N)` around the node in
rzfive-smarc-som.dtsi avoids the complaint, as the empty child node is
not added:
	ethernet@11c20000 {
		compatible = "renesas,r9a07g043-gbeth\0renesas,rzg2l-gbeth";
		/* snip */
		#address-cells = <0x01>;
		#size-cells = <0x00>;
		status = "disabled";
	};

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Geert Uytterhoeven <geert+renesas@glider.be>
CC: Magnus Damm <magnus.damm@gmail.com>
CC: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: linux-renesas-soc@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index d6f18754eb5d..c62debc7ca7e 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -22,6 +22,7 @@ &dmac {
 	status = "disabled";
 };
 
+#if (!SW_ET0_EN_N)
 &eth0 {
 	status = "disabled";
 
@@ -30,6 +31,7 @@ phy0: ethernet-phy@7 {
 		/delete-property/ interrupts;
 	};
 };
+#endif
 
 &eth1 {
 	status = "disabled";
-- 
2.40.1

