Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AA95F778B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJGLgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJGLfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:35:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A61204C3;
        Fri,  7 Oct 2022 04:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665142553; x=1696678553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/OHDhGSFdwMgshUa3fgcG5d1PPCnB4LMGwCZhvO4ew=;
  b=a0jEH97Z4Hf0hUDS2YlGIod3i60ZaBhfjq52/M+sv/HwPy/GzahePQK/
   HK3g2BFWySOsV897lsbeps5htx4ClSgK5MsbfrruDtB5viNAy3F+1Z1EZ
   AseTfpF3j7CcEtfvXWVKa+J2UTBzEzp2vVq0abzTGzBxGCVVKP1IOWU0L
   ukgTjXDDoyu3FBP06FoHCzaox9CrB7PRAIBowaR58L5XMIiekt4jH5TjL
   sUtGFIvoXqNGPFE4ZU87XV8XlFC+swHVzQZH+D4w1U75ESrYoDrFqDhU6
   ffrEPucenM6lRxpEE1L5iQcL0CpaLZGdR9wz0oCRJ4KvwztYMllSsmTJk
   w==;
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="180864990"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2022 04:35:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 7 Oct 2022 04:35:50 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 7 Oct 2022 04:35:49 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v11 4/4] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Fri, 7 Oct 2022 12:35:13 +0100
Message-ID: <20221007113512.91501-5-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007113512.91501-1-conor.dooley@microchip.com>
References: <20221007113512.91501-1-conor.dooley@microchip.com>
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

Add the newly introduced pwm driver to the existing PolarFire SoC entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..5db66c743595 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17532,6 +17532,7 @@ F:	drivers/char/hw_random/mpfs-rng.c
 F:	drivers/clk/microchip/clk-mpfs.c
 F:	drivers/mailbox/mailbox-mpfs.c
 F:	drivers/pci/controller/pcie-microchip-host.c
+F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/rtc/rtc-mpfs.c
 F:	drivers/soc/microchip/
 F:	drivers/spi/spi-microchip-core.c
-- 
2.37.3

