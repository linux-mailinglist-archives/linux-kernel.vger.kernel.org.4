Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513546DD608
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjDKI52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjDKI50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:57:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3491A26BE;
        Tue, 11 Apr 2023 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681203444; x=1712739444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gVYx9+DVF2GF+A4bANXLI3OWUXhLfRnRmzz023oqQG4=;
  b=SGDyAp70TwWAId8eQbA0QXOEVfypyYxwqjPa5qihttjy60n56ar3rLTe
   mQt71qm8xaTIYLR/CcPJmW+Es27Qb/dLKq9NNBHGQ0cvlA9HyNiS+1JrU
   jVsuAyVZn8N9QkjYaJYOcTbzPyDsT7kDk9Hl4B4bwcowDweizugJ/q9KY
   yn72YDlcbs0nJtIjGu0IVZTcj4nIsSVNevRCwJxNia5oCxJzez2XlPz4l
   6jnTtPeCfMs7pV4g5fHnWuP//m+vQ13XDUXpdC4L74GJL5q+/WGkE+yIV
   qOsowHGbwNxqbG0/wH3GwwZyzw89qnnONVt6nF4RdRXGKxn2U6kNirO30
   A==;
X-IronPort-AV: E=Sophos;i="5.98,336,1673938800"; 
   d="scan'208";a="146437125"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Apr 2023 01:57:11 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 11 Apr 2023 01:57:10 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 11 Apr 2023 01:57:08 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v16 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Tue, 11 Apr 2023 09:56:35 +0100
Message-ID: <20230411-dastardly-payable-a74538861513@wendy>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411-wizard-cautious-3c048db6b4d2@wendy>
References: <20230411-wizard-cautious-3c048db6b4d2@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=668; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=gVYx9+DVF2GF+A4bANXLI3OWUXhLfRnRmzz023oqQG4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmmCgfntPLVZTkVX2iuvv7xcvgSjYtbAye9ZTnN7SESeLh4 8ZHAjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkSg8jw3KX/WsDjyzNTn69+5HK3a Va1jfKFa08XxbMLeneu2bDm7MM/wMnMzzY4lW0X3xPcxrf367vpytvvpXptZi37hRTpeqBd2wA
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

