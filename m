Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7619C688E32
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjBCDuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 22:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjBCDuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:50:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C27681B38;
        Thu,  2 Feb 2023 19:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675396210; x=1706932210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cMvbIa3FLCRSl3fQRWvqEpoBzJYKfBeBfB2mYetr3uk=;
  b=kH8mNbEVlzka2ozRIkCdWmQID1nNROVj2g4WvWFl3TfA9O7LdcnnQzBo
   xaoBv5WRaAnYW3JfghyVg6cAmhCoz5Vlnto/33K6Y2UhScOKkjz67O+TG
   xc310f/uheBqbutVyHhMZQ9SVxMtdNRBZYgezVSrL/j+u3H1ya1wsOAtr
   18ljkA2cMto2kX12r9PsJM7ZFlCQZxSeKW8njkQ8S0KJF+shnEvqSL8Pv
   Uwn/COQc9A3Sq39NlmQsN4y+H8yWQR8DhSUy8t4C5NDeYbIKGc2/hiEso
   J8zHyYtNW6vndguT6F7HTshU9P7NlL7RreJApMOXwJFJObHi3phlTAbVs
   w==;
X-IronPort-AV: E=Sophos;i="5.97,269,1669100400"; 
   d="scan'208";a="199411147"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Feb 2023 20:50:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 20:50:08 -0700
Received: from che-lt-i66125lx.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 20:49:49 -0700
From:   Durai Manickam KR <durai.manickamkr@microchip.com>
To:     <Hari.PrasathGE@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>,
        <manikandan.m@microchip.com>, <varshini.rajendran@microchip.com>,
        <dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
        <balakrishnan.s@microchip.com>, <claudiu.beznea@microchip.com>,
        <cristian.birsan@microchip.com>, <nicolas.ferre@microchip.com>,
        <krzysztof.kozlowski@linaro.org>, <alexandre.belloni@bootlin.com>,
        <davem@davemloft.net>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <Horatiu.Vultur@microchip.com>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <michael@walle.cc>, <jerry.ray@microchip.com>
CC:     Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH v5 4/8] ARM: dts: at91: sam9x60: Specify the FIFO size for the Flexcom UART
Date:   Fri, 3 Feb 2023 09:18:29 +0530
Message-ID: <20230203034833.451461-5-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203034833.451461-1-durai.manickamkr@microchip.com>
References: <20230203034833.451461-1-durai.manickamkr@microchip.com>
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

From: Manikandan Muralidharan <manikandan.m@microchip.com>

The UART submodule in Flexcom has 16-byte Transmit and Receive FIFOs.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 arch/arm/boot/dts/sam9x60.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
index ee6cc4329ae4..1e401a919f56 100644
--- a/arch/arm/boot/dts/sam9x60.dtsi
+++ b/arch/arm/boot/dts/sam9x60.dtsi
@@ -209,6 +209,7 @@ AT91_XDMAC_DT_PER_IF(1) |
 					clock-names = "usart";
 					atmel,use-dma-rx;
 					atmel,use-dma-tx;
+					atmel,fifo-size = <16>;
 					status = "disabled";
 				};
 			};
-- 
2.25.1

