Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8291F70743A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjEQV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjEQV2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:28:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0711732;
        Wed, 17 May 2023 14:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684358914; x=1715894914;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Jnx73iYy2J9K7uSzhh1UHCYltU9kWEDXMbRP1gAejdg=;
  b=XDnyEdJa3peeNKyCDIjED8FcQ21otfRujo+2azAu5X69ox+yYKswaV7X
   8xstA+ZjtUCATAnR5B2EiAvg3TLY9B9GUBPkQpxXiJf/01Xcv8znYvj+R
   LU8eaCcGkZJXEJUVUgOmsbf1YheDoKo1OZTiZwBxHNGF9vmkmrTG5ECq6
   ZkwTqZwQ/qP5R/TcXtHGHljPseIAZv024P37sUub72k9MBVcI7TtHCT2C
   ZXvrDQaV3cJAzt2fU/YWqbZQiyCXefz2wdi8CO0lU/2VRfyj0CwoHvb8W
   Li3TkEG3y+QMzlz8k4P0tJW/nOA4ONJ7eoOxAgJr31VJhQcxqRk2xVRU1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="341274742"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="341274742"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826098101"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="826098101"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.143.168])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:28:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 17 May 2023 14:28:11 -0700
Subject: [PATCH 2/3] cxl/pci: Update comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-cxl-fixes-v1-2-870c4c8b463a@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358895; l=1155;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=Jnx73iYy2J9K7uSzhh1UHCYltU9kWEDXMbRP1gAejdg=;
 b=qkGtd7nkrQtcgTRmtBxYsjv0Oc1zXIwHHux3AtXqjz9qyaq+hw/zPWjcNATj6yt+ENdzDow8F
 iumufjrji0iCD4P2hn2zZEoUxOnR8qIWwP8IHMo4EKO75otY7vulaXo
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
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

The existence of struct cxl_dev_id containing a single member is odd.
The comment made sense when I wrote it but could be clarified.

Update the comment and place it next to the odd looking structure.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f7a5b8e9c102..ad7a1276fdc5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -469,6 +469,10 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
 	return 0;
 }
 
+/*
+ * Threaded irq dev_id's must be globally unique.  cxl_dev_id provides a unique
+ * wrapper object for each irq within the same cxlds.
+ */
 struct cxl_dev_id {
 	struct cxl_dev_state *cxlds;
 };
@@ -506,7 +510,6 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
 	if (FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting) != CXL_INT_MSI_MSIX)
 		return -ENXIO;
 
-	/* dev_id must be globally unique and must contain the cxlds */
 	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
 	if (!dev_id)
 		return -ENOMEM;

-- 
2.40.0

