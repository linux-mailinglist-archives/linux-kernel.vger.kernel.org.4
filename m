Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871206FBA14
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjEHVkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjEHVk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:40:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4653138;
        Mon,  8 May 2023 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683582006; x=1715118006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FGV+fdCgw3aBzLM/prNQt4Br3a3O7eyOg7GihjhTucw=;
  b=GkxsYOMo4McDLCDLjLFy4KwC8C99zeHVfBPnVmVN6y5nHsuSD9Txwn28
   qqAmodQIrnASjT1lccWBSid/q+8vG1IdGIBWuaGhvuAaWAcMrVTyJWqCX
   qGeuzusoeFDzXS6DQumxT73hyB93gf6IvJgXCv2yAgIcjCBo/KzDUQPn+
   UenolnCtMw8gokp4fBAvOo2Ob9bmvJXF/jgOLA8nhZOx0vnmckwRQL0Bw
   qpBPHs+AJCCSqtYg8F2PJv4vIOlQ07Tou05TZ3Ba3ULLXU7eIuK3DryVV
   DzJgdjBz8563aFxZLZEUQJT5GtwKZ81FYAQZ5WvJHFqYaKr8ozY52jZ6k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="349796692"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="349796692"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:38:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="945018721"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="945018721"
Received: from linux-builds1.an.intel.com ([10.122.105.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 14:38:59 -0700
From:   dinh.nguyen@linux.intel.com
To:     linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, Dinh Nguyen <dinh.nguyen@linux.intel.com>
Subject: [PATCHv2 4/6] MAINTAINERS: add Dinh Nguyen for socfpga-hwmon driver
Date:   Mon,  8 May 2023 16:28:50 -0500
Message-Id: <20230508212852.8413-4-dinh.nguyen@linux.intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
References: <20230508212852.8413-1-dinh.nguyen@linux.intel.com>
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

Add Dinh Nguyen as the maintainer for the SoCFPGA hardware monitor
driver.

Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..064f9db7ffe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2781,6 +2781,12 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/edac/altera_edac.[ch]
 
+ARM/SOCFPGA HARDWARE MONITOR
+M:	Dinh Nguyen <dinh.nguyen@linux.intel.com>
+S:	Maintained
+F:	drivers/hwmon/socfpga-hwmon.c
+F:	Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
+
 ARM/SPREADTRUM SoC SUPPORT
 M:	Orson Zhai <orsonzhai@gmail.com>
 M:	Baolin Wang <baolin.wang7@gmail.com>
-- 
2.40.0

