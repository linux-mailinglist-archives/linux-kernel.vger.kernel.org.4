Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33635EC10F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiI0LVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiI0LU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:20:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A798151406;
        Tue, 27 Sep 2022 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664277625; x=1695813625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DtjFB323S4Wx5S1fAIRUAwQUn/ZVmDrcjqP1LgDfbcc=;
  b=DLyJM9l6Ts9zhUYd7iKywbUd2jC535RNe/duka/WX8SA+mk9UsM91KE7
   7Rrj4WfDTgPhhx6yr59XeJPB1GAbPXZEaANBYavbmwzbI4y1md3tNf/ie
   7tURFqJo4tIMgNm1M7UpgGiXVwQ2yFYc1+EzA11CKUus88Euv+bqP1maD
   6DFqEPGdWAYz8Wj/I7xWKsmYlyqAs+fINjpnKZ0shaeQnsaXwSVJqb4Vs
   HE+OOCTCo/VawTJWCJVXLfEbseRtiIZVUzcuFoRLVEoRECZfZ+C6CWBJ3
   IXU8Clmr/s7hXZj0W6B/taO1ODbKR/dNGCioFUVZsNpzG+KBd/hDYJ4Ty
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="179094376"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Sep 2022 04:20:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 27 Sep 2022 04:20:20 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 27 Sep 2022 04:20:17 -0700
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
Subject: [PATCH v6 08/11] riscv: dts: microchip: reduce the fic3 clock rate
Date:   Tue, 27 Sep 2022 12:19:20 +0100
Message-ID: <20220927111922.3602838-9-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927111922.3602838-1-conor.dooley@microchip.com>
References: <20220927111922.3602838-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the v2022.09 release of the reference design, the fic3 clock rate
been reduced from 62.5 MHz to 50 MHz as it allows timing to be closed
significantly more quickly by customers who chose to build the
reference design themselves.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
index 35030ea330ee..b6bfe177ccb2 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit-fabric.dtsi
@@ -29,7 +29,7 @@ i2c2: i2c@40000200 {
 	fabric_clk3: fabric-clk3 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency = <62500000>;
+		clock-frequency = <50000000>;
 	};
 
 	fabric_clk1: fabric-clk1 {
-- 
2.37.3

