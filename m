Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C20C6C478E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCVK0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjCVK0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:26:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0349E5CEF3;
        Wed, 22 Mar 2023 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679480776; x=1711016776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UHHsYT39pGeNMX2oibt0RObI5UboYwFvGeKym4oKDoE=;
  b=PrjFcoZfYcB/8nqPVKEH5EE67b5T+xE0OYw31TekvHYByMM7Ho6b5R3K
   OywPyNzyhn2Hd35vCpIkJ8PTt6FvAreJTIwOQGa7+veuGWh78/xXVj0JA
   Syfoqlk1Oa5FTIhoopN+Itrql5ky7WWCgf7YZQTWVO4CuORpsLzdv8YtX
   OpD/tBb0RS0WnmB5ZKsiqMkUXd6/vV2TCtjP4faD+W22W/jjN9+q9Valj
   p+8whFRTLbYXi9TTkKuhZPxVUiqHygQBlC1XV1At73DstXXrkT29dEjUH
   rbqSY/g5InsmShPfNV4+UV7bO7MifxhAvQ19qW1+W4IYZWLxvMIddCa5D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="319570430"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="319570430"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 03:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="681843642"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="681843642"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2023 03:26:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 267F681; Wed, 22 Mar 2023 12:26:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 2/2] ACPI: SPCR: Amend indentation
Date:   Wed, 22 Mar 2023 12:22:58 +0200
Message-Id: <20230322102258.27390-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322102258.27390-1-andriy.shevchenko@linux.intel.com>
References: <20230322102258.27390-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Remove unnecessary blank lines.
2) Remove double spaces for consistency.
3) Reformat one comment for consistency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/spcr.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 01d29ebdb9c2..3d242c746d10 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -71,18 +71,16 @@ static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
 
 /**
  * acpi_parse_spcr() - parse ACPI SPCR table and add preferred console
- *
  * @enable_earlycon: set up earlycon for the console specified by the table
  * @enable_console: setup the console specified by the table.
  *
  * For the architectures with support for ACPI, CONFIG_ACPI_SPCR_TABLE may be
- * defined to parse ACPI SPCR table.  As a result of the parsing preferred
+ * defined to parse ACPI SPCR table. As a result of the parsing preferred
  * console is registered and if @enable_earlycon is true, earlycon is set up.
  * If @enable_console is true the system console is also configured.
  *
  * When CONFIG_ACPI_SPCR_TABLE is defined, this function should be called
  * from arch initialization code as soon as the DT/ACPI decision is made.
- *
  */
 int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 {
@@ -97,9 +95,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	if (acpi_disabled)
 		return -ENODEV;
 
-	status = acpi_get_table(ACPI_SIG_SPCR, 0,
-				(struct acpi_table_header **)&table);
-
+	status = acpi_get_table(ACPI_SIG_SPCR, 0, (struct acpi_table_header **)&table);
 	if (ACPI_FAILURE(status))
 		return -ENOENT;
 
@@ -184,10 +180,10 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	 *
 	 * If the user specifies "traditional" earlycon, the qdf2400_e44
 	 * console name matches the EARLYCON_DECLARE() statement, and
-	 * SPCR is not used.  Parameter "earlycon" is false.
+	 * SPCR is not used. Parameter "earlycon" is false.
 	 *
 	 * If the user specifies "SPCR" earlycon, then we need to update
-	 * the console name so that it also says "qdf2400_e44".  Parameter
+	 * the console name so that it also says "qdf2400_e44". Parameter
 	 * "earlycon" is true.
 	 *
 	 * For consistency, if we change the console name, then we do it
@@ -202,7 +198,8 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 	if (xgene_8250_erratum_present(table)) {
 		iotype = "mmio32";
 
-		/* for xgene v1 and v2 we don't know the clock rate of the
+		/*
+		 * For xgene v1 and v2 we don't know the clock rate of the
 		 * UART so don't attempt to change to the baud rate state
 		 * in the table because driver cannot calculate the dividers
 		 */
-- 
2.40.0.1.gaa8946217a0b

