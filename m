Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F867462DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGCSw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjGCSwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:52:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18C2E7D;
        Mon,  3 Jul 2023 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688410353; x=1719946353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mym6i/tgEoTAGg7H2qslE07ns2in3+2GRLlg1GCRN9A=;
  b=RlT90CFGm+HhAHm8GG5kZuGftH0fuX7HV5Vcv9faqtw2ufVBQhSKcJfZ
   x1QJdUCLGXhhX0TbCmGtuhnh5tJ0tZ+Px3Ea2CvT31mcDP25mXDjxZZFU
   UI4/nyIxgLMf19iUQfpZ1bZNRyo+AqwUVPeE0+YwpofxLf5S9EHB1HzWH
   IB+i9w5YCKpssXKqq9jkkJFlqtguZgsqMCrHcjl+8Il5cvGGd3NG9GNI6
   3ziJ4se32uzzZZJ04jQQmtfow1TTSOYo5LJxNmSeoC3c5lxEh38q1iTR8
   OKDa2DDrytnrBQw0uhzSG1EwZY45s+Wn30pa/Cx+lIWOzHIUUsmx/eUEf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="449322739"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="449322739"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:52:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="831912490"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="831912490"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2023 11:52:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BF7C2718; Mon,  3 Jul 2023 21:52:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 12/12] HID: cp2112: Use octal permissions
Date:   Mon,  3 Jul 2023 21:52:22 +0300
Message-Id: <20230703185222.50554-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Octal permissions are preferred as stated in
Documentation/dev-tools/checkpatch.rst. Replace symbolic permissions
with octal permissions when creating the files.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-cp2112.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 3c6a3be8fc02..adbe8a47cf67 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -175,7 +175,7 @@ struct cp2112_device {
 };
 
 static int gpio_push_pull = CP2112_GPIO_ALL_GPIO_MASK;
-module_param(gpio_push_pull, int, S_IRUGO | S_IWUSR);
+module_param(gpio_push_pull, int, 0644);
 MODULE_PARM_DESC(gpio_push_pull, "GPIO push-pull configuration bitmask");
 
 static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -1057,7 +1057,7 @@ static void chmod_sysfs_attrs(struct hid_device *hdev)
 	}
 
 	for (attr = cp2112_attr_group.attrs; *attr; ++attr) {
-		umode_t mode = (buf[1] & 1) ? S_IWUSR | S_IRUGO : S_IRUGO;
+		umode_t mode = (buf[1] & 1) ? 0644: 0444;
 		ret = sysfs_chmod_file(&hdev->dev.kobj, *attr, mode);
 		if (ret < 0)
 			hid_err(hdev, "error chmoding sysfs file %s\n",
-- 
2.40.0.1.gaa8946217a0b

