Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184D97246F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbjFFOz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbjFFOyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:54:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1CEE42;
        Tue,  6 Jun 2023 07:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686063286; x=1717599286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tq23lNIKA2SguU6N65nqWksRBv5EvXmrFt7DAmX+o8=;
  b=PSgC23dHuJTwuuIghhY9AZJ2gy8FAvM7QJqQI5bXB5zEjX1RfwWUrzS+
   Q+MOkI/nvtahJfKo6n96mEw3tNfL1YGpjB3tFRnPc/6u5Ze0BNRvUPzVJ
   vntJN9Dqg9tEOMK+mzjW+fQzNCzn1nNtgAmgAOh3IQN3bdhd7Q2qN9E66
   2bbpy/LCa2FlZ4TG7Tj4QsIhNQlpu2fFz9+37sSIPURb1P41MdLiCoMkW
   1lqNWjCvJ+drGrA1VZrQKXC2IYwkXE6GI+sobAlKnLuwfkRibBsPnrbJ6
   VtzJgEeEtpgHkuCW+Hqr8Rk2S4o/3suQw0VdKHcBX9y2uGeTWCoII205w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="337050769"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="337050769"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="853480012"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="853480012"
Received: from ekohande-desk2.vc.intel.com ([10.234.35.153])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:54:46 -0700
From:   Abe Kohandel <abe.kohandel@intel.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Abe Kohandel <abe.kohandel@intel.com>
Subject: [PATCH 2/2] dt-bindings: spi: snps,dw-apb-ssi: Add compatible for Intel Mount Evans SoC
Date:   Tue,  6 Jun 2023 07:54:02 -0700
Message-Id: <20230606145402.474866-3-abe.kohandel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606145402.474866-1-abe.kohandel@intel.com>
References: <20230606145402.474866-1-abe.kohandel@intel.com>
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

Document the DesignWare SSI controller compatible for Intel Mount Evans
Integrated Management Complex SoC.

Signed-off-by: Abe Kohandel <abe.kohandel@intel.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 12ca108864c6..a47cb144b09f 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -74,6 +74,8 @@ properties:
         const: intel,keembay-ssi
       - description: Intel Thunder Bay SPI Controller
         const: intel,thunderbay-ssi
+      - description: Intel Mount Evans Integrated Management Complex SPI Controller
+        const: intel,mountevans-imc-ssi
       - description: AMD Pensando Elba SoC SPI Controller
         const: amd,pensando-elba-spi
       - description: Baikal-T1 SPI Controller
-- 
2.40.1

