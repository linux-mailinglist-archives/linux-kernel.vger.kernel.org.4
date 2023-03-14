Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A8F6B87BD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 02:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCNBlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 21:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjCNBlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 21:41:31 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0200A7C97D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678758088; x=1710294088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=az/KB86lRG095DZZ6RuZwSVMJqq3LS8MNxe03npvozo=;
  b=PZuC4jsk/73D62JxIedVWv5WCuASRZDkdRDxOcvSxzp9NeLYMzp+uMhy
   vRoaoyrCxKORhzDMkmU8ILpNbfLmmrfhWe1dJEg1bLBOI3S62sjz5j5i+
   KX93DoqkMGU90palzH3cnYhxRsX0hkX15+WrBCt6UStDJ9Qmen+ndUijy
   tp69rRLW49IHIf6vVxLkFeKuUtfNXYzx0ENwgoNck91x3/lhnjH1rIqLP
   dBqKHePyB6Z1UXC3k7DOhnC/kj/+yX9/H+ZsU7JWAF953WvXGMtzJ1jps
   gbnwOQmARY8iEphBa7prZ5qlD5pq5p7oj6PTiotZb7RMMi5i9ZLb8cVJo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="316949285"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="316949285"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="711327495"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="711327495"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 18:41:26 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 11/16] soundwire: cadence: remove CDNS_MCP_CONFIG_SSPMOD
Date:   Tue, 14 Mar 2023 09:54:05 +0800
Message-Id: <20230314015410.487311-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
References: <20230314015410.487311-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This field is not used, and its definition is not aligned with the
hardware specification.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index e835dabb516c..4f34fc72dbd5 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -33,7 +33,6 @@ MODULE_PARM_DESC(cdns_mcp_int_mask, "Cadence MCP IntMask");
 #define CDNS_MCP_CONFIG_MMASTER			BIT(7)
 #define CDNS_MCP_CONFIG_BUS_REL			BIT(6)
 #define CDNS_MCP_CONFIG_SNIFFER			BIT(5)
-#define CDNS_MCP_CONFIG_SSPMOD			BIT(4)
 #define CDNS_MCP_CONFIG_CMD			BIT(3)
 #define CDNS_MCP_CONFIG_OP			GENMASK(2, 0)
 #define CDNS_MCP_CONFIG_OP_NORMAL		0
-- 
2.25.1

