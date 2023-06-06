Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB907250B0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 01:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbjFFXUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 19:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240347AbjFFXT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 19:19:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1937B210E;
        Tue,  6 Jun 2023 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686093536; x=1717629536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X57jnGuTiggRpZM0RbAoYdJUJN0S9BiOl+EhvJJH8fQ=;
  b=Z3SOPn1ODDIyZ6+ryQAAZkLGWKep06hxfnqqamFL0F9VTXVPB/lp87pk
   sGCRR2QTFf91EbYMZ7e8l1oYrFWLtHZ2Cgg5YxRQuWPxUXDQVuDlVkrHK
   wWsfqzDJipBsp+Q7ZPbQ1WQvGPNizaEVX/g9rHrvI4/5eY/7NdUis29Ao
   AYLdBwRaazVHTofEbm0iN+rC7x2XwDYwKCtX15D+Fhk7ODjbU2/34aavR
   knTnc/fBgxngCL2e+wO0aeYaj57inRHnTwt4VIPFtJ4py/V9YqqhePO6F
   0UqixqtSPy9DTF60X2bdRpUuRDnKvojdAS2AmNwUsbyWPrqIPlje33PDx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="355676518"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="355676518"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 16:18:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="659718703"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="659718703"
Received: from ekohande-desk2.vc.intel.com ([10.234.35.153])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 16:18:55 -0700
From:   Abe Kohandel <abe.kohandel@intel.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Abe Kohandel <abe.kohandel@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] spi: dw: Remove misleading comment for Mount Evans SoC
Date:   Tue,  6 Jun 2023 16:18:44 -0700
Message-Id: <20230606231844.726272-1-abe.kohandel@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a misleading comment about the DMA operations of the Intel Mount
Evans SoC's SPI Controller as requested by Serge.

Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
Link: https://lore.kernel.org/linux-spi/20230606191333.247ucbf7h3tlooxf@mobilestation/
Fixes: 0760d5d0e9f0 ("spi: dw: Add compatible for Intel Mount Evans SoC")
---
 drivers/spi/spi-dw-mmio.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index c1d16157de61..a699ce496cc5 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -237,14 +237,7 @@ static int dw_spi_intel_init(struct platform_device *pdev,
 }
 
 /*
- * The Intel Mount Evans SoC's Integrated Management Complex uses the
- * SPI controller for access to a NOR SPI FLASH. However, the SoC doesn't
- * provide a mechanism to override the native chip select signal.
- *
- * This driver doesn't use DMA for memory operations when a chip select
- * override is not provided due to the native chip select timing behavior.
- * As a result no DMA configuration is done for the controller and this
- * configuration is not tested.
+ * DMA-based mem ops are not configured for this device and are not tested.
  */
 static int dw_spi_mountevans_imc_init(struct platform_device *pdev,
 				      struct dw_spi_mmio *dwsmmio)
-- 
2.40.1

