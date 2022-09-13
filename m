Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4079D5B76D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiIMQyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiIMQxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:53:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02DE136;
        Tue, 13 Sep 2022 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663084019; x=1694620019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SbCjoEiyySf0wEqGD1QoXIt7eMt5aSq3M/gKQ/kWBnk=;
  b=n1VQD4eb/yYe/T6Ssg/Ftr0nfjW2ndnkpNwF/0vh4MH4boD1qd0Q/37f
   DtPtZvApVxtaOZvOsJXiuyy+tRbvByR4zqQ8HUZmkzlvbyxbXjTZYOgR5
   gpgkssU1Hn+h4REJgtKoOzMlFAXXnsmZZvX6Mnv0ASTm3sEDHtAF1B3r8
   fhTo0hAzBnqrui3a4Ut2KWjiBJPymuUraUqt1cPfrKWq+Qdwwj3QQvYhm
   cZYe5BeU+aRFLo01/Gu9AJdbpJpTP8J0Ok5stidxBB5w3KZi4HLFjEiBS
   tpoaJBILf/rOim3suwdlKiBOCaMmUpwE56VG+JL2L/DHmEHkDx52Rlj4E
   A==;
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="176926290"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Sep 2022 07:24:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 13 Sep 2022 07:24:49 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 13 Sep 2022 07:24:45 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <broonie@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <jirislaby@kernel.org>, <sergiu.moga@microchip.com>,
        <admin@hifiphile.com>, <kavyasree.kotagiri@microchip.com>,
        <tudor.ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v3 01/14] ARM: dts: at91: sama7g5: Swap rx and tx for spi11
Date:   Tue, 13 Sep 2022 17:21:53 +0300
Message-ID: <20220913142205.162399-2-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913142205.162399-1-sergiu.moga@microchip.com>
References: <20220913142205.162399-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap the rx and tx of the DMA related DT properties of the spi11 node
in order to maintain consistency across Microchip/Atmel SoC files.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- Nothing, this patch was not here before


v2 -> v3:
- Nothing, this was previously [PATCH 2]



 arch/arm/boot/dts/sama7g5.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
index bb6d71e6dfeb..249f9c640b6c 100644
--- a/arch/arm/boot/dts/sama7g5.dtsi
+++ b/arch/arm/boot/dts/sama7g5.dtsi
@@ -866,9 +866,9 @@ spi11: spi@400 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				atmel,fifo-size = <32>;
-				dmas = <&dma0 AT91_XDMAC_DT_PERID(27)>,
-					    <&dma0 AT91_XDMAC_DT_PERID(28)>;
-				dma-names = "rx", "tx";
+				dmas = <&dma0 AT91_XDMAC_DT_PERID(28)>,
+					    <&dma0 AT91_XDMAC_DT_PERID(27)>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 		};
-- 
2.34.1

