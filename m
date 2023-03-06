Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0854E6ABA59
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjCFJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCFJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:50:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1F72333B;
        Mon,  6 Mar 2023 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678096201; x=1709632201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=276T++Ba7jMivtEgAFP836L0rMlfsQm/Se+v+ZQ2unk=;
  b=TjKN3Jq4S+OMxYAfNWfGHfwzIGiWY5GTIIwbHohPjOJY7o+GW0IVRMlJ
   zpzQU/8HckXdjFexaEu7bvetodJVOsWqKgPeZTKbjhi0E0vSAGgh47UcA
   vKQVfR0kxOWB2gsR47G91NHI33iqLsXqjQGgxQyB4AcmpB9yadiA0OT6i
   /WN7duguXk/ooHV5ZB6T79x5jFTy60ofOo5u7duEZF/PWEetWYGAltKFv
   XUeMlNT9ZH53XpagkKumvdpX2JC7YcWnRYDWL6JuWZgaHiC4WdDGYCZml
   QzeznQkP2f9fV4fOYEBjhy4rx6H0uSb8mimjd8JBm13EUOQvcEc/UVluB
   A==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673938800"; 
   d="scan'208";a="203807099"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 02:50:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 02:50:00 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Mon, 6 Mar 2023 02:49:59 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v14 2/2] MAINTAINERS: add pwm to PolarFire SoC entry
Date:   Mon, 6 Mar 2023 09:48:59 +0000
Message-ID: <20230306094858.1614819-3-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306094858.1614819-1-conor.dooley@microchip.com>
References: <20230306094858.1614819-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=670; i=conor.dooley@microchip.com; h=from:subject; bh=276T++Ba7jMivtEgAFP836L0rMlfsQm/Se+v+ZQ2unk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCms2zk3xT39+OXegR1ii8S71rb0VM0rzlm+rpZ979mZWs+e l35V7ihlYRDjYJAVU2RJvN3XIrX+j8sO5563MHNYmUCGMHBxCsBEPgcx/C/fk1O22n7S8+nh0R9tLx jLe/tFiioqVE23jbm49p2IqyfDP+2Z3JIR4WJKFfKno+c93r9mxoW0PaHBu/Q2cE646H37BzsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
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

Add the newly introduced pwm driver to the existing PolarFire SoC entry.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f3053..128cc89a47d8e 100644
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

