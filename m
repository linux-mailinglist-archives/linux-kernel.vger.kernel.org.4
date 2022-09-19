Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC31E5BD040
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiISPO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiISPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:14:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ABE356E9;
        Mon, 19 Sep 2022 08:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663600453; x=1695136453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9l85M5Mmw+iMAkBceErn0IPu5335FhxC7YxeDPx3hLA=;
  b=iAMrjHpJcHEGSHviZERNBWQaf6IoSPLI8M8AiLHs/Bdyf4H2sf4XzWSe
   xCRfvapbEOHVSbHpMZYOlowVQ0w5DfZ37JN7TACwJjMULhxGTSNiwuyJs
   BueZjamDv8c7Fc34gMenklvlBxBeTc2OMTMrqbn3XxGvDn2kBUNg0I4yv
   Xn9ZlSQm7+d1agSmPveXPJqH+ZbT2FefhmY4mWT9/qrmCAbl8Iq7leak0
   ljep3wWiuVAOos5lGFyFveJTCrtrQGi2w9xbu+Cjg09gRXG+nBdSXgWli
   2jF90D8V2/TVUC0YA8/wlmFfIMlls3Th5120DUj31A8FV7CGdnu92AX5P
   A==;
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="177851613"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2022 08:14:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 19 Sep 2022 08:14:08 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 19 Sep 2022 08:14:05 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <kavyasree.kotagiri@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>
Subject: [PATCH v4 7/9] tty: serial: atmel: Define BRSRCCK bitmask of UART IP's Mode Register
Date:   Mon, 19 Sep 2022 18:08:45 +0300
Message-ID: <20220919150846.1148783-8-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220919150846.1148783-1-sergiu.moga@microchip.com>
References: <20220919150846.1148783-1-sergiu.moga@microchip.com>
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

Add definitions for the Baud Rate Source Clock bitmask of the
Mode Register of UART IP's and its bitfields.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- Nothing, this patch was not here before



v2 -> v3:
- Nothing, previously this was [PATCH 9]



V3 -> v4:
- Nothing, this was previously [PATCH 11]



 drivers/tty/serial/atmel_serial.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
index 70d0611e56fd..ed64035ba6c3 100644
--- a/drivers/tty/serial/atmel_serial.h
+++ b/drivers/tty/serial/atmel_serial.h
@@ -68,6 +68,9 @@
 #define		ATMEL_US_NBSTOP_1		(0 << 12)
 #define		ATMEL_US_NBSTOP_1_5		(1 << 12)
 #define		ATMEL_US_NBSTOP_2		(2 << 12)
+#define	ATMEL_UA_BRSRCCK	GENMASK(13, 12)	/* Clock Selection for UART */
+#define		ATMEL_UA_BRSRCCK_PERIPH_CLK	(0 << 12)
+#define		ATMEL_UA_BRSRCCK_GCLK		(1 << 12)
 #define	ATMEL_US_CHMODE		GENMASK(15, 14)	/* Channel Mode */
 #define		ATMEL_US_CHMODE_NORMAL		(0 << 14)
 #define		ATMEL_US_CHMODE_ECHO		(1 << 14)
-- 
2.34.1

