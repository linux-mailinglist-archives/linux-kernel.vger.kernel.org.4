Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2230697B49
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjBOMAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjBOMA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:00:27 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585CA360AE;
        Wed, 15 Feb 2023 04:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676462426; x=1707998426;
  h=from:to:cc:subject:date:message-id;
  bh=MHH7lVQE7fGj4fqtmDSadUcN4W18+Z5aCG0IRm/pI5E=;
  b=KYReqv704LDixTnY035CF/IwNUTxzjIuHYXUHL/UVFR1ElUWdLvPGtiA
   69FWa/Z7ZFS3e8rV0wMMYLsHo6W9AtdylmP11CJnySnhYHt1u8TAyqRYI
   dmKlBO/dgeJdOQdh5TM9u9ZeWK+nR8T6ujG9kVPdUmxjYdbkoa5omKqdW
   UF0z2YXxpmaz2pWf/c2bHzuScyntph6+Y9C8AiHiURi9xK76iiozacATc
   xyB0V0DZhLWYiAQSB39Zqu2ODVFRF8YL/SdnOa1/SkabOJlW02DlQH2N+
   MbQ7lpy1LH1KuM46Av1DLaCPeVZ8I3eT/TfAO6aMhVNGCszDuw5aJ3S+g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="330040624"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="330040624"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 04:00:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="662899553"
X-IronPort-AV: E=Sophos;i="5.97,299,1669104000"; 
   d="scan'208";a="662899553"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by orsmga007.jf.intel.com with ESMTP; 15 Feb 2023 04:00:23 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 2DFA219723;
        Wed, 15 Feb 2023 17:30:22 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 2865F158; Wed, 15 Feb 2023 17:30:22 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH] gpiolib: acpi: remove redundant declaration
Date:   Wed, 15 Feb 2023 17:30:04 +0530
Message-Id: <20230215120004.9693-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove acpi_device declaration, as it is no longer needed.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpio/gpiolib-acpi.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
index 9475f99a9694..5a08693b8fb1 100644
--- a/drivers/gpio/gpiolib-acpi.h
+++ b/drivers/gpio/gpiolib-acpi.h
@@ -14,7 +14,6 @@
 
 #include <linux/gpio/consumer.h>
 
-struct acpi_device;
 struct device;
 struct fwnode_handle;
 
-- 
2.17.1

