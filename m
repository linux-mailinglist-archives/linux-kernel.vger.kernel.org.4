Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5885BD039
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 17:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiISPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiISPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 11:14:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A2233E24;
        Mon, 19 Sep 2022 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663600447; x=1695136447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I4gMGo2tfk/2mg9vrlwrTzCDmtNMbNJml/dUvNSNDZ4=;
  b=kG5tYkjCHpb3mDSOy7xoLpe00U1KIXBXZGx+m2tYIe/81C2uXZtAANgB
   trV5XIEL7JLdNQJKlqTmB+HM31fGRxsw93MBJ6A5z64YCzWg5QtAQSAyT
   +VuOvh0bzoQXw/QNC1DzHIE+0ctlzLLONhaX8I9XKIRDjKuBNa8yB7ms3
   Et+kaOacBXPUfOREkLvJIW0YrxmJNj/uBjZDGIGpsDBucD/+ynfnM5kob
   bgSt4O9rYkQaXKIu/blECeN4V7RGo6gepFCWQ9d+zyUrjBWmSpQDmyi5l
   MpFrUP4Q7XSMhmONeTLPl9+LQc22ki2/nrxzj2n2agDXh5PALIxNn3eLU
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; 
   d="scan'208";a="180993026"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2022 08:14:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 19 Sep 2022 08:14:04 -0700
Received: from ROB-ULT-M68701.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 19 Sep 2022 08:14:01 -0700
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
Subject: [PATCH v4 6/9] tty: serial: atmel: Define GCLK as USART baudrate source clock
Date:   Mon, 19 Sep 2022 18:08:44 +0300
Message-ID: <20220919150846.1148783-7-sergiu.moga@microchip.com>
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

Define the bit that represents the choice of having GCLK as a baudrate
source clock inside the USCLKS bitmask of the Mode Register of
USART IP's.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
---


v1 -> v2:
- Nothing, this patch was not here before


v2 -> v3:
- Nothing


v3 -> v4:
- Nothing, this was previously [PATCH 10]


 drivers/tty/serial/atmel_serial.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/atmel_serial.h b/drivers/tty/serial/atmel_serial.h
index 0d8a0f9cc5c3..70d0611e56fd 100644
--- a/drivers/tty/serial/atmel_serial.h
+++ b/drivers/tty/serial/atmel_serial.h
@@ -49,6 +49,7 @@
 #define	ATMEL_US_USCLKS		GENMASK(5, 4)	/* Clock Selection */
 #define		ATMEL_US_USCLKS_MCK		(0 <<  4)
 #define		ATMEL_US_USCLKS_MCK_DIV8	(1 <<  4)
+#define		ATMEL_US_USCLKS_GCLK		(2 <<  4)
 #define		ATMEL_US_USCLKS_SCK		(3 <<  4)
 #define	ATMEL_US_CHRL		GENMASK(7, 6)	/* Character Length */
 #define		ATMEL_US_CHRL_5			(0 <<  6)
-- 
2.34.1

