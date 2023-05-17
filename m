Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C33C707439
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjEQV2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjEQV23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:28:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3670A1732;
        Wed, 17 May 2023 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684358908; x=1715894908;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NxykSF0yuigVRyhmiAOlC2C/CUOtx/RaDUQ0PKhnCCg=;
  b=ZOtsZOG03wjI4oGQUHS8j2qOdKNGc1Sl9kzWvbrgjgzE6/zI6LTMn5M8
   wE4R05xPF2zl1W001Obi6f9SSU2PKXAOEhdlOlrPEf+ZHhQmlQUmepnem
   XBgb+up9Nkwn1DIK/q3Tct8pOrqffZhU/PBcmv17uW9E+D4o5WBHsCewc
   nK9lN28Y1PQsLpWUh/JA8vTdD0mEZZiSlDAk+cUOEp2H7JrNDu9sqWfYV
   5I3RZyd0OCyO4IYk/R09wOIlT6UZpCrye2pz3MUpRUpa3adEdwZt+kGyA
   GG+5ZIO5mUBIeDkq/PiLujDe+6uG30/GnL/20oNqHBbBpfsxf9id6PHjV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="341274725"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="341274725"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="826098073"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="826098073"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.143.168])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:28:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 17 May 2023 14:28:10 -0700
Subject: [PATCH 1/3] MAINTAINERS: Add additional reviewers for CXL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230426-cxl-fixes-v1-1-870c4c8b463a@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684358895; l=755;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=NxykSF0yuigVRyhmiAOlC2C/CUOtx/RaDUQ0PKhnCCg=;
 b=QAV7YBg+rjyFhoKdx2BYoFW+h9Y+R92ISgTQ+oAVUr1GJzyQCVNbkg3AXzuRztMBtZzHXCLhV
 Y/X8fc+3lCEDMNTqyDyAVqeqGz2QPr2KhO6ZMTgYQK3UkCdrYPmQ+EU
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

To get better coverage add Dave Jiang and Jonathan Cameron as reviewers.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..6f8568ec2731 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5169,6 +5169,8 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Ira Weiny <ira.weiny@intel.com>
 M:	Ben Widawsky <bwidawsk@kernel.org>
 M:	Dan Williams <dan.j.williams@intel.com>
+R:	Dave Jiang <dave.jiang@intel.com>
+R:	Jonathan Cameron <Jonathan.Cameron@Huawei.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	drivers/cxl/

-- 
2.40.0

