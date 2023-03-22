Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B79A6C4DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjCVOjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjCVOjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:39:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2063347A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679495964; x=1711031964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8uevUwjjKvLYeP2DQKzLWRjw88ZIleN4K7KAE0RgZQM=;
  b=jVCeYsQd6kp9pDOZytt6GIqxERschcuuck54DFg0BTaiwwLHddxC8ZKl
   0iwTX8JP4QWi7F3aciWtY3u1O7eU8sx9IdHxPdJL/CcJW2JyLK7wY9Msa
   cUAFu4xg+96ArNkm4AzOzzH8FzZLe94Xg7Ap7Hqhw4eLcsQAuQmcfVTnh
   5ARKlmnthn0nFNf/2fzIrSEXmq8Ik/0NW1EMVJgHvfrxcJBpDNrfTeUtS
   TOjhlIF4HEP6p0VcBGd459jesKzfoqIT2qEamFiJEHrbnuNC1SiFJU5mx
   AOkNLKlSRUQQFnwU/783KHHVUcwTj1BEmCqvlucl9fB4Jxu01DLzqCM9c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="319622119"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="319622119"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 07:39:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="856116425"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="856116425"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2023 07:39:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B976F5A7; Wed, 22 Mar 2023 16:40:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v1 05/14] extcon: Amend kernel documentation of struct extcon_dev
Date:   Wed, 22 Mar 2023 16:39:56 +0200
Message-Id: <20230322144005.40368-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
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

First of all, the @lock description is missing. Add it.
Second, correct the terminator value for the mutual exclusive
cabling.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
index 93b5e0306966..15616446140d 100644
--- a/drivers/extcon/extcon.h
+++ b/drivers/extcon/extcon.h
@@ -13,8 +13,8 @@
  *			are disabled.
  * @mutually_exclusive:	Array of mutually exclusive set of cables that cannot
  *			be attached simultaneously. The array should be
- *			ending with NULL or be NULL (no mutually exclusive
- *			cables). For example, if it is { 0x7, 0x30, 0}, then,
+ *			ending with 0 or be NULL (no mutually exclusive cables).
+ *			For example, if it is {0x7, 0x30, 0}, then,
  *			{0, 1}, {0, 1, 2}, {0, 2}, {1, 2}, or {4, 5} cannot
  *			be attached simulataneously. {0x7, 0} is equivalent to
  *			{0x3, 0x6, 0x5, 0}. If it is {0xFFFFFFFF, 0}, there
@@ -27,7 +27,7 @@
  * @nh:			Notifier for the state change events from this extcon
  * @entry:		To support list of extcon devices so that users can
  *			search for extcon devices based on the extcon name.
- * @lock:
+ * @lock:		Protects device state and serialises device registration
  * @max_supported:	Internal value to store the number of cables.
  * @extcon_dev_type:	Device_type struct to provide attribute_groups
  *			customized for each extcon device.
-- 
2.40.0.1.gaa8946217a0b

