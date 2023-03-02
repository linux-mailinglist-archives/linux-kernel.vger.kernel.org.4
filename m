Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94AA6A8627
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCBQTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCBQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:19:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EB6303C2;
        Thu,  2 Mar 2023 08:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677773974; x=1709309974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fPddKD7VeXAPJ/NExZr4CCUt4W5FHKKbrDl+aF9crV4=;
  b=RUCj8E+YaDh5DO1kqoBIxaLTdb/BvQmFjd3TUmOZGJVD9gEZAgOEa5Hs
   1DWRLJQmBQAVyeV4mLkviDAdIi6UB8c3jlmexLRZ+POy3bsCDJmKHYexE
   HrGavEArgDcUboXBJJFoEwRhqLSiCF6lST9M8DuHbKvMcsliwvIFQvrfS
   qudlMOvt0SRqGeS6KROHn9WYiQcYGhoDHUZvfC0b95HMYGr3Lb9jhEGfE
   whB2+Ec2LhsXF/GXj6SkiCxsY5DxopYgnK+Wm9UKpdbkiTs8KYfRebeFV
   mNA4jorwN1lizx0w5nR23h7pZxSOFPH9KBjU9QGIA08iUul51AJ1Pq5iI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="421028540"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="421028540"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 08:11:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="764051532"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="764051532"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2023 08:11:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 390C7143; Thu,  2 Mar 2023 18:12:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/1] =?UTF-8?q?ACPI:=20docs:=20enumeration:=20Correct?= =?UTF-8?q?=20reference=20to=20the=20I=C2=B2C=20device=20data=20type?=
Date:   Thu,  2 Mar 2023 18:12:12 +0200
Message-Id: <20230302161212.38142-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I²C peripheral devices that are connected to the controller are
represented in the Linux kernel as objects of the struct i2c_client.
Fix this in the documentation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index b9dc0c603f36..56d9913a3370 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -19,7 +19,7 @@ possible we decided to do following:
     platform devices.
 
   - Devices behind real busses where there is a connector resource
-    are represented as struct spi_device or struct i2c_device. Note
+    are represented as struct spi_device or struct i2c_client. Note
     that standard UARTs are not busses so there is no struct uart_device,
     although some of them may be represented by struct serdev_device.
 
-- 
2.39.1

