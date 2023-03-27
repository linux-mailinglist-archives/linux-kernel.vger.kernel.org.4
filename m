Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE66CA5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjC0N2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjC0N2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:28:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCFC3593;
        Mon, 27 Mar 2023 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679923632; x=1711459632;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eq405EaOHdHE2FSFIsfAvwBxXc9cVFwBElpq0o2L8/0=;
  b=hBOgTTpucDrMB6s/NuiiojcZ5Qyqt0Oq9DJxjLlDGczHKCxsJkMk2qLO
   5UgAWAZ6bgo8Zt4YJ0I/MWMJf0x+w/vXP6JR2uLcoO4SI7ZlYxQWEjm8z
   p/Ysi3TJlYjaITzH+5VhJi6yqfnAQGxvIkWwz0vlTF0CJirhAFTnpVV6X
   DZjNioTqPxHky+D+3YcVIOTUGmRXrt7F60g+XlL2Oo1iPiM6ax9taiw5X
   qeZvfFnjTmeF0w4hhKm0sqJmukLH9d0+PdwnFBaaYloRqyCDjpwDJwD35
   HOGPZ8XxsiRTU/sXTVKeBzHNtKVGWqh4c/6Jzb2xXfje2ffTsX+lpdxAT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="324142963"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="324142963"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 06:25:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="748001509"
X-IronPort-AV: E=Sophos;i="5.98,294,1673942400"; 
   d="scan'208";a="748001509"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 27 Mar 2023 06:25:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2A01E79C; Mon, 27 Mar 2023 16:25:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/1] ACPI: SPCR: Amend indentation
Date:   Mon, 27 Mar 2023 16:25:12 +0300
Message-Id: <20230327132512.84540-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Remove unnecessary blank lines.
2) Reformat one comment for consistency.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: avoided changind double spaces (Rafael)
 drivers/acpi/spcr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index 01d29ebdb9c2..cd36a97b0ea2 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -71,7 +71,6 @@ static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
 
 /**
  * acpi_parse_spcr() - parse ACPI SPCR table and add preferred console
- *
  * @enable_earlycon: set up earlycon for the console specified by the table
  * @enable_console: setup the console specified by the table.
  *
@@ -82,7 +81,6 @@ static bool xgene_8250_erratum_present(struct acpi_table_spcr *tb)
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

