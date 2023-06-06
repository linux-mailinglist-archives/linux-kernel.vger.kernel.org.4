Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAA97246F4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbjFFOzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236337AbjFFOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:54:50 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1451BD;
        Tue,  6 Jun 2023 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686063274; x=1717599274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QOA64W01SpZvtPyZI5vSxqWBOWT+zCVYEfRmUYyugCc=;
  b=DABOFdXlrMOSP2LijwI9uSDE8RM/L8YmXl9ovbgkXD4uYaItlR9zpRMU
   6as0uknmBUx9LJJv7J3kHSkt3yolwSyCgfPFe2aQVNtE9taA310etd9HI
   Zo+0Tj91aA9yvDrpePI/84ZItAT1vn4HTq5Dj/TnpKjrRP2Hje5CFlv6w
   mJnSLV1H8TfY+L3a35t2XwQtyQEOAeouSVUWKJvIYeD+omfw8DnNPch1x
   gEzP2hL9X0lfJUK8LnysccNij+UgRoZcWIDafF3tG0kn7LvnIKY0VilZN
   K1McFfRgU9KJQIRVJEnWLEfbgXOksp4+HH4ZH69Xk4hF9byrwoTCOSV/1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="337050691"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="337050691"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="853479853"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="853479853"
Received: from ekohande-desk2.vc.intel.com ([10.234.35.153])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 07:54:33 -0700
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
Subject: [PATCH 0/2] spi: dw: Add compatible for Intel Mount Evans SoC
Date:   Tue,  6 Jun 2023 07:54:00 -0700
Message-Id: <20230606145402.474866-1-abe.kohandel@intel.com>
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

The Intel Mount Evans SoC's Integrated Management Complex has a DW
apb_ssi_v4.02a controller. This series adds support for this controller.

No SoC level chip select override is provided and as such no DMA
configuration is done for the controller.

Thanks,
Abe

Abe Kohandel (2):
  spi: dw: Add compatible for Intel Mount Evans SoC
  dt-bindings: spi: snps,dw-apb-ssi: Add compatible for Intel Mount
    Evans SoC

 .../bindings/spi/snps,dw-apb-ssi.yaml         |  2 ++
 drivers/spi/spi-dw-mmio.c                     | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+)

-- 
2.40.1

