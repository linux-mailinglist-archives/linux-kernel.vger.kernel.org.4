Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B577770816B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjERMfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjERMfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:35:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2592E44;
        Thu, 18 May 2023 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684413348; x=1715949348;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IIWuJtF5YeJRCRhlmAxLua4lTEc3oMoMEkkaQsN/f3M=;
  b=eJx++cVMIRGLWr2QzXVczwmv7J0nmClG0uRv62WsvBTxgxSAIYfDfgpZ
   mGNooSxHxSuZCkA0Vbb8ZfbDnDIe0qdnznsFAxxopanQQFdJdDlV6z6Ck
   T7+yqR2Ot8nFHO19majmz6n4HmKEni1FqrEj4B3ODeBlXwgnwN+GuFCjM
   ZM1xSolEQn98vNIGP+HXe+xrjljcXwfUnDW4IVuf5Ekaqz3tVfqK2bwY6
   Y+Mk3U2s8QdaWs9yN8uVVOaOpSYjXsjIDTcwJVPxwVdrFduHWLQileWs2
   D4WwGm97lP56PXXj955BJJvbLuJfHJ27/D0H+h0yXNiKSCM8dj3WWyehq
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,285,1677567600"; 
   d="scan'208";a="214432189"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2023 05:35:47 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 18 May 2023 05:35:42 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 18 May 2023 05:35:41 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v18 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Thu, 18 May 2023 13:29:21 +0100
Message-ID: <20230518-headrest-puppet-d6cf2e11e340@wendy>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518-reactive-nursing-23b7fe093048@wendy>
References: <20230518-reactive-nursing-23b7fe093048@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=669; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=IIWuJtF5YeJRCRhlmAxLua4lTEc3oMoMEkkaQsN/f3M=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClpUgplf64fduuUD4mfOCF81dw5xbz1c4+Jpbp9uNzrnlIV tv5kRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACZyfA/D/+r/KaU3H79cwZP8K49d3K RN6t2PM472DhvOlf4wl9l1fDHDPz2e4u8nTWXFDVr1CyJKu9/WvX0Ts0PcL/ink7nq9Km2DAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 7e0b87d5aa2e..4ef20257cae4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18138,6 +18138,7 @@ F:	drivers/clk/microchip/clk-mpfs*.c
 F:	drivers/i2c/busses/i2c-microchip-corei2c.c
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/pci/controller/pcie-microchip-host.c
+F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/reset/reset-mpfs.c
 F:	drivers/rtc/rtc-mpfs.c
 F:	drivers/soc/microchip/mpfs-sys-controller.c
-- 
2.39.2

