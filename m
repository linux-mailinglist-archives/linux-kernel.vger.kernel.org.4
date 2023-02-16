Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1CA699CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBPTYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBPTYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:24:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF547411;
        Thu, 16 Feb 2023 11:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676575470; x=1708111470;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VRWxI1BSbX3fqvB3PJMiXA+2paU29r4uX6QUspia6Xg=;
  b=LCnzR97/xNOXiMvuo8WuuH29QLuDivqxbgybvxbzxUG7mZBxHdKvKGaP
   4qPbkZ7tqjna84k+d4CIHK35Il/+0t9RylypSEEuL6WfGYMYO7gkF3fcR
   pZbjlyHr9oC1k01kKzLCTciyEktti6ROGixxnx2iHdjNr8nQ9MYzL/poF
   QGmeflXl6nMfQ/uwgycgi5AWsCnJyqk+XQRP79y0wn8CwiNhHkShj/irN
   sdcoTL9nc2wpWw4mndLOktHPy0WFzYfE+8LEj49hhto8bJ/RLnVJr0ljx
   0CX6g2XsoFaqXfmh7G19Cp1IT5QLGIAH2YP5cuBU24MElrqOi38mb6Vlm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="359256702"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="359256702"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 11:24:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999171730"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="999171730"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.246.71])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 11:24:29 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/mem: Add kdoc param for event log driver state
Date:   Thu, 16 Feb 2023 11:24:26 -0800
Message-Id: <20230216192426.1184606-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
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

From: Alison Schofield <alison.schofield@intel.com>

This makes the kernel-doc for cxl_dev_state complete.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
Needs to accompany 'for-6.3/cxl-events' into 6.3

 drivers/cxl/cxlmem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c6c560c67a8a..ccbafc05a636 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -250,6 +250,7 @@ struct cxl_event_state {
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @doe_mbs: PCI DOE mailbox array
+ * @event: event log driver state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for

base-commit: a5fcd228ca1db9810ba1ed461c90b6ee933b9daf
-- 
2.37.3

