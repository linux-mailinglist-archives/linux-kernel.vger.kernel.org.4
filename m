Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83398728F24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjFIE4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjFIE4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:56:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6430E8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686286604; x=1717822604;
  h=from:to:cc:subject:date:message-id;
  bh=citkw1r4YtrCYDZ4MGd3TXYFScmecRMdIB/aj3T4GOE=;
  b=jfSDNsLwAwp+LKBxvTMuiWM67DVdAjEMckNpyNAyFlbAJvM2ikmUTE93
   eQPT2kxUuk6KKq9UzbfORTvxrdPwsMgI1Rdm8X0p27o2E4H9lKJ198Tmc
   o4jRDKOc9pagMVArJ1VHUDK3WNN30WGeP41RF9aTOlLHbgUEx2DYTkAwI
   kiTbyw7vYSPmzvlZoLkNtjR3qHtZA3pNcGOFHOPTateITF6NFULOdTRHu
   SvkDlt5+80d7r73nNy2jd11xVcqdawGsxJaS7zDXJLihUy1cNA2+LByge
   wVxfqU+TwGs68y3DGk8OXw/IZBB0SGwwJFA8E9cfl3sj4pnbBlVmybJ4Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347163948"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="347163948"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 21:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="710231864"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; 
   d="scan'208";a="710231864"
Received: from srpawnik.iind.intel.com ([10.99.123.68])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2023 21:56:36 -0700
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, sumeet.r.pawnikar@intel.com
Subject: [PATCH] Update comment to include stepping
Date:   Fri,  9 Jun 2023 10:12:22 +0530
Message-Id: <20230609044222.18928-1-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 2.17.1
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

Wildcard for stepping "X86_STEPPING_ANY" is also defined here.
So, update comment to include "stepping".

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 include/linux/mod_devicetable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index ccaaeda792c0..bb4d009ab2cf 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -680,7 +680,7 @@ struct x86_cpu_id {
 	kernel_ulong_t driver_data;
 };
 
-/* Wild cards for x86_cpu_id::vendor, family, model and feature */
+/* Wild cards for x86_cpu_id::vendor, family, model, stepping and feature */
 #define X86_VENDOR_ANY 0xffff
 #define X86_FAMILY_ANY 0
 #define X86_MODEL_ANY  0
-- 
2.17.1

