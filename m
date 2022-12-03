Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0362A641443
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 06:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiLCF0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 00:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiLCF0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 00:26:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65EAE2ABB;
        Fri,  2 Dec 2022 21:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670045173; x=1701581173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WJ/EtdAAq3iZV8At5WAIDvB61b6DbKEUdBQU4p3hB0U=;
  b=J7XrBdG64lzSVzCbQ7wJs9+R4O237m0UO6nGJWwE3PRu7oxIo9wVrRot
   hfGEJtj1tQZgRwjyicOlmIOY+IZxbFpF1t0iy1NUZOf35/7a6zu7RoeqS
   NSgN8LWY78sp5eBWue97sYLCdlqHZOYpr7shjH8Nm8DcmyyB41KKOrg6f
   6fM2GlKzxalt+VfFDKZPAHu1I5GOisSUD7COLLbpfuMij+nQxhJREumqu
   wNxqD3OWsUkwm+3Ha7XOrMHn1vct6ufhmf1sxK1hz3eC4fl7XFSHBeLBX
   uthpyq8TdQzof10bMq2wIpbDU+KiPQbo+Yz3QVrLEG0zuUuFDgS+Za5bX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="296451987"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="296451987"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 21:26:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="708713321"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="708713321"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 21:26:13 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     bp@alien8.de
Cc:     rdunlap@infradead.org, jithu.joseph@intel.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, ashok.raj@intel.com, tony.luck@intel.com
Subject: [RESEND PATCH] platform/x86/intel/ifs: Add missing documentation entry
Date:   Fri,  2 Dec 2022 21:24:45 -0800
Message-Id: <20221203052445.502450-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <774fd22a-aaee-758d-8195-77bac783ecbc@infradead.org>
References: <774fd22a-aaee-758d-8195-77bac783ecbc@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 -Resending to "bp@alien8.de" as "bp@suse.de" reported undeliverable

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

