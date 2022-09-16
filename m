Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8D5BAC63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiIPL1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiIPL1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:27:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9141A4B0C;
        Fri, 16 Sep 2022 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663327647; x=1694863647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyLDKbNNI38wXrC5Tei7bV2mB9uLlpphPD5ViUjlS80=;
  b=Gu73X08GaNR79I2hTzf/awwLNnW/ob9SVkhBlo5FbEUVku5LTJcmV9Pt
   4voqN7c2kiqBod5Su8F1FNoxI2atv/bDcwBAUJBudr2T7Vm+VdsSdqhGs
   AS1+MsGfCGT5ZtDWJLTtZJg8JopplrlEL5MEu3+A7MZEN+KY/GghqyPB1
   XvAJBi8mXa9CFC0Jfq0vF1AHCi4NRZ3x4FB5MtBMp/rDsAnzYBt2EJb2x
   Ck7e7GngGvjM1IrQkBkGXBtuw0Wknb3IteH2xDu9u1l01CYMTjqTvR4ON
   1vak8n1vl0RcRm6t5augz9/YJ30+v9cSvFJc0qBMQ8jxvPVBKlEcm2HmZ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,320,1654585200"; 
   d="scan'208";a="180674454"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2022 04:27:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 16 Sep 2022 04:27:25 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 16 Sep 2022 04:27:22 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Shravan Chippa <shravan.chippa@microchip.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cyril Jean <Cyril.Jean@microchip.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Vattipalli Praveen <praveen.kumar@microchip.com>,
        Wolfgang Grandegger <wg@aries-embedded.de>,
        Hugh Breslin <hugh.breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 04/10] riscv: dts: microchip: add pci dma ranges for the icicle kit
Date:   Fri, 16 Sep 2022 12:26:40 +0100
Message-ID: <20220916112645.567794-5-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220916112645.567794-1-conor.dooley@microchip.com>
References: <20220916112645.567794-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently removed, accidentally included, "matr0" property was used
in place of a dma-ranges property. The PCI controller is non-functional
with mainline Linux in the v2022.02 or later reference designs and has
not worked without configuration of address-translation since v2021.08.

Add the address translation that will be used by the v2022.09 reference
design & update the compatible used by the dts.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 7 ++++++-
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts         | 3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index 0d28858b83f2..c0fb9dd7b2c8 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -2,7 +2,8 @@
 /* Copyright (c) 2020-2021 Microchip Technology Inc */
 
 / {
-	compatible = "microchip,mpfs-icicle-reference-rtlv2203", "microchip,mpfs";
+	compatible = "microchip,mpfs-icicle-reference-rtlv2209", "microchip,mpfs-icicle-kit",
+		     "microchip,mpfs";
 
 	core_pwm0: pwm@41000000 {
 		compatible = "microchip,corepwm-rtl-v4";
@@ -37,3 +38,7 @@ fabric_clk1: fabric-clk1 {
 		clock-frequency = <125000000>;
 	};
 };
+
+&pcie {
+	dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x1 0x00000000>;
+};
diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index f3f87ed2007f..5e2b8aa2ff64 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -11,7 +11,8 @@
 
 / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
-	compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";
+	compatible = "microchip,mpfs-icicle-reference-rtlv2209", "microchip,mpfs-icicle-kit",
+		     "microchip,mpfs";
 
 	aliases {
 		ethernet0 = &mac1;
-- 
2.36.1

