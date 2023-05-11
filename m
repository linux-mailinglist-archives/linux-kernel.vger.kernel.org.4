Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3E6FF7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjEKQpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbjEKQpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:45:07 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5362C769D
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683823503; x=1715359503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jCzIt+9YJxsUmYM/FF8Fbd046agBv6K6X56tZevzIpE=;
  b=FoEkii9z5DLT40Z1g/mU+GpfoEfVwYOD2jBWGqGbtX7JY+KmbgUOpZli
   0BaAz4ExsDcGT1t4zMeMw4tKTLjPo9D/6WH605jwLuwRHSVhRyxJkKAZQ
   bDFHOLj5dHlydcAwb1DLlEWtR10XmHjtpnoVOpwbkGZ5OMxYPMd5Vs3An
   VWeAdahVTUpFTRLao+VF1Rm5EfkgVVkCJb48IZ82vKzRKhJuMem7X92ix
   FnWed3wgPCTBuKI9pN8BK1Fuzy9TWKr0Gb65Ns5FTsaFLrjVH65zrs8sB
   mI7w6bFnkwgb8ciRxhHAMu6lm0QK6dPs1HYWAeU7jztal/rtfEoy6NEeF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335069011"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="335069011"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 09:45:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="769422718"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="769422718"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 09:45:02 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v1] MAINTAINERS: add entry for auxiliary bus
Date:   Thu, 11 May 2023 09:45:01 -0700
Message-Id: <20230511164501.3859674-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When auxiliary bus was added to the kernel the MAINTAINERS file wasn't
updated with a mention of the files, contributors and reviewers. Fix
that oversight by adding Dave and Ira, with GregKH as (same as current)
owner.

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Acked-by: Dave Ertman <david.m.ertman@intel.com>
Acked-by: Ira Weiny <ira.weiny@intel.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..cdc71e222e46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3387,6 +3387,16 @@ F:	include/uapi/linux/audit.h
 F:	kernel/audit*
 F:	lib/*audit.c
 
+AUXILIARY BUS DRIVER
+M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+R:	Dave Ertman <david.m.ertman@intel.com>
+R:	Ira Weiny <ira.weiny@intel.com>
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
+F:	Documentation/driver-api/auxiliary_bus.rst
+F:	drivers/base/auxiliary.c
+F:	include/linux/auxiliary_bus.h
+
 AUXILIARY DISPLAY DRIVERS
 M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
-- 
2.31.1

