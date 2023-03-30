Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E69C6CFC67
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjC3HMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjC3HMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:12:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C768B6EB2;
        Thu, 30 Mar 2023 00:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680160359; x=1711696359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVYx9+DVF2GF+A4bANXLI3OWUXhLfRnRmzz023oqQG4=;
  b=ezu2dR3UI36rPTpXutmGCDk0mmx6px0vj6k/9TwXe8GcsFJl5HKvWkxF
   AS3lJY0qpqmk+BZ6JdZIhjRoIzmHYTiq0M34wwDvwS3OGyaz3eharyZo2
   DvpXbmqF6LlgdQDvH2XSpicd7sdQ5cv0oR/IIXiSsXPLFifVCxAPmLeAq
   S/mUOFRsmrdis/wzBykpyBWI/R+pSmCnMZaGJSVijcMuzZeB6euAf1+jb
   9diwAzFtuqGO7wNMgGv22U9pMEdUQ9KasArHj8x2CFNm+65p0uBtBApRS
   d/MXCjVGOj/XqLMYuzGdRd6NbC7UXT+k+9/w1J1pIhm9XcI1wxQ+N2Iov
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="scan'208";a="218644803"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2023 00:12:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 00:12:38 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 30 Mar 2023 00:12:37 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v15 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Thu, 30 Mar 2023 08:12:04 +0100
Message-ID: <20230330071203.286972-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330071203.286972-1-conor.dooley@microchip.com>
References: <20230330071203.286972-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=668; i=conor.dooley@microchip.com; h=from:subject; bh=gVYx9+DVF2GF+A4bANXLI3OWUXhLfRnRmzz023oqQG4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmqZs7FklxF+hvPh86PrriyPY3jxIejC2cdT076wnxYSm3L kqKXHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiIBwvDXznORqe4w71nCtbdk4+4xf Mo/mr6UoW9CWsPz9++cn19aTXD/8q2+tO3xYTV5fKWeT+Wvcr0tf7wHeXNF0Uf/d21tv/ke34A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

