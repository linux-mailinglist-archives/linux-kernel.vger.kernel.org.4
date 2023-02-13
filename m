Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317AE69520B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjBMUjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMUja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:39:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622671284B;
        Mon, 13 Feb 2023 12:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676320769; x=1707856769;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=89B8F9htL6Qei6aB89FjZiKtmN09XvKCxECHkIfzD7U=;
  b=IVaapr+CmWP5I+LrvCa71OigVxsAwRzBW9xsu3+x3IUhIW/U/zGCpcat
   PSYSPDvB7n5m4xMlurj9Ut8vEbv9THrQgONulA/zUiJ5fGcKR4sO2UrIU
   7YC9sGBBprrVFnmgK/3kXgMhvvILqBhXa7OVLc2FzxbjiwtcmRISUVzuR
   ZYvUeRmj7Ykv8eU14QlL+/XRz2H9q5QGfLaM2ZejnXtrYSdQnElwcaQOD
   gRP6lAZ+jMngfbaL301cwbfS373usDHSEMytc4aERmXyr1yk7MlJ1XRYf
   m9ysHqYhJVvD5ztZmJwt/vlyrsxa/6VPrraIu0qkSDlaWcBdbhF0c1rRV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="358401414"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="358401414"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 12:39:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="914470130"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="914470130"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Feb 2023 12:39:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D92F51A6; Mon, 13 Feb 2023 22:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/1] Documentation: firmware-guide: gpio-properties: Clarify Explicit and Implicit
Date:   Mon, 13 Feb 2023 22:40:05 +0200
Message-Id: <20230213204005.55483-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify the Explicit and Implicit meanings in the table of Pull Bias.

While at it, distinguish pull bias keywords used in ACPI by using bold
font in the table of the respective terms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed formatting issues
 .../firmware-guide/acpi/gpio-properties.rst   | 35 +++++++++++++------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
index eaec732cc77c..db0c0b1f3700 100644
--- a/Documentation/firmware-guide/acpi/gpio-properties.rst
+++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
@@ -67,17 +67,30 @@ state of the output pin which driver should use during its initialization.
 Linux tries to use common sense here and derives the state from the bias
 and polarity settings. The table below shows the expectations:
 
-=========  =============  ==============
-Pull Bias     Polarity     Requested...
-=========  =============  ==============
-Implicit     x            AS IS (assumed firmware configured for us)
-Explicit     x (no _DSD)  as Pull Bias (Up == High, Down == Low),
-                          assuming non-active (Polarity = !Pull Bias)
-Down         Low          as low, assuming active
-Down         High         as low, assuming non-active
-Up           Low          as high, assuming non-active
-Up           High         as high, assuming active
-=========  =============  ==============
++-------------+-------------+-----------------------------------------------+
+| Pull Bias   | Polarity    | Requested...                                  |
++=============+=============+===============================================+
+| Implicit                                                                  |
++-------------+-------------+-----------------------------------------------+
+| **Default** | x           | AS IS (assumed firmware configured it for us) |
++-------------+-------------+-----------------------------------------------+
+| Explicit                                                                  |
++-------------+-------------+-----------------------------------------------+
+| **None**    | x           | AS IS (assumed firmware configured it for us) |
+|             |             | with no Pull Bias                             |
++-------------+-------------+-----------------------------------------------+
+| **Up**      | x (no _DSD) |                                               |
+|             +-------------+ as high, assuming non-active                  |
+|             | Low         |                                               |
+|             +-------------+-----------------------------------------------+
+|             | High        | as high, assuming active                      |
++-------------+-------------+-----------------------------------------------+
+| **Down**    | x (no _DSD) |                                               |
+|             +-------------+ as low, assuming non-active                   |
+|             | High        |                                               |
+|             +-------------+-----------------------------------------------+
+|             | Low         | as low, assuming active                       |
++-------------+-------------+-----------------------------------------------+
 
 That said, for our above example the both GPIOs, since the bias setting
 is explicit and _DSD is present, will be treated as active with a high
-- 
2.39.1

