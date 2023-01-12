Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D12266709E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjALLMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjALLLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:11:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D766B54D87;
        Thu, 12 Jan 2023 03:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673521403; x=1705057403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/1kIJrcOAyKVevXhfiD87Iof+tcVfPU5Ymnzf+FJC4I=;
  b=kYpDvWIuTUIO0oH83sw3PR4wFKo7nR1GafBp3oVU+amzu01Lpen+b+B9
   WVXEOsXqfUx2dyUGI7N5LxJxo+WF0R2FcOpzDUMrgqnXvVWc8qkp0FPzJ
   OaZQnK6pMGTZpgfTxgT9rGW+DHVr+gh/bOjvTuco8rdOGCTb7aQxv6pNl
   b+HGiIWdD2cdjNHJ20tMiS8M3QEfIelXIDDl4uTF7rDabc61hiWzPc47S
   7cKuatZUZZ2ku0lYmdjsuydxwgDgasriSk4BV/vL3cTFczCdq0EPb8xOr
   eG6NwkOXVUj+NDHEmH4l1mQLt3YEv9/Ly/35fkrdmwiu04QA4iQfhuFZX
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="131991591"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 04:03:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 04:03:22 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 04:03:14 -0700
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
Subject: [PATCH v4 4/8] ARM: dts: at91: sam9x60: Specify the FIFO size for the Flexcom UART
Date:   Thu, 12 Jan 2023 16:32:04 +0530
Message-ID: <20230112110208.97946-5-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230112110208.97946-1-durai.manickamkr@microchip.com>
References: <20230112110208.97946-1-durai.manickamkr@microchip.com>
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
index 74c90158801b..fbdde3ab1086 100644
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

