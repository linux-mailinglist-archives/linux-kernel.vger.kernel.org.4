Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1728165B5F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbjABReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbjABRe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:34:26 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB7CA0;
        Mon,  2 Jan 2023 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672680865; x=1704216865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yTeQ4iXOCmX4eH04kZmPkFyCtQ2mz03AnPemoHb9ccg=;
  b=D8cbZKdFFT9iUGqF62e72mRInrDi3KfBJQnLreqIdifFzddVEOo61quz
   zSdw6CUj33ceOp3Gt+ja/6qBVjzROh8ABHJ6AlOmBZFFz3LGg+/LVLmhl
   9WfR8oNg9lir+CS+gWRW3Hbc1/VktzyzcMnSGameU2rz/JNeoDPBcGB1y
   A9FzDzkDx6jGAAB2bxcoKZTgn1Zx/cHOJ+7MWO1z1H2wy4JPVDXv2Y6EZ
   mcYiXRjr19pt26CWDJwMarwNZXSiGVDgINh9HvcSfwvHVWaY6JQ7aVDOg
   EYRX0ZXbmaaj4H5sjLav6rg5OeBiJTap+OfU/Hpy7vI29BuD6qsbOQ2y9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="322752807"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="322752807"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 09:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="686951025"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="686951025"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Jan 2023 09:34:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CE22E1CA; Mon,  2 Jan 2023 19:34:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/3] iio: adc: ti-adc128s052: Sort headers
Date:   Mon,  2 Jan 2023 19:34:50 +0200
Message-Id: <20230102173450.29882-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102173450.29882-1-andriy.shevchenko@linux.intel.com>
References: <20230102173450.29882-1-andriy.shevchenko@linux.intel.com>
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

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-adc128s052.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 0f737e9df0fa..a456ea78462f 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -10,12 +10,12 @@
  */
 
 #include <linux/err.h>
-#include <linux/spi/spi.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
 #include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
 
 struct adc128_configuration {
 	const struct iio_chan_spec	*channels;
-- 
2.35.1

