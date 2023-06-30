Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFDC743F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjF3QRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjF3QQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:16:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE8513D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688141805; x=1719677805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P+hgFltg7BGQNj1jV6ZIFIkEfA1KJeI+UtK+1XY33xk=;
  b=pjJPukD0SiXlzpSOrQ6cn8C5XiLO4VDJJNd9j0jFJhxkIYTohyrO8G2i
   xiTly70UJbGS1am/VuVdMe9Jaf3n8cOmKMLU4rS/2qh7/yRLt2mcQ0tPD
   zgw0DG4FvrtGHAJAlVmacEGHWXcXj2oMaGpBMgwry9YXtTusfBPN78kUd
   FHHs/q+ZWwzsS8eYsKYorkHB0/iXaJIqIOWCTIe3oJd4hW52nYUVJHFIS
   th3gJM15UXgPk+9y8i0e/7gEBh2ewapKCAKwzTEC65LvakYGm/zfMdIR2
   3+MFHDfVoki+v2HNFe8+Qfgo+f5kpgdVHQWLdGZuGFnn9IQP3rilRMeD1
   w==;
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="159343958"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2023 09:16:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 30 Jun 2023 09:16:44 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 30 Jun 2023 09:16:44 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <tudor.ambarus@linaro.org>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>
CC:     Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH] MAINTAINERS: Add myself as a maintainer for Microchip SPI
Date:   Fri, 30 Jun 2023 09:17:00 -0700
Message-ID: <20230630161700.448747-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Tudor is not with Microchip anymore. I have worked lately
with Microchip SPI drivers replacing Tudor with myself as this
maintainer.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad32db6c81cc..8478cc82f197 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13881,7 +13881,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 F:	drivers/soc/microchip/
 
 MICROCHIP SPI DRIVER
-M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+M:	Ryan Wanner <ryan.wanner@microchip.com>
 S:	Supported
 F:	drivers/spi/spi-atmel.*
 
-- 
2.39.2

