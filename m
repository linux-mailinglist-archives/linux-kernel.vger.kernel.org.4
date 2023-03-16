Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5AE6BD418
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjCPPlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjCPPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:40:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9708B84805;
        Thu, 16 Mar 2023 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678981207; x=1710517207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QY7c2Zv6zQ2m+oD/+P9BhbgqEJw+zh4mpyaE0d49/qM=;
  b=V6GldC5jcFsSHWhFAs7wYzWmYzdKdGWDoe47GwJx+FD5kem4G/p0qcem
   5Ax3WG9OR/xS+JIEJ0nLBJ2mO+cZp7Zp28lVZ5StZs90xCNAEmpvf5+bD
   FWqyUrTWZebfIZKQ3WSBy4nrL4io8yf4XMH1bwIoodZKNpDv+CZe2nzU1
   sPGcnAl6F/rURJaaXCOz6tPjQz5vP3e48mmlb2VsR8uOhMvFUuRVUa80b
   MjvxpYOtbu2r4MiFvEOZV6lydfWYyQ4L0zP6XjYes6nbDYo11MWFas1bM
   /AqFS0/3Vfncr7+0QHqWjMtPlDxY6q2c/7I5SVDRzktDar7vnu/VvYZgv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="339570941"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="339570941"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="1009266965"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="1009266965"
Received: from feiwang3-mobl2.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.170.93])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 08:38:50 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH 01/15] powercap/intel_rapl: Remove unused field in struct rapl_if_priv
Date:   Thu, 16 Mar 2023 23:38:27 +0800
Message-Id: <20230316153841.3666-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316153841.3666-1-rui.zhang@intel.com>
References: <20230316153841.3666-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f1e8d7560d30 ("powercap/intel_rapl: enumerate Psys RAPL
domain together with package RAPL domain"), the platform_rapl_domain field
is not used anymore. Remove it from rapl_if_priv structure.

Fixes: f1e8d7560d30 ("powercap/intel_rapl: enumerate Psys RAPL domain together with package RAPL domain")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/linux/intel_rapl.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 9f4b6f5b822f..828557645770 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -124,7 +124,6 @@ struct reg_action {
  */
 struct rapl_if_priv {
 	struct powercap_control_type *control_type;
-	struct rapl_domain *platform_rapl_domain;
 	enum cpuhp_state pcap_rapl_online;
 	u64 reg_unit;
 	u64 regs[RAPL_DOMAIN_MAX][RAPL_DOMAIN_REG_MAX];
-- 
2.25.1

