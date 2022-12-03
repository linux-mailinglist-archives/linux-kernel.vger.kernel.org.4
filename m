Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAE1641435
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 06:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiLCFGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 00:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiLCFF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 00:05:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A13BBBF8;
        Fri,  2 Dec 2022 21:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670043956; x=1701579956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MUai+TNjC0Cx5KqQvcNQnHWoy9M6SukRcdTK0bFEnI0=;
  b=XFSkGINMSBldSTaD6zHQtF8DlMktC9Hu/6hI/Jl/z/wN9X97h3To+KY6
   bcyMiu034d2ZWOfR8jkxq6aq8rb1O/9gsj03xHj2GQl+eVwIHnrbb38sh
   Mg0q8z8k+7FabV1Vajv8eMaDxuGsDAvO4wXmejaGqYqSK3cCM0XWt2VAd
   RUb+PuDY5jAYV6euOsdH55kOi/7KfTAr5GvIh55AMP6pq6Kv2rhHHzQX7
   /NbxqZa60QkB/DNnFZaT5EAN7WzmhJF+EV4ekf9w6R6RRz301baAEq7Ic
   j25gXFHGKqTRBmHJM5+mf+xH8k5eYBeucS5r8FI0vbPyWT5M4MMb+RFmD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="295789950"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="295789950"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 21:05:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="751524149"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="751524149"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 21:05:55 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     bp@suse.de
Cc:     rdunlap@infradead.org, jithu.joseph@intel.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, ashok.raj@intel.com, tony.luck@intel.com
Subject: [PATCH] platform/x86/intel/ifs: Add missing documentation entry
Date:   Fri,  2 Dec 2022 21:04:28 -0800
Message-Id: <20221203050428.502264-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <774fd22a-aaee-758d-8195-77bac783ecbc@infradead.org>
References: <774fd22a-aaee-758d-8195-77bac783ecbc@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for test_num member of struct ifs_data is missing [1].

Link: https://lore.kernel.org/lkml/774fd22a-aaee-758d-8195-77bac783ecbc@infradead.org/ [1]

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index da1474e1d8eb..046e39304fd5 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -208,6 +208,7 @@ union ifs_status {
  * @status: it holds simple status pass/fail/untested
  * @scan_details: opaque scan status code from h/w
  * @cur_batch: number indicating the currently loaded test file
+ * @test_num: number indicating the test type
  */
 struct ifs_data {
 	int	integrity_cap_bit;

base-commit: 1a63b58082869273bfbab1b945007193f7bd3a78
-- 
2.25.1

