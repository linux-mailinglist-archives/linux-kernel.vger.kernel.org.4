Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBB3715DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjE3LoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjE3Lnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:43:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A60418F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685447003; x=1716983003;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nk/Kz7oSHoHb7l9itbC3B12OJHLZle3JtSbm/pMCIe0=;
  b=iyKNe+cHozUifRAw5trQBLRuqS/XAPfZMlGWvlN/zdIG85Wxh+5z4SQC
   7Z5JAc5nMURbcZ3OHW3+GdBS/Pgnu6tNHqTAQ3H0y/hc1KZzhdYO0YdBp
   /TX9Yxg9ya/rCy/iurxW+IUjy8saFSGzm3QT//FFnRRP1BT+4q1u8FBzo
   mdqURI+5p/Al+1sdElX0+Gkyze3TEixYEN9G6a13B2x7nj6EqQc4SzIEo
   KcU4lChFfhwgsxLlgE3SgIQh3vDr+PioY/bR46x4FQKO+snDOoSHv9blm
   8r/iYCM7A7rfQS7LKYDm6/oQqOpQoT1thoPBZAgdZcoXRMUzzu02rJWfJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="383145363"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="383145363"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 04:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="700588713"
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="700588713"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2023 04:43:07 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Paul Lai <paul.c.lai@intel.com>
Subject: [PATCH v2 05/12] x86/cpu: Remove redundant comment during feature setup
Date:   Tue, 30 May 2023 14:42:40 +0300
Message-Id: <20230530114247.21821-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
References: <20230530114247.21821-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sohil Mehta <sohil.mehta@intel.com>

The code below the comment is self explanatory. Instead of updating the
comment with the newly added LASS feature, it is better to just remove
it.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/kernel/cpu/common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 315cc67ba93a..f26c56fe9963 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1861,7 +1861,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
 
-	/* Set up SMEP/SMAP/UMIP */
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
-- 
2.39.2

