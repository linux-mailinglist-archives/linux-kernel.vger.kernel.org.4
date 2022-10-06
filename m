Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6745F6631
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiJFMiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJFMhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:37:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B7B85A8E;
        Thu,  6 Oct 2022 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665059873; x=1696595873;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cZ1DyGBREhYanUww/M4Cfa6VqXvo80wIheIgHvT9G1c=;
  b=SESjD++5LPwuY+OSa7y+8HM17FjfmIHhAYJYaXs76w7mRTbdFTTGiOzZ
   UdI11N0GhOMGa3k07rNgYWXz1gMhhxOlKQeLrXsHyX8A4PngcI9QVyUPq
   qoJfxuTickbf6tP7bJUguM6VqYStBUMeNKISnCYZMtbCUs+EJ/G29+qx2
   FH2KXAz8QuGkdQ1oiT5iBSz147HH1Hf7tL3xo/84GsLa4sZKf8y9cfVhy
   6P8lmLFRghNJcWpkDnktmqc/khjqZsSEtTNBSdp+EAYmZL6vrF6kXYVuh
   tS/D7kcPIWdcE3OIu0wQwj9feifd3zyeVF3D3YiacFkVLvfBlNF6EVpgk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="301031456"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="301031456"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 05:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="627001100"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="627001100"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Oct 2022 05:37:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 17D4917E; Thu,  6 Oct 2022 15:38:10 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 1/1] device property: Fix documentation for *_match_string() APIs
Date:   Thu,  6 Oct 2022 15:38:07 +0300
Message-Id: <20221006123807.37014-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The returned value on success is an index of the matching string,
starting from 0. Reflect this in the documentation.

Fixes: 3f5c8d318785 ("device property: Add fwnode_property_match_string()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 617007a25783..bfed224c5724 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -236,7 +236,7 @@ EXPORT_SYMBOL_GPL(device_property_read_string);
  * Find a given string in a string array and if it is found return the
  * index back.
  *
- * Return: %0 if the property was found (success),
+ * Return: index, starting from %0, if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
  *	   %-ENODATA if the property does not have a value,
  *	   %-EPROTO if the property is not an array of strings,
@@ -457,7 +457,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_read_string);
  * Find a given string in a string array and if it is found return the
  * index back.
  *
- * Return: %0 if the property was found (success),
+ * Return: index, starting from %0, if the property was found (success),
  *	   %-EINVAL if given arguments are not valid,
  *	   %-ENODATA if the property does not have a value,
  *	   %-EPROTO if the property is not an array of strings,
-- 
2.35.1

