Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B336EA6EB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjDUJ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjDUJ2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:28:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DC6AD0E;
        Fri, 21 Apr 2023 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682069280; x=1713605280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVYx9+DVF2GF+A4bANXLI3OWUXhLfRnRmzz023oqQG4=;
  b=bsfBLVQljqpqfet5szpRZGw9poLpBfwibghWwFa+h2F9u0AHewkmWXBe
   j/PjQQpi43OmkpFJXpcDe6P2/aoBDImy5PmF1ySbqWZyBd5cxRdRZfaQi
   fzVByeS9kMCZyjW5UTW7pebRBtLasuqksuVOzxuGJsgxLIGa6WXT14yeL
   DO0/W445Tat4nHJRefvLNoBqKETHBxxZmp5PUcrDAP9jgCcdSK4j45WKI
   UlS2/UiIWp7+weOEsz4DzF39wvO5sQPXvr6aAt77LVkzY9Q/+q8UolIcQ
   bUV8cpTpAUBluQtM9UjDk9mrkvhNAOvIeCAmMGDbNw0JXs646q1vu3O7y
   w==;
X-IronPort-AV: E=Sophos;i="5.99,214,1677567600"; 
   d="scan'208";a="221946996"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2023 02:27:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 21 Apr 2023 02:27:56 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 21 Apr 2023 02:27:54 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v17 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Fri, 21 Apr 2023 10:27:10 +0100
Message-ID: <20230421-affix-atlas-156f7a5ab395@wendy>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421-neurology-trapezoid-b4fa29923a23@wendy>
References: <20230421-neurology-trapezoid-b4fa29923a23@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=668; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=gVYx9+DVF2GF+A4bANXLI3OWUXhLfRnRmzz023oqQG4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClOYW9+xi7/GLr6i4O79S45L9FEq8u7Jn0NK0iQ+MaU9O+I 77z/HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiI0HRGhm8Zs6eUTn87/XXNZ5ENFk 4Rq3K3L1Td32Fs2DDZ10nm3GFGhhspbbq11Sb+K+f8KvzDplm5wjxD3mpxjn/xlLjy15dW8wEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the newly introduced pwm driver to the existing PolarFire SoC entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..128cc89a47d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17993,6 +17993,7 @@ F:	drivers/clk/microchip/clk-mpfs.c
 F:	drivers/i2c/busses/i2c-microchip-corei2c.c
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/pci/controller/pcie-microchip-host.c
+F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/reset/reset-mpfs.c
 F:	drivers/rtc/rtc-mpfs.c
 F:	drivers/soc/microchip/mpfs-sys-controller.c
-- 
2.39.2

