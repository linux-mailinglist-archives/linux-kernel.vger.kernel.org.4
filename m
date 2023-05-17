Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7370743E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjEQV2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjEQV2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:28:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F05A1BFA;
        Wed, 17 May 2023 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684358920; x=1715894920;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=aLHFmTt4LCs0DVMtM1wqR56iyFuUZrZvjeZ079GZuMM=;
  b=LSlE81kzekanwsk1OVvrzqDUO7B+JtfACOPASAblRpN+s8qyITQPKms0
   eFzOnk+hErrfOVlEP6jr5jNWaCvcmn5z5Bnl7J8bf9nbiH03eq8ok8sZd
   inN/0u6odJZJcjkdKMrSfutvVsFuSwLR/qYqgFz+WcM9T+7WXSab08kAp
   tt7/Id6emHvRglU8VlD/Xo6Rri+xe6Bh1Wl29jpqxyBRH1KC9orOWKnHk
   AoP/v+ZFa7RZPYBsGVZ4uslmJ5Xc5Sv29DBbGjsbs9j91WSsiJ/Z7WKuH
   Vd/zYgCupB7+x3GqZ82sQ0fOFvb2cILRMBEC49n9CFkloP6nHVn6+OsC/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="336440450"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="336440450"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:28:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="734840829"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="734840829"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.143.168])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:28:38 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 17 May 2023 14:28:12 -0700
Subject: [PATCH 3/3] tools/testing/cxl: Document test configurations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-cxl-fixes-v1-3-870c4c8b463a@intel.com>
References: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
In-Reply-To: <20230426-cxl-fixes-v1-0-870c4c8b463a@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-9a8cd
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358895; l=5143;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=aLHFmTt4LCs0DVMtM1wqR56iyFuUZrZvjeZ079GZuMM=;
 b=lnYIC06SBPSEBRcGxl1jf+6AJvtpaqyMYXA5ROvRRHd1j57/oiqntMHaJk23ll5YvccYrwCCC
 3wU8IZOpxoUDdBherDCi//mj5k39mugX0nL9tbW/bXd9uk4zzxqMYln
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devices created, their relationship, and intended testing purpose is
not extremely clear, especially for those unfamiliar with cxl-test.

Document the purpose of each hierarchy.  Add ASCII art to show the
relationship of devices.  Group the device declarations together based
on the hierarchies.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tools/testing/cxl/test/cxl.c | 75 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index bf00dc52fe96..bd38a5fb60ae 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -23,6 +23,31 @@ static int interleave_arithmetic;
 #define NR_CXL_PORT_DECODERS 8
 #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
 
+/*
+ * Interleave testing
+ *
+ *             +---------------+                            +---------------+
+ *             | host_bridge[0]|                            | host_bridge[1]|
+ *             +-/---------\---+                            +--/---------\--+
+ *             /-           -\                               /-           -\
+ *           /-               -\                           /-               -\
+ *   +-------------+         +-------------+       +-------------+      +-------------+
+ *   |root_port[0] |         |root_port[1] |       |root_port[2] |      |root_port[3] |
+ *   +------|------+         +------|------+       +------|------+      +------|------+
+ *          |                       |                     |                    |
+ *  +-------|-------+       +-------|-------+     +-------|-------+    +-------|-------+
+ *  |switch_uport[0]|       |switch_uport[1]|     |switch_uport[2]|    |switch_uport[3]|
+ *  +---|-------|---+       +---/-------|---+     +---/-------|---+    +---|-------\---+
+ *      |       \              /        \            /        \            /        \
+ * +----|----++--|------++---------++----|----++---------++----|----++----|----++---------+
+ * |switch   ||switch   ||switch   ||switch   ||switch   ||switch   ||switch   ||switch   |
+ * |_dport[0]||_dport[1]||_dport[2]||_dport[3]||_dport[4]||_dport[5]||_dport[6]||_dport[7]|
+ * +----|----++--|------++----|----++----|----++----|----++----|----++----|----++----|----+
+ *      |        |            |          |          |          |          |          |
+ *  +---|--+   +-|----+   +---|--+   +---|--+    +--|---+  +---|--+   +---|--+   +---|--+
+ *  |mem[0]|   |mem[1]|   |mem[2]|   |mem[3]|    |mem[4]|  |mem[5]|   |mem[6]|   |mem[7]|
+ *  +------+   +------+   +------+   +------+    +------+  +------+   +------+   +------+
+ */
 static struct platform_device *cxl_acpi;
 static struct platform_device *cxl_host_bridge[NR_CXL_HOST_BRIDGES];
 #define NR_MULTI_ROOT (NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS)
@@ -31,16 +56,51 @@ static struct platform_device *cxl_switch_uport[NR_MULTI_ROOT];
 #define NR_MEM_MULTI \
 	(NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS * NR_CXL_SWITCH_PORTS)
 static struct platform_device *cxl_switch_dport[NR_MEM_MULTI];
+struct platform_device *cxl_mem[NR_MEM_MULTI];
 
+/*
+ * 1) Preconfigured region support (Simulated BIOS configured region)
+ * 2) 'Pass-through' decoder
+ *
+ *       +---------------+
+ *       |  hb_single    |
+ *       +------|--------+
+ *              |
+ *       +------|--------+
+ *       | root_single   |
+ *       +------|--------+
+ *              |
+ *   +----------|----------+
+ *   |     swu_single      |
+ *   +-----|-----------|---+
+ *         |           |
+ *   +-----|-----+  +--|--------+
+ *   |swd_single |  | swd_single|
+ *   +-----|-----+  +----|------+
+ *         |             |
+ *  +------|-----+  +----|-------+
+ *  |mem_single  |  |mem_single  |
+ *  +------------+  +------------+
+ */
 static struct platform_device *cxl_hb_single[NR_CXL_SINGLE_HOST];
 static struct platform_device *cxl_root_single[NR_CXL_SINGLE_HOST];
 static struct platform_device *cxl_swu_single[NR_CXL_SINGLE_HOST];
 #define NR_MEM_SINGLE (NR_CXL_SINGLE_HOST * NR_CXL_SWITCH_PORTS)
 static struct platform_device *cxl_swd_single[NR_MEM_SINGLE];
-
-struct platform_device *cxl_mem[NR_MEM_MULTI];
 struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
 
+/*
+ * 1) RCD
+ * 2) Type-2 (Accelerator)
+ *
+ *  +-----+
+ *  | rch |
+ *  +--|--+
+ *     |
+ *   +-|--+
+ *   |rcd |
+ *   +----+
+ */
 static struct platform_device *cxl_rch[NR_CXL_RCH];
 static struct platform_device *cxl_rcd[NR_CXL_RCH];
 
@@ -64,6 +124,17 @@ static inline bool is_single_bridge(struct device *dev)
 	return false;
 }
 
+/*
+ *  +---------------+ +---------------+
+ *  | host_bridge[0]| | host_bridge[1]|
+ *  +---------------+ +---------------+
+ *  +---------------+
+ *  |  hb_single    | (host_bridge[2])
+ *  +---------------+
+ *  +-----+
+ *  | rch | (host_bridge[3])
+ *  +-----+
+ */
 static struct acpi_device acpi0017_mock;
 static struct acpi_device host_bridge[NR_BRIDGES] = {
 	[0] = {

-- 
2.40.0

