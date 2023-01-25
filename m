Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BB867A925
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 04:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjAYDWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 22:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjAYDWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 22:22:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6523C4F370;
        Tue, 24 Jan 2023 19:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pQRTA/4JyK2mnLs0yKoG7AJ7DTQ9kHP714WeYL4l++w=; b=0xgLduo/NhUthSPWsdImu0k/Mw
        1pJG8TnkbOzqpMcddgyzv8PtZv9ere8pKCxhyV4dN2DO/zw+/qCj8Yp5/dLnW+oPGZIeNx5cJRtE/
        lFN+OXDP9hEajbZCytEklILkroSqqxn8F50dDEA03wut5I//2l9uMs0w9Ou79dW1H1/LBqFYJP8xN
        zubwAsNs9d7NC8jTGjyng7s8riucTi/AdUw6nhWDEgw5zaPhfS+MDfdKQzh7SuMNag3xpcQXeoKYs
        LUBkgY33PLhCSbsT5ZCVM7NDAVTMnOh0nQHYC5K2a/OJgqoiEd2nECc8XcMqvuF8YDeqtJjCBxfmU
        2/+1tHIA==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKWMf-005vHe-Tw; Wed, 25 Jan 2023 03:22:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl: fix spelling mistakes
Date:   Tue, 24 Jan 2023 19:22:21 -0800
Message-Id: <20230125032221.21277-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling mistakes (reported by codespell).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ben Widawsky <bwidawsk@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
---
v2: add corrections for other source-code spelling errors (Alison)

 drivers/cxl/Kconfig       |    2 +-
 drivers/cxl/acpi.c        |    2 +-
 drivers/cxl/core/port.c   |    2 +-
 drivers/cxl/core/region.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff -- a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -116,7 +116,7 @@ config CXL_REGION_INVALIDATION_TEST
 	depends on CXL_REGION
 	help
 	  CXL Region management and security operations potentially invalidate
-	  the content of CPU caches without notifiying those caches to
+	  the content of CPU caches without notifying those caches to
 	  invalidate the affected cachelines. The CXL Region driver attempts
 	  to invalidate caches when those events occur.  If that invalidation
 	  fails the region will fail to enable.  Reasons for cache
diff -- a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -19,7 +19,7 @@ struct cxl_cxims_data {
 
 /*
  * Find a targets entry (n) in the host bridge interleave list.
- * CXL Specfication 3.0 Table 9-22
+ * CXL Specification 3.0 Table 9-22
  */
 static int cxl_xor_calc_n(u64 hpa, struct cxl_cxims_data *cximsd, int iw,
 			  int ig)
diff -- a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1137,7 +1137,7 @@ static struct cxl_port *find_cxl_port_at
 }
 
 /*
- * All users of grandparent() are using it to walk PCIe-like swich port
+ * All users of grandparent() are using it to walk PCIe-like switch port
  * hierarchy. A PCIe switch is comprised of a bridge device representing the
  * upstream switch port and N bridges representing downstream switch ports. When
  * bridges stack the grand-parent of a downstream switch port is another
diff -- a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -399,7 +399,7 @@ static ssize_t interleave_granularity_st
 	 * When the host-bridge is interleaved, disallow region granularity !=
 	 * root granularity. Regions with a granularity less than the root
 	 * interleave result in needing multiple endpoints to support a single
-	 * slot in the interleave (possible to suport in the future). Regions
+	 * slot in the interleave (possible to support in the future). Regions
 	 * with a granularity greater than the root interleave result in invalid
 	 * DPA translations (invalid to support).
 	 */
