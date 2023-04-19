Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652626E713C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 04:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjDSCoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 22:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDSCog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 22:44:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E76D659E;
        Tue, 18 Apr 2023 19:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681872275; x=1713408275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QY7c2Zv6zQ2m+oD/+P9BhbgqEJw+zh4mpyaE0d49/qM=;
  b=G18V/KdW+HqqUQUzHq3kO60WCf5dojNnPvGb+A0PTbVE7v1+ELa/5w5i
   zF6Wtk/LIaHW9zt0umjeElcPKnPyNvE+OWq6MlEQxoyV0FlTGz6a+LeHT
   SQ7iifhTXmRNHgRl7SV14orBp6UQURhaWHY7p1wJLxxko5Lim0MPg4uVP
   ejamlIQqXxUBUiQKXFzWbA0GEXW8ICZV2akkYa8tyBiZGnrmkPUw/1n7d
   28GSo73QDZRZia38+FlmdcH+TjgZSiQo1+8rmFVRqJCAmF9naRzCXCF3Y
   +/RnabIiv1X8+f/V8SRiYSZmVvwfSztOIXksDW4lI8GMs0D/s/MrJH18I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="373215268"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="373215268"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="937478005"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="937478005"
Received: from hanboyu-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.29.76])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:44:33 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: [PATCH v2 01/15] powercap/intel_rapl: Remove unused field in struct rapl_if_priv
Date:   Wed, 19 Apr 2023 10:44:05 +0800
Message-Id: <20230419024419.324436-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230419024419.324436-1-rui.zhang@intel.com>
References: <20230419024419.324436-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

