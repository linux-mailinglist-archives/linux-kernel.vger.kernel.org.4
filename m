Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE2B6FBA09
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjEHVkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjEHVkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:40:01 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8F1729C;
        Mon,  8 May 2023 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683581972; x=1715117972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OwXZLZleXFeAooPhA0PTrMxq3lQ05ppIoojJrb4Dj0Y=;
  b=Ws889pWf2LRGA2TyY3PiOBrCtrfQIagiY6T6AV8Qbw2WuMwHev7KplqM
   iqFusd2U6P0NP70gpv+ZN+YA7erRbxnIuJoENsNl4dFYWrUk7o+8oXhgM
   CbFh2iABZyULaegjZxf1XUjZdb6vjpnviruhp8wFe9oRPmfJ0pCGURh6q
   rkKEkYY9tocS8m86bxtYSGEw2CPVrv3dKNRvWOk2lPlPkUnUvPPZksy6U
   2VUzjXvUp5pA1Nou4Cmwut/aoe7KzaPZE08v3WFeWya8MWfZywTuYSeUb
   yJRkVzQcMudpV0fVkcx4GdTC/n+uEsYis47Dr51m4dIkrXAyubUBpmnHp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="349796674"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349796674"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="945018712"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="945018712"
Received: from linux-builds1.an.intel.com ([10.122.105.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:38:56 -0700
From:   dinh.nguyen@linux.intel.com
To:     linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Dinh Nguyen <dinh.nguyen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCHv2 1/6] units: add a macro for MILLIVOLT_PER_VOLT
Date:   Mon,  8 May 2023 16:28:47 -0500
Message-Id: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
X-Mailer: git-send-email 2.40.0
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

From: Dinh Nguyen <dinh.nguyen@linux.intel.com>

Add a define for MILLIVOLT_PER_VOLT.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
---
 include/linux/units.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/units.h b/include/linux/units.h
index 2793a41e73a2..5b797535e1b9 100644
--- a/include/linux/units.h
+++ b/include/linux/units.h
@@ -31,6 +31,8 @@
 #define MICROWATT_PER_MILLIWATT	1000UL
 #define MICROWATT_PER_WATT	1000000UL
 
+#define MILLIVOLT_PER_VOLT	1000UL
+
 #define ABSOLUTE_ZERO_MILLICELSIUS -273150
 
 static inline long milli_kelvin_to_millicelsius(long t)
-- 
2.40.0

